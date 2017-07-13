//
//  ViewController.swift
//  Sketch Cache Cleaner
//
//  Created by Sasha Prokhorenko on 2/6/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  // MARK: - Properties
  @IBOutlet var backgroundView: NSView!
  @IBOutlet weak var button: NSButton!
  @IBOutlet weak var mainImage: NSImageView!
  @IBOutlet weak var backgroundImage: NSImageView!
  @IBOutlet weak var cacheCleared: NSImageView!
  @IBOutlet weak var notificationLabel: NSTextField!
  @IBOutlet weak var sketchLabel: NSTextField!
  @IBOutlet weak var progress: NSProgressIndicator!
  private var permissionGranted = false
  private var stringToTest = ""
  private let privilegedTask = STPrivilegedTask()
  private let bashPath = Environment.bashPath
  private let calculateCacheSizeTask = [Environment.calculateCacheScriptPath]
  private let clearCacheTask = [Environment.clearCacheScriptPath]
  
  // MARK: - ViewController lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundImage.isHidden = true
    cacheCleared.isHidden = true
    notificationLabel.isHidden = true
  }
  override func viewWillAppear() {
    super.viewWillAppear()
    view.window?.titlebarAppearsTransparent = true
    view.window?.backgroundColor = NSColor(red:0.07, green:0.04, blue:0.20, alpha:1.00)
    view.window?.contentView?.setFrameSize(CGSize(width: (view.window?.contentView?.frame.width)!,
                                                  height: (view.window?.contentView?.frame.height)! + 20))
    setButton(button, title: "Enable and Scan")
  }
  
  func appState() {
    switch (permissionGranted, button.title) {
    case (false, "Enable and Scan"):
      button.title = "Enable and Scan"
      askPermission()
    case (true, "Scanning..."):
      checkSizeOfCache()
    case (true, stringToTest):
      clearCache()
    default:
      print("Do nothing")
    }
  }
  
  func askPermission() {
      privilegedTask.launchPath = bashPath
      privilegedTask.arguments = calculateCacheSizeTask
      privilegedTask.currentDirectoryPath = Bundle.main.resourcePath
  
      let err = privilegedTask.launch()
      if err != errAuthorizationSuccess {
        if err == errAuthorizationCanceled {
          print("User cancelled", permissionGranted)
          permissionGranted = false
          return
        } else {
          print("Something went wrong:", err)
          // For error codes, see http://www.opensource.apple.com/source/libsecurity_authorization/libsecurity_authorization-36329/lib/Authorization.h
        }
      }
      
      privilegedTask.waitUntilExit()
      permissionGranted = true
      backgroundImage.isHidden = false
      progress.startAnimation(self)
      button.isEnabled = false
      setButton(button, title: "Scanning...")
      mainImage.cell?.image = #imageLiteral(resourceName: "closedBox")
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
        self.button.isEnabled = true
        self.checkSizeOfCache()
      }
  }
  
  func checkSizeOfCache() {
    progress.stopAnimation(self)
    let readHandle = privilegedTask.outputFileHandle
    let outputData = readHandle?.readDataToEndOfFile()
    let outputString = String(data: outputData!, encoding: .utf8)
    let stringArray = outputString?.components(separatedBy: "/")
    guard let stringToDispaly = stringArray?[0] else { return }
    
    if stringToDispaly.trim() == "0B" {
      finalUIState()
    } else {
      stringToTest = "Clear \(stringToDispaly.trim())B"
      setButton(button, title: "Clear \(stringToDispaly.trim())B")
      mainImage.cell?.image = #imageLiteral(resourceName: "boxWithSketch")
      notificationLabel.isHidden = false
    }
  }
  
  func clearCache() {
    privilegedTask.launchPath = bashPath
    privilegedTask.arguments = clearCacheTask
    privilegedTask.currentDirectoryPath = Bundle.main.resourcePath
    
    let err = privilegedTask.launch()
    if err != errAuthorizationSuccess {
      if err == errAuthorizationCanceled {
        print("User cancelled", permissionGranted)
        return
      } else {
        print("Something went wrong:", err)
      }
    }
    privilegedTask.waitUntilExit()
    finalUIState()
  }
  
  func finalUIState(){
    mainImage.cell?.image = #imageLiteral(resourceName: "openBox")
    button.isHidden = true
    cacheCleared.isHidden = false
    notificationLabel.isHidden = true
  }
  
  // MARK: - Actions
  @IBAction func buttonPressed(_ sender: NSButton) {
    appState()
  }
  
  // MARL: - Helpers
  func setButton(_ button: NSButton, title: String) {
    button.title = title
    button.cornerRadius = 3.0
    button.backgroundColor = NSColor(red:1.0, green:0.70, blue:0.0, alpha:1.00)
    let textColor =  NSColor(red:1.0, green:1.0, blue:1.0, alpha:1.00)
    
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    
    guard let font = NSFont(name: "San Francisco Display Semibold", size: 14) else {
      return
    }
    
    let attributes = [NSForegroundColorAttributeName: textColor,
                      NSFontAttributeName: font,
                      NSParagraphStyleAttributeName: style] as [String : Any]
    
    button.attributedTitle = NSAttributedString(string: title, attributes: attributes)
  }
}

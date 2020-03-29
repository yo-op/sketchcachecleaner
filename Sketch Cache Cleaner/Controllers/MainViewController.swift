//
//  ViewController.swift
//  Sketch Cache Cleaner
//
//  Created by Sasha Prokhorenko on 2/6/17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

import Cocoa

final class MainViewController: NSViewController {
    // MARK: - IBOutlets

    @IBOutlet private var backgroundView: NSView!
    @IBOutlet private var button: NSButton!
    @IBOutlet private var shareToTweeterButton: NSButton!
    @IBOutlet private var shareToFaceBookButton: NSButton!
    @IBOutlet private var mainImage: NSImageView!
    @IBOutlet private var backgroundImage: NSImageView!
    @IBOutlet private var cacheCleared: NSImageView!
    @IBOutlet private var notificationLabel: NSTextField!
    @IBOutlet private var sketchLabel: NSTextField!
    @IBOutlet private var progress: NSProgressIndicator!

    // MARK: - Instance Properties

    private var permissionGranted = false
    private var stringToTest = ""
    private let privilegedTask = STPrivilegedTask()
    private let bashPath = Environment.bashPath
    private let calculateCacheSizeTask = [Environment.calculateCacheScriptPath]
    private let clearCacheTask = [Environment.clearCacheScriptPath]

    // MARK: - ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialVCState()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        additionalVCConfigure()
    }

    // MARK: - Initial state

    private func configureInitialVCState() {
        backgroundImage.isHidden = true
        cacheCleared.isHidden = true
        notificationLabel.isHidden = true
        shareToTweeterButton.isHidden = true
        shareToFaceBookButton.isHidden = true
    }

    private func additionalVCConfigure() {
        view.window?.titlebarAppearsTransparent = true
        view.window?.backgroundColor = Colors.background
        view.window?.contentView?.setFrameSize(CGSize(width: (view.window?.contentView?.frame.width)!,
                                                      height: (view.window?.contentView?.frame.height)! + 20))
        NSButton.setButton(button, title: ButtonText.enableAndScan)
    }

    private func appState() {
        switch (permissionGranted, button.title) {
        case (false, ButtonText.enableAndScan):
            button.title = ButtonText.enableAndScan
            askPermission()
        case (true, ButtonText.scanning):
            checkSizeOfCache()
        case (true, stringToTest):
            clearCache()
        default:
            break
        }
    }

    // MARK: - Helpers

    private func askPermission() {
        privilegedTask.launchPath = bashPath
        privilegedTask.arguments = calculateCacheSizeTask
        privilegedTask.currentDirectoryPath = Bundle.main.resourcePath
        let err = privilegedTask.launch()
        if err != errAuthorizationSuccess {
            if err == errAuthorizationCanceled {
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
        NSButton.setButton(button, title: ButtonText.scanning)
        mainImage.cell?.image = #imageLiteral(resourceName: "closedBox")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.button.isEnabled = true
            self.checkSizeOfCache()
        }
    }

    private func checkSizeOfCache() {
        progress.stopAnimation(self)
        let readHandle = privilegedTask.outputFileHandle
        let outputData = readHandle?.readDataToEndOfFile()
        let outputString = String(data: outputData!, encoding: .utf8)
        let stringArray = outputString?.components(separatedBy: "/")
        guard let stringToDispaly = stringArray?[0] else { return }
        if stringToDispaly.trim() == "0B" || stringToDispaly == "" {
            finalUIState()
        } else {
            stringToTest = "Clear \(stringToDispaly.trim())B"
            NSButton.setButton(button, title: "Clear \(stringToDispaly.trim())B")
            mainImage.cell?.image = #imageLiteral(resourceName: "boxWithSketch")
            notificationLabel.isHidden = false
        }
    }

    private func clearCache() {
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

    private func finalUIState() {
        mainImage.cell?.image = #imageLiteral(resourceName: "openBox")
        button.isHidden = true
        cacheCleared.isHidden = false
        notificationLabel.isHidden = true
        shareToTweeterButton.isHidden = false
        shareToFaceBookButton.isHidden = false
    }

    // MARK: - Actions

    @IBAction private func buttonPressed(_: NSButton) {
        appState()
    }

    @IBAction private func shareToTweeterDidPress(_: NSButton) {
        NSWorkspace.shared.open(Share.twitterMessage(stringToTest))
    }

    @IBAction private func shareToFacebookrDidPress(_: NSButton) {
        NSWorkspace.shared.open(Share.facebookMessage(stringToTest))
    }
}

# Sketch Cache Cleaner

[![Build Status](https://travis-ci.org/yo-op/sketchcachecleaner.svg?branch=master)](https://travis-ci.org/yo-op/sketchcachecleaner)
[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](https://github.com/yo-op/sketchcachecleaner)

![Sketch Cache Cleaner](https://image.ibb.co/mHOoea/cleaner.png)

Sketch Cache Cleaner is an app that deletes hidden Sketch history files that can take a lot of space on your hard drive and that you would probably never use.

## Requirements

- macOS 10.10+
- Xcode 9.0+
- Swift 4.0+

## References

The app idea inspired by :
1. [How Sketch took over 200GB of our MacBooks](https://medium.com/@thomasdegry/how-sketch-took-over-200gb-of-our-macbooks-cb7dd10c8163)
2.  [How to recover 50 GB or even more by deleting Sketch caches files](https://medium.com/sketch-app-sources/how-to-recover-50-go-or-even-more-by-deleting-sketch-caches-files-e5829dba20e1)

Please, read them in case you want to know how it works.

## Warning!

### If your workflow relies on automatic versioning by macOS (Time Machine etc.) - DO NOT USE THIS APP!
### The app will remove all files in folder: ` /.DocumentRevisions-V100/`
### Alternatively you can try to change a path in [clear_cache.sh](https://github.com/yo-op/sketchcachecleaner/blob/master/Sketch%20Cache%20Cleaner/Scripts/clear_cache.sh) to `/.DocumentRevisions-V100/.cs/{*,.*}`

## Tips

1. Use this app wisely.
2. Reboot your Mac after app use.

## License

Sketch Cache Cleaner is released under the MIT license. [See LICENSE](https://github.com/yo-op/sketchcachecleaner/blob/master/LICENSE.md) for details.

--------
Idea & design:  [Yuriy Oparenko](http://oparenko.com)

Development: [Sasha Prokhorenko](https://twitter.com/minikin)

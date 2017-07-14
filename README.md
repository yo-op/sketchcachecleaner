# Sketch Cache Cleaner

![Sketch Cache Cleaner](https://image.ibb.co/mHOoea/cleaner.png)

Sketch Cache Cleaner is an app that deletes hidden Sketch history files that can take a lot of space on your hard drive and that you would probably never use.

## Warning!
The app idea inspired by [this](https://medium.com/@thomasdegry/how-sketch-took-over-200gb-of-our-macbooks-cb7dd10c8163) and [this](https://medium.com/sketch-app-sources/how-to-recover-50-go-or-even-more-by-deleting-sketch-caches-files-e5829dba20e1) blog posts.
Please, read them in case you want to know how it works.

### If your workflow relies on automatic versioning by macOS (Time Machine etc.) - DO NOT USE THIS APP!

### The app will remove all files in folder: ` /.DocumentRevisions-V100/`

### Alternatively you can try to change a path in [clear_cache.sh](https://github.com/yo-op/sketchcachecleaner/blob/master/Sketch%20Cache%20Cleaner/Scripts/clear_cache.sh) to `/.DocumentRevisions-V100/.cs/{*,.*}`

--------
Idea & design:  [Yuriy Oparenko](http://oparenko.com)

Development: [Sasha Prokhorenko](https://twitter.com/minikin)

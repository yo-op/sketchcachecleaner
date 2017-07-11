#!/bin/sh

#  clear_cache.sh
#  Sketch Cache Cleaner
#
#  Created by Sasha Prokhorenko on 2/6/17.
#  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
#  defaults write -app ‘sketch’ ApplePersistence -bool no

rm -rf /.DocumentRevisions-V100

exit 5

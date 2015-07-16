#!/usr/bin/env python
import ambari_helpers as helpers
from resource_management import Script


# server configurations
config = Script.get_config()

package_dir = helpers.package_dir()
files_dir = package_dir + 'files/'
scripts_dir = package_dir + 'scripts/'

commands = ['cd /tmp; sh ' + scripts_dir + 'shell/python_setup.sh ' + files_dir]

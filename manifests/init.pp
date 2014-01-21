# Class: monit
# 
# This installs a "base" monit system that is accessible by a web browser.
#
# Parameters:
#   None
#
# Actions:
#   Duh
#
# Requires:
#   - none
#
# Sample Usage:
#

class monit {
    include monit::install, monit::config, monit::service
}

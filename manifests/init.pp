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

class monit ($alert_address,
             $smtp_host,
             $smtp_port,
             $smtp_user_name,
             $smtp_password,
             $email_hostname,
             $web_username = "admin",
             $web_password = "monit") {
    include monit::install, monit::config, monit::service
}

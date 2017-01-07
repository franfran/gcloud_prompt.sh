#!/bin/bash

## Script name:    gcloud_prompt.sh
## Author:         Francis Mak (franfran)
## Last Modified:  Jan. 08, 2017
## Description:    Customize bash prompt to show the current user and project in gcloud.

#getting values from current config
#stackoverflow.com/questions/35599414/gcloud-command-line-get-default-project-id#35602041
get_project_id()
{
    gcloud info |tr -d '[]' | awk '/project:/ {print $2}'
}

#get name from email address
#http://stackoverflow.com/questions/39270018/extract-email-string-from-string-in-bash#39270102
get_user()
{
    gcloud info |tr -d '[]' | awk '/Account:/ {print $2}' | sed -e 's/\(.*\)@.*/\1/'
}

#note the double quote below instead of single quote
#http://stackoverflow.com/questions/37378803/update-variable-in-bash-function-and-use-it-in-prompt-ps1#37380085
prompt_string="[gcloud]$(get_user)@$(get_project_id)"

#customize both terminal window title and the prompt
#https://wiki.archlinux.org/index.php/Bash/Prompt_customization
export PS1="\[\e]2;$prompt_string\a\]$prompt_string:\W\$ "

#put the user in this new shell enviornment, and they can exit and back to default enviornment when done
#http://serverfault.com/questions/530833/bash-setting-environment-variables-from-a-script-and-leave-a-shell-prompt
/bin/bash -i

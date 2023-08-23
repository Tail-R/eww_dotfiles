#!/bin/bash

######################################################################
# You need to install wmctrl and nerd-font
######################################################################

# Return "occupied" only if currently workspaces was occupied
check_occupied() {
    wmctrl -l | awk '{print $2}' | while read -r occupied; do
        if [ "$occupied" == "$1" ]; then
            echo "occupied"
            return
        fi
    done
}

# Create yuck code of the currently workspaces status
get_workspaces_yuck() {
    buffered=""
    status_class=""

    # Before read this section you better execute 'wmctrl -d / -l'
    wmctrl -d | awk '{print $1 " " $2 " " $9}' | while read -r number status name; do

        occupied=$(check_occupied $number)

        if [ "$status" == "-" ]; then   # "-" mean inactive
            status_class="inactive"
            icon="󰧞"
        fi

        if [ "$occupied" == "occupied" ]; then
            status_class="occupied"
            icon="󰊠"
        fi

         
        if [ "$status" == "*" ]; then   # "*" mean active
            status_class="active"
            icon="󰮯"
        fi

        buffered+=$'\n'
        # buffered+="(button :class '$status_class'
        #                    :onclick 'wmctrl -s $number'
        #                    '$icon')"

        buffered+="(label :class '$status_class'
                          :text '$icon')"
        
        if [ "$number" == "$1" ]; then
            echo "$buffered"
        fi
   done
}

# Main
ewwStructure="box :class 'workspaces-button' 
                  :orientation 'h' 
                  :spacing 20"

workspacesNumber=$(wmctrl -d | awk '{print $1}' | tail -c 2)
workspacesStatus=$(get_workspaces_yuck $workspacesNumber)

echo "($ewwStructure $workspacesStatus)"





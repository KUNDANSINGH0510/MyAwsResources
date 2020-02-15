#!/bin/bash

# Example run for this file:
# executejob.sh

sed -i 's/\r$//' *

bash ./analyze_application.sh
if [ ! $? ]; then
	exit 1;
fi

#!/bin/bash
file /sbin/init | awk '{print substr($0,17,17)}'
exit 0


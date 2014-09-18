#!/bin/bash
# Quick bash script to run puppet on all agents in noop

for i in rsyslog master client elk; do echo -e "---Running puppet on $i---"; vagrant ssh $i -c 'sudo puppet agent -t --noop'; done

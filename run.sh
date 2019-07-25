#!/usr/bin/env bash

# temp hack wait for git-syncs
echo 'Sleeping'
sleep 10

# mv the spec files into the correct structure for dapperdox, git-sync is not not flexible!!
# this is a bit of a hack, ideally we'd change dapperdox to have directory structure more sympathetic to multi-project

for d in `ls /specs`
do
  echo ${d}
  mkdir specs/${d}
  cp /specs/${d}/content/swagger.json specs/${d}
done

./dapperdox
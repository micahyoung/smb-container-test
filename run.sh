#!/bin/bash
set -o errexit -o pipefail -o nounset

app=${1:?"usage $0 app-1|app-2|app-3"}

source secrets/env.sh

trap "cf delete -f test-${app} || true" EXIT

cf push test-${app} -p ${app}/ -u none -b binary_buildpack -s windows -c 'powershell.exe Start-Sleep 99999' --no-route --no-start

cf set-env test-${app} SMB_SHARE $SMB_SHARE
cf set-env test-${app} SMB_USERNAME $SMB_USERNAME
cf set-env test-${app} SMB_PASSWORD $SMB_PASSWORD

cf start test-${app}
sleep 10
LOGS=$(cf logs test-${app} --recent)
if ! grep -q "OUT hello" <(echo $LOGS); then
  echo $LOGS
  echo =============================
  echo FAIL: no success message found in logs
  echo =============================
  exit 1
else
  echo =============================
  echo PASS: success message found in logs
  echo =============================
fi

# Uncomment for Docker
#test_image_tags=(
#  cloudfoundry/windows2016fs:2019.0.48
#  cloudfoundry/windows2016fs:2019.0.33
#  cloudfoundry/windows2016fs:2019
#  mcr.microsoft.com/dotnet/framework/runtime:4.7.2-windowsservercore-ltsc2019
#  mcr.microsoft.com/windows/servercore:1809
#  mcr.microsoft.com/windows/servercore:1903
#  mcr.microsoft.com/windows/servercore:1909
#)
#
#for image_tag in ${test_image_tags[@]}; do
#  docker build ${app}/ -f Dockerfile --build-arg image_tag=$image_tag --build-arg SMB_SHARE --build-arg SMB_USERNAME --build-arg SMB_PASSWORD --no-cache --isolation=hyperv
#done

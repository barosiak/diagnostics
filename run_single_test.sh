#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Missing test filter argument. Usage: ./run_singlefile.sh <TestFilter> <Rebuild?>"
    exit 1
fi

if [ $# -eq 2 ]
  then
    echo "Rebuilding diagnostics repo."
    cd /home/brosiak/repos-ubuntu/diagnostics
    ./build.sh && ./eng/privatebuild.sh
fi

echo "Copying runtime."
./copy_runtime.sh 1

echo "Running test: $1"
cd /home/brosiak/repos-ubuntu/diagnostics/src/tests/SOS.UnitTests
export LLDB_PATH=/usr/bin/lldb   
../../../.dotnet/dotnet test SOS.UnitTests.csproj --filter $1
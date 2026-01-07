#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Missing path argument. Usage: ./copy_runtime.sh <target_path>"
    exit 1
fi

source=/home/brosiak/repos-ubuntu/runtime/artifacts/bin/coreclr/linux.x64.Release

if [ $1 -eq 1 ]
  then
    target=/home/brosiak/repos-ubuntu/diagnostics/artifacts/dotnet-test/shared/Microsoft.NETCore.App/10.0.2
elif [ $1 -eq 2 ]
  then
    target=/home/brosiak/repos-ubuntu/diagnostics/artifacts/Debuggees/SingleFile/DumpLongNameTruncation/bin/Debug/net10.0/linux-x64
fi

echo SRC:$source
echo TGT:$target

cp -v $source/sharedFramework/* $target
cp -v $source/System.Private.CoreLib.dll $target
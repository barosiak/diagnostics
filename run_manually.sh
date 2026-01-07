#!/bin/bash

DUMPS_DIR=/home/brosiak/repos-ubuntu/diagnostics/artifacts/tmp/Debug/dumps/ProjectK/10.0.2/net10.0/

export DOTNET_MULTILEVEL_LOOKUP=0
export DOTNET_ROOT=/home/brosiak/repos-ubuntu/tom-diagnostics/artifacts/dotnet-test
export DOTNET_DbgEnableElfDumpOnMacOS=1
export COMPlus_DbgEnableElfDumpOnMacOS=1
export DOTNET_DbgEnableMiniDump=1
export COMPlus_DbgEnableMiniDump=1
export DOTNET_DbgMiniDumpName=$DUMPS_DIR/%e%d.dmp
export COMPlus_DbgMiniDumpName=$DUMPS_DIR/%e%d.dmp
export DOTNET_CreateDumpDiagnostics=0
export COMPlus_CreateDumpDiagnostics=0
export DOTNET_DbgMiniDumpType=4
export COMPlus_DbgMiniDumpType=4

if [ $# -eq 0 ]
  then
    echo "Missing path argument. Usage: ./run_manually.sh <target_path>"
    exit 1
fi

if [ $1 -eq 1 ]
  then
    ./copy_runtime.sh 2
    /home/brosiak/repos-ubuntu/tom-diagnostics/artifacts/Debuggees/SingleFile/DumpLongNameTruncation/bin/Debug/net10.0/linux-x64/DumpLongNameTruncation
elif [ $1 -eq 2 ]
  then
    ./copy_runtime.sh 3
    /home/brosiak/repos-ubuntu/tom-diagnostics/artifacts/bin/DumpLongNameTruncation/Debug/net10.0/linux-x64/DumpLongNameTruncation
fi

echo "Checking for dump files..."
DUMP_FILES=$(ls -t "$DUMPS_DIR"/*.dmp 2>/dev/null)
    
if [ -n "$DUMP_FILES" ]; then
    echo "Found dump file(s) in $DUMPS_DIR:"
    for file in $DUMP_FILES; do
        SIZE=$(du -h "$file" | cut -f1)
        TIMESTAMP=$(date -r "$file" "+%Y-%m-%d %H:%M:%S")
        echo "  - $(basename "$file") ($SIZE) - $TIMESTAMP"
    done
else
    echo "No dump files found in $DUMPS_DIR. The crash may not have triggered dump collection."
    echo "This can happen with certain exception types that are handled by the runtime."
fi
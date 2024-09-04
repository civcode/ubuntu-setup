#!/bin/bash

# Read extensions from a file and install each
while IFS= read -r extension || [ -n "$extension" ]; do
    code --install-extension "$extension"
done < misc/config/vs-code-extensions-list.txt

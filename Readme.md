# ps_Util_CopyRootFolderPermissions.ps1

## What it does:

Creates subfolders and sets identical permissions on a destination folder from subfolders of a source folder

Process is:
- Get list of subfolders in the source folder
- Capture the ACL permissions on the source folder
- Create a folder with the same name in the destination folder
- Set the permissions on the destination folder from the source folder

## How to run

- Run the script in Powershell with the following command:

.\ps_Util_CopyRootFolderPermissions.ps1 -sSource "Path to source folder" -sDest "Path to destination folder"


## Requirements to run

Must have admin rights on both the source and destination folders and permission to run scripts on the system


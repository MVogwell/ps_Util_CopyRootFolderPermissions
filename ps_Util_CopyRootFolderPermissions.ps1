#####################################
#
# ps_App_CopyRootFolderPermissions.ps1
#
# Creates folders and sets identical permissions from subfolders of a destination
#
# Process is:
#	- Get list of subfolders in the source folder
# - Capture the ACL permissions on the source folder
# - Create a folder with the same name in the destination folder
# - Set the permissions on the destination folder from the source folder

[CmdletBinding()]
param (
	[Parameter(Mandatory=$true)][string]$sSource = "",
	[Parameter(Mandatory=$true)][string]$sDest = ""
)

$ErrorActionPrefernce = "Stop"

If((test-path ($sSource)) -and (test-path ($sDest))) {
	$bSourceDataCheck = $True
	Try {
		$objSourceFolders = gci $sSource -Directory
	}
	Catch {ps_Util_CopyRootFolderPermissions.ps1
		$bSourceDataCheck = $False

	}

	If($bSourceDataCheck) {
		Foreach($objSourceFolder in $objSourceFolders) {
			write-host "$($objSourceFolder.FullName)" -fore yellow

			$bGetSourceACL = $True

			Try {
				$aclSource = Get-ACL $objSourceFolder.FullName
			}
			Catch {
				$bGetSourceACL = $False
				write-host "... Failed to get ACL for the source folder" -fore red
			}

			if($bGetSourceACL) {
				$bFolderCreated = $True
				$sDestSubFolder = $sDest + $objSourceFolder.Name

				If(!(Test-Path($sDestSubFolder))) {
					try {
						mkdir $sDestSubFolder	| out-null
					}
					Catch {
						$bFolderCreated = $False
						write-host "... Failed to create new folder" -fore red
					}

					If($bFolderCreated) {
						Try {
								Set-ACL $sDestSubFolder -aclObject $aclSource
								write-host "... Successfully created and set permissions" -fore green
						}
						Catch {
							write-host "... Created folder but unable to set permissions!" -fore red

						}
					}
				}
				Else {
					write-host "... Destination folder already exists. Not created new folder" -fore red
				}
			}
		}
	}

	write-host "`nFinished!`n`n"
}
Else {
	write-host "Either the source or destination folder does not exlst. Please check and try again `n`n" -fore red
}

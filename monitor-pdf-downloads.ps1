#
# - wait for the PS> prompt to appear
# - cd C:\Users\Ger\Downloads
# -     PS> .\run_script.ps1 
#   powershell -noexit "& "".\run_script.ps1"""
#

$workdir = (Get-Location).Path

# Create a new instance of the SHA256CryptoServiceProvider
$sha256 = [System.Security.Cryptography.SHA256CryptoServiceProvider]::Create()

# Define a function to add a number to a variable
function Add-Number {
    param (
        [int]$variable,
        [int]$valueToAdd
    )
    return $variable + $valueToAdd
}

# Initialize the variable
$number = -1


for (;;) {
	$number = Add-Number -variable $number -valueToAdd 1
	if (($number % 60) -eq 0) {
		Write-Output "Scanning $workdir ..."
	}

	# Define the directory to scan and the wildcard pattern
	$directory = $workdir
	$wildcardPattern = "*.pdf"  

	# Get all files matching the wildcard pattern in the specified directory
	$matchingFiles = Get-ChildItem -Path $directory -Filter $wildcardPattern

	# List the matching files
	foreach ($file in $matchingFiles) {
		#Write-Output $file.FullName
		#Write-Output $file
		
		$string = $file.FullName
		$substring = "-HH00"

		if ($string.Contains($substring)) {
			#Write-Output "SKIPPING: $string"
			continue
		} 
		Write-Output "PROCESSING: $file"
		
		
		$filePath = $file.FullName

		# Open the file and compute the hash
		$fileStream = [System.IO.File]::OpenRead($filePath)
		$hashBytes = $sha256.ComputeHash($fileStream)
		$fileStream.Close()

		# Convert the hash bytes to a hexadecimal string
		$hashString = [BitConverter]::ToString($hashBytes) -replace '-', ''

		# Output the hash
		Write-Output "SHA256 Hash: $hashString"

		$hashId = "HH00{0}" -f $hashString.Substring(0, 16)




		# Define the path to the file you want to rename
		# $filePath = ..............

		# Get the current date and time
		$dateTime = Get-Date -Format "yyyyMMddHHmmss"

		# Extract the directory, filename, and extension
		$directory = Split-Path $filePath -Parent
		$fileName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
		$extension = [System.IO.Path]::GetExtension($filePath)

		# Create the new filename with the date-time + hash
		$newFileName = "$fileName-$hashId-T$dateTime$extension"

		# Combine the directory and new filename to get the full path
		$newFilePath = Join-Path $directory $newFileName

		# Rename the file
		Rename-Item -Path $filePath -NewName $newFileName

		Write-Output "File renamed to: $newFileName"
	}


	Start-Sleep -Seconds 1
}


<#
.Synopsis
	Build script with Invoke-Build bootstrapping.

.Example
	PS> ./MyProject.build.ps1 Build -Configuration Release
#>

param(
	[Parameter(Position=0)]
	[string[]]$Tasks,
	[string]$Configuration = 'Release'
)

# pinned version
$IBVersion = '5.6.2'

# call Invoke-Build, install missing
if ([System.IO.Path]::GetFileName($MyInvocation.ScriptName) -ne 'Invoke-Build.ps1') {
	$ErrorActionPreference = 'Stop'
	try {
		Import-Module InvokeBuild -RequiredVersion $IBVersion
	}
	catch {
		Install-Module InvokeBuild -RequiredVersion $IBVersion -Scope CurrentUser -Force
		Import-Module InvokeBuild -RequiredVersion $IBVersion
	}
	Invoke-Build -Task $Tasks -File $MyInvocation.MyCommand.Path @PSBoundParameters
	return
}

# Synopsis: Build MyProject.
task build {
	"Building $Configuration"
}

# Synopsis: Remove files.
task clean {
	remove bin, obj
}

# Synopsis: Default task.
task . build

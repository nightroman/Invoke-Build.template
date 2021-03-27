<#
.Synopsis
	Build script, https://github.com/nightroman/Invoke-Build

.Example
	PS> ./Script3.build.ps1 build -Configuration Release
#>

param(
	[Parameter(Position=0)]
	[string[]]$Tasks
	,
	[ValidateSet('Debug', 'Release')]
	[string]$Configuration = 'Release'
)

# Ensure and call the module.
if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
	$ErrorActionPreference = 'Stop'
	try {
		Import-Module InvokeBuild
	}
	catch {
		Install-Module InvokeBuild -Scope CurrentUser -Force
		Import-Module InvokeBuild
	}
	Invoke-Build -Task $Tasks -File $MyInvocation.MyCommand.Path @PSBoundParameters
	return
}

# Synopsis: Build project.
task build {
	exec { dotnet build -c $Configuration }
}

# Synopsis: Remove files.
task clean {
	remove bin, obj
}

# Synopsis: Default task.
task . build

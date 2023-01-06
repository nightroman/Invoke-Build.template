<#
.Synopsis
	Build script, https://github.com/nightroman/Invoke-Build
#>

param(
	[Parameter(Position=0)]
	[string[]]$Tasks
	,
	[ValidateSet('Debug', 'Release')]
	[string]$Configuration = 'Release'
)

# Bootstrap.
if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
	$ErrorActionPreference = 1
	if (!(Get-Command Invoke-Build -ErrorAction 0)) {
		Install-Module InvokeBuild -Scope CurrentUser -Force
		Import-Module InvokeBuild
	}
	return Invoke-Build $Tasks $MyInvocation.MyCommand.Path @PSBoundParameters
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

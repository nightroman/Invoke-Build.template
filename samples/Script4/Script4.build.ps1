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
	$InvokeBuildVersion = '5.7.3'
	try {
		Import-Module InvokeBuild -RequiredVersion $InvokeBuildVersion
	}
	catch {
		Install-Module InvokeBuild -RequiredVersion $InvokeBuildVersion -Scope AllUsers -Force
		Import-Module InvokeBuild -RequiredVersion $InvokeBuildVersion
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

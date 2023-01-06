<#
.Synopsis
	Build script, https://github.com/nightroman/Invoke-Build
#>

param(
//#if (bootstrap != "")
	[Parameter(Position=0)]
	[string[]]$Tasks
	,
//#endif
	[ValidateSet('Debug', 'Release')]
	[string]$Configuration = 'Release'
)
//#if (bootstrap == "*")

# Bootstrap.
if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
	$ErrorActionPreference = 1
	if (!(Get-Command Invoke-Build -ErrorAction 0)) {
		Install-Module InvokeBuild -Scope MyScope -Force
		Import-Module InvokeBuild
	}
	return Invoke-Build $Tasks $MyInvocation.MyCommand.Path @PSBoundParameters
}
//#endif
//#if (bootstrap != "" && bootstrap != "*")

# Bootstrap.
if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
	$ErrorActionPreference = 1
	$InvokeBuildVersion = 'MyVersion'
	try {
		Import-Module InvokeBuild -RequiredVersion $InvokeBuildVersion
	}
	catch {
		Install-Module InvokeBuild -RequiredVersion $InvokeBuildVersion -Scope MyScope -Force
		Import-Module InvokeBuild -RequiredVersion $InvokeBuildVersion
	}
	return Invoke-Build $Tasks $MyInvocation.MyCommand.Path @PSBoundParameters
}
//#endif

//#if (restore)
# Synopsis: Restore packages.
task restore {
	exec { dotnet restore }
}

# Synopsis: Build project.
task build {
	exec { dotnet build -c $Configuration --no-restore }
}
//#else
# Synopsis: Build project.
task build {
	exec { dotnet build -c $Configuration }
}
//#endif

# Synopsis: Remove files.
task clean {
	remove bin, obj
}

# Synopsis: Default task.
task . build

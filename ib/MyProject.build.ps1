<#
.Synopsis
	Build script, https://github.com/nightroman/Invoke-Build
//#if (bootstrap != "")

.Example
	PS> ./MyProject.build.ps1 build -Configuration Release
//#endif
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

# Ensure and call the module.
if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
	$ErrorActionPreference = 'Stop'
	try {
		Import-Module InvokeBuild
	}
	catch {
		Install-Module InvokeBuild -Scope MyScope -Force
		Import-Module InvokeBuild
	}
	Invoke-Build -Task $Tasks -File $MyInvocation.MyCommand.Path @PSBoundParameters
	return
}
//#endif
//#if (bootstrap != "" && bootstrap != "*")

# Ensure and call the module.
if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
	$InvokeBuildVersion = 'MyVersion'
	$ErrorActionPreference = 'Stop'
	try {
		Import-Module InvokeBuild -RequiredVersion $InvokeBuildVersion
	}
	catch {
		Install-Module InvokeBuild -RequiredVersion $InvokeBuildVersion -Scope MyScope -Force
		Import-Module InvokeBuild -RequiredVersion $InvokeBuildVersion
	}
	Invoke-Build -Task $Tasks -File $MyInvocation.MyCommand.Path @PSBoundParameters
	return
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

<#
.Synopsis
	Build script, https://github.com/nightroman/Invoke-Build
#>

param(
	[ValidateSet('Debug', 'Release')]
	[string]$Configuration = 'Release'
)

# Synopsis: Restore packages.
task restore {
	exec { dotnet restore }
}

# Synopsis: Build project.
task build {
	exec { dotnet build -c $Configuration --no-restore }
}

# Synopsis: Remove files.
task clean {
	remove bin, obj
}

# Synopsis: Default task.
task . build

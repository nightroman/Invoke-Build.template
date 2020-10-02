<#
.Synopsis
	Build script <https://github.com/nightroman/Invoke-Build>
#>

param(
	[string]$Configuration = (property Configuration Release)
)

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

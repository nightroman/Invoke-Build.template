<#
.Synopsis
	Build script (https://github.com/nightroman/Invoke-Build)
#>

# Synopsis: Remove temp files.
task clean {
	remove z, *.nupkg
}

# Synopsis: Collect package files in "z".
task publish {
	remove z
	exec {robocopy ib-basic z\content\ib-basic /s} (0..2)
	Copy-Item -Destination z @(
		'ib.png'
		'Package.nuspec'
	)
}

# Synopsis: Make the package.
task nuget publish, {
	exec {NuGet.exe pack z\Package.nuspec -NoPackageAnalysis}
}

# Synopsis: Install the template package.
task install nuget, {
	assert ($name = (Get-Item Invoke-Build.template.*.nupkg).Name)
	exec {dotnet new -i $name}
}

# Synopsis: Uninstall the template.
task uninstall {
	exec {dotnet new -u Invoke-Build.template}
}

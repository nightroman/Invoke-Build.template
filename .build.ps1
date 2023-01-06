<#
.Synopsis
	Build script, https://github.com/nightroman/Invoke-Build
#>

# Synopsis: Remove temp files.
task clean {
	remove z, *.nupkg
}

# Synopsis: Collect package files in "z".
task publish {
	remove z
	exec { robocopy ib z\content\ib /s } 1
	Copy-Item -Destination z @(
		'ib.png'
		'README.md'
		'Package.nuspec'
	)
}

# Synopsis: Make the package.
task nuget publish, {
	exec { NuGet.exe pack z\Package.nuspec -NoPackageAnalysis }
}

# Synopsis: Install the template package.
task install nuget, {
	assert ($name = (Get-Item Invoke-Build.template.*.nupkg).Name)
	exec { dotnet new install $name }
}

# Synopsis: Uninstall the template.
task uninstall {
	dotnet new uninstall Invoke-Build.template
}

# Synopsis: Test the template.
task test {
	exec { dotnet new ib --force -o samples/Script1 }
	exec { dotnet new ib --force -o samples/Script2 --restore }
	exec { dotnet new ib --force -o samples/Script3 --bootstrap * }
	exec { dotnet new ib --force -o samples/Script4 --bootstrap 5.7.3 --scope AllUsers }
}

# Synopsis: Default task.
task . uninstall, install, clean

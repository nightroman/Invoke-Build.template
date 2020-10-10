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
	exec {robocopy ib z\content\ib /s} (0..2)
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

# Synopsis: Test the template.
task test {
	exec { dotnet new ib --force -o samples/Script1 }
	exec { dotnet new ib --force -o samples/Script2 --restore }
	exec { dotnet new ib --force -o samples/Script3 --bootstrap * }
	exec { dotnet new ib --force -o samples/Script4 --bootstrap 5.6.2 --scope AllUsers }
}

# Synopsis: Default task.
task . install, clean

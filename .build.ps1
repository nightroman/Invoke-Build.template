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
	remove z
	Set-Location (mkdir z)
	exec { dotnet new ib -n Test1 }
	exec { dotnet new ib -n Test2Any -b *}
	exec { dotnet new ib -n Test2Sco -b * -s AllUsers}
	exec { dotnet new ib -n Test2Ver -b 5.6.0}
	exec { dotnet new ib -n Test3 -r }
	exec { dotnet new ib -n Test4 -b * -r}
}

# Synopsis: Default task.
task . install, clean

# Invoke-Build.template

Build script template for [Invoke-Build](https://github.com/nightroman/Invoke-Build)

NuGet package [Invoke-Build.template](https://www.nuget.org/packages/Invoke-Build.template/)

## Install

Install the template by this command:

    dotnet new -i Invoke-Build.template

and uninstall by:

    dotnet new -u Invoke-Build.template

## Create

Change to the target directory and invoke

    dotnet new ib [options]

in order to create `<directory-name>.build.ps1` in this directory.

## Samples

Generated build script samples:

- [Script1](samples/Script1/Script1.build.ps1) is created by `dotnet new ib`
- [Script2](samples/Script2/Script2.build.ps1) is created by `dotnet new ib --restore`
- [Script3](samples/Script3/Script3.build.ps1) is created by `dotnet new ib --bootstrap *`
- [Script4](samples/Script4/Script4.build.ps1) is created by `dotnet new ib --bootstrap 5.7.3 --scope AllUsers`

## Options

Use the following command for the list of options:

```
dotnet new ib --help
```

#### Option `-b|--bootstrap *|version`

It creates the standalone script with automatic installation of `InvokeBuild` and specifies the required module version.

The script may be invoked on its own directly, i.e. not by `Invoke-Build` command.
In this case, the script checks for the `InvokeBuild` module
and installs its required version if the module is missing.

The version value `*` stands for any installed module version.
If `InvokeBuild` is missing then the latest version is installed.

Otherwise, the value specifies the required existing version.
This version is hardcoded (pinned) in the generated script.
It may be manually changed later.

If `bootstrap` is omitted then the generated script is supposed to be invoked by `Invoke-Build` as usual.
This scenario requires installed `InvokeBuild` module or `Invoke-Build.ps1` script.

#### Option `-s|--scope CurrentUser|AllUsers`

This option is used together with `-b|--bootstrap`.
It tells where the `InvokeBuild` module should be installed if the required version is missing.
Available values are:

- `CurrentUser` (default) Installs in a location for the current user.
- `AllUsers` (run elevated) Installs in a location for all users.

#### Switch `-r|--restore`

This switch tells to add the task `restore`, to restore packages.
This task is supposed to be called explicitly.
The task `build` runs without restoring.

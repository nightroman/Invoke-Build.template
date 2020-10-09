# Invoke-Build.template
Invoke-Build script template

## Options

The following command:

```
dotnet new ib --help
```

shows the list of options:

```
Invoke-Build script (PowerShell)
Options:
  -b|--bootstrap
                  string - Optional

  -s|--scope
                  string - Optional
                  Default: CurrentUser

  -r|--restore
                  bool - Optional
                  Default: false / (*) true
```

#### Option `-b|--bootstrap *|version`

Tells to create the standalone script with automatic installation of the `InvokeBuild` module and specifies the required version.

The script may be invoked on its own, i.e. not by `Invoke-Build` command.
In this case, the script checks for the `InvokeBuild` module installed
and installs its required version.

The required version value `*` stands for any available installed version and the latest to be installed.
If `InvokeBuild` is not installed then the latest version is installed automatically.

Otherwise, the value specifies the required existing version.
This version is hardcoded (pinned) in the generated script.
It may be changed later manually.

If this option is omitted then the generated script should be invoked by the `Invoke-Build` command.
This scenario requires the installed `InvokeBuild` module or use of the `Invoke-Build.ps1` script.

#### Option `-s|--scope CurrentUser|AllUsers`

This option is used together with `-b|--bootstrap`.
It tells where the `InvokeBuild` module should be installed if the required version is missing.
Available values are:

- `CurrentUser` (default)
- `AllUsers` (run as administrator)

#### Switch `-r|--restore`

This switch tells to add the task `restore`, to restore packages.
This task is supposed to be called explicitly.
The task `build` runs without restoring.

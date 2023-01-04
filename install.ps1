Param (
    [switch]
    $Force,

    [switch]
    $DryRun,

    [string]
    [Parameter(HelpMessage = "Installation mode: link or copy")]
    [ValidateSet("link","copy")]
    $Mode = "link",

    [Parameter(HelpMessage = "Directory containing the dotfiles")]
    [ValidateScript({
        if (-Not ($_ | Test-Path)) {
            throw "Folder $_ doesn't exist."
        }

        if (-Not ($_ | Test-Path -PathType Container)) {
            throw "$_ is not a valid folder."
        }

        return $true
    })]
    [string]
    $Source = "./home",

    [Parameter(Mandatory, HelpMessage = "Directory to expand dotfiles into")]
    [ValidateScript({
        if (-Not ($_ | Test-Path)) {
            throw "Folder $_ doesn't exist."
        }

        if (-Not ($_ | Test-Path -PathType Container)) {
            throw "$_ is not a valid folder."
        }

        return $true
    })]
    [string]
    $Target
)

Get-ChildItem $Source | ForEach-Object {
    $SourcePath = "$Source/$_"
    $TargetPath = "$Target/$_"

    Write-Debug "Copying $SourcePath to $TargetPath"

    $Overwrite = $Force
    $BackupPath = ""

    if ((Test-Path $TargetPath) -And (-Not $Force)) {
        $Yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes', 'Overwrite the existing file'
        $No = New-Object System.Management.Automation.Host.ChoiceDescription '&No', 'Do not overwrite the existing file'
        $All = New-Object System.Management.Automation.Host.ChoiceDescription 'Yes to &all', 'Overwrite the existing file and remember my choice'
        $Backup = New-Object System.Management.Automation.Host.ChoiceDescription '&Backup', 'Backup existing file and overwrite'

        $Title = "$TargetPath already exists"
        $Prompt = "Overwrite?"
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($Yes, $No, $Backup, $All)
        $Default = 1

        $Choice = $host.UI.PromptForChoice($Title, $Prompt, $Choices, $Default)

        $Backup = $false
        $Overwrite = $true

        switch ($Choice) {
            1 { return }
            2 { $Backup = $true }
            3 { $Force = $true }
        }

        if ($Backup) {
            $BackupPath = "$TargetPath.bak"
            Write-Debug "Creating backup $BackupPath"
            Copy-Item -Path $TargetPath -Destination "$TargetPath.bak" -Force -WhatIf:$DryRun -Confirm:$(Test-Path "$TargetPath.bak")
        }
    }

    if ($Mode -eq "link") {
        New-Item -ItemType SymbolicLink -Path $TargetPath -Target $SourcePath -Force:$Overwrite -WhatIf:$DryRun
    } elseif ($Mode -eq "copy") {
        Copy-Item -Path $SourcePath -Destination $TargetPath -Force:$Overwrite -WhatIf:$DryRun
    } else {
        throw "Invalid mode: $Mode."
    }

    Write-Host $TargetPath -ForegroundColor "Green" -NoNewLine

    if ($BackupPath) {
        Write-Host " ($BackupPath)" -ForegroundColor "Yellow" -NoNewLine
    }

    Write-Host ""
}

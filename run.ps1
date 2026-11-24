[CmdletBinding()]
param(
    [Parameter(Mandatory, Position=0)][string]$InputFile,
    [string]$OutputFile
)
$ErrorActionPreference = 'Stop'
$culture = [Globalization.CultureInfo]::InvariantCulture
try {
    $records = @(Get-Content -LiteralPath $InputFile -Encoding utf8 | ForEach-Object { $_.Trim() } | Where-Object { $_ })
    if (-not $records.Count) { throw 'The input file is empty.' }
    $result = @(& {
        [decimal]$previous = 0
        for ($i = 0; $i -lt $records.Count; $i++) {
            if ($records[$i] -notmatch '^(\d+):([0-5]\d(?:\.\d+)?)$') { throw 'Expected mm:ss or mm:ss.s.' }
            $seconds = [decimal]::Parse($Matches[1], $culture) * 60 + [decimal]::Parse($Matches[2], $culture)
            if ($seconds -le $previous) { throw 'Cumulative times must increase.' }
            'Lap {0} · {1} s' -f ($i+1), ($seconds-$previous).ToString('0.00', $culture)
            $previous = $seconds
        }
    })
    if ($OutputFile) {
        $stream = [IO.File]::Open([IO.Path]::GetFullPath($OutputFile), 'CreateNew', 'Write')
        try {
            $bytes = [Text.Encoding]::UTF8.GetBytes(($result -join [Environment]::NewLine) + [Environment]::NewLine)
            $stream.Write($bytes, 0, $bytes.Length)
        } finally { $stream.Dispose() }
    } else { $result }
} catch {
    [Console]::Error.WriteLine($_.Exception.Message)
    exit 1
}

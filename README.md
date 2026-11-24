# Lap Split Board

Convert cumulative stopwatch readings into individual split times.

## Run

In PowerShell 7+, run `./run.ps1 -InputFile ./example.txt`. Pass `-OutputFile ./result.txt` to save to a new file. Existing output files are protected.

## Example

Cumulative readings, one mm:ss or mm:ss.s reading per line. The bundled example output includes:

```text
Lap 2 · 50.00 s
```

## Limitations

Input records are read from a UTF-8 text file. Blank lines are skipped.

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md) for checks and [CHANGELOG.md](CHANGELOG.md) for changes.

## License

[MIT License](LICENSE). Copyright (c) 2026 lap-split-board contributors.

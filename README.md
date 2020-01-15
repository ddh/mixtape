# Mixtape Manager
MixTape Manager is a CLI tool that makes changes to a collection of playlists consisting of users and songs.


## Installation
1. Clone this repository
1. Give permissions to run mixtape: `chmod +x bin/mixtape`

## Usage
1. Run from the command line:
    ``` shell
    mixtape_manager <mixtape.json> <changes_file.json> <output_file.json>
    ```
    where `changes_file.json` is a set of changes you want to apply to the original file, `mixtape.json`. The output file will be written to `output_file.json`.

## Development
* Written in Ruby
* Using `Thor` gem

## Authors
@picoPWR

## License
This program is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Acknowledgments
HighSpot
# Mixtape Manager
MixTape Manager is a CLI tool that makes changes to a collection of playlists consisting of users and songs.


## Installation
1. Clone this repository
1. Give permissions to run mixtape: `chmod +x bin/mixtape`

## Usage
1. I have provided default files for the input and changes under the `data/` directory.
1. The output file can be found in the `export/` directory
1. Run from the command line:
    ``` shell
    mixtape mixtape.json changes_file.json output_file.json
    ```
    where `changes_file.json` is a set of changes you want to apply to the original file, `mixtape.json`. The output file will be written to `export/output_file.json`.

### Supported features:
This sample app currently supports the three requested functions from the exercise:
1. Adds an _existing_ song to an _existing_ playlist
2. Add a new playlist for an _existing_ user where the playlist includes _at least_ one _existing_ song
3. Removes an _existing_ playlist

### Changes file structure:
The changes take the form of a `.json` file. Take care in how the data is structured as it determines which of the three supported features is invoked. Please look at the provided `changes.json` file and the following:
1. Adding a song to a playlist must take this form:
    ``` json
    {
      "id" : "1",
      "song_ids" : [
        "5",
        "27",
        "30"
      ]
    }
    ```
2. Adding a new playlist to a user must take this form:
    ``` json
    {
      "user_id" : "2",
      "song_ids" : [
        "40",
        "22",
        "25"
      ]
    }
    ```
3. Removing a playlist must take this form:
    ``` json
    {
      "id" : "3",
      "user_id" : null
    }
    ```

## Development
* Written in `Ruby`
* Using `Thor` gem
* `Rspec` + `Aruba` for testing (pending)

## Authors
@picoPWR

## License
This program is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Acknowledgments
:wave: HighSpot
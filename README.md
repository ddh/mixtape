# Mixtape Manager
MixTape Manager is a CLI tool that makes changes to a collection of playlists consisting of users and songs.


## Prerequisites
* Install `Ruby 2.6.4` (may work with earlier versions)
* Install [bundler](https://bundler.io/)

## Installation
1. Clone this repository
1. Navigate to the root of the repo
1. Run `bundle install`
1. Give permissions to run mixtape: `chmod +x bin/mixtape`

## Usage
1. I have provided default files for the input and changes under the `data/` directory.
1. The output file can be found in the `export/` directory
1. Run from the command line:
    ``` shell
    bin/mixtape mixtape.json changes_file.json output_file.json
    ```
    where `changes_file.json` is a set of changes you want to apply to the original file, `mixtape.json`. The output file will be written to `export/output_file.json`.

### Supported features:
This sample app currently supports the three requested functions from the exercise:
1. Adds an _existing_ song to an _existing_ playlist
2. Add a new playlist for an _existing_ user where the playlist includes _at least_ one _existing_ song
3. Removes an _existing_ playlist

### Changes file structure:
The changes take the form of a `.json` file. Take care in how the data is structured as it determines which of the three supported features is invoked. Please look at the provided `changes.json` file and the following examples. Note that each data structure is a child of `"playlist": {}` and `"id"` refers to the playlist's id.
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

## How do we scale?

### Maintainability
* I wrote the app in such a way that it supports a single user on a local machine and it only supports a handful of features.
* This resulted in many design decisions in the codebase that could down the road make it harder to add new features.
* A lot of the code can be DRY'ed up. For example, I wrote a crude imitation of `ActiveRecord` to handle the pseudo-creation of `playlists`, `songs` and `users` in-memory. A lot of this code is repeated across the classes and this can be cleaned up by creating a class that bundles together shared functionality. I could've went ahead with `ActiveRecord` but I felt it was too much overhead to deal with for such a small use case.
* This app only supports text files but we could expand to all types of inputs and outputs by adding adapters for databases or different file types.
* There is a lot of logic contained in `cli.rb` that can be extracted out to other methods or services.

### Accessibility
* At present, this app has a poor usability outside of tech-savvy individuals who would know how to run this CLI tool.
* Not only that, the input and outputs are limited to text files and is restricted to local use only.
* The CLI can only process and produce one file at a time.
* We could scale for usage by hosting this CLI tool in the cloud for example, behind an API. It would then be able to handle multiple requests.
* Once "online", we'll have more options to scale

### Performance
* Say we were to provide this tool as an API that is accessible by the Internet...
* We can increase performance by scaling horizontally, bumping the number of available servers that run the API and put this behind a Load Balancer to handle traffic.
* We can separate out the writing vs reading into their own standalone services; each with their own resources perhaps.
* We can only hold so much in-memory data. We can turn the original input source file into a datastore and then the output can be written to this datastore.
* If the changes file is extremely large, we can make accomodate for this by streaming the changes file or loading each change into an event-queue. A separate worker then can consume each change.
* If the data is stored in a database, we can create indexes for attributes that are often looked up. e.g. users, songs and playlists
* We can cache the data so it can be retrieved quicker. Changes to playlists can invalidate and update caches as we see fit.


## Post-mortem
* I had fun working on this project!
* It got me interested in using `thor` as a tool to build CLIs. I was more familiar with built-in tools like `rake` tasks for `Rails` or just using `OptionParser` for very simple one-file ruby CLI tools.
* I need to add unit tests for the various models in the app
* I would like to add a persistence layer to this tool, like a database, to store the data for later use.
* There's coupling between `Playlist` and `Song` that I would like to fix. Perhaps a join-table of sorts.
* My `changes.json` file is _very_ picky with how each of the requested features are formatted. If we were to add more features for the project, I would need to change how the app interprets the changes. Perhaps have named actions like "update" or "destroy", much like a CRUD app. Then we can treat the changes file li
* I would like to add more error handling. I've added a handful of the obvious ones but I certainly did not cover all edge cases.

## Authors
@picoPWR

## License
This program is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Acknowledgments
:wave: HighSpot

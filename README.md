# Tennis Club API

## Specification

#### 1) An endpoint for registering a new player into the club

a. The only required data for registration is the player’s first name and last name,\
   nationality, and the date of birth

b. No two players of the same first name and last name can be added

c. Players must be at least 16 years old to be able to enter the club

d. Each newly registered player should start with the score of 1200 points\
   for the purpose of the ranking

#### 2) An endpoint listing all players in the club

a. It should be possible to list only players of particular nationality and/or rank name\
   (see the bottom of the document) or all players

b. The list should contain the following information for every player:
   1. the current position in the whole ranking
   2. first and last name
   3. age
   4. nationality
   5. rank name
   6. points

c. The players should be ordered by points (descending)
   1. The unranked players should also be ordered by points (descending)\
      but should appear at the bottom of the list, below all other ranks

#### 3) An endpoint for registering a match that has been played

a. It should require providing the winner and the loser of the match

b. The loser gives the winner 10% of his points from before the match (rounded down)
   1. For example, if Luca (1000 points) wins a match against Brendan (900 points),\
      Luca should end up with 1090 points after the game and Brendan with 810
   2. If Daniel (700 points) wins a match against James (1200 points),\
       Daniel should end up with 820 points after the game and James with 1080

c. The business logic behind calculating new player scores after a match should be unit-tested

The code should be as readable and as well-organized as possible.\
Add any other information and/or extra validation for the above endpoints as you deem necessary.

|  Rank   |   Points |
|---------|----------|
| Unranked | (The player has played less than 3 games) |
| Bronze | 0 – 2999 |
| Silver | 3000 – 4999 |
| Gold | 5000 – 9999 |
| Supersonic Legend | 10000 – no limit |


## How to use this project
This is a Ruby project. Tell your Ruby version manager to set your local Ruby version to the one specified in the `Gemfile`.

For example, if you are using [rbenv](https://cbednarski.com/articles/installing-ruby/):

1. Install the right Ruby version:
  ```bash
  rbenv install < VERSION >
  ```
1. Move to the root directory of this project and type:
  ```bash
  rbenv local < VERSION >
  ruby -v
  ```

You will also need to install the `bundler` gem, which will allow you to install the rest of the dependencies listed in the `Gemfile` file of this project.

```bash
gem install bundler
rbenv rehash
```

### Folder structure

* `bin `: Executable files
* `lib `: Source files
* `spec`: Test files


### To initialise the project

```bash
bundle install
```

### To run the app


## Tests


### To run all tests


```bash
bundle exec rspec
```


### To run a specific file


```bash
bundle exec rspec path/to/test/file.rb
```


### To run a specific test

```bash
bundle exec rspec path/to/test/file.rb:TESTLINENUMBER
```


### To run rubocop

```bash
bundle exec rubocop
```

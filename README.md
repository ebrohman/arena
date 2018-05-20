# Battle Pets Arena

* Development Considerations
  - I choose Rails because it was easy to get running and most are familiar with some of its tooling and patterns.
  - Due to time constraints, I have not removed the view layer, action cable, and other extraneous things from the project that come with Rails scaffolding.

* Assumptions
  - The client of this service knows the identifiers of the pets that are to do battle

* Ruby version
  - I'm running this with `2.4.3` using `rvm`

* System dependencies
  - hard dependencies
    - postgresql
    - redis

  - I have the native postgres for mac @ version `9.4.0.1`
  - I have redis installed through brew
  - I am running redis with `brew services run redis`

* Configuration
  - create a `.env` file and add your `API_KEY` for the Heroku batle pets api

* Database creation
  - `bundle exec rake db:setup` or however you prefer to run your db migrations, i.e. `db:create`, `db:migrate`, `db:seed`, etc.

* Database seeding for development
  - `bundle exec rake refresh_pets` will pull battle pet data from Heroku and load it into your development database.

* How to run the test suite
  - `RAILS_ENV=test bundle exec rake db:create`
  - `RAILS_ENV=test bundle exec rake db:migrate`
  - `bundle exec rspec`

* After the test suite is run you can check coverage
  - `open coverage/index.html`
  - It is currently at 100% coverage - yay!

* Using the app
  - The endpoints are as follows:
    - `POST /contest`
      - params:
        ```
          {
            "challenger_id": <uuid>,
            "opponent_id": <uuid>,
            "strategy": <string> (optional)
          }
        ```
      - response:
        ```
          { "contest_id": <uuid> }
        ```
    - here, `challenger_id` and `opponent_id` are the ids of various battle pets.  `strategy` is the strategy type to use to do battle.  A `Strategy` is where the battle logic is encapsulated.  Current options are "random" or "attrition".  New battle strategies can be added to the code by simply following naming convention and some template methods.

  - `GET /contest/:id`
    - params:
      ```
        { "id": <uuid> }
      ```
    - sample response:
      ```
        {
          "id":"0c9f46a9-0c3c-48d1-9071-7e9af1b3f07e",
          "challenger_id":"1d4d557b-2470-40cb-b2e4-1bc138914464",
          "opponent_id":"2251ef5c-4abb-4f97-943e-0dc8738b5844",
          "strategy":"attrition",
          "winner_id":"2251ef5c-4abb-4f97-943e-0dc8738b5844",
          "created_at":"2018-05-20T20:12:56.473Z",
          "updated_at":"2018-05-20T20:12:56.484Z"
        }
      ```
    - battle status
      - the status of a battle can be read from this endpoint.  Battles are run in a background job and once a winner is determined, it is recorded and persisted to the database.  The absence of a `winner_id` indicates the the battle is still pending.

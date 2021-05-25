# README
***Sleep Diaries***

- ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-darwin19]
- Rails - 6.0.3.7
- Node - v14.13.1

New gem: simple_token_authentication
(also rubocop and pry, just because I like them)

After pulling:
1. bundle install
2. rake db:migrate

***Routes***
- index GET http://domain/ --> diaries#index
- show_diary GET http://domain/diaries/:user_id/:date_id(.:format) --> diaries#show
- show_with_token GET http://domain/:uuid/:date_id(.:format) --> diaries#show_with_token
- update_diary PUT http://domain/diaries(.:format) --> diaries#update
- create_diary POST http://domain/diaries(.:format) --> diaries#create

Devise authentication works for index and show methods

Implemented Token authentication for three methods, all in the diaries controller:
(note - need both Token and Email in the header, see FaradayForDiaries for usage)
1. show_with_token
2. create - Note: ActiveRecord errors are not currently displayed. That would be an improvement.
3. update - not implemented yet

The API methods can only be called using Faraday (or postman or whatever)
- app/workflows/faraday_for_diaries.rb

***Faraday Usage***
- First go to folder and manually update the params
- go to console `>>> rails c `
- run `>>> FaradayForDiaries.create_diary `
- or `>>> FaradayForDiaries.get_diary`

If you create a new diary entry for a day in the past week, it will be reflected in the
diary dashboard, if you click one, will pull in data from the show method (either defaults or the actual diary record)

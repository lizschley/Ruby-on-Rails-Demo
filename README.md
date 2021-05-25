# README
**Sleep Diaries**

- ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-darwin19]
- Rails - 6.0.3.7
- Node - v14.13.1

New gem: simple_token_authentication
(also rubocop and pry, just because I like them)

After pulling:
1. bundle install
2. rake db:migrate

Devise authentication works for index and show methods

Implemented Token authentication for three methods, all in the diaries controller:
(note - need both Token and Email in the header, see FaradayForDiaries for usage)
1. show_with_token
2. create
3. update - not implemented yet

The API methods can only be called using Faraday (or postman or whatever)
- app/workflows/faraday_for_diaries.rb

**Usage**
- First go to folder and manually update the params
- go to console `>>> rails c `
- run `>>> FaradayForDiaries.create_diary `
- or `>>> FaradayForDiaries.get_diary`

If you create a new diary entry for a day in the past week, it will be reflected in the
diary dashboard, if you click one, will pull in data from the show method (either defaults or the actual diary record)

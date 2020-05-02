# **DinDiv**
1. Get started with Ruby (https://www.ruby-lang.org/en/documentation/quickstart/)
2. Get started with Ruby on Rails (https://guides.rubyonrails.org/getting_started.html)
3. Whenever starting to work on a new Rails project, make sure all the app's gems are installed.  Switch to the app's root directory (presumably `expense-splitter`) and run `bundle install --without production` (you only need to specify `--without production` the first time, as this setting will be remembered on future runs of Bundler for this project).
4. Get the local database created:

```sh
$ rake db:migrate
```

5. Now insert "seed data" into the database--initial data items that the app needs to run:
```sh
$ rake db:seed
```

6. At this point you should be able to run the app locally (`rails server`) and navigating to `http://localhost:3000/movies` in your browser.  If you are using c9, use `rails s -p $PORT -b $IP` and navigate to the link generated within c9.

# Bitcoin Quotes

A simple website that shows a curated selection of quotes related to Bitcoin, one quote at a time. Available for everyone at [bitcoin-quotes.com](https://www.bitcoin-quotes.com/).

### Contribute

If you find any typos, grammatical errors, broken links, or any other mistakes or issues, please [point them out to me](https://dergigi.com/contact/). Or even better: create a pull request to correct them.

### Build the site locally

Prerequisites:

1. Install [Rails](https://rubyonrails.org/)
2. Clone the repository and `cd` into the site's directory
3. Run `bundle install` to install dependencies from `Gemfile`
4. Install and set up [PostgreSQL](https://www.postgresql.org/) (see `config/database.yml` for details)

After that, simply run `rails s` to serve the site locally.

### Update

Two scripts are of interest for updating the DB: `db:seed` and `paywall:create`. If the site is running on Heroku, for example, the following will do:

```
heroku run bundle exec rake db:seed && heroku run bundle exec rake paywall:create
```


### Support

You can follow [the bot](https://twitter.com/btc_quotes) on Twitter, share the project, [submit](https://forms.gle/himv1V62J8ArHPkJ8) a quote, or [support me](https://dergigi.com/support/) directly.

---

Created with 🧡 by [Gigi](https://dergigi.com/).

[![tippin.me](https://badgen.net/badge/%E2%9A%A1%EF%B8%8Ftippin.me/@dergigi/F0918E)](https://tippin.me/@dergigi)

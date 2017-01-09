# Telegram Ruby Example

An example Telegram bot integrated with [Dialog Analytics](https://dialoganalytics.com). Built with [atipugin/telegram-bot-ruby](https://github.com/atipugin/telegram-bot-ruby).

- [Dialog Documention](https://docs.dialoganalytics.com)
- [Dialog API reference](https://docs.dialoganalytics.com/reference)

## Getting started

Clone this repository and run `bundle install`

Create an account on https://app.dialoganalytics.com, grab your Dialog API token and bot ID.

Set environment variables in `.env`:

```
TELEGRAM_TOKEN=...
DIALOG_API_TOKEN=...
DIALOG_BOT_ID=...
```

Start the bot:

```bash
$ ruby bot.rb
```

Go on [web.telegram.org](https://web.telegram.org/#/im), find your bot and start interacting with it.

## Go further

Read more on how to make the most out of the possibilities offered by Dialog here: https://dialoganalytics.com

# README

CSV製造機。

### setup

```sh
$ cp .env.sample .env
$ docker-compose build
```

### usage

* 新しいCSVを定義する
```sh
$ docker-compose run app new foo_bar
$ tree line/foo_bar
line/foo_bar
├── column.rb
├── configs
│   └── template.yml
├── exp.rb
└── row.rb

2 directories, 5 files
```

* 定義したCSVを出力する
```sh
$ docker-compose run app factory foo_bar
$ tree line/foo_bar
line/foo_bar
├── column.rb
├── configs
│   └── template.yml
├── csv
│   └── FooBar.csv   <= new!
├── exp.rb
└── row.rb

2 directories, 5 files
```

### help

```sh
$ docker-compose run app factory -h

Usage:
       factory <name> +[options]
where [options] are:
  -r, --row-count=<i>    出力行数
  -f, --file=<s>         出力ファイル名
  -H, --header           ヘッダーの要否
  -s, --separator=<s>    区切り文字(default ",")
  -q, --quotes           全フィールドをクオート
  -o, --overwrite=<s>    config上書パラメータ(JSON)
  -v, --version          Print version and exit
  -h, --help             Show this message
```


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

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
$ docker-compose run --rm app new foo_bar
$ tree line/foo_bar
line/foo_bar
├── column.rb
├── configs
│   └── config.yml
├── exp.rb
└── row.rb
```

* 定義したCSVを出力する
```sh
$ docker-compose run --rm app factory foo_bar
$ tree line/foo_bar
line/foo_bar
├── column.rb
├── configs
│   └── config.yml
├── csv
│   └── FooBar.csv   <= new!
├── exp.rb
└── row.rb

$ cat line/foo_bar/csv/FooBar.csv
ID,Name
1,山下 大輔
2,石田 芽衣
3,増田 優
...
```

### help

```sh
$ docker-compose run --rm app factory -h
Usage:
  1. new <name>
  2. edit line/<name>/...
  3. factory <name> +[options] # <= Now here

Currently available <name>:
  co_items
  import_contract_order
  sample
  sample2
  template

where [options] are:
  -c, --row-count=<i>    default: 10
  -f, --file=<s>         default: "rollout.csv"
  -H, --header=<s>       default: "true"
  -s, --separator=<s>    default: ","
  -q, --quotes=<s>       default: "false"
  -o, --config=<s>       overwrite config(JSON)
  -b, --bom              With BOM
  -S, --shift-jis        Output with shift_jis
  -W, --win31j           Output with Windows31J
  -v, --version          Print version and exit
  -h, --help             Show this message
```

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
├── dynamic_parameter.rb
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
├── dynamic_parameter.rb
└── row.rb

2 directories, 5 files

$ cat line/foo_bar/csv/FooBar.csv
ID,Name
1,山下 大輔
2,石田 芽衣
3,増田 優
4,野口 一輝
5,木下 愛
6,後藤 翼
7,村田 優
8,武田 隼人
9,森 直樹
10,増田 航
```

### help

```sh
$ docker-compose run app factory -h
Usage:
  1. new <name>
  2. edit line/<name/...
  3. factory <name> +[options] # <= Now here
where [options] are:
  -r, --row-count=<i>    default: 10
  -f, --file=<s>         default: "rollout.csv"
  -H, --header           default: true
  -s, --separator=<s>    default: ","
  -q, --quotes           default: false
  -o, --overwrite=<s>    config overwrite(JSON)
  -b, --bom              With BOM
  -S, --shift-jis        Output with shift_jis
  -W, --win31j           Output with Windows31J
  -v, --version          Print version and exit
  -h, --help             Show this message
```

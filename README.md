Cfn2dsl
=======

cfn2dsl is a tool to enable CloudFormation development team to work on both JSON templates and Ruby DSL code written in `cfndsl` (created by project [cfndsl](https://github.com/stevenjack/cfndsl])).

The idea is to give developer options on developing CloudFormation using the tool and language they feel comfortable and efficient. Some developers like to develop JSON template, and others like to develop with `cfndsl`. We need a tool to sync the developments on both methods, so `cfn2dsl` is here to help. It can parse CloudFormation JSON templates and translate them into `cfndsl` Ruby DSL.

what cfn2dsl can do
===================

* it parse CloudFormation JSON template and output `cfndsl` Ruby code

* it use generic `cfndsl` objects in the translation, for example `Parameter()`, `Resource()`, `Output()` and `Property()`. It supports all official resources, attributes and properties supported by CloudFormation.

* it formats ruby hash/arry objects in a more readable way using `awesome_print`

what cfn2dsl can't do
=====================

* it is not able to keep your comments in Ruby code, you might need to move the important information out from the Ruby code into README.md

* it so far doesn't know how to translate CloudForamtion resource into abstracted objects used in `cfndsl`, for example `EC2_Instance` ...

* it can't reproduce your programming logic in your `cfndsl` template if you rely on Ruby code to do interesting things, for example environment variables. (you might think about to use CloudFormation Conditions to achieve environment switch)

* it doesn't know the translation of special intrinsic function provides by `cfndsl`, for example `FnFormat()`


how to use this tool
=====================

```
#> gem install cfn2dsl
```

* command line options

```
#> cfn2dsl --help

Usage: cfn2dsl -t|--template file [-o|--output file]
    -t, --template file              Template file path
    -o, --output [file]              Output file path
    -h, --help                       show this message
```

* translate JSON template and output to standard out

```
cfn2dsl -t /your/path/to/template.json
```

* translate JSON template and write output to file

```
cfn2dsl -t /your/path/to/template.json -o /your/path/to/template.rb
```





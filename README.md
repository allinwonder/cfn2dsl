### Cfn2dsl [![Build Status](https://travis-ci.org/allinwonder/cfn2dsl.svg?branch=master)](https://travis-ci.org/allinwonder/cfn2dsl) 

cfn2dsl is a tool to enable CloudFormation development teams to work with both JSON and YAML templates to produce Ruby DSL code written in `cfndsl` format (created by [cfndsl](https://github.com/stevenjack/cfndsl) project).

The idea is to give developers options for developing CloudFormation configurations using the tool and language which they feel comfortable and efficient in. Some developers like to develop JSON templates, and others like to develop with `cfndsl`. We need a tool to synchronise development in both methods, so `cfn2dsl` is here to help. It can parse CloudFormation JSON templates and translate them into `cfndsl`'s Ruby DSL.

#### what cfn2dsl can do


* It parses CloudFormation JSON or YAML template and outputs `cfndsl` Ruby code.

* It uses generic `cfndsl` objects in the translation, for example `Parameter()`, `Resource()`, `Output()` and `Property()`. It supports all the resources, attributes and properties officially supported by CloudFormation.

* It formats Ruby hash/array objects in a more readable way using `awesome_print`.

#### what cfn2dsl can't do

* It is not able to keep your comments in the Ruby source, so you might need to move any important information that exists in comments out from the Ruby code into a README file.

* It currently doesn't know how to translate CloudForamtion resource into the abstracted objects used in `cfndsl`, for example `EC2_Instance`.

* It can't reproduce your programming logic in your `cfndsl` template if you rely on Ruby code to do interesting things, for example environment variables. (You might need to think about using CloudFormation Conditions to achieve an environment switch.)

* It doesn't know how to translate special intrinsic functionality provided by `cfndsl`, for example `FnFormat()`.


#### how to use this tool

```
#> gem install cfn2dsl
```

* Command line options

```
#> cfn2dsl --help

Usage: cfn2dsl -t|--template file [-o|--output file]
    -t, --template file              Template file path
    -o, --output [file]              Output file path
    -h, --help                       show this message
```

* Translate template and send output to standard output

```
cfn2dsl -t /your/path/to/template.yaml
```

* Translate template and write output to file

```
cfn2dsl -t /your/path/to/template.yaml -o /your/path/to/template.rb
```

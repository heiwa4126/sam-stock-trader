# sam-stock-trader

[aws-sam-cli-app-templates/python3.9/cookiecutter-aws-sam-step-functions-sample-app/{{cookiecutter.project_name}} at master · aws/aws-sam-cli-app-templates](https://github.com/aws/aws-sam-cli-app-templates/tree/master/python3.9/cookiecutter-aws-sam-step-functions-sample-app/%7B%7Bcookiecutter.project_name%7D%7D)
にあるAWS SAMのサンプルテンプレートに手をいれたもの。
コードを読みながら、コメントとか入れていく。

ほか参照:
- [AWS SAM を使用して Step Functions ステートマシンを作成 - AWS Step Functions](https://docs.aws.amazon.com/ja_jp/step-functions/latest/dg/tutorial-state-machine-using-sam.html)

SAMだとASLはYAMLで書ける。便利。

# 動作メモ

起動は
AWS::Events::Rule
で1時間に1回(デプロイ時はdisable)

ASLで最初は
StockCheckerFunction
functions/stock_checker/app.py

もし stock_price が50以下なら
Buy Stock へ。
それ以外は Sell Stock へ。

Buy Stock は
functions/stock_buyer/app.py

Sell Stock は
functions/stock_seller/app.py

で、
Record Transaction で
DynamoDBに入れる。
すごいのはこれASLでできること。


# 最適化統合(optimized integrations)

`arn:aws:states:::dynamodb:putItem`
みたいののリファレンスはどこにある?

ここ:
- [Step Functions 用統合最適化 - AWS Step Functions](https://docs.aws.amazon.com/ja_jp/step-functions/latest/dg/connect-supported-services.html) タイトルから想像できない内容...
- DynamoDBについては [Step Functions を使用した DynamoDB API の呼び出し](https://docs.aws.amazon.com/ja_jp/step-functions/latest/dg/connect-ddb.html)

統合最適化(optimized integrations)以外の呼び出し方は
[他のサービスで AWS Step Functions を使用する - AWS Step Functions](https://docs.aws.amazon.com/ja_jp/step-functions/latest/dg/concepts-service-integrations.html)

`arn:aws:states:::aws-sdk:*` を使う
[AWS SDK のサービスの統合 - AWS Step Functions](https://docs.aws.amazon.com/ja_jp/step-functions/latest/dg/supported-services-awssdk.html)
など。「SDK統合」。いちいちlambdaを書かなくてもいいケースが増える。



# ASLの '$.' とは?

JsonPath。ASL内では使えない関数あり(lenght()とか)

> パスは、JSON テキスト内でコンポーネントを識別するために使用できる $ で始まる文字列です

- [パス - AWS Step Functions](https://docs.aws.amazon.com/ja_jp/step-functions/latest/dg/amazon-states-language-paths.html)
- [json-path/JsonPath: Java JsonPath implementation](https://github.com/json-path/JsonPath)
- [JSONPath Online Evaluator](https://jsonpath.com/)


# ASLの '.$' とは?

[InputPath、パラメータ、および ResultSelector - AWS Step Functions](https://docs.aws.amazon.com/ja_jp/ja_jp/step-functions/latest/dg/input-output-inputpath-params.html#input-output-parameters)

> パスを使用して値を選択するキーと値のペアの場合、キーの名前は .$ で終わる必要があります。


# ASLの仕様は

ここ: [Amazon States Language](https://states-language.net/)

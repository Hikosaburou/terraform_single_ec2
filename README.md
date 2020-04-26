# terraform_single_ec2

AWSで単一サーバにSSHアクセスするための構成

## できるもの

AWSアカウント上に以下を作成する。

- VPC, IGW, パブリックサブネット, ルートテーブル
- EC2インスタンス
    - 特定IPからSSHアクセスを許可
    - 全てのIPからHTTP/HTTPS接続を許可

## 準備


### SSHキーペアの作成

EC2インスタンスにアクセスするためのキーペアを作成する

```
$ ssh-keygen -t rsa -b 4096
```

コンソールでEnterし続けると `~/.ssh/id_rsa`, `~/.ssh/id_rsa.pub` が作成されるので適宜リネームする

```
$ mkdir -p ~/.ssh/keys
$ mv ~/.ssh/id_rsa ~/.ssh/keys/test
$ mv ~/.ssh/id_rsa.pub ~/.ssh/keys/test.pub
```

### クレデンシャル情報を設定

環境変数を設定する。(`AWS_PROFILE` 設定を推奨)

```
### アクセスキーを直接指定する場合 
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=xxx

### 名前付きプロファイルを指定する場合
export AWS_PROFILE="my-profile"

### 名前付きプロファイルでIAMロールを利用する場合、以下を追加する
export AWS_SDK_LOAD_CONFIG=1
```

### terraform.tfvars の作成

```
public_key_path="$HOME/.ssh/keys/test.pub"
my_ip="x.x.x.x/32"
```

各項目に以下要領で値を入れる

| 項目 | 内容 |
|  ------ | ------ |
|  public_key_path | 公開鍵ファイルのパス |
|  my_ip | SSHの接続元IP |

## デプロイ

以下コマンドで構成を確認する。

```
$ terraform plan
```

以下コマンドで構成をAWS環境にデプロイする。

```
$ terraform apply
```

- EC2インスタンスにSSH接続

```
### @ 以降に terraform apply で出力されたPublic IPを入れる
$ ssh -i ~/.ssh/keys/test ec2-user@x.x.x.x
```

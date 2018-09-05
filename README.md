# terraform_single_ec2

AWSで単一サーバにSSHアクセスするための構成

## Usage

EC2インスタンスにアクセスするためのキーペアを作成する

```
$ ssh-keygen -t rsa
```

コンソールでEnterし続けると `~/.ssh/id_rsa`, `~/.ssh/id_rsa.pub` が作成されるので適宜リネームする

```
$ mkdir -p ~/.ssh/keys
$ mv ~/.ssh/id_rsa ~/.ssh/keys/test
$ mv ~/.ssh/id_rsa.pub ~/.ssh/keys/test.pub
```

- terraform.tfvars を作成する

```
aws_access_key="access_key"
aws_secret_key="secret_key"
key_name="test.pub"
public_key_path="$HOME/.ssh/keys/test.pub"
office_ip="x.x.x.x/32"
```

各項目に以下要領で値を入れる

| 項目 | 内容 |
|  ------ | ------ |
|  aws_access_key | AWSのShared Credential. アクセスキー |
|  aws_secret_key | AWSのShared Credential. シークレットキー |
|  key_name | EC2インスタンスに設定する公開鍵の名前 |
|  public_key_path | 公開鍵のパス |
|  office_ip | オフィスのPublic IP. (SSH接続の際にIP制限を行う) |

- 構成確認

```
$ terraform plan
```

- デプロイ

```
$ terraform plan
```

- EC2インスタンスにSSH接続

```
### @ 以下には terraform apply で出力されたPublic IPを入れる
$ ssh -i ~/.ssh/keys/test ec2-user@x.x.x.x
```

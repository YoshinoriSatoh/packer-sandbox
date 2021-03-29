# packer-sandbox

検証したり、便利に使えそうな、packerの設定・プロビジョニングファイル群です。

対象はAWSのAMIです。

## packer

https://www.packer.io/

### バージョン

```
Packer: v1.7.0
```

## コマンド

各ディレクトリに移動して実行してください。

### AWSプロファイル指定

variable.pkrvars.hcl の `profile` に対象のAWSプロファイルを指定してください。

### バリデート

```
packer validate -var-file=variable.pkrvars.hcl packer.pkr.hcl
```

### ビルド

```
packer build -var-file=variable.pkrvars.hcl packer.pkr.hcl
```

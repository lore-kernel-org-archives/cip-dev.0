Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1A6C4332F
	for <webhook@archiver.kernel.org>; Sun, 20 Nov 2022 20:50:12 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.56])
 by mx.groups.io with SMTP id smtpd.web11.22508.1668977405544013151
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Nov 2022 12:50:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Mr0jhzzo;
 spf=pass (domain: siemens.com, ip: 40.107.6.56, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUwRrppoR86EpmoIkfHc7c+L8F6lMiesTCygwh8IhPUdG6NmYyyHFfM+J1ETRgjVYCAy9eL0m8RMAk1zmCd71181L2TjluHurfATklN0s2UUdEd2eVWYuR83gyrIFEq0eDTe4OQ9G7aLgtPZX/4idH+Dr5kpQUX4SHV3HMdiSEveR27/ku8HbZZP7onBKdETvH44FquxA/5SuRa4yyVWucDpQiamoxWPHmGDiOPIgMQJdYk1cYhAwqPiEOGUnxXHnIJQgklyfardzVMdddHxFkDTwCw8wVm+TqZcv0RxA3NDaP6O5jlbBoEutZsIbpJl4+TKy1CZURsItyNhvTzlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xfYvrWZU2lyTJqQHL5tBCPzVpAR97SSRKbNu88XBoo=;
 b=OuXBgM+/vykMZnsJqiUth6pSSF08YtIHmp1cSad0AG5y7xHlm/Pv0tRAySD+XT30n80B/vZxpKf7Xho8aVjS1RRPoaoi+P6VWFQYjG7BC1rlAK5JagNX+RJxe9p1UFp5VqFqV+QTfOHzlDL+BcyURJ/bpxcwHVHdeDd5H95+VaZnfv7FZS4PgL9cdpIlcu7mfHHqs8XNVwGf3FaY4Sz5j0kkfCS3IWLAl6fQjqmyfqqGcg4HKROegxetF3v41FCyZxU1xEMW8LWhzNUBTWtQjSSPpQZG9Rl0lH+EuCuXZ5pQWwBFO2utnliw9tLpgBSSfLrnhJhcbj/aRO58lz1KRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xfYvrWZU2lyTJqQHL5tBCPzVpAR97SSRKbNu88XBoo=;
 b=Mr0jhzzou+XIVBbWN5FnSt8UjE7BenxqJmehsgJbRqqWtW6ln2h4P15jyz7AqQYAHfKGbm9/cmtaVRILOncUBlPplYklNVQN8203V/wfMaXdjejUs3TRBgIXijq995BpQRIP9VAiSv2GPBjPZJ4N0VeIwADH2oz2mYqLrQj6AEbb2gZcxXKJaP4OLJauLQU832vY5tt7bjkyvsZurR4EFBoQK0SirxQ4mt+W/qcSfKgMAwZy7wpdjZLydWSe8R0HcnZE3/yDXeqlMhCDaKliS53PnPVtQ76fkVQcFFQU8oCrI2swaeGrzhD0wldUYOJB7d/KmW1FE5MuFmAINoHkYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sun, 20 Nov
 2022 20:50:02 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 20:50:02 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 6/8] change ebg sb signer and secrets to pk kek db
Date: Sun, 20 Nov 2022 21:47:09 +0100
Message-ID: <20221120204711.5826-7-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120204711.5826-1-sven.schultschik@siemens.com>
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: e11863f4-a05c-47d2-3300-08dacb38cbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F2fkDpLehFpMPJG3OTewRPxzYM6GOCAxuFiIU2Mw5NePnw+Dyef2Fh6tky4TyrK6xT/Fid37oDbY9oD8OezIlv+V1H8nU2D3F5agkOq19Ao0D+0ETFS0JpMExy8cA29qc72wYLOyydRVbrUtvWHaQyK3XVW9AuHn7jimX1lv2+UlvdTu4quWTHy0S62LeVTW+er6M5wH3qXG4j1U37RurIrea2b1FJvMQC0nhP0I+VnhDg6QiwhxNgsY0yg10zlHEKztJhOA8KnxDOO19/ZSBX725cpOKo5h2cQj9lerf2DaTB41gFraQM5BZWANFoYcD9TCrIu+znrz15ukhIjXZxZqvDxdZmQ6e8xlRxuF1e7y0a35cs2h9PhWJku6qwly5Ae8vkBoE6HG4FiozCOEoYFUzLfiIYdce/Oct2YrgdSUjs5oWZu6uADU9bq9GHtQldF4J7hLAzmb5k7nVdKTO2bjwVj+XJIkn4lRg2YUjetn9k3ADZ1BRmehn0MdmkAHZgm1EYpOGvt+XuJz5iccCBl7DkZRefMmy6orlWR6vWrQi7ayrm8uFw/dNtyd67BuZgY1p7XlQ4XAnOB3hS0HK7F55RfqoZAgDo5dXV0heOOPvAZpS9RN5WhELBF6/zadIrZBfCeQuxuPejx3jdnUDai2R1WX+LagwnWZYi0WrSxei0iR496091xvN8myrkO/VeMTmRjf0ACsyb4yZ/6F4g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(2906002)(26005)(83380400001)(9686003)(86362001)(4326008)(6512007)(8676002)(66556008)(66476007)(82960400001)(66946007)(38100700002)(36756003)(41300700001)(30864003)(6916009)(8936002)(19627235002)(5660300002)(316002)(107886003)(55236004)(478600001)(186003)(1076003)(6486002)(2616005)(6506007)(378184002)(14743001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bIdH6buvz4b+0XO1uBOT4xdO8TgIv2CbthGS9BixcT3C2yfsC28iMkYfiAfa?=
 =?us-ascii?Q?KD/fiwlpEm7SqMej4MQvNrv3CC+k5cmz9I+qtbvC/+UI+ZD2JfvrioY7DW7S?=
 =?us-ascii?Q?2ngRV30u0+WAQXbqZZv8p2DA2POwzuzxnxtAdmihdXxN0borM8SZPWnN18cN?=
 =?us-ascii?Q?6WPI5k1re8e7psw1cH5YFALXIcQvznlN+tAdtVNpkbW5bBkMKttdgq6ffH0w?=
 =?us-ascii?Q?OsZlfUHzvfUZPiDd8xOAwmoMOWhZKH6GhS64UxVHCVGLU7+KYH0MQN4Q7CxC?=
 =?us-ascii?Q?IRhw+fTyh7yfgBUUg327ULMUcFdNfmo2fiKisUgzQRPqGrsEg0a901V7CKPk?=
 =?us-ascii?Q?g4m14ESnYTARzfVDz/DdEE4BDveUahs4+sn+HPEyu0U6HZTOLZjL3vFGqxEm?=
 =?us-ascii?Q?uanJ7ijaboLPd9Bzaw9U8IjVp2a+eZ7f8M+1mNFEW29vu6BAVvK7vi/VR+eO?=
 =?us-ascii?Q?Lh1pSETGGa9OABuJUyZiiOIFuBxqZEjRv7Q3U7bZD9rg+Mzy6WIDw+g4+43B?=
 =?us-ascii?Q?zRuwEO+eX6acojjeS5TQMpTYrlGbHivpBuAjAwG/JMDtbIAXG9Afkf/3G/dO?=
 =?us-ascii?Q?n5EKLDTfp5qMVFaAI3yfTOzehm3MN1zECKxsNZXaEWoztOcyfmuDpLenAuGD?=
 =?us-ascii?Q?tIqBQcjm3xTXx5OJDiiVft+myyYrdeCbAOT81VJqV4l4gkWCGxY7Gz7zpdTR?=
 =?us-ascii?Q?7Hm0gGLAH9MBmNQ7sOk0CTs9i69fCmWNbOr4h37+rVHnZpLauKUi2xS3Ni8F?=
 =?us-ascii?Q?F+8wRQYTTl+Cf9KbzbogHc4sa40nj8srFHeAF9b7eFxt+EcmR7h4GJp/UjDQ?=
 =?us-ascii?Q?eQMO3QEnqtbfyivYWRWJCgj+s+AN36QSPCXFxLgaY6PmWUcu8jNsS/sdXVMS?=
 =?us-ascii?Q?I5rUDpvRnF2MArnLAp/h1xkv2DZp5NUvtqfg0XiVD5yUEyyiR/thqbZqpnD5?=
 =?us-ascii?Q?/PDTaxy6ba8sJKV23DZaVCDh7v4RGWVePyNap7YP7ekPLAComllfXmaltqHn?=
 =?us-ascii?Q?a+gD12Bmc55436ATGzP2IfBsAcuJpfdxINmgcKZwNy48RADJFIz/BGwDSPbl?=
 =?us-ascii?Q?evk4aBFakEj7oZvIDZmbrauVnfQSPFjY4uUg92RzMmrcz3FYRj2yQctMaDRI?=
 =?us-ascii?Q?zwK82DccduQ1VQ/ENJEf9ZViEaWpVtEw7OJM0wnAlF+6oAKsMVEub3xS++gK?=
 =?us-ascii?Q?M1p7GrpThKghvxpkTjL9Q+So6rMjqx3q7l0UMqIQBW96tXYXgYsY3o4+ulrg?=
 =?us-ascii?Q?hRqvtfyxPcRTR/+zM2RG9XAsPD6nPn27P1RUS9/n15iFejA55pGtWZle6Ssk?=
 =?us-ascii?Q?x+0en3zfMVKfVE97d7cY8m1x7n8v/H6Q0EnEm326gxAZ5cov6gL3oSj84y7l?=
 =?us-ascii?Q?UPukZ2c4m/x0wcBgfW44LKgL8C3RXc7dqjYnLwciWT3ojBHhDaU8osz3aVRI?=
 =?us-ascii?Q?1HCKWNSG2AV1pS4ZHdK5xM6Acco0i5qHXyiVTeugpCkYUyxQqx7uYEiaJm2R?=
 =?us-ascii?Q?o0hL4nr2O9VfqCUtwS+pu/rJO3zzQrGlGHcV8CO/kgREo4ezWUd9FAN655rZ?=
 =?us-ascii?Q?12XJtBgrZm48G69vPmtTbLa7835jlEg/ybnuAr/PVzBzgncC+Geruab7XHvk?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11863f4-a05c-47d2-3300-08dacb38cbef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 20:50:02.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqkLYI4N0r9hvgmFqyX2deSOaQ/nHe/NYgzFziAvqFL6D2hiNP4iKlt9Y/fovyyOzyNS+TsyxW+fB/vo6r887zbySU4K1Go4Q7h1Qpmm6AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 20 Nov 2022 20:50:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10059

From: Sven Schultschik <sven.schultschik@siemens.com>

The secure boot setup with OP-TEE, u-boot and EFI works with a platform key=
 (pk), key exchange key (kek) and signature database (db). isar-cip-core sh=
ould only provide one secure boot solution and so the key structure and set=
up needed to be adjusted.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 .../files/sign_secure_image.sh                |   2 +-
 .../secure-boot-secrets/files/KEK.auth        | Bin 0 -> 2066 bytes
 .../secure-boot-secrets/files/KEK.crt         |  19 +++++++++
 .../secure-boot-secrets/files/KEK.esl         | Bin 0 -> 839 bytes
 .../secure-boot-secrets/files/KEK.key         |  28 +++++++++++++
 .../secure-boot-secrets/files/PK.auth         | Bin 0 -> 2064 bytes
 .../secure-boot-secrets/files/PK.crt          |  19 +++++++++
 .../secure-boot-secrets/files/PK.esl          | Bin 0 -> 837 bytes
 .../secure-boot-secrets/files/PK.key          |  28 +++++++++++++
 .../files/PkKek-1-snakeoil.key                |  27 -------------
 .../files/PkKek-1-snakeoil.pem                |  21 ----------
 .../secure-boot-secrets/files/db.auth         | Bin 0 -> 2067 bytes
 .../secure-boot-secrets/files/db.crt          |  19 +++++++++
 .../secure-boot-secrets/files/db.esl          | Bin 0 -> 837 bytes
 .../secure-boot-secrets/files/db.key          |  28 +++++++++++++
 .../secure-boot-secrets.inc                   |  37 ++++++++++++++----
 .../secure-boot-snakeoil_0.1.bb               |   5 ++-
 17 files changed, 174 insertions(+), 59 deletions(-)
 create mode 100644 recipes-devtools/secure-boot-secrets/files/KEK.auth
 create mode 100644 recipes-devtools/secure-boot-secrets/files/KEK.crt
 create mode 100644 recipes-devtools/secure-boot-secrets/files/KEK.esl
 create mode 100644 recipes-devtools/secure-boot-secrets/files/KEK.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PK.auth
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PK.crt
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PK.esl
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PK.key
 delete mode 100644 recipes-devtools/secure-boot-secrets/files/PkKek-1-snak=
eoil.key
 delete mode 100644 recipes-devtools/secure-boot-secrets/files/PkKek-1-snak=
eoil.pem
 create mode 100644 recipes-devtools/secure-boot-secrets/files/db.auth
 create mode 100644 recipes-devtools/secure-boot-secrets/files/db.crt
 create mode 100644 recipes-devtools/secure-boot-secrets/files/db.esl
 create mode 100644 recipes-devtools/secure-boot-secrets/files/db.key

diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_imag=
e.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
index 0c9b898..42e5b90 100644
--- a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
+++ b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
@@ -30,4 +30,4 @@ fi
=20
 keydir=3D/usr/share/secure-boot-secrets
=20
-sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --=
output $signed $signee
+sbsign --key ${keydir}/db.key --cert ${keydir}/db.crt --output $signed $si=
gnee
\ No newline at end of file
diff --git a/recipes-devtools/secure-boot-secrets/files/KEK.auth b/recipes-=
devtools/secure-boot-secrets/files/KEK.auth
new file mode 100644
index 0000000000000000000000000000000000000000..3127ddfd55edd8e07baf97df7fe=
3ea862b1c3d91
GIT binary patch
literal 2066
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
IArSGu0a%Gf%K!iX

literal 0
HcmV?d00001

diff --git a/recipes-devtools/secure-boot-secrets/files/KEK.crt b/recipes-d=
evtools/secure-boot-secrets/files/KEK.crt
new file mode 100644
index 0000000..9e30c92
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/KEK.crt
@@ -0,0 +1,19 @@
+-----BEGIN CERTIFICATE-----
+MIIDFzCCAf+gAwIBAgIUUm6UcyySbfo1Z0j6PE4vwh0VDpUwDQYJKoZIhvcNAQEL
+BQAwGzEZMBcGA1UEAwwQU0lFTUVOU19URVNUX0tFSzAeFw0yMjA3MTkxNDIxMjFa
+Fw0yMzA3MTkxNDIxMjFaMBsxGTAXBgNVBAMMEFNJRU1FTlNfVEVTVF9LRUswggEi
+MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDCqj+JxOHAVUEnTADr7ralBaoH
+UveJrC+kuEOKsp4f+LCaoEL2Y6jYH1GRp/jzqEmFfTx+BkI31axxOyaQWaTsY5vH
+ZPT60FnVCd+Rcv2FLi9sbaTZlEgR9EId1STUV6f9yVyUOdE0O304uA3lR716Dvqx
+KkxFW421p5mgA5ziOKFHCsz2xz0pj22D5C7tBYggzL4II3W27ZL72tlV9ml9s9aP
+ddM0/yyP7AnKT+vrm/vXbBoo0Su7/HTTQd2slGyTke0L/roW6Hp1BU5dLAzpmk8h
+w0/ae5LuRS/59Vp63yoB+Ub2dnoDYWbGoXWzLnMAlo+FGdl5bLvYXjuUHrl5AgMB
+AAGjUzBRMB0GA1UdDgQWBBSmLviEyla34oiK7m0VAd64YwQiJDAfBgNVHSMEGDAW
+gBSmLviEyla34oiK7m0VAd64YwQiJDAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
+DQEBCwUAA4IBAQB30i3lT+4VNyCzp0Pe16R2IShdq0GL93uA6jh62EzLWtiFknLC
+Wt6vgd3CvrohjzbOU8VLJDp9HGoCG1nQBUM+iI19MAE6jJMm3bBXhicE/52k8+1+
+pGxM022JjRZ9wzkyVPLZ0SWwnbgcExDAAyQaLXGdhGO5celuAv40mS86LKFh9hu7
+R1brjzebx7jb2YXdMal5SALYGvPtdM6DVxKhQuS/UeJDaS+rlRZraM7F2aaUXWHf
+mPyCAY2RMWLUKIIewzhA3ND+WmItyvDVd64UXG9B0AilL8x9nUwf5BQTbUFVqo1n
+B0XrHgFOwh55tCNTYqsXAkaqlg2xymdfBgZ5
+-----END CERTIFICATE-----
diff --git a/recipes-devtools/secure-boot-secrets/files/KEK.esl b/recipes-d=
evtools/secure-boot-secrets/files/KEK.esl
new file mode 100644
index 0000000000000000000000000000000000000000..3debd0f8c60d83fda677003b81b=
56f3f734371f4
GIT binary patch
literal 839
zcmZ1&d0^?2Da*aux2_hA(f&~6&ddM?+CW+m2$YnJja^)XOu{N=3D?J;O#7B^^O{J(&i
ziIIs(Bq(o6vCgF2U#96Ezij;U56O!1O*P<U<J4;NX#38~$jHsgU?6QMX&}zV9LmDX
zBM|KA>g(zk93SEu91`#C>TMt=3D&TC|3U~Xt>Xkuh&WEchH8Y6M>Yi?pxLbi;Nm4Ug5
zk)HwRJ}#yvMn;B1tL!_EJUkHUsP4n?`rWprtgG0AzIU$CU$VowYtuaW9~)*ZaQc?K
z;)Z<S#N|IeukdWGwW(usGQYZ}&{}Om<dQeZvyZ2I`E?=3DkD(C%)MSolM^mB5T+??Ve
z_{B-~s>+q{<$q7cOtHLZVqI&ogZHWX-YULd8?}5~qkFe5pSgf}&LfM3?p$ZS9k<o&
z&uxC9_m;Io;mke`<<f0$C;h&4GxS?#?dEI!rI$_q>-4|jJmvrT_3Yo*bEGsbYVZD2
za@q0jnkhMxC%)zWw@d6rRVk}qtPao1S^kQL{clxIdgrSD^J`SqeJ#eHZr{qPm=3Dn{E
zEiB!vSIjW2zg6;PWzOy!an@7hc2+VmGcqtP4mJohkOhXnEFX&)i^wv)A1$ZCwm<6V
zdY3E8cyC8Ci;{|gJV;uZMZ!R=3D0lNZzkOE;w#{Vp=3D2FySTIoN@53=3DDQghVo0gPyOGC
znk#Hx?tJh1k}^e&*wv2R->Vy5SybKdIURMQbyCrxsC(-h?;hH>OR?YVT<}qE6{}jA
zEGFs53#`s|9lf;%j8;99)$VQxZ&PRaKX=3DLJw{=3DT$d@kp9_KMXWwloU)bn~L>hPgXr
zgar;Tt4Qe<&TUEFS@<%K>7U6=3DeJh=3DXiQlAmyNA8*H=3Dlic$L*V~cMVrodNAFP`uw)!
zTywb4LZ>JD10OkO>aU(EmYs3#=3D*?wQViWJr_|wGLJJB%dibj*%VGD;l7yd;h>7M#<
zwS1jOOupj<j-~o%YUldMKM@hmbqrnAo6hd~T8`20kX+>!<=3D~{%;!JL<rtxk(l^)N=3D
GRtW$zSy9pe

literal 0
HcmV?d00001

diff --git a/recipes-devtools/secure-boot-secrets/files/KEK.key b/recipes-d=
evtools/secure-boot-secrets/files/KEK.key
new file mode 100644
index 0000000..d5e015c
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/KEK.key
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDCqj+JxOHAVUEn
+TADr7ralBaoHUveJrC+kuEOKsp4f+LCaoEL2Y6jYH1GRp/jzqEmFfTx+BkI31axx
+OyaQWaTsY5vHZPT60FnVCd+Rcv2FLi9sbaTZlEgR9EId1STUV6f9yVyUOdE0O304
+uA3lR716DvqxKkxFW421p5mgA5ziOKFHCsz2xz0pj22D5C7tBYggzL4II3W27ZL7
+2tlV9ml9s9aPddM0/yyP7AnKT+vrm/vXbBoo0Su7/HTTQd2slGyTke0L/roW6Hp1
+BU5dLAzpmk8hw0/ae5LuRS/59Vp63yoB+Ub2dnoDYWbGoXWzLnMAlo+FGdl5bLvY
+XjuUHrl5AgMBAAECggEAEElEFZemN3wqfkoqjZKkLzxBFGnJkfgY6FQOOo1lE1Gw
+HM+pqol9987u+RuvhVsgA44NwJFvetJiofqL6GnHlYtj3hPBNza1PVCdJsMTGNBb
+YVvu/dEdEnt4CJzrfuRyhpYRK8mGijMr79HeP793x713FdlvFiJpwbfq72s99eMX
+dyV6oBXfwYRNs/NVzJtoADEKSdx9WbqEQX1LDH9uqLtrsWEipWRV53F/AmLAjEPF
+3KdK0Yq7JqVLEXig96Dg7d77N/cnXa3ynBKhA2rQrCaJMFWkmSBOUhUNyUFJ0WJe
+pmF80g4Qkljl+usE82uDgLgEsFOQbynDCNA8f3YQfQKBgQD3IVJKbyYAv97wtD7x
+QCqlZyRPElv6cEZm2t9+YA65/In8GAke7m8a+wW6VhxyH3FPsEyyDXTJNAo1LNSp
+ARyQ6QCYrxsCmkQaIrLuvnnbZrfFUsTp1uXS7psryZQeT+CP+pNV1olaZOJtqT7S
+XIo3HgPeEiqH6J6zvUcaqyRd7wKBgQDJpt4DLjITNtdqow4SNbFxhXT1eleCdL31
+LLjYDV4VX7raGjF0JV4A4IS1JlVsHdvarr/PiE8jq0UK/rsoPQHkyFAxcP7T+bWX
+Xit6F0HOk8bh0ygwYNQzNf5YH22OxwXiORHYHs+iDRUEy7mUnFPiaqY8tVzROmtp
+5N7yPANHFwKBgBBYvOe9iGb+ShHj6lHs66U7OFSeo0TijlWZXrUuR2sYAEyTjm7k
+WKcROaTEs2b9G3Ko97nDWBlC/vXbfEmdkDUppGd1FbVLXPvZlbpjEQ5pMfi0a+AH
+3fXg4JS55blHkVQUwBAqe7Vl/PBCBKzHgED7FEhpLTUGNxEukPh7n5EzAoGASiT5
+4s98iAYVJNd5WAa4DNaWT6BBRu1n3xsniAE6Q7+kM4eIAX2v18C16umCZTOBYCH6
+0vL6rlHOHCHXbQ8pgBaLLfKvL//T3ik48TZV8v/xE52RXGBuBbpnn71GikXxiuGT
+BxUlIR+QR+gkf1kPmuO95fqFe0Tws8n8k7KvPdcCgYA6ThU4MXo5VY540TiKkkYy
+cz6nJRPXea8UCjHl0KoYzRxWBn18uCUla64pG2s5c94RwPACWRdIkpDdXxcWQVMl
+ZT7jNGnq0njRMh/VXyKnZMwgYrw564ESNVWcysgDNvgmohNSImP8uQo1IRQcIdY5
+8jh7DDlNxlV3iwRuFyTKGw=3D=3D
+-----END PRIVATE KEY-----
diff --git a/recipes-devtools/secure-boot-secrets/files/PK.auth b/recipes-d=
evtools/secure-boot-secrets/files/PK.auth
new file mode 100644
index 0000000000000000000000000000000000000000..75bd8f298420452a1d8b33ae6ac=
a6e9cf8dc7e9b
GIT binary patch
literal 2064
zcmaFH&Mqt<D#`!@yIFuNrjLAcFRk~wpYhJKYo$r8d06UlgC>^wOpJ_%{06*ioC$3n
zjH%2lOpL4y2Hb3%T5TR}-+39?85cA$OBysWiyAaB{$0S##K^=3DXlA;}IX}MH*v43Zj
z+R5*`lO4X~MS_fg>S5#t8X;vUVIaoF9LmDX!yoMF>g(zk93SEu91<VkZ6GJkYh+|#
zZfI#}Vq|D!7zN}SBXRNSZDLeHwhHK4<|amd2B7P>n3@<F8CHn49c(?&q}}SJbjRp{
z{F(dZ5@G%~Q+zbe&h)r8F)^-aP15B4D>bh!?VkJX#WQvu&9#kd?0?H|z7r#TEcUwQ
zvpDZ|lSapxE!k=3D5dqgF--MX_UU53rkK{+fe#&!S9UkP>6cK$I2RmP`2?0>b!z30;I
z3_EYm+_e|9=3DPkYPL?_fiamEp`jq}-@gkGL#vt^razB=3DG|>xB6~uPD3?V9FCOF8yO6
zcvU5HdfcR)0@wdCJ?*!&wYKaPS9-EmxLW&o@}6a_dwR8^WFsbfr}G=3Df-;h4#`S@kS
z?2QctPdiy}mfyKi=3D2$#e^5(;h25;vt>@zx85EZBJ^JUO}n^)V?61Q%9B~s7C%*epF
zIM^W2Ko%JKvV1IJEFzOG*StMB@8go~8-KnlE>5wi-SpnXKprHm%mR$12J8y>K?;N!
z8UM4e8ZZMX<X{KJFfiB|8IlwZ2VSz^xw!d6VPDSqZE^nBs=3D9PSZ=3D_h8-g{g6f_3RU
z%}J{n`+5^Ib@P<+Rg$>=3DvT#_ve5WMB#P+8%dsa?(<)i8E_SB{-Z{Kn4@4Xq{bOTmz
zGMH}15$CCXVcEt_zy3d5Zo#c$s9wB1Ezf%H<{vuKOg>Agom-@0e*0sCNnT(3&Yb`4
z9`P}0pWkirn$NbxU|Z9=3D75qn>HQx7i#df@%b7{}Ii)-KS$QH2JuO=3Dw!oBq5a$>{O1
z&8a5#K91G-wr?IceU$uQ9dhpDXK8^qX6_5trqyh?6Rz#{oo}|dP(#Ix`r>|B=3DeQ?V
zCQUWwZLW%cdCExR5!3DW;^noM_o(l(Sr=3D;9#25=3DqdXd0fWMG6Z-QvzP$oUQ_4*?T4
zOA{jlfB(f}Z?dbJs$vc#PyAdRS+MT8&TnUyy2(e|JrfG~#FIN*V&dv;r^Ndt*1Ab;
zUR_kX=3D((cNMK<Y^Uwrrf)tBWuWMMziaSzuIdxwv&`)?GlK4T>|&%W;8Wr@j8-%S*^
zI<@0x_L=3DT8fw?o?D!v|QPw`ll9=3DhO(%n~bC;awS%>gNhdPWyd7BGz(M{o?d~*NujL
zd-vW-Vd#^oIMo?z`F4>~Y<{+w!6V};>HB@n>u;@}$Yt@Z(o&Wsz-jk`T!*VwPyej!
z|Freo%J$9;r;jOJ;t&rER@E?I;8?xrskEDs%2DYBpP23ys~>tlk2A&O`|DKR3DSSR
zEB+S`WIJspwximoePQH*rB9|T_iEp|S~N!cLy;>pq)^iY(t<#sq-1RD;v!@cRxxYO
PXel*XN{yCMSV}1Xh66(<

literal 0
HcmV?d00001

diff --git a/recipes-devtools/secure-boot-secrets/files/PK.crt b/recipes-de=
vtools/secure-boot-secrets/files/PK.crt
new file mode 100644
index 0000000..b775cd9
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/PK.crt
@@ -0,0 +1,19 @@
+-----BEGIN CERTIFICATE-----
+MIIDFTCCAf2gAwIBAgIUZCtVOTmlE6NPiVomyfe7Y0D0blkwDQYJKoZIhvcNAQEL
+BQAwGjEYMBYGA1UEAwwPU0lFTUVOU19URVNUX1BLMB4XDTIyMDcxOTE0MjEyMVoX
+DTIzMDcxOTE0MjEyMVowGjEYMBYGA1UEAwwPU0lFTUVOU19URVNUX1BLMIIBIjAN
+BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqBWGwYXAgiuFSiLcMuAfzN93GFZP
+2WRMKM2ZSNaRYV5yrGKTj9R86tK7nfbo5gcMKa2BrD/7H7PcXBvGXdcp5l5LhzSB
+QZmEa2ZnvBUZttrcvGccBkFAI1ZWXEW/mfpgfhs+T1wwejPK8L/qrEeM0rtoPksJ
+ba3QK56l0OQsVUAhmMQWsZ8GQhLpyIY9Bp83q1DHhZCf+dQg7VACbhdzdfw4EdUk
+aZdekrkQ1/0C5Y85PTs5jRci5K0TeyvHY7ymhbyNKlodWJNLZw8zX9gbyknj6YCb
+sYBw5YkF2Xfc2HZBc50Z2eGxMO2foY4ywXBaXiD56VK/POq2ZmG1tuoUfwIDAQAB
+o1MwUTAdBgNVHQ4EFgQUktN87cme8aS3sfnuc3NkOH2y7zQwHwYDVR0jBBgwFoAU
+ktN87cme8aS3sfnuc3NkOH2y7zQwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0B
+AQsFAAOCAQEAYiDDUdI4DNGzyHGObM+2Xk/WeoosVdhkOzXe7XXoBaWeKZKrAY6N
+YWktbiJvJGIK/QQIOunuIhQCBvyJa5psV3nil+68fWUjt7jW/d6Y9i1Qq7Iwlz4I
+Xkkn0Kaxsvr/4ac4CyQxJ3O3Zm47nbP4LJY08xomzqIkN9vxgDRujoe5bP+HSF9c
+ZvPuskqfBqQwtoKuqA/EQyjvjopdiO2c0ryu0a3vuGsQOL8mERVNZ+d4YjLjxrNl
+ND9MQXtvPezjgvEZ8DtUzvHzGxDsNkegrWZ8sNxXK0b3DpsXEoB4mH9zjx1DXuTU
+kpUzDYN6X+nKMijiAtvvF3d907wnujyuVQ=3D=3D
+-----END CERTIFICATE-----
diff --git a/recipes-devtools/secure-boot-secrets/files/PK.esl b/recipes-de=
vtools/secure-boot-secrets/files/PK.esl
new file mode 100644
index 0000000000000000000000000000000000000000..acd616b5ce5fa5fedfcd0a77334=
821fc834f1a88
GIT binary patch
literal 837
zcmZ1&d0^?2Da*aux2_hA(f&~6%FF-;nm}3*2$YnJja^)XOu{N=3D?J;O#7By&M{JVge
ziIIs(Bt<*a(sHTrV*k!4wUgg>Cp&z}i!|V6<J4;NX#38~$jHsgU?62EVIaoF9LmDX
z!yoMF>g(zk93SEu91<VkZ6GJkYh+|#ZfI#}Vq|D!7zN}SBXRNSZDLeHwu+IJfw_s1
zp8@DPE~X|%MurulZ3kNqG-<bbDcv!8Ab;k5xkQ-%%@iMvvok%eO-zg{T9Y)n|4PlP
zOS|WOd-05&M{{lC8vEb!oA1O(AB(-N`7F-6-K5cRW=3DnQj`W{iqZMW|1Nta=3DBbWjcp
zi*emQ^H)Nhw4Hy9L6z~T5Bp!OaqqdbJHyVKGk5I;?RiTtJkbetP@Hi@Y~y@3C!v=3Do
z+HBe8o39Qy-a29a&npUV1DNu}i%b7l2wqjmoE|r6r@-~UOi%kQZLKYP#g(3{6|UAk
zp1fyS>z-b%DA|a~-s$|t@i(MTc|LyGFneP|!P8FGo8@<IlsOj9mAv_Iqruzx3;T=3D?
z7DUA<{CpX--{#e}w8X93UWwE*F*7nSE)F&bG>`>`zAPV$7>mfH%QbIL&ilAz`^KN|
zii=3DY$YB#+%F^~sIE3*J&sR6qJevkrTM#ldvtOm?L3OU$;F$@fLMusGX!-1D9crI=3D}
zQP`Jrep{UXwW=3D<i&>Jb%ruW{KzF=3DKCPjk|0#=3DhRfOx--Ce3c}wzbqV9FW)JNFtPpV
z%$}7KUioPHyFIn3%G-Bb`+IN3H{F2Mn+&Ggam0D5Us$$r)35&zms@bF7^)X<Ps_8O
zyZMLCG?UL#YUdWInBV@`V3OC@zBA{4yGMLX+UIwhyymklG1%6$ZUz4lXN~uLU9lZ+
z=3DUm#e?&8|_JF*2V_Nxhs`ldgxNHThSY;&rKy^mvczU`aGO&=3DvcScjbZ_*q)ujhXv`
zwP`gQ?u2W*edn7kF4RylqrSLb);aFUl}S^Ld7G=3D^U!F43c*J!3y?A-;<vr@VY}SPW
E037I59smFU

literal 0
HcmV?d00001

diff --git a/recipes-devtools/secure-boot-secrets/files/PK.key b/recipes-de=
vtools/secure-boot-secrets/files/PK.key
new file mode 100644
index 0000000..8241b95
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/PK.key
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCoFYbBhcCCK4VK
+Itwy4B/M33cYVk/ZZEwozZlI1pFhXnKsYpOP1Hzq0rud9ujmBwwprYGsP/sfs9xc
+G8Zd1ynmXkuHNIFBmYRrZme8FRm22ty8ZxwGQUAjVlZcRb+Z+mB+Gz5PXDB6M8rw
+v+qsR4zSu2g+SwltrdArnqXQ5CxVQCGYxBaxnwZCEunIhj0GnzerUMeFkJ/51CDt
+UAJuF3N1/DgR1SRpl16SuRDX/QLljzk9OzmNFyLkrRN7K8djvKaFvI0qWh1Yk0tn
+DzNf2BvKSePpgJuxgHDliQXZd9zYdkFznRnZ4bEw7Z+hjjLBcFpeIPnpUr886rZm
+YbW26hR/AgMBAAECggEBAID06wuEu7ri+wNzFXAvBhbgB/ZzGhYW3lubyhPZE3cZ
+yG87vizmgOSEw48hRXReSdWcGdX2zIt5KgK9CIcssifdhqL4BIc46iCgU8w4gB8L
+cblWfmjKHRQ/hEiM9sCDGQ8HhdnLSCIppHTrOXft+TwgrozEczpj1UfyExPeS6kn
+KKT6qYroBDI6019YyGnsUXAldvweoFb8apkNXQr41PJsdv00FZC+VnM96GHKle4o
+TKPqfPMV9UTuYlCVbNhGmS17C5qZUdPhqlPnGjBzKO0SmwDF4GDKr2q8oVHrfGKs
+tgaUeoDI8NAYpMahaLvP+aM/gEEDZKguGwzk7FQaNGECgYEA3+VrKaM95QVwElIS
+UGZY6qiXER9I1vFjAd96i0MF7KYVSRBvLc2L/kvh/m9TVYosM6PziI45jhkfs19p
+r6DZiWl7tXY3vRzF2L+14ST8nlmkDe2GiYkGP3W2EXUwW4eORK1FvJdGJMsByplG
+66u19qWFO9A4r68Uiwu4wJalQU8CgYEAwC9oWamopJaZzSbachkn2jz94/1rkf8/
+ggNPZgyeFb3GT52/0ocb8UV3/f++qQKfVeDuM2X4wI0SkJlVXTRHv2xhYZcjpDkT
+fS9VIrgo4yjfL1N1KNY7EayySG6zzrwewHsoxxahjFJSeFZQK6QkB0aTbP/1DZsx
+SJv3o4A1TdECgYBzOP7IQ9EzjnPZidEQ/UrfIHn1/tKeg0U/joHjL0/aNLKZklKV
+EMXtzaF1LleFmwEaZlKLQR5PiZBt4Dlkf/PTqqxWe4s90JPk8uwn/L/gwiMSY92r
+5A+KEwrquxNy1zUZFM7hujwH7U1ztSPxXsHbN910Jbk2eHSrBhJDUoOjMwKBgBJK
+8OXH7lNsOkt6rUQ6/L4bHBd9YaXN49+eLQqLnOh43c1qOH3zekdm01sL4rv3ke78
+r++YfyrkwqWc0rFCbqnbyREe77eL7zz1KmdZnBqzIzs/+GDgs1KlW3rlfpvo8Axm
+LKV2k/3lQBBQNuVQhFVk9FdlrY+T/AbrQZEAfRJhAoGBAIUM6deAiamqsr9CAD99
+mwUbZIzQVQ/yaa4oNZGaF+SX/ZVkbUqC0p7eUWXn3g5FcOafM+uS8FPh/pakpLve
+ZcMd1N8FaPPChKbKnOECouw6ZZAo68W7L800Z3nxr2aCigcWGk0mKt+mth3AwAet
+Um0CSV1HpOZ3XD85/IvfKtxh
+-----END PRIVATE KEY-----
diff --git a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.ke=
y b/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key
deleted file mode 100644
index 193de62..0000000
--- a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key
+++ /dev/null
@@ -1,27 +0,0 @@
------BEGIN RSA PRIVATE KEY-----
-MIIEowIBAAKCAQEAyIuuXei5qIw+UvavLxPyyNhx0G6Ijuf9SqxVXOpKcQ+l3ZCc
-KQaCLWCH0pbPQj587zVjgMUd4SHgXdVP6awDz8b0NcLgyzF31pHBmmB3z55nv2Jb
-gI56bix9TEHLpoDs4+cWAb2WZPkW8rV/6YR+xVuE8fi9aAWJ7H4dwUhPzU7RBB1d
-Z1wF6Wv3b8nn1jJa5W8I3zOd+tpWczOsqyRnDnFhMiOulGAiFTtmIXv2VReQf7Tx
-rXdqAAs9dcS3qizzNVgY5XpABtmYu1AjyLwwqXZ+blZ2tmUUJicgw3YdCWtlTAtf
-XZDHf+ZzgCNtTvhb2DzpAVmF/H+A8w8lUJZiBQIDAQABAoIBABET/BRZNj5JOyF7
-im2a6Ej8TazvTMfGr8ZFKLvR4+b+6yQUJYhE2p8colRnrVy5z4/bXw7fOm0qol27
-RaPjlyuBiNhvMQ98tfTa0r7fyjQvDCy7JomrGHf7Z+wvijUys3mw+ynIyF7u62pd
-1HfBZb5OzeKBSTfriNRP5R7JlqooDl+O9JVlnvlJIaFe1rX2sQxZ7F8gVINKIJDv
-n7ZZ0o351uIMjKLqwmliULPTjZ2ZeeJqnkB0pFcWZzEf2wAnrrglYRdnn10oNzhB
-6cXMHJeuEOedXECLZtmynRw1dWZK9+Xku1jEAqTWAoI0OIjrfYYzntwe/kab8w/R
-T7ojFGECgYEA9rGhtmSQiim2h+3iGyXNTEQiEOFFL7E8/1ibfWi3vzDhoLARrnH1
-p45DPgnL664xLHXIUl6/wto79Ij/2qA9mp054nVJ4X4AQgq3xCT/57nL0QHfQLaa
-VdzNIoz4jJT3cO0gYcBAK4Bg+dGGQ6ZUrRRt6VkHG/W6fW0D1e7PnEkCgYEA0Bxj
-Jr4ShNXb7J4YDQ24uSwmc2E1IgX5FjHu/JMKCiyIDWQkrxtVdIL9v6+kmYecyxFJ
-S3Qyr3ZqOHqwN1svYuB/CHyKg6dHrzJyZFTj8cr8h0ZKLDu2xZNFxfBIjn5vitSX
-W9q3477oFG/30Ew12Yee4NhDQkaEuB/Ic9+yv90CgYB2y00rLrwnvDSIunXiSs7U
-xg59gG03rSrJb5rYxj+NkvVj0sWA8qGwASLCUidfo69MUJ+ZgsTnCP5MIFjMp9Ni
-jAne0ko0it+G7fBWRNbyeJb8W+FtIUGqzTv/QlFCKU4KlDW+vLxp9lU8l7gHBabK
-/gZ7kwKIZUlbss5hC7Hv+QKBgQCsQBLBKmlhkTEqs9/sTgMrISPiM/8qXg9BE6tf
-WsTgjuM9UjoaxWEBwroMQnDWsqxQV8p2rYKWQEjC3qmj59Fc4bvDZnGvbnGizPpp
-mOniY8SIouEZo4MwHSmPH8auSnBAVJ3C5VF3K7gj0lknCy03E02phNaGsJ+BVq0v
-W2Qz8QKBgEB5RKiwJhgGQA2o+NJKKUUCDM9iBsO1Yy3QwtDWioKKcdAkxdTg3xR+
-XtJdXq6MkCMWM5em3v6GHPceexn81FZTxGBbIMBYNp0Sp4qs/3lK64ln8m5Qttxe
-70HVtrp9HhG5oFJ3fUuLPcYpE2GMgPM9fIbAWh9GZ4GpTLuPRtWg
------END RSA PRIVATE KEY-----
diff --git a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pe=
m b/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem
deleted file mode 100644
index dd02a82..0000000
--- a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem
+++ /dev/null
@@ -1,21 +0,0 @@
------BEGIN CERTIFICATE-----
-MIIDdzCCAl+gAwIBAgIULTs+L+8XzClMGhAvyFIdsp/PYgUwDQYJKoZIhvcNAQEL
-BQAwSjELMAkGA1UEBhMCVVMxETAPBgNVBAgMCENvbG9yYWRvMRUwEwYDVQQHDAxG
-b3J0IENvbGxpbnMxETAPBgNVBAoMCFNuYWtlT2lsMCAXDTIwMDkwNzE4NDMyMloY
-DzIxMjAwODE0MTg0MzIyWjBKMQswCQYDVQQGEwJVUzERMA8GA1UECAwIQ29sb3Jh
-ZG8xFTATBgNVBAcMDEZvcnQgQ29sbGluczERMA8GA1UECgwIU25ha2VPaWwwggEi
-MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIi65d6LmojD5S9q8vE/LI2HHQ
-boiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd1U/prAPPxvQ1
-wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+RbytX/phH7FW4Tx
-+L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZzM6yrJGcOcWEy
-I66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7UCPIvDCpdn5u
-Vna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4DzDyVQlmIFAgMB
-AAGjUzBRMB0GA1UdDgQWBBRjuNXuXfh7mi8I3eTboeYGyFTa2zAfBgNVHSMEGDAW
-gBRjuNXuXfh7mi8I3eTboeYGyFTa2zAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
-DQEBCwUAA4IBAQBW2ckn0APqBnwSiOXCWkMCnvY7K7UOfxAlotEsMFSrkzdEa4IE
-sn0+A3RV/r3HZGqIaE8GMsBqp8UiVIbL5H67dkqvJEke94/7wEUC16JSSOBc0Mac
-HeArDWsL/WIbzKiVcRrmgX+XwJFlsUN5UtR/feTHR08yiy5srSCIJEqli/cTrOxS
-JAgvWPLxcoFhOKf6Mi+nwWdrQEbpXvvv8Jv/qyyz5e/VmTRY0wIVmUjd+Yseu+5M
-3+cpKtlYaawMxVni5RibA0A12fm+i60fGPrkCNhascUrNY+Oppaf/h+QmKOwEM7h
-pqKXyGFQyU6dB6cFBQ/uD5IABUYuEOuL7VFY
------END CERTIFICATE-----
diff --git a/recipes-devtools/secure-boot-secrets/files/db.auth b/recipes-d=
evtools/secure-boot-secrets/files/db.auth
new file mode 100644
index 0000000000000000000000000000000000000000..a385ee08c9cc40761f9f0f52e0b=
4ff9d48b87770
GIT binary patch
literal 2067
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
Paf;{kpd$s2M~?siFKstz

literal 0
HcmV?d00001

diff --git a/recipes-devtools/secure-boot-secrets/files/db.crt b/recipes-de=
vtools/secure-boot-secrets/files/db.crt
new file mode 100644
index 0000000..d8016c0
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/db.crt
@@ -0,0 +1,19 @@
+-----BEGIN CERTIFICATE-----
+MIIDFTCCAf2gAwIBAgIULYM1S6ThMZcCNiIfnfnXYA/n4awwDQYJKoZIhvcNAQEL
+BQAwGjEYMBYGA1UEAwwPU0lFTUVOU19URVNUX2RiMB4XDTIyMDcxOTE0MjEyMloX
+DTIzMDcxOTE0MjEyMlowGjEYMBYGA1UEAwwPU0lFTUVOU19URVNUX2RiMIIBIjAN
+BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAp0S/0yPuxYYZIIyrwOCT2Z7u+nxv
+6jn1TF8XOZBLqm0LlBL0tjC4NHS/6leQgtKbFs/M/FpBv0OCHDRCpMaNK6ogTHI/
+ScStINv2TCtKICjY7yeOvzrvX88wxZ3l1c1oc+NFVCwz3ylnPwpHzmi8nI6JZ/1i
+sYXr9wTMOW/SgLU9PHdIdipnEhDayxtTPS+7/DX5tdctcKeUNSxCwdB8dpXZIF7D
+W2dfgCupRS0I5LTfrpo/Jem2Rj+PshPhsssNGhEbai7mX3WPMzV4V6i6gDV8Ii4X
+yZLSuR2EuuOHAO+Ykvtt1Vktf93C0FuOyF9GeENx0RPJzcGMBRZVA0oowQIDAQAB
+o1MwUTAdBgNVHQ4EFgQUalXGEWO9XH5ZjrGZ2D8QT4Izx9YwHwYDVR0jBBgwFoAU
+alXGEWO9XH5ZjrGZ2D8QT4Izx9YwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0B
+AQsFAAOCAQEAmT8QcOkRMZKi2ojfrXGmhommCJaHZcRF7BzmiOP5tyJORccLRXCl
+05zLoW8JJSZmgXlEvWpVEA4LU4JtrhpCG2dqEbotKmkDI8oAVWAzlbraItJfk6L1
+pkB4AAd51TMF8Z6D5yOLnvfjiEm6kGEwt1lE4NmJKb20NHV3vDNjC4vbmWKxg465
+901TLYpZthTRLp1y4Gu3MI5USxn66hJLOqDijvSVYkGpemeLwOzNG8SNYZGXj7KD
+OsKdmTm2E0J6QT4MRgrVLvbiYpKiXy1QEVPazXYtJ88vagQjLDrQ9VlyyPUnpaxK
+2WI9S2rU2EHqFrTmu8skQZRJl1LEcEHFxA=3D=3D
+-----END CERTIFICATE-----
diff --git a/recipes-devtools/secure-boot-secrets/files/db.esl b/recipes-de=
vtools/secure-boot-secrets/files/db.esl
new file mode 100644
index 0000000000000000000000000000000000000000..644357bedea2acb605e9f3abbd9=
7423133844c0c
GIT binary patch
literal 837
zcmZ1&d0^?2Da*aux2_hA(f&~6%FF-;nm}3*2$YnJja^)XOu{N=3D?J;O#7By&M{JVge
ziIIs(M7P=3D0d&xt?=3D}cxy@^gP)PvC$4aE$>k8>d#AN85K^Mn-N{1_LQW2?H@U=3D1>-9
z9{ylYS6^4Z;P?>N;E?!~Bm+5dULzv|b3;o*6C*<-qbMNP7>SElZxf>uvQ><%49rc8
z{0u<XaWOS9GBPZ8*?(F2-O)Blg`U+19!$PD@7=3DGO{8yG=3Ded5I}CwQ;Q<(?w+Wt+hc
zlal?f!Y4Fcnk{zz%%3R7{mxA?CQeI^^=3DhwD@F}wQJhE2d_BS7GF9nSo@74SETfL7z
zZ*X+()2nAQiXXd%=3DosJEOt<H9KbNs*PG4vG-=3DvMLufMaLvCO~Ju+`S4+@nk@T}a^8
zY3X2F{oQ{|e{Q|5Td;hJsgBdZ3pHg^Zz{wcj!utn&|c}P%kgB({dKeKRbOs%v+v&|
z{BYB0UMWH8EWKy(rTxaH72zv(HJH{Y>4~45bZMt-%dW@m4DV-5`ki|<Qn&u@p$pM{
zC*s{IoC_}spFDf8hgB?;*-PUf6Eh<N<Kke0Km%D|=3D*#l4h_Q%dg&q@3-WyXF*|%}#
z4SNCqCgbDR4CF!5$}GTGYQV05AEZE-k?}tZs{u2RLJoFd3<HCmkzuC2K*38v!%2&7
zb=3D+TDxU8*n8OOBt)FZBMWS(_A{<&Sr&-FOBYr)dXb51YJ=3DTucoYpitHn-wa+#~s|1
zyH3hUIz3Bpm#$VOv+^m1&;;YDyKX66il4mb>oSK52KLIU#;hObH9uGGp7;H6hv%*d
zi3ZyvT^`)*)ZDwpq_ljGaWZ%J?U_j%oBMWt_YKzVirgl0QEzV1gY4}FeIeeGzg`J>
zTP=3D9h_ho95<I1Y^?gMYmN+0P>oH)IIQ?u2fxic-d2|HCe+VQw?UDf;cC~4B7c-;WO
z;9F<Qbk)!6XR#>jSY7xUS#;v7`qDLCH<N6=3Dv##85d?mK!+3wRSj#E6R2OTMJJbDBG
Di@!@P

literal 0
HcmV?d00001

diff --git a/recipes-devtools/secure-boot-secrets/files/db.key b/recipes-de=
vtools/secure-boot-secrets/files/db.key
new file mode 100644
index 0000000..46e130e
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/db.key
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCnRL/TI+7Fhhkg
+jKvA4JPZnu76fG/qOfVMXxc5kEuqbQuUEvS2MLg0dL/qV5CC0psWz8z8WkG/Q4Ic
+NEKkxo0rqiBMcj9JxK0g2/ZMK0ogKNjvJ46/Ou9fzzDFneXVzWhz40VULDPfKWc/
+CkfOaLycjoln/WKxhev3BMw5b9KAtT08d0h2KmcSENrLG1M9L7v8Nfm11y1wp5Q1
+LELB0Hx2ldkgXsNbZ1+AK6lFLQjktN+umj8l6bZGP4+yE+Gyyw0aERtqLuZfdY8z
+NXhXqLqANXwiLhfJktK5HYS644cA75iS+23VWS1/3cLQW47IX0Z4Q3HRE8nNwYwF
+FlUDSijBAgMBAAECggEBAJRVTV9qcCZOYx4QYYesILFOVlNf4sduGnBdq3Tq148N
+IMVxgf3HerNaDY89k/PP3KUAJqJrT/7TWSC135vMUAi21+mzLxi2B2oqZmLpyNR4
+JNkA1YAUPY9TZ8b33YganlSW6TZZ9K4kQ2EONtt+2jRj2sqTU+BmCPmIEaul1KE5
+qPaF5CbKVIIg8Jlkq8OuOLaCtaOq2iv7bOZFdoK6jCKNQA9dfGQPD6NgTtPXAX8f
+3iNeHtX+vfbUhsxqKsMeybWxYDTzjuV/zADvh66IPrjViIe4jS52f9jmKrdMe6fp
+GHmGVlZqkUtuE5aQTJOnQIxKqjJMv4TetXJrNa6WBiECgYEA2AnpfXnb0ONsD3Wz
+4TwXrY7OimbWgkBLXpWBDuxKmmCKdtac9l2g8USzZFqZ1svu7r07BUnGbziPtKCN
+Fn36UNRll75FmgZ12PcX9vwr2SnU4UaKWgBJCAVjJAIaqeysG+6TyB/gtFszqlhF
+OmGCa/o7vEVrTd4V1Dfv6rH25v0CgYEAxjVsDIbGb7eZ5v6Wi6XMq5ssO7MvFmhb
+LwSOMFX2lNRPOXYf3xRdkgzrdqVtvWvH2OnY7jy81IVa8OdJ7DFdLOkO2kBfb71/
+F8xyLlo6dWoOmTtBQ1GVfetwto6E9puaaP5x4n4CgRkt7X4j1HNSAOVIZ7m8wYaC
+QiAv4p+S7hUCgYEAgJ0mDDVH0AwUgP+pnyWPUxv5ihu/CLwOIrkOpDu4Dj/7LtSF
+jYYgEoK76bqma2HtVOQDBxrsr7oUk4whcop9QzGvaa808IV4EzrHYZqu4BIvUg4U
+v4/76nKKmx1FknP74oUeJb4UoErLb1YtoJv8cRwABA2v3COjCzxh8G8SdmECgYB4
++aI5AwmapjUJB9pa4ZdKJiuZRIQ46Pi+eclPNyiJLgwsxiwtvABgZAJTKCUSt/YC
+Lrh4sBmQnNQktQYpYve7sYOfMisNyFsJ637FS8ziXRkL7V6n9+OGN21T/yioW9Ci
+xKo90ys0IGonyhWUVc53PXoz1OmgNLjMI1kWuM61AQKBgB2+vLFr+uPsOoQE1KzY
+W2+NQAQzvixsESdrdl2p4r/VmF40kPbKyLtKx7/yUzWAblvYahB3T2Bb9Ppy4DhN
+1gTQYvi7rfdmEvNVo0cHAdUlhZZAkBF3sfRNZktKSrIf+lxJfCMVwrhRGkNko2ou
+8LlFqem938MnXqxlDCh1YQ9J
+-----END PRIVATE KEY-----
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b=
/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index f53435a..2a30f1e 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -13,20 +13,41 @@ inherit dpkg-raw
=20
 PROVIDES +=3D "secure-boot-secrets"
=20
-SB_KEY ??=3D ""
-SB_CERT ??=3D ""
+SB_PK ??=3D ""
+SB_KEK ??=3D ""
+SB_DB ??=3D ""
=20
-SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_KEY') if d.getVar('SB_KEY'=
) else '' }"
-SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_CERT') if d.getVar('SB_CER=
T') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_PK')+".auth" if d.getVar('=
SB_PK') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_PK')+".crt" if d.getVar('S=
B_PK') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_PK')+".esl" if d.getVar('S=
B_PK') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_PK')+".key" if d.getVar('S=
B_PK') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_KEK')+".auth" if d.getVar(=
'SB_KEK') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_KEK')+".crt" if d.getVar('=
SB_KEK') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_KEK')+".esl" if d.getVar('=
SB_KEK') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_KEK')+".key" if d.getVar('=
SB_KEK') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_DB')+".auth" if d.getVar('=
SB_DB') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_DB')+".crt" if d.getVar('S=
B_DB') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_DB')+".esl" if d.getVar('S=
B_DB') else '' }"
+SRC_URI_append =3D " ${@ "file://"+d.getVar('SB_DB')+".key" if d.getVar('S=
B_DB') else '' }"
=20
 do_install() {
-    if [ -z ${SB_KEY} ] || [ -z ${SB_CERT} ]; then
-        bbfatal "You must set SB_KEY and SB_CERT and provide the required =
files as artifacts to this recipe"
+    if [ -z ${SB_PK} ] || [ -z ${SB_KEK} || [ -z ${SB_DB}]; then
+        bbfatal "You must set SB_PK, SB_KEK and SB_DB and provide the requ=
ired files as artifacts to this recipe"
     fi
     TARGET=3D${D}/usr/share/secure-boot-secrets
     install -d -m 0700 ${TARGET}
-    install -m 0700 ${WORKDIR}/${SB_KEY} ${TARGET}/secure-boot.key
-    install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem
+    install -m 0700 ${WORKDIR}/${SB_PK}.auth ${TARGET}/PK.auth
+    install -m 0700 ${WORKDIR}/${SB_PK}.crt ${TARGET}/PK.crt
+    install -m 0700 ${WORKDIR}/${SB_PK}.esl ${TARGET}/PK.esl
+    install -m 0700 ${WORKDIR}/${SB_PK}.key ${TARGET}/PK.key
+    install -m 0700 ${WORKDIR}/${SB_KEK}.auth ${TARGET}/KEK.auth
+    install -m 0700 ${WORKDIR}/${SB_KEK}.crt ${TARGET}/KEK.crt
+    install -m 0700 ${WORKDIR}/${SB_KEK}.esl ${TARGET}/KEK.esl
+    install -m 0700 ${WORKDIR}/${SB_KEK}.key ${TARGET}/KEK.key
+    install -m 0700 ${WORKDIR}/${SB_DB}.auth ${TARGET}/db.auth
+    install -m 0700 ${WORKDIR}/${SB_DB}.crt ${TARGET}/db.crt
+    install -m 0700 ${WORKDIR}/${SB_DB}.esl ${TARGET}/db.esl
+    install -m 0700 ${WORKDIR}/${SB_DB}.key ${TARGET}/db.key
 }
=20
 do_prepare_build_append() {
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.=
bb b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
index 24a5352..b78f22f 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
@@ -11,7 +11,8 @@
=20
 require secure-boot-secrets.inc
=20
-SB_KEY =3D "PkKek-1-snakeoil.key"
-SB_CERT =3D "PkKek-1-snakeoil.pem"
+SB_PK ??=3D "PK"
+SB_KEK ??=3D "KEK"
+SB_DB ??=3D "db"
=20
 DEBIAN_CONFLICTS =3D "secure-boot-key"
--=20
2.30.2



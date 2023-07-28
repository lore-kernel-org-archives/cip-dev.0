Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9909CC0015E
	for <webhook@archiver.kernel.org>; Fri, 28 Jul 2023 14:33:57 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.47])
 by mx.groups.io with SMTP id smtpd.web10.33541.1690554831169870021
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jul 2023 07:33:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gdqfnPj3;
 spf=pass (domain: siemens.com, ip: 40.107.13.47, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj7fkIFz/Tj1p1HLoAeenjFYtPFbTOlj6wPUkRl/I2/T3GOeZ2Rwta/u/SixRJoLm4uDC/2RszdvoPPk/5GA5zeAJy+r8nzcug4T9m8SnR1NpBm9xTz0twv37I1QGpcicpMO2laMu+psiD+h9qUhVxENqGHIzxPDivy/5Df82PlMeA4KVjpDiDw+XHvMYWNrVXmMLUP2iUW3AxjrXBksgSa6rV8Nqan3xKw3l81eVAytHqXHoJ6r5d4h7Bg7Fa2CUzl9tqGiZMYWmUIjpy+YZk0VBIETu8ri+gbID0B0Z/ZNGnraBaiI2vwWzxfJ9pp6F/dFn89VSRdM06LYsRGDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD/WIM5aEkKeuL14mNIbiaWh0dx+43Voxqz6mXoCR/E=;
 b=LeVMLOIzDfP07ZcbS2mnyd4NTLfsMB3GqHxjwp8iqPgpvCaKaXTgW1c9hCG9YqFk9N565HYB+9EtJU0E8SpIokSXYq6HkyJ/1zhcEa0dVAMdN9cUkz4WoSic+qE+9eK+Y0XyinyaesTq1jGxV2urfxEqfzUrf1BUljj2BeSGXr2OCZbwD3Yc0KTPW1TTitx3WvPGqq6FQAnIKklORlakXf/8OiFpt/xHTpZM7XNFX8KLNQ4fcjHxDD9vuabwmdL9p1I/3FwVvFKmOKoeKFfnwiNRQrcg7v10dpJCgGZj1bgl/WshKemFJ5Oh8wbjDE2V7qtxgxyFMYxJd3SnoVmxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD/WIM5aEkKeuL14mNIbiaWh0dx+43Voxqz6mXoCR/E=;
 b=gdqfnPj3kOEeAi19ZLITWIgY7j9qA+07+VZehL1i/PEH7KdxPZZjEdNfAPSgs8CH8zCUuKZ1U9+ETMjpn3rR2jRULFJcuDyv03TtjBGBvXhqhZ4NnXY9caM1qD9zlL6JN7wKpoN3f7AoVwPOCGBwtPdTEgmOGexIUZG1IKiSBemWoMkIXoZSX0ud2WtwvaoQ821iknwCVwvnGMllHFLUNxMtcwTQRpnWuSa5I3hIQ34h38CcnTjBACMI+Gs2e9PeGffjFvh2eLU2r1V/7FuUAFhdrf5NeVi6V08zvYBaOjyS2zRPUgoEuKYvBH9NSgb1ihVCLCMZ8eVSy6VrhmqFBg==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB3151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:33:45 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b214:c3bf:bdd4:fd7a]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b214:c3bf:bdd4:fd7a%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:33:45 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>,
	"Sudler, Simon" <simon.sudler@siemens.com>, "Koch, Stefan"
	<stefan-koch@siemens.com>
Subject: [isar-cip-core][PATCH 0/4] initramfs-crypt-hook: Fix disk encryption
Thread-Topic: [isar-cip-core][PATCH 0/4] initramfs-crypt-hook: Fix disk
 encryption
Thread-Index: AQHZwWCDEkG67ru4pUeXK+3z6fP+qA==
Date: Fri, 28 Jul 2023 14:33:45 +0000
Message-ID: <20230728143320.3891194-1-stefan-koch@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.39.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|VI1PR10MB3151:EE_
x-ms-office365-filtering-correlation-id: 5955e3c0-6808-4bcb-f0ae-08db8f77a65d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CrDkYOYiMIIQxrHub4mdkLoYh8+j7YJGyihcPTkdDyWV2BA2QagaVelIitI7jZsBRqsYdWezFy1hCJ2cM99Idg7dFNmLBCPP0KzLjgIe02N6+U1FZdXJKefTBsPUxV568m/287XBnFLq1RqBQUz+fLIQD01hGsWc0+t4OmjThxwjRFJkFqB+gbqUlyxQ3iVjzB6xycCQLOoSe/XQowfs2cCT1KKRHUw6x4oh07uLEk8j1UVab2FOWSKsm/50Iv0/7c1odsqmNLX4h6U3IARddFyh7o+lNracTqvA3gd/+a0VYSSIYwD7Gpn2RAsgFzAEygu/cjimUM5X+xj57dWF89WAtIOBUeikVhUpZVna9Db3rxT31sb7GJ661hCmzXUPG3WFM5ZReOPsZGk1I9IA6b3369qiYBiXC78X4i3Lvk9RO6fFluj93GLrgkKh+7yLaDAomjk3jUiCJXXx62i5vWYuP/Hdoc11Pj6xyErEh5+JQmtIfmLqFboiqgfbnVE9sGbhWJfyZPFDX7/pkg+bzlmGiISyahR7MgBMx8JLF4hKFwKqO9AXMFGRCJ7/qrXwmnsQJG2eh/QzZWZmojcVYvQf56lIj7jt3tvyzN9IZsxNxD8nHwIONNaBNQlDr8Hr
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(1076003)(82960400001)(26005)(6506007)(478600001)(54906003)(186003)(107886003)(71200400001)(122000001)(6486002)(64756008)(66476007)(66446008)(4326008)(6916009)(2616005)(83380400001)(6512007)(38100700002)(66556008)(91956017)(76116006)(66946007)(5660300002)(41300700001)(38070700005)(316002)(2906002)(8936002)(8676002)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?yzWLppwrJ6sqJQJ2kjYHkIaVtZZWki1sQDE1voaZQ/EGxFtFa7wSxl3FPF?=
 =?iso-8859-1?Q?Rck2iXk0jEVoD7s3ko7BeqEnb0mfgmVNymnJkvPNbQw71J5ocsJ0vU8I8i?=
 =?iso-8859-1?Q?6OCyN3JMkRDz7JCUw5v8neMX56yirlXO+qF+8mQyUJPeEDYLYY+fmYvKTD?=
 =?iso-8859-1?Q?umC/ZKuHwr8CNMWCz0d09qux0j4HM4R+krz1cD8zrFVR/hl265xDh9pGMi?=
 =?iso-8859-1?Q?WwgfXkj10RemWYqmYUlbYnrR/lAMtg4/vpX6YccLRPZDNM6684G/eMWBC0?=
 =?iso-8859-1?Q?Vx93qvROkU9EgNQlZ5nBJeHTUJC3ZZMnbxZODXcdN72Irk2TUXfssE3jX0?=
 =?iso-8859-1?Q?EXvO4xdqEbsKcLgkM2zJQ5ESdmHKLfwsDusmCMUpGBgh+rP5Z3hRXngk0k?=
 =?iso-8859-1?Q?Bu274EgLfIL+R6QIAQoABCsS82LkAImXSTfYINmgkjyIV9pnidI6iYWgPr?=
 =?iso-8859-1?Q?itj2ZU6Knp2ypG2Zs+URbgc+2AmUTkXbAoQgEMvW13ySkiCx8DNz9WrzLv?=
 =?iso-8859-1?Q?RM5PbOQvxrZqony+J8mD4nGCs7SXTKTj+oc70jngYldkTNVP8zft5rjy22?=
 =?iso-8859-1?Q?MxszMfDLlg697gZECQROEKgpAgPWeaboVDEIXUsUoegYCuyUeu8VlyKtGI?=
 =?iso-8859-1?Q?ilT3+tH6HwYNb605Jn/jKapl1B8SH5w/i+uev159P6GLM2eELhZnj29QEH?=
 =?iso-8859-1?Q?p7Z9DFkwbqEAIdrI+jKrw5Ecd0QsDHlp+AL+yJEolcHR+I30K+nqykjpH9?=
 =?iso-8859-1?Q?ibsxEl7nSVvduPG7Vi13OLG6k4WHT9Iv3mPUyBoCd96moIBhdwpTksEO/H?=
 =?iso-8859-1?Q?6tSQL3Dk/XeQusln3CTRgzY17nQsFTi8UCaK+NDStmF21qGE6eLV/fp5WL?=
 =?iso-8859-1?Q?e5IO4qMRUI+k094vn570CUAYPnZKFzvdS3h1CSyi+ibTW0C+Ub3UeYXzfV?=
 =?iso-8859-1?Q?vi2hBnCdWMuRUebDe3qFdgZqwvg/orbGRcxzUGhc5qRNyBj892ZmoRwlU+?=
 =?iso-8859-1?Q?pXX4aEbgtDTyYkEii7Pk+eIMpWfzEWatgnpI803lUNg4J+r5EbvSU+qIry?=
 =?iso-8859-1?Q?J2qfqvKV13ulfL2oefuxZJUAalEgMmdvpjgq0Go9gfzFlE2twywpPGDbUo?=
 =?iso-8859-1?Q?vb7BdhKuSv1VQjf1RoYliJ7uJ443F6V8Dggp3EdnR7z3kfMNzLAdNUf0RM?=
 =?iso-8859-1?Q?mGktwgx75t8FoCH7fNMlPMcNzzztze/SqZ3xWzRajeUoAc7KD1WJJB3GGe?=
 =?iso-8859-1?Q?W59DOSl/kShvIUFREN0i/hrLbj3HGqTnyJiJ8aMAIIRhGCeqbiRuqTS/LV?=
 =?iso-8859-1?Q?6Mnak7uIixQFj/SoYbBavh+gxttKK46tt9g4q5ms70GAnTdN+ppttIiDZh?=
 =?iso-8859-1?Q?zxdyyXMgxEIb8tvuzqIykM3vXOMnn12uufRYgEDTUkzObUs1vZoj0G/HBs?=
 =?iso-8859-1?Q?BMnE5t6C/eXRFP4nDRFd7cdaFVM3fIhwJovAA92XO9hgUivgdaSD2ssUoV?=
 =?iso-8859-1?Q?d+qYAx7wCziydhyZYezCTM53CFnRrWxv0NK4ZpEFAQs5GM1+4K3kybTos1?=
 =?iso-8859-1?Q?JAp5LahisyeisiAlVebmJc9knRon/PB4VWNnmZaXacu+pE7FUy0woe0LVA?=
 =?iso-8859-1?Q?GWgtAE0RAmtU2yTx1PHZRlu4t8LMqKDQYew+872+0dMocUXftubLAVhg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5955e3c0-6808-4bcb-f0ae-08db8f77a65d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 14:33:45.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4qE+p4jQBwBKqD5iXG7ghHAzRQPxBQt9xKQ4c1bgDHGzZgrateIiq/URnWgt2bKkCDn6DVhqBYplKsQROks2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jul 2023 14:33:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12517

Hi

This is a patch set of 4 patches that will fix several issues with the init=
ramfs-crypt-hook.

- The most important patch avoids data loss in case of resize2fs failure. A=
t failure the disk encryption process will be aborted before any random dat=
a is written to the disk.

- A further patch checks and repairs the filesystem to prevent resize2fs fa=
ilure to ensure that resize2fs will succeed. So the mentioned disk encrypti=
on cancellation will not reached.

- Another patch fixes an error with libcryptsetup-token-systemd-tpm2.so whe=
n using systemd from bullseye-backports. The library is missing and is not =
needed there.
The patch ensures that the generation of the initrd continues and makes the=
 lib optional.

- The last patch avoids calling of a tiny mke2fs version from busybox, beca=
use the tiny mke2fs does not support the used -t parameter.
The tiny one resides at /bin/mke2fs, the full version resides at /sbin/mke2=
fs. So the full version is called explicit.

Best regards

Stefan

Stefan Koch (4):
  initramfs-crypt-hook: Avoid data loss in case of resize2fs failure
  initramfs-crypt-hook: Check and repair filesystem to prevent resize2fs
    failure
  initramfs-crypt-hook: Avoid calling of tiny mke2fs from busybox
  initramfs-crypt-hook: Fix error with
    libcryptsetup-token-systemd-tpm2.so

 .../files/encrypt_partition.systemd.hook                   | 2 +-
 .../files/encrypt_partition.systemd.script                 | 7 +++++--
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb       | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

--=20
2.39.2


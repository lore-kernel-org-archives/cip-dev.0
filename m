Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F07C38A2D
	for <webhook@archiver.kernel.org>; Mon, 24 Oct 2022 12:27:47 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.69])
 by mx.groups.io with SMTP id smtpd.web08.18475.1666614460636520290
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Oct 2022 05:27:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=sb+o/QLL;
 spf=pass (domain: siemens.com, ip: 40.107.22.69, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2A9gmXYR1/WURWzuc5vHBOtqnHkV4+NA2pYOXzFr/nTE/6Y105EIkbO2HXvWJ3Q5aGWswk+xYbU7PbKmXxEOnIJ7ARKa5j5/C6iFLP33oYlvbRvh8r7WxYst2/u+Lusr9oYCnhcNU/vWyOMqKFXJUuBDhqd+ux0cQxwDAmpQOSOJFw8mKGZo04GKQSx/yh2CCOS6urHrh3mwnu+Zx9jGJPOSKHbMfhN/rOew/5sGQmBuyg1YqTsDHep+EE+ZwiSF6nJgBpYiMq7Guo8w5pRJvHMcIJA6fSPU3o7S4E5QtiIeFiXyE7GdDQNo1aO1j3Pjs31ZjqOFw/t+5asqha1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jmn4Au/X5ouSz/IDi2kumT192wapBoMWQfCMVG8RgOA=;
 b=eHKHPAxOHcEnKG9x3aeznW0e+1xEoIwuj31Y5QDcMnGBaX519SGVhpmAfwQURWjl70UKt5FRUPd4gJ4yptI1j64XTsOgXnmuUWpj00JRCjSIRQlu6Ce0Afev93wCey57mTk/JW2qi+eZRqAgFfRxuE1P3gPBwx65Z91Fkyyhuhxb/RkbvJxc0CxQM5i6MtqGSQkc7lHZBlOp+CguNZnoFC2Z/O4znrZ/e91SBYe8Y9uejNp/wgPUTnmsniXCjQSglSOboTZHllnCwnx+9NSn7qy33qolJ33P0iLUBs/4swHzvMxlRwrlsEtzD5ETP+T4ywW1LI/Y+9T8oFjkWxArqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmn4Au/X5ouSz/IDi2kumT192wapBoMWQfCMVG8RgOA=;
 b=sb+o/QLLL8XIjkj95LcZrfwbpReZaMqeqhDAGDR3pMZBVDk/uuuwzJCfMMQSzJ0Ghhh7J0wbvE3RAXmMhPi1QRLfs7SkXNq3UM6PiPi5HqbkosKOBQLPWooGeROe9qmHJ6Cuz5R3WCEtL18BB6L8ip+vsD1XrPRMc/d2oA5MqXsOGPWMsZHVAxCmm6JWJ3NK7ZD6JqSKhsHiN7YFiqc/YXYT2WJTXg9Atjwkg7wiIC0FV3O18/8TumN/Cyv91mnevwgu3Y1kZ8ipx9B23ySIicNrAZv2DQ6fwBEz4miwTRGaMf9PbjImTgReV4zJMm1k2LZO6LP1c6BLyxsHNhw5Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by AM9PR10MB4038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.25; Mon, 24 Oct
 2022 12:27:37 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%8]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 12:27:37 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 0/8] Secureboot on QEMU with EDK2, OP-TEE and RPBM
Date: Mon, 24 Oct 2022 14:27:17 +0200
Message-ID: <20221024122725.383791-1-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0047.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::24) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|AM9PR10MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf2ac6e-aa41-4fec-1d7b-08dab5bb22c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AvUTjv+aiN4/NfU7renZfkCwK2ggtzjYlhv4ReKZaW8SHoDy83c0ap3sKJ4x/2URYt2WjqaOiFZNrSsF8AnSKHvp3GMZDDZtUN/bCaSXDvB1QNsob4IUXOdWrr3Aa5vPPiVBuag1tPVPmwlZutM3P00Jt744yp8xjW4Vq4qfjnSIjJ6dHGYQK8I4pcH8Up38p25AFMOIG3tJyfQtyKjC9A5wLzBww8U0UOiS1C3CqUTGJdQPvBgiXERzPSyHZDTM3zJb1ZETAY2YuuFwPRXTgfbDCXkCzPctSybo+mjG9Bcgd7BCZ5Ldofr+FinABbalPB5/v3wdG7qVdANIjGJzOqh7lNHOXuB869eLDVM/6Vkasi2IVYTy8x1xNu9N8tivUqx08h0aYGHUrEgbX71qxUIc3S/h2HFVDKR52QCgu58crB0t6weza4Dz1RPzlc/7+x/cRJc9a6/HgrZqrfHTmgtWpx4WT+E9b3kyjBi6TKNDaA9Yur+NhvonOD8qDc5KQWjMZ8EXJqjjptuSBG44QYyoO46lggl6neIb+MjQgxNlIdoI2lGbGzDkVh6DkmrVzIuEHCJBtYl2nzKZFI2j05nHrQ9CZds6I4LGVJbvJjBVKzsFkBeHTqYgW9izW8w7t14KPKONcq4CFJ+YfCbZleR8BwM2DhiTB3zSJtB/KDHSErnK7tLZ1j1kOThVkm6z
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(82960400001)(86362001)(4326008)(6486002)(8676002)(5660300002)(186003)(9686003)(66946007)(83380400001)(6512007)(478600001)(26005)(38100700002)(2906002)(36756003)(2616005)(8936002)(6666004)(316002)(6506007)(41300700001)(66556008)(66476007)(107886003)(1076003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7Dh2PTUxiZ5i6QO3eVE271c2sq4IVldVenNNsmx4hVoqlJ6ZybLmQOX3Aafk?=
 =?us-ascii?Q?/9qWeQ+tcxtkwd7v6X3qKLXQPZEFWuTnkeDyJTClFfEAMbRkW4sAWGJSak2P?=
 =?us-ascii?Q?XzWqZFbHdBgS2YnlkKJTS0E8l2ellGFNu4Mh6Yt/JT03NsqPydx1DoV7Hgu6?=
 =?us-ascii?Q?YLznWhH+qwLqrEc1lXdpU26hSHuO7+1GmJFybYFr7d+QbK6UNyo1wDZJ/tGA?=
 =?us-ascii?Q?VTHXK/C+tm0RfKiRYWLJxgFjfpGQzwZo3RNgDZEMYSm60l25sorBq8ty5eFf?=
 =?us-ascii?Q?qaj23mUy9WJv72L4zLLna9WBThQ87ygr8N2vUOBP8xKOrQFuXK9JPXcxgvCl?=
 =?us-ascii?Q?IOXq4dRtVQDvPRwZryQYyNoI/VdX7dw7rb8DPXS3NkdOk/8JWS/zqxpYyet1?=
 =?us-ascii?Q?PzY26bPmcFs6orAGqrxdiQIDXLcbqVs8hpqIhxl0vyjUhUufYOtRKps14FPE?=
 =?us-ascii?Q?kfv2TQMURHACGwXUVDupjMm/TsWLP3M+jwfnAkgq3cbTaxjW8UrVP3nwagkq?=
 =?us-ascii?Q?nvqE6xGROfTqFyYnPG7NNLQwyvRVgl8KUo+3W3gPetZVvX/a8+sOhYIDrv3t?=
 =?us-ascii?Q?iUzQQRpzLc0ogX9JgpbuNm0LgTWLhZJdobhwK0X1eSKUWxVzcGQop68kWzig?=
 =?us-ascii?Q?jTshxRGai6JSEfr9GoOH4N5YlSfQr/LGPdigQvNbmBJDKUSapKyIm7b5YKEt?=
 =?us-ascii?Q?NChbiameyshqfwud4ev7u668PrZSZXJNCQon3xyGU6Dmz2p8vy8qFTvrrWzQ?=
 =?us-ascii?Q?slXbUZPjnaCf92maQUBQkFWvOczRlGLhm4l58vK2BZgmtBYfQRJ1irMmIwp8?=
 =?us-ascii?Q?jFweNbPGPa/qJBk/tpzfYfBDpPvlwzQcNxROBrAGpJ3GbKA9DeQyAG0yWPze?=
 =?us-ascii?Q?8zijz9885ej8IBAzOXK16WHXPtu9K6F4vhCnjTAylM9HtXa2gugDsyg2SEty?=
 =?us-ascii?Q?W+ifRm+5+L82sXDdEsIRbow+wmzbFKvHsnxt8EBJq2nOaSaHICOO/0DRDLHP?=
 =?us-ascii?Q?KJYjYlApVwSOt0BbaPlYtm4h/N+RXqQg2fIwinVVp7lCZD2MGqR2AIThbIvt?=
 =?us-ascii?Q?DwSbzPmiSbQeSZLShmkFqTytCq7xur/m7HGD6i44hH0F4w6mtHXDv+rDby3+?=
 =?us-ascii?Q?o2A8lI+lah5f/YcXmba052vCNs67cdzMyww4s56vf8SNabFIh6fcneFJi1yB?=
 =?us-ascii?Q?MTMoAv4I47VX3/nJJ2V7bgdf8/RtpSdEmLOSnZQPvu1bOBRocSk7gTae3YxQ?=
 =?us-ascii?Q?IQKFW1lyZV6ywpfsoeTuHMdfyP2CrrT13fDS4TQhFCb25Lg6ECphvjTo2iXz?=
 =?us-ascii?Q?TFrTRpQSvuAucFTfhTkH2rSauDUlZCRiRJlGRfKo+Vp3r1SZhqrfor9f1Uti?=
 =?us-ascii?Q?x5qJw7XDfbxEoLWp910VVB9h5fXcN4ppYSOz+iNx4kFQjlh+r8SiEpPoaNmr?=
 =?us-ascii?Q?o47YsLQk1CB2l+HJ9hlfHQPg2CwfF30bir2hhfeECDMpYnXHcrzWiR+cuKY1?=
 =?us-ascii?Q?S9qd/Da0vB9asy5bu0V6jl68D88s+Ms5fVwv3QsK8rMApP+d2RHinotgMUTA?=
 =?us-ascii?Q?7+bzrDzNwI3jxPVm435Wid80+1twiRtcIVyKKFaqEZiGc84MYuBSWhAd8k0W?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf2ac6e-aa41-4fec-1d7b-08dab5bb22c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 12:27:37.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdaVNjkwaNpkoeA0x619yxlkbb7Kvxs7oVPoKDFlCieY6ts7DxY2B481YbuwbtF9+7cV6StcaO8bG2Z6zKxa2D1Dcg6ishywdJlzfhZmq7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4038
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Oct 2022 12:27:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9804

From: Sven Schultschik <sven.schultschik@siemens.com>

This series of patches will add recipes to build a QEMU setup
which uses OP-TEE to use RPBM (Replay protected memory) of
an EMMC for a secure storage. Which is used within Secureboot
on ARM64. QEMU itself does not have an implementation of a
virtual RPBM. Therefore a patch for u-boot is needed which
adds this feature to u-boot, but breaks hardware
compatibility within u-boot. As soon as QEMU has a native
RPMB support included, the patch can be removed.

The last patch is ment for manually test and verify the=20
patches, but should not be merged.

Sven Schultschik (8):
  add recipe for edk2
  add recipe for optee qemu arm64
  Include optee into u-boot
  add u-boot patch for qemu to support RPMB
  add recipe for trusted firmware a qemu arm64
  add kas files for building qemu secure boot images
  enhance start-qemu.sh for arm64 secure boot
  no merge - manually instructions test secure boot

 README.md                                     |   65 +
 kas/opt/u-boot-efi-ebg-op-tee-qemu.yml        |   11 +
 keys/helloworld.efi                           |  Bin 0 -> 4576 bytes
 recipes-bsp/edk2/edk2_202205.bb               |   43 +
 recipes-bsp/edk2/files/rules.tmpl             |   61 +
 .../op-tee/optee-os-qemu-arm64_3.17.0.bb      |   54 +
 .../trusted-firmware-a-qemu-arm64_2.7.0.bb    |   61 +
 ...hack.-Breaks-proper-hardware-support.patch | 1375 +++++++++++++++++
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |    9 +-
 recipes-bsp/u-boot/u-boot-qemu-common.inc     |    5 +
 start-qemu.sh                                 |   14 +-
 11 files changed, 1695 insertions(+), 3 deletions(-)
 create mode 100644 kas/opt/u-boot-efi-ebg-op-tee-qemu.yml
 create mode 100644 keys/helloworld.efi
 create mode 100644 recipes-bsp/edk2/edk2_202205.bb
 create mode 100755 recipes-bsp/edk2/files/rules.tmpl
 create mode 100644 recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-=
arm64_2.7.0.bb
 create mode 100644 recipes-bsp/u-boot/files/0002-rpmb-emulation-hack.-Brea=
ks-proper-hardware-support.patch

--=20
2.30.2



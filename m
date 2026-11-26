Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11270.1795689018322784349
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=V3ZcEARy;
 spf=pass (domain: siemens.com, ip: 52.101.84.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUTQ0AHBgfsFyyWNdkpLtNj7m9sYNyISXkE57cew0PlOJAWKwtDTNjgo5ZnqU/zaQIjoeGwQboIA4jNzxw0yHwHqrPm2DaGuFWqX9VuktXvPc4eJ/xKaFqwmM3M2xA/O8aOq3lilGTt7+gka6LfYFhneR7rScnAShj5ULcOrE/7myp0CFLI6Oa+DrnA6I03pxEwV71NN19XxVVK2ykLxUiISIEV4QyxM/8RUYcZHQiqjnSPuU1FTaJ4n9S7LqXZFRyoCOwVB2DebSERwgMXd4d2BQHxBs5jPUZTK93f1ofEMJBpO8Q4oYmUBbu8mVfdQSM1rI+o4DP17kuxes5eBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV299rHzrZznZQ2ZQBTFLDoivP7yONQn2p4Pv/e/nsU=;
 b=SBI0i5c7rKcnr3jl9oYcUagf40I/oL91rChJlQAPZH1/LpTIvec2y1qF6oGNxVkpMs2rLZbWJzzQWk2ZDZg9wPyOhH4Wvv8lLw5u31t/mnu/S1Hd66o980q3ME+KfRyo7qLW3qEM3NJbIPLR/hoPUNRNcYmyp3xmUlXgzOeF0fxbTSPG9G3jxMoyBl8AMl8DIJPOAW9XAnCf12p12oLebzh6lCCFhmU3Qu9r85TGbg/OKhpvw4wo3J7/b8Hx+hY+KxMFIg6sisYZZyZ4x8zmqgXY7a8Q8mX/umipV6125Q0m+suIv56E/Yv+bD1UmbhDT2Gt4H3Q8iBam5FN6RsHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV299rHzrZznZQ2ZQBTFLDoivP7yONQn2p4Pv/e/nsU=;
 b=V3ZcEARyBHlBRr1lMva7vsDq3yUNYDZsGw7HVXCJMeO8LJVe/ZnTgoU1eTS85vdT+mkxzI8XYvkPCyxEW+7oYjbMv6SZefYZd7Uimp556IDRlFIjPH2rP+5MBDA+P7wZJnqBRvlBiILrrelmuZTF0Gmqg4M6CvHFkFbn1vsbU7OBSZsMCWeBz/P+VLGYbkFa3zUk3bJVBx8f332I6/ISkx0+/kAuWz8MvlCmzczXE2gyy36Gxnk+crAr5qMplZhxVxg0U2D8o8ipHLlUIo1HK9XAxAQnnXkJeR3Z/kv2nEZgFPXDsKU2xUYSS1ePOgsnaPoLvkenBagl7/E783LeOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 10:30:15 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:15 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 02/21] kas: encrypt-all: mark the A/B rootfs with mountpoint /
Date: Thu, 26 Nov 2026 11:29:48 +0100
Message-ID: <20261126103007.2922985-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
References: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: cf05c8ce-2fd5-448a-c56d-08df4ba84237
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261026121527099003|261102123227099003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: YkkExuSPFBntSLgM7tbVSg1Rmu9AwrD5JpSSVTYDmOxj4VGs92PHYP2enZmB6CllSWiODSFMv+zKZiztUOIz8bCJV+swM7d3Em3ObgSavw+/nVcBvkh3tdHOS+AaIGKF/dPCrKjUX06/wRDp24dcRgbLPjNfXPPGPuzMpPk/7DXGckHgtxNRXfyLXlnBKoPF9XzsXP/qbRq1SDl5f20e/mgqXSP5y/MEXLCn30lIZZiK7vULaBvFTbzeWAyGpzy0zwAd4qU6ATweb5inizS/mvhR5t14Y+snP16tREQaaR/IBLXuOEsJry104/PdrzZ2KYNxvrRp5EYTN7PPK0Tf201gPQ1JJiD2Mm52dhvBuP/xhT6jY2P5IvgFClg2oVC1zlph7qUsaYL+HFID6u+A9ufRcyYnsI/ktDhsZtYvEgv1EoM//NRMl/POsW1Bm5hiOrr5Ovo5uNEq1ZwV3Agw8qVKcOAN+Hlo90Wq90rX19D62hR/2Dpvpit+d4x+fzwIb4/YgrQL37eLw9ZNyW9GZe9ifd4dpSO3ypGpZ/IdHWvwhuHiACeQe+DebcYfxbzIx45ROrr3fNK68XcREnG+mb37YoDCU1xZEjzeoFcU4pP3oZuTRSNJtRqMq5/y2OLfTQ59XLH87bYk/gJx6s3nmMkOC50k5NaFtKCpOKT+iJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261026121527099003)(261102123227099003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QblGn7gkFsS7H8LK/pRNbSbdC9bCjU0SGtNO5Qu77rNcGB8s9VTGYCk1BYyt?=
 =?us-ascii?Q?KbsrfUOPgD6j5C4Vyk9ruShY8RMNs3GrdqwRdNN++YNBL/mMFXqmKvsXaPjc?=
 =?us-ascii?Q?f1TTRb30E3IU1EyrrtIvCU6DNRAMmEGFAoJ18+J33DpvcXF3g+ytbnCer8F7?=
 =?us-ascii?Q?wahMReLjJYChBgVIRywF6iKn+htqJQy8WsjHSc6TzAmCXGXSt62lBuMA/Cl+?=
 =?us-ascii?Q?WfI74sd+2OOu2Z4ZHRP3+qFKtnMECZIkQKww5orQOQ5SaGEL/locMqkNjqfG?=
 =?us-ascii?Q?M6QvmUfPcFMDEsCVocmiulwzqEkTcG2Gg71mAXiW3wuy9xeUMEq8bHw9xqhp?=
 =?us-ascii?Q?f5f8+TRnWe8XT2fq1CdbX70SNxZw2tp1FklXgEw0F6wkxjH6lek2wCkyIk+F?=
 =?us-ascii?Q?LuowyksgFrkTihKgLvhtfLgPupbUmCoYyN2TFyQR6y3PMtqJ5kGNcFhDlzYW?=
 =?us-ascii?Q?c0farlhctPRP7U1amLz8otlB+HHK+KudfSg7cYA5Au2bPjXJbbiMa8Op14ln?=
 =?us-ascii?Q?0/8DDp+IymrQSA3UURbVlCvC0YZ1OuMZ7aGbSpg6bc2UpfS/+l/z7tFBDieT?=
 =?us-ascii?Q?l04pFpFTMzOZrQ/j8/1SCZNuHc+Aye7BN7OmpjapV5Q7tM+at6oTo9i783wu?=
 =?us-ascii?Q?emLCMzfxXdsq/Rx57j7JRq1gFQknYHwutzGXkiTSxqF/xf/w6q4HcBgm9E0G?=
 =?us-ascii?Q?P8IBz6JbUxb9Dyh+ooZxNiXoVGiplYT+u2kLKNX1KDI5Uaru4PLsxQzBb6++?=
 =?us-ascii?Q?f3Q70V5cTGHXCpltHygABnpcRN90zo37ri4ewzUwALRvKZ7A4KIKhgDv1pK+?=
 =?us-ascii?Q?7twG9aAxQYYvLdxVDEx8sGuezwAbQEZSLs5wllv3TRp5aJ4beNpX4whgUDfi?=
 =?us-ascii?Q?cLtTCu6Tq/W12wouIpQMKct5hW3RPzOP2nO0RMgRhddxY4PezRPmU2kk7zuz?=
 =?us-ascii?Q?OL+gfEfHslJzGuk46M7Bq5mxOrJDoyVhXhXq3Z7XO6OTvu5WMPekFe5r+RTk?=
 =?us-ascii?Q?cjj27627NDBiuYtlQXV2OzQdT/SSi1I16gwe00WECbUduwq9GkhoAmcFuksy?=
 =?us-ascii?Q?WYcGmEkXNAme3Xp7g5ql5AKRUYM68WtpA65orgnxBeKtYsWFA+ehVfcbyMOR?=
 =?us-ascii?Q?xgOb4ywSkzONQpSX0v03KdD10w2gCAd8qdOpFF9k/k/f3MSQ+mDKpwFLvnR5?=
 =?us-ascii?Q?P7KQTRZcBkeLJX52/hL8w8a5z43Cy814GWfX985SP6GCNHf5ruq3x1qCLY77?=
 =?us-ascii?Q?Q9NLE/rA/pdREv8mY0FHSpzv8ytNFrP81xA2v5I0WNcLnYyhnx/q5KiZk+W7?=
 =?us-ascii?Q?BtvxHuNkJybYakK+YQPucMdey0ValYUn0VfDTbKriQGFEPPeEzpnmAfdv5Tf?=
 =?us-ascii?Q?Ih1kYZ8iXeZiLfa9+8oza3wia6JUqqFMvO+WJF/4QU6sS26oc2TXAOsGw8Iv?=
 =?us-ascii?Q?02bLXGv+wB/dN6EsaYe3ioJLih+Py5sGHWNle8cC2yuTU21dSqnVPpbK/xro?=
 =?us-ascii?Q?kbFAXkLxsMFJKzf9Mo0khmm+VnfrOKdAET12D8UJY28LOs6LYycYZe+OGTx3?=
 =?us-ascii?Q?uEMQRdKb4voeBNIxdujZk3hA7+G63rq+BTl12pOfh/1j7IiYL2nWl4iz+Dw1?=
 =?us-ascii?Q?qdf/HXfMN12k7st/0hjY/cpHWJO8AwItJ53juEXN/z45K+2Bn8lAF1QiL5Kj?=
 =?us-ascii?Q?wUZgGKhUpgqDUtmxBNQ913SZIykauexnHmkQTNctmHTc9ShRQaO+GQan1Pys?=
 =?us-ascii?Q?Nd4RiyNhPKxo+Q9oa7k4QTflQNl2ibQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf05c8ce-2fd5-448a-c56d-08df4ba84237
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:14.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dap01suCCgWGQeusvxOPoPt9Yr/g3xOqJ4Nj84+L2453xyROAfVrP7bdBVW4nbiVPpGNoysT/WRAv/hCFAt4rew6oxGNyoRKzd8ORpV+xCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25083
Content-Type: text/plain; charset="utf-8"

The A/B rootfs entries had an empty mountpoint, which the crypt hook
cannot tell apart from a data partition that is encrypted but not
mounted. Use the mountpoint / that the crypt hook now treats as the
rootfs marker, so that the dracut embedded-crypt module can set up the
rootfs before verity opens it, and the hook keeps leaving the mount to
abrootfs or verity.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/encrypt-all.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
index 8ad40eeb..fa24939a 100644
--- a/kas/opt/encrypt-all.yml
+++ b/kas/opt/encrypt-all.yml
@@ -15,9 +15,9 @@ header:
     - kas/opt/encrypt-data.yml
 local_conf_header:
   encrypted_root: |
-    # Do not set mount points for systema and systemb as they are mounted =
by the
-    # abrootfs/verity initramfs
+    # The mountpoint / marks systema and systemb as the encrypted rootfs. =
They
+    # are not mounted by the crypt hook but by the abrootfs/verity initram=
fs
     # As we use a weak default assignment in the intramfs-crypt-hook recip=
e we need
     # to set all partitions
-    CRYPT_PARTITIONS =3D "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PA=
RT_UUID_B}::reencrypt \
+    CRYPT_PARTITIONS =3D "${ABROOTFS_PART_UUID_A}:/:reencrypt ${ABROOTFS_P=
ART_UUID_B}:/:reencrypt \
                          var:/var:reencrypt"
--=20
2.47.3


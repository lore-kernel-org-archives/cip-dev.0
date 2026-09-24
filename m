Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719C6C9831A
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:30:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5690.1790249442850179999
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:30:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bC7yAxRb;
 spf=pass (domain: siemens.com, ip: 52.101.65.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZOlGiAvxNO2j5s/L3rdEOIBDu11Fethay+aB6KeUtnZW5SnU5IpPaaPDcpUNFyALd3xl8ydzNWEup6CCty0224QNKSBpL+BchP/HhQGeL8YFGCeNdqw1i5hs1NImsjv8jkqPq7QJegS4GmUs8Yu7NG5pExeZLEL1qEEkTcMFl/qFr1+pW8UQ3NgGsY4IGB33MtmAxEsXfMcqnOieeXQit9Vx9xDdDOZCRXsbOp0EBwv2xGmgm6ggNObDe66viwaHrWEXIbgb+Fbiwn9RjJsRUOtCT5s9VIEfsd1E/4c5y+xLZy5FrdKe5n1c+c7ovbHnp0BvIKBTZWxiFU88zPv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpE8y42LuywxoakwEM7Pv4Z/1rNyQdywbvZGu8arJ+0=;
 b=kqtM6gibQveSZKXxa1e2p7TkPbURjqjVb+SbDGQz4X6VfyFIGEftC8/eHBFMRzXuUkDZfDkyRXJOSbamIk9oubd154AvWJxWwojwfoIPpgK9GevT+n+UHOFjLZlHuoqjAfhCbqoL0mfJTeKSAp1umSOxGlDIrA6hFIa6OHRcXEgR7Kr/YNOc9mscFeo4WUL7qULHm/HiILCvPedw8tAeaUhBufdPhv1kQB+23bvWuaL8kWZgxqMqsabRAJLyJoUJoDTXPtqOkifhTSyhE8JQFQsG6iV7e9ryQYT+EcK4xGR2t4fK5pqCncvAqUNr3f9DwpJBcEA3nclt6INVPU7Qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpE8y42LuywxoakwEM7Pv4Z/1rNyQdywbvZGu8arJ+0=;
 b=bC7yAxRb5oLBIotQ2fByq5+KxrsYNedXciWsuPMp5oZ3TGT8ulWwAIm5EYuouEgMO7wGtmtQGGblmWBuRirq2agYtn3sLYP5s/t+wiZSHkgKNkn+nJRVNWRp+4lbUUWQRLEY1dqA5aUCYwIPQYgsXA586TwKwBtcg+qvoZjptFU9W6McelyZQpHG5xmBkvSSVwjgrU74pieQ/Qu6uLcJ+Y5ND602gmgz7Hy6tcvPSYAyFllrzTolTpNEIaZEAh9hWmIY3ZjIAxTZu1xg1/ReJqCJGFQ05e87I4AAxS0XTQno9+6ZwnJE46z4tKRc1g7k1uhcjKRfDhKrt31kGNanzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DB8PR10MB3308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 11:30:38 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:30:37 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 2/5] initramfs-factory-reset: Ensure that '0' disables the TPM clear instead of enabling it
Date: Thu, 24 Sep 2026 13:30:18 +0200
Message-ID: <20260924113028.3191076-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113028.3191076-1-quirin.gylstorff@siemens.com>
References: <20260924113028.3191076-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::6) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DB8PR10MB3308:EE_
X-MS-Office365-Filtering-Correlation-Id: 448054bc-e502-48e6-7109-08df1a2f417b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|55112099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	zJyQY1WY7nXuytdyWkZIeYVj9MQ8X1Oc8uR5ifb+MPO/18/ogw/LZ227rzgxX94ozlAjEXmGg3iAjWe8a5cZgCnWKn7NLIxaqBODXs3EJZ59fsi2jOcNSk7tUBiy+ZCDQNOLyCVShxNjedjgR49BCBcjeuT/rKb88ZYEI8YXgvxhPLs/P9g+v8rASgOMGmQeu08kSN553v3dqTH4K8Yy39ddod5tSPPBWz/eaSOOvy9VKufXn+mTexauErykw/8P4WUzINzszvaN2Hfb4iHMEct8OZDXaF0+Vw5hIyXajUCanDyJejgig7cj+9n3KhjG1T/SzXgwpYYCxpAChg/GldIz5iYUtJpWzN0rIqd9BrlhqyAvVKKBZKIL1EH0g2+nnv/4ElzlWaZxpzm2WWzKZg9UfcxF8veekOtx5UV8vdQixZxzukV3XzqtePkRmHVG1ccXwyqKkdnhEoCbV9Sjkk7YHPTt/DeBSaVAdynxRMTdkuEEzXxBuP92E9eTz1GxHpvUcMVHA8LBlzuWB2f82+j0KY+sAJOXBt5EiV+LD8cJXGj6cu4IKiVrI2aXMxc6sxE/QlDWJpfENuItXus15ohlEw8IF4tV63EYXR3zV7ExjYiNxgA9GOA+MgvOCi0XK9/9nLAGJmWEaInO0nEynXMD6Sok8gVGw3vP5faYD+s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tQTb/NzlXPxuhC3U9bzcQInlNe6P6/OhiOm4jn1k7uPSzQbJ5/DUSl3bUoIB?=
 =?us-ascii?Q?CkLREPyAkjcI6zA4nJPt+JDCkFgZlJsRyfK5PAigptFRI1z8E3q7MoHbnT93?=
 =?us-ascii?Q?HlVPQJeMIWU1NveDgzvmXCfJYUgTlnzcm6hM3+LyaNpfXrM7ndTDvZmT9ZRK?=
 =?us-ascii?Q?XN5yOnDFJZ67VWAILjiTqJIVk+GXRbnXexD3E0oq7VZyFq/jnZmhRCFuL2np?=
 =?us-ascii?Q?7QJo4WKweancxzOfW6iZCa1FP940RloDti3+ehoWbQo35lrJ6whhps4YhKkv?=
 =?us-ascii?Q?SbE4j7YUkVU3zBkptWHxjfkazrnCnu23tmnc/onYerkWbYm4JLopzarBn3X5?=
 =?us-ascii?Q?qgBdllBbGEwhhSjpPfSzx/6LC9YosZoBL5UiYLu37NNfrPuF1l9dIRDEglfD?=
 =?us-ascii?Q?t+G2+f/7jjnJ+C97uItyG7jKxl8vrHhF7AunP1H32l8OpULMKZKOpxo/cPcX?=
 =?us-ascii?Q?CFETmmaEq228pBLJ+19NTMcarphvyQGkYGAbKJIv7eIwxlmLwpYYPKCouVo5?=
 =?us-ascii?Q?AGcWtWGNOBY9vOdjmOdb+ybJp0VwCvTBHtwb7LdMNIK5/JWEvTbDelxwhKLY?=
 =?us-ascii?Q?1EOyAyvgzQpXYqv6YWIDim9iVtWPA3ih1LpVxQpQ6hDdupS9pnrUXrCp7qDZ?=
 =?us-ascii?Q?Ffo/1Ix5bEHIk4WlJW11KutHhgiRxU/BIyAV3cLRxmRr4yT7Wl/sWQwY7H3p?=
 =?us-ascii?Q?7ilp4hBUNpEFqHsqYfpWo+zjoFD7FpMqWBxZi9ff+km1BCIZD/OGIRgMo5l3?=
 =?us-ascii?Q?l5NxIOrfPpj5OFwC51lUE3OjDjq2fSqvGyc4yTeXiqCaZwTUE8W/LP9SH453?=
 =?us-ascii?Q?8ZVOZhDLDdm44ec+wcihpGzRgdozTN9v7BUetOOf1Lv8f9g6jKU0qQN0bMEh?=
 =?us-ascii?Q?8k5Adl7CGIq12B/wSH0E0fgv+3o6maUt4Xvi4FlrxX2faIgCm9TMtGxjS8df?=
 =?us-ascii?Q?AQLeDHTvJ/9UhReQP6ZhUtfmoO0Ckw9TB/EynFdKLCeT1ES4rPB+mBCDafyx?=
 =?us-ascii?Q?lwJT5wD54dsE6FpEmROXNv+k2a1whS+bPtFDoRkdpw7eBQtEAw786J4vM3Qk?=
 =?us-ascii?Q?P+Q+4hx3Xn7eS2XVYtc/9SRk5Ja4HGEYYUJCsVbY5tJyp9iEHliq0g6/itVr?=
 =?us-ascii?Q?mAy2XrBnBMDtz+js/qnvv6O8Q/upmimo/vANVM3k9CCMs6xK6JioRSilJUP8?=
 =?us-ascii?Q?AiMBBnNudr8d4Scbx2KKpiuVnVhnR4IhN+tLThRgoMVuHcYHOYZOKWjlkCQv?=
 =?us-ascii?Q?Onc+Okp/GO0elONzzz/+Qu1SDY4A5dY/Vx4hxfAegg1p54cXnxStZgCp0CL6?=
 =?us-ascii?Q?lH4dSzUkRW7Gw0yeYYgE0KBFoKmWP3yYrZ4WGn2zO9Bi1Eef21NlKYskvM2I?=
 =?us-ascii?Q?59eEyT2y39lMEpbecBNKQnMMqxmr9tzVXxLxwRbwGZ4RZse12Ggy10lnKZyV?=
 =?us-ascii?Q?qk/6gUW8xKhy1nsW2vrfdfEm4euPYoiIPgG+7xaUDdSnlUMJkBJjaQLvvpZ/?=
 =?us-ascii?Q?7PPACWt1ZTJY7ord5w4k1FB4mM3cDPAnwxxH5VAlm34MQzEhI9rg/3QAuHaj?=
 =?us-ascii?Q?cq0/ysFTwHikqgg4OyxusBCr4ARqbjEQ/DLVhMip7WhaSEUgdq6bSV5A3E86?=
 =?us-ascii?Q?EiAohjKjPTXPpItxbSPyGVrIM3/NCOXMNM1jZCqa9ypkt2UcIk/bhFe8rxm2?=
 =?us-ascii?Q?4uA20BIwc8txEz2lJgtKPF3//tq5KxF1l5lu2SI2ogXKkwI1BsRZ7LCVszim?=
 =?us-ascii?Q?lp+3qR+7TnJACG24k5E6wbywKw6KgDM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448054bc-e502-48e6-7109-08df1a2f417b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:30:37.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uK/56VJwmVAUTV2LixoN6hTe/AsR7IDPuLgPa9nsF+5Sl9UWTTL08CRepoOtyGklEdjvMXGavZKnCQ3SqRvFNgTHQbDiuhutZloOS5/Rwo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3308
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:30:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24311

Setting INITRAMFS_FACTORY_RESET_CLEAR_TPM to '0' did not disable
clearing the TPM: the generated script tested the variable with '-n',
which is true for both '0' and '1'.

Normalise the value via bb.utils.to_boolean into the new variable
INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL and compare it against '1'
instead.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/factory-reset-script.tmpl                          | 4 ++--
 ...reset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-r=
eset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} (90%)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-r=
eset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/fac=
tory-reset-script.tmpl
index 94b5f8b0..d17cf322 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-sc=
ript.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-sc=
ript.tmpl
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025 - 2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -48,7 +48,7 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "fac=
tory-reset"; then
                 ;;
         esac
         if [ "$fs_type" =3D "luks" ]; then
-            if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
+            if [ "${INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL}" =3D "1" ]; th=
en
                 # after this the data on the encrypted partition
                 # is inaccessible
                 tpm2_clear
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-facto=
ry-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initr=
amfs-factory-reset-hook_0.4.bb
similarity index 90%
rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factor=
y-reset-hook_0.3.bb
rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-=
reset-hook_0.4.bb
index 670725b7..aaa194b0 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.4.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025 - 2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -19,6 +19,7 @@ INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partl=
abel/var"
 INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
 INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D '0'
 INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D '1'
+INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL =3D "${@ '1' if bb.utils.to_boolean=
(d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else '0'}"
=20
 # to support factory reset on btrfs, add 'btrfs'
 INITRAMFS_FACTORY_RESET_FSTYPES =3D "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT=
_TYPE}"
@@ -33,7 +34,7 @@ FACTORY_RESET_HOOK_TARGET =3D "${@ 'local-top' if bb.util=
s.to_boolean(d.getVar('IN
 TEMPLATE_FILES +=3D "reset-env.tmpl factory-reset-script.tmpl"
 TEMPLATE_VARS +=3D " INITRAMFS_FACTORY_RESET_DEVICES \
                    INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
-                   INITRAMFS_FACTORY_RESET_CLEAR_TPM"
+                   INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL"
=20
 RDEPENDS =3D "factory-reset-helper \
             initramfs-cip-functions"
--=20
2.55.0



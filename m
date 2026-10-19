Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D07CCF2E3
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:00 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31402.1792405553417919648
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:25:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=DVt659pu;
 spf=pass (domain: siemens.com, ip: 52.101.84.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahpf5LEQfxFumDuHWkbmE2gj4lLtk5aebBJaMSJcQLrvAhkX9eieI22IcJ15No39xJCr9sekHNc+UUff3h8QOf3QUtXriP6P3EiidatsuSgpsxIeAdTgpNWEHIJmPbaspjSlR2FReElKE9QiOodOLhg0/xAAEMM9xh9IGgBy6MPhGBHDBEgiYNWMSU7oPFXBtLeM0yeHmqdFU/xeTpAszknInfz458ZX9mzvSGGN9ajmqCEEV4KquOSvxhaHDe12zuN+CTZNw70YOEGZJfByxryq1pbA5wXjGQgf4vMqVaBzOsmoo4mB3nU3srLF119KlEwTTbwptGVM/Cwchydj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyliF2W9xzSGtaSpBdx4GS8Gxm7Zg/hOqrwWOi884gs=;
 b=OS2ZKf6Nrm5wO6WFgb098qDL1cdjZ3zjiASb7LiSC0nbFsNnaOZiygOgDfTyYqldV7BUT/QgPNsfesHdpEzChVr5IiG2XMNIKqhDGWrYKlU0/Wdr0BpF8T2NrQiSJilFcrYSDF5RK3x/dHPsFHaAfRi5U1PAWhlhqkwHtgAI9fCJE0+V82LCqhOqRQESoPZcCQ8yj22j41IrnC7/zVBMoiqYXHalPXys1SvRYlzVQEPPR5vMhb5QV8QuTzHGRSj1XIKPuGy/jIIp3RnidTPjlIH3uOabBVR7kJfZgX6L0lEDGX8ymuH1Epfevpl9+CVFWlqQzpPZpEgJ4IzJcVw5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyliF2W9xzSGtaSpBdx4GS8Gxm7Zg/hOqrwWOi884gs=;
 b=DVt659pu6JeIvpJDjtTxsOOCRShgyh5ZHnw1Y4xc9tl6xhvz0zu5LL7MxDs3JzPUrtWLp/eM7rVu5majRzTJzrLs5DvjIkfBU3YH1qMs3O4lTKZRdGcce5AvnnCwAkb4R3/ZBd7PUqP/eP87aiUkfSc9M/7jSHOetC7vrbF2WDqCgBmYUpRrZ3tQj7zJ1YOV4yTlSZrsmVT1bskMipYnODLOMDs70dRK7JjbVPo08oA1NPCS+ht9SnIYDlw4qoPzle4zCobWXn56p0UmuHGvi+5p+uCd2Vm6cJMJU99IwXjkjDc1Ylw9WCRacXppThxiYfgDhyuuyJPuwQ2i3ZPIhQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:51 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:51 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 03/12] wic: select the A/B rootfs image via WIC_ROOTFS_IMAGE_TYPE
Date: Mon, 19 Oct 2026 12:25:14 +0200
Message-ID: <20261019102541.672620-4-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e61aad-c30a-409a-8a00-08df2dcb5890
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|55112099003|18002099003|22082099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	YPbs26I+uUF8t85DoUciL5LvvYiNQ8U8mVD3VfAV1pNnf8Y85f7cq2+2hynEG72YnvI1Z2Kb9oeEZrh7E4nLs0BXJxg2R6PuVDv93WdkrNm8L8L7rJUoql7qkVr6sPCtEl1/71+iyt6RDH1aaMlyhwvkj1fcUoA7Hr6HHZq3gahlO3oxZnvtQQfWQucWfjAiGFMaJPKGH/nLjWefkdxgBTBbzQAlUh0xTNhIvG1W9ILSMkXU66q9I/qeZARqaZX3kEIS6Y/Use89zV8iYeUmQk2W5c9EcZgZA+CfJfedlNBxWhf5pOTKcplSRkW9Q+eHi23v577SbwI+lbCDupYqPPfZ2lt0ckcDumUxQDuP2dyFIONEPhoCLtmBLllyCjK5oh3vKwhv76b9aImWlKk35xLJt18i876i2Xu2l9tHqQU6uHi2tKs0Q3WiFOWedh5LkeiFbvtZv50rJkQWdYUpkp5hbvcy1yloCR4AMRiFLzFu+xIzL48yw5psK3arS+biqBkIBqaBpB+11lZvoVB0F2mfDHRqdrh1+fAS0pebg3HSHAaa8yRaYuvkVEZazwSuwsYua0djcF1qYDxOOSclG7T0/1h2hkh33WjZwp2yvrGyLq+ZOwphY1cCy+1DuoqQlJtIGxlmMRZQ4jns7gMdmIEIVttrMUtAIYRKYSlbD7k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(55112099003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0GjfgNHUcqDEop4ma5ULVoGCM2gd4rydThUpsPUsR6GnuyjQutTCZPqKqsXD?=
 =?us-ascii?Q?ZduANuPmquQdwF4tqQCgN4r4o7b4ld53e6JaJqgILxza5kxC44FFJvJvlfUF?=
 =?us-ascii?Q?xCtxdAlRNbON8XluVmYHSWu2CgfgAcZHB/exNRslhqximrZ0Nl2aM5khEE3U?=
 =?us-ascii?Q?BoS9uuGzugAvBuNf4eNamjIvhv2ejGAorxzRTeCZnzouKMAl9sR5e1bNpG6+?=
 =?us-ascii?Q?XdIDSnEWXBRHPO0AC0iqOIFeSbe1e3gyZovVrx01aeTKQ6JNqi1KajyaLgM3?=
 =?us-ascii?Q?w5G1z20PJ8aBvBe+q9f3yJnqVDDx03nlO7VvKf4ZoSu5o4euPIS0LUcsq1IQ?=
 =?us-ascii?Q?bqC4T62Al4tsk6qSa8iwKr8lFW22LE2w2Wgyi+CJDaoyVVYy73TWzjgd1Kjp?=
 =?us-ascii?Q?aDXox1blDrY9V6OFEAtOpahxiojBhX+dqWKEEI0RBtm+E+xwaJnHzl3rIqvD?=
 =?us-ascii?Q?/Ambldg3qe2ZDmGDwG3CN2NNu+OTLoZ2D5+VlwGo7BU6Ewhq6Gtff8ixn5lH?=
 =?us-ascii?Q?CYsKRaIqCMr0FpSCSyt8pL9JR2HaZ0iTiKBtpkooJSCclVNP1L0ylYvAMCBP?=
 =?us-ascii?Q?9LkIxC6L9J2Ylqbbgy8fWq+4GzZXGz0w65C7V3Xj/68r6uObYnLdbjZsYldo?=
 =?us-ascii?Q?jY2WuthiLWH1GR8uGfJ/Lr8EMAzJP8dWkBitKf/xmImS0lM5PKFqJcE+UQll?=
 =?us-ascii?Q?PhTXzmjdM8XuzkiGYs8nkdP9hzvDdmFHDiZ7DNXZs0MnaE/SerSXwDM2Bhas?=
 =?us-ascii?Q?rvopnNF2iEwK1FVQS9qHhq06yksRwNVTlUrI9sxzKh/aaT+17VITFioJ78YB?=
 =?us-ascii?Q?G/NMTgKsdEcmWeWAJyR9MefPG0kvkEu4f92m5GhDXahPoESSP3lb1Rq0PQUe?=
 =?us-ascii?Q?d6Vn072sQov+I0VglIhhRV8aMlZRJQrgzPWYKbncXwSQQD+AxD7nOk6mOByR?=
 =?us-ascii?Q?K3lYddjrldouJZWcBcr3NkHtIut2cLkcX72BYAyKXJVPQ0ryKYS7NEBwKq+p?=
 =?us-ascii?Q?DInhzamDpR5c6WjGpVEwcEX2U828vPl0cGI+UM25CegmyxtN+NTcOJHpF24Z?=
 =?us-ascii?Q?TPTwa0wZ7OZ8boZj5fQpIIIO1L8AiHHCTnArWukl7pPYuJzyMAnZ5tHGwQ1Y?=
 =?us-ascii?Q?XR3PGdICrEUlyZBA+dl/Rc3gRBKgzVTxmBVmbEUWMRw4Y7qSI5wwzNqAQ813?=
 =?us-ascii?Q?RFXuwLdVqW7MmX7/s9bkrqBCSPT6oUdMtmxW5zi363+dotWEmi4Naxyr3pAY?=
 =?us-ascii?Q?eWnM/9QsKrQ48CgW5ldtGs+W4ULSCBE1PWL2zV5+OAvVSYOyChNlif8F69Uv?=
 =?us-ascii?Q?2GduukxDPOOpJZN2flSKXOD6eb+aqKLwOtUJoovBlLibTTgSRMzlZuCSzdfu?=
 =?us-ascii?Q?iH/PabubbVyk6WXbGSaAcy/rdnBwJerQypPolfTZEfH3t7+RyKxLm0L3NnE/?=
 =?us-ascii?Q?F/aTxUWnSZtrCDWX0/xxxoizt0wf0g5JaYShtdAxNqcDGdeEpPoW+NULnwcx?=
 =?us-ascii?Q?wwOoj6TSagLmdgHXlbAeMlWDoQAsLLxvwxvCEtsSVRsMQf8FAZJ3RjEkHSP2?=
 =?us-ascii?Q?z482GRPnDLjMMUTusIR3KxKd6sOG6rlqbetGYf3pfoL8cj5KqxgP1sKhXgB8?=
 =?us-ascii?Q?GNuPV2nC27fzjx1FGlYefgo5PKsotux/giT13KDrY5OuFbAJDp8bioqe1trH?=
 =?us-ascii?Q?fNi43T/Q9zoZavKrmEYJhJiKE6lakyXeZeCpwuMFkyMvVJzuXzy7JXatzHWm?=
 =?us-ascii?Q?Z4q1Xpb2JTHWRj2NrhZqYaw+Oz8cC/I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e61aad-c30a-409a-8a00-08df2dcb5890
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:49.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NTujbWGemlVqrh7apuNysptC0WlqGnuKHLfo34oxIlfgRp/cltx+6IXKeBthMvUUGv+s1QgagdCN810D8zbWQxnU4rUoGat0x01SDsf9iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24483

The efibootguard wks files take the rootfs image from
WIC_ROOTFS_IMAGE_TYPE, which is verity if RO_ROOTFS_VERITY is set and
RO_ROOTFS_TYPE otherwise. cip-core-initramfs installs the verity hook
via the new ro-rootfs-verity override instead of secureboot.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass                    | 3 +++
 conf/distro/cip-core-common.inc                            | 2 ++
 doc/README.secureboot.md                                   | 3 ---
 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 4 ++--
 wic/bbb-efibootguard.wks.in                                | 2 +-
 wic/beaglev-fire-efibootguard.wks.in                       | 2 +-
 wic/de0-nano-soc-efibootguard.wks.in                       | 2 +-
 wic/hihope-rzg2m-efibootguard.wks.in                       | 2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in              | 2 +-
 wic/qemu-arm64-efibootguard.wks.in                         | 2 +-
 wic/qemu-riscv64-efibootguard.wks.in                       | 2 +-
 wic/rzt2h-evk-efibootguard.wks.in                          | 2 +-
 wic/ti-am62px-sk-efibootguard-secureboot.wks.in            | 2 +-
 wic/ti-am62px-sk-efibootguard.wks.in                       | 2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in                | 2 +-
 wic/x86-uefi-efibootguard.wks.in                           | 2 +-
 16 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 179dcb98..631fc6a2 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -22,6 +22,9 @@ INITRD_CMDLINE_STYLE ?=3D "cip-initramfs"
 INITRD_EMERGENCY_CMDLINE ?=3D "rd.shell=3D0 rd.emergency=3Dreboot"
 WICVARS +=3D "INITRD_CMDLINE_STYLE INITRD_EMERGENCY_CMDLINE RO_ROOTFS_TYPE=
"
=20
+# Rootfs image type written to the A/B rootfs partition by the wks files.
+WIC_ROOTFS_IMAGE_TYPE ??=3D "${@'verity' if bb.utils.to_boolean(d.getVar('=
RO_ROOTFS_VERITY')) else d.getVar('RO_ROOTFS_TYPE')}"
+
 WIC_HOME_PARTITION =3D ""
 WIC_HOME_PARTITION:separate-home-part =3D "part /home --source rootfs --ch=
ange-directory=3Dhome --fstype=3Dext4 --label home --align 1024  --size 1G =
--fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0=
f-58904f369524"
=20
diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.=
inc
index c945378a..dbd65e3f 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -32,6 +32,8 @@ TEE_SUPPLICANT_IN_USERLAND ?=3D "0"
 PREFERRED_PROVIDER_factory-reset-helper ?=3D "factory-reset-helper-file"
 PREFERRED_PROVIDER_factory-reset-helper:ftpm-stmm =3D "factory-reset-helpe=
r-efi"
=20
+OVERRIDES .=3D "${@':ro-rootfs-verity' if bb.utils.to_boolean(d.getVar('RO=
_ROOTFS_VERITY')) else ''}"
+
 # Watchdog to service by initramfs hooks during lengthy operations like
 # partition encryption or factory reset. In our integration, enabling
 # fTPM/StMM implies a U-Boot-based firmware which may enable a watchdog ea=
rly.
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 2d107a07..658396a4 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -160,9 +160,6 @@ local_conf_header:
     IMAGE_FSTYPES =3D "wic"
     RO_ROOTFS_VERITY =3D "1"
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
-    INITRAMFS_INSTALL:append =3D " initramfs-verity-hook"
-    # abrootfs cannot be installed together with verity
-    INITRAMFS_INSTALL:remove =3D "initramfs-abrootfs-hook"
=20
   secure-boot: |
     IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-signer"
diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/r=
ecipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 7e77a205..30d17d5d 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -23,6 +23,6 @@ INITRAMFS_INSTALL:append:ftpm-stmm =3D " initramfs-tee-ft=
pm-hook"
 INITRAMFS_INSTALL:append:swupdate =3D " initramfs-abrootfs-hook"
 INITRAMFS_INSTALL:append:swupdate =3D " initramfs-${RO_ROOTFS_TYPE}-hook"
 INITRAMFS_INSTALL:append:secureboot =3D " initramfs-sbcerts-hook"
-INITRAMFS_INSTALL:append:secureboot =3D " initramfs-verity-hook"
+INITRAMFS_INSTALL:append:ro-rootfs-verity =3D " initramfs-verity-hook"
 # abrootfs cannot be installed together with verity
-INITRAMFS_INSTALL:remove:secureboot =3D "initramfs-abrootfs-hook"
+INITRAMFS_INSTALL:remove:ro-rootfs-verity =3D "initramfs-abrootfs-hook"
diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index b6d19ba2..cfec1773 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -11,7 +11,7 @@ part --source rawcopy --sourceparams "file=3D/usr/lib/u-b=
oot/bbb/u-boot.img" --no-
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/beaglev-fire-efibootguard.wks.in b/wic/beaglev-fire-efiboo=
tguard.wks.in
index 0274745a..abde300d 100644
--- a/wic/beaglev-fire-efibootguard.wks.in
+++ b/wic/beaglev-fire-efibootguard.wks.in
@@ -10,7 +10,7 @@ part --source rawcopy --sourceparams "file=3D/usr/lib/u-b=
oot/beaglev-fire/payload.
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/de0-nano-soc-efibootguard.wks.in b/wic/de0-nano-soc-efiboo=
tguard.wks.in
index a1c1108c..daf048a0 100644
--- a/wic/de0-nano-soc-efibootguard.wks.in
+++ b/wic/de0-nano-soc-efibootguard.wks.in
@@ -10,7 +10,7 @@ part --source rawcopy --sourceparams "file=3D/usr/lib/u-b=
oot/de0-nano-soc/u-boot-w
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efiboo=
tguard.wks.in
index 04ec65ee..322c2095 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -6,7 +6,7 @@
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64=
-efibootguard-secureboot.wks.in
index 29096087..d4d0f6db 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -3,7 +3,7 @@
 #
 include ebg-signed-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.verity" --a=
lign 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC6=
3DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootgua=
rd.wks.in
index c60fbc56..5c008c3a 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -6,7 +6,7 @@
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efiboo=
tguard.wks.in
index f902dcef..755dcbb5 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -6,7 +6,7 @@
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/rzt2h-evk-efibootguard.wks.in b/wic/rzt2h-evk-efibootguard=
.wks.in
index ca18bec8..bdea66b1 100644
--- a/wic/rzt2h-evk-efibootguard.wks.in
+++ b/wic/rzt2h-evk-efibootguard.wks.in
@@ -4,7 +4,7 @@
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62p=
x-sk-efibootguard-secureboot.wks.in
index 1e2f578a..0116b8c2 100644
--- a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
+++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
@@ -13,7 +13,7 @@ part /boot/firmware --source bootimg-partition --fstype=
=3Dvfat --label firmware --
 include ebg-signed-sysparts.inc
=20
 # ABROOTFS partitions
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.verity" --a=
lign 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC6=
3DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 ${WIC_HOME_PARTITION}
diff --git a/wic/ti-am62px-sk-efibootguard.wks.in b/wic/ti-am62px-sk-efiboo=
tguard.wks.in
index d0c7ef44..80c4fa1a 100644
--- a/wic/ti-am62px-sk-efibootguard.wks.in
+++ b/wic/ti-am62px-sk-efibootguard.wks.in
@@ -13,7 +13,7 @@ part /boot/firmware --source bootimg-partition --fstype=
=3Dvfat --label firmware --
 include ebg-sysparts.inc
=20
 # ABROOTFS partitions
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 ${WIC_HOME_PARTITION}
diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efi=
bootguard-secureboot.wks.in
index f441c4ba..3a7d9c82 100644
--- a/wic/x86-uefi-efibootguard-secureboot.wks.in
+++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
@@ -3,7 +3,7 @@
 #
 include ebg-signed-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.verity" --a=
lign 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC6=
3DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.w=
ks.in
index abc0d6eb..5f94ee2e 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -6,7 +6,7 @@
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${WIC_ROOTF=
S_IMAGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
=20
--=20
2.55.0



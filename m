Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11270.1795689018322784349
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Gunh4jG8;
 spf=pass (domain: siemens.com, ip: 52.101.84.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neVJ8DAjRuP6YEiTpf/xYjVNZSGEKtyu/NCH/Pw2mvZAYM1XlB78JcX7NeS63WMmNszFMGt85zTSuwgtotSfy5PFMi82K92AOGYpn1dO/tqLYtaLdCHR+I6tWjGU+MorTSxflBhCmkVJEp1lpctK3UHgY+ICawSrTiDqa7R0k6O6viShC8wtL7PWlDUMw6xlawsn2fKXWPHHwFT882NIZOaUcb7eePCL0GPJsUMDcY8DDIliOme+FMTFdErrLY5PLRrUjGVJ9iUPYoDSpYsmPilUHVPrBMgSmLYSUROLJkGH2YvtnqBZFNhai3TwkcCwJoEOFTIl6e8OAq3Mrgg4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwH6m3kklHT7CB/4iPJR8ZBs7Sz3N3DfoWmkKajMwLk=;
 b=H0FlZTW1lPmzNZbPe3obCG+2SVRftqF70jIXDciduiccT4nQ8UOx9Oa7P79vYAXKICiM7vp4qALObAzw/Tkd+XSIx6wcBu8Oaz0RfED0vKBXO4QqybpQMCiUEiSFXYJOhzsS1zOhCgAYDyf9FJcvq7AHl4SPntUdeKlUNFy0wv302S7ouMcqxAWiGpnADA3hZIuQRU2BWE9gFz8dPr+klMKLjMIOa6QN/cDiWDljb8ny5sXgtORMfjvjFN9IgIh+jlLuxS1htDUSlnLEPaVkILFOJgW24AWwK0wBBsodSDZc49NkT9PWfQj7WWhaIN614JaAuO9pRUp0UGmRY/9xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwH6m3kklHT7CB/4iPJR8ZBs7Sz3N3DfoWmkKajMwLk=;
 b=Gunh4jG8WGSMUJ06/ZivnVunBY0MgXyNK25uPGzAyMnRhZFM2BrQqEQbijN7u31p7l8mE8ranZPUT9WeDGN+QSVZYtmgj8BaDCJGulzjS4bld5JY1fPTfIlY2WTcxqGhy2j0JUe5ojcUqG5qylVMTrPD5zTJfv3s7tvj5PrrI5RR+zKFtbTmVV4IbKf6Yfp/r3kR1v/dyjaJCKBSVrGyrAqGj+B0IJPWuYzK87epPa+eAibB0btpfGxdfq0MMOga+ZvH+VL4pzNMyZa9gfD+CnbgkI9jzDM8nYaln5fwTRjB+gGm/zaAKL/RfmOFOENaCnKJgxUhe+OHYSb9CMXfog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 10:30:16 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:15 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 03/21] Add ROOTFS_CONTAINER_TYPE to wrap the read-only rootfs
Date: Thu, 26 Nov 2026 11:29:49 +0100
Message-ID: <20261126103007.2922985-4-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79faed99-3893-4007-2581-08df4ba84287
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|261028144727099003|10067099003|11063799006|261009220027099003|261022115727099003|56012099006|261009223327099003|261009221727099003|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261022075727099003|261009221227099003|261026121527099003|261102123227099003|18002099003|6133799003|55112099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 54iBqnNmBwHa4XgEBdY4OW+9Uab7Zxm6zBfu4lJ0Caj+NgV/VC+RULsEhmLvbNYghwMwg3Rzy9EBEn1zzTX8qK89YgfqCJAGzK4FNuSV/KBPMxbhxf8nKgdyPWSbCr2b8vnElWclzim39T8Nw6d4/9qIYaR6ci9VXYcSYKU7hJKHbBUDBsjtnmVGeUD0+u1G3fqT8Tp3uwx+GTsXKWksdSZ172LRTeXNyPqtJKirxidsUakRElFulZg2011xigC/ejeXes6eiACODN+sfsyCOD3UXdLCnJizvF9roz0+HPhIukmPlxphTL6i92ggH3KPHY0UwbvMFQw9rIqMrHOSL1xnyCxC9s9fTQysBVta8TOUAvX0bYO8BJJ+UA8gWqbXcyU664SO90rEpuQtCALXksRyF7tSCMEPVrzT0F6LcanAi8UQEHGEN+dLnraXxlr4xCRavtjCvo1yWxRoXiKmWE2qLOc+NKkXP8/xouV3P2Z9YEaggih+YHnlLhyLBQdwFiP4ag493XSn8leyapzffS+G0c/hSDb7YhlbQCQlpKsekW7kUbPtokuGZwyhux4+fz6ax3+FQs+Y4fmvtdHUAG/inB8ulF24OSLWs/v6ixpFTLHvHrtNytOVjQGrvcgqVbcq8V0HxTqmvMFEhrX/V+nGVRZXS58rSSdLLwV9VAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(261028144727099003)(10067099003)(11063799006)(261009220027099003)(261022115727099003)(56012099006)(261009223327099003)(261009221727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261009221227099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003)(55112099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EINqvHgMuemAx2ispe2ID2TKb84k8S7OCmxqdMDULoDEyqoPrcM0sSACBMZb?=
 =?us-ascii?Q?h/T+ha+7O/xNVP1eUwrqjA5picftdPpEj9iTmHzoORZLQ7SKC4TBrhEvl/2S?=
 =?us-ascii?Q?ueBhYL0F07ZGv8pQ7dUm4fOAZKFCZB0smdMxubjUmeoct0Ma6bPj8Folp/ZU?=
 =?us-ascii?Q?hhMlvjXhfKqxdSRa5YZcstUsd2zX3qo7CKc5oPyWRG2qjZ/nCnjuSDUde/IK?=
 =?us-ascii?Q?b4eF0rAKjmPSYbWAP9/PiqR1DS1lqyBTqdi2aMdvBjDnXdWr6BLhtKJfCv2H?=
 =?us-ascii?Q?SgTY8UgVsInYeo7cY9UIanCCtnSsjo/XtmJb31tTK7BW7w493/XJmMUSPOxp?=
 =?us-ascii?Q?f1QSvN7YeGSAYHceoAgQXZaeZtSliuiePj28kFgqFicmp9vprUiUDRbrncJD?=
 =?us-ascii?Q?6V7nTG4CvnD/1tgS8mQDo6YOmxtSv1Ys1g5lglI+u486K133d/eCZ+px8c+5?=
 =?us-ascii?Q?44bif0SVIIi46i31Yk231Ss1YwxgCFHXE3YLEqUBoMNrRwtSg10HDOJSjGJ3?=
 =?us-ascii?Q?kdZIy3/EeEk1feg7vk+N9tincLfDMYZck/9hiSMGU/2idWzyTraHjxjxI75k?=
 =?us-ascii?Q?d0Irjf+w8ghMLYCe4w98jeyjcsvOSUV3mskZx4wvmhy1JalLuY9uCq7HVOGu?=
 =?us-ascii?Q?AU6RSZlhU+YUJMM9okYp+GieflZdMq3nVGM+9uEklGDWjQEd1PCM9VnP9Q8q?=
 =?us-ascii?Q?AaZ6zNYOPNceWc57Va66Y0IlnjzrUj/w42stLOLQmmdrOekAPBGrO3UZ7BPC?=
 =?us-ascii?Q?vmLWEYxxNrGMZkaCCQzn84oPTd7UUKgYX3Q2+ngzd8lm4dvmg+LhD+v5c4xe?=
 =?us-ascii?Q?JRVaXmO/xY/TygDuxQtkhTyH1c/J+OVP/+hSa8P39KZQ4KmJchsAGroFLChS?=
 =?us-ascii?Q?521myRQaKNsatcLVUbNhZjgwa1Wa9lDHncGCnZVDDccMDInWzLlCe38THxQV?=
 =?us-ascii?Q?Rc1Xv6FYLN3f3FeQvwG2JKjDL3Xn43ajfoRdn78roIhxG9TutAARZG9vbyKN?=
 =?us-ascii?Q?wcBYKuC5kEf0+3du/Nopb0fWCetvIAGGw9NgMEO3Tn3tK9xEI1ARMFi9G/eC?=
 =?us-ascii?Q?/u6kOxeM3ju1I/XnKRBzQr17epeVI5Nv230NOz1ZNmlH/PEfUlQs4zFi4HM8?=
 =?us-ascii?Q?oTgFWbTiTu5ZPJ7FWR1LHFn9wbvisOynzVdip5Z24nVdBvsBVHROTZvoVk/Z?=
 =?us-ascii?Q?Pcu7xRA/QA47GAEKEn67RBM7yHkmLA93fPXdI5sWTe8ox3V7cpfhF2O2z6qA?=
 =?us-ascii?Q?G6y0hcpIhtgkMVwHlqt7KI/LNnjeVTKPO/m/8mxIqL1AyX626Aa4tX4//fWv?=
 =?us-ascii?Q?J+IxLQgnl8suPBtKVQwidm7HaoR8ywD22p80ETE7FGQr9zieomMu3Sj8tBxK?=
 =?us-ascii?Q?03QzH8bEDf3p6RWew2Q0pyF88NbOlB3J/ZmugEiukkMgR7cgQVLSky0/Q5Rt?=
 =?us-ascii?Q?JXOFKsLD4T9+5BZDsuWg3xWi4zCjtUbB1kAAEAGTcKyyQbuLTBz6pKO9W2jV?=
 =?us-ascii?Q?/u36aDjvZ3pAzDNuv/mJLMehyYJYE9kHeqbcZ3hWlkKLmUugh2T9E/4XquGS?=
 =?us-ascii?Q?wtZ69KZv7KylaDalHtFfogX3l+1nPR/vgkINk074tU6W38D7QQCxy34QlJan?=
 =?us-ascii?Q?n595m42PeHhV0+YwDVWVqqDj/ghmGHjazf6QD2h131jKm+I1Jyo0HKZeh8Yf?=
 =?us-ascii?Q?J9v/kDIQaceTviRrx6A9OwPQJ2gfv556wTcOY6C/1BA5Lg4c/PkQsoOchZ+Y?=
 =?us-ascii?Q?M1wfGkBpFOTQR5VsUWJgYzwo18ErkNU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79faed99-3893-4007-2581-08df4ba84287
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:15.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Khmjv9RQFfetitXQ5mNXCPqak+5fbrg5+yjHVJbp5N15A3E9LlixZArw7XDVKZJxcXHq+meeWfARaqbW1ivyM/OEtd2nBgWeC+njhxFlzdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25084
Content-Type: text/plain; charset="utf-8"

This is in preparation for the introduction of dracut to support
dm-verity on systems where secure boot is disabled.

dm-verity does not replace the filesystem of the read-only rootfs, it is
stacked on top of it: the verity image is created from
rootfs.${RO_ROOTFS_TYPE} and only changes the file suffix. Selecting
"verity" with RO_ROOTFS_TYPE mixed both layers and required a second
variable, VERITY_IMAGE_TYPE, for the filesystem inside.

Keep RO_ROOTFS_TYPE for the filesystem (squashfs, erofs) and add
ROOTFS_CONTAINER_TYPE for the container around it: empty for none,
"verity" for dm-verity. A type instead of a boolean leaves room for other
containers like dm-integrity or IMA later.

ROOTFS_IMAGE_TYPE is derived from both and names the image that is
written to the A/B partitions and packed into the swu: the container type
if set, else RO_ROOTFS_TYPE. The wks files use it, so the secure boot
variants no longer hardcode .verity. The initramfs selects the filesystem
hook from RO_ROOTFS_TYPE and the verity hook from the
rootfs-container-verity override.

Secure boot sets ROOTFS_CONTAINER_TYPE to verity by default in the
distro configuration, so it does not depend on the snakeoil kas file.

VERITY_IMAGE_TYPE is replaced by RO_ROOTFS_TYPE.

The older "RO_ROOTFS_TYPE ??=3D squashfs" defaults in swupdate.bbclass,
verity.bbclass and cip-core-initramfs.bb predate this change and are
left alone. The new variables are defined only in the CIP distro
configuration; using the layer without the CIP distro is not supported.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/swupdate.bbclass                    |  2 +-
 classes-recipe/verity.bbclass                      |  8 +++++---
 conf/distro/cip-core-common.inc                    | 14 ++++++++++++++
 doc/README.secureboot.md                           |  6 +-----
 kas/opt/ebg-secure-boot-snakeoil.yml               |  2 --
 recipes-core/images/swupdate.inc                   |  2 +-
 .../cip-core-initramfs/cip-core-initramfs.bb       |  5 +++--
 wic/bbb-efibootguard.wks.in                        |  2 +-
 wic/beaglev-fire-efibootguard.wks.in               |  2 +-
 wic/de0-nano-soc-efibootguard.wks.in               |  2 +-
 wic/hihope-rzg2m-efibootguard.wks.in               |  2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in      |  2 +-
 wic/qemu-arm64-efibootguard.wks.in                 |  2 +-
 wic/qemu-riscv64-efibootguard.wks.in               |  2 +-
 wic/rzt2h-evk-efibootguard.wks.in                  |  2 +-
 wic/ti-am62px-sk-efibootguard-secureboot.wks.in    |  2 +-
 wic/ti-am62px-sk-efibootguard.wks.in               |  2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in        |  2 +-
 wic/x86-uefi-efibootguard.wks.in                   |  2 +-
 19 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbcl=
ass
index 4011739d..565a66e7 100644
--- a/classes-recipe/swupdate.bbclass
+++ b/classes-recipe/swupdate.bbclass
@@ -11,7 +11,7 @@
 # SPDX-License-Identifier: MIT
=20
 RO_ROOTFS_TYPE ??=3D "squashfs"
-SWU_ROOTFS_TYPE ?=3D "${RO_ROOTFS_TYPE}"
+SWU_ROOTFS_TYPE ?=3D "${ROOTFS_IMAGE_TYPE}"
 SWU_ROOTFS_NAME ?=3D "${IMAGE_FULLNAME}"
 SWU_KERNEL_NAME ?=3D "linux.efi"
 # compression type as defined by swupdate (zlib or zstd). Set to empty str=
ing to disable compression
diff --git a/classes-recipe/verity.bbclass b/classes-recipe/verity.bbclass
index 56e4f4ea..366aee21 100644
--- a/classes-recipe/verity.bbclass
+++ b/classes-recipe/verity.bbclass
@@ -9,12 +9,14 @@
 # SPDX-License-Identifier: MIT
 #
=20
-IMAGE_TYPEDEP:verity =3D "${VERITY_IMAGE_TYPE}"
+IMAGE_TYPEDEP:verity =3D "${RO_ROOTFS_TYPE}"
 IMAGER_INSTALL:verity +=3D "cryptsetup"
=20
+# The filesystem image protected by dm-verity is selected by RO_ROOTFS_TYP=
E
+# (squashfs or erofs).
 RO_ROOTFS_TYPE ??=3D "squashfs"
-VERITY_IMAGE_TYPE ?=3D "${RO_ROOTFS_TYPE}"
-VERITY_INPUT_IMAGE ?=3D "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
+
+VERITY_INPUT_IMAGE ?=3D "${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}"
 VERITY_OUTPUT_IMAGE ?=3D "${IMAGE_FULLNAME}.verity"
 VERITY_IMAGE_METADATA =3D "${VERITY_OUTPUT_IMAGE}.metadata"
 VERITY_HASH_BLOCK_SIZE ?=3D "1024"
diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.=
inc
index c945378a..da48b47f 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -32,6 +32,20 @@ TEE_SUPPLICANT_IN_USERLAND ?=3D "0"
 PREFERRED_PROVIDER_factory-reset-helper ?=3D "factory-reset-helper-file"
 PREFERRED_PROVIDER_factory-reset-helper:ftpm-stmm =3D "factory-reset-helpe=
r-efi"
=20
+# The read-only rootfs is described by two stacked settings:
+# - RO_ROOTFS_TYPE: filesystem of the rootfs (squashfs, erofs)
+# - ROOTFS_CONTAINER_TYPE: container around that filesystem. Empty for non=
e,
+#   "verity" for dm-verity.
+# ROOTFS_IMAGE_TYPE is derived from both: it is the image type that is wri=
tten
+# to the A/B partitions and packed into the swu.
+RO_ROOTFS_TYPE ?=3D "squashfs"
+ROOTFS_CONTAINER_TYPE ?=3D ""
+ROOTFS_CONTAINER_TYPE:secureboot ?=3D "verity"
+# Derived from the two settings above, do not set it.
+ROOTFS_IMAGE_TYPE ?=3D "${RO_ROOTFS_TYPE}"
+ROOTFS_IMAGE_TYPE:rootfs-container-verity ?=3D "verity"
+OVERRIDES .=3D "${@':rootfs-container-' + d.getVar('ROOTFS_CONTAINER_TYPE'=
) if d.getVar('ROOTFS_CONTAINER_TYPE') else ''}"
+
 # Watchdog to service by initramfs hooks during lengthy operations like
 # partition encryption or factory reset. In our integration, enabling
 # fTPM/StMM implies a U-Boot-based firmware which may enable a watchdog ea=
rly.
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 2b14bfb2..1b908483 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -158,12 +158,8 @@ header:
 local_conf_header:
   secure-boot-image: |
     IMAGE_FSTYPES =3D "wic"
-    IMAGE_TYPEDEP:wic +=3D "verity"
-    SWU_ROOTFS_TYPE =3D "verity"
+    ROOTFS_CONTAINER_TYPE =3D "verity"
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
-    INITRAMFS_INSTALL:append =3D " initramfs-verity-hook"
-    # abrootfs cannot be installed together with verity
-    INITRAMFS_INSTALL:remove =3D "initramfs-abrootfs-hook"
=20
   secure-boot: |
     IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-signer"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot=
-snakeoil.yml
index 569d2a5f..13b23a16 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -17,8 +17,6 @@ header:
 local_conf_header:
   secure-boot-image: |
     IMAGE_FSTYPES =3D "wic"
-    IMAGE_TYPEDEP:wic +=3D "verity"
-    SWU_ROOTFS_TYPE =3D "verity"
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
=20
   secure-boot: |
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdat=
e.inc
index 699c9619..14617b91 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -21,7 +21,7 @@ python __anonymous() {
=20
 include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
=20
-IMAGE_TYPEDEP:wic +=3D "${RO_ROOTFS_TYPE}"
+IMAGE_TYPEDEP:wic +=3D "${ROOTFS_IMAGE_TYPE}"
 IMAGE_FSTYPES:append =3D " swu"
 # input is already compressed
 SWU_COMPRESSION_TYPE =3D ""
diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/r=
ecipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 7e77a205..7d3bbe3b 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -21,8 +21,9 @@ INITRAMFS_INSTALL:append:encrypt-partitions =3D " initram=
fs-crypt-hook"
 INITRAMFS_INSTALL:append:factory-reset =3D " initramfs-factory-reset-hook"
 INITRAMFS_INSTALL:append:ftpm-stmm =3D " initramfs-tee-ftpm-hook"
 INITRAMFS_INSTALL:append:swupdate =3D " initramfs-abrootfs-hook"
+# The filesystem hook is needed for the filesystem, also inside a containe=
r
 INITRAMFS_INSTALL:append:swupdate =3D " initramfs-${RO_ROOTFS_TYPE}-hook"
 INITRAMFS_INSTALL:append:secureboot =3D " initramfs-sbcerts-hook"
-INITRAMFS_INSTALL:append:secureboot =3D " initramfs-verity-hook"
+INITRAMFS_INSTALL:append:rootfs-container-verity =3D " initramfs-verity-ho=
ok"
 # abrootfs cannot be installed together with verity
-INITRAMFS_INSTALL:remove:secureboot =3D "initramfs-abrootfs-hook"
+INITRAMFS_INSTALL:remove:rootfs-container-verity =3D "initramfs-abrootfs-h=
ook"
diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index b6d19ba2..ca4e0228 100644
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
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/beaglev-fire-efibootguard.wks.in b/wic/beaglev-fire-efiboo=
tguard.wks.in
index 0274745a..70779456 100644
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
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/de0-nano-soc-efibootguard.wks.in b/wic/de0-nano-soc-efiboo=
tguard.wks.in
index b61a68a4..63c7589e 100644
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
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efiboo=
tguard.wks.in
index 04ec65ee..b78e7275 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -6,7 +6,7 @@
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64=
-efibootguard-secureboot.wks.in
index 29096087..223455d7 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -3,7 +3,7 @@
 #
 include ebg-signed-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.verity" --a=
lign 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC6=
3DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootgua=
rd.wks.in
index c60fbc56..b6523252 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -6,7 +6,7 @@
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efiboo=
tguard.wks.in
index f902dcef..2f03bdeb 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -6,7 +6,7 @@
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/rzt2h-evk-efibootguard.wks.in b/wic/rzt2h-evk-efibootguard=
.wks.in
index ca18bec8..71bc6795 100644
--- a/wic/rzt2h-evk-efibootguard.wks.in
+++ b/wic/rzt2h-evk-efibootguard.wks.in
@@ -4,7 +4,7 @@
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62p=
x-sk-efibootguard-secureboot.wks.in
index 1e2f578a..8ab3bca6 100644
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
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 ${WIC_HOME_PARTITION}
diff --git a/wic/ti-am62px-sk-efibootguard.wks.in b/wic/ti-am62px-sk-efiboo=
tguard.wks.in
index d0c7ef44..66ab62ed 100644
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
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 ${WIC_HOME_PARTITION}
diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efi=
bootguard-secureboot.wks.in
index f441c4ba..73e3c894 100644
--- a/wic/x86-uefi-efibootguard-secureboot.wks.in
+++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
@@ -3,7 +3,7 @@
 #
 include ebg-signed-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.verity" --a=
lign 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC6=
3DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
 # var and optional home are extra partitions
diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.w=
ks.in
index abc0d6eb..9cae346a 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -6,7 +6,7 @@
=20
 include ebg-sysparts.inc
=20
-part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${ROOTFS_IM=
AGE_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --=
part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
=20
=20
--=20
2.47.3


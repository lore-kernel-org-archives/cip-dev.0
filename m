Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C1CA5FE5
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:20:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9457.1790939991891002964
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:19:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=e7wpNV38;
 spf=pass (domain: siemens.com, ip: 52.101.84.34, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkM6zEZRro5O8BYzV6q0lzVj/28OwgQnEInLd6KCHdPfbAqJzYkSAlZ73kFLWpZfFUb0Be4z+4iW94pPEkwhxlJzJey/UIYxR0jH1vDW/Uh2q0vW9NUEkHow/LG2KRlYrMNhhC+AaenNoQgVqvlmno6GK+c063GNPkQZhp/e9KWqpyq1ONMSIRf1Yk5lfy5Hy6d2Acluc7ATYweI/QmsX8mKLL+tIrodU758a8Yr6eJYw2HfWTpMq/r7Frt/xTbzMZQt3NPKVz+R6IDprWm6cJoYpARmQOaM7eAVm41LeKrOSQbdXobyLMFomqtMOIiqe3qClrQ/8Gh7MzCsugUqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4whojZq5xy4+O7r3CzwXSuWw70jKWnk7hRPP10XHd0=;
 b=I6w7tPIZXtLUTsvWUbUfZ09otEnFB/qFUvNBsD+O7AS4R782usTTjqM6DQDP7VdZoEVPsEorGV16ibe6dRAJT+4e2IGtXLt8WCblgA89KmO/ZKZT92eg+FaTnMnJSO51TlMxN3xQKVvjagkwKiIj6Kr8MGLhcIsTsishdqLjOUJVSmszzCWoIdz2ghSS0tFlcJoDIIKJAZ8TY0CHZsIRGMdwADmcp5dEedIIt2h03yMJXQG7Q339QQ6NhINGUqOt9YtUIfNpEBwAhZIURdBFTnmFdY1QjO77Wcaqmw7PwrBrZ3p/BvMa5RLaZeVWOwYxkVbOqnSKkyo2RoYiLsCwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4whojZq5xy4+O7r3CzwXSuWw70jKWnk7hRPP10XHd0=;
 b=e7wpNV38ekzvIDWlItUVI5PZ2hpU+Ftm1hI7JdCLhZoFnxbQ3yjKPwqbmpQXNV67zH9OxjGLaRTDxNafI/xvCrE7wUUKzLSfOCFL12HuRB0bI3gUk1aKFXuG825ZhfpERdrabO8AEQo69sC9Jxj75/h2qsqqUkTt61FEqL1NNEd3ia1AX76975eUkqfMsqNe4fLiSUaWxqFszpreWEMQuq0nyXcHdivAEIdO61Mw8KHc8c5CPKjShE/H7NPHWZIf66fj1BKxMZ9yX/FcikcqTELBHoLjKuKfesE7ewQ13JPQj+06M1cTQUUduPma+XY5z1orkSEyKJhoXAAP1LOkUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:49 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:49 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 04/11] wic: select the A/B rootfs image via WIC_ROOTFS_IMAGE_TYPE
Date: Fri,  2 Oct 2026 13:18:51 +0200
Message-ID: <20261002111938.3600786-5-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 58455c4e-7720-4c8f-1fa6-08df207711d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|3023799007|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	2839pje/lubCOpGceIYH8KdKhk3tdcUsT5qlMcjROB5nXfzlvMrhdfOYS/d776FLkAUgeNB67y2X3y6NdTWCp/vAWyPZI7+fpHetw3/Vn02HcdBJXc4BtiCABTmRzZ4UoiDLjEdZt7h9TUcMIPX+Y1GACaIIvZaohU/0GrqxLd9UMXnB7t5uB79tBjtXQ6JAAjPHt6hjaLgqqvGOsZj38KFePkD/M+MHZC80m2qa+s0+IPDbCvu/2qJfy9kc9dcBCfL7hX+pMMyKuopHR2puOX+7G14TaYsNtNwslHwBkXr8a8XkSQnuzyh+HJ+65TKmvzC0jAgFdwOJkobxJKNGxRwVuQ9iMAZhjadrOVoNOTyJcHZsWWYBN1NZv9fOrSY8lFVqfM4iB6XZSaCGkKLuJUav0WzxOoU3h7klEBwSCJWU2fuXJLcQF6NM3OSWaciAMsVMAhHuRrZrHiBjSJCPhTltydB24rDESm8FokyfmazKNZ9FtSQ9GdVXdqqdkSH70cONWI952CevS9EFwKBjr7I+ImONdXPcrKWlLszcSaJ8bRUh1djwjQ0wFjwGj2t4cuROQ58Z9picYv9kFmKdpQWmyYztLNgchN640O5cAHfQWsdXFv8QWEkh4Gxw9PJzQdwQnIfiZuIeFHHjzDAZqH3/cWXH9mp7HWjLlJxi5zA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L6TD2yDu+SVP0fU4TApfOiwv3kURHF9+5apJztfXU3lXGy/ehDWpi8PX2+on?=
 =?us-ascii?Q?wC/9nIp0h8/yGJ8Y7EPI8WJLGz5ouA9psooA02CKFwjuxh1qPhaDBoSO7Mzx?=
 =?us-ascii?Q?KNxqyloh/M2YdcoQfbc6Htc436RQm6LKNL4gQVPg5lTO8Y9upyW7Pt2pbGLZ?=
 =?us-ascii?Q?SCYek7GA3tXkATJfa3vqEafleOHG931V6p4uS4Gmh3tvHj7+TndZWHb/6IL7?=
 =?us-ascii?Q?MhNgEX6CC/EWIObfesVv4gF46blwL+0jmU9MJD7GNwy5iEJQN0brfH2V66rZ?=
 =?us-ascii?Q?ZPj+WhHtR3kgTqa1TGbSacN73I8caFFj1534HY5tae6vEov6OpA+3DyZ3p4U?=
 =?us-ascii?Q?R49vpuKmeTfAsdWSNJG/fTwLYaMVhNX84lsSVUCcbna0ny0W8OCZe55gAlYH?=
 =?us-ascii?Q?hZMEBgZnVRg5gO5XjBZV/nLYN79SOLOF3NVwlzjaJoRxwTmcunqvcXDi2j4L?=
 =?us-ascii?Q?25Qjs9a1VZN8IzDVLCgGR/S99+NY6h/U+v/ieUeq2FJoI4TjwkgRvJvkaKEU?=
 =?us-ascii?Q?vayznnhIXCrEVIGHBhhDLW/5ttywKcWMk+RPuxV6J2ihoaCdygNI6+SP79ST?=
 =?us-ascii?Q?DZ1hl0K9FuUEd26W9EhaXLgDTYergGCZ7uKPFCwGXKxKDtbMcQ8BY54jUGEl?=
 =?us-ascii?Q?x/E0i/e52hFp3hXs/ydyGxFCbbB71tjLNV0c0cSq5h5AuCgSDzk8qxHKAT3y?=
 =?us-ascii?Q?BMD5MHSZcnwFXKXzX3oiu5WwjmqdHhe6odMl5HiiVI5bQQDmNRKZ7ibF1xTl?=
 =?us-ascii?Q?iUD1cmfyVh+NKGuh8VrV+/a8zNAKtOMZqm5/Hg/ZwRpCZ32twufKurjoW/0a?=
 =?us-ascii?Q?LU22eV/SbqlcNZJ7oytOOwDtxFvOIHlAdbahl36RwEnybu9VbZ/h3j8+QpO6?=
 =?us-ascii?Q?OCkXt7yNUvCcMuaMkF042yOjJvVwDErD0eQ/35y+fnkoHFHGde3QrzrlmAOD?=
 =?us-ascii?Q?C7C3M9C+TPW7B2WNE/HWyq6B1270bKkqQNmth3YiDfs5ehKcD3a1bStQ1Xu1?=
 =?us-ascii?Q?m2gNONK+Zc3WoHLgmMYLSwAk90rE4p6Af/IN/CfPQ4lyt7Tvl97uDBiFfEpe?=
 =?us-ascii?Q?gVM0YdY6YI8fqzHNBFm4JLcOQySc3C7rsm/KX11jgiznuYt83pRWJcMMgU6i?=
 =?us-ascii?Q?xhhI10NP3aTvezxldY39hbw7YkVh2jRBM+P/jm/Xm2eui524TYXfYsdmew6I?=
 =?us-ascii?Q?bPTgIGaGjtLtm/crKiKf7TY/yFuBubVpA4NvsWnkXn5Ec76dY57bmX54V7wb?=
 =?us-ascii?Q?KjIAt4MAknaYStQ2vAqjOmwKjvlZ8megq40IhjcA8rfSorp4vDKRUUWGIgLf?=
 =?us-ascii?Q?72wLA/ikkCK791+eFHDtG268FGv4JHBQV4QUVi6m6DNdnSjgfLvDp6cIZ39a?=
 =?us-ascii?Q?mp4RKUaGZ00mjvgZ7WktTmfg7V7XFKtKHt4UcaXJDAcRS6uSxKhoIVnkjDw8?=
 =?us-ascii?Q?qBOWBCprl9TIhA8haqs9ONY3up8grjrwLf0cYJ3Lst9ZMTUrij0JdSngvvcs?=
 =?us-ascii?Q?jQJrHF1MjUTE4L93eibb3bCsDza2UK/hDPGfjnLMIMovq4K8tqx0Kn2FyZS8?=
 =?us-ascii?Q?vlhnSqVKEZnPhKEb7ZZeeDwd63MwVwecXPv8PAzyTFozwbNYjnCKcwCxKrPH?=
 =?us-ascii?Q?sPC7OL3iv0lR0S92JpMzdmPZpPOvdvgSM/xnKVg0krsbM8QdTaW7UB9oGpys?=
 =?us-ascii?Q?L451yKTxk77MZhgqb+RsW461776yMAegrVtyPOtL0enpmdl0zgnb1xKb/e+1?=
 =?us-ascii?Q?KAXflQLF7H08xEm1tyHtlbLjICFspl8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58455c4e-7720-4c8f-1fa6-08df207711d6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:48.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBt31I2jS/+62oberTWpRut6iWhhv+nMrIFx4y4TptQAqpo8HwQOVDIe0OYt/LbIHoC64924V2D80BXmwWTpJj++hVEqp3qY8XOtWc/sGqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:20:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24407

The efibootguard wks files take the rootfs image from
WIC_ROOTFS_IMAGE_TYPE, which is verity if RO_ROOTFS_VERITY is set and
RO_ROOTFS_TYPE otherwise. cip-core-initramfs installs the verity hook
via the new ro-rootfs-verity override instead of secureboot, and the wic
plugin adds panic=3D5 for the verity panic so that EFI Boot Guard can roll
back.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass                    | 3 +++
 conf/distro/cip-core-common.inc                            | 2 ++
 doc/README.secureboot.md                                   | 3 ---
 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 4 ++--
 scripts/lib/wic/plugins/source/efibootguard-boot.py        | 3 +++
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
 17 files changed, 22 insertions(+), 17 deletions(-)

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
index 0f8ef04b..65f3ec07 100644
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
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index f6d16310..1e011d9c 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -97,6 +97,9 @@ class EfibootguardBootPlugin(SourcePlugin):
             else:
                 cmdline +=3D " cip.verity_root_options=3Dpanic-on-corrupti=
on,%s" \
                     % cls._get_verity_opts()
+                # reboot on a verity panic so that EFI Boot Guard rolls ba=
ck
+                if "panic=3D" not in cmdline:
+                    cmdline +=3D " panic=3D5"
         if source_params.get("abrootfs_root") =3D=3D 'y':
             cmdline +=3D " cip.abrootfs_root_options=3D%s" \
                 % cls._get_abrootfs_opts()
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



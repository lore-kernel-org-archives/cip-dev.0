Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11271.1795689023333075748
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=D5KkdkXt;
 spf=pass (domain: siemens.com, ip: 40.107.130.6, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKJdZ4lIdGSmlos6D61JLk/Vwnv7wP7Fj9hqLOyCXMDCiYsxzYAHti4q2VNkUmAc5wLxSdjHzMB5CZ/8Q8+fCbpwCudscyS8Ek0N2H0DnKPgsjV2TjZpyH8/EneF/O0My8ojTVaRGRI86k6lCdY0WUY/jUzBZ8cKJI+e9fPpL5oXI9x2aq/qGnLbd+DGLbHS0NuPxrzcguUgw5k0878CegZ1/2+fa1SWGZ3g3zpzged3kWbE+T9HJ8ao51RjiYDKwgE1nz2djpAv69B0YJtoBO6STzmLBwCH8WSv6adFA1L1EbC29rakb9Vsv3/HQRKtVKtXbtYHLesNgOWfyCoDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVo9REiJhKRMgHGjd4/vliXdkjHFK6O8Z2Wqob8Qxuc=;
 b=Vox5mMjroZ1P5n1J8c4tEsSgIY2Md8Ai00mmaZbc7rrvyCFhQkvHkupoT+5K5vUob6vb8LHb4Fxr0I2Hpl5/u45tpNtpgGKbt7S4b9jcSL2we28WSl37BdRdIcNhaxJFfoBc8XN0PL/Gl6kKSHohFa8balf70H3fAjmw2kP0ddkpKzGlx2BmPTunO5KTYdlASDwYUKCikf3FC1tjF+es0va4pPnO/a413hU3V8hUBY2EdfeMl42Zu9R8lXpjk+Cb2MhpOsq2y396cXLpRD+H9S8CQ/hZCpxk93wPk8dwLmJjb00Qi8OGb/8okV4rATquM1ZeW4l7OYxhQYHTpAv4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVo9REiJhKRMgHGjd4/vliXdkjHFK6O8Z2Wqob8Qxuc=;
 b=D5KkdkXtKxA3U/8zYucaAkUf7LpJfjxWj7mkpjdbEk817PCRQVnkhF/Pwm4nap4ecZ7JzSd6Ir/adfEDWJoxYX1tLBHe/Jw/3D1MYXobAjVdlL3gxbCXvdD7P7cmRrImkbwkwReZBSjpefF2g9uND8F5BNP9TyAHpCucF5VAXv9/GIW5Zw73uxR+jzSf6nH59g0ywtoErKCOXXG1jAmijc8Br9wN9fy9y9OI2IBeZdzl90rvLlNXadT9qGfxEAOQvOSWtrotgsCBPHRbJe2cO9K1NDez7YpwItVN14t9NVaR5Q+BPHKcXPGjJnvjaa9lI0fK/uXNsQF7Ld3Z9wYO/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by MI7PR10MB209735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 10:30:21 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:21 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 14/21] cip-core-initramfs-dracut: add dracut initramfs
Date: Thu, 26 Nov 2026 11:30:00 +0100
Message-ID: <20261126103007.2922985-15-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|MI7PR10MB209735:EE_
X-MS-Office365-Filtering-Correlation-Id: 2430fa8f-1243-47d1-9d4d-08df4ba84630
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|261022115727099003|261022105027099003|261022075727099003|261026140227099003|261021121427099003|261028144727099003|261026121527099003|261102123227099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|261009221727099003|22082099003|18002099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: k5hPQzz60jEjMUHYqnkIfco0FjiPk7i+zGWIeMxC57BpAlJNzT3XLySclvwV9FJsNKvupXhgiijOzgYnnKpxynvIFZmAJS8kRP1wsXCnB5wDY5sXWc6hUWX8Rqb8EyZr1uUtefiRUVg9SKe28FOjS5HeKsrkhV6LiXxKor/pgC6Ynusy6NW2fITSyemShBeuyUP1fKUzzAIz7TCWJ+y8zYprxzcVIrGttKE++hdIyfTQqIM7DThw+LiSern7LweqlLlFgZfMXmdZT9wxKAledYse6QUk/RUL2I22m60C3UeKCfAW0jj1OQujpzfBKFDWioK8jlX77XejRSt1m+Y/YGEmbyiAi1cZqPQ3eBUN92tWAUT046Kdwy41487q7LyntwlE4appNQ5KaNv/0SHNnh8VJuqshxDCuteFZ/oCA7W/YBRB2QoH6zuiF1jcMiEcC27M44n+t4HBRpTKrX1TKtJ+XxlAEUhDUtH2/tFFTkRBl9t6zCfuNIXk0ERaX6tLwpzSrAtAf4P/qlU38bjP8cUAzNT/AZ83cnGJZv3oPSXuOTpNL4CCst+qQn79Yc1++gCUZts2RIbskecFlLPdxPsF4/bpSEFHkIsDIBHIOjBYpgSW4jF/vxD3U5TKEIpDvh/nCTPy9CRjEZF7vGJanAIaIpy0Rr1Y7nJkySUS/7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(261022115727099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221727099003)(22082099003)(18002099003)(55112099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0aplvyM0a6MrG3nW79jx0006OkYwCnPM5zbm50ItnM7+12ffZ3OxkPvTRvhi?=
 =?us-ascii?Q?2kQoK/QeFc7GE/bnQF+d4kR7YhQObDO0WKAdx2XZTwgp/1DtB9pXhpm3lQ5V?=
 =?us-ascii?Q?vE1yEZ7RvT2p3J4hodI53f8OHBSK9116MNGdxzmxN/AchSsgo/OTBd+5UyiF?=
 =?us-ascii?Q?qYTGrDNVjrPRT4XloGl5QqZy8aJFB6X9Xecuq2F1h9W63hLRwe1DAYNadhmU?=
 =?us-ascii?Q?9nrOrmAWRYdK4ur5tp514l5ABsb6Kbs6CxSqXnEU92CfA3IwPaifxlK3QVub?=
 =?us-ascii?Q?BVNen3UTKM79dtN2E8jkWEr/sat7U9jEobiV8cdUSAtXcxPA/l9+2gSwbFw2?=
 =?us-ascii?Q?Ol3rkCEKwA15/fHuf0HVKRd6a2NLoG52etIBO29NltIJzzKm8bFI9RAQkgbO?=
 =?us-ascii?Q?CpqFKI9z48mJtUM5GsV64OoIXCHmhINOxS2shiwa4gMfCV3+bLQQwEtyy17t?=
 =?us-ascii?Q?5zJ6cQeTBpqXBfgKfqA58jeHN/wfbPhw9+O5yqhIXSGjeSavmio7sOBUW3Yu?=
 =?us-ascii?Q?GbLc7gLGg9sNVAA6mOOJIbQmkctRMMKpf2XvgBxgaz2if6T8eOHJMwfS3OM/?=
 =?us-ascii?Q?SPiemUswzcUMsw8CUkTA1KeaZs3qJecKUVJ7Z47GIGtQs8z69Cr2ngy9kTCX?=
 =?us-ascii?Q?0cF4JOAhAAqA8cSkhIvvs6uJGsd4FCvhIcU2niY6zc2f34AwOfhSUTPJZhL0?=
 =?us-ascii?Q?gefLQ2Mmx4QOZlNl4Kmwehhocpj19dHsDVrLkrzDL7A53KY3JAyti3NXOqwJ?=
 =?us-ascii?Q?LnDwcm+/XBFq1Iu+75e94GfcfESnrFEiNYjwIvNSviJLJiqawS37Y9aPESyG?=
 =?us-ascii?Q?x7543kxaDCrS+MIrKYTRlQmZ7ypGDgivkR5vQ58CbGIdbObV/MOAP8th+3RM?=
 =?us-ascii?Q?HqSctGenOH5sOgj3Y6yU+1Ou5uq6meIeGWjFzxKhoeinEvpAAUA78AizvyuP?=
 =?us-ascii?Q?WeUe7tS3BkL9rRJz56mZGU0DGlFyqxcqZTiONkMkrgWmsY5/Km25QBMjo3Rm?=
 =?us-ascii?Q?Jri7CHBHff8JC2xF7Xmer3mH/wImRXO/uEgbnFzp8M+oykpYId4mbw0f4cFc?=
 =?us-ascii?Q?8Iz50vreO2Ht9pqlKoNhdWnzo4J7bSugeV1dS6hH59UyuCQw8hDtG73LWg9g?=
 =?us-ascii?Q?pMxS7xdAqZuG3FLXitJdl7EI5Y0yzTk+AYwnh/pAS8QpPTOUDz3k+dfwCkf9?=
 =?us-ascii?Q?l95/6yprOEi507FUa+jM2JZXnS2lWfaCKlcRL/Uwo/ZSCT/7NpQvh2yEyNjO?=
 =?us-ascii?Q?YXMLgmX5jjvAREDz++aWVUjKpMsvWfzSBQFpJt2FQ3Bqkew4kb0BQ+OEVJKW?=
 =?us-ascii?Q?17y5a23ikSvP8rlY2Lh69WZX8wmhsRATEY4jHFa1AKK7XPjH7rO+VcLvau8/?=
 =?us-ascii?Q?1uigkworMoII6MNph4lpy+cieQUrhp2IFcRI2IJWFxTlx651lWQAY3l2tKHE?=
 =?us-ascii?Q?12JPUrZlw8MXd5+WMT79QeYESDecBLYYmbXogrv4dHlDduOVlsoiYnEPICO/?=
 =?us-ascii?Q?5Els7hptI+5Zllhcy/jr7CnEUUm0EjLtF1ow4nl8HwJX573O6OsRxvZQjpV6?=
 =?us-ascii?Q?x6Rz9izZyem949MDnz3VPuS0Mxp7vLnwdalCjFeQVaH39x5YUZQAc0jseZwm?=
 =?us-ascii?Q?xVpmeo9M3p1eFZxflPL2c2cy7a28TMnLCVGrTxekqOubsO1EvhOjGtewMJpl?=
 =?us-ascii?Q?nhFIyDmgX8UvgQjFfzCv9kBM8ANeRI90TrRTPSfVQ/gMALcSaBK8IASCpahf?=
 =?us-ascii?Q?iWDtQJOXCfrI4+Ubd8DnEMonhHwMr+s=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2430fa8f-1243-47d1-9d4d-08df4ba84630
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:21.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDX+2LjaRjiqUdCx5OscbB2FuVAebg6bxmiGabIX4AG7i5OracR6dFOjnsNID2d/bfjKrjkQ5f+0KlMPVNFez/jLf/O2JLGqd1BVvNfi5dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR10MB209735
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25096
Content-Type: text/plain; charset="utf-8"

Debian forky switches the default initramfs generator from
initramfs-tools to dracut. Add a dracut-based initramfs so that CIP
Core images can move to dracut before that switch and the dracut
modules are tested in advance.

Trixie is the minimum release: it is the first release whose dracut
provides the features the modules need, and it allows testing the
dracut path on the current stable release before forky makes it the
default.

The initrd is generated with --no-hostonly, as it is built in a
chroot and must not depend on the build host's hardware. The overlay,
verity and watchdog modules are always included; crypt and
factory-reset follow the encrypt-partitions and factory-reset
overrides.

kas/opt/dracut.yml selects the recipe and sets the dracut override, as
the other kas/opt files set theirs. The distro configuration derives the
systemd kernel command line style and the verity container from the
override, as dracut has no other A/B root selection than the root hash.
Building the dracut initramfs without ROOTFS_CONTAINER_TYPE =3D "verity"
fails at parse time.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass       |  4 ++
 conf/distro/cip-core-common.inc               | 10 ++++
 kas/opt/dracut.yml                            | 20 +++++++
 .../cip-core-initramfs-dracut.bb              | 54 +++++++++++++++++++
 .../dracut-tee-supplicant_0.1.bb              | 28 ++++++++++
 .../dracut-tee-supplicant/files/install.sh    | 12 +++++
 .../files/installkernel.sh                    | 10 ++++
 .../files/tee-supplicant.service              | 26 +++++++++
 8 files changed, 164 insertions(+)
 create mode 100644 kas/opt/dracut.yml
 create mode 100644 recipes-initramfs/cip-core-initramfs-dracut/cip-core-in=
itramfs-dracut.bb
 create mode 100644 recipes-initramfs/dracut-tee-supplicant/dracut-tee-supp=
licant_0.1.bb
 create mode 100644 recipes-initramfs/dracut-tee-supplicant/files/install.s=
h
 create mode 100644 recipes-initramfs/dracut-tee-supplicant/files/installke=
rnel.sh
 create mode 100644 recipes-initramfs/dracut-tee-supplicant/files/tee-suppl=
icant.service

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 0c30f131..c92ec34e 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -39,6 +39,10 @@ python () {
     if 'secureboot' in d.getVar('OVERRIDES').split(':') and container !=3D=
 'verity':
         bb.fatal("Secure boot requires ROOTFS_CONTAINER_TYPE =3D \"verity\=
", "
                  "otherwise the rootfs of the signed image is not verified=
.")
+    if 'dracut' in d.getVar('OVERRIDES').split(':') \
+            and container !=3D 'verity':
+        bb.fatal("The dracut initramfs requires ROOTFS_CONTAINER_TYPE =3D =
"
+                 "\"verity\": verity is its only A/B root selection.")
 }
=20
 # Warn at build time: a warning in the anonymous function above is repeate=
d at
diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.=
inc
index 9f407a80..a9ff9b89 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -34,6 +34,15 @@ PREFERRED_PROVIDER_factory-reset-helper:ftpm-stmm =3D "f=
actory-reset-helper-efi"
 # The dracut factory reset module is only triggered by an EFI variable.
 PREFERRED_PROVIDER_factory-reset-helper:dracut =3D "factory-reset-helper-e=
fi"
=20
+# Kernel command line format the initramfs understands: "cip-initramfs"
+# (initramfs-tools hooks) or "systemd" (native systemd verity arguments, u=
sed by
+# dracut). Other initramfs implementations can set it.
+INITRD_CMDLINE_STYLE ?=3D "cip-initramfs"
+INITRD_CMDLINE_STYLE:dracut ?=3D "systemd"
+# Symlink below /dev published by the dracut embedded-verity module; used =
for
+# the systemd.verity_root_{data,hash} kernel command line options.
+DRACUT_VERITY_DEVICE_LINK ?=3D "dracut-embedded-verity"
+
 # The read-only rootfs is described by two stacked settings:
 # - RO_ROOTFS_TYPE: filesystem of the rootfs (squashfs, erofs)
 # - ROOTFS_CONTAINER_TYPE: container around that filesystem. Empty for non=
e,
@@ -42,6 +51,7 @@ PREFERRED_PROVIDER_factory-reset-helper:dracut =3D "facto=
ry-reset-helper-efi"
 # to the A/B partitions and packed into the swu.
 RO_ROOTFS_TYPE ?=3D "squashfs"
 ROOTFS_CONTAINER_TYPE ?=3D ""
+ROOTFS_CONTAINER_TYPE:dracut ?=3D "verity"
 ROOTFS_CONTAINER_TYPE:secureboot ?=3D "verity"
 # Derived from the two settings above, do not set it.
 ROOTFS_IMAGE_TYPE ?=3D "${RO_ROOTFS_TYPE}"
diff --git a/kas/opt/dracut.yml b/kas/opt/dracut.yml
new file mode 100644
index 00000000..1f7be48a
--- /dev/null
+++ b/kas/opt/dracut.yml
@@ -0,0 +1,20 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 23
+  includes:
+    - kas/opt/ebg-swu.yml
+
+local_conf_header:
+  dracut-initrd: |
+    INITRAMFS_RECIPE =3D "cip-core-initramfs-dracut"
+    OVERRIDES .=3D ":dracut"
diff --git a/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs=
-dracut.bb b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs=
-dracut.bb
new file mode 100644
index 00000000..520e8cca
--- /dev/null
+++ b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut=
.bb
@@ -0,0 +1,54 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit initramfs
+
+DESCRIPTION =3D "dracut-generated initramfs for cip-core"
+
+INITRAMFS_USE_DRACUT =3D "1"
+# The modules are not extracted from the package names, so they are listed
+# explicitly in DRACUT_EXTRA_MODULES.
+INITRAMFS_INSTALL +=3D "dracut-config-cip-overlay \
+                      dracut-config-cip-verity-${MACHINE} \
+                      dracut-config-cip-watchdog-${MACHINE}"
+DRACUT_EXTRA_MODULES +=3D "embedded-overlay embedded-verity embedded-watch=
dog"
+
+INITRAMFS_INSTALL:append:encrypt-partitions =3D " dracut-config-cip-crypt-=
${MACHINE}"
+DRACUT_EXTRA_MODULES:append:encrypt-partitions =3D " embedded-crypt"
+
+INITRAMFS_INSTALL:append:factory-reset =3D " dracut-config-cip-factory-res=
et-${MACHINE}"
+DRACUT_EXTRA_MODULES:append:factory-reset =3D " embedded-factory-reset"
+
+# The module ships its defaults (certificate directory
+# /usr/share/secure-boot-efi-certs), so no configuration package is needed=
.
+# INITRAMFS_INSTALL is added to DEPENDS by initramfs.bbclass.
+INITRAMFS_INSTALL:append:secureboot =3D " dracut-embedded-sbcerts secure-b=
oot-efi-certs"
+DRACUT_EXTRA_MODULES:append:secureboot =3D " embedded-sbcerts"
+
+# fTPM: the TPM device is provided by the kernel TEE drivers, same list as
+# HOOK_ADD_MODULES of initramfs-tee-ftpm-hook. With a kernel tee-supplican=
t
+# (TEE_SUPPLICANT_IN_USERLAND =3D "0") systemd just waits for the TPM.
+DRACUT_EXTRA_DRIVERS:append:ftpm-stmm =3D " amdtee arm-tstee optee qcomtee=
 tpm_ftpm_tee"
+INITRAMFS_INSTALL:append:ftpm-stmm =3D "${@' dracut-tee-supplicant' if bb.=
utils.to_boolean(d.getVar('TEE_SUPPLICANT_IN_USERLAND')) else ''}"
+DRACUT_EXTRA_MODULES:append:ftpm-stmm =3D "${@' tee-supplicant' if bb.util=
s.to_boolean(d.getVar('TEE_SUPPLICANT_IN_USERLAND')) else ''}"
+
+# buster, bullseye and bookworm lack the dracut features needed here
+python () {
+    overrides =3D (d.getVar('OVERRIDES') or '').split(':')
+    if any(s in overrides for s in ('buster', 'bullseye', 'bookworm')):
+        raise bb.parse.SkipRecipe(
+            "cip-core-initramfs-dracut is only supported on trixie and lat=
er; "
+            "use initramfs-tools on other distributions.")
+}
+
+# driver of the filesystem inside the verity image
+DRACUT_EXTRA_DRIVERS +=3D "${RO_ROOTFS_TYPE}"
+
+ROOTFS_INITRAMFS_GENERATOR_CMDLINE:append =3D " --no-hostonly --no-hostonl=
y-cmdline"
diff --git a/recipes-initramfs/dracut-tee-supplicant/dracut-tee-supplicant_=
0.1.bb b/recipes-initramfs/dracut-tee-supplicant/dracut-tee-supplicant_0.1.=
bb
new file mode 100644
index 00000000..43a7de98
--- /dev/null
+++ b/recipes-initramfs/dracut-tee-supplicant/dracut-tee-supplicant_0.1.bb
@@ -0,0 +1,28 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+# dracut replacement for the tee-supplicant part of initramfs-tee-ftpm-hoo=
k:
+# runs tee-supplicant in the initrd so the fTPM TA can use its storage.
+# Only needed with TEE_SUPPLICANT_IN_USERLAND =3D "1".
+
+inherit dracut-module
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "dracut module that starts tee-supplicant in the initrd"
+
+DEBIAN_DEPENDS:append =3D ", tee-supplicant"
+
+SRC_URI +=3D "file://tee-supplicant.service"
+DRACUT_REQUIRED_BINARIES =3D "tee-supplicant"
+DRACUT_MODULE_DEPENDENCIES =3D "systemd"
+DRACUT_INSTALL_CONTENT_FILE_NAME =3D "install.sh"
+DRACUT_INSTALLKERNEL_CONTENT_FILE_NAME =3D "installkernel.sh"
+SRC_URI +=3D "file://install.sh file://installkernel.sh "
+
+do_install() {
+    install -m 644 ${WORKDIR}/tee-supplicant.service ${DRACUT_MODULE_PATH}
+}
diff --git a/recipes-initramfs/dracut-tee-supplicant/files/install.sh b/rec=
ipes-initramfs/dracut-tee-supplicant/files/install.sh
new file mode 100644
index 00000000..7fb9a530
--- /dev/null
+++ b/recipes-initramfs/dracut-tee-supplicant/files/install.sh
@@ -0,0 +1,12 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+# Inserted into module-setup.sh by dracut-module.bbclass.
+# shellcheck shell=3Dbash disable=3DSC2154  # dracut sets moddir, initdir,=
 ...
+inst_simple "${moddir}/tee-supplicant.service" "$systemdsystemunitdir/tee-=
supplicant.service"
+inst_multiple modprobe
+$SYSTEMCTL -q --root "$initdir" enable tee-supplicant.service
diff --git a/recipes-initramfs/dracut-tee-supplicant/files/installkernel.sh=
 b/recipes-initramfs/dracut-tee-supplicant/files/installkernel.sh
new file mode 100644
index 00000000..a264b11a
--- /dev/null
+++ b/recipes-initramfs/dracut-tee-supplicant/files/installkernel.sh
@@ -0,0 +1,10 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+# Inserted into module-setup.sh by dracut-module.bbclass.
+# shellcheck shell=3Dbash
+instmods optee tee tpm_ftpm_tee
diff --git a/recipes-initramfs/dracut-tee-supplicant/files/tee-supplicant.s=
ervice b/recipes-initramfs/dracut-tee-supplicant/files/tee-supplicant.servi=
ce
new file mode 100644
index 00000000..276b671f
--- /dev/null
+++ b/recipes-initramfs/dracut-tee-supplicant/files/tee-supplicant.service
@@ -0,0 +1,26 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+[Unit]
+Description=3DTEE supplicant for the fTPM
+DefaultDependencies=3Dno
+After=3Dsystemd-modules-load.service
+# cryptsetup-pre.target is passive: pull it in so the ordering applies.
+Wants=3Dcryptsetup-pre.target
+Before=3Dsysinit.target cryptsetup-pre.target
+# Stop cleanly before switch-root; the rootfs starts its own instance.
+Conflicts=3Dinitrd-switch-root.target
+Before=3Dinitrd-switch-root.target
+# No dependency on the TEE device: ExecStartPre loads optee, which creates=
 it.
+
+[Service]
+Type=3Dsimple
+ExecStartPre=3D-/usr/sbin/modprobe optee
+ExecStart=3D/usr/sbin/tee-supplicant
+
+[Install]
+WantedBy=3Dsysinit.target
--=20
2.47.3


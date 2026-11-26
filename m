Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11362.1795689021983219042
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=rxqI5ku3;
 spf=pass (domain: siemens.com, ip: 52.101.83.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jw2vfvC8uAI1AxomLqpMIz6PZ7F1VjjxDYPubQjEUVvZ9onVvmZBiu1vojAc5uI3C8/JKRYC1sbIczSrNd2KqdLNEVNUuzdF0B0PQyUZvWgHOdEBKTfvrBdoVV+ejfjO3OBR2daZpXlR56EvVnN5xs0WD+A5fuRYnaId0PXjJj6/Z2av40l6oX19HnHcNVIJc2CatlphRTHWrbc6XTHj/yJZERhCNDfwIYwVMuHjjbfNkE76XCcSxN+5CO4c2sx7WNUEQymXNYXmxd1dKcpBaEs1Uwbq5HA73MMcy0YgPbgv0/104GzdR15stsc4IANDzFEmrsX7EwCs93PqTxURBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4uEGVyy1dpOYgSjNA7olQTO8ZNNUMLuTqPpE8U8ios=;
 b=X/K/x2D2Q9Tkc5EGK1TSmJawbe9q6i+4IUMj94y3wfr0P7dl14Gxwa648vGxKYpIz1DDvj8HKsmSkpn1aTYGD2GgwK4qSI+ZTo5FR1GBfWdwGKoramDiS4Ycot8evSuO8Ur6IwhULFUS7+cpzhm+8NC2Qu/wFpnNKwCXCpOPx0QQI46oQgpW/2cbhv8eoy0TX+/8/Ha0Cp/9woROqFWOS/lxL2uebWzZN4b1TsglDZiBY5d9GwZqSjMoemrAdEbjBxBK5hQ9UfsfLbZKEyTt7nDlooYp2P+jvsVppWIwfH2kKmbATbua6yawlb26vDSza0bEjoioGOMqVXZIwnfWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4uEGVyy1dpOYgSjNA7olQTO8ZNNUMLuTqPpE8U8ios=;
 b=rxqI5ku3LMxatWPD9ue/sxy3ABk4piIPLDXhPF5bETdv6Noo/8ZG7Zx43vq647uFHjxr8jSrG48nLGOUljz6g0h8Sc01as977t0pBCgjlZVcEuZ3CKcI2PwlWRJN2BMgrITFxzkPwJnFxtec1hZ+0eNTGi7mROt9BU0AfQJCkm7hAhLFdNypztU5UsPqps68Qs3Lgkz8xsyfL3HCJXDIKHkqX3YuXvVt9hSDK3tT0Qw/fFs84zQEPGd+Xm3NGTLV4Hq2VY39rv4bWTaFZR4MQMmhDE2IJWXpWiK62zE8XHi1Z1d2lNGRILacwLDc4jkIgcdaWNzUk1Be4Z/rz1iM1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 10:30:18 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:18 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 08/21] customizations: make systemd watchdog timeout configurable
Date: Thu, 26 Nov 2026 11:29:54 +0100
Message-ID: <20261126103007.2922985-9-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: e2dc45df-8109-4e5d-64b9-08df4ba8441e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|261028144727099003|10067099003|11063799006|261022115727099003|56012099006|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261022075727099003|261026121527099003|261102123227099003|18002099003|6133799003|55112099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: sS78yZcI4qOIGri84bjTAkBWA0H75dALu4znRsetXHTW+pe5ZCuOPhIOe3eYYOwAKsEuWNF3joboBMBZS9gDpsoioFioDQPGBXzV0ihv609+W6kQscxPa2ilZ8TBYGCkycixHLqoDlDUM1Aw7v19+1Ggh13ie8tqosxb36IXPOMeQ0ZW/FVpqPXgkaHL+c7FXmm8CnqECmq8RUvwMIuJ4MNa9A7aM56PxwXx72K5QX79ZOG3/OoS1DONXtm9PTpgjRL6i58C3nH2/SIrs/g1GLCpTPHhoJtI7HCAzYT8BX7+Wuo7diRkXGzonT6ACU0aDUuSOQJpoIIHU7mljkeoH7lohixStg9Yl0gzDHWqrSUlhaPoGD3hnp5j4EyuFfJyIlTjD4SngYqmtwq00ZIFO57mRrbLaudGcuuYEHz19pEftyYpKD0arGHNH+yyP7ytR7BXSC0W7RzDIBagZ6snBCluYs1NEu0AYveMiUWLDNPcvXUFbniGFI95N1pq4x7cvKlbP+OiOrgcGPwBdsi2pYGaty2WibcmZZdO+4IBFCfC+AahvjYJFC6oOZRahkcpI5N8ywdDqyLYyIT9CfTserpkogihUxWbeUyIm7iph/ciYxuetis91grteYl2+uIkeTzmVndatECInkY+ElMl1eRiI/Lpwzzwb3dmFL5SlEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(261028144727099003)(10067099003)(11063799006)(261022115727099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003)(55112099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NhnRmbb5+OxTaECxV9tT29oUHgVLFUUNw5cxgqb8h+aDJHug2SZiANfcR+As?=
 =?us-ascii?Q?aWRE5MDVC0HIHbPzCT+dIb8JJHBZjD5uhj/rQ3jnmZ54zDLIlhhla8O2beB7?=
 =?us-ascii?Q?iKcUeWW9GCs+Z9jl1sfyByz6DlrOoztMzblVXX9AXZDAyPZ7V8zK3+eV81do?=
 =?us-ascii?Q?7UQlqszoUZ+AHt62f502BPRJMV17jJvrRXF7PwzjuA7HYmH85zgJG1Gfr8Ch?=
 =?us-ascii?Q?km6yCUNnzgCE3QT6PkNqcvXTwQ/hHWGcopg7fjMsdUwBWk5jOIK6mO6euXQA?=
 =?us-ascii?Q?m0KWlaWcVTtoRbp1BLdWYo3JqYo6YkMECf4MWo8hyhsnaarPUKojy9cNz6Fe?=
 =?us-ascii?Q?/fNbJL2+dVMA4s4SV7sBs7z0p3IpK61IUFGRXx9ndXHsTaZXcl5zdFpKkIEn?=
 =?us-ascii?Q?bvCU60TzHHl+4zqEaFPagIMGZHYAaHPXIp0APpt/MUr9GRprFwj7hiHFgeim?=
 =?us-ascii?Q?LWqEVIA23qg+f0Wxuelk8AxrMQljKFDUKZQFIvxqLjPJGzZIJUcW3NHu50ku?=
 =?us-ascii?Q?2jVsAYJNcXIn5iA/a2sE/epQmgMQXk+9t+Qos2goRLQT/AZOXmzsHMQXDKL+?=
 =?us-ascii?Q?fXDTEaMBcCJ564nuNgmUbHMyCAB5N3A+FOt9ZpX7D3nPZmDE5fN4JwjwZQIR?=
 =?us-ascii?Q?qbe5R6biNE0vKch3JV0KojqgTFNrwqR6DXte2b8gGmiYGA3F3Kh/w1ojnIRC?=
 =?us-ascii?Q?R4hlYeTvgNs/29tISKkOQRMC2GmyyzpQlwk7j0weblam0suktkBheEZVW4/c?=
 =?us-ascii?Q?foCf9YTQl4vsVvsFZLCnVHXczCbmaDz/xDsbOGcbn9MIGOHcNP/iwBpAycAB?=
 =?us-ascii?Q?k6MELis80Es2uitHsiQz+JhvFxg+zpfqwYMIR8OpOnH0gvjZ0C620i8Xr8dg?=
 =?us-ascii?Q?fD7h5LEnIgVxAF1d5jmImb3389vB1CvWpAuNRYgJJGyNvE3GJub//WzJiQo5?=
 =?us-ascii?Q?DQNlDMP5VyvyFHazpKXYBMy+kKFF3y7NWilyHaOY49ka/QJ8XdhGsq9DmA3L?=
 =?us-ascii?Q?FmcLkLpn++yWTN8An1Je7kVuS2OjtgefRee4Qtcq8PPhM/dl5W6b16nWs8gG?=
 =?us-ascii?Q?21d5wwipGX3AM+b4YPgXpY6ginBq/YfLvK47PSJhEA2duCAs3lB9Umq7RYHH?=
 =?us-ascii?Q?oLuJkqTvqinKgjbijr0MWnnqm9TnUmxt+GhEB1Q4V1kEtiwOvnGteD7HFkNo?=
 =?us-ascii?Q?3fDjIhWcennP9fnY0jx8X7rNyvUMlSr9jURstu5jViJTcxoU2hrYvvnsZwJq?=
 =?us-ascii?Q?l/qjyKPYKZiYY4MTQ83uSOAF6vdCejColCi0kTae7xRKesCygsn9MPTTfm6z?=
 =?us-ascii?Q?bcfMKreyCGmRbzu0X51FmTR4AwajjbTLlVyWlcqFSNbLgEF9dXRk06TK1B0R?=
 =?us-ascii?Q?+SnTBg22AxHxqqX3Gkg6btK2u+3Kvyz5OxFSoVDshu5hBiyjTxIADRK3y+q8?=
 =?us-ascii?Q?R8jJVhH7aZNFNt3cdkXKI3Rzgl1MFZ7EP2DXYpA4wlVtXWOUIMhGmubNsicg?=
 =?us-ascii?Q?UFOugfwkEzOgptMeJFXAdWpqOUK2EiTgooVzrBoUyP0giKNYN8sUa26PxmUz?=
 =?us-ascii?Q?MjMWQKIIPk1sTFQP8tu6o9edB1xmvwLVo06+OrfOO6neKrCvFzUKXnhk86ao?=
 =?us-ascii?Q?7J83uI9ngpU9Sd+btQwkB31sE//nAsMq8WRej3eqQwmU0v5iTMPke8q/6ISM?=
 =?us-ascii?Q?ifjuppLKsdCaHasFVqOfTrXpxULuC+hFg9AC50iTc8lGuyGuTr2Hcwh6vF6V?=
 =?us-ascii?Q?pfw+5kqqb0pW2xYeNkip2RnIzxtN5gc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dc45df-8109-4e5d-64b9-08df4ba8441e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:18.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z45hiAWRPN08Suvvwqw57argD6nr/h1O+c5Hy4UDEB3qO4T0cq3uP/F23s0xhjC5uCr/ZVYMLw0HGBkUVHd/MTEDRGyZ0U2O+pAq1CXk69E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25090
Content-Type: text/plain; charset="utf-8"

The runtime watchdog timeout of systemd in the rootfs was fixed in
99-watchdog.conf. SYSTEMD_WATCHDOG_TIMEOUT sets it now. It follows
WDOG_TIMEOUT, the timeout of the bootloader, but falls back to 60 seconds
when WDOG_TIMEOUT is 0: that value means that EFI Boot Guard does not
enable the watchdog, as U-Boot or the kernel already started it, and
systemd still has to service it. Set SYSTEMD_WATCHDOG_TIMEOUT to 0 to
disable the runtime watchdog, as kas/opt/disable-watchdog.yml does.

WDOG_TIMEOUT now has a default in the distro configuration. As
INITRAMFS_WATCHDOG_DEVICE depends on it, machines that did not set it
before (for example hihope-rzg2m or x86-uefi built without the kas menu)
now also get /dev/watchdog serviced by the initramfs-tools crypt and
factory-reset hooks.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                                             |  5 ++++-
 conf/distro/cip-core-common.inc                     | 13 ++++++++++++-
 conf/machine/qemu-amd64.conf                        |  3 ++-
 kas/opt/disable-watchdog.yml                        |  1 +
 recipes-core/customizations/common.inc              |  6 +++---
 recipes-core/customizations/files/99-watchdog.conf  |  6 ------
 .../customizations/files/99-watchdog.conf.tmpl      |  8 ++++++++
 recipes-core/images/swupdate-efibootguard.inc       |  1 -
 8 files changed, 30 insertions(+), 13 deletions(-)
 delete mode 100644 recipes-core/customizations/files/99-watchdog.conf
 create mode 100644 recipes-core/customizations/files/99-watchdog.conf.tmpl

diff --git a/Kconfig b/Kconfig
index 929373d9..df71aa36 100644
--- a/Kconfig
+++ b/Kconfig
@@ -413,7 +413,10 @@ config WDOG_TIMEOUT
 	  needs to be large enough so that systemd can take over the watchdog,
 	  continuing to drive it via Linux.
=20
-	  Set to 0 for disabling the watchdog in case hardware lacks support.
+	  Set to 0 if EFI Boot Guard should not enable the watchdog, for
+	  example because the hardware lacks support or firmware or the kernel
+	  already drive it. The systemd runtime watchdog is configured
+	  separately via SYSTEMD_WATCHDOG_TIMEOUT.
=20
 endif
=20
diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.=
inc
index da48b47f..d2fcb7da 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -46,9 +46,20 @@ ROOTFS_IMAGE_TYPE ?=3D "${RO_ROOTFS_TYPE}"
 ROOTFS_IMAGE_TYPE:rootfs-container-verity ?=3D "verity"
 OVERRIDES .=3D "${@':rootfs-container-' + d.getVar('ROOTFS_CONTAINER_TYPE'=
) if d.getVar('ROOTFS_CONTAINER_TYPE') else ''}"
=20
+# Watchdog timeout in seconds that EFI Boot Guard sets. 0 means EFI Boot G=
uard
+# does not touch the watchdog, e.g. because U-Boot or the kernel already
+# started it.
+WDOG_TIMEOUT ?=3D "60"
+# Timeout of the systemd runtime watchdog. It is independent of WDOG_TIMEO=
UT:
+# a watchdog that is already running must still be serviced. Set it to 0 t=
o
+# disable the watchdog completely.
+SYSTEMD_WATCHDOG_TIMEOUT ?=3D "${@'60' if d.getVar('WDOG_TIMEOUT') =3D=3D =
'0' else d.getVar('WDOG_TIMEOUT')}"
 # Watchdog to service by initramfs hooks during lengthy operations like
 # partition encryption or factory reset. In our integration, enabling
 # fTPM/StMM implies a U-Boot-based firmware which may enable a watchdog ea=
rly.
-INITRAMFS_WATCHDOG_DEVICE ?=3D "${@'/dev/watchdog' \
+# SYSTEMD_WATCHDOG_TIMEOUT =3D 0 disables the watchdog completely, includi=
ng
+# in the initramfs, so no device is serviced then.
+INITRAMFS_WATCHDOG_DEVICE ?=3D "${@'' \
+    if d.getVar('SYSTEMD_WATCHDOG_TIMEOUT') =3D=3D '0' else '/dev/watchdog=
' \
     if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 \
         or 'ftpm-stmm' in d.getVar('OVERRIDES').split(':') else ''}"
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index 748aaa33..6cec9b97 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -13,5 +13,6 @@ USE_CIP_KERNEL_CONFIG =3D "1"
=20
 PREFERRED_PROVIDER_factory-reset-helper:swupdate =3D "factory-reset-helper=
-efi"
=20
-# when running without kvm (as in CI so far), 60 seconds might be to short
+# when running without kvm (as in CI so far), 60 seconds might be to short=
,
+# for the bootloader and for the watchdog serviced by systemd and the init=
rd
 WDOG_TIMEOUT =3D "120"
diff --git a/kas/opt/disable-watchdog.yml b/kas/opt/disable-watchdog.yml
index 64695b83..56cc1a76 100644
--- a/kas/opt/disable-watchdog.yml
+++ b/kas/opt/disable-watchdog.yml
@@ -13,3 +13,4 @@ header:
 local_conf_header:
   no-watchdog: |
     WDOG_TIMEOUT =3D "0"
+    SYSTEMD_WATCHDOG_TIMEOUT =3D "0"
diff --git a/recipes-core/customizations/common.inc b/recipes-core/customiz=
ations/common.inc
index 0fd3d4f8..016e558b 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -19,14 +19,14 @@ SRC_URI =3D " \
     file://postinst.tmpl \
     file://ethernet \
     file://99-silent-printk.conf \
-    file://99-watchdog.conf"
+    file://99-watchdog.conf.tmpl"
=20
 CUSTOM_HOSTNAME ??=3D "demo"
 WIRELESS_FIRMWARE_PACKAGE ?=3D ""
 INSTALL_WIRELESS_TOOLS ??=3D "0"
=20
-TEMPLATE_FILES +=3D "postinst.tmpl"
-TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME"
+TEMPLATE_FILES +=3D "postinst.tmpl 99-watchdog.conf.tmpl"
+TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME SYSTEMD_WATCHDOG_TIMEOUT"
=20
 DEPENDS +=3D "sshd-regen-keys change-root-homedir"
=20
diff --git a/recipes-core/customizations/files/99-watchdog.conf b/recipes-c=
ore/customizations/files/99-watchdog.conf
deleted file mode 100644
index 1f38c559..00000000
--- a/recipes-core/customizations/files/99-watchdog.conf
+++ /dev/null
@@ -1,6 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-[Manager]
-RuntimeWatchdogSec=3D60s
-ShutdownWatchdogSec=3D60s
diff --git a/recipes-core/customizations/files/99-watchdog.conf.tmpl b/reci=
pes-core/customizations/files/99-watchdog.conf.tmpl
new file mode 100644
index 00000000..c75cae0c
--- /dev/null
+++ b/recipes-core/customizations/files/99-watchdog.conf.tmpl
@@ -0,0 +1,8 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+[Manager]
+RuntimeWatchdogSec=3D${SYSTEMD_WATCHDOG_TIMEOUT}s
+ShutdownWatchdogSec=3D${SYSTEMD_WATCHDOG_TIMEOUT}s
diff --git a/recipes-core/images/swupdate-efibootguard.inc b/recipes-core/i=
mages/swupdate-efibootguard.inc
index a9be514d..3a0c17c5 100644
--- a/recipes-core/images/swupdate-efibootguard.inc
+++ b/recipes-core/images/swupdate-efibootguard.inc
@@ -13,7 +13,6 @@ IMAGE_INSTALL:append =3D " efibootguard-tools libebgenv0"
 IMAGER_INSTALL:wic:append =3D " efibootguard:${DISTRO_ARCH} efibootguard-t=
ools:${DISTRO_ARCH}"
 IMAGER_BUILD_DEPS:wic:append =3D " efibootguard"
 IMAGER_BOM:wic:append =3D " efibootguard:${DISTRO_ARCH}"
-WDOG_TIMEOUT ?=3D "60"
 WICVARS +=3D "WDOG_TIMEOUT IMAGE_FULLNAME KERNEL_IMAGE INITRD_DEPLOY_FILE =
DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
 IMAGE_TYPEDEP:swu:append =3D " wic"
=20
--=20
2.47.3


Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF74CCA5FE3
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:20:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9457.1790940002646661841
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:20:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HoNTDsKC;
 spf=pass (domain: siemens.com, ip: 52.101.84.53, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeG9IxLwNcJGH2teloVMn0URCrbD2g93V1HZqS2De4FoMdITCSPg2/M6wiqMQxSF8PALO++arCsdMOlcqUQNhA8CY8LxIaVaL2HUF91CWUBlhwcFcJOErITMyNZMinq8edkEEZw/5NHkptMyrfaBCRI5Pij0+8l0KFYH6zYsvlCGyur/ACa8Ct1191DDpMxCXbOaDsyYI8OqzzJO1ozz+aQd9x0o0tE9Zesd2qbuHsYuHTJMpPUT/9M1tWbweMlv34gXWIpxU1vjkM4hLi3N9cftmdv8y0huZJ0XYR+9m+/jKuNBJfDz/K9J58tOY9DcxDswQsYI/w7UEt4Kn1IesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLHn5tTGEpQpY6GZnKzXg8IpFt6Duew+fpeU07TY088=;
 b=VGclyTdzZks0+Vhh+ZZMz13dawo5HE+W2HrgFF6jFcw1CYtlcqXx59v3BTyOoZwNCCd5fFwKsh+I4E7Yxz7Ed5Xsf24xMh1Hyw67hNNZ/SkBeol2JwIrDZ/EAweg7Cee3FAf8eZ6S0sJ+tXvvJOSF7fR++i0jY/2zGGAdXB1BFoiMvpMmMfab1dhxWGWmSQMdfC1nFKdVV9PMl0tLjP7pWwioMsb7eu7nI5JAOyJinYK81rFRDOPXFE2OOHw31H5RgfGWwj5GXVTGK21CXt7AuzdKJrBb7S4lCy+a3jJountjgAgK6fj72gi5e+S4ikE6Io5EABFavhY5F6eA9LP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLHn5tTGEpQpY6GZnKzXg8IpFt6Duew+fpeU07TY088=;
 b=HoNTDsKC5AYnFlLnkYxC7E8K63HsXfohCKkn/IXzKAwJfb8PXKL89GAnBJq67PThLAVKRFdmqLNzpl3neRrtx5+aWX4gyXjhImE6GGTLdKpZdrKctLJ8sIPKXRI7OCWpA8FTTmXQTc9ywdgujne2P00HuIef4QLKt6IdwQ19q8tnJtMMUdZwopw2G0zYaqCMBuPppWX7N81G63w4WJlYpje9qHMssTANSBILDn8ZAMhJz4B+71Zz4i1rUW5rLgarPRvB1M2xJRKJxjS0tEsUY2ceXL90lm5dBf4JIlXgpeXK778SzhZAMr992axdGNKy9Yy8rDTxeI6yo1PMaBggWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:53 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:53 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 09/11] watchdog: use the rootfs systemd watchdog timeout in the dracut initrd
Date: Fri,  2 Oct 2026 13:18:56 +0200
Message-ID: <20261002111938.3600786-10-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa6cc82e-4017-4b05-dd50-08df207713e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|3023799007|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	dZ4YpHal/lqmMFukFNNhw5wCkAkEvkymS9DHxDQ5o39dzZAxNEtAAOD/UUdDXAGzAhyl4CQtovxR2pN2qwJAqN1soAnJfwHB5ylkiv/BaWiWVhb8VixEqxZCEljnqYfrzt0zsQgpKkSpAGP/JEhfu1rBL4TWvst2sruGE0VzJyw+gF3jI09J8q3DwEVwFQy06KSU8BaTDZivJInY2251XHI/YHWk0uZJZZOBqPZzSnFlP98lB1Vq8Xi7Xaz8wrj/+t8xjQ07BeAaTlzYeCnh+OEmJF1LHwBCJoxfgytFCjM4IRX1+d6KVrxc2VzCPyuYn+/GBG7wBGHmxmYMiOo6BlKbFdxf4A/xBQY+zqSWJx/m9EvzMrJbmLS8uMSqbAWfyRzcO7MRuixWbD1z8puxzi72XWFlIVIUC9EnQEplCxBt1pTCuuWQ0k1dxNYQSDFkCOaEXq6DFdWVmXszCU9nXevs+e9C81bPZjZJX60FroL+h588XDBaPq1O586R22Fm5iAzeLjFd4kwpOH6YG9AMteCpn5tQ3gxuzr1o5n5iYf891Mrg83HoyhMEYDBegR//uAVqCyW58i83BHPUWlRaT4yDcK4jgxsCF0YFRPzOaBfxKGvekbrYdIUBDuIFlxYSkcGu7HBSUeOluSkpVmsNA8p3at0s/KMeIxO1Rs+6K0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hSJef/kXO1YAizYne178JPnbAbHgMpIx8KjCIwVEbtFeHI3qH+NfSu/JXeSj?=
 =?us-ascii?Q?48vMcDtbLCFq079rms//GIBv06+oCIwhDJtbaLNG+lG62M+B42mWkhCoUlha?=
 =?us-ascii?Q?djCQfaub23y6Ng5V0Z8Rg7/7RXxJcamPC7kHrb4uop1SvwnO+jkqK3ca7jRM?=
 =?us-ascii?Q?yJWK0+wNjXUnxcbVR3ejrZ9buApLM3qrs8nlQehnETVSQVdHbNMy3r1lHS7m?=
 =?us-ascii?Q?OCqirpWBYNLGdKIIYOyEV6oC7jdj5Gmwdn9TedriTLCJinU2q20E1/UCeWpD?=
 =?us-ascii?Q?fvQBp6j7jJG7sDqtlDW8pGkc/qOXknQC3mMkgHd+UKPnoFCsJqhb5D2u9kCO?=
 =?us-ascii?Q?yJQhDEw923DPlvqrq0IEgNPiepeidHdlOAhE8WM+rpS6sMVLibAlaU0uAMWY?=
 =?us-ascii?Q?m8d6wqVgp7pZF143AiFQPQyHqeBZIwl0wJU8rx3asl06eQGBSeEHms0P0yF+?=
 =?us-ascii?Q?bRGnIIJdzLKxxct+T0lf4zqkLzb29wqClmhEqrxvemXS7l9iIcBuB4+XhEkk?=
 =?us-ascii?Q?4DGL46rnXWpSn33tR9L5ZZQWr5P9lx/s2EvpbMDFvjrBvJYdSxE+AxpH9H62?=
 =?us-ascii?Q?MZiQePlPlwzy9frt1OpUxTqtlVrscmHbk3H2s/Qn/qoWl4RowXhq0HOTl9it?=
 =?us-ascii?Q?35QFMo+3S+eT32QVdFJ+6QA9tFt18Amhr9jwyVeW/5Jc7ErfZTpAfQnZoIih?=
 =?us-ascii?Q?x9Ew/TTC2UZy0y83kP74l67/DJEf23giPyWIiJLsRuhgmroQ51qdYHwMIsuo?=
 =?us-ascii?Q?ppJu+XyPWNhla4BWrNZvvwfmQVkWHByl5XM6oZhDFHP//SPFJyYOajROW5na?=
 =?us-ascii?Q?OouaWD2R+w0NvxmnpMIWIUlbYk+o2iUx2Qy2lZile0jgzHi8zA2jMQlBsD9c?=
 =?us-ascii?Q?vTKcfYPXFyVGrJ8skHrZWil5erqqj4/CqWl00MmkzvSjKv9EHyl6gh0ENJI3?=
 =?us-ascii?Q?IHdNY35BF9YF/E5KRJkABfAPQs592NhXTNRMjIPBz6K3ZCDdY931+6iP5csC?=
 =?us-ascii?Q?rO5m6AzsKd97qGvoIA8rF4h3/AuahIdaqP5npyY8Zo4uSY24ekSQg7PZjq/o?=
 =?us-ascii?Q?sDmtybqlxQLVI63j5Tfe10JJoM+Ts/1PKmWTJQPUF4q124qdAMBJMkz+Y7tq?=
 =?us-ascii?Q?JRMoT5xsWhjNj8M/xbDiRnhUwlVPIAnijePkojp7xQBWKJJW/TrUelIClyeE?=
 =?us-ascii?Q?8KwieYNlhZwSaM5YeJPd+qbAk8x87A6XBkiAUEvnyXa02PB7Wi2kstsRBv/L?=
 =?us-ascii?Q?XBeYvdXD/Dh6PO8xMX4g8zcU7rEeZVqECNrmKjXw8/3oNCloO2WugOZNSVH2?=
 =?us-ascii?Q?uX5U6c7ICyKwncSzBQ8Mhqc0V2UuYAul0DFG5mndj/gftv1VD9/23Og6Di1I?=
 =?us-ascii?Q?UEtmr6/KSVTWQjFsXo6ykpHHGnjqbk1CDib4uSZ55z/uzye6PkydBRuL6NZ7?=
 =?us-ascii?Q?yDl1ohSUSSsSldqZiq1ShNQfMUAL7G/vX027at4z+xrWJcHG61uueNWwKfaM?=
 =?us-ascii?Q?lwzCqsYsBsOAqkyQhUyW+rpdjj7idGlWz2OqKIXokTU1JwlviAcM+3tFOX8J?=
 =?us-ascii?Q?dpLUNbwBl4zBHm7urluPkMK0Lnvhk8iB3RcC8WjkcvSwXArmPzmS2J9CeqG7?=
 =?us-ascii?Q?IGgtfh4OLsybjQTuDRy1C24ML1aHfEIiebU1ULpYz2bztFib0l+XHZw8mEF1?=
 =?us-ascii?Q?39e46/bj5mkwLjyqrMBBFrbk4rRpzMZCbqE4j0zIpyiyk0uzRXXa9RI/Zkxs?=
 =?us-ascii?Q?SYpvYp1vSZJbsNIzbFIC/TlkGILHXBU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6cc82e-4017-4b05-dd50-08df207713e7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:51.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6rpcFoxw5K88LQYY0CkPEY3d005isbJkQF1WsDlxqwFWgUFBAN99y+SNs4W79RFp8SG4iJvTrbXbuVJBcSrhDnBaTNmS3slerROP+NIloU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:20:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24412

Introduce SYSTEMD_WATCHDOG_SEC for the rootfs systemd watchdog and use it
as default for the cip-watchdog dracut module, so initrd and rootfs
service the hardware watchdog with the same timeout.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-common.inc                            | 3 +++
 recipes-core/customizations/common.inc                     | 7 ++++---
 recipes-core/customizations/files/99-watchdog.conf         | 6 ------
 recipes-core/customizations/files/99-watchdog.conf.tmpl    | 6 ++++++
 .../dracut-config-cip-watchdog_0.1.bb                      | 2 +-
 5 files changed, 14 insertions(+), 10 deletions(-)
 delete mode 100644 recipes-core/customizations/files/99-watchdog.conf
 create mode 100644 recipes-core/customizations/files/99-watchdog.conf.tmpl

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.=
inc
index bbcea1da..db3fe1de 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -37,6 +37,9 @@ INITRD_CMDLINE_STYLE ?=3D "${@'systemd' if d.getVar('INIT=
RAMFS_RECIPE') =3D=3D 'cip-co
 RO_ROOTFS_VERITY ?=3D "${@'1' if d.getVar('INITRAMFS_RECIPE') =3D=3D 'cip-=
core-initramfs-dracut' else '0'}"
 OVERRIDES .=3D "${@':ro-rootfs-verity' if bb.utils.to_boolean(d.getVar('RO=
_ROOTFS_VERITY')) else ''}"
=20
+# Runtime watchdog timeout of systemd, in the rootfs and the dracut initrd=
.
+SYSTEMD_WATCHDOG_SEC ?=3D "60"
+
 # Watchdog to service by initramfs hooks during lengthy operations like
 # partition encryption or factory reset. In our integration, enabling
 # fTPM/StMM implies a U-Boot-based firmware which may enable a watchdog ea=
rly.
diff --git a/recipes-core/customizations/common.inc b/recipes-core/customiz=
ations/common.inc
index 0fd3d4f8..09f4c744 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -19,14 +19,15 @@ SRC_URI =3D " \
     file://postinst.tmpl \
     file://ethernet \
     file://99-silent-printk.conf \
-    file://99-watchdog.conf"
+    file://99-watchdog.conf.tmpl"
=20
 CUSTOM_HOSTNAME ??=3D "demo"
+SYSTEMD_WATCHDOG_SEC ??=3D "60"
 WIRELESS_FIRMWARE_PACKAGE ?=3D ""
 INSTALL_WIRELESS_TOOLS ??=3D "0"
=20
-TEMPLATE_FILES +=3D "postinst.tmpl"
-TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME"
+TEMPLATE_FILES +=3D "postinst.tmpl 99-watchdog.conf.tmpl"
+TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME SYSTEMD_WATCHDOG_SEC"
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
index 00000000..3d75192f
--- /dev/null
+++ b/recipes-core/customizations/files/99-watchdog.conf.tmpl
@@ -0,0 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
+[Manager]
+RuntimeWatchdogSec=3D${SYSTEMD_WATCHDOG_SEC}s
+ShutdownWatchdogSec=3D${SYSTEMD_WATCHDOG_SEC}s
diff --git a/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip=
-watchdog_0.1.bb b/recipes-initramfs/dracut-config-cip-watchdog/dracut-conf=
ig-cip-watchdog_0.1.bb
index 1fd1a87e..fdad94ee 100644
--- a/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip-watchd=
og_0.1.bb
+++ b/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip-watchd=
og_0.1.bb
@@ -14,7 +14,7 @@ DESCRIPTION =3D "Build configuration for the cip-watchdog=
 dracut module"
 DEBIAN_DEPENDS =3D "dracut-cip-watchdog"
=20
 INITRAMFS_WATCHDOG_DEVICE ??=3D ""
-INITRAMFS_WATCHDOG_SEC ??=3D "${@ int(d.getVar('WDOG_TIMEOUT') or 0) or 60=
}"
+INITRAMFS_WATCHDOG_SEC ??=3D "${SYSTEMD_WATCHDOG_SEC}"
=20
 CONF_NAME =3D "cip-watchdog.conf"
 CFG_VARS =3D "INITRAMFS_WATCHDOG_DEVICE INITRAMFS_WATCHDOG_SEC"
--=20
2.55.0



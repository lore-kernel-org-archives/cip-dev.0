Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E40CCF2E5
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:01 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31404.1792405559440302034
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tf4uabJv;
 spf=pass (domain: siemens.com, ip: 52.101.70.60, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzYCsgNCIV4FEV5Y5V6+jMZhwi0x5zi9mKnzophxnTe90bq4AdkPw4zX+sKypPBQbIHHlFDUdoP2qtTboF3ouo3OuUCROE+v+2JopsBkKfybdyOYxOD0EMOcA5wcdRjmGXRHHKETzqqRlnjANWVem6JqEuAAz614+BanVs6slMWeAyiK5OmiQcZ78wS+OfVfyV3pleh18R2pUGXo83ixg6ZbxoAaBem1H5JrcHrR3nibp+USUmyqzzlhI7XYrSUeREYaP4CDZlUoetdOQ0AG+Pvf8vYgtvcwE7sMbDs3K1imP9ckH8fC7C64m8KT8OlWgVIPwzcB0xALkfmLdFX8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLHn5tTGEpQpY6GZnKzXg8IpFt6Duew+fpeU07TY088=;
 b=wSKGzTsDokmFbINpGtC0FUjJsUWO74ViOtVwv9+zei/X9yDFUXiUY+kXNJxpBQwjgW1pGUetr3gXoKCqMQXLVM6/UzcGkNKi3SSkOYJ963nriaUqCCOX59VigtpKBH8gGexRenalYu9P7AanbR9jEIqjc4++73B/1KSW3W3gLUehDbXG3KhgjSi1VuoCYKAweIDjNQQfW/HCGUsAhjGiWBS4Rnw/BvLSipCfWs/ojstsz/0DjDbtHSG2FDEsm8YTBlIxnWm5/KUdgZ1ErDOWzK5rzi4zIG2FSP7tHmG0XsGc4v6J/31R6SenCQcf95gUbmlh6zpcbSoHhuFjBOVzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLHn5tTGEpQpY6GZnKzXg8IpFt6Duew+fpeU07TY088=;
 b=tf4uabJv89krCZrEMigXlWZTBF+tg1T7f+QpUmlJ1A1MJ85xIG8XAP+G/ytXke6bz2rLZ/+26qg3xXvrfCcq1cgNRaKKhrrN0xKvGQZ0XdfzH5EFxQ2TWAzAqBuoqWoOwbkrQEHoOfo8eNmnKAcQvKYAhcusEV461iyIw5LDWm8I9X12f4ReLJOz7jZ7KLs71uo3jucrjy+tiNTBRQceumFRk7RGfIkgcETOIm8c2HULjuFDRHxMbf3/DbSYc0Ixo/zdogOXFHR5A5UPEn93HZF2zm84fGMBZEzDXTb+jjsFdSxKiUzFhjEY8vF6N/2xdYmGN8FDu1Zd/C7xNgyCtQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:53 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:53 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 08/12] watchdog: use the rootfs systemd watchdog timeout in the dracut initrd
Date: Mon, 19 Oct 2026 12:25:19 +0200
Message-ID: <20261019102541.672620-9-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d6bf69b-dc0e-420d-ab92-08df2dcb5a44
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|55112099003|18002099003|22082099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	u2sGl2IugeMO36ZUVndaM87ZnjrOWaGd9bMkxJaQWNK4kiw+Wi0mFywQYWLmRVk1ZTc01brvvAIWLCsIj09A+NWkCQ3ey5AL7TjdgErCazNHwKq0ClIV0R/fqGXIrkytiAxjMVcS5kT6tK+hlhAOq0HubMwdNaih2DVHBJQw4ce4LP9zKDmYrIb3fGEccmnX8o4b/fgVvGT4stcKd6UuwOtmWfrazDObDrqdQgJPD2oPnFfnQsF3BsoIjk8I9Mdx+deYwFKWF+3Yfy90Rr1lXAfBBd5kRWhRJTkAgKaD7N9qQByhTTOuo5jaPNWPvVzzGij7EayiRjgwo56LIl97XXqzV3C+fFXV7AjoNdd5GTGpzEph0PxyduNOG62mZ66u65/OCXELLcY8U72O+h4VcZjXTmI19GGMhqCmKBwdg5HtHlt9NVUwRLjdTBBrU3fc+Sl9YPZdjqYfA+I+YN/HuwZgjUIUOJ6cvrLtx/0msgXjvEjvrqcA99S9ZlA1ze62uNWNnJWRLikh+HBt3jRP9ULObZBbjb5f/LePSK+TvGPe4j1m27zwtBkQ0vD0iZu9xHqlFM03CS0atYCSgCxxMt4Oz7BYnVKNKNfMS4Ovvz7qD7aMZjABsGtSFTTXv8MTWeJj896MsfRaX0MolZ8Ff45/7ZbJ63jidRyAA1hCCJM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/Uo2X+hag2/V9Ll7MkHRLbK39xatWzQ8qFf/20JxVCf9o/dHYW9e8NIhbGWU?=
 =?us-ascii?Q?mPdxgo1grh1+05fBKiO9AKJ9i4fkAKeZeVKY1DnYCOUNfaEFbG2/31Wn0M7k?=
 =?us-ascii?Q?zFxO+m8AKDvmtM+JeyPTNz4xCReg7ao2RV46t8h9A2uPpppHB3DaCp8/X+B0?=
 =?us-ascii?Q?IM4c8xcfUFwWQ5rr7UnqsoecQSnpbgNB3lYSRa4l9M4BCcMu2onaINRp5wtT?=
 =?us-ascii?Q?jPf5Mc/soq5SvcNPW/0ep6wUraCb56HsdOJCGQK/DjVob0Vp+ztg8iCynCb8?=
 =?us-ascii?Q?eANLryDYihhKAvg2zmvEe1kgpKwrQ1kmX6vaZD0tfNRKAFcSsSXNVmzB59io?=
 =?us-ascii?Q?yvi3QOaL3w1nbJ6KCFq8CzWHi/MctLFXzvgUZj9E5ivWRLuvjnIRCyG24INU?=
 =?us-ascii?Q?meZkGVhC+jl+YZWUvfo6HXLo3LtvcclrpkuVRIfr3QibAXeNP2Zq5bzKMWFg?=
 =?us-ascii?Q?nEtzIi3XCgPjQqBZeMy+aCsaqDtBg5eZ31lknpvSQGUd7KGCVcR+oDptFwMG?=
 =?us-ascii?Q?k33VUStZ8r6xgYgDxRBsDg+kZCgb0JO3pqiU1gjRc5k0QbCjVu3QbYVYDEC3?=
 =?us-ascii?Q?slbw3ghv3dTPDS378CgzxYBsF021VYb1pFEVJf3pTdDytDYQw8mLxVpFbQqp?=
 =?us-ascii?Q?tFBaTJ1sbImS/weNqDDppWWNgPKafKfhRaaUUEYcfDxDJQ4YUtKG3kWQl1Bd?=
 =?us-ascii?Q?VpNem60Oc6SzdnTPeL9ZL8HNNdcummTuVZ/Yqkux/Ay/4EkgSrcA8NWjuIiS?=
 =?us-ascii?Q?1eg7XIOxj/quKklDqNPZl9ct2xMUre22NmSHRthJKDUTG9Il3fJdB+50DWN9?=
 =?us-ascii?Q?3bO9j+IkQKoyS2Tri8JWZQBeCg4mra7hWlUuAAs7ncZ5Q9pA0LyNHDabSYOL?=
 =?us-ascii?Q?lsGepDhvuPMfFBSuWCZJMOUxCVaJNrorkxm3B1rUVyQgbIJW+xylWkqsGHTk?=
 =?us-ascii?Q?PjkqmqnKp1yhWiE9EtBpcuROnmt+PdlJYx18xsjweNmpU/jv/AHEQ6hA/Xw9?=
 =?us-ascii?Q?xihBqs4Ol7uCKnh2lThi6LOZt+9bwvJpLvDnRApqANSkv6EDNmk0nr6IzGLH?=
 =?us-ascii?Q?Vr2Mg/d6ygQqo0XzgHdKLksnb3tHHi+fhThqvvdBAWpXDZjw3CTySWCyE9lE?=
 =?us-ascii?Q?/y1SHfI6PQsmyKVvdY0OLEzZUa0VcjHxve+W7FsbKuSoqi87peFpLmNhbOUU?=
 =?us-ascii?Q?WBW8+Pl+TZVyi95f4/1h9xXsiWKVFvnN4VH+v58jMhD/eAAsujs4TP/++L8F?=
 =?us-ascii?Q?QoC1IwGx75BWvouCWLtFmOUfMail9snY+ero6er2EUMUS0hdgXz5cQ/bd2AN?=
 =?us-ascii?Q?lHhgC6b4pZE3QjV6dw3uH6hrWDS5SG5/aYcwHehGqr+86zs4qwK9dDx1GTtF?=
 =?us-ascii?Q?TdUtThhbSOGv2LyPoYCH06yt3i9M4YXe0QOgko4V+4QZUr/xrG28VD31+8RQ?=
 =?us-ascii?Q?fEDqYvt6XIMH4B8yt9Ut6m1fsNmWwSNlPr66SI/LCupRH0CkPZ9yd5+dXEfb?=
 =?us-ascii?Q?jYaOtG7Ac066zpbmZ1PtkrTsJ0pq0bPdL/M6WIV4zPEeEhkwq8ij3ijA6d8t?=
 =?us-ascii?Q?2MyeUtVdrgESSt2l/yfyNeARt3E2lHoYRRoopKeHEFvBxLbke8TRH0m4FnbS?=
 =?us-ascii?Q?pIRWwxTaI6/gBNkUWsyHlxMqhFIL+NRy1JqaYzg9dut9nNbetqO79cRamfQT?=
 =?us-ascii?Q?gz9Kz7sGiDK6tPwSzVFGBnNZ7MuZZPXMs9FNMrYxIEHePN7eY5dD/4dWlug4?=
 =?us-ascii?Q?MHZgfNvJ4QPgB0onxLrS0J+sx9fpvWw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6bf69b-dc0e-420d-ab92-08df2dcb5a44
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:52.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlF1cwDmLXH2yR0oXL2Bq+WiOlM+i1ZfQSI7kwz6888aKwFcrIpAJ9HoNy8Oy6YS8Y0YaIZeYpdbj+vwadkYQgqrvIIcxymFtIFkCadkaXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24488

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



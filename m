Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE540CA5FC4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:20:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9457.1790939991891002964
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:20:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=IYXgvVQg;
 spf=pass (domain: siemens.com, ip: 52.101.84.34, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpxTYn8X5WlldQMCrlVz2rTJpEayLU2uOVNQxyfrsnwVm37HLqGPmWfKJpYB8n97IOx/bWrgUuYQyD0TSqz/RSF+bdehR1Asx5HBeKbTC/qsHYkNE8TmmE8N+xVYvFwM6TRrSypvu85QujNBgivXOvKpbDCHgODHuDNushJWeSdW28ioDjHfyGyXUmVvl9HYjNmrY/azO6jWDohym4TkntMzgGM3BeeGw4WvYnub4i2LbxsD86XbcMwzuf3hWaTj332lST0kzM6cFIaFHPiu2Nu9aucT76+thCS3be1WAEqNtNIefSRlCiwtC4NkgWyMVCS/+xRxy2+ynJoKpyZLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geybjG3HSlc7+27vW7kNtsKbh+NX9xed6xsZFbJosPU=;
 b=aWJIjwMIokvnMFqhM9imFChPK+WZnfMFIdgSwnFKuzNzic0pDu+EksdWAqtvist6RMSvNPuWi6vg+x9bMYMI5sGp8YILzkTO2n3up9UNG6Ha8tst6RdgH+leBJFNw+MHfNi3DwG1JhtLBa7Puw42tvg+KSkpnuQaNeO+7TmWN4DTwfxDINl0jw7SZ9WZTr0D2TATdoEfROafAB4Receg/eIRun0f0CYbX8aHnuSu/yfawWTah7GcTu4xuWqcjZZ0bpVhjOCzwUEVLE9kWuqq3rqaL6hIUeQfcugT9xYEvQ/E6bWBT4CwBCiVTz4Y7pinRZe799ELLEpSAcH44QNxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geybjG3HSlc7+27vW7kNtsKbh+NX9xed6xsZFbJosPU=;
 b=IYXgvVQgN97/Q4K0ttlvpNvZ49hrC1aXaMMfsdY8Gj/aVV7HuIAUjZN5QIK8id45FbTSu5/Y+yj9SqPKt0goilVnaTTODbXGLWCPbT2B8RYD80wp32mzXtz5/CuBvo42fQukWAluyGPL0Ixz5ONNv9Aa6rud4S4237gYMqAUjmJ/JtRKS1CtNdcqnAw1FvXCt6+bLPQplT+i54oR671IBuCTIiTJO3lIJuIWkC3kcKrNG7Mzp4CD7cG+Gf7ICnK7IGjnCcAKNfzIjX8uhfTOEUagfgVBRkf5lUvaD6rLG3p1QPg3mYVo0eZtxdktg+bZCdJYv1IKtmIx3WKIan+6Mg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:51 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:51 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 08/11] cip-core-initramfs-dracut: add dracut initramfs
Date: Fri,  2 Oct 2026 13:18:55 +0200
Message-ID: <20261002111938.3600786-9-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6130575-9b1c-426b-f757-08df2077138b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|3023799007|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	MQOX9O3CyzhHy4JiYT0wN/Aw3ZreUjefPB+2jvQfrAu6GyzwbChDDqCY85USbQzo9w5DllpAfltITMI/FEPmiRu+2JN3ahAvC+ihJ5u/I1FcMrcvJNcZANwNoBpwKX+qz5JHsEMwNI0unukFQSVSxCMQIzvT/9ejL5dayiVka7nz1ysoYx8xe/pwyy3Ng8xu0MOM6HxkdL2+L8gIP0dbJVu7etZOirUrJJ1+oSBPXGwT1pBJ4DLCnEMJeIwiy4wdjf4mzDbftbbRergveAKurXeVz9Bjyk2I5Ji0xSk6mEhSX2O26JRXeT144vNvWJAD89WZvHq/6Eye7gyhYDeD/Q2T0uJl+FfHuFhupsbozwju+iIjOSh7slUB/VVqQPpHszCJXqW8Gw/8TI/tw0Xy934piJV5LW7trGhKXC448YZE9zBmztJLZEjrG2CDpXGjMx9EXWBAwG1lk5OPBqg8z4EAfoEeCq38TE0sYo9ePncyY2/xRb5r0kfOO3Y0dNmPQJYdBGzqJDGGigpzt93nfkhzRYBcMhBUGX6kVZqd104Cafr9gC+8XtTy3KE34D0aFF9ys5ZdJdZ0i+Eo94lCeaEs9nDrz84v+8ag61RpreFaoBkIxUK1kExDRpBr/QFEo0NZZDMJJRfobOIFa4bgumBDIs/TRgKDfCyllE6YttI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6M0c4vwOc2qZQ9N0bF/gPfbrUnmr5QxqJ8u2+nUiLFKi8hm+y+VeWOSPCADU?=
 =?us-ascii?Q?Z3OP0qK5ZRIPP4DE8hQCXuXSz+BL5c20bjpBNUqNmidSaaQEG7iUTidSsGIn?=
 =?us-ascii?Q?nULdpnWAaBaQrXA7CtpN5Ni/nWBS67JOLe1CbdfZwOvPzbjZaSCFlrKrDojk?=
 =?us-ascii?Q?LbKMzBJlM96UgYnJPI6/2S/MpUEmpn/6Bb+G6f/VoH5ZD46Q0NXO1ki3pbuV?=
 =?us-ascii?Q?nnBWBJ2xi9py29hcWwvIVnbCuYQQ8TBiQjAtmD8b13xydpq5ftnu0svg+BC9?=
 =?us-ascii?Q?i9rdteW4RlYwqv/3uPuzbOl54JjX/4M1q3pzJzs1Ll6bOOaa6ncsJhEO5KBd?=
 =?us-ascii?Q?omx2E/09yqxp7KwvLWN3B2VbHayDx6pIuEEVYY7xy4l8y8FLc46/ZPNuOkf4?=
 =?us-ascii?Q?S5zKC2yeIpPsYHeI9SF4/U84UdeP0UWHtVaKYHohFyAXmYfGzHnJNwwX0qG0?=
 =?us-ascii?Q?OIykuGmDCuggK8DWYYQKo0bE4zxKazqSsOhIw6T5Yn6lW7cI9ioO5pJa87LT?=
 =?us-ascii?Q?ErWqjoo5I9RgstB2tkzSzsAZygYoutvOJjVvNYgN0n1/GpxH4N+W+GFYpa90?=
 =?us-ascii?Q?X7FvM3URawyhY23gtW+QY3iT5rA6F50TgjsLrh+ePtsb811LcILQtrwH5+H9?=
 =?us-ascii?Q?jOA+FJjBSSb1lSPsDMWkinI+kOpF+lgQlGlfCXJg5NTC3sC6QNIQA+bdlHYn?=
 =?us-ascii?Q?Ci6dGJaqYcmFDypN51zX4NY+Zf9e1EioVi+3FE52YVEUMljcDyoIRF8XPXxc?=
 =?us-ascii?Q?I0nd9PlULvv22OeO0RFIaIXZC8+camWcBmfC/6HR4aDnLAE8EgnrUcII8qM9?=
 =?us-ascii?Q?n/xyQ+hXgAaw+2wcFGpDmxA6kKvFk+6uS1pT/Z3Z29L92c2sKLUhoI9D9kel?=
 =?us-ascii?Q?OT5I6rVbjzrywtgAFRjLgDGqPICIXy+L8Gfpujop5+L2loHqH2hfQfTep1m0?=
 =?us-ascii?Q?xpjfzwoCLxFQQrFmIMvlAzK+h6MelmHudG8keUjrZp8h6nm7e4RStQT3jeE7?=
 =?us-ascii?Q?UhzCGPXLo+ESIDgRJ4QGYX+5lgRFhOEqLS1gE4dF87Pt2yZhTJ3LbeulY5Nw?=
 =?us-ascii?Q?Dh2T/pfpToOHlKtTIQzKZ3ke9HriTK2NBbNZmJW/Z1G5p5s2lcUcTeAB1hO1?=
 =?us-ascii?Q?lfR3dZvMAFezqW8HdCPyhjPURiJHqGfAB5KF/EyQWVFk7BGN1pdwAdEdy9DX?=
 =?us-ascii?Q?x/Z6a/pQKxYE3jaVW01tQ4faxbC6t3ioxAniwHaL9iEBc8wx4tNQnlgLx7jO?=
 =?us-ascii?Q?XdLten6p2XDs7yCC+8T+QP3miMQpPmSz8LLLv1bZsoVmd9IRA35PIdos3xuw?=
 =?us-ascii?Q?NjWGWyeseW0QRD3CwG7frI+Ku5WTIMw4gnKErIMqPnq7P8IRTr8C4uq66HFk?=
 =?us-ascii?Q?/i8t/f0SUqYuR9iFvoyoYK2ExUBk4A8gBiEReCSk0ql+u07rixjmIOBkiXKo?=
 =?us-ascii?Q?lXmOSVR+84uSEOQb7znrJOtgGgn+sVxg0b53cY3J1GbfTIXVYKMVCN+7nleM?=
 =?us-ascii?Q?9K7cfuAKhuLhfI5fITENPpjZYh5AIxVxIPq16YHITw7t57y4HzvRw6MLyNl6?=
 =?us-ascii?Q?BTv+7y8FBhAhMNp26bnZpf5v4N1rMioTQFLx4ABEgUJ32AhgufsCA8+E7m6i?=
 =?us-ascii?Q?2iLZWSA9KZo9ikIvaNQ2P3OAa/b8pIum3X9HxxwcB8Ns/tUyOzFQmY3Tstg/?=
 =?us-ascii?Q?DcsrwRhQaenCI10MXBSowWkTfTYZXlR+sM3f7oXvqclpZDl98WvfoYVMycKa?=
 =?us-ascii?Q?JGJjwJiROrAOEEaeEvizAmu/FzmyuuY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6130575-9b1c-426b-f757-08df2077138b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:51.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLlh5EeK7XOEnsunsw41FmRevbiHsUic9wMCD+f5MQ0M2ywPjB0c9mk8Yh2UPG7EHgi2GdaMiFCkcpuwmjy/XBcU9A+yumdfjZAmoR8R2e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:20:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24411

Generates the initrd with dracut (--no-hostonly) on trixie. The overlay
module is always included; verity, crypt and factory-reset follow the
swupdate, encrypt-partitions and factory-reset overrides.

kas/opt/dracut.yml selects the recipe and the dracut kernel command
line style.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-common.inc               |  3 ++
 kas/opt/dracut.yml                            | 17 ++++++++
 .../cip-core-initramfs-dracut.bb              | 41 +++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 kas/opt/dracut.yml
 create mode 100644 recipes-initramfs/cip-core-initramfs-dracut/cip-core-in=
itramfs-dracut.bb

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.=
inc
index dbd65e3f..bbcea1da 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -32,6 +32,9 @@ TEE_SUPPLICANT_IN_USERLAND ?=3D "0"
 PREFERRED_PROVIDER_factory-reset-helper ?=3D "factory-reset-helper-file"
 PREFERRED_PROVIDER_factory-reset-helper:ftpm-stmm =3D "factory-reset-helpe=
r-efi"
=20
+# The dracut initramfs requires a verity rootfs and the systemd cmdline st=
yle.
+INITRD_CMDLINE_STYLE ?=3D "${@'systemd' if d.getVar('INITRAMFS_RECIPE') =
=3D=3D 'cip-core-initramfs-dracut' else 'cip-initramfs'}"
+RO_ROOTFS_VERITY ?=3D "${@'1' if d.getVar('INITRAMFS_RECIPE') =3D=3D 'cip-=
core-initramfs-dracut' else '0'}"
 OVERRIDES .=3D "${@':ro-rootfs-verity' if bb.utils.to_boolean(d.getVar('RO=
_ROOTFS_VERITY')) else ''}"
=20
 # Watchdog to service by initramfs hooks during lengthy operations like
diff --git a/kas/opt/dracut.yml b/kas/opt/dracut.yml
new file mode 100644
index 00000000..969388cf
--- /dev/null
+++ b/kas/opt/dracut.yml
@@ -0,0 +1,17 @@
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
+  version: 14
+
+local_conf_header:
+  dracut-initrd: |
+    INITRAMFS_RECIPE =3D "cip-core-initramfs-dracut"
diff --git a/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs=
-dracut.bb b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs=
-dracut.bb
new file mode 100644
index 00000000..8541574e
--- /dev/null
+++ b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut=
.bb
@@ -0,0 +1,41 @@
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
+# dracut-config-* packages are skipped by module-name extraction, so the
+# modules they pull in are listed explicitly.
+INITRAMFS_INSTALL +=3D "dracut-config-cip-overlay \
+                      dracut-config-cip-verity \
+                      dracut-config-cip-watchdog"
+DRACUT_EXTRA_MODULES +=3D "cip-overlay cip-verity cip-watchdog"
+
+INITRAMFS_INSTALL:append:encrypt-partitions =3D " dracut-config-cip-crypt"
+DRACUT_EXTRA_MODULES:append:encrypt-partitions =3D " cip-crypt"
+
+INITRAMFS_INSTALL:append:factory-reset =3D " dracut-config-cip-factory-res=
et"
+DRACUT_EXTRA_MODULES:append:factory-reset =3D " cip-factory-reset"
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
+RO_ROOTFS_TYPE ??=3D "squashfs"
+DRACUT_EXTRA_DRIVERS +=3D "${RO_ROOTFS_TYPE}"
+
+ROOTFS_INITRAMFS_GENERATOR_CMDLINE:append =3D " --no-hostonly --no-hostonl=
y-cmdline --reproducible"
--=20
2.55.0



Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C935CCF2D6
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:00 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31403.1792405557545157339
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:25:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=LcIE6C27;
 spf=pass (domain: siemens.com, ip: 40.107.130.11, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+nGXVTXn05BsxFKL/OgmHdWDgagcSCXO0QGeh54p0NIKpxg56/n9E1TjAekZdwgpDZLA/g6emC7qjZSo2xOqf3cn3gXQIRt91U04IbmQA8zLUARobjO7ere7zIkWl8WPNWCcJvsI1XkMCcjyV0q0P1uqMCTblQzT8+N1280hWBMVxc7sinXD1YKV9eRRUaw+HmiXkRwC3DgazBLhT/uX4mcHy8+NhZ+sbndaMpN2LfZwbPZSN6n6wWy5vNshLKOKZ6G9mN3BLlTy8/gDM8GVN8gDkTH2Ey1xuyY+2XJCbvI6BEeVpQ2sSXHWUF6s+8JJtFG+9APRP/Z49m9+vU43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geybjG3HSlc7+27vW7kNtsKbh+NX9xed6xsZFbJosPU=;
 b=Fxpcb+5fHhvmTJ9gjPFk+8eai+UzkVtzvEFuUcvtFq/dUeReKTsGbizXbMNektOdzubDnRHP5BFF7ZfmV19Xx0bQJEyH6eecOrtDBTdNk2ZnkNmOoXaoPwVbkUuEJip9rzsWw6K136TJ7SY7xYqRNWKIhQi9KHmmgJo6QFhtse9WC65qUTBQEZ7+ZxJO8i+rVcves9qj4LVjEwXZFwrTN1NxNz0AicuRe2dJH0dopVeDK4P0U05umRZnyLYcg61To7aeHI7RA3ia37TSqbH1eBwuMjO9eaJS1JTsZ6N2SVgzrAWunF8v3qKEC5bGZFvflR4lPZ6BfaP8qTzCC/SJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geybjG3HSlc7+27vW7kNtsKbh+NX9xed6xsZFbJosPU=;
 b=LcIE6C27MlykjEeLwNJ4wX1VMsF5iAIqcsPIXnNlwiMTJ0WxwiFsHjuwJcU1zJr9OhzeHwi583QBwwpNDb8zSWwY0by2ojGeobvu1C8b+haLy7Dv2x1avKFwkYVDWNBeovnKcx9rd7tpAmqhTJf1kapRCUXBq9t+mzEYSTxc7GwbQyQU/7EMXlD6RPFfRZlDB8qfc5WY1VYqyb4mX5CDfHtyvuYC7L+uk55d7VN/GP5C+e0nljHZHwFCDcpZ2dyjlyQ0U1meu5JXUOgm8O45AveXVEZ7yBv99p7BM/bo07EER+oYA4UQbneKRB2r0JwEizenxGW/LfZIKzFFVSV7Dg==
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
Subject: [cip-dev][isar-cip-core][PATCH v2 07/12] cip-core-initramfs-dracut: add dracut initramfs
Date: Mon, 19 Oct 2026 12:25:18 +0200
Message-ID: <20261019102541.672620-8-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8c14a6c-50e7-4b7a-ece7-08df2dcb59f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|55112099003|18002099003|22082099003|10067099003|3023799007|261009223027099003|261009221227099003|261009223327099003|261009221727099003|261009220027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	zA4UV6jHf90+UFlc9xAruJluSVF7RgHLwlTReYrcSoZq643LVLpNh/cp0w7UMoSarbT39akoNHY0K83SiOfLQNuEgEckmWUKKLB3NaVkF3QSo8mP+jvbIsa+EornG8/+BvfRn88MPpMkYpfUG2R+1Pi8s7vCLN+KANp33X/dFF9p6xmCis9+nIASlAwwOUZt/nTjZlxJGQu+KshQ45cEb4P04CNJzJ4Fq/q7RtgbxsEc5tVd40EMpFCkCPo7vvxNFVpKbpM0oFfbKzKnh0bmmahIzB3f2F4qp+K+4BeiACA3Ob0C2+cjTkNWw6laR5WSMCFTHC3xAH5AhKxeY8sEfH0TFTXufOSQ99wX3Yl2RJRoEBf/miBBL5VaKkYbBi1tfC78+qWyyNxM9xj9nHioEh7NoxQLPXadG/8tNBZhQkL37wNcbL3Z1ChgK3SZ6l1GEgr2r6it/EYOz1uO9BKEzM4A7zEE6pFVMSoz//BAcfweYMyD/uo3aeBkLyHnl+X60/1VOcR4/aErm0tQtcDJqvu3q/gt0DDAWLGFgAt4fO+wEsF3MHsVQzPBU6ZR/g/K/8jH0n99IzLK0/cqpH0VjQ/uuGktHE/lFOHwWCRE4NKUswgL3TmvLsmB/9Yr9ls96iK8uoDfA4F6i7xmAvU/7WH7h+CyS1xVfKEYQ2XTJsQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(261009221227099003)(261009223327099003)(261009221727099003)(261009220027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I5s7dgYnGLZqzLw5Jur5hMHNLjt7RolMGeo0h4x7q+Cp4obi3D4/Yy+2hi7A?=
 =?us-ascii?Q?bx0AKtEX8czTTKrfM6BJWLQq9RG+XwRC5nstZ/LUjPNtcOjjIUa74tJw8tk9?=
 =?us-ascii?Q?7sU/WZcVvEgBm8vaCYyP80CtVbLcpyqSBx3glj+t6OUAZmjHrZf2mMPWLC/s?=
 =?us-ascii?Q?mQVRn0kmjsXskLAnkEZUixzbNV94wWGje3nFYPeMrWgtQhwkf25rrlliZPUr?=
 =?us-ascii?Q?ooSOrBDiICipJCHe1eh8ibEi1tClKV8m3YX2TFIojrPnvW5aK4T8QO7n0oEg?=
 =?us-ascii?Q?Kxd8go0ms7F26SukJzhBLu0hULVOZBgAWCYCbMD8s17RXjiMXmL+V2255R0K?=
 =?us-ascii?Q?hLx45VZxhk6E6lcuJ++2JpVo7Wqx008nfgsYc7T/ydiXIp8gTGAWChiED7VH?=
 =?us-ascii?Q?RHSodEwB9PT4D/9L/NZ8BsR3lY9ke8Ph4Bz3f2yr8kz0bqn1yqYN94DE7nrx?=
 =?us-ascii?Q?D2kBKdnnHRXC7beeCmrz5SNqYYoQjsW5R6jaods1WXfrjEzXJyycCfhYQuZ2?=
 =?us-ascii?Q?skC6IubYoAQFBrcAZm633q+jreLxrIFF4Z5tRoD10o/pTzZ6hy+kFTAU+epn?=
 =?us-ascii?Q?iIsUpfp0C7SK6nja22UA2l7oMBC2Jdd1cH9lrjA9k4yEuBdJKyG9Kx6Mddd9?=
 =?us-ascii?Q?sRcro0WOrWZxC5cU0GV0BLOM95j5avLnoKPdGJ12ESGaeHeq6EOBuDwGi2ip?=
 =?us-ascii?Q?ssIVKu2xNe3C5bC3au8ZIZuC5ftDTtjXLVOkob8nfBV7XrAKYuzghVwLM0bi?=
 =?us-ascii?Q?8tn5YPOAIhYrgJ1jZ873siYwlSL2DcM8fHCQ9tixRb2cnPR5lTgLTH/gq8SQ?=
 =?us-ascii?Q?ySMEpyKLylr3fsm22D8umC122CmZ04JxOSZJMWL2n1yxqspu7Ci1j15ulvrw?=
 =?us-ascii?Q?RmJNh61/zA9hgYz7qQ7yYcriJjlq1vIi/v8pjER0w/3vQ1IgcUsq8zg3wJTc?=
 =?us-ascii?Q?6mcdq66oEssVOQhLuLBTLaRbOhtzkhg9gX19Zf2OD9X6vCNWVfs5PWm+vs54?=
 =?us-ascii?Q?Zo93MM3EQdufRxPwczsvvJksjtvocKdf7rDML0x7axJI8Q3mBm9zofsZRXcP?=
 =?us-ascii?Q?kroqfSReQlyJbq5PP6ylmDxpqYdiEHwGKiJmrDBgTAYD7b8qLnF1qKZin55d?=
 =?us-ascii?Q?6mwnSR1OAG4EnsXJ1ACxN5CKb/AL+l+KKJ8mwqRfJ4rPYTbYBDnHmimhkmgX?=
 =?us-ascii?Q?ixpHwecxnxWITnBwE7w+Qf5vUjWKSCU/uCvNwGHALGy6/UF663c9w114HpGD?=
 =?us-ascii?Q?oB7ts88gwDVEfQox/3JWtHASZ8rFiFxxUIJeziBg7WAYk+DLhZdc4sW2fUeX?=
 =?us-ascii?Q?K+mdZd0sMa0rR/3cYFJ1JHc5uvDiwoV2alQp4zzngwtRvfUB/VE+9NlYLnvw?=
 =?us-ascii?Q?s8C4mMRjddILJ+Qi7Yrawk7n7P+UkWTc0X0PMdk1ctYzqw2DcmD7a8mThz5y?=
 =?us-ascii?Q?Lwpy1AeG6pVfwJF9uMzLzztcCxlbz42p8Hd48E11SeJVVmjOhUXV2fpRARZj?=
 =?us-ascii?Q?kqB1zX+flHrjtQyQ5e0v2h3DCgmEAK+lNpQSmdCkZmHWVokWtwxKVIsn109E?=
 =?us-ascii?Q?C+00IvCtnpofRs1/vvH7Dbm7hU11CS9ForACb+sbzU21OoFWw9DSo6VbFe5x?=
 =?us-ascii?Q?nVQlhlnghqH9+c2pADD+QltW9ljerKGVAQv/Zk8gcWtI7ylYwPnZzhwL57k7?=
 =?us-ascii?Q?kPFcfEgOISTvSMy0Ucn2CtUFMMHmoDFRDot4YY4kFcrdSgWgF71ng7Ny0h/E?=
 =?us-ascii?Q?nd/VpilOI6TfFGP3nlwPr/f8DAucZrY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c14a6c-50e7-4b7a-ece7-08df2dcb59f1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:52.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsZzNpCKMQa+zTJeUWT27xa6L405Rw+RXrNpr3USbXR9d6AgkQIltPFez/TRrnqvxPgbibeSYtXJyW/ny3p3jm0w7mYznDCFujey92z+ZDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24487

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



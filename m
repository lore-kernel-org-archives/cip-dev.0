Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15681.1794914933922263860
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=upGT9FrE;
 spf=pass (domain: siemens.com, ip: 52.101.84.18, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8MvrWr4AjDtcAbWvaRzohK4FSyYXzNXLa0HVxAAMmN6JGRCimQUrip4M36L3Y2OnNDcF0ZRAmvHTejBCigsC/eS9UEq04s3N4GdpCi30+tW0qKAEHbjdXC33FwPTnNNKbCYuXdorLHLnRt7U/0nK7F6E+J2s6U9uBQXx0aCx/t8RAI1vL+WPvll1zOmPBE4R1t5iBMWDLHkjPBB+oaSOowUsgVobGBqWOTQLMseKIiZDt3+Tocanhb2PGyUmmRhGa64+/QkW3eAPAo3+uOhMYqvC1K687mGcDuSGV7sAK8cU+Gk7nzuPeW5PAN+NkbM0QNlWwgZoAa9oHZCmiib6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7BjdKy2pYar9nMRyH9t2lg5Pz5MWj8HL92lIKRK77Y=;
 b=Cogrc91MUs8MHC4Uu6jcfVtwPbf6K4QaXe83td4rL3/qi7o+aBcAesvQY5RIqACgRLrZTkK0jkt67l9tr50kaTOK10deRu1bphdBSMIiM/Fs9hyLxmuvSRioOo0kbJbDJ+oZRB658qzKAMiFKQ/eg8h0xFCV6Qgg5g58/SYUNJAf+Rk8zjsvzXgN4A8of8H1rI722IKBBAvOYzxjvt59ugR4prsqk3yKIvX77J5Fyuok6d5FSlPFgcJAS7QG9SVWcEsCt6x4cVSwfbgiUL/fF116DiqeEvuF3CZERtG/eP4uQI1zzLTwRa6qxLzbtsODmlWAGdi1ZGKALsIzJY5Yog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7BjdKy2pYar9nMRyH9t2lg5Pz5MWj8HL92lIKRK77Y=;
 b=upGT9FrEKWtrISJ4wl6wxqMGl/aDcMgRtdTHGbf2OI2TbsVBQpBWKnR0f8XdRZpPA5+k9a+oPs1OAbDqZiWEKx9G7VbSDqkYWDH1rSQHKSaYmhn0iH9+Q3RheekLhvICq9DG6+/7KTzpMJ/HfJjGWR9GafsvEdvGZiUTsCd3tu8ZoOLTcxw27wAL6vZSTWNb6HpQGGq0wKzjnFyoGVVwafauA0hqJCxd7mUqUg+MRWlMQEJNYfPAKFDJWArRYrLpgT/ovx5i9za6G6iNbrjnnHwU9HGhINO8grHYrug6rLd34fJFvSgZMVUxuwAtdKD1xW405qEtx4bx2D0k9HoyZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM7PR10MB3144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 11:28:50 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:50 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 14/19] cip-core-initramfs-dracut: add dracut initramfs
Date: Tue, 17 Nov 2026 12:28:28 +0100
Message-ID: <20261117112833.316234-15-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM7PR10MB3144:EE_
X-MS-Office365-Filtering-Correlation-Id: 958e407b-c0cd-48b5-4cce-08df449df22f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261022115727099003|261021121427099003|261102123227099003|261009223327099003|261009221727099003|261009221227099003|261009223027099003|261009220027099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: /OQojXSK/3UfkfsvsPW0KGxfdRgoXN1IcxcKXI/0ZaaSxz3Tfg46CWUjcoDiqQtm81YnoQ/GdBWQDP0xZxX+L1gcA0cJXDmaiUgNv927y69fqmf3QSxQXVp29rarlCoTXnM8wLc7wwt3qQzonEZr8r9xey1l4bxVoJkYLRbUBwfTtfXUn8gZUNW9TWDMRoBfevUVF6Uvq/bKMixAw6+PWKe3SIGULGhQ9figwdikJKc4fTg0r10O3EfGK5Pk5cVj2G7C2QTvsCu2uT2H4Wmyl50KsACXIlECS3f9jI3XnnAEov9WtF6QV+INtVdGgYd/2sqBXy2V5s97x6y0VEe4BHKFpiqf9QwJ9G8vviXzwfzceHXvoeh/cAOEENnS/K5LxGsm129UhJyLkrXQOblA3XQsCtLuDYPUdmGT9L7JOBcXidH3dAK3Q+8/80EIDw54RYIRhoAovnZZWK3Ahq1aD+lqD8OTmtNJ/plRR2x3sgykn8rAeoWqwxDiWJL9RF6KLUznzfpNeOnuVXlhEZUZmrTSj6t3hcm+M6+P8xYiswP2FYXCI8x727+L0OeixHt6ouwq5/CU2Eb+Xyt5NRmcVbeTw0rra8MvDV6QrZvESYj+Gvdo6czbnctHCmhQ3Y0kwEwUESZcnMlDx9CmzWL3YXg3OgLu3vEvK5Y9dWRLq+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261022115727099003)(261021121427099003)(261102123227099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009220027099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8jXLthBlTvHeOqiKi77ADcE5vDFtxCUT6cKdW/0LN2ETJsG6ddl85GNJxec5?=
 =?us-ascii?Q?HTxc5gHD8MnmkLjm3GzsF9a32N8zwE0XKqO0K3SrcxVH1I9/5yT2EIkoosBE?=
 =?us-ascii?Q?ItusNTgaLGLRYDnhvWx2zmiUBZr9vhT/iv0Q+psVTfz4DT3oE6LsCeY7p7rJ?=
 =?us-ascii?Q?Vt3K+KZ2sA9I0CU58sGyJJ0nsj5k/nJL0Tt9dQx3fsJVztqKeHyc623IM+i/?=
 =?us-ascii?Q?SdFNsGP+IY2IkJZG8Ew9kP89G39HyiuzzLKvY3IoiOq3U/lPAqdrQfVU1UQV?=
 =?us-ascii?Q?AMuuKDYIlkYlu/JT96fPYRgeel0l40ozX5kEIzaUB9cvtOrYnCGHTRep6IsX?=
 =?us-ascii?Q?SeCTMngdoUBpaWSRYE6QsfDBSIfa1MmbCuRGRcAPvMB7dF10e+57bz0xxNWX?=
 =?us-ascii?Q?r5EOnkWy4Alz4zT0HkPol//8yWv6aXnZc1a62ztd++SRErVV/T5jrnF3ItYM?=
 =?us-ascii?Q?0O/0fyuSJvDHf1Bc/PYVMny921Vj6vjEvGtvSVqb/vv9hqKISVgLdDyFzC9r?=
 =?us-ascii?Q?51bxeL9Iy8uVQKoq3bKAwMSdWvu1T+syPNpAxJq5jiVWYaKH10xPD6Eyjdnz?=
 =?us-ascii?Q?TCcjwPCT0NsaffsexbQqF1NpJqgwt5oMmHS90lGt0udiRHkt5R0RbweTRC+2?=
 =?us-ascii?Q?YYbo2N5Uhzu2TqcUWBX4UOw4BDfGbt+eDr7n6+2ha2gwEGEP4mO0QdcylNqD?=
 =?us-ascii?Q?pwTwbt6eAS3QvBAi4aTc9PcJ5KSZ7nXdh3Dq7bcxsfeyu8rx0H+hnpAcRexe?=
 =?us-ascii?Q?Wu1xIlNMn0hgFwQuGpgNxnAlJcZP3U7ScSlijSprKlydKoVikg7SCUzukFZ/?=
 =?us-ascii?Q?oG72bTJPKuaDV9DGGW6LvR7uqK0UMRdbN9Na5ISOaM/uTTHHLtwQ6MJ4yiQ+?=
 =?us-ascii?Q?7g04RLBuhWNzaApkuR6LcAoGuOjiixBQVWolSEMOK75ZvVmq+X1eFaUmrAIu?=
 =?us-ascii?Q?WCoVUSr0HBfmtpilwwlEusFjouTb4zJSlptyynwg8CLpYdpBZcgJkc+oWY0v?=
 =?us-ascii?Q?I/zDaqG3vX1TEqqkF7S3S9hrIek6EwWU2s3Xqpv6jEbs0hjvZTfG8/dBJ1/2?=
 =?us-ascii?Q?b2kScJHk5KWBH2yuK6zvcu1NdVahIdpabixAnc5JhrWzaGiXCdL0ogbzIQRC?=
 =?us-ascii?Q?gGHi5vYzsJPT3gAMZ33HzOPelUPka+QixBh9BJYwzrVzTL8H6jBBFTSheP21?=
 =?us-ascii?Q?/hS15531PiqGZ8ktFqunys4sqULD50wat25CL6A2HKPZbGOsq1qXMO2L6VTh?=
 =?us-ascii?Q?gXXsyKWu7dLsTh5vOO0LVjUXS7GSLNrHl6AEcBgwW/aJAtwUTmH43QPwIEsY?=
 =?us-ascii?Q?rDKljPRxddt+VT1pATjIdrw7G1uae6+YHdYTys1BOhNhzupbM7S+L+wfSO7y?=
 =?us-ascii?Q?akreaLxvwzUV/mOE97ot+rL3hU/3511u9qkJDz6u15PrG8sIS1uMAf3dftsk?=
 =?us-ascii?Q?kMZU/aDVsAI2pyLikL/MkerGw9Nx9Y7HiYYkcNdesNyCPUB6UvX5TfHvFubD?=
 =?us-ascii?Q?/X5LMfSm8BZCRgPP/uYKc55HF3lV+Yyta8lbXgOELcPGVaJZLp9XaAw1g2Ph?=
 =?us-ascii?Q?JE4e70IHkO4EJurLvjEBw+QfumORjq/am8ZNvkcVa1oFyodUqzgDYvmVCF4r?=
 =?us-ascii?Q?Y/v4aujticcL2YS9C4yr93cvcZQOInhjomekvdd+S9ZvySjLMTrC/ilncGEs?=
 =?us-ascii?Q?uGP0JcsCTNf5dNyVL/1GJ9H0RX99mk86DU8WYcS9461xLM/epcHCKoI2xfeO?=
 =?us-ascii?Q?0wC8yR+CzsVX8GfdkwidgfTHaI0vuJc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958e407b-c0cd-48b5-4cce-08df449df22f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:47.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zybb8M/TJQwq1gyKYge1EgqqczJtQOYoOE1MGHckbOZ0HH8ckRRx39fwjle7VNSxzAoIXTPrhnFV56ElrjRfTYkKLPiRGIH8tLQPzyglT08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24835
Content-Type: text/plain; charset="utf-8"

Debian forky switches the default initramfs generator from
initramfs-tools to dracut. Add a dracut based initramfs so that CIP
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

kas/opt/dracut.yml only selects the recipe. The distro configuration
derives the systemd kernel command line style and the verity container
from it, as dracut has no other A/B root selection than the root hash.
Building the dracut initramfs without ROOTFS_CONTAINER_TYPE =3D "verity"
fails at parse time.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass       |  4 ++
 conf/distro/cip-core-common.inc               | 12 ++++++
 kas/opt/dracut.yml                            | 17 ++++++++
 .../cip-core-initramfs-dracut.bb              | 42 +++++++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 kas/opt/dracut.yml
 create mode 100644 recipes-initramfs/cip-core-initramfs-dracut/cip-core-in=
itramfs-dracut.bb

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index b40b7d55..b58331f4 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -28,6 +28,10 @@ python () {
     if container not in ('', 'verity'):
         bb.fatal("Unsupported ROOTFS_CONTAINER_TYPE '%s', supported are "
                  "'' (none) and 'verity'." % container)
+    if d.getVar('INITRAMFS_RECIPE') =3D=3D 'cip-core-initramfs-dracut' \
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
index b567df2d..ff66086b 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -32,6 +32,17 @@ TEE_SUPPLICANT_IN_USERLAND ?=3D "0"
 PREFERRED_PROVIDER_factory-reset-helper ?=3D "factory-reset-helper-file"
 PREFERRED_PROVIDER_factory-reset-helper:ftpm-stmm =3D "factory-reset-helpe=
r-efi"
=20
+# Kernel command line format the initramfs understands: "cip-initramfs"
+# (initramfs-tools hooks) or "systemd" (native systemd verity arguments, u=
sed by
+# dracut). Other initramfs implementations can set it.
+INITRD_CMDLINE_STYLE ?=3D "cip-initramfs"
+INITRD_CMDLINE_STYLE:dracut ?=3D "systemd"
+# The dracut initramfs requires a verity rootfs.
+OVERRIDES .=3D "${@':dracut' if d.getVar('INITRAMFS_RECIPE') =3D=3D 'cip-c=
ore-initramfs-dracut' else ''}"
+# Symlink below /dev published by the dracut embedded-verity module; used =
for
+# the systemd.verity_root_{data,hash} kernel command line options.
+DRACUT_VERITY_DEVICE_LINK ?=3D "dracut-embedded-verity"
+
 # The read-only rootfs is described by two stacked settings:
 # - RO_ROOTFS_TYPE: filesystem of the rootfs (squashfs, erofs)
 # - ROOTFS_CONTAINER_TYPE: container around that filesystem. Empty for non=
e,
@@ -40,6 +51,7 @@ PREFERRED_PROVIDER_factory-reset-helper:ftpm-stmm =3D "fa=
ctory-reset-helper-efi"
 # to the A/B partitions and packed into the swu.
 RO_ROOTFS_TYPE ?=3D "squashfs"
 ROOTFS_CONTAINER_TYPE ?=3D ""
+ROOTFS_CONTAINER_TYPE:dracut ?=3D "verity"
 # Derived from the two settings above, do not set it.
 ROOTFS_IMAGE_TYPE ?=3D "${RO_ROOTFS_TYPE}"
 ROOTFS_IMAGE_TYPE:rootfs-container-verity ?=3D "verity"
diff --git a/kas/opt/dracut.yml b/kas/opt/dracut.yml
new file mode 100644
index 00000000..59dbd730
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
+  version: 23
+
+local_conf_header:
+  dracut-initrd: |
+    INITRAMFS_RECIPE =3D "cip-core-initramfs-dracut"
diff --git a/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs=
-dracut.bb b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs=
-dracut.bb
new file mode 100644
index 00000000..db7b1cee
--- /dev/null
+++ b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut=
.bb
@@ -0,0 +1,42 @@
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
+DRACUT_EXTRA_MODULES +=3D "embedded-overlay embedded-verity embedded-watch=
dog"
+
+INITRAMFS_INSTALL:append:encrypt-partitions =3D " dracut-config-cip-crypt"
+DRACUT_EXTRA_MODULES:append:encrypt-partitions =3D " embedded-crypt"
+
+INITRAMFS_INSTALL:append:factory-reset =3D " dracut-config-cip-factory-res=
et"
+DRACUT_EXTRA_MODULES:append:factory-reset =3D " embedded-factory-reset"
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
+RO_ROOTFS_TYPE ??=3D "squashfs"
+DRACUT_EXTRA_DRIVERS +=3D "${RO_ROOTFS_TYPE}"
+
+ROOTFS_INITRAMFS_GENERATOR_CMDLINE:append =3D " --no-hostonly --no-hostonl=
y-cmdline --reproducible"
--=20
2.47.3


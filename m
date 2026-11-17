Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15529.1794914926563983602
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=v0piYCGV;
 spf=pass (domain: siemens.com, ip: 52.101.83.21, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYrETTLOt0f8gA0G6M/m7G6HNIUvg07IQsb6aROMddBWEURQQ8koLJDGwWwKRKSpyT649kkvHvH3XM8CLadcesFmmySwT4cWLOydwvNDroNM7zGgvBEBvrQ9EYxc8uBe+/Y4Okb7XZxXZaDuQa5Imu8twm4DJn9sHxBT9XxaKMzd3fpNTDBTXO5IC+Uz4dmzDc21FpiI1KWnu81696X3KoKNNKWwx6SGRl/WZCXo1Io1PQW8zFL588z58acQZT6GjntIgPGSf9iduyUvmpjis48GuauqmwaRm/N6vK62cSdQaf8wzJByeTLtIx0jmfkIx3K5ios3zrDCUnLVITGkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5vOMsqcz6rgweiBxwnF41taURbUd+Ix7UsJKmKZY+Q=;
 b=SLBIRcEAtXEPvECm9wF7kHmIAjFtYR0N9Yl5PuLSDUPTskXQteoBvcbrhXPOgalCeZttjm3VQqD3COpV81feau1qM/73u6xEqPX8wbebRsQP/bcv+/T42LsSk5mVyXP2QoqNZFXXii6IBV6ia4c3JV0pkMz3czYkHR35w9zUwqhTFx79qfivJXrA84RdID5d02Rm6bP1mBrv6yYG33xQ/PX8jsFXCJRTf+GLtrsj+5dM39xNRuN9ed9WrEjTKc0ldjvCReMuon/7oqpRx6bF3cqfWv5yuh39FOxt25YJ6RcblrsSfr6jo8zhnsOPpMa+SFbgxC4kqYU0M5QfyaoRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5vOMsqcz6rgweiBxwnF41taURbUd+Ix7UsJKmKZY+Q=;
 b=v0piYCGVcQ4bCkvRRM60cHcLiIj9UOw2E+Uh7v5Kz08SSyy2eYE/DNfPpG+9YufDR3FTU+vCuJwHJyeIBypF2ZeomCOS8EKVqJlOysDRs+rp+pI8H2PU+2rygRtWPqe7RrNw9hs98Eqb5J/PuawKQLnQjiTTMJn/kVpa4a+ssLyCI9lHUUcYYZx2EC+qT7CMq9S1hbhqCt3KcygclBfwRDmUNJPc+Lw/oiMB3A/eYoHnCsy0N1QrFNafAqs2ryjLfAz6lf4daxgxeoVKPjg9lRucMGuwyFKb/paspw7wQA8+duvEXf2wHHEW5oSUUoP+68/e2tlCsm/sOXq9zYxEAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS2PR10MB6615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 11:28:42 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:42 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 03/19] Add ROOTFS_CONTAINER_TYPE to wrap the read-only rootfs
Date: Tue, 17 Nov 2026 12:28:17 +0100
Message-ID: <20261117112833.316234-4-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS2PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: b751e8c8-346b-45f6-f2d6-08df449deedd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261026121527099003|261022115727099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261102123227099003|261009220027099003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|55112099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Kx4+Zq5ZHsGLtJ/Rjar8znTWYZpxEZd/KwU0qjg/IlHIPxTY+kjzqZhVhcPhHvJNm+352vjcrjnMI+fkMGuyJ0DbD/pXa44fRt5F2X2V5ZZBHjMeFPgRaJd1eR/8DGk20ioCL2ubc9xWcOvqf7XqGMFm4my6EKzTkQKgTKmzAnVHwqrK78EhZv8VJEDQB5ee5/+KNMm7AxuFCKf3fPGGufrLOHLB9FKf1Ue5DIHEyJdC7hMexZ55sGSzr14YA2XETtfaipnHI1E5L62zJ55IT+9ifA1kaWlgNRyt13QVtu9rQRR7CNwfxnK6IwKJKfd5SwhQmS5tKCqYihvCHC2BP+z4cubyixOU9KO8w+cJIP29MTDmamWBkHEYGnRZwbrOzNoxI/va8mqngPbb6NFiEzwywhkvNgWMCAd38yBfjygEQEQWx0HkesyvzjI40stAekfait6eiUkegLZivaoWVx7ijoXGZRaOinfpyDfavt9HLJqxqymVUPZ438rT8WprBCVKNgE8Ux4BZzyCKZQls0HhvWkzMTrZhB21JJ2wIU/1VL8HktQD28jbFMhVBjcnxned2wqFqTyC+MQXC6SYvOqnFepj0CVqGUJ7DESxaV1vrfMGKlzcLs/SaLMVlwSyvcrKX4wkraEaJ8rJur9MfrnIJ/t131zVJb6W56m5ZEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022115727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261102123227099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(55112099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lPCvaJHHqHOSXYJebNFauwPS2DCgp16p8Sk0AixPSf1Nl/88pxfYhXXkE05I?=
 =?us-ascii?Q?b8LZUdv85Vr51NIIjX30F63RzE6GvWEwcQ5RrSC1xPr77Agepzje2ReWqzWW?=
 =?us-ascii?Q?eueo6+7ENFGiENaHJbJxGFZwO6Whlmx8R8mnav5GlU9ONMOfDIQoCv6laXkb?=
 =?us-ascii?Q?5gqtiS3Ds0gyfAd2xSRIrN50EiarOBkWGFXWe9JH4TTW5mQMxvQTlMPUfZre?=
 =?us-ascii?Q?iTYNqzBAG02cBR7aYAerOqUFoRe5BJJxb7zltpERCgg3QwmOi8uhBd/uApOT?=
 =?us-ascii?Q?gasnJyCTT7pby8GFvU/457A+Ci4+wH7kulFfS6Epw3fdKdxfxu1vNYj6vuIU?=
 =?us-ascii?Q?BAn9Q+23NTLiLFRdGH5cPaBTuMwNyXOypk8Uf4sreNLIA/oSTMXiYW4JnFxn?=
 =?us-ascii?Q?x/y02dQFtoB87+EOHPZzyCGyJX1DCrxxKLEi29IQTnqc4XQCitrr6HG1hile?=
 =?us-ascii?Q?SJnV6sg266+JvKDAlcipCoQ8UycjnOfiKSfDVJoIyQCxANnyuXNRBUcJaHhe?=
 =?us-ascii?Q?7I5WgTT+FOeq3BuHe/dAzX6mMKdoksZ/w/Q4F9lNdRriQ1e6MPTAO3VFTsX+?=
 =?us-ascii?Q?pb6wHHG14y+8zgy/3v9Hok2e3gWBKpIJGiCffKXkXQfX01/qu6oDCwk0e8gL?=
 =?us-ascii?Q?LWEIuwp9jAFh2DFBVbwBqhk62H7OjM0XxZh7IM6GhJ+266nt0sv3cE0mdzlM?=
 =?us-ascii?Q?o2yjUM2/DjyPxvKK9htkOqHlENc69rschlMy2wZrd88pwqC5U3ohpkc/3ZDg?=
 =?us-ascii?Q?XJ7iPJSaKwGK0brWlIx4WIB4NQBPfnAiKDeHw5DFb+rf6YauSXlD7yQ3dt4F?=
 =?us-ascii?Q?35eLSZs8Qqa4nud14zKG9j1Kt8hghbwb2yVt7pPbshrEu68KSyagCXTM66o7?=
 =?us-ascii?Q?ABoqqbLaFvU1PNsqM3xtcpCi3xwwdmfV6/Av2oe7J57LilFZ9MlLYA16jv/o?=
 =?us-ascii?Q?3m93ES9AzhVML9wt+TqwTrVl0zK+2SLA/H8g4x52Dx7b5qda/4B8CfZFi417?=
 =?us-ascii?Q?7MhqT8HmuncXdZvzhT5hSUJVnOLjsMnmpHrKhcER8pWu1jhlt97HIiz7zgvS?=
 =?us-ascii?Q?dkZHZIr0ZIOCGmJYGMLraPOX9JZ26fZ0cgxc+iiCUAB4IZiSuTafuVW5+RUG?=
 =?us-ascii?Q?e54T0GVpqcsCW1cqCB7kjSsUpvWP0ObyeYvbc2X5WgAobmAY9fpC8aR7fj7m?=
 =?us-ascii?Q?KcVv7x+cLzZlYNbXFt90uDOEehvW/fLcHzXQaS/RZO2ceOnGvEMUKaG+IMLp?=
 =?us-ascii?Q?YBZCF0IoxfwA59NxuWWTnp0zxuQ9NundTM5lmQjw6rA3vLBdeEWtBOPigZ/N?=
 =?us-ascii?Q?Vad6ExCSqAaRw5IHQtZ8feAEOvccSMMzu8Hq00JeRzMXpzr1xU3tF7pIHAak?=
 =?us-ascii?Q?a6z0CokhsXOJXFTM0RCfWf+tSPTF/mYkmQ4iM8oe1xw+sJ+T3J2pbZIjywrX?=
 =?us-ascii?Q?U63PoaEBaYvTJ8XWmu/ZAIa4wqKBt5lkhpM4hmpdyFJs34BWcQcNBIS1YvDR?=
 =?us-ascii?Q?htnxnUjnvqAaAG3ysChjuNK7YY5jXW33DyyOW/z/n/CjLvoLOeZyRSEEO/5m?=
 =?us-ascii?Q?k/rNfyhHPxkTpcpkghQCW5an11eyCtDQJjkhQfaT5QkFbe84UwMWYIrbGGyq?=
 =?us-ascii?Q?04R80tWqVTkLHDMvml1wZS4z1+VUf6asXUZVPtGePN3O2Q9Cvm69KkUd1fwo?=
 =?us-ascii?Q?ZCbIowVzwB1CR9/55K27UU5Tf7cfFEWYj+LRIiY18QeWVI8dHgcVPJeMjbMi?=
 =?us-ascii?Q?hZ+HzR8ud2L72/gfNyredog5LaqPcMk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b751e8c8-346b-45f6-f2d6-08df449deedd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:41.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Fyy9nvReKQD8IzfAYbY8T8Vl+MVVjGGMYaGF2KEmNpck33goZ9UxrRLCikMZSYDuviYPN9cSp4w4YquvauuP537y3sYg26082w2aVVGTn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24823
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

Secure boot sets ROOTFS_CONTAINER_TYPE to verity by default.

VERITY_IMAGE_TYPE is replaced by RO_ROOTFS_TYPE.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/swupdate.bbclass                     |  4 +++-
 classes-recipe/verity.bbclass                       |  8 +++++---
 conf/distro/cip-core-common.inc                     | 13 +++++++++++++
 doc/README.secureboot.md                            |  6 +-----
 kas/opt/ebg-secure-boot-snakeoil.yml                |  3 +--
 recipes-core/images/swupdate.inc                    |  2 +-
 .../cip-core-initramfs/cip-core-initramfs.bb        |  5 +++--
 wic/bbb-efibootguard.wks.in                         |  2 +-
 wic/beaglev-fire-efibootguard.wks.in                |  2 +-
 wic/de0-nano-soc-efibootguard.wks.in                |  2 +-
 wic/hihope-rzg2m-efibootguard.wks.in                |  2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in       |  2 +-
 wic/qemu-arm64-efibootguard.wks.in                  |  2 +-
 wic/qemu-riscv64-efibootguard.wks.in                |  2 +-
 wic/rzt2h-evk-efibootguard.wks.in                   |  2 +-
 wic/ti-am62px-sk-efibootguard-secureboot.wks.in     |  2 +-
 wic/ti-am62px-sk-efibootguard.wks.in                |  2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in         |  2 +-
 wic/x86-uefi-efibootguard.wks.in                    |  2 +-
 19 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbcl=
ass
index 4011739d..3b97d7dd 100644
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
@@ -62,6 +62,8 @@ IMAGE_TEMPLATE_FILES:swu =3D "${SWU_DESCRIPTION_FILE}.tmp=
l"
 IMAGE_TEMPLATE_FILES:swu +=3D "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
 IMAGE_TEMPLATE_VARS:swu =3D " \
     RO_ROOTFS_TYPE \
+    ROOTFS_CONTAINER_TYPE \
+    ROOTFS_IMAGE_TYPE \
     SWU_ROOTFS_ARTIFACT_NAME \
     SWU_KERNEL_ARTIFACT_NAME \
     TARGET_IMAGE_UUID \
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
index c945378a..e6142351 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -32,6 +32,19 @@ TEE_SUPPLICANT_IN_USERLAND ?=3D "0"
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
index 569d2a5f..26244a1a 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -17,8 +17,7 @@ header:
 local_conf_header:
   secure-boot-image: |
     IMAGE_FSTYPES =3D "wic"
-    IMAGE_TYPEDEP:wic +=3D "verity"
-    SWU_ROOTFS_TYPE =3D "verity"
+    ROOTFS_CONTAINER_TYPE ?=3D "verity"
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


Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1327BCCF2E7
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:01 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31402.1792405553417919648
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:25:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QWBGgSrL;
 spf=pass (domain: siemens.com, ip: 52.101.84.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oo310KpfPgDuuEHxjjvUvFJPrPuH5I1S5LCv37xoeYuiFmTYvb6VfxwNbWXAcBuXxz7GT/nDIZN5dJnINwaNSjYcQFqvU872hpug9RUbyZn4uMRbH+1CsQpVz4rXcbvDIxJiU6d+g/WSwhtHoZiNloRGhcObkcNlTwrV856ZkfIzd080jmrT80CosqkVFVae2Lw0ZgQNilrp7cDbLjL2QvJAHPuXd2pGK7+4+wcTtM8WheXAhcUkvrzugjwnW+wIa3OXG8He2TFF034MTn6M1y14R981rtdI4Q0+gOkWp6OdPYoJdsOj4LYZG+yOw+F7i5siAX7xEkm414AdI5mUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JKFp1hf/GIx+sbUNb6HuR2sX0Ras3rfb/tr7zJHFlY=;
 b=j2V+hkJTyNm1CMtilfn5BhpIPf9UJV4LU31V3uHhd/nphDbKwBzLMuLu/yhCp4BNEKTz27c5SuW28/lFiKNKZnfiNlKV+aqwj/hu84mwA6ZpF3rmBJJqfukd9SD95+ryFpsS8HzdhsfMhMCZLNLB7LGxhD3W2fwhzDc3g/vRLJk0UcU68bCaa7mqvJ39bOyXjuIzg7Dk0XFZaYNM9JOQ9huTxlnk7zNtsA/7yRT83NFzBhiehKaNS4x7Rd2wvVttQF+2YIaLVkbWomAux/J2A6adnQx7sfYfq4mlZUzKIEZe/BYg3uQ65//5m5hVQfT/s43EJmW6MqUX5X3vMrzs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JKFp1hf/GIx+sbUNb6HuR2sX0Ras3rfb/tr7zJHFlY=;
 b=QWBGgSrL8L+CgFChz++vGA7f9gj5h+0XZhrXxSd68/Z9na58O7vCkhKB4yDlUNZeTo8gQmW78dXhZDn1iEebCxYHrn+M/SufVA6qZ9pT9V26ej6OU3JVK0Il3OY/IeuN8yRCf7npx/nPIv6aORGiHzemSjCa6tqlCL9bXs15z3KvtgQZ8Z7/Js+np04kG29adhnWPp+N9boZN0u7fEd/rxg61deszrd24UnhN73eUSkpEvHQEbzASBp/Zr1GEd3n7bIY1iGDu6+GjXJ1IHHUHtqOMmlLBemvabAHglvd2atnzZ4XGw7luJNJ1yv0y3eo1a2vm2y9tIvM4fRcQW0okQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:50 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:50 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 01/12] swupdate: add RO_ROOTFS_VERITY to select a dm-verity rootfs
Date: Mon, 19 Oct 2026 12:25:12 +0200
Message-ID: <20261019102541.672620-2-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3581ccc4-fa0e-4809-03cf-08df2dcb57e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|55112099003|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	Oj5cCuzdDriOz4vKoOZ+BAxOyGpdYr0FDj1NvPTaZzcUqoSm8yHiraLsjcfkwnRBCrgF0p99rx4VbeVLD3Wt8Z8ONAoS9ndH7IwU3UghGF08SgYucDE1wE+JVxbY956AKFOy0HWs+8XGrh3VNohKiHktCf/cNaYgjT/xEEpRt7YIoJPII/B2vviJleBPHU2nQqV6G6iOELg3c/nlv6oS8qhH6oDvoj8Rg9+fLtARTcwMvkHt9y7SQv7QruScaMKvZgfYdx2ETaUJcKN6LYUIkCoKkYOgTN0mUStLKJdPZgZ5017ezEdN6g2tguwJ5z+TixOuHjq08Q3cISd0mvLcAIWwEJqLqyZWBrlQj7cpYHLBniqg7eFvwz/2EPpdy2cL+XBeVXZcGalOgIDB+93yBGqWyM8karQYYcgm10mm2TUUoFmZbSpD1443gzs62s+XWYRiRh8GgYqfMftGaOfVZOb0r057u2F4Lh4k+GHyT6aYqdexTNv+T/s5dURn4sW97XtipsUGqHDoT6A+/OEaHlXXdDnXzmb+C3aMVIFghweCS1IodiUv+VQfqEvMKigTEmEEaPwlWSNqLI9u+YN8ozyP+bjQtuUqBVUNmGUTYzFRjd36LnhVc4WEGxzClfMzRdXWXafpXnBex2dyjsp/oKj0Fxjef3HmLuwRHy4gD9c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(55112099003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LhZg3z2ZK592/v7ANbREWhenKA2O81G81gsRM0dc4IHLQUHqDOqDoNEyNYqg?=
 =?us-ascii?Q?qcKD4Fv/DfjJ+A3u61ewAmqeP3SpAIMNUgSjOZf6pCqc2J9lnGkKFxZ01peo?=
 =?us-ascii?Q?n2SGBDXeVKh4xq6/+adj2ZERHs9iePkVXdWn/kuSI6S/FVBTLt/RR/4Qr6WP?=
 =?us-ascii?Q?ObfK9EqDDI/yu6R3/5mYjDzqOotBc4ue7barPeC2ruljfUuM3/OlgWbhW60G?=
 =?us-ascii?Q?OAcHCiwkjv+Z0qelaEYnOGmE8RhA2ccCeFYMWNKJaRV0D3gH/XpAAy+fp0n+?=
 =?us-ascii?Q?6R7TpmO2+D6jErxso4pHO1obasTNCXsPmsBMaH/Z5mvLaCF90EAB/0/UT5QD?=
 =?us-ascii?Q?mG1zLj1Wy6NJw3K83GYDQ6OQiF4booBy9jeqDK90SaUNLM0uphH84lMjpqBb?=
 =?us-ascii?Q?jUxqHHoNnROtruHrVs69UhhbL9XzYJQVLeryFBW+ieV+58q0+vmXwdW1ON4g?=
 =?us-ascii?Q?sXoY4HbcktgQw1gsqk9xmkjaPvJ89Rp5xHE8/1FGSi+n9fnklhyWbM1K6avv?=
 =?us-ascii?Q?AXmeibd+KdQFZ46FwfvO831f/0aYB1rTkoBC2XrDxLKc8CLk80h7JB8QMikk?=
 =?us-ascii?Q?Jq/GdO5pV1wCFOcNIo3VqdN+UefZ28EV0T2Co0WCJlENORzIdmzhuVTsb+6x?=
 =?us-ascii?Q?aF5DdEGhDuGTfcOtgLDGFBMrQ1Ubvtnxl/FdNZK3G1599GJzv/oIxmD8IN3J?=
 =?us-ascii?Q?rMwiuspi03hz/xRw3bpFb4jwl4H4z8fWFewqstP6/l+UJa8Jr/yQd+xRft1R?=
 =?us-ascii?Q?ZhrQXUmay1ukaj//2rTUe1p++qaXqm92WCwAbShvgUvT7AiPOsOHtNVNqUR+?=
 =?us-ascii?Q?cIwqrt3kWAwH4ov23SAtdT+IRItpWp+9b1Vkrh4NOMbi48uS0l9PJsLKSe9v?=
 =?us-ascii?Q?NWN9EdztKQY4EX9wNF0qqJJCJgLJ+I/gvuhRk3AmtX/umpqPDfZYiedHAo6G?=
 =?us-ascii?Q?Y9B32v/Ju5qdM3BhEZSXbprbwPdK8wn/Th/mMUaxa2ckhQTPIt8w+SDflqgf?=
 =?us-ascii?Q?bRxWvCwI12gEn3yaPfpSg3FPvNBSQD2rOSnZWput6w3WslM1/RYYFGxz9wzq?=
 =?us-ascii?Q?zW3UHJVsql0IYdvPuiIsn6s3LNLBOikiDNRRiEaF0eA3s2SNYfCyjlUk4HDJ?=
 =?us-ascii?Q?UizaHpChZ9/Ls6z/uC/6McghurmTvZbSMa5kqJKXM6DEQHxFxb0WM3HkYrJb?=
 =?us-ascii?Q?6PNitrQ6r7vRWhlxyBNYfpWyRui/DWnwEFUrxIBJ9yCDEKy0iQhigCAt0j+a?=
 =?us-ascii?Q?Gx8O2XDra+x3lLzjTbeen/NjM+5c+Y9OHREAu0tgFqvK4VJCr/eOFiH5CkBo?=
 =?us-ascii?Q?7D3YVSf1JtfVheQE9R93cnyWVYMOqnuQRaaWNSc3Iz4L/lW1Ic+sjpqg3UN0?=
 =?us-ascii?Q?WLW9ZMwBvBg4ZxzpwLji4k87/2ElQBaCZkKmCgMwcJPl/ojaWvtiJvjTdrfn?=
 =?us-ascii?Q?ELB74L9rAflFBmHvpnQphd1o3bsOcpKvYbnbTgO2mTVjE3gNyt+AFNlRoK1K?=
 =?us-ascii?Q?VPxDgJsOhM6StHtgMw74YdAHZRXW2sF0Fj17bOLJZ6b92cyDRU9hPVAn6tpy?=
 =?us-ascii?Q?zeX/JUtgCIScvEL0hCZSSHkZZvFZ03uhl2A0iYgTeR5hYVVUqHyGzGt8cVzZ?=
 =?us-ascii?Q?VcnCbN2GMBYKUIkCwa+JoZaHUNAn9sID4DilIh1WyFeZrLttjnEMr3JJqroR?=
 =?us-ascii?Q?ZWGqkybR6toJGCTT7svnJtoGb0oY9TfyFJafR8tPkGQdKQPp1bQr5jnMb8Ug?=
 =?us-ascii?Q?eDXustulG5gj1YZl0qSVK4e73wCjFoU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3581ccc4-fa0e-4809-03cf-08df2dcb57e1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:48.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZhWiLUrbF65DF5zIyW4fOadbP6Pjm71/tooVxFVXggn91CzHYo7DV6x9uHxwfcI30KuJB0fK/ZMFmbc6H7mt19x20CJDQmfVjCsxkyvVAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24482

RO_ROOTFS_VERITY replaces setting IMAGE_TYPEDEP and SWU_ROOTFS_TYPE in
the kas option files. If set, the wic image depends on the verity image
and SWU_ROOTFS_TYPE defaults to verity.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass | 3 +++
 classes-recipe/swupdate.bbclass         | 3 ++-
 doc/README.secureboot.md                | 3 +--
 kas/opt/ebg-secure-boot-snakeoil.yml    | 3 +--
 recipes-core/images/swupdate.inc        | 1 +
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 1690ecb2..70152de2 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -9,6 +9,9 @@
 # SPDX-License-Identifier: MIT
 #
=20
+# Protect the read-only rootfs with dm-verity.
+RO_ROOTFS_VERITY ??=3D "0"
+
 INITRAMFS_RECIPE ?=3D "cip-core-initramfs"
 IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
=20
diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbcl=
ass
index b5b5273b..ba0ddd7d 100644
--- a/classes-recipe/swupdate.bbclass
+++ b/classes-recipe/swupdate.bbclass
@@ -11,7 +11,8 @@
 # SPDX-License-Identifier: MIT
=20
 RO_ROOTFS_TYPE ??=3D "squashfs"
-SWU_ROOTFS_TYPE ?=3D "${RO_ROOTFS_TYPE}"
+RO_ROOTFS_VERITY ??=3D "0"
+SWU_ROOTFS_TYPE ?=3D "${@'verity' if bb.utils.to_boolean(d.getVar('RO_ROOT=
FS_VERITY')) else d.getVar('RO_ROOTFS_TYPE')}"
 SWU_ROOTFS_NAME ?=3D "${IMAGE_FULLNAME}"
 SWU_KERNEL_NAME ?=3D "linux.efi"
 # compression type as defined by swupdate (zlib or zstd). Set to empty str=
ing to disable compression
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 2b14bfb2..2d107a07 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -158,8 +158,7 @@ header:
 local_conf_header:
   secure-boot-image: |
     IMAGE_FSTYPES =3D "wic"
-    IMAGE_TYPEDEP:wic +=3D "verity"
-    SWU_ROOTFS_TYPE =3D "verity"
+    RO_ROOTFS_VERITY =3D "1"
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL:append =3D " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot=
-snakeoil.yml
index 569d2a5f..e1665187 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -17,8 +17,7 @@ header:
 local_conf_header:
   secure-boot-image: |
     IMAGE_FSTYPES =3D "wic"
-    IMAGE_TYPEDEP:wic +=3D "verity"
-    SWU_ROOTFS_TYPE =3D "verity"
+    RO_ROOTFS_VERITY =3D "1"
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
=20
   secure-boot: |
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdat=
e.inc
index 006d6220..361dd5e0 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -22,6 +22,7 @@ python __anonymous() {
 include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
=20
 IMAGE_TYPEDEP:wic +=3D "${RO_ROOTFS_TYPE}"
+IMAGE_TYPEDEP:wic +=3D "${@'verity' if bb.utils.to_boolean(d.getVar('RO_RO=
OTFS_VERITY')) else ''}"
 IMAGE_FSTYPES:append =3D " swu"
 # input is already compressed
 SWU_COMPRESSION_TYPE =3D ""
--=20
2.55.0



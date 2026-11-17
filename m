Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15529.1794914926563983602
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=dA2EsjR2;
 spf=pass (domain: siemens.com, ip: 52.101.83.21, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3bXNIIaBd6WjmfFzEeRv9hJGT/DA+BCvvHFUP3FfOJFFhvz1Y1bqYaaK+faRgKP2ar9yeh+LcbiFOkAhcJLPThdkTMQQ20oesnySr/1GOxSInBTgGXuNqIgqUTpOOkh4mAPfup/i1NHvucuzLvzRpVm4lS5UlLIkanoujUYe419WTkdmI0YynPSWVhTLYGrGfOlMP0Ci/hj3kzqUwUnawDz4SX6IUMrH3sOkopAt5p2cpJxXO3Lz0viB7GE1VWYNkWVpf6KETn+1VRCefaNtenHffeSo4jC7keFPA6lea2AFI1Yo8Pqc8Jat0D7OL9mXW/vhXHW6St/MDrJU2lVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYi8FiCZkmsx1Nu664EDtKkq0JfWS5NcoObOO7nHkMU=;
 b=AGaRW2xPW5TAuh+JOyDF0K4354v8+Bnlh6XT2h0bzSkhbTERsTF50d+SM2cD16+QENXrs+yoc6vUojxRQtVarqO19CFCfT5vxgZm+0797UWZ6EBSmg3fkMlwGm0HRNhK2+1U2NREMvev635h3hNTjw8PW9GFvCYFcXNhJoaqfaJj4bepMXZFvKtXrZzsMo412l18fIzu9L9Ce1qEtbc8TFDuhVgJTq8mmmLV6zbE5H5KJb5SC2FwexS+EE7bqEZcDeQbHnNllsNBUYg/lTekLpNPnfJs1KlE58Nk2lTFnGvfFvEBHqaYk7tcbnxJNLtjfJQH5YRyzu2rZ2CEvzsd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYi8FiCZkmsx1Nu664EDtKkq0JfWS5NcoObOO7nHkMU=;
 b=dA2EsjR2OMwnGj6tWTA2Yv8kJFWyxOrB0+weS4aQIba9gQyNdOpIgzYuCtTWytn5IBED7W4Vx+BNG0wC2aGRqvrJ3zYePb+8oz/+zthsBV4aCzsLOOhSc0Ng7bTEk4ivV31ESPNdi5nahjtnhbLpqyJVqYZpG55S2ImAF08zqTyJSa2x7wBBtPYXuNXVCArxSOTgzGLM5OkMG69NfODxsDiGK03PbsyHkTy8H3OW3xFBLzIcmaXAXdqva8eFVShL9DU4W1V8Ys3e5x+KMvH9XjM8f2w5b0Ya0p8oCZook7yAifc5InpMRbYk6TnK60Nsc0JuV+kthYxUsgx8tbJEaw==
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
Subject: [isar-cip-core][PATCH v3 04/19] efibootguard-boot: derive root mode from ROOTFS_CONTAINER_TYPE
Date: Tue, 17 Nov 2026 12:28:18 +0100
Message-ID: <20261117112833.316234-5-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6241dd6-5f4f-4eb0-8864-08df449def25
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|260925021311599003|260925022911599003|56012099006|11063799006|261026140227099003|261028144727099003|261026121527099003|261022115727099003|261021135927099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261102130727099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: EPD6bgfvrvo+ua7VGVEvYufnzL3daj1EXQOMPUzsJwi97kVPa0x6u6ykrG/uMqwS7DAQQ53qjeu3+LNvKkXfbe2xyCQ+lESoqThrfInS5usF7Oi9RoKrK/PiCaSNFKtTfFqsQlZSyRUlnT3ZcA4Re2LdqHDPQA8DXvxQLrYjEewM0WZldfWe2b6UZnIn/EdAsNuoGPxe4Vl4PGNd30M3odAeSGNv6hjMY2HkVjqTRxIdqIVVh6gjiT1VNwgwyhndVFeN1+p8iAE/JtkUhSjZCO5czcso/H+iYgF6vdgfgjgWV0ldsvQO0JxvLniHSYLRJR1CvsBd8lzc/WAfZ1T6EeL9L+yMaxfxN4ScQJUDVXaujgst4MvSJSD0c94GsLr+VTJ1tu7+ao1p+eClCniCHM4/DAWgewKV8x/nAAXtWl83Z8RLSJAL99/I+FTx2xsM6ZsNI2qhc+mTeaIER0JhwS4nhIGccXV4GvHxcytC8qs34gZHaUbwxsnnquI090HbHSFucRzCmoGM7tis4XJgRJPftIUocXsaQau7c2jHn5FYuGq7aDyq/tKB99GHJV2XVi+Tnr2n2zQbtS5dCVZASMhJXd1OkBn5iZ5w8o/jq4seA4T5LLvpri34AZfzr6cMdcdN79kKmBNys8vKp3TXpEhE/kpNGCgmeXT3gUsVqXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(260925021311599003)(260925022911599003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022115727099003)(261021135927099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261102130727099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Co86XkZ5slMSE4bZypZMjcEbRP7coN2Xpx/M7ocjFlfFevGloKJayZXbchNi?=
 =?us-ascii?Q?WO2H9dvtA9ApWYywpEd/AQHhN821i4y7PQoaNMfXqm08Tz/HAMQLcWY/D0rr?=
 =?us-ascii?Q?zcZrAvkg+CTRQ//0UOpWaKh+qQzPxWJgxFMyJfx96nrtmjiI1kPsHkbIjROa?=
 =?us-ascii?Q?lDVjnAw4rYyKN2kB6DiJ52lOzxiQgF9w8ZCGPFpjg4Bo5HGmIWJHXHuK/Q2L?=
 =?us-ascii?Q?0EdLhY0pMyKkp36A/TEey9Lqw69fDjnvt+OHY1hLo71yuttPDe5oOB2ZpsqP?=
 =?us-ascii?Q?G66OBzVZ7Kfc3hamJO1goK3wG4LjIuKtgDp2kfO9GjIlE1yRJetbw4kHWpe/?=
 =?us-ascii?Q?zFz20f4JOIKlIp0jlhRK5TGlVq8q5yG1ln04/RK6pCpX1xTc5TffZMqw9jyy?=
 =?us-ascii?Q?W9q9bNCks/8zg/FI6G7WfVFxspFpj578BXbBq90RaPK8qJGci6rFNBtNA0jP?=
 =?us-ascii?Q?+CFi3o5w0rWPUpFmLbAhMpcWPh295J5cZ661kFvi6v9XrHZq6CsCSET3JoRz?=
 =?us-ascii?Q?sNwT6QN7LIAn5CZhsWQ7nWPZUTSm2Tt0gEQ013gLmHqJfzWFza92WRt+4prx?=
 =?us-ascii?Q?C9SBJ9vXNXgx9jsS7ckDz6xIwJq4vMi/vhBwjCRKTYblh1pjIiilt57LQBNi?=
 =?us-ascii?Q?2a0RdAlY8oMmnLBEwqNnDS9f7ZH9J49w3tf25tuAqm8f+tlxHkPYEc1UwN3g?=
 =?us-ascii?Q?EuClfyzYWRIpS9s7jZ5VkW14Xd1XfdbhWDCH2yHlgbgV28OxuRw37S8ZHI0s?=
 =?us-ascii?Q?pFjqRIcp6xosZIx9cYVuf3jns/h23H31SWY4E9xaJBwmTAwZo9p1MFfTTGok?=
 =?us-ascii?Q?IBvn54PXzfvzuN2zaE8BMfCh8eAIekmTw7TkAKb4daIgkRhay4ehAGzZv6fG?=
 =?us-ascii?Q?+f/dCsck1bZXJ0ZIQ3evWbz3DEe7vUunJY89zjUOFab9awPZXtjsR2f6VQy3?=
 =?us-ascii?Q?k/CGXMeVHRLDz8iBOKlkbxtbV4ppV0YkVG1aLlndlwNlCF4BWu/8i+LrHJsS?=
 =?us-ascii?Q?OZZvnd3GW+jJfpWRQIgq0f+T18QiDO3eho/PR2ksL/60HY1ucaAO56C1cjj4?=
 =?us-ascii?Q?DL//fdSqojVFkBRo9GueWtauCTxODtcn/dwf8q7TYrQE0Xg66A7UX1zT08ce?=
 =?us-ascii?Q?kMFzG1uZ2K6xAUDLn8JwRYThMxEzoIELBZnd5w8B+F3azVJnyuPEm0/ri68i?=
 =?us-ascii?Q?IVV8/XZrhipJvDa5vwJiMr34BUGh1ruRaq+PKvhVhkqMNRVw3C7Qm012qTm6?=
 =?us-ascii?Q?2vaold63PM+2QjvOriCCVX0EPgF10ks8GjNNKT8ebpxMAfTrGPboso/TXxQo?=
 =?us-ascii?Q?SJ7q+kCrpPsGKcr0FbnyIChOJ1LBMMYAVhmyGmuEz2PrCxzW6jicYdHcuXTC?=
 =?us-ascii?Q?W0YV84RBr5hf0j4ylXKk3RkaaT9i3FkqKvLxWKKY/ZLkeqPyMLazWUKJbISX?=
 =?us-ascii?Q?D8CPubxRwnPmXmrTmS241b0OrxmErV0hJaY3MmwnyYyOCIJa7VAWpKCnarhZ?=
 =?us-ascii?Q?7tbGN9lP7FecskfpxhRJDnk89DQis/LQC7R+KB3uAL2Mtsqrj/YGj5v+J/UT?=
 =?us-ascii?Q?HU+E0yuiNBgqnu+M0o9iX1GRI37jNlUHfKWTYAMsXvpmx3mso60ldgkTksBz?=
 =?us-ascii?Q?7Yg1IFuYcckkADxllKCQl92BqyjoY39Wu54telS2DiVyHsrfzNS66cJst4sD?=
 =?us-ascii?Q?HZs0mtS4sb48RUFK9h29pacIZu8VxfE4d9Ts3+nZDincEgOcn360z3BehAgA?=
 =?us-ascii?Q?DnN6MsNex4T0Bfm23gtieUN1MLxMkhs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6241dd6-5f4f-4eb0-8864-08df449def25
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:42.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvFQe/kyGi39HBEHQiKk9vnrkPkerhTFfFDfP/RWFhAc0gcKofqbkMJ30cJUZDqUysGpud+ydYRNvddkhfME0zMOr7z4XPokslS70s4+RXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24825
Content-Type: text/plain; charset="utf-8"

Whether a partition boots an A/B root (abrootfs) or a dm-verity root is
decided per image by ROOTFS_CONTAINER_TYPE, but the wic layout repeated
that decision in the wks sourceparams abrootfs_root=3Dy and verity_root=3Dy=
.
Two switches for the same thing can disagree, and wic .inc files cannot
be parametrized as wic does not expand BitBake variables there.

Export RO_ROOTFS_TYPE and ROOTFS_CONTAINER_TYPE to wic via WICVARS and
select the root mode from them: the "verity" container emits a verity
root, no container uses abrootfs. Remove the
sourceparams from ebg-sysparts.inc and ebg-signed-sysparts.inc.

Empty variables are not exported to wic, so an empty container is seen as
unset. RO_ROOTFS_TYPE is never empty and tells the plugin that the image
exports the root settings, as opposed to an out-of-tree wks file of an
image that does not.

This also fixes images without secure boot and a verity container, which
used to get an abrootfs cmdline although the initramfs has no abrootfs
hook in that case. The signed layout now follows ROOTFS_CONTAINER_TYPE as
well instead of always selecting verity.

The sourceparams verity_root=3Dy and abrootfs_root=3Dy are only used as
fallback for out-of-tree wks files of images that do not export the root
settings.

With the root mode following the container, dm-verity can be used without
secure boot too, by adding kas/opt/verity.yml or selecting it in the kas
menu.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                                       | 12 +++++++++
 classes-recipe/read-only-rootfs.bbclass       |  2 ++
 doc/README.secureboot.md                      | 12 +++++++++
 doc/README.swupdate.md                        |  2 +-
 kas/opt/verity.yml                            | 16 +++++++++++
 .../wic/plugins/source/efibootguard-boot.py   | 27 +++++++++++++++++--
 wic/ebg-signed-sysparts.inc                   |  4 +--
 wic/ebg-sysparts.inc                          |  4 +--
 8 files changed, 72 insertions(+), 7 deletions(-)
 create mode 100644 kas/opt/verity.yml

diff --git a/Kconfig b/Kconfig
index 163813b9..929373d9 100644
--- a/Kconfig
+++ b/Kconfig
@@ -338,6 +338,18 @@ config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
 	depends on HAS_SECURE_BOOT
=20
+config IMAGE_ROOTFS_CONTAINER_VERITY
+	bool "Protect the read-only rootfs with dm-verity"
+	depends on !IMAGE_SECURE_BOOT
+	help
+	  Wrap the read-only rootfs in a dm-verity container. Without secure
+	  boot, dm-verity detects corruption of the rootfs, but the root hash is
+	  not authenticated. Secure boot always enables dm-verity.
+
+config KAS_INCLUDE_ROOTFS_CONTAINER_VERITY
+	string
+	default "kas/opt/verity.yml" if IMAGE_ROOTFS_CONTAINER_VERITY
+
 config KAS_INCLUDE_SWUPDATE_SECBOOT
 	string
 	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 1c35d8c6..0bf808d2 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -14,6 +14,8 @@ IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
=20
 do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
=20
+WICVARS +=3D "RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE"
+
 WIC_HOME_PARTITION =3D ""
 WIC_HOME_PARTITION:separate-home-part =3D "part /home --source rootfs --ch=
ange-directory=3Dhome --fstype=3Dext4 --label home --align 1024  --size 1G =
--fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0=
f-58904f369524"
=20
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 1b908483..256e8fae 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -17,6 +17,18 @@ select the root file system generates a uuid and stores =
the id in /etc/os-releas
 During boot the initramfs compares its own uuid with the uuid stored in /e=
tc/os-release of each rootfs.
 If a match is found the rootfs is used for the boot.
=20
+### Root file system protection
+
+The read-only root file system is described by two stacked settings:
+`RO_ROOTFS_TYPE` selects the filesystem (`squashfs` or `erofs`) and
+`ROOTFS_CONTAINER_TYPE` the container around it. With secure boot the
+container defaults to `verity`, so the root file system is protected with
+dm-verity and its root hash is part of the signed unified kernel image.
+
+dm-verity can also be used without secure boot, by adding `kas/opt/verity.=
yml`
+or setting `ROOTFS_CONTAINER_TYPE =3D "verity"`. As the root hash is not s=
igned
+then, verity only detects accidental corruption and the build warns about =
it.
+
 ## Adaptation for Images
=20
 ### WIC
diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index c1428a7a..ee73c000 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -409,7 +409,7 @@ The image is built with the RT kernel just so that ther=
e are some differences be
=20
 **Note**: Only `rdiff` supports delta kernel binary update using `rdiff_fi=
le` handler.
=20
-Creating an delta update file for rdiff_image (rootfs) and rdiff_file (ker=
nel)  handlers requires a reference artifacts (against which the delta is c=
omputed). In this case, the image and kernel built in the previous section =
can be used as the reference artifacts. By default the `DELTA_UPDATE_TYPE` =
is set to `rdiff`, `DELTA_RDIFF_REF_IMAGE` is set to the name `${IMAGE_FULL=
NAME}.squashfs` (or ${IMAGE_FULLNAME}.verity in the case of Secure boot ena=
bled image) and `DELTA_RDIFF_REF_KERNEL_IMAGE` is set to the name `linux.ef=
i`. The values of `DELTA_UPDATE_TYPE`, `DELTA_RDIFF_REF_IMAGE` and `DELTA_R=
DIFF_REF_KERNEL_IMAGE` can be changed in the `delta-update.yml` file.
+Creating an delta update file for rdiff_image (rootfs) and rdiff_file (ker=
nel)  handlers requires a reference artifacts (against which the delta is c=
omputed). In this case, the image and kernel built in the previous section =
can be used as the reference artifacts. By default the `DELTA_UPDATE_TYPE` =
is set to `rdiff`, `DELTA_RDIFF_REF_IMAGE` is set to the name `${IMAGE_FULL=
NAME}.squashfs` (or ${IMAGE_FULLNAME}.verity if `ROOTFS_CONTAINER_TYPE` is =
`verity`, as for Secure boot enabled images) and `DELTA_RDIFF_REF_KERNEL_IM=
AGE` is set to the name `linux.efi`. The values of `DELTA_UPDATE_TYPE`, `DE=
LTA_RDIFF_REF_IMAGE` and `DELTA_RDIFF_REF_KERNEL_IMAGE` can be changed in t=
he `delta-update.yml` file.
=20
 The build system looks for the reference artifact in a directory named `pr=
evious-image` in the build directory used for the build process.
=20
diff --git a/kas/opt/verity.yml b/kas/opt/verity.yml
new file mode 100644
index 00000000..7fa9b142
--- /dev/null
+++ b/kas/opt/verity.yml
@@ -0,0 +1,16 @@
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
+header:
+  version: 23
+
+local_conf_header:
+  verity: |
+    ROOTFS_CONTAINER_TYPE =3D "verity"
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index ca97d7d7..da695e9d 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -36,6 +36,7 @@ import logging
=20
 msger =3D logging.getLogger('wic')
=20
+from wic import WicError
 from wic.pluginbase import SourcePlugin
 from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
=20
@@ -89,11 +90,12 @@ class EfibootguardBootPlugin(SourcePlugin):
         boot_files =3D source_params.get("files", "").split(' ')
         unified_kernel =3D source_params.get("unified-kernel") or 'y'
         cmdline =3D bootloader.append or ''
+        root_mode =3D cls._resolve_root_mode(source_params)
         # the verity cmdline format is identical to systemd.verity_root_op=
tions
-        if source_params.get("verity_root") =3D=3D 'y':
+        if root_mode =3D=3D "verity":
             cmdline +=3D " cip.verity_root_options=3Dpanic-on-corruption,%=
s" \
                 % cls._get_verity_opts()
-        if source_params.get("abrootfs_root") =3D=3D 'y':
+        elif root_mode =3D=3D "abrootfs":
             cmdline +=3D " cip.abrootfs_root_options=3D%s" \
                 % cls._get_abrootfs_opts()
         if unified_kernel =3D=3D 'y':
@@ -152,6 +154,27 @@ class EfibootguardBootPlugin(SourcePlugin):
         cls._create_img(part_rootfs_dir, part, cr_workdir,
                         native_sysroot, oe_builddir)
=20
+    @classmethod
+    def _resolve_root_mode(cls, source_params):
+        """
+        Return the root selection: 'verity', 'abrootfs' or None.
+        The mode is derived from ROOTFS_CONTAINER_TYPE: "verity" selects a
+        verity root, no container an A/B root. RO_ROOTFS_TYPE is never emp=
ty
+        and tells whether the image exports the root settings. Otherwise
+        fall back to the sourceparams verity_root and abrootfs_root of
+        out-of-tree wks files.
+        """
+        if get_bitbake_var("RO_ROOTFS_TYPE"):
+            # Empty variables are not exported to wic
+            if get_bitbake_var("ROOTFS_CONTAINER_TYPE") =3D=3D "verity":
+                return "verity"
+            return "abrootfs"
+        if source_params.get("verity_root") =3D=3D 'y':
+            return "verity"
+        if source_params.get("abrootfs_root") =3D=3D 'y':
+            return "abrootfs"
+        return None
+
     @classmethod
     def _generate_kernel_opts_from_file(cls, filename, keys):
         env_file =3D None
diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
index 8210598d..01f6c486 100644
--- a/wic/ebg-signed-sysparts.inc
+++ b/wic/ebg-signed-sysparts.inc
@@ -7,5 +7,5 @@
 part --source efibootguard-efi  --size 16M --label efi   --align 1024 --pa=
rt-type=3DEF00 --active --sourceparams "signwith=3D/usr/bin/sign_secure_ima=
ge.sh" --fsuuid 0x4321dcba --uuid d1360f76-b09a-4bcc-b923-8195088cbe02
=20
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D2,signwith=3D/usr/bin/sign=
_secure_image.sh,verity_root=3Dy" --fsuuid 0x4321dcbb --uuid f870258b-706f-=
4a66-8d58-b5a75ce61b8b
-part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D1,signwith=3D/usr/bin/sign=
_secure_image.sh,verity_root=3Dy" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-=
403f-8637-b111e4482ee9
+part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D2,signwith=3D/usr/bin/sign=
_secure_image.sh" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75c=
e61b8b
+part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D1,signwith=3D/usr/bin/sign=
_secure_image.sh" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4=
482ee9
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index b7f1afa6..199c89a5 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -7,5 +7,5 @@
 part --source efibootguard-efi  --fixed-size 16M --label efi   --align 102=
4 --part-type=3DEF00 --active --fsuuid 0x4321dcba --uuid c19e7e9f-bacf-49a6=
-b43d-2fc18d2a8d03
=20
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D2,abrootfs_root=3Dy" --fsu=
uid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
-part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D1,abrootfs_root=3Dy" --fsu=
uid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
+part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D2" --fsuuid 0x4321dcbb --u=
uid e8567692-2dfa-459a-be15-f6e5ddcc8f49
+part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D1" --fsuuid 0x4321dcbc --u=
uid 94b2174d-c792-4e8e-8a34-b506e2927937
--=20
2.47.3


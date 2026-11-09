Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2703.1794216692079045545
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 01:31:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Es4BnPKl;
 spf=pass (domain: siemens.com, ip: 52.101.72.33, mailfrom: clara.kowalsky@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buAmY4ai0MaSBo/kdSgntIPQ+JxWfU6nnPpOmXJbYfnxZDLwH7jS7FQaDrrURsgjeGruLfuWZyySHacZRrLCa9S/w74JoW0HEZawP0WJpjrlgnSOijHHBJo5htqQS4TAnF2NsR+Mtv2qHInVVPh9LwaCNpxpoiRuaQUE/lCL3zHvhzoCmpabBNBiybGJiCwiA/iY8L3ITaXT9tdM9TPZpVESFf9If6h73+v8re9mCvI2yGCj3/1284XAnXHNjHdScs6GHFpowU54KxM16PmZawNJld20aNQvlo9aa7tOBOUkNHp3A0uNq9iFfHw3oYKllEpjg4rOnZQFFnzh+UuocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yypfY7dEpmr4jVbghcnddvrU4LRa+GZBgEQWaTe/2TU=;
 b=yp7Ki34xaocx2ZQ4e7s1DbHptaqKXJIuvDMqEIJiNj0Z252Ws25sulIE2DAHgwspqufv5YJLXj3JLohIA/InPMU++cmrIdrXrh7qxyk5zPPJ+6JPucCwJAT6Cw/mnN1SlSWKow7y7sda5ELdX84HcffZCMXBbHfgmfxgkOu3l5SyrJki9izm+of6eaULRYFFWpzmpNeb5rd824/tAa0AtO7/9ltT7WyVZhthU1JTPS6/E2jIuwjq1AhsGBwUvZqbZXDomue2s7kvZ0TG1xuYntpVF5f2Qgvwv2l9F1HACehPvBe/tWZNqB10F2kecVQdbjJm+0pQ5rSI8crV6UVHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yypfY7dEpmr4jVbghcnddvrU4LRa+GZBgEQWaTe/2TU=;
 b=Es4BnPKlEW9GNmeG1GMdVYDsLVPQXAxI+XhD0jVFG7j9ccCoEhoNSPHwo7tI3/ySp16FY5vW2eEBmJ85jB5foYdN8cOF441tehDmtfd4ttWCTCTw8UUd6v4MZvqCqcE9bSAb5OI1ifKQ7o/RqQwnxU+veeX8Ui63IcF/+8DqwmhNLLlOMsAQXOfhV7VjRpj9xbZoSrZY6OuT1NUR0PCFAcYh0WbBRab0ywJ92HrAhVUSZFXScsJcArxSA5thcVABkZxctjJshJcKHBRJ/RcrLqO5Kj55mREjLBYVlThL0d+OLIfOXRopWBPVhsXFZS7/3Rze9LDDp6/9bputfUs9Lg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by AM8PR10MB3986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Mon, 9 Nov 2026
 09:31:27 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%6]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 09:31:27 +0000
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] Add missing whitespace around assignment operators
Date: Mon,  9 Nov 2026 10:31:09 +0100
Message-ID: <20261109093109.224917-1-clara.kowalsky@siemens.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Return-Path: clara.kowalsky@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|AM8PR10MB3986:EE_
X-MS-Office365-Filtering-Correlation-Id: 246f49d9-6022-4c18-f5db-08df3e443af1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261022115727099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|10067099003|55112099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: xEuO78ffbUwLx7wiqd5RenA/gmuaKX5hBgp2AlgjWpO7cwdvbyFTpL+LDuerJEm81BRtzw1GNzsEDGYatk2xv0SiEKOMooxw+yhmEuycO3bS6GQYAHhdTuaYF8pZSeEH8iY11lSJpwmWjv48MEis8mc272Cvt0Ux2RnDFtpKU1p3z4dvSn6+CBGt4C86v6QdU1mmrRDKItTfkJaIamSCljPSIlu2ij/2wdSTEY0B7FaERd654VaQ2CCmHYmxp8QH+U4BNnNS0krwXh43rP5sgfJRu8Xehwa/ppJHzE08MUdooNbZ1BScRSDj/7on+MXJQfiADLoJ4nOw31h+GgUHnMTd35xZSWMMuJvoBmYJX11DS+VL+lw5nhr+RO7Tzb3jtozsBdRI3aGRQgnQxIJp10B9L3OzvEOTiib8m/WQoWW/wR7DbEPvN1PZUQ23Wyp953Cp6qzJl34vK+cfhEQa09/0innzNulpWAy2dolY4a+3PNGR36s09R+wcB5lOf8HBpvh0dwwv6l+tXJg+zIylvwrSyd8OhNfq5qW2bnWkZly9kwszhZTAxsJ8h6xfwET0q0pjpvY2dcYYWs6eCAX69W41wU+F5Vva6yZBDraUBwgPkc0ue/NLBJCgF0dsZQ03VtD/dZL5fRCbwhrOTj2fvW8qxiKl3T/a9xhRMOuGQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261022115727099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+mf3tfi03KmbARsy0q07llCothqWtVkxUm/RAB4JS2UWZYogWxON8+miWygH?=
 =?us-ascii?Q?FZVh9fXARL5JiFWSG8XKil/OWW1F0EAh652ETrcX8p2O/M/OhRJCjIvbazrV?=
 =?us-ascii?Q?NT6zHbNdHqvN/ochR4+4dUDXt3/Ni0siB8wc0FoaeDI3b2dXkev/IJumZjo1?=
 =?us-ascii?Q?De4OO0TcxdqaMza+G7pKAhsrnh5ZUs8gmVs3tOyOEQOtL++Pvw2DDxOS2Ah3?=
 =?us-ascii?Q?91J5xW6lZmk5HTRfPlOpBupJqq9P3Nwm/OGZyBMriPisG3pkUBiMVg4GgTnu?=
 =?us-ascii?Q?9lIzDK5J4djekP1WMbKGIKmxP0oXsxHv6MpxuYPFcjz6PnEURx8JumSNnk2I?=
 =?us-ascii?Q?vx0FTebdl2C0GsCmDybChXJ9I+yED8Zwiknh7dEWv2YYxmc4w1KfCvUzwCdP?=
 =?us-ascii?Q?8ErE3w9kHz5ugTwZlvnJ+cXh3LnughXoaltYE3JwF+1lnymA7pVCcNgutJMG?=
 =?us-ascii?Q?Yha2U8E+jPZiIJLcImBE3eIN1quGKymhBpmM8ma2z80VHZZKE5TEIVkIGbz8?=
 =?us-ascii?Q?ZUe1QjNoEPf4WOev4Hwkxi8uhAS1c4byFIJdi7nmvsWQ3P1IgyKuGq/J0/IQ?=
 =?us-ascii?Q?Zq6F+T8T+MnFcA6SdcRuAkSbSxurGjYtmUt96OcRCN2lOitFCGUNLIVkTsC/?=
 =?us-ascii?Q?btNPsOIiNw0Lo2oOs4OefSbexlTXITz80Y3QIQgQDqAxRxvlyYjwfLLcgI/H?=
 =?us-ascii?Q?LD+wCOf0B+AochZ/llq5w9cJmKPpLiHo3qJcVkWO50fAoQ7oT/ALMC27CqdS?=
 =?us-ascii?Q?UKC8XsV2u+2DuyskyLGu02pxtTi4gM+ow+u5NzFnq7G1Rb6JkTjbFCc1Fc1f?=
 =?us-ascii?Q?6z8ID/zZlf56jCkstTtpIBMryBz1S5sy4NNWB21qORaDCCkh/Afs3Ux4XqZc?=
 =?us-ascii?Q?x9LCcNB4ZSL76xKbo6WHZ4fd03Vfgi8HzUH/d+ylyLVe3xspY/4+fpOGYUuC?=
 =?us-ascii?Q?DkUbEldJqjq5GET6nLbs/UZdrwMy0VRRtGh53AkZNUwhK0ourhfem4fVnfEd?=
 =?us-ascii?Q?8AKKJ1HF5tK2QraNA14y2kvwPLGVSYIndWchvhNlTffJccLGORN29BJG9MAn?=
 =?us-ascii?Q?jQW3w1TJc5LcZfCxgOQ7lLC/rGKU8zSRe6X/U/5JAY17oaZVbHwpmZu5Lolj?=
 =?us-ascii?Q?kNGLUVsPQoUDaHg7/PAl00iwvdXmQ1TCdl5FSQ+Bca5VktFPZ9ooe1hCgcxV?=
 =?us-ascii?Q?AeotorMNXlPQXOiyXhMPJ+OS7rTaAdvyuAvg7nTuSMKiAlOvbyW+W+TOiQgn?=
 =?us-ascii?Q?R3ke325afZBMAtHH+Kk0xeeo1TXGP82JhZpBUdvY8m4sWkpvg9a4dyPcB+zP?=
 =?us-ascii?Q?MAslqidfnZWDBHhFMkh84YuN63R6jrkRxqLPv4xB4VvXopqVwusrPF85hHNz?=
 =?us-ascii?Q?d2o962F5jW5y22Pd3+MY2oQepLui5AmADhtjeprG1ewlGILGgSGrhkQdJ6UY?=
 =?us-ascii?Q?EDv6ChLa9ESGCOVqZ+8hJf5HHSKot9qLevrNbzisNg99os0FnT4sVqOQTtGa?=
 =?us-ascii?Q?uZ5nf6FADa5PEjwv6Cx1/ox7x+jbI0R+QGv6uIFhTg0Uc9kAm5f+aF9veXmN?=
 =?us-ascii?Q?usg4zMwVu7QAZ7HfAWD/XiwTsGAslajHsy+X8Y4VzznQe2rWpov6TvqQP2Pt?=
 =?us-ascii?Q?LIU+f8CyDmRkcoh21KKsMtNXsQgkRqh8wwpjN5i2fbuBqaETTVBR7yZFFAkL?=
 =?us-ascii?Q?Op/MoYktV/skD7qdqu/bqkXlJJfxoip3vN09Sux0NH9X7YCnfyepJGyDxeNE?=
 =?us-ascii?Q?6jTMZWRXrquQvX0YYg+XM85uUqthOyc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246f49d9-6022-4c18-f5db-08df3e443af1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:31:27.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/+UDAa+cxNkq2fhdJsR6tpX8+pE+xR5qiQqXJy0lxomDhRIv2SB99X3IIvXaRhWiqxTJEIcQ/iRaE/lszebjDqmKtTyJUgUSeDk/nVMW4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3986
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 09:31:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24691
Content-Type: text/plain; charset="utf-8"

In preparation for an update of BitBake in Isar, add missing spaces
around variable assignment operators. BitBake commit 24772dd2ae6c
("parse/ConfHandler: Add warning for deprecated whitespace usage"),
included in v2.15, emits warnings if the spaces are missing.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass                     | 6 +++---
 kas/opt/ebg-swu.yml                                         | 2 +-
 recipes-core/home-fs/home-fs_0.1.bb                         | 2 +-
 recipes-core/swupdate/swupdate.inc                          | 2 +-
 recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb      | 2 +-
 recipes-devtools/dosfstools/dosfstools_latest.bb            | 2 +-
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb    | 2 +-
 recipes-python/shtab/python-shtab_1.5.5-4.bb                | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 1690ecb..1c35d8c 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -36,9 +36,9 @@ IMAGE_INSTALL:remove:bullseye =3D " immutable-rootfs"
 IMAGE_INSTALL:remove:buster =3D " journald-config"
 IMAGE_INSTALL:remove:bullsye =3D " journald-config"
=20
-ROOTFS_POSTPROCESS_COMMAND:append =3D" copy_dpkg_state"
-ROOTFS_POSTPROCESS_COMMAND:remove:buster =3D" copy_dpkg_state"
-ROOTFS_POSTPROCESS_COMMAND:remove:bullseye =3D" copy_dpkg_state"
+ROOTFS_POSTPROCESS_COMMAND:append =3D " copy_dpkg_state"
+ROOTFS_POSTPROCESS_COMMAND:remove:buster =3D " copy_dpkg_state"
+ROOTFS_POSTPROCESS_COMMAND:remove:bullseye =3D " copy_dpkg_state"
=20
 IMMUTABLE_DATA_DIR ??=3D "/usr/share/immutable-data"
=20
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 486d30f..bf54079 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -34,4 +34,4 @@ local_conf_header:
     IMAGE_FSTYPES:remove:qemu-amd64 =3D "ext4"
     IMAGE_FSTYPES:remove:qemu-arm64 =3D "ext4"
     IMAGE_FSTYPES:remove:qemu-arm =3D "ext4"
-    IMAGE_FSTYPES:remove:qemu-riscv64=3D "ext4"
+    IMAGE_FSTYPES:remove:qemu-riscv64 =3D "ext4"
diff --git a/recipes-core/home-fs/home-fs_0.1.bb b/recipes-core/home-fs/hom=
e-fs_0.1.bb
index c99c32a..dd81716 100644
--- a/recipes-core/home-fs/home-fs_0.1.bb
+++ b/recipes-core/home-fs/home-fs_0.1.bb
@@ -16,7 +16,7 @@ DESCRIPTION =3D "Systemd unit to mount a dedicated /home =
filesystem"
 SRC_URI =3D "file://postinst \
            file://home.mount"
=20
-do_install[cleandirs]+=3D"${D}/lib/systemd/system"
+do_install[cleandirs] +=3D "${D}/lib/systemd/system"
 do_install() {
     install -m 0644 ${WORKDIR}/home.mount ${D}/lib/systemd/system/home.mou=
nt
=20
diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swu=
pdate.inc
index e11f0d5..f04939a 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -11,7 +11,7 @@
 DESCRIPTION =3D "swupdate utility for software updates"
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
=20
-HOMEPAGE=3D "https://github.com/sbabic/swupdate"
+HOMEPAGE =3D "https://github.com/sbabic/swupdate"
 LICENSE =3D "GPL-2.0"
 LIC_FILES_CHKSUM =3D "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=
=3D751419260aa954499f7abaabaa882bbe"
=20
diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recip=
es-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index 035887e..6405a42 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -18,7 +18,7 @@ DEB_BUILD_OPTIONS +=3D "nodoc"
 FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files/2021.11:"
=20
 SRC_URI =3D "git://salsa.debian.org/debian/swupdate.git;protocol=3Dhttps;b=
ranch=3Ddebian/master"
-SRCREV =3D"344548c816b555c58ec199f31e45703897d23fb5"
+SRCREV =3D "344548c816b555c58ec199f31e45703897d23fb5"
=20
 # add options to DEB_BUILD_PROFILES
 SRC_URI +=3D "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rule=
s.patch \
diff --git a/recipes-devtools/dosfstools/dosfstools_latest.bb b/recipes-dev=
tools/dosfstools/dosfstools_latest.bb
index d0ac128..3ec79f6 100644
--- a/recipes-devtools/dosfstools/dosfstools_latest.bb
+++ b/recipes-devtools/dosfstools/dosfstools_latest.bb
@@ -13,7 +13,7 @@ inherit dpkg
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
=20
-CHANGELOG_V=3D"<orig-version>+cip"
+CHANGELOG_V =3D "<orig-version>+cip"
=20
 SRC_URI =3D "apt://${BPN}"
 SRC_URI +=3D "file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=
=3Dno"
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hoo=
k_0.4.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_=
0.4.bb
index e201277..e47b483 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.b=
b
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.b=
b
@@ -58,7 +58,7 @@ DEBIAN_DEPENDS .=3D ", awk, coreutils, util-linux, e2fspr=
ogs"
 HOOK_ADD_MODULES =3D "overlay"
 HOOK_COPY_EXECS =3D "mountpoint awk e2fsck mke2fs"
=20
-SCRIPT_PREREQ=3D"crypt"
+SCRIPT_PREREQ =3D "crypt"
=20
 do_install:append() {
     install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
diff --git a/recipes-python/shtab/python-shtab_1.5.5-4.bb b/recipes-python/=
shtab/python-shtab_1.5.5-4.bb
index 03e0aed..8d096a4 100644
--- a/recipes-python/shtab/python-shtab_1.5.5-4.bb
+++ b/recipes-python/shtab/python-shtab_1.5.5-4.bb
@@ -23,7 +23,7 @@ SRC_URI +=3D " \
 SRC_URI:append:buster =3D " \
     file://0001-Lower-requirements-on-setuptools.patch"
=20
-SRCREV =3D"8db4615b2c3ee0a9332b6030687e1179fcfc8670"
+SRCREV =3D "8db4615b2c3ee0a9332b6030687e1179fcfc8670"
=20
 # We don't have pristine-tar in this tree hence use this option
 GBP_EXTRA_OPTIONS =3D "--git-no-pristine-tar"
--=20
2.56.0


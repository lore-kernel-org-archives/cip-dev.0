Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11290.1795689093383602819
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:31:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=GjyqCPQL;
 spf=pass (domain: siemens.com, ip: 52.101.83.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJWmuSuV+cDqCZfY4419fru04D+wFv+euv+NWtruqizVFRVclM+jYIF3oDwCzN8iSCVd7fS+4F8BYsbfjE+N0Oy//UILn/B4ECQzmbvooiP2ojmGvreqgfehgHyNy3e3TUX1lCKyNoRyyfI2cU7EA8b58+81/iw94RHkiWU1/Saw/Gxrd8l4OWbj40HzFC1Vwj2lQU8udO98hQdUp/l1X7PcLBvcX6bhPGUomQGUKEn0XsasftrKNmRnq9whnEyROJ0O7h7VElE4ijhsIWAuUv9aayolZSpOcnQQQuXtIaF3nPeN9bY0AoK+GbyMjKxlGUvjzE1oz32Szrkh4IyAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlCYwTL3UkvDv2Zrm0leQgX2KTJ7J0kFtKj5bHvjO4k=;
 b=GMnkOmt/QKuNRr2epnVUAfV4NSRwem6h0Y5Mao9Te2P4M3FSiLW/4b8VZEq/8D5Lq82mLHXm7rS1N9SsQPDjnJr9/tgyZYLTHNtqdnmn8RX8KOE6cMyjxRvBz713KufkBf5rP3mFxrPo5tNjUPV+jp8v33b3C/bL6WnzS9WyZDdsC5dwKzcmJs/L6P40nbRSrOVHy+ZSzODpwWKo0naxJuTNCpjKZ4KaQaOeTPdJinLk2kUMgcb6HeLJPjMSSL8vjaOiR7WFWNOI6pVWgXTIqVHnvj3hhrJgLNlPofkbst1X+CXIqd6PkEGiNgG3NNB0vc62IZRkqZJ/kavc6Zi8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlCYwTL3UkvDv2Zrm0leQgX2KTJ7J0kFtKj5bHvjO4k=;
 b=GjyqCPQLsAZMtUD5WLcxYUmcUgcIsqOiLbR1Qt2feZBBdOnOHRElrF4TTPA8wP2wDWIakMiR4Y1/1aiKlBdN7y5WzWiwUbXph2MugVcA7fpwQeWvxdB3+cX6VGEi/MnPJpF1btSe5deF3f1sIpL+aP8Ci1oHAJW5NTvER7i/7ybc9wPSlB39vzw9I5r6yE+nd96H9e+fGH9xkvt4svisp2Hpu0sVsa9vTJcVgS7nunuR1sdQW3BqGOAAOod8jphdOMSo3VhPynZJgGSdbJnHfv13qVCiIP7q/0fQbxPIQ3BgxclgL7wvK5exD4HGzodETagzqnhzOx+piP8kbTq4Zg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU4PR10MB9591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:61a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Thu, 26 Nov
 2026 10:31:30 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:31:30 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 20/21] verity: make the reaction to corruption configurable
Date: Thu, 26 Nov 2026 11:30:06 +0100
Message-ID: <20261126103007.2922985-21-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
References: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU4PR10MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df076c4-764b-448b-b55c-08df4ba86f46
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|55112099003|3023799007|11063799006|261022115727099003|261022075727099003|56012099006|261102123227099003|261021135927099003|261021121427099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 0aiIDed7hIghsqGEob5pIgsrwTFC+D+/NdCwr1bfOVON3c8dchWqVAbt7gDEWoFvKM6YGBbxEmZzjkIEa5jUm9/6CearvFFomnYzN7AUy3OqkvqVL5anNUIZ5WKtDse0pQ4SWwd9FNtF4u3GA1vFgItKa7pC12BSxeYSdSHsxAdU50m4unGC4n51RNJbZNshr9yBlAFxZA5ZFYah7w0WpswzrzL159Chfxq5XlD0QPDlU5aqJdeyjsue87gS/VWLedRTbI3+4vvQrL6z1pp0D6x+KXYI4LdaE2aOFOBc1nT6/yKioUMBtrEmWgI5Q6ymPkDMqw/kVnuJR7+kmNQL+TMuXlUuzgwhl5T8xrqpdS6+52030QIceIRed9gDBMTLtYmfYSyAyRuCEfdTPCBF/k8V3UXMPkN/ARbI9ZSxwVWPRcnJ16nLkUs+9gUQc3InN0PGl27oGoLwtOCdvVG0Rxw4dYsB1BeJiq37XJzwaSE/zFlowQKj7vMmr+Oz4ymGwZai1lWUd91N8euc8g7qwieQc3oGjli5rvABWDB/1pmcHCh4oas20ILT8DtLpDpAeMvJEDo9U9t8ZBkB4mRTVOdrtOdi0KJqEFpRNNFeeFJUsE/+K7bt0gUG1OoPu6xeg8m0p43Qxhzwfla/aP4e4bWg2XXbNwWjm4zxyUVrUBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(55112099003)(3023799007)(11063799006)(261022115727099003)(261022075727099003)(56012099006)(261102123227099003)(261021135927099003)(261021121427099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?duyGvGzgCHzBq/87S8NWm/ebWKFQO9jhwZw1SCoNgyUDTV8nQ/KUe1OkIaNl?=
 =?us-ascii?Q?LLILgs/ZAZ/QvJnISnJynvBGRSHk9+3U6QBL8nrTe7nNQBRKB7H2cQHXGHi7?=
 =?us-ascii?Q?0QFNbFaSxx6i7vmZvWZvMJZ+rw3oURMuHdaXb1hn6P4Q1KAyReCpNoWHvHtV?=
 =?us-ascii?Q?joLA24CWrIClVS3W+EWo8vHfFCPICZS2k4Bcm2JUBGNKiXjspS8jG1/JtPYJ?=
 =?us-ascii?Q?mHZqUyRSs7+wfedwPKUJNo6VdGBqncKa4vap+Ge8a8CdN+zWduquCUQebJ7W?=
 =?us-ascii?Q?OLGsTIV3EzpQJM+P3EUrMhQeDPkdQqer6oNdpvYqC0304MLG/aSZHA7peQ0L?=
 =?us-ascii?Q?HXm+02lXTu2ARJGx3e7n7qrc8Z2CNFqETXahzi2P63Gql8ZRGIb6J4TKt1Fa?=
 =?us-ascii?Q?P2PUq7Oc4IroLOqspTwATl+Z7pwOvhHJ72uEq5qJT0Yts+2W4YXZOu/H6hC/?=
 =?us-ascii?Q?6v/wQaMmcl0Y66PPRy8gdndSvjDG+XrDf3Xk3uGvPiLBBjzNGKsAC75dQ/Sx?=
 =?us-ascii?Q?gpZy+qm1zwnm9PBqMQYqqle5yMKI3hpZAKyytL5uCkC2ZwrJtDXvMohHMsJx?=
 =?us-ascii?Q?5k5yB+kcIu8lz6Ccm9DDYfyfvhIxplOkEJDk8Jq4MOzLOu07qI1xKBNNqUMR?=
 =?us-ascii?Q?9MdqwHRm7xf/sAPpuxHw3dT8l3u0tqRtMf3E+aCqmpQv+nKfvGNyACZtIPsS?=
 =?us-ascii?Q?wodDAmbLNJ3HTg8Qok50n9eGJX8HxvE7hnogjltEcyGcL2dy8bjOTx3DTiUO?=
 =?us-ascii?Q?cJtKdJw6sE9RKoNFqd2rgqtCbSYL8qdk9cMgZj2GMML3AlYNcrhfb+HJKaNz?=
 =?us-ascii?Q?G0ErvodwhETtbALFsvU5Ob4gQACRis+81rFmMKA/uOZE/outAwCGf7b5Gb4A?=
 =?us-ascii?Q?1lQc5nkc0IdBlfYzXHmhMm5ZpEdHFMx5u3QeEyS6hNzwbBmIECJdXQ7R314H?=
 =?us-ascii?Q?J0LApztvnAyk5ZdQJ1MirBcw0XViVN/Z4E76KmPhuDyZBIekc9OS2Ardyhzx?=
 =?us-ascii?Q?vHHRGHLuWSdGcvipYo9wmFaqUFwZNCYZ5NK7Bo04CTewTxWcmr9yFVPNcUbz?=
 =?us-ascii?Q?uWbk5dRDUqvm0mXBkOCR1zn27QEfkrPXl2/n7+DhmshmnfVdZTGuOkbzGWi+?=
 =?us-ascii?Q?ryX0T34HCH/NtlIy1uQ0rxkSU0mhS143i8rTbECXkqBedpmv2Gun4iHaYYhZ?=
 =?us-ascii?Q?xzp1coGQkvdAxunH3194UiP0zlpxQtnHXUOkpx5EFQWfNNAiehY5s5woeP+Z?=
 =?us-ascii?Q?Fb2m2HEjt0hxfnO3VKf/1hHUDzurcMJrP/Wz21WrAm6WM3UYHW4Bs39AwWiw?=
 =?us-ascii?Q?O3UcE3Mmlay7HvHHUp+YGeln3BoJEA9//U5diOA08gM/EK5z277FaCD6a0IK?=
 =?us-ascii?Q?QKxhA2orfucEnDzh7t5XcsJzJqCRRZgJ5e+r1nIBA279R+g5P924gO1pc459?=
 =?us-ascii?Q?pfAMZMR/n/n/4Ev5RmVVh7tAFt9riqxw7WERmEgN+NI+kAbay8JhyhtH7q5s?=
 =?us-ascii?Q?n2SNoondhI/JxPz739XJRYIl+8B12mzAe9+sq2b7dAnPJ98zB3XzfP72lob1?=
 =?us-ascii?Q?x5izKvcKP8kXPEOqKTPDyEqQ4jD8+uwW23rIyQyHFAE42PwEu5k6/l+65GGB?=
 =?us-ascii?Q?ovNoLORDsy/qraeZsNIVn4kP5jta5xlK22jzRjG8ahyt2UQG1MYIvqGY8Pja?=
 =?us-ascii?Q?ejaAi3+I3zvWIxOcaSUA1UDjGfdjew0u/4iU6D++wuaP/p5zBOmFcchpcnuG?=
 =?us-ascii?Q?Sfl0D6iDVyyS+fxafyyHKCVw2pVZJLE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df076c4-764b-448b-b55c-08df4ba86f46
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:31:30.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h34EAVCGzDIDaDjGOpkL2D+Rb8qEwiJWTzR3jYEuz8epyFSUk60SpFCBExE96CbjjtLreX6pcANlhTrUYizIMCAptJaZURax6bakWTQeg9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:31:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25102
Content-Type: text/plain; charset="utf-8"

Add VERITY_ON_CORRUPTION (ignore, restart, panic). It sets the
veritysetup option of the initramfs-tools hook and, with dracut,
systemd.verity_root_options on the kernel command line generated by
the efibootguard-boot wic plugin.

The command line previously always asked for panic-on-corruption, but
the initramfs-tools hook ignores cip.verity_root_options and always ran
veritysetup with --restart-on-corruption. The default "restart" keeps
that behaviour for initramfs-tools; dracut defaults to "panic". On the
initramfs-tools path the value in cip.verity_root_options is
informational only.

A panic only reboots with panic=3D on the kernel command line, which the
efibootguard wks files set independently of this variable.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass       |  6 ++++-
 conf/distro/cip-core-common.inc               |  6 +++++
 doc/README.dracut.md                          |  3 ++-
 doc/README.secureboot.md                      | 14 +++++++++++
 .../initramfs-verity-hook_0.3.bb              |  3 ++-
 .../wic/plugins/source/efibootguard-boot.py   | 25 ++++++++++++-------
 6 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index d8c9fec3..d7ce0dda 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -17,7 +17,7 @@ do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
 # Kernel command line arguments that keep the dracut initrd from stopping =
in an
 # emergency shell. Set it to an empty string to emit none of them.
 INITRD_EMERGENCY_CMDLINE ?=3D "rd.shell=3D0 rd.emergency=3Dreboot"
-WICVARS +=3D "RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE IMAGE_FULLNAME INITRD_C=
MDLINE_STYLE INITRD_EMERGENCY_CMDLINE DRACUT_VERITY_DEVICE_LINK"
+WICVARS +=3D "VERITY_ON_CORRUPTION RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE IM=
AGE_FULLNAME INITRD_CMDLINE_STYLE INITRD_EMERGENCY_CMDLINE DRACUT_VERITY_DE=
VICE_LINK"
=20
 python () {
     if d.getVar('RO_ROOTFS_TYPE') =3D=3D 'verity':
@@ -28,6 +28,10 @@ python () {
     if container not in ('', 'verity'):
         bb.fatal("Unsupported ROOTFS_CONTAINER_TYPE '%s', supported are "
                  "'' (none) and 'verity'." % container)
+    if d.getVar('VERITY_ON_CORRUPTION') not in ('ignore', 'restart', 'pani=
c'):
+        bb.fatal("Unsupported VERITY_ON_CORRUPTION '%s', supported are "
+                 "'ignore', 'restart' and 'panic'."
+                 % d.getVar('VERITY_ON_CORRUPTION'))
     if d.getVar('VERITY_IMAGE_TYPE'):
         bb.fatal("VERITY_IMAGE_TYPE is removed, use ROOTFS_CONTAINER_TYPE =
=3D "
                  "\"verity\" instead.")
diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.=
inc
index a9ff9b89..d0872aa6 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -51,6 +51,12 @@ DRACUT_VERITY_DEVICE_LINK ?=3D "dracut-embedded-verity"
 # to the A/B partitions and packed into the swu.
 RO_ROOTFS_TYPE ?=3D "squashfs"
 ROOTFS_CONTAINER_TYPE ?=3D ""
+# Reaction of dm-verity to a corrupted block of the rootfs: "ignore", "res=
tart"
+# (reboot) or "panic" (kernel panic, which reboots only with panic=3DN on =
the
+# kernel command line; the efibootguard wks files set panic=3D5).
+VERITY_ON_CORRUPTION_DEFAULT =3D "restart"
+VERITY_ON_CORRUPTION_DEFAULT:dracut =3D "panic"
+VERITY_ON_CORRUPTION ?=3D "${VERITY_ON_CORRUPTION_DEFAULT}"
 ROOTFS_CONTAINER_TYPE:dracut ?=3D "verity"
 ROOTFS_CONTAINER_TYPE:secureboot ?=3D "verity"
 # Derived from the two settings above, do not set it.
diff --git a/doc/README.dracut.md b/doc/README.dracut.md
index c1f87d73..b3ed88dc 100644
--- a/doc/README.dracut.md
+++ b/doc/README.dracut.md
@@ -14,7 +14,8 @@ How the pieces fit together:
    `INITRAMFS_RECIPE =3D "cip-core-initramfs-dracut"`, adds the `dracut`
    override and includes `kas/opt/ebg-swu.yml`.
 2. **Distro defaults with `:dracut`.** `ROOTFS_CONTAINER_TYPE =3D "verity"=
`,
-   `INITRD_CMDLINE_STYLE =3D "systemd"`,
+   `INITRD_CMDLINE_STYLE =3D "systemd"`, `VERITY_ON_CORRUPTION` defaulting=
 to
+   `"panic"` (see [README.secureboot.md](README.secureboot.md)),
    `factory-reset-helper-efi` as the factory reset provider, and no `/var`
    entry in fstab (`FSTAB_VAR_ENTRY`).
 3. **Checks.** `read-only-rootfs.bbclass` fails the build for dracut witho=
ut
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 4e494901..10763c98 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -29,6 +29,20 @@ dm-verity can also be used without secure boot, by addin=
g `kas/opt/verity.yml`
 or setting `ROOTFS_CONTAINER_TYPE =3D "verity"`. As the root hash is not s=
igned
 then, verity only detects accidental corruption and the build warns about =
it.
=20
+`VERITY_ON_CORRUPTION` selects how dm-verity reacts to a corrupted block:
+`restart` (reboot, default), `panic` (kernel panic, default with the dracu=
t
+initramfs) or `ignore` (log only, no protection). A plain
+`VERITY_ON_CORRUPTION =3D "..."` assignment in `local.conf` or a kas file
+overrides the default. The initramfs-tools hook still honors
+`VERITY_BEHAVIOR_ON_CORRUPTION` if it is set explicitly.
+
+A panic reboots the system, and allows rollback, only if the kernel comman=
d
+line contains `panic=3DN`. This setting is independent of
+`VERITY_ON_CORRUPTION`: the efibootguard wks files of this layer set `pani=
c=3D5`
+in `bootloader --append`.
+
+**Note:** Out-of-tree wks files must set `panic=3DN` as well.
+
 ## Adaptation for Images
=20
 ### WIC
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_=
0.3.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.=
bb
index e67ae7c2..478ab35d 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
@@ -19,7 +19,8 @@ SRC_URI +=3D " \
     file://local-top-complete.tmpl \
     "
=20
-VERITY_BEHAVIOR_ON_CORRUPTION ?=3D "--restart-on-corruption"
+# veritysetup option, derived from VERITY_ON_CORRUPTION
+VERITY_BEHAVIOR_ON_CORRUPTION ?=3D "--${@'ignore-corruption' if d.getVar('=
VERITY_ON_CORRUPTION') =3D=3D 'ignore' else d.getVar('VERITY_ON_CORRUPTION'=
) + '-on-corruption'}"
=20
 TEMPLATE_FILES +=3D "local-top-complete.tmpl"
 TEMPLATE_VARS +=3D "VERITY_BEHAVIOR_ON_CORRUPTION"
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index e87b8610..33ca8db8 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -30,7 +30,6 @@
 # Christian Storm <christian.storm (at] siemens.com>
=20
 import os
-import re
 import sys
 import logging
=20
@@ -97,12 +96,9 @@ class EfibootguardBootPlugin(SourcePlugin):
             if cmdline_style =3D=3D "systemd":
                 cmdline +=3D cls._get_verity_cmdline_dracut()
             else:
-                cmdline +=3D " cip.verity_root_options=3Dpanic-on-corrupti=
on,%s" \
-                    % cls._get_verity_opts()
-            # panic-on-corruption needs a reboot afterwards, otherwise the
-            # system hangs instead of rolling back to the other rootfs.
-            if not re.search(r'(^|\s)panic=3D', cmdline):
-                cmdline +=3D " panic=3D5"
+                cmdline +=3D " cip.verity_root_options=3D%s,%s" \
+                    % (cls._get_verity_corruption_opt(),
+                       cls._get_verity_opts())
         elif root_mode =3D=3D "abrootfs":
             cmdline +=3D " cip.abrootfs_root_options=3D%s" \
                 % cls._get_abrootfs_opts()
@@ -226,6 +222,16 @@ class EfibootguardBootPlugin(SourcePlugin):
                 opts[sd_key] =3D v
         return {k: v for k, v in opts.items() if k in keys}
=20
+    @classmethod
+    def _get_verity_corruption_opt(cls):
+        """systemd/kernel dm-verity option for VERITY_ON_CORRUPTION."""
+        behavior =3D get_bitbake_var("VERITY_ON_CORRUPTION") or "restart"
+        if behavior =3D=3D "ignore":
+            return "ignore-corruption"
+        if behavior in ("restart", "panic"):
+            return "%s-on-corruption" % behavior
+        raise WicError("Unsupported VERITY_ON_CORRUPTION '%s'" % behavior)
+
     @classmethod
     def _get_verity_opts(cls):
         verity_sd_keys =3D ["data-block-size", "hash-block-size", "data-bl=
ocks",
@@ -263,11 +269,12 @@ class EfibootguardBootPlugin(SourcePlugin):
         emergency =3D get_bitbake_var("INITRD_EMERGENCY_CMDLINE") or ""
         verity_link =3D cls._required_var("DRACUT_VERITY_DEVICE_LINK")
         return (" roothash=3D%s"
-                " systemd.verity_root_options=3Dpanic-on-corruption,%s"
+                " systemd.verity_root_options=3D%s,%s"
                 " systemd.verity_root_data=3D/dev/%s"
                 " systemd.verity_root_hash=3D/dev/%s"
                 " root=3D/dev/mapper/root rootfstype=3D%s ro%s"
-                % (root_hash, ",".join(rest), verity_link, verity_link,
+                % (root_hash, cls._get_verity_corruption_opt(), ",".join(r=
est),
+                   verity_link, verity_link,
                    rootfstype, " " + emergency if emergency else ""))
=20
     @classmethod
--=20
2.47.3


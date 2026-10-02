Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E2CA5FD4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:20:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9457.1790940002646661841
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:20:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=DZPEnZLr;
 spf=pass (domain: siemens.com, ip: 52.101.84.53, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg0smnovQxtdp7PJag2IIbflaFe8e48O+Gfg5yXzPcM8/niqyGBPR8u4Cetl5CbvqBTnPibLr+qkgPuQBLGn1xX5pV/3sXSGNAzzwC0Rqkrm23Yhr/19KsvmQEC402nu2usZWv8PRTmhEx4Z73o4EZSO2lI239OTHTXhkCB4+2pksQSTpURbxFMxy3ZUBS1PJH5zCluiDFP/gBf0Ub7LG0QjYX/crIhK7xJzKBpdxOdOGHCQRrrg9nBgruHMXVLyJlRHbBkK8jxvlrkLQThydHiulQRTg96Q5hyblf16aZ/Z2FxvhZaf5ZccOVkb6ehsx7dCO1ksWFB6zeFNO8yXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB2qNJpuqOtwmEA6f6G3AviMDibBe4rwuyjFXGVOFcA=;
 b=Of38HZ0I6uCgqex/k3hkeiZdLk5TSlJWYCK0cvXWXe0lg/g1l+qAiQ0j3qLGbrqtQq4vXjpdhPb4kWIiuUtOb8M7x2wRIRvTcsXzod7b+gLK9pzP3DBBvag7fZDz3QOzk4RZgn9z2H8kvJGbl1htPJxrH1YG51GYPZhbdWpaufiLmnpdCFw1xJrIIYYXk6szi2Au+eemQeCBzPGbScxO5mhoA77HCBxbhHfzdaFLtv3xeNiR0v4wLXjTC1rsysfM3t45IwwcUPSiTjNqp3AKMsEbaazkSg4hPTKuvrzWwzXVj11BX+iWHvelwwctdtyst7NX7DK1YJp4lC3WRztBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB2qNJpuqOtwmEA6f6G3AviMDibBe4rwuyjFXGVOFcA=;
 b=DZPEnZLr8w41Xnhjhw6L3YhIFJ+8hs9KWHWAl9wf/n7KSgBOc1xGeWeY8ElNujk/OqUAHvmHkNX9aXYQ0k9sQ1qKbqEa//YJnqGUeGbRMGlCI8IIDUVsmjhR1YIzQ3sIjQWDCrNprG368oUUwM6K9srbjEoQzoaQfxKnaO3iO83oVq/k7CzN0bPUJ9dYfa5QhLIY1mgOVLHLb4GhCkoSzDIU7DtsrahCT793iDR3xXoMYlBf3ldZndkVWfr75vgPLEw1nWX2DAsRsAfZYM8PXuEFUWSwVFWd7WbVUQFW1L/8qN4CqdCYkffIHeHmctevZwHWFTnh0Y0pZzwn8raDaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:56 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:55 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 11/11] doc: document dracut initramfs
Date: Fri,  2 Oct 2026 13:18:58 +0200
Message-ID: <20261002111938.3600786-12-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: b67af6f5-fed5-437b-0cf3-08df207714b9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|3023799007|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	2OZVyS/XNbSBIrB5dmP+Ji/jBkH3fn7QEZXVTT4jmR6ZmAb1sF+1ZLyjChztLC3sNGcAjLUVb0ASgg0ItK6nVilBAS1w4cVO2imeYiT0rwikNaIVCNUifJqYeIk00jNVWQZUKfIyV/tHOMhvZ9oGJZxcBR4KAaDuLvRnBdd5P3z2Fon/yOAtSwU8JOdOA3ehcYSqXBxq4Ga4lIcPQpt0VdsQzBXd5vzEX5bIzJq1lIzSYzToJL9/0kE7D89/FaA3jufLqsboPHbPItAvOd5buYCUkvUefiZ9Y6+D8UY0x+XwJWBtCxkMh8/V3UIU1SXCLvF2Di3aFd10LB1pBQjkE8EnER34Wj1v9J1BfCr4und+NRomnBlyCMrtI3+hovfppEtgeIaGt+kRTaxmC1gL4ntq6idlqj6cgTPaAkGtHPXjI/cppagELV+qmLJh3d+UjUp8QH2JEgHEG/GB9AwpzmodbjsyNizdjNZaV3wxbt50YxqZjH/X+ZlmbDGNS8IHwaAcwEl311xvaXlHMSfZA37yhwZVdF9EdC3FQwNkh+jeOUODBPiHoV0FU51YxJiwtAZdmpMWLlIZfAhidaHsCLPFehyVRKY+cN7zi2A/Tyda1HQrbf+ifgss5sEu39XAxg8Q/fTor+14pV0W3OrP/nqG63tRDO9D2Ll3jMyq5PA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iHJdiwV9qLEOQJ//kcvLDyjJPKLNPJLKx/EwKtGzNwvQ0Jkfyu7++dzk9YkZ?=
 =?us-ascii?Q?D43cyl8L/6F878gbwjwBpcmSQXjNqU6YAx3d6CGXoC/S35I7NdkbJm8Enpp1?=
 =?us-ascii?Q?VYYbkLQPXZ7Rwm76C5pshPU+9SPh6aTGMT9Y/+Cywn+dmFqvy0x6naZd1FRF?=
 =?us-ascii?Q?Ce6N4xzrbQYEbD1DRVzuLqaZUfsgjZxPihVV0IN06zEFzG9S9R+sPpprFH1+?=
 =?us-ascii?Q?G6Fv1fzcbIqEJyY2p4dyiWoUx8vk3xYi57bqDCi8Zxzf2uuTpKF6x9V7LwE1?=
 =?us-ascii?Q?ACZB8s0v5wwm4WcNaE1x73RTkpeRy/SqeU01hLIovIGjGwsy75qqtCmndJ1/?=
 =?us-ascii?Q?cnSdUNhfvnnoru0b8jst2a7g21FkxOJUdNq+S9knfqYKgMZV2+Mnr2cHKqxc?=
 =?us-ascii?Q?49ahJct/JV2zCIeyNj/YQxCHtGSAtXKAZSgHb/PHEU2HNXu4mrh10adWFwfm?=
 =?us-ascii?Q?/V7rVcUg+WKQp20lRTFuymZSX0n0IN7vtu9bZyPkCYdnDwT1s6mXhDEiJMvv?=
 =?us-ascii?Q?YVogjSBN24nRMWqn1dAJTk45UAmA268EyrGrTm+4GyRFBm0kDdt4Vga+xhBG?=
 =?us-ascii?Q?2ZdEaRvo+AJlIbMtqBOUE2cfByJJkwBpJoXNH4IvLK7/X2Ulrf+gtdmUOrpR?=
 =?us-ascii?Q?qPp70Jgd9iXzhx+Rj1WeL4cX/URleyQ3zEuIVL7ujeraqHPnlx37Kh1d2UZh?=
 =?us-ascii?Q?xEPllOUlX0bKZ1sOQ8ZC97DuQANdREu3mMM5R5qLOH2WgMWkN3NKHkWynYjg?=
 =?us-ascii?Q?0D/5JFVvQsYD9XjKZghXlp8aw6ls8qEIdY6arSNC/TjjjMdAiOphfetkMLfr?=
 =?us-ascii?Q?W9h69XU/wOCHPr6xsR2c13M1FL3g4jlLw3xnZYfLaVK1Ql4Tux+5GDbDrOwh?=
 =?us-ascii?Q?Rvv+bUt3dCUTWpr5g5fU18KaBy15AnOGnVIfO7TrFIwddJQ4rqrUOxATt7M/?=
 =?us-ascii?Q?xX5SJ+QHgY16QWS5EzpWaYnrJO+9KhRr0OjzKMVXur2pRMNaHHOi1pQiV4IY?=
 =?us-ascii?Q?JDm6vKu7AHeg2om0llbrLA8a4ajohAcnOjrnBKYj6UnhymeINDPqPsOsCyFr?=
 =?us-ascii?Q?ukJBc2JJeT4cKm74IZm/BvgPLXB8FENLutCLY6AFLHYki+cFyuJBHpsigaoo?=
 =?us-ascii?Q?6KT44w350hboAHHYS1/OXt++7B5rv7wWNEMABnaWBrfQkPCW3aKn7xU0dWJa?=
 =?us-ascii?Q?9H5hWMtN/SASP60kmSQMHs2nOU59hd8se+/Ge/rIHxeMnoHynIhpwoIC7hA1?=
 =?us-ascii?Q?OQRcsMJYNy6Embe36P5RrsVSOmgEG22cLzEdh/YR58SUKwARoCzx6JBDxp+k?=
 =?us-ascii?Q?LDOMOGfNYldKPc6GcgEhCSFsIDNt4w41Y18nna2tqvvPDP1S5f1HwqZ7lDFC?=
 =?us-ascii?Q?bkB4/6g2cD38y/5pFB6FlBSrT5AZauru9ie/4g06hXNXA3H3CgR4o/qdSBF3?=
 =?us-ascii?Q?dINb8PGLz0mSbp/Xtm3prfi9GOTGbsLclfzp3JNXswFxznnfh7hr9T/bCnIB?=
 =?us-ascii?Q?PvZ7V8S6BQSvH8IvthSy5RedixX9sr2MYovSGPoh1hFGGMIqpmshAHRJgFA3?=
 =?us-ascii?Q?HSp+JZUNw8ZrlIDn1RmS7jrvWCgCClc5vkPgio2zi9DFgb2gXVD7oNbHGw5x?=
 =?us-ascii?Q?Yi8CanvK3lsFqo/LR9u5XgLm2CCEOtmPu6dP0LubkDU7lOMkn5w1xje0i3kL?=
 =?us-ascii?Q?sJ8PpPwVZazJlveJgGOi4IojYPPOJC7e6XcNacYnW0tL4y/TTYX7ZRuNnKyc?=
 =?us-ascii?Q?sZpo8B2wi+ywI4nqeR3ovC/PvqLr8PI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67af6f5-fed5-437b-0cf3-08df207714b9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:53.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCrp506GcKUd/OOfOuKFhPQ2QmU8QRFFKBPp1kW7SbyuWhQDiFb7CKJUuXr7wTkX8oMf1Dul5SPqRiknBCd2agwQlVcwNuT62R3DCM8xpPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:20:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24414

Describe the dracut initramfs, its modules and configuration packages,
and the dracut-specific behaviour of factory reset and secure boot.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.dracut.md        | 95 +++++++++++++++++++++++++++++++++++++
 doc/README.factory-reset.md | 46 ++++++++++++++++++
 doc/README.secureboot.md    |  4 ++
 3 files changed, 145 insertions(+)
 create mode 100644 doc/README.dracut.md

diff --git a/doc/README.dracut.md b/doc/README.dracut.md
new file mode 100644
index 00000000..f4d3866b
--- /dev/null
+++ b/doc/README.dracut.md
@@ -0,0 +1,95 @@
+# dracut-generated initramfs
+
+isar-cip-core can generate dracut based initramfs images instead of using =
initramfs-tools.
+This prepares for Debian 14, which switches the initramfs generator from
+initramfs-tools to dracut. It is currently supported on trixie only;
+`cip-core-initramfs-dracut` is skipped on other distributions.
+
+## Build
+
+Add `kas/opt/dracut.yml` to the kas chain, for example:
+
+```bash
+./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/securit=
y.yml:kas/opt/dracut.yml
+```
+
+The fragment sets `INITRAMFS_RECIPE =3D "cip-core-initramfs-dracut"`. The =
distro
+configuration derives `RO_ROOTFS_VERITY =3D "1"` and
+`INITRD_CMDLINE_STYLE =3D "systemd"` from it, so setting `INITRAMFS_RECIPE=
` in
+`local.conf` is sufficient. The latter makes the efibootguard-boot wic
+plugin emit systemd's native verity arguments instead of
+`cip.verity_root_options=3D`: `roothash=3D`, `systemd.verity_root_options=
=3D`,
+`systemd.verity_root_data=3D` and `systemd.verity_root_hash=3D` (both poin=
ting at
+`/dev/cip/verity-data`), plus `root=3D/dev/mapper/root`, `rootfstype=3D` a=
nd `ro`.
+
+## What is in the initrd
+
+The dracut modules are maintained in a separate repository,
+[embedded-dracut-modules](https://code.siemens.com/linux-expert-center/emb=
edded-dracut-modules),
+and built by the `cip-dracut-modules` recipe. Their configuration is shipp=
ed
+separately by `dracut-config-cip-*` packages built in this layer.
+
+| dracut module | Module package | Configuration package | Replaces |
+|---|---|---|---|
+| `cip-verity` | `dracut-cip-verity` | `dracut-config-cip-verity` | `initr=
amfs-verity-hook` |
+| `cip-overlay` | `dracut-cip-overlay` | `dracut-config-cip-overlay` | `in=
itramfs-overlay-hook` |
+| `cip-crypt` | `dracut-cip-crypt` | `dracut-config-cip-crypt` | `initramf=
s-crypt-hook` (systemd backend only) |
+| `cip-factory-reset` | `dracut-cip-factory-reset` | `dracut-config-cip-fa=
ctory-reset` | `initramfs-factory-reset-hook` (EFI variable only) |
+| `cip-watchdog` | `dracut-cip-watchdog` | `dracut-config-cip-watchdog` | =
watchdog handling of the crypt and factory-reset hooks |
+
+`cip-core-initramfs-dracut` installs only the configuration packages; each
+pulls in its module package. Overlay and watchdog are always installed; th=
e watchdog is only serviced
+if `INITRAMFS_WATCHDOG_DEVICE` is set. Verity is added
+with the OVERRIDE `swupdate`, crypt with `encrypt-partitions` and
+factory-reset with `factory-reset` (`kas/opt/factory-reset.yml`). The drac=
ut
+modules are enabled via `DRACUT_EXTRA_MODULES`.
+
+## Configuration
+
+The configuration variables (`INITRAMFS_OVERLAY_*`, `CRYPT_*`,
+`INITRAMFS_FACTORY_RESET_*`, `DRACUT_VERITY_DEVICE_TIMEOUT`, ...) are unch=
anged.
+The `dracut-config-cip-*` packages write them to `/etc/dracut-cip/`, where=
 they
+override the module defaults. `dracut-config-cip-crypt` also generates a
+crypttab from `CRYPT_PARTITIONS`, ships it as `/usr/share/dracut-cip/crypt=
tab`
+and installs it to `/etc/crypttab` in its postinst.
+
+`INITRAMFS_OVERLAY_RECOVERY_SCRIPT` is optional; if empty, the module's
+default recovery script is used.
+
+The initramfs is built with `--no-hostonly`, which `cip-crypt` requires.
+
+`cip-verity` does not open the verity device itself. It ships a udev rule =
that
+runs `cip-verity-match` against every filesystem partition and publishes t=
he one
+whose dm-verity header UUID matches the identity on the kernel command lin=
e as
+`/dev/cip/verity-data`. systemd's own `systemd-veritysetup-generator` then=
 opens
+it as `/dev/mapper/root`.
+
+`cip-overlay` is a `pre-pivot` hook that mounts the persistent storage dev=
ice
+under the real root and stacks a writable overlay over each path in
+`INITRAMFS_OVERLAY_PATHS`.
+
+## Encrypted partitions and `:expand`
+
+`cip-crypt` provisions TPM2-sealed LUKS2 partitions on first boot and leav=
es
+unlocking to systemd's native `systemd-cryptsetup-generator` (build-time
+`/etc/crypttab`). With `kas/opt/expand-on-first-boot.yml`, the last
+`CRYPT_PARTITIONS` entry gets `:expand`: on every boot the pre-mount hook
+grows that partition with `growpart`, and after mounting, `systemd-growfs`
+grows the LUKS2 payload and the filesystem. This is a no-op if the disk is
+already fully used. Only the last partition on the disk is grown. If the
+entry is not last, the module logs a warning and boots normally.
+
+## Limitations
+
+- **Verity is required.** A/B slot selection falls out of roothash matchin=
g;
+  there is no dracut port of `initramfs-abrootfs-hook` and there will not =
be
+  one. A swupdate image without secure boot has no dracut migration target=
.
+- **UKI systems only.** The non-unified-kernel efibootguard path
+  (`unified-kernel=3Dn`) is not supported and not tested against dracut.
+- Not ported: the squashfs and erofs hooks, the TEE/fTPM integration, the
+  file-marker factory reset (`factory-reset-helper-file`), and for crypt t=
he
+  clevis backend and `CRYPT_BTRFS_SUPPORT`.
+- One generator per image. Isar's `initramfs.bbclass` rejects an image tha=
t
+  mixes generators - with dracut selected, any package whose name contains
+  `initramfs` is an error - so there is no hybrid migration step.
+- qemu-amd64 only so far. Other machines follow in later increments.
diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
index 4b1a1ab9..f1a0930e 100644
--- a/doc/README.factory-reset.md
+++ b/doc/README.factory-reset.md
@@ -5,6 +5,8 @@ To enable the factory-reset functionality the following two=
 elements need to be
 ```
 INITRAMFS_INSTALL +=3D "initramfs-factory-reset-hook"
 ```
+  With dracut (`kas/opt/dracut.yml`), the module is `dracut-cip-factory-re=
set`
+  instead. It is installed via `kas/opt/factory-reset.yml`, see [dracut](#=
dracut).
 - factory-reset-helper which provides the helper scripts to set the factor=
y-reset marker
 ```
 IMAGE_INSTALL +=3D "factory-reset-helper"
@@ -28,6 +30,50 @@ As the factory-reset is executed before the disks are un=
locked in the initramfs,
 variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of =
encrypted partition is not supported with the file based
 marker.
=20
+## dracut
+
+With `kas/opt/dracut.yml`, `dracut-cip-factory-reset` replaces
+`initramfs-factory-reset-hook` and is installed automatically with
+`kas/opt/factory-reset.yml`.
+
+- **Trigger:** only systemd's EFI variable
+  `FactoryReset-8cf2644b-4b0b-428f-9387-6d876050dc67`. With dracut,
+  `set-factory-reset.sh` writes this variable. EFI variables are required.=
 A
+  build with `factory-reset-helper-file` fails.
+- **Flow:** a systemd generator pulls in `factory-reset.target` only if
+  the variable exists. The variable is deleted before anything is wiped. A
+  failing or timed-out reset (`INITRAMFS_FACTORY_RESET_TIMEOUT`) reboots
+  (`FailureAction=3Dreboot-force`) into a normal boot.
+- **Plain partitions:** zeroed, `wipefs`, and re-created with the previous
+  filesystem type and label.
+- **Encrypted partitions** (`encrypt-partitions`): the LUKS keyslots are
+  erased first (`cryptsetup erase`); the unlocked mapping keeps working
+  because the kernel holds the volume key. Then the mapping is zeroed, so =
an
+  interrupted reset cannot leave a partition that still unlocks with partl=
y
+  old data. Then the mapping is closed, the signature is removed, and on t=
rixie the TPM is cleared (`tpm2_clear`,
+  disable with `INITRAMFS_FACTORY_RESET_CLEAR_TPM =3D "0"`).
+  `dracut-cip-crypt` then creates a new LUKS2 container with a new volume
+  key and TPM2 token, and a new filesystem.
+- **Filesystem type:** encrypted partitions get their filesystem from
+  `dracut-cip-crypt` (`CRYPT_CREATE_FILE_SYSTEM_CMD`).
+  `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE` is only the fallback type for
+  unencrypted devices without a detectable filesystem.
+- **Unlock failed:** an encrypted partition that could not be unlocked is =
not
+  zeroed. Its LUKS keyslots are erased and the TPM is cleared, so the data=
 is
+  unrecoverable (same as `initramfs-factory-reset-hook`).
+- **All TPM2-sealed partitions:** clearing the TPM makes every TPM2-sealed
+  partition impossible to unlock, including `CRYPT_PARTITIONS` entries not=
 listed in
+  `INITRAMFS_FACTORY_RESET_DEVICES`. List all of them.
+- **Power loss:** a power loss during the reset (after the variable was
+  deleted) leaves partially wiped partitions. The next boot does not repea=
t
+  the reset.
+- **Watchdog:** if `INITRAMFS_WATCHDOG_DEVICE` is set, the module configur=
es
+  systemd's hardware watchdog (`WatchdogDevice=3D`/`RuntimeWatchdogSec=3D`=
) for
+  the initrd on every boot, not only during a reset.
+- **Forky:** TPM clearing will move to `systemd-tpm2-clear.service`. Until
+  then, `INITRAMFS_FACTORY_RESET_CLEAR_TPM` is ignored there, and the buil=
d
+  shows a warning.
+
 ## Verification
=20
 - Create a test file in a target partition (ex: `/var`)
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 65f3ec07..0b4fc653 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -179,6 +179,10 @@ local_conf_header:
 Replace `demo` with the name of the user-generated certificates. The user-=
generated certificates
 need to stored in the folder `recipes-devtools/secure-boot-secrets/files`.
=20
+The example above builds the initramfs with initramfs-tools. The initrd ca=
n
+alternatively be generated with dracut, which replaces `initramfs-verity-h=
ook`
+by the dracut module `cip-verity`, see [README.dracut.md](README.dracut.md=
).
+
 Build the image with user-generated keys by executing the command:
=20
 ```bash
--=20
2.55.0



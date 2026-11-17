Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15713.1794915001116929499
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:30:03 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=xoifcW4p;
 spf=pass (domain: siemens.com, ip: 52.101.83.8, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqSQG9bJf4T6KN1dpRKJiz7zbVfRXQ2oXmbOmV7ETrMJAhfCMMvpBrHtHkrO/lj6ckndAvHHkhrzmlHgfqkj2mMSGFPvc3Q/LZSnAipEhgyc63sy8rpcx7UToVgR912Z0dXHK3eKvhagUEwtFID7qjV2UQy982iu8scB/ZPojkyjA+GUPpZsdRVbbvnBoZjtSB+VOFl3uVCpHmeHw81na+qfR5+BDj0scouAw2l4JZ6IYRdEgftFSkfqnYDIH1aFKs7wwjL58F6aM4c3XRyuk83MZ19OUDNp2qH9YizVG+LsVeijlxcrmQ/j3ynD43rYrAZKQKpex4ZqADXTwymTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZkgNouJipD2IQmaCvteLJ0lJ4/JIXxFRke8+fQd1c0=;
 b=TjtAf3LC/eTm0PNOiqZSa+/3mD03wRfLKuAH1DId5EI+JfbD+EOSXIHKVLrkPjTuvOuuXPtFrvktX3cJod/kuElkGDnHbNoC8ofqksQ4VFMvx0RG5Rvn70+AV0+1cKczTWjQMq8y+hgVD9bgKiM6wWWk4R1B6dEsf9XJpMElOdz7xJhm9l8pwTN+qE0oEbKr1vmKowp+ap4sl2BDN6CeSuaqAYHhugU6+MWuduNgjT8thBnOubplu4VQ4kZyobUzAbV5cWJqzqrOCSz9rjKC1oZWrxUKpOF7N0hZRhcPhzpNkN/uc1JZhswMal+6wvVWu6Q6tIFpjMH/afd4RdbTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZkgNouJipD2IQmaCvteLJ0lJ4/JIXxFRke8+fQd1c0=;
 b=xoifcW4pLmQEGZ/8bBTPcKXH6poBp9B68zHzSQ7gcstnxUxtklie5phB1IyTC26Gg3CslyoSDUjkC+6lKsgR6Mv6rfsplO5zqcKV7BnbY3gfpsacD1bMSxDulUlsxoHpS5J9OHQpddASRfx2qOB/0+Ir6ScCPIK8lqpSgjO1VSHn8I7txyu4TRLTeLXjxfnhh4ehpznV9W2QO55VhpVLIkXilzJeHldUWfY7/6vSeSp7fsGw2y/uma/Cc5cucHahsRJ5ld0LtrM17XiwKm/gNHmKdNezaxa+sTmR6XvmHTuIdnmg64NW5xs/dF2H40v3sIZv3hskGvjYWEWj5Q01sQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS2PR10MB6615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 11:29:58 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:29:58 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 19/19] doc: document dracut initramfs
Date: Tue, 17 Nov 2026 12:28:33 +0100
Message-ID: <20261117112833.316234-20-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS2PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: d287db84-fb69-4422-a079-08df449e1b60
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261026121527099003|261022115727099003|261021123027099003|261022105027099003|261021121427099003|261022113327099003|261022075727099003|261102123227099003|261009220027099003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|55112099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 59rEefCsG7fJbX06MDfYFmLss+rzG/HpQR53aCrpcFEPKinUFJR7IPfnEdBrVkGpW017vhQdTHohM+LUZo2uVKZRefyAtnIZ11Rk7+VT3tozDYEX/+zcNEpPpMdsnlL/PI3Za3irx+iLApk9s7Cgey63GNBCZyIdeAaQfEUDbh+PSv7FvtpuQkrfNNDpsYuHP6n8PphMiBfPRk2c+XdPOdxLyem1Qu1Si+7wm8+GryBrYwFj2M/JHRTPLCORWM1EDQyHhLnsxLfGZ1Sdl55idfyZOoMYyAbf9vmFARZ+k75xQVbf/ggDwOF9b9E4zQb7MJutKLDx77pKVl/RcjQ2XK9HC+ZEzPw5719EU8ThxxLWZceVRWrMl8JY4oinL66RVx6ipQINlXwSb3/er6KfL2OPMsi957P4ejGrXto/hMRNDcpmoFFG85lQkp04voHQbN+lYJlViV3zsnJ6C+DMvSzoV20R/GZgbjFVJL7apA9YH+q2vb8a+XBEbleaZsfi6jpmeA+KYJxgl2LKvWamFSpwAtLxyUP57EsSgoeo6o6phAFC+GRAoB+Lluxg1v0GZLKx3nhVa3XftTO7zxuXEAk7bgwnYbzq5ibb/7+v10U78szj4vLws+8M1nYkVBbU2lOtAJV4NYKJ+jQxIIoywohVWjYeE1FfQRUAlPHoow8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022115727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022113327099003)(261022075727099003)(261102123227099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(55112099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GNjIZdoH2bW6yg4qxyM+TDwEXVRJBpGNH6Du707qrM2Jd7rW+hAHV/r2Uki8?=
 =?us-ascii?Q?ZShaxrnNrPfQeXTDedYpcSm9N0rPE9DPtbhLSboBsOhb0BCLv9frwnCByh9Z?=
 =?us-ascii?Q?v8K5nt6lsqXeN6im0BUF5sSNcf0YWvAbnZlC+2g5oxj20TmkvKAHAddA4VwL?=
 =?us-ascii?Q?YcRPYimPWOSeixV0m7aNGBCni+JUwvwa/h+5jUK3zhj9fYCGYdUFpCvx8JKy?=
 =?us-ascii?Q?VG1Kf7IroQFokPSTaaZgqKhKBGxeTr/qKayY/UaidCe4cDy3swMnNbE4t1RJ?=
 =?us-ascii?Q?5gnq6leIcBKmQWCDSucavC5VaRU+bK/gfTQhBVieDU9FJY16Q9yZWl+7lW3c?=
 =?us-ascii?Q?b4+ktQfF8GVErfXMrWvp299psjwGVqNCf5ZwEjoPyyV0RPrjIcT2VNMyL5AS?=
 =?us-ascii?Q?1djZzm6406KBQnTN1HqzSFljvsx4Dw9dn2Wklsu9kgsLPJizL15yzGBQg5V3?=
 =?us-ascii?Q?L4b+yxDDsxqMmmcl2Ou5oAuU4nxYCpETqnZ+19uWThpGdzggMMsD3OMEHi5A?=
 =?us-ascii?Q?HTBsI05y4KHm534NL5hW5HZZON/WSqtsaJ7KdvjM9zUMfhrVxF8gcERlwjsg?=
 =?us-ascii?Q?L9LjEsjvoZzvM8gn6acte+q5Tx3NbsitMi7ZjJPDMyaVntbjypfpKoeyf/Nk?=
 =?us-ascii?Q?3kjPObHjTOYclfCrB+usEWnUpmwU2dCOTA0U7bCzHxDFBN6VJOoIovFw7eqL?=
 =?us-ascii?Q?gq1LipozpVEfTbdfK/Dy5tXlsqPKOQ7F9TfdN3mqEWdTlVJx/KeGQW+Kj/fz?=
 =?us-ascii?Q?fKNQqm0+yD8rJPmlavHmo96L2LBlCNzKgYuD6ZG0tqMqfXCFtGN588KJpsGx?=
 =?us-ascii?Q?Hlk3i5G0I/r7aIKa1TyeS9bkrT/uYFvI2/gM2BEBeJl5IbySg3fnXrhbcYwg?=
 =?us-ascii?Q?DWelOQSBIO+e05ov7S7X4bemO1NjLtcwWj6jJ13ZO07OOhMRBbbP8Q3wrBC9?=
 =?us-ascii?Q?GIagUxryU4Q6sKdy3T0L0XUOu03tm6kRc4nz7BDW/BotHP09pp42iv7+1eGR?=
 =?us-ascii?Q?8dyN1dNixFRJr+QPjqgE8XIV3nizb0pgYs0qGEYmpI8yr3JLwVGYUBr/rRba?=
 =?us-ascii?Q?eH3VWlhda9OnvtZuUiQXIXqWQ9XRh1uiPIhMtA6A661tuD36vCmgQI2Ya2fs?=
 =?us-ascii?Q?+oxklbsKavTAQwFDfUN/1zyuVeYdmuWu8ftUbakv8lgHSYeZysanuyxGXPVG?=
 =?us-ascii?Q?c93vSng7Trcsw/ZumD4pLZM577TJG5zM45R0mfQGBQbWzVR3IZJ54TtQ3HnI?=
 =?us-ascii?Q?MYzDgY0+e5ypeYlJbAsATp4uq62mZbz1AG1ABzKF9JP6ktQsKwTZf/4Y8F/l?=
 =?us-ascii?Q?YGmqfK/71CqyJ8guBs83jsYPmLf08m9oUIpKCrA5DK0e42UVEns+ks6QEK4m?=
 =?us-ascii?Q?6JMagW5vXvv8nJKwFBGRvzD/yvmm9NUAhnyW80a8K/u6CPC3r4QfnoyM68wv?=
 =?us-ascii?Q?/bHi29Vrdol1YXadH0rkQgU/teL88+QeJ0DTRi47xA/ZB4pYkZbG5bKerVN9?=
 =?us-ascii?Q?mv/YN/2V0TfR1YwqV4REcBTrCmJk4wecofQED/gKzdHPmRva7AN+N5OJGup5?=
 =?us-ascii?Q?QRWax+gt4ja3e2bqidnBOnYmKbGOl0FKzUlN8vxvQ6qh288jUnpoAhF3D0eC?=
 =?us-ascii?Q?dt3qg+ACs9ByleyXSBb0I4Zy/S1DPx8rD1VeWTGAjWcBWNNoBlIuDNrM2H7T?=
 =?us-ascii?Q?vDq5cVaRoJa69AnmXnhosIiNrUzdn3ErNtPBBFp/3nA4A8Y4yPGq1mUICOQY?=
 =?us-ascii?Q?ILzg6lJBHwbwx1W3DUPxwQTwvy7iJSM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d287db84-fb69-4422-a079-08df449e1b60
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:29:56.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nATF8/jlhyBZ7Ad+n6oT4UGkUEl8DMZwECV/ff2c8es+B09m+Y3SE/LizTELvkwsc/70PHZNCG3ikAmDPZ5BcdFCdb/PO0VPLxSwJOvhx/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:30:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24840
Content-Type: text/plain; charset="utf-8"

Describe the dracut initramfs, its modules and configuration packages,
and the dracut-specific behaviour of factory reset and secure boot.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.dracut.md        | 100 ++++++++++++++++++++++++++++++++++++
 doc/README.factory-reset.md |  46 +++++++++++++++++
 doc/README.secureboot.md    |   4 ++
 3 files changed, 150 insertions(+)
 create mode 100644 doc/README.dracut.md

diff --git a/doc/README.dracut.md b/doc/README.dracut.md
new file mode 100644
index 00000000..a41b1a70
--- /dev/null
+++ b/doc/README.dracut.md
@@ -0,0 +1,100 @@
+# dracut-generated initramfs
+
+isar-cip-core can generate dracut based initramfs images instead of using =
initramfs-tools.
+This prepares for Debian 14, which switches the initramfs generator from
+initramfs-tools to dracut. It is supported on trixie and later (including =
sid
+and forky). `cip-core-initramfs-dracut` is skipped on buster, bullseye and
+bookworm, whose dracut lacks the features the modules need.
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
+configuration derives `ROOTFS_CONTAINER_TYPE =3D "verity"`, the `dracut` o=
verride and
+`INITRD_CMDLINE_STYLE =3D "systemd"` from it, so setting `INITRAMFS_RECIPE=
` in
+`local.conf` is sufficient. With the style `systemd` the efibootguard-boot=
 wic
+plugin emits systemd's native verity arguments instead of
+`cip.verity_root_options=3D`: `roothash=3D`, `systemd.verity_root_options=
=3D`,
+`systemd.verity_root_data=3D` and `systemd.verity_root_hash=3D` (both poin=
ting at
+`/dev/${DRACUT_VERITY_DEVICE_LINK}`), plus `root=3D/dev/mapper/root`, `roo=
tfstype=3D` and `ro`.
+
+## What is in the initrd
+
+The dracut modules are maintained in a separate repository,
+[embedded-dracut-modules](https://gitlab.com/cip-playground/embedded-dracu=
t-modules),
+and built by the `embedded-dracut-modules` recipe. Their configuration is =
shipped
+separately by `dracut-config-cip-*` packages built in this layer.
+
+| dracut module | Module package | Configuration package | Replaces |
+|---|---|---|---|
+| `embedded-verity` | `dracut-embedded-verity` | `dracut-config-cip-verity=
` | `initramfs-verity-hook` |
+| `embedded-overlay` | `dracut-embedded-overlay` | `dracut-config-cip-over=
lay` | `initramfs-overlay-hook` |
+| `embedded-crypt` | `dracut-embedded-crypt` | `dracut-config-cip-crypt` |=
 `initramfs-crypt-hook` (systemd backend only) |
+| `embedded-factory-reset` | `dracut-embedded-factory-reset` | `dracut-con=
fig-cip-factory-reset` | `initramfs-factory-reset-hook` (EFI variable only)=
 |
+| `embedded-watchdog` | `dracut-embedded-watchdog` | `dracut-config-cip-wa=
tchdog` | watchdog handling of the crypt and factory-reset hooks |
+
+`cip-core-initramfs-dracut` installs only the configuration packages; each
+pulls in its module package. Overlay and watchdog are always installed; th=
e watchdog is only serviced
+if `INITRAMFS_WATCHDOG_DEVICE` is set. Verity is always
+installed, crypt with `encrypt-partitions` and
+factory-reset with `factory-reset` (`kas/opt/factory-reset.yml`). The drac=
ut
+modules are enabled via `DRACUT_EXTRA_MODULES`.
+
+## Configuration
+
+The configuration variables (`INITRAMFS_OVERLAY_*`, `CRYPT_*`,
+`INITRAMFS_FACTORY_RESET_*`, `DRACUT_VERITY_DEVICE_TIMEOUT`, ...) are unch=
anged.
+The `dracut-config-cip-*` packages write them to `/etc/dracut-embedded/`, =
where they
+override the module defaults. `dracut-config-cip-crypt` also generates a
+crypttab from `CRYPT_PARTITIONS`, ships it as `/usr/share/dracut-embedded/=
crypttab`
+and installs it to `/etc/crypttab` in its postinst.
+UUIDs in `CRYPT_PARTITIONS` must be lower-case, the build fails otherwise.=
 This
+differs from `initramfs-crypt-hook`, which also accepts upper-case UUIDs.
+
+`INITRAMFS_OVERLAY_RECOVERY_SCRIPT` is optional; if empty, the module's
+default recovery script is used.
+
+The initramfs is built with `--no-hostonly`, which `embedded-crypt` requir=
es.
+
+`embedded-verity` does not open the verity device itself. It ships a udev =
rule that
+runs `embedded-verity-match` against every filesystem partition and publis=
hes the one
+whose dm-verity header UUID matches the identity on the kernel command lin=
e as
+`/dev/${DRACUT_VERITY_DEVICE_LINK}`. systemd's own `systemd-veritysetup-ge=
nerator` then opens
+it as `/dev/mapper/root`.
+
+`embedded-overlay` is a `pre-pivot` hook that mounts the persistent storag=
e device
+under the real root and stacks a writable overlay over each path in
+`INITRAMFS_OVERLAY_PATHS`.
+
+## Encrypted partitions and `:expand`
+
+`embedded-crypt` provisions TPM2-sealed LUKS2 partitions on first boot and=
 leaves
+unlocking to systemd's native `systemd-cryptsetup-generator` (build-time
+`/etc/crypttab`). With `kas/opt/expand-on-first-boot.yml`, the last
+`CRYPT_PARTITIONS` entry gets `:expand`: on every boot the pre-mount hook
+grows that partition with `growpart`, and after mounting, `systemd-growfs`
+grows the LUKS2 payload and the filesystem. This is a no-op if the disk is
+already fully used. Only the last partition on the disk is grown. If the
+entry is not last, the module logs a warning and boots normally.
+
+## Constraints
+
+- **Verity is required.** A/B slot selection falls out of roothash matchin=
g;
+  there is no dracut port of `initramfs-abrootfs-hook` and there will not =
be
+  one. The `efibootguard-boot` wic plugin selects the verity root from
+  `ROOTFS_CONTAINER_TYPE`; the filesystem inside is selected by
+  `RO_ROOTFS_TYPE` (`squashfs` or `erofs`). Without secure boot the unifie=
d kernel image is
+  unsigned: verity only selects the slot and detects accidental corruption=
,
+  it does not protect against tampering. The build warns about this.
+  Setting `ROOTFS_CONTAINER_TYPE =3D ""` with dracut fails the build, as t=
he
+  default of `verity` is the only supported value.
+- **UKI systems only.** The non-unified-kernel efibootguard path
+  (`unified-kernel=3Dn`) is not supported and not tested against dracut.
+- One generator per image. Isar's `initramfs.bbclass` rejects an image tha=
t
+  mixes generators - with dracut selected, any package whose name contains
+  `initramfs` is an error - so there is no hybrid migration step.
diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
index 4b1a1ab9..99a8d78d 100644
--- a/doc/README.factory-reset.md
+++ b/doc/README.factory-reset.md
@@ -5,6 +5,8 @@ To enable the factory-reset functionality the following two=
 elements need to be
 ```
 INITRAMFS_INSTALL +=3D "initramfs-factory-reset-hook"
 ```
+  With dracut (`kas/opt/dracut.yml`), the module is `dracut-embedded-facto=
ry-reset`
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
+With `kas/opt/dracut.yml`, `dracut-embedded-factory-reset` replaces
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
+  `dracut-embedded-crypt` then creates a new LUKS2 container with a new vo=
lume
+  key and TPM2 token, and a new filesystem.
+- **Filesystem type:** encrypted partitions get their filesystem from
+  `dracut-embedded-crypt` (`CRYPT_CREATE_FILE_SYSTEM_CMD`).
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
index 256e8fae..9b2430be 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -191,6 +191,10 @@ local_conf_header:
 Replace `demo` with the name of the user-generated certificates. The user-=
generated certificates
 need to stored in the folder `recipes-devtools/secure-boot-secrets/files`.
=20
+The example above builds the initramfs with initramfs-tools. The initrd ca=
n
+alternatively be generated with dracut, which replaces `initramfs-verity-h=
ook`
+by the dracut module `embedded-verity`, see [README.dracut.md](README.drac=
ut.md).
+
 Build the image with user-generated keys by executing the command:
=20
 ```bash
--=20
2.47.3


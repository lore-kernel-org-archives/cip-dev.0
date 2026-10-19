Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEACCF2E9
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:01 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31403.1792405557545157339
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:26:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fbgz7Pcn;
 spf=pass (domain: siemens.com, ip: 40.107.130.11, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1B0khEmNPBvgRkhm3Zvn58LIK3lbRjaLyytr+zc60V6nFdH5IeFFQnLjVatWf/gPlfoll6o4jNvD/6ab22LoHn8BjpS5yXO37nnlrLENsErX7+DvqEcz4A35o4/k4u5LJaMaJuLgXAMmiIAcwLJ6pR5k1tlGTheCffdPU1I3crLraruJXMwfFvjOtbTM0zl2O9zjlze6X1BSDUJsFi+cOngAxmYReVY7AAk1P/TIs/uhKDAKjdWo2KC5R/RnJKlS7e1QGvt/O4KM0RV/Grj3xsNMz+PzDWBRQMduVPCuPjn6y0HpkgD2K1NBm6tt3cqiFJygS1SgSQaqXvOL4kW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgDS5k6eMOe/pHjhiuFW1+k42FgB/UR5LYLq3hBsjno=;
 b=Cv7rfyN+nploioFqL+CRBhNRAujSz3adnqCAOX4wnlMXKzoEdgdoTdXyNgMXcn0hLaTTFpZh4XcYTzzwI4LlexOpKaMCjgf/4mnhF0DYMh76seregSvdAns/+TICiFTwquPMrsFFVOPsXS0HCENQFF/+ouFdWsOGOXghGmfSWPSPlMQPTlK2AH2DhTsP4M9ghecdUC73230cC6TwptHjsNzU+Zzajv7BThNELmo2T5ZFDh8PjEqGr21doftHItM2Fgn0pDfOYUIO3XCs1a3S2w5yjz+dxkKz1CzMG+vuqUfWVvf9zxKwaaUE/vvsnx+1hj8jQfsq+krg1pNSRUe1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgDS5k6eMOe/pHjhiuFW1+k42FgB/UR5LYLq3hBsjno=;
 b=fbgz7PcntB5CxaRT70PGHRkyev8zCkbzvks8VQH6FrqBAU+rHj0j4CY44o9pVoi+0tboFmVFb8hEhcxOOirVCQqg1qMqXWHUckzVUT1vsmATMPaFB1v7/lPOGH2RbZpA48SsXqUrM5Xc4d421dqbbdLu8H2eWEEWbZ/Q+kH8qlb2YA/COM138I/1v+XXGSA/gohncj+pPrVKUm/JoXtjgN0CQRy5gPKlkHx/SuUKqy8UZHJl7ynYE9eNtHgIlRBrFHdzHaFK7LfpvWcHpPYh6sBTQUpUDSDLUcwG6zmAkJ2SYgzh3DV8nrHwHtlmYUFCQ8gbG12mVbUoh8qgv8uTvw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:54 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:54 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 11/12] doc: document dracut initramfs
Date: Mon, 19 Oct 2026 12:25:22 +0200
Message-ID: <20261019102541.672620-12-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80d1f9fa-2d96-4e35-9aa9-08df2dcb5b3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|55112099003|18002099003|22082099003|10067099003|3023799007|261009223027099003|261009221227099003|261009223327099003|261009221727099003|261009220027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	c4d3Kdw/LmEV9qfUpkXVU21AVplh+oYr/ShocgGkV6cojWaw0ec02BJq1miEOKJ4PoS0vtBU6N8dkshGD/6Fyoo/0HKvqSKXMtpWjTubP0APxVTtqx2Mh/wu1oJyiHnrE8pS73LG/16CAm8Y4rszTtcDQlrtzvdRmjrMVAVjcjYX6dwmYQ24/xGI4ajBIGdk8vpB2iVgVvL8V98S5ldpc+WxHzFTzNvPR6ehvbNOEn7EqcnCypASbPsKO6R/+p2syX1ozfQfd1m11xlnVFmOaXAlSFdhXukxxlwsZTAY5T37Iqq7JLM+q+P+YYRTjxX0B1GKiE4UHQTtXYi10hk2vaJbLNiF4IsEM3YXtcZnpKKdgmXLLfagqgHensfUBdw21aNr5c2PiGdJdPABDAo+8umj5XkydAl+Pc/WV4stj+7WQvC7dF6YOUBteJn+dRJmF2/XsYoWinHpHmyuWUr3l2H59+C6YbE6WdIGRpX5dbEyDhJrGf8s/5gqcV/ailTse4E0uqVB1JKQjxzVsYOnQPcQQFDkkK0Ha5qhlymQkx+sFpwqyQr3LTZFldPr4+/Ar+Dy6n+2xfZ6rlPEDfF+pqA6qm56xU01j0FofHjLd/nHbL9YiSdwoZsPFjbxz37UoSDqlwoV4NjLDHLEnMh1tVw8EfSuExIdwnDBfeu81Vo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(261009221227099003)(261009223327099003)(261009221727099003)(261009220027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ho8eTHyCG1fEIeeErxA1JE1zr7yM8VOATa5BKncCDTTkk4MqYjWn0wDEBEY7?=
 =?us-ascii?Q?hAjZtEC2t424jaEFMwzorrb6x9Vm6gvT+d5vbRfwnhrLVEm2E7EBfMA4JfB+?=
 =?us-ascii?Q?CpVvh0wAeVYU8s8wYCuxdmppD/JUPIy/cZ2fd6ep6ZJRXMWdP8DGqHbiJ8mP?=
 =?us-ascii?Q?1bhZsd08r986tF5zbRv0VQ7f8lNtZWhjuvfmQaJCfYJOWg9fFQCemlTnXRzX?=
 =?us-ascii?Q?rHapalnPqMAHeKmyg92j8oAUv6jVvQmTAbFifQAhM93IFP6GM8RKguOAoSCZ?=
 =?us-ascii?Q?sWMesHBamAGWzgbnSRshN8+kEDTEn4eaO7SKUkpj+FEDm0o4sXQ5iBO36s4y?=
 =?us-ascii?Q?Ton7wHSaaSXg4r0TMcc5O91NKJtRL6LtTfaB3829ZFVRRs3D//7N4ZcZvxUW?=
 =?us-ascii?Q?a6wfQf264OuZIi4iRc8r8zJzNvpyQGSNyQoaleQpsQM2N1TitAxBRyTsh4WN?=
 =?us-ascii?Q?RDRafWf24IdU9OOEHdrdIay6f9bKE1u9Qgyta348YJDsC1zjPtob1UXyxx+C?=
 =?us-ascii?Q?XCQBSiB4L9m4mAme9SuuKGqLV+NrlcHiU6bgAqiKKxBiXPluRTQE/xipRnk/?=
 =?us-ascii?Q?u/S6jUA/fD+E/WOQmZOXnGGFSo756t3k1Yp5D260c3eCuak67wj0eEQzXqSj?=
 =?us-ascii?Q?aMsNdABAL+Up5B/w6CXxw1x0ppKwIBlaclcYXZmzULzqFCwaYutpt4CQK0ib?=
 =?us-ascii?Q?83Im6v6kkJ8ipIzSDCrDRexaAGBPfWBQPQNBtHiHhykV1LV/SEjCoY9VfnwL?=
 =?us-ascii?Q?YsxeR6LNAubXMWHJx2ErgnQTrU78v6M0wlIkIqiyZXRo2B9fmHOckRuvkae7?=
 =?us-ascii?Q?tOGKVLndk5UheP9SRWVmce2dFbXlX01DML0KikXWApYin4EFxlfd7wnFtUOU?=
 =?us-ascii?Q?YmtidhSW+iKXK4dM9m/eR1Dp4TSLfawzQTPSpdVuUJGirbN+7mWEa88EBnth?=
 =?us-ascii?Q?11EiIPvwhfJgnzh/TrzQRfneaCsvz1ZN9K7qrkw0PcXeQdCryT1lwFJBfV74?=
 =?us-ascii?Q?WRTBkgg2e0PX3h3F1+V85iInZHTB5KYtHhlyFMUzyTHjy9fm4QHXKC5qzEt1?=
 =?us-ascii?Q?bOUCnMFURaoj3zg8segSF642GfHT/vAnyAzWYAB2e+VWc1KLVOVE+2U9mvVT?=
 =?us-ascii?Q?IZvjJrlSGELyyX9jpSOqL8QTlhAMETH/ISRbv6wRJ5l7eoetlR9KBst6NkAa?=
 =?us-ascii?Q?KroLoiDjqSYXIaioYJEQW17sIKlNC9yVfRls2nDK1Fs7D0+DjCNFYvDfM2s0?=
 =?us-ascii?Q?q4k36GYSRBvKLULYTo3gBupMHazcGHVxLIYnfnRufFmvatREkgWKMNNu/NBV?=
 =?us-ascii?Q?/mU83BvSJNftOgA70e5LjBjyMvgnv4dy5JYpfsRouqV4WOfuYp1R/wdt/SGC?=
 =?us-ascii?Q?V4RinkLSzzNxtv7bAfc9zdLCVJeGH1ApvVeBlvrLrULKtJgIz5eXpTP9WF7y?=
 =?us-ascii?Q?pakjTdeqIGCn0OoBX5Q+Cw5pc8G5myv3bdJjI8ENKWrs1WPh96uZR4Fi7pkN?=
 =?us-ascii?Q?P5wSR98AksMRuPkc0GzcFUKTYnzjSdBPubVz6fZ9JS1Nlc++ynl/VP3dYF7j?=
 =?us-ascii?Q?ylv86XVIjAfKBGVRzj6CeFkb+ziAmNCnnhhJEvC8szrROXhpuo5UafQsCVOZ?=
 =?us-ascii?Q?GNAaOz0J+yV0RXGrvJVnWQJixyYlx3JhUaVZ4da94d2IHkq97ZHPztOxzj9A?=
 =?us-ascii?Q?X7r+f43wEh/hJQsXQjo9aktDroJzWTxn4RM24sJQfEdxDQPZX8ZtJOb3UfqG?=
 =?us-ascii?Q?42bGqtUV3Uzsgus/fKxq7pncMrooRC4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d1f9fa-2d96-4e35-9aa9-08df2dcb5b3f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:54.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJwnO93fraXYnNqR3IP8Bu/QIKOCCNfBF4+/BuxFCQhG7ilS0Qbi+CiJWiR2GuGzU+TokToSOxi8l2BZuGE/EVHHRQUGdvbz0TNMLrg9qbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24491

Describe the dracut initramfs, its modules and configuration packages,
and the dracut-specific behaviour of factory reset and secure boot.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.dracut.md        | 99 +++++++++++++++++++++++++++++++++++++
 doc/README.factory-reset.md | 46 +++++++++++++++++
 doc/README.secureboot.md    |  4 ++
 3 files changed, 149 insertions(+)
 create mode 100644 doc/README.dracut.md

diff --git a/doc/README.dracut.md b/doc/README.dracut.md
new file mode 100644
index 00000000..2a59cd08
--- /dev/null
+++ b/doc/README.dracut.md
@@ -0,0 +1,99 @@
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
+  one. Without secure boot, the `efibootguard-boot` wic plugin replaces
+  `abrootfs_root=3Dy` with the verity root cmdline automatically. The unif=
ied
+  kernel image is then unsigned: verity only selects the slot and detects
+  accidental corruption, it does not protect against tampering. The build
+  warns about this.
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
index 658396a4..f576bc49 100644
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



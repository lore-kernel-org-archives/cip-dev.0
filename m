Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11270.1795689018322784349
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=mww4GY94;
 spf=pass (domain: siemens.com, ip: 52.101.84.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVwAJ+hB/vMU2gTle/WF8z+tEo9Axv6Ob7oYs9odJJoEJ5ZGP7N6BSj367GVsA69BZ0cSpDzRSLBlVSt4C76noZRv5HzHSsGyWiCYY4hjaXnDbya3HFsJee8Yz9Qq/73f2aIQ2y5hjxBLrxylFQBFymXn0jZBCI9JrTJuYxRnyF2UVCVisRKMR+DNDsS4Eydq9G83Oc0Ai9SKBd0iLs6Ck/XtE0kle4NbiwwAwq75exgOpmaQUX+jqWMNnVk3B9BRDRVYKKmXG9e5C4vUw+/bil6jESJW0Utj583Qn5iWZSHrS5+NB4UMl7q6us3+bEDqwadjk1PFKSBfJM9CD8CfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FI3+6f0KZmGwTSOB2tLUxCCd0xjEDm4gbkRMAzVgISM=;
 b=zL/pIunM87ZVHeYnMrzqiqxwjYSI1eAA5qpdCCX6axNgM36swgDXrGwDlmuL/oPTUpQM7kfc+BzLlPwQCygFt4gOZnEA+k1r4n+MLXXEjswOSlUE9Bdsofl+eiK4GK72ru8ktPijqBMJHeybG+27HK/MSuvPrR8Mg51OdTWjtn9dy7suAqO6FOvXmEv5qoREH3u+qoriPjFpA/OmBi9Zj6qoYTgAvJ71xk1C0k0Bf7vHvxtfIlF0+6HJFYNP7LbwpeH9ouB/uMD1kWt+gLqqWpoXhLtzmscviC+UjyPFUoYiqM/5NmMpZcPffIvE2WE3U4GmPYlmVTaAQ+C2qskTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FI3+6f0KZmGwTSOB2tLUxCCd0xjEDm4gbkRMAzVgISM=;
 b=mww4GY94gQ/O0ThJLhqZOtyq7EfHKJDQiW9JBBosURI6utw+2tBR2rJEYuzTMINhJ0SSn6pNevXHB2BZ0O7P01SYeUTvJr/fva0TvHmBaeLfmh61THxbDH1vDnD4QEFmPebEsnu/Ql1XVrZbZJc2afKf8cgTrk3TkdyaXPK0QJXabP6oB1BM8ldE101y9EvRAJdnwSKaIwWZfLPE6AMWtaM06F6E293cxYa1jiERrVh50ToV25knFucNZKShjz2Nt8hX40e6x9G9wOfFK3FxhCJmAwQ/fuhbdscwRz/rXttwNAajnuIEwMz3yjkIbGn7HTPI+XTirBQQD1Zm5qDsOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 10:30:13 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:13 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 00/21] Add a dracut based initramfs
Date: Thu, 26 Nov 2026 11:29:46 +0100
Message-ID: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: f503a883-6c5a-411b-671d-08df4ba8418c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|261028144727099003|10067099003|11063799006|261022115727099003|261021135927099003|56012099006|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261022075727099003|261009221227099003|261026121527099003|261102123227099003|18002099003|6133799003|55112099003;
X-Microsoft-Antispam-Message-Info: lgms6zlzXU1vjtjaqQrv3aB+JxK0IOKn4XqIMmcxTq7HgNod60cNdyAggN9cFn1ap3UxsaPijcm9v71OfrUGYV7ThcWOwVGBPMSnjjI6cpaab7BHN7DnV/VTuAYE27q856bUuL5UCIWsf29YsLh/mAEiSdLX2RGmPkRWoI7QMvtre92YOkqF5C37C9aWLJrax9+N3smMJScUs48mXhTCr4ootVVUOLiRP3B57HVwsiEWT7XSaSKrLGb5qwiTYTlwk/S16JMtxGGoY2/ihQ9lNC2435fXuDOMOQZhln8BoPLFXZoKsxOlHsAR1mlv0M2sOl+CqMvUtAjJzlY7jWlxdrZt/puqOD/GxVLx3O//gl4lBkPHt0wihbDqPBEUnht0/hcD9a6oT4FB60+fRq0GoaXDmF9Ejq7HqwySL8h8o8zyyYH+VgkKXAVxu2W2Lh+Z/A8R6H6c29QVk/dH8Z49Pm92ifC8rhY3o6FukA6Tj//J3C2j+6GI65Fq3hooe7WNa6yNr8uVWo4J6Vrqou7awcS3bpyPSCgAxERZHYEDz5XSkFWvYmwIy4p5a1NfYNkfRuNKyr+0kHvJTfhDMFoSgiKFBl7ASXRHsVfRxKjVaw/fQlHYnVQw8YravYU8SimR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(261028144727099003)(10067099003)(11063799006)(261022115727099003)(261021135927099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261009221227099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQ6pG3EuYh6aTp7cFsRgnMktAHk9FzM+HeuaDL5AEHZui5Z2MV7SWijd+38y?=
 =?us-ascii?Q?837gOZyuVLwE157FoqAIfabuwr0zAUCOw5BLgR6bEKDZsaHWlIjeIVjol0Uq?=
 =?us-ascii?Q?mLcuvdWB1gGw0IKNVQzgpmGtq/ftIryC7HEbBdr7myoK5l/GNAWoPNpt7+qL?=
 =?us-ascii?Q?bToue53rca/kKZvM3tcMZEZBswJgWFxJEGzwS8Jg2zAo/0Q2Q/+5Zq7oVDq+?=
 =?us-ascii?Q?qsOIT+QvD8W7XY34QriMDltnaU2US46hG0zkOyd5ECSEzNNdESLdZ+YU6LA0?=
 =?us-ascii?Q?aEiajgWdYBAZyXjfPeQT83n0xrcfcm4l6qmeTqwcY0AVfSh1rnTSAwrnz4Zi?=
 =?us-ascii?Q?ySwi0PNxXijKU0hwUA1NR/RrQBrOQ29Fu/FuHpYa3lEDIP3o6cwO8w1eIFtp?=
 =?us-ascii?Q?/lboaSwhRhGx6feLoCIbKUMoc8AWWu6QkaaCKYu11YJ+ApzEW2DlaK8r/ZeL?=
 =?us-ascii?Q?CWWEQxs+CShKq0CrBodn/nCIVOs0d+vrTvGePy8sfwt7XQ8FIN4HgeVVf7K4?=
 =?us-ascii?Q?9RO5ut1LfQe4tL7AGJ9e1tKROqP5FZ8lHSw4cZZfFBQVwJ5eJBT/NrxwgEtc?=
 =?us-ascii?Q?kGMPLLao+m2CryBp4Wcm0zh5M/itpYqacIvH1MP0u53we6UhQjfsZHlRCCe7?=
 =?us-ascii?Q?7iyolgWdLuTjqshYKd75B0YGkFyejiqBke3EwfaqPvaoqo5fABcY+VZssu2K?=
 =?us-ascii?Q?rsOemaCgKxmEIDbAnPUVzMcAyJZ/zbo4IQHsi4rsYoy4nCtu+OzoawuGPIlb?=
 =?us-ascii?Q?BJO2SP4E6LJdB/RPDFK74el2ZvaVWgyThI3YnNbsJC0GxwpQKzGuyM1S/6AT?=
 =?us-ascii?Q?ZlDSYfQmnt7E1lO3+JtMlKSDeMBAp28rX+WhdlL+2kgJxivHMNVuF6JT2+rE?=
 =?us-ascii?Q?+0MpceD3gTgpMcSKOnz/9ij2H8EtgB0/06hyiYy2A3tMDdywoqDD//+m70/1?=
 =?us-ascii?Q?0ZMNzAbq5h1tu8od7FRDIhdeqBHcg7Sssnsd6pd5sDTFouuzcQ7Ae8Lkxao+?=
 =?us-ascii?Q?D1HlT2Je2+3I99fBtfaRK1A7Wy4kzlqD8CgE/BsWnkIUivKrkSFdzrtLZh1f?=
 =?us-ascii?Q?Dijw1sktDdqAI7Erme24Xpzm744gxZ8ueDLmDgxJuyVbDYQxrUtqxc8RXwGS?=
 =?us-ascii?Q?1UjXhTumSAPnXvH/DzX7qXWvNmbReddaHBUGDVcuE3vvR4kdR6BftVx1mB7j?=
 =?us-ascii?Q?rsmGtaEMOBcXjeIEPIbCWeh/kKWn5rQgRy7wRYxcZjedyT5LmkkR+LiDij+R?=
 =?us-ascii?Q?afMSISbiMa0jcDnbj0M314DL8Vgbk98MoCRiwuRxUxpnJ1N5HJZBhJYHjEAo?=
 =?us-ascii?Q?hLusuN2TkXmsgn/wUcYesl9TeJvax5DUh0sHDmYzp7QONmzgmzoYzcS3ISC7?=
 =?us-ascii?Q?jcMRcfXr9CDde+gb3agSrbotz0k/Mf18sZTl1tsMukLiO4Ju7gcKw4tIC3NU?=
 =?us-ascii?Q?dGZLMnk/A7i5zZm1wQAIFmPXVJlJoKxdgxgy9TYLMP5hKLr3wsNzK0rRfCBB?=
 =?us-ascii?Q?acV02D2hp4iyyRgfDwSiAJGGs1CpMaLimk9+eznz5okicL70S8gh9T6nWfe6?=
 =?us-ascii?Q?41coEl0pl7zV45mIjnAuFIVJtMBfofoXbEZcUGGoYZBno+M3LkDmexNssioP?=
 =?us-ascii?Q?pNMugoO4HY0zLsu8q4mRLwOqiBGmjWJ6zCl0IMi6Y0tff6a7zN9vtgkMbm54?=
 =?us-ascii?Q?Tla82RtRJFDLBBrCnk0JugKFMZVYfpN6qZdRTBDIMiyIePAyxdwvbthiOLLT?=
 =?us-ascii?Q?pURuHJbN23grWBfBoi7G7dhrKRVxQ94=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f503a883-6c5a-411b-671d-08df4ba8418c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:13.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9in/2bgq1uEZlNzoNMW5IiAk6SMFYFyVmRKJXOtk8S9xLf1yHAH4eSyffv+Apk9yhe6Ec/mGqTJb8RLLLjUyrJ2PQthNeVVT7WRE0RPWe7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25082
Content-Type: text/plain; charset="utf-8"

This series adds a dracut based initramfs next to the existing
initramfs-tools one. Debian forky switches the default initramfs
generator from initramfs-tools to dracut; this lets CIP Core images
move early and tests the dracut modules in advance. Trixie is the
minimum release. It is selected with kas/opt/dracut.yml or in the kas
menu and requires SWUpdate with the efibootguard-boot wic plugin.

The initramfs is built from the embedded-dracut-modules package
(embedded-verity, -overlay, -crypt, -factory-reset, -watchdog,
-sbcerts), which replaces the corresponding initramfs-tools hooks. One
dracut-config-cip-<module> package per module writes the existing
BitBake configuration to /etc/dracut-embedded/.

Supported with dracut: dm-verity root (with or without secure boot),
overlay, factory reset (systemd FactoryReset EFI variable), encryption
of data partitions (/var, /home) and, with kas/opt/encrypt-all.yml, of
the rootfs partitions, separate home, secure boot key enrollment
(embedded-sbcerts) and fTPM/StMM (TEE and fTPM drivers in the initrd,
tee-supplicant if it runs in userland).

Note: the embedded-dracut-modules source is still fetched from
gitlab.com/cip-playground/embedded-dracut-modules (branch main). The
final location is pending a decision by the CIP TSC. This does not
block the series: once it is decided, a follow-up updates SRC_URI in
the recipe.

Not part of this series, to be done as follow-ups:
- CI/LAVA coverage of the dracut paths beyond the secure boot boot
  test: verity corruption, SWUpdate update and rollback, factory reset,
  encrypt-all, a runtime watchdog check, and a /proc/cmdline check that
  the dracut initrd was booted. Also encrypt-all with initramfs-tools.

Changes since v3:
- Rootfs encryption (kas/opt/encrypt-all.yml) is supported with dracut.
  The mountpoint / in CRYPT_PARTITIONS marks the A/B rootfs; the
  initramfs-tools crypt hook understands the marker too.
- Secure boot key enrollment (embedded-sbcerts) and fTPM/StMM are
  supported with dracut.
- New: VERITY_ON_CORRUPTION configures the reaction to dm-verity
  corruption (default restart, panic with dracut). All efibootguard
  wks files set panic=3D5, so a panic falls back to the other A/B slot.
- New: SYSTEMD_WATCHDOG_TIMEOUT for the systemd runtime watchdog;
  kas/opt/disable-watchdog.yml disables the watchdog completely.
- The dracut-config-cip packages that depend on the machine are named
  <recipe>-${MACHINE}.
- qemu-arm64 doubles the crypt setup timeout, as encrypting the rootfs
  with encrypt-all takes longer on the emulated CPU.
- Dropped "qemu-amd64: load watchdog drivers early via force drivers"
  and the Isar update it needed: CIP kernels build lpc_ich in, the
  change was only required for Debian kernels, which build it as a
  module.
- "Fix expand-on-first-boot with separate home" is merged.
- Review fixes, CI and documentation updates.

Tested on qemu-amd64 and qemu-arm64 (trixie, 6.12, erofs, secure boot,
SWUpdate, separate home, factory reset, encrypted data partitions).
Rootfs encryption (kas/opt/encrypt-all.yml) was checked on the
qemu-amd64 initrd.

Quirin Gylstorff (21):
  initramfs-crypt-hook: treat mountpoint / as rootfs marker for A/B
  kas: encrypt-all: mark the A/B rootfs with mountpoint /
  Add ROOTFS_CONTAINER_TYPE to wrap the read-only rootfs
  efibootguard-boot: derive root mode from ROOTFS_CONTAINER_TYPE
  efibootguard-boot: look up verity and uuid env by image name
  read-only-rootfs: check ROOTFS_CONTAINER_TYPE and secure boot settings
  read-only-rootfs: do not mount LABEL=3Dvar from fstab with dracut
  customizations: make systemd watchdog timeout configurable
  embedded-dracut-modules: add recipe
  dracut-config-cip-*: add build configuration packages
  factory-reset-helper-efi: use systemd FactoryReset variable with
    dracut
  efibootguard-boot: emit systemd verity cmdline for dracut
  efibootguard-boot: disable the dracut emergency shell
  cip-core-initramfs-dracut: add dracut initramfs
  read-only-rootfs: do not install home.mount with dracut and encryption
  ci: Add dracut build
  Kconfig: add option to generate initramfs with dracut
  doc: document dracut initramfs
  wic: reboot on kernel panic with efibootguard
  verity: make the reaction to corruption configurable
  qemu-arm64: double the crypt setup timeout

 .gitlab-ci.yml                                |  69 +++++++-
 Kconfig                                       |  41 ++++-
 classes-recipe/read-only-rootfs.bbclass       |  72 +++++++-
 classes-recipe/swupdate.bbclass               |   2 +-
 classes-recipe/verity.bbclass                 |   8 +-
 conf/distro/cip-core-common.inc               |  45 ++++-
 conf/machine/qemu-amd64.conf                  |   3 +-
 conf/machine/qemu-arm64.conf                  |   6 +
 doc/README.dracut.md                          | 162 ++++++++++++++++++
 doc/README.factory-reset.md                   |  59 +++++++
 doc/README.secureboot.md                      |  39 ++++-
 doc/README.swupdate.md                        |   2 +-
 doc/README.tpm2.encryption.md                 |  19 +-
 kas/opt/disable-watchdog.yml                  |   1 +
 kas/opt/dracut.yml                            |  20 +++
 kas/opt/ebg-secure-boot-snakeoil.yml          |   2 -
 kas/opt/encrypt-all.yml                       |  10 +-
 kas/opt/verity.yml                            |  18 ++
 recipes-core/customizations/common.inc        |   6 +-
 .../customizations/files/99-watchdog.conf     |   6 -
 .../files/99-watchdog.conf.tmpl               |   8 +
 recipes-core/images/swupdate-efibootguard.inc |   3 +-
 recipes-core/images/swupdate.inc              |   2 +-
 .../cip-core-initramfs-dracut.bb              |  54 ++++++
 .../cip-core-initramfs/cip-core-initramfs.bb  |   5 +-
 .../dracut-config-cip-crypt_0.1.bb            |  97 +++++++++++
 .../files/embedded-crypt.conf.tmpl            |  16 ++
 .../dracut-config-cip-crypt/files/postinst    |  18 ++
 .../dracut-config-cip-factory-reset_0.1.bb    |  43 +++++
 .../files/embedded-factory-reset.conf.tmpl    |  11 ++
 .../dracut-config-cip-overlay_0.1.bb          |  48 ++++++
 .../files/embedded-overlay.conf.tmpl          |  12 ++
 .../dracut-config-cip-verity_0.1.bb           |  46 +++++
 .../files/embedded-verity.conf.tmpl           |  10 ++
 .../dracut-config-cip-watchdog_0.1.bb         |  36 ++++
 .../files/embedded-watchdog.conf.tmpl         |   9 +
 .../dracut-tee-supplicant_0.1.bb              |  28 +++
 .../dracut-tee-supplicant/files/install.sh    |  12 ++
 .../files/installkernel.sh                    |  10 ++
 .../files/tee-supplicant.service              |  26 +++
 .../embedded-dracut-modules_0.1.bb            |  24 +++
 .../files/local-bottom-complete               |   7 +-
 .../files/local-top-complete                  |  21 ++-
 .../initramfs-verity-hook_0.3.bb              |   3 +-
 .../factory-reset-helper-efi_0.1.bb           |   3 +
 .../factory-reset-helper-file_0.1.bb          |   3 +
 .../wic/plugins/source/efibootguard-boot.py   | 129 +++++++++++---
 wic/bbb-efibootguard.wks.in                   |   4 +-
 wic/beaglev-fire-efibootguard.wks.in          |   4 +-
 wic/de0-nano-soc-efibootguard.wks.in          |   4 +-
 wic/ebg-signed-sysparts.inc                   |   4 +-
 wic/ebg-sysparts.inc                          |   4 +-
 wic/hihope-rzg2m-efibootguard.wks.in          |   4 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in |   2 +-
 wic/qemu-arm64-efibootguard.wks.in            |   4 +-
 wic/qemu-riscv64-efibootguard.wks.in          |   4 +-
 wic/rzt2h-evk-efibootguard.wks.in             |   4 +-
 ...i-am62px-sk-efibootguard-secureboot.wks.in |   4 +-
 wic/ti-am62px-sk-efibootguard.wks.in          |   4 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in   |   2 +-
 wic/x86-uefi-efibootguard.wks.in              |   4 +-
 61 files changed, 1231 insertions(+), 95 deletions(-)
 create mode 100644 doc/README.dracut.md
 create mode 100644 kas/opt/dracut.yml
 create mode 100644 kas/opt/verity.yml
 delete mode 100644 recipes-core/customizations/files/99-watchdog.conf
 create mode 100644 recipes-core/customizations/files/99-watchdog.conf.tmpl
 create mode 100644 recipes-initramfs/cip-core-initramfs-dracut/cip-core-in=
itramfs-dracut.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/dracut-config=
-cip-crypt_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/embedde=
d-crypt.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/postins=
t
 create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/dracu=
t-config-cip-factory-reset_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/files=
/embedded-factory-reset.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-overlay/dracut-conf=
ig-cip-overlay_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-overlay/files/embed=
ded-overlay.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-verity/dracut-confi=
g-cip-verity_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-verity/files/embedd=
ed-verity.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/dracut-con=
fig-cip-watchdog_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/files/embe=
dded-watchdog.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-tee-supplicant/dracut-tee-supp=
licant_0.1.bb
 create mode 100644 recipes-initramfs/dracut-tee-supplicant/files/install.s=
h
 create mode 100644 recipes-initramfs/dracut-tee-supplicant/files/installke=
rnel.sh
 create mode 100644 recipes-initramfs/dracut-tee-supplicant/files/tee-suppl=
icant.service
 create mode 100644 recipes-initramfs/embedded-dracut-modules/embedded-drac=
ut-modules_0.1.bb

--=20
2.47.3


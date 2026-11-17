Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15529.1794914926563983602
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fQVmlE1H;
 spf=pass (domain: siemens.com, ip: 52.101.83.21, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk/mayE8fm6MK/NqawtiE3F0Flj2464yvqg6qB2xoX8qKNbq4SAGOVATfk3SdbNlNKvoK+TzsSpgICt5BPlwcP7uqs1fJtVz8SWDTJIQeDQKXfml9v4pz97mEBLqzmhiv/CAzjDabT+r9H30xOQ+NkhplPbxuG7gkzOwbsrSEujanUZXlZx3SRWIzNltcGOey35bs+QMXoCQOq1E9ZGb9VFrs/hoJUUfmqTTNN1SMvEcocwNvobVXLUo3lQ9fLgIAssvjilK6HjE6b3CAp3MUlQGGUfS5rE4lA5fMvdbX4ttKXa02eCBR5ksHcD3JqxXVonUCKOyCVYgr1DfpA1veg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb8RNEVQlOYZysWDOlFIo+FLQrMrcCh5xgCs4hvTNaI=;
 b=d19nT+oNCMrg3TdTNMsgVwGzxfHiiR2Y6V42sS/MigayDFWOqy5WREur6+Ln1SkCOLB/xz7pehEnIhltwtvb3JqiSwhpIPBCAOz9I5qtejjozePeyN2uQKMEt2RoFAbzQU7MhSwuu6xyAOp6eDkIzynPpoDfgJpxwh9ElZFCAUCfwlFnvLMXg0IHt7cpRPxNt7ynCrgIXMD1EuJkVCKE5Yn33Z2rXjjDfJ9KKwPnjomeWCOEX9zI20nMXXVyqo3mLucyxZOrQ3BZvy7j/VwpW2cWOCn7H6wA5YfZqHi/meZ4N8ITAaKg0aKOeuoYZ9ZPACTxX1XUgmfeLiTSUxGA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb8RNEVQlOYZysWDOlFIo+FLQrMrcCh5xgCs4hvTNaI=;
 b=fQVmlE1HUAtit9/Sv4BiKJ7lyV6pjLJtRKmhhgX2uAt/aKlllrjwZkCxJaAZaVH/lo/w9wOdRND6BWdZrV73HeHpgqrOTkvHJo/avFVE8FVWJnyVzRDaUw3Xa0lpoIu3eg4V1HXlYsGMScfn04dsPvxhjycvdSxlBvfm+aLRRGguibBNtzFkkfGP/ykSWOfk8SyaklI/6YDaIGcd+CVKrOeMi+/lEaXPFKqt8BUCOlBK1DNDw4YtOuSe00WVuuC5eE98nob5LSSgVWHwCqoqOKRtUGYxkcSpbzIvGEHQVGLEy4YHRNL+knh2RtsELQ+0LE4PIVNWnabDDLUCHRSc5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS2PR10MB6615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 11:28:40 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:40 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 00/19] Add a dracut based initramfs
Date: Tue, 17 Nov 2026 12:28:14 +0100
Message-ID: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS2PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 942509b4-10a5-4222-664e-08df449deda9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261026121527099003|261022115727099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261102123227099003|261009223027099003|261009221227099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Q2ct6tXB3njZ/zao5GlEbMv7nCh9YG8auYgYutqGh7hp1v0P1vMzTJcAB056q1OVWHP0Ctg/ElF46x+2qdPx5jaTnLvSYkbcIzN/QFM3a1nEnD2N1dX9i7BFjn0/CKpMDWYHLgjJUb9cmYgrk8aaib4EEOMapoO7GGIKoSsPn/ADlrK4/cdvPUHnzGiBLMBetPUtdFgo1oRM0rUk85XmpX/E6Dm9kz9cZF1v7KPPCRnRrsTnhZOrBUN3iZ8jPjzKnZAYLSEA7VxBXFEB2NGsCALS6HCdy4yMQvf43pT+8pWeKWy3e15yCWcVOhkS1ZWI8LgJnanMPcpsPZoRzQF7emzsvny8oiYd/Xpym3EwGz+B1+a9M/sqTFNnh6J9lsJQZ7gbusH0AzUB1hCF3bbhbN3iV5zKUD09Ifb4OtpEXk0CRcUrrJKZ8EycpOBTv4YFhm6oZmkG0UOKhocgZK0hhkU8K6um9UJd47eAKDQF43iuft/iKL8B1zcAYOlAWjLTG7Xm6BFApV43yX2FxlnbyXfaW6N+9nbJ0gklM5KNLycpugPFPFI1p0orWPk3IHhZ+UM3hPryAx10pYa+MaJjc1qnrjGVcuytEkyyiB5JCOZmP+4aad/LeWDmbM9uGetn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022115727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261102123227099003)(261009223027099003)(261009221227099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q/WLi07I/OLFxdxNDG7/s4RmDUFhIsxdWaOKEx6dCMLBd1fpkobwDwrehfqY?=
 =?us-ascii?Q?3sA38y4rAe5XAGk78AoMZt7bS13qsbLTUW9zkMhxHEoR8776UwegOQADu5+7?=
 =?us-ascii?Q?yrYV3yXy9MzJlG3Q6xoPwb3kBl5nYWGu9ciEj4bjQdhaDdYSg36OEN7lskhV?=
 =?us-ascii?Q?CgsKNAgYUobemCuhp+dAYRefzNW3mmqP2+RWvTsWvQjm19U7nRD0/ybW0hPj?=
 =?us-ascii?Q?P/FrUDliQ/BV14MWV5kkzk7kdtSLaAYApwVqvKnQkZoaHJKdiY9+KRavUUI1?=
 =?us-ascii?Q?rX+sORWMrXLZcrZu+vES14rKNfAfGszKKTlq6wEzR/Qp4VckOhNZs5XTSOoQ?=
 =?us-ascii?Q?J/lmLXP5EkyTvic7rxQPromY6u9baYpnZXWbh9ICbMdkVvtmCc4PePgcXKxr?=
 =?us-ascii?Q?AOfv3YHIrxMeBg3EELrLjdOaRu6I/P5wEY7zlFcP/NNz6GsTqhqMnHn45a52?=
 =?us-ascii?Q?fx2ezRRmNJxFlmbslnOyFHs8O7GwcSFahD6GG5YLE8c/VQdKvn2nFBXmdrPf?=
 =?us-ascii?Q?aYl8d+jDC/A00j89Az1f4Qu6l4CbDlIOX5JZKjgeZi6zK5uMSayaXGrv8WlU?=
 =?us-ascii?Q?L03WG2PqClwlHV5mFImV6FObkqoYnPtAq/vhHDu4gM1AZMEM+mEe675oXOXu?=
 =?us-ascii?Q?SRpuLye4pYyPv9Td7n/i/vRuSbrtsLbpZkh6mY0DcIeGI0bztmkEwljjPQTv?=
 =?us-ascii?Q?puKqton4Zs53tYFXTemUAhP9YPM0jlMUyy9g3pSIaWzSSGKuRAyG9yd+bO9/?=
 =?us-ascii?Q?X2A1C52Ddpb43BkLafamF6RVsgOm5r8Ci+MyrmgvNbEtKIF1PHrggLhbzFCp?=
 =?us-ascii?Q?vH8+5RJMdDaUdl+b6lxWM4M8C8oA2PubQfIvmsdKF1+sd3w6LGx5gj5ou9ab?=
 =?us-ascii?Q?FZAcEAShO2NjHHRHFdcTN/ok5pqfFtOA/koblMHzcfcPnJchXBbB8sWm9fXP?=
 =?us-ascii?Q?2sjgdvxYu/tusZZY/OQCbFBOCcT0IjqX24x4T1QGvU+3UVT7qG+9gWCmyXHy?=
 =?us-ascii?Q?ioNJ/kWy4vKEU6e78fMgeQO6P/XeOBK+6T0D4BrdnIPF0dZslUVzZSdMVLoq?=
 =?us-ascii?Q?i9OccFEW90AzYKZSgixTHZwmKZtiPBlrtjt9rZ+Xb4VVZkDh0j8P8NOyTkni?=
 =?us-ascii?Q?VW+lJRjSs1Cg6Qhj5K4kbnEH3Z9EANDI3pKWMJfRyYcRYUQ5BK53D8bPRd80?=
 =?us-ascii?Q?NpIQxYCkD65SVGDUusJQLMi4AAoLDYI0HuIIiabu8v8ytEsMFb2NW1iHsJ1H?=
 =?us-ascii?Q?2TPb+a7honAUERnXwxFqJmtFP7jJ2vVfwqXFwU4CiZxhzdAU+zTvV5Sg8vMu?=
 =?us-ascii?Q?sTkwES75MvrhmWmm01ieNcDkrk6d1pR2cfkwvl7aPU9SZLOlIGwVTjcwLdR4?=
 =?us-ascii?Q?cWu3Ek3s8EghDCQInyX0tzTZ2XfKwyD7Smj1skKggbVvaXYJzJs02P6Ko+ue?=
 =?us-ascii?Q?M1XB1+B+WnhXdrCxoyYtWc4BezV7vWw94rySj39b48e3nyfe8ZTUOq2zW7T0?=
 =?us-ascii?Q?0XObjpjypgnMEi4/kp39gSBvB5jC0xRpXoeCvTemxABAoJ85cza2fOv2Rjn/?=
 =?us-ascii?Q?iqVqPPNupinWq0EyVagIIjRrA31BKn5DY+2epncUeE3o6I0A5pqCr24ZWr3v?=
 =?us-ascii?Q?1jy7IOHO3Ce7rAQE1ylGNw2FwSf1oiRUb8DzqNUTK83EBNWxMNizfJCwJMm/?=
 =?us-ascii?Q?E1AUrOF9NmhNsnyUTcsERNlZUMaXyalhlwcnpqPCpcBno+H33sSUtU62cgQd?=
 =?us-ascii?Q?xaxJ4xFBF3skUVHvMs8AC/lbpWx2H6s=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942509b4-10a5-4222-664e-08df449deda9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:40.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6ruAweKcSf1I+VtCxLmT/gVNCOvAmRdkFKCd3vN2KitiUOYkJvRQKZNiAs6gKgl8nQAxBcPoq2hrh5DiLkObh3MVvxgB6mZRMfeCqsL83E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24821
Content-Type: text/plain; charset="utf-8"

This series adds a dracut based initramfs next to the existing
initramfs-tools one. Debian forky switches the default initramfs
generator from initramfs-tools to dracut; this lets CIP Core images
move early and tests the dracut modules in advance. Trixie is the
minimum release. It is selected with kas/opt/dracut.yml or in the kas
menu and requires SWUpdate with the efibootguard-boot wic plugin.

The initramfs is built from the embedded-dracut-modules package
(embedded-verity, -overlay, -crypt, -factory-reset, -watchdog), which
replaces the corresponding initramfs-tools hooks. One
dracut-config-cip-<module> package per module writes the existing
BitBake configuration to /etc/dracut-embedded/.

Supported with dracut: dm-verity root (with or without secure boot),
overlay, factory reset (systemd FactoryReset EFI variable), encryption
of data partitions (/var, /home), separate home. Not supported:
encryption of the rootfs partitions; the Kconfig hides both options
with dracut and the documentation explains why.

Note: the embedded-dracut-modules source is still fetched from
gitlab.com/cip-playground/embedded-dracut-modules (branch rfc). The
final location is pending a decision by the CIP TSC; the recipe will
be updated once it is decided.

Changes since v2:
- Split the read-only rootfs type: RO_ROOTFS_TYPE is now only the
  filesystem (squashfs, erofs); the new ROOTFS_CONTAINER_TYPE ("" or
  "verity") describes the container around it, as suggested by Jan.
  dm-verity is stacked on top of rootfs.${RO_ROOTFS_TYPE} and only
  changes the file suffix. ROOTFS_IMAGE_TYPE is derived from both and
  used by the wks files and the swu. VERITY_IMAGE_TYPE is removed.
- efibootguard-boot: derive the root mode (abrootfs or verity) from
  ROOTFS_CONTAINER_TYPE instead of the abrootfs_root/verity_root
  sourceparams, which are only a fallback for out-of-tree wks files.
  dm-verity can now be used without secure boot (kas/opt/verity.yml).
- efibootguard-boot: look up the verity and uuid env files by
  IMAGE_FULLNAME instead of globbing IMAGE_BASENAME*.
- read-only-rootfs: fail early on invalid RO_ROOTFS_TYPE/
  ROOTFS_CONTAINER_TYPE, warn for verity without secure boot.
- read-only-rootfs: do not mount LABEL=3Dvar from fstab; do not install
  home.mount with dracut and encryption.
- New: INITRD_EMERGENCY_CMDLINE; the dracut initramfs reboots instead
  of dropping into an emergency shell (rd.shell=3D0 rd.emergency=3Dreboot).
  An empty value emits no arguments.
- New: WDOG_TIMEOUT configures the systemd runtime watchdog; 0 disables
  it as well.
- dracut-config-cip-*: fixed files/embedded-<module>.conf.tmpl rendered
  by Isar and installed unchanged; The crypttab is installed from the
  postinst and an edited one is not overwritten on upgrade.
- Kconfig: dracut depends on SWUpdate; the verity and rootfs
  encryption options are not offered with it.
- qemu-amd64: force-load lpc_ich in the initrd (DRACUT_FORCE_DRIVERS,
  Isar updated for it). iTCO_wdt binds to a platform device that
  lpc_ich creates, so it is not pulled in by itself. udev loads
  lpc_ich too late for systemd to service the watchdog during the
  initrd phase. Forcing lpc_ich loads the whole chain early.
- Commit message cleanups.
- Added documentation and a CI build.

Tested on qemu-amd64 and qemu-arm64 (trixie, 6.12, erofs, secure boot,
SWUpdate, separate home, factory reset, encrypted data partitions).

Quirin Gylstorff (19):
  Update Isar for DRACUT_FORCE_DRIVERS
  Fix expand-on-first-boot with separate home
  Add ROOTFS_CONTAINER_TYPE to wrap the read-only rootfs
  efibootguard-boot: derive root mode from ROOTFS_CONTAINER_TYPE
  efibootguard-boot: look up verity and uuid env by image name
  read-only-rootfs: check ROOTFS_CONTAINER_TYPE and secure boot settings
  read-only-rootfs: do not mount LABEL=3Dvar from fstab
  customizations: make systemd watchdog timeout configurable
  embedded-dracut-modules: add recipe
  dracut-config-cip-*: add build configuration packages
  factory-reset-helper-efi: use systemd FactoryReset variable with
    dracut
  efibootguard-boot: emit systemd verity cmdline for dracut
  efibootguard-boot: disable the dracut emergency shell
  cip-core-initramfs-dracut: add dracut initramfs
  read-only-rootfs: do not install home.mount with dracut and encryption
  qemu-amd64: load watchdog drivers early via force drivers
  Add ci build for dracut
  Kconfig: add option to generate initramfs with dracut
  doc: document dracut initramfs

 .gitlab-ci.yml                                |  10 ++
 Kconfig                                       |  32 ++++++
 classes-recipe/cip-crypt-root.bbclass         |  37 +++++++
 classes-recipe/read-only-rootfs.bbclass       |  38 ++++++-
 classes-recipe/swupdate.bbclass               |   4 +-
 classes-recipe/verity.bbclass                 |   8 +-
 conf/distro/cip-core-common.inc               |  27 +++++
 conf/machine/qemu-amd64.conf                  |   5 +-
 doc/README.dracut.md                          | 100 ++++++++++++++++++
 doc/README.factory-reset.md                   |  46 ++++++++
 doc/README.secureboot.md                      |  22 +++-
 doc/README.swupdate.md                        |   2 +-
 kas-cip.yml                                   |   2 +-
 kas/opt/dracut.yml                            |  17 +++
 kas/opt/ebg-secure-boot-snakeoil.yml          |   3 +-
 kas/opt/encrypt-all.yml                       |   4 +-
 kas/opt/separate-home-partition.yml           |   2 +-
 kas/opt/verity.yml                            |  16 +++
 recipes-core/customizations/common.inc        |   6 +-
 .../customizations/files/99-watchdog.conf     |   6 --
 .../files/99-watchdog.conf.tmpl               |   6 ++
 recipes-core/images/swupdate-efibootguard.inc |   1 -
 recipes-core/images/swupdate.inc              |   2 +-
 .../cip-core-initramfs-dracut.bb              |  42 ++++++++
 .../cip-core-initramfs/cip-core-initramfs.bb  |   5 +-
 .../dracut-config-cip-crypt_0.1.bb            |  82 ++++++++++++++
 .../files/embedded-crypt.conf.tmpl            |  10 ++
 .../dracut-config-cip-crypt/files/postinst    |  16 +++
 .../dracut-config-cip-factory-reset_0.1.bb    |  36 +++++++
 .../files/embedded-factory-reset.conf.tmpl    |   4 +
 .../dracut-config-cip-overlay_0.1.bb          |  40 +++++++
 .../files/embedded-overlay.conf.tmpl          |   5 +
 .../dracut-config-cip-verity_0.1.bb           |  30 ++++++
 .../files/embedded-verity.conf.tmpl           |   3 +
 .../dracut-config-cip-watchdog_0.1.bb         |  29 +++++
 .../files/embedded-watchdog.conf.tmpl         |   2 +
 .../embedded-dracut-modules_0.1.bb            |  23 ++++
 .../factory-reset-helper-efi_0.1.bb           |   3 +
 .../wic/plugins/source/efibootguard-boot.py   |  86 +++++++++++----
 wic/bbb-efibootguard.wks.in                   |   2 +-
 wic/beaglev-fire-efibootguard.wks.in          |   2 +-
 wic/de0-nano-soc-efibootguard.wks.in          |   2 +-
 wic/ebg-signed-sysparts.inc                   |   4 +-
 wic/ebg-sysparts.inc                          |   4 +-
 wic/hihope-rzg2m-efibootguard.wks.in          |   2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in |   2 +-
 wic/qemu-arm64-efibootguard.wks.in            |   2 +-
 wic/qemu-riscv64-efibootguard.wks.in          |   2 +-
 wic/rzt2h-evk-efibootguard.wks.in             |   2 +-
 ...i-am62px-sk-efibootguard-secureboot.wks.in |   2 +-
 wic/ti-am62px-sk-efibootguard.wks.in          |   2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in   |   2 +-
 wic/x86-uefi-efibootguard.wks.in              |   2 +-
 53 files changed, 776 insertions(+), 68 deletions(-)
 create mode 100644 classes-recipe/cip-crypt-root.bbclass
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
 create mode 100644 recipes-initramfs/embedded-dracut-modules/embedded-drac=
ut-modules_0.1.bb

--=20
2.47.3


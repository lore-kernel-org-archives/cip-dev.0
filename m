Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54023CCF2E0
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:00 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31402.1792405553417919648
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:25:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Wp4crKYK;
 spf=pass (domain: siemens.com, ip: 52.101.84.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLZ60MbfP5SFoR7tqixITgRrbfYcyfq7W0vwBve1bgfOjKgJvoB55KEwh1w2553DQuhy6Q/OmSED+1XuXxuDzCahJptLW4HVo2X49p2KsQhhKub7GScrI+M2Bo1ovmkMAnF7zPPjlv4q7BE6P+V3lTyjCNvrm314D4lGbmSt17swnq8IE7CTEfr1UaQefT0W/rtU5UhoT6jAGJ6fy1NhUycFY8piVYmLlsByoXhzx4e0VwLZzeaMah27Pb0O4Z7bygtftfRAQDkCvZwBkYHxB1U1wHTyeP+yq+KIUhkXnJ6iH/HwMFb/9/fMKiYFsYZ2LDGGg9jC4mSfK9NHPIHl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AYQO+veBS9PYcr3K2vg23NQvI9sXpmmCmfrgqohtQg=;
 b=fdQ3LjjznNeuoaot6cSCYFipo5x/gQyuBa/w4mcmRInZfAShldOsTP6wPtEYGnY7JjCF0FO7KAIsyBUSQKu2JeSwgepO74IUDSLzsaUyE4F2KOqm83T3y5neeJLY9Sftl+OCNhC0y/PzuMND/qMx/+F9YauPKGnPjky8XuE0u6KztGoI1ge6JcE7YylbYW6pSB1o3ryx+Xm/Waj4mFRkvOVen3k1Be4mMeEBMLyvhMxstwBLhm0FrTPL+PTnjtR12AJYLVrp//kCRO3TFxbxbrQ7JRgUY0DKMrhVN5flkjkRkcxLYoPofMAIuyiblTL/u9o6vLkGqId68jfG6ze+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AYQO+veBS9PYcr3K2vg23NQvI9sXpmmCmfrgqohtQg=;
 b=Wp4crKYKTlHwOpQs1pStcVx5d9TQryepLWwHgf/A210USu0/aBUv5Ik5XfEIRvJKBOYuY+7AY2EGxGCXm+BbUMq/ZtHA28eGkqzlWss20ZZPlqdsxpep239wnbvUqVcsOa9ldkni+HN+hHYbvja1t+Ev8lPchKxxzpHlpd/8UAF+OL9d20fzzl9upogIE6tGYH08sRmZSnnxPjGWrjB3UZJb0bh0NjXP9FH8B5UswNB3ubuxm6fBOQCo7S1w7aULl3yBHA95jXhItK/J6R1r5WVRT76jXg1jxHVnYPWzvCDu0llab0Awle6cBO7eg32z12G+VkA/4bqtn8bOxJKqMQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:48 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:48 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 00/12] Add darcut initramfs for CIP Core
Date: Mon, 19 Oct 2026 12:25:11 +0200
Message-ID: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbaa365-316d-48aa-e999-08df2dcb5784
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|55112099003|18002099003|10067099003|261009223027099003|261009221227099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	DTNQiWejx3CE62/4v+Lp/N82LWOOgJ0k55QCajXuFx9e7KaqwZJm+qS2fsaFL9s/tmXDqGiyCv/IvxHq5eVzo37RptuaBNKZhz+dS5F68jaEiKiMxDvzPyrGD43YxYpMmMP1GlY+jXDW/hVgNPw9FQMM62uSk2woAmg4bO36eIBVdus3xsi0DRgLoVqephd9ew+IhHgY4ZpfsqXh9ftX4CEfXakmmGlTIITOtVLL3red1gv7JQI9STsrQhBiZJLKDgteoc+Ge5Add1DNAeT3QP5kXXyjke5BYKOj5PGGXyytN9ZWIjQbdxLp1k6h5AkgscVUwcDzw8u7k4VxeV1yzdK9YV+ohUsUpKWU8GxQC0yGYeP4TygnCROsk98qi/hqHLsiPJJQQE+WeruXOZuqfkPq/WhZhjEKQ6Ge6ApVwaRB9ehPe03FU17IP7hJv6cAx8s8dFA8QNXR1lUcvLTW/oQZWDvmk83EyJYE/RILAcZDK3hhrBI1BLitYpB+DcFUDOWqFeI3tTxtVY2XE8nTR5H17BtHZb+5WtdW0AX/f48CH5AcGXunk6Q1PuFNAVteOR3gELykGrZXztzTdTpe1bE8S6QH2os1t76uJ9Se3Lu1qehW84nhhiD07qL1xjEkS4MB0sMJkQqQFbAvdONpZf7/brG9Lo+YlKAb8HDtjNs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(55112099003)(18002099003)(10067099003)(261009223027099003)(261009221227099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3pn128nV9NzcsNaISrpzIfHx1yRhsB5mTQLaottch5Y7c4wdV9u0H2Z1MZHW?=
 =?us-ascii?Q?v2ZCRnC9wSrsCmsgHrjXFY6hlTxUyVu6gIDN4upsGvy2G4Nkl380thBSWdjR?=
 =?us-ascii?Q?LjWJjcy5zi4ZLFyCT+lY9PhLRLMZ17jtCevD8OF9FzhBtcK+hzIfH+S+BrY8?=
 =?us-ascii?Q?Skqoz2xtmXxP44EFrXar/5uxIEiF839TkH1pywzYAePNixJCoi2kIkCVL08C?=
 =?us-ascii?Q?Z5r2v3islHE5iXbtti7jR+fAUKZyNXdZIEKdIylTVhYaOhYvQ5YGix8hBXoI?=
 =?us-ascii?Q?Ln6ou5Y4iR9xXud5m2AYMRFOOyuzlarL1k/XowHlWl6ukRc8xvsBwCZS2TN6?=
 =?us-ascii?Q?TUfSITHMh0CTYxgXz11ffApUS1HStExEi2u06K8kZUP4YG+ZbDNTQ0zUp+8D?=
 =?us-ascii?Q?o14SjNwuiD7O6+8q2+Rm69X2R8l/ZwP2QxIFPDr76tziz20tc6RfwBmGuzR0?=
 =?us-ascii?Q?pXRgQcaSKZUxEc4ySIutDYdm3sccCVzRs/tpPFlnbgAmsM7HvB2LDnqnsWhm?=
 =?us-ascii?Q?FUTrCvZckTr4D4Pk+SyUugmi8rzVETO04ypBKn6Wx11YrEV5dp7/usdrVJl2?=
 =?us-ascii?Q?AO/CPo72vNlhiYAobcthHuMNjLp1vX7tbbeuZiWL3CO85q/18Is99IvT3dEe?=
 =?us-ascii?Q?1V5sFyST6QWb5TLfNrVIGRGJlz05dSiW0+wDgLlckU9T3PWCoVlKreJxJW4T?=
 =?us-ascii?Q?fmFuEEtcyCOS2x2h/pb4SmMXE4T0V7m9PGm+TWw+k+3pfTRQehQ/0h14lSNR?=
 =?us-ascii?Q?zFCinOpOGd9GDBGZWBSvdx3ZFssrWc6Gbf1yAEryDRgouXoIBl7x+Lj/OVuH?=
 =?us-ascii?Q?ZeYUB87ogADROUxlejJrG6dBEwql7pH6F/BYbzR541ePUl2fEAfwn0aVCBqF?=
 =?us-ascii?Q?gf0ofo6M5uEShWJ7KH9rMGelkAa+sXfpUGGCJKvAjogPCjjQBOqvs8t0mgZm?=
 =?us-ascii?Q?UExj9Uy7h0vbc4NUWU1nVX20rUV8fujdUvhUkbsLPhtKPnr2D9+hpApEmxGJ?=
 =?us-ascii?Q?1E6RGlJ29ccIpkFXmXOiJeoSWhjwg6x2hMkUC/HZw0/az5jMFn/nqvm5U9hJ?=
 =?us-ascii?Q?K/hHWDiLCWYCTnyNDONdUqddzLmcweTHmCSNGNEBpAJpPGFKcv8xIfIzmw40?=
 =?us-ascii?Q?7ecqCvBbFgDnaB1XXVsnO1NsqMPdG/5ZD1hFXUGanPDcPi/QWjw0iCvS6Jxp?=
 =?us-ascii?Q?mHGrpjBtBNUryEApKvy6sRIo78isMUL0u10HjJi48qJ94Dw/sXZ9BFSdtHPs?=
 =?us-ascii?Q?apHMsfx6mAV4kGEE58KXp6b/V2Gbz28AanR9ttuOANBzYozbGkKpy1Dp4ZCM?=
 =?us-ascii?Q?dlQWIocD7okUDfhkHOjHA3kbQiuPDkcl6CrMIyZvqqGPPf8XKkSVTmlAklpO?=
 =?us-ascii?Q?q94BmoAa4oDVlRY3NQ1ZJoXCBW84FNbOvWQm8+J6ShsEis96CGKJzY9a6yTg?=
 =?us-ascii?Q?ygQFd9Tf5b2GpcZhjOXQwaqAEffqrVc0X571LYN6Mh21DTiRvuwvV6sRkxSZ?=
 =?us-ascii?Q?4jkONUyCa/u+k35AHdQlkThz8ewVvKFO59TBi9GqYt1wJJOzrMuibQHmNvBV?=
 =?us-ascii?Q?6Ff6sZtn8ECeQqwEJxnGZyR+SWkr1g2XqDyvXqg60fR28fcjcri/8sbDHjga?=
 =?us-ascii?Q?L1yj0zBJKzpLsV1HrkmfoJqC2xAirfgFmxywpAypjIeVv8SHlM4RBtMg8Mqg?=
 =?us-ascii?Q?2BeT+VXHeklcsdH5FMJxi19NAsGKsy+SWUdkZsqB0EZvC3x7OfHpRCCxtxR1?=
 =?us-ascii?Q?QaiHVND1dwhVLPXIZgbhwbN7Ch4PfrY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbaa365-316d-48aa-e999-08df2dcb5784
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:48.1838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8muYk3mL7cGIfXthSt3+J1TINXSuUjTlSBKpRX8bz0cFrT0JGLpXpEt3n2GQV4sxTS5lR9GDpq53BDvG7bPcY3TeA5VDF+e27GOgXB8Lsvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24481

This series adds the necessary recipes and configuration to build a
dracut initramfs for CIP Core. The initramfs is used to boot the system
with a read-only root filesystem, and provides support for features
such as dm-verity, factory reset, and watchdog.

The code for these dracut modules will be stored in a a separate
repository the make the maintenance easier. The repository is located
for the RFC at
https://gitlab.com/cip-playground/embedded-dracut-modules.

I will use force push on this repository until the development is
settled.

It only supports Debian trixie and later, as it uses systemd for the initra=
mfs.

I tested it only with the isar-cip-core build it should also work with
downsteam layers. Please test it and report any issues.

Changes since RFC:
- Added a patch to load the watchdog drivers early in the initramfs
  this is needed to load the iTCO_wdt driver for kernels if the watchdog dr=
iver
  is not built in.
- Allow verity based rootfs with secure boot disabled. This allows to drop =
abrootfs
  for systems with dracut based initramfs. Also in case abortfs_root=3Dy
  is set together with dracut the wic plugin will automatically generate th=
e verity
  based kernel commandline.
- wic drop adding panic=3D5 to cmdline if dracut is used.


Quirin Gylstorff (12):
  swupdate: add RO_ROOTFS_VERITY to select a dm-verity rootfs
  efibootguard-boot: emit systemd verity cmdline for dracut
  wic: select the A/B rootfs image via WIC_ROOTFS_IMAGE_TYPE
  embedded-dracut-modules: add recipe
  dracut-config-cip-*: add build configuration packages
  factory-reset-helper-efi: use systemd FactoryReset variable with
    dracut
  cip-core-initramfs-dracut: add dracut initramfs
  watchdog: use the rootfs systemd watchdog timeout in the dracut initrd
  Kconfig: add option to generate initramfs with dracut
  read-only-rootfs: check dracut verity and secure boot settings
  doc: document dracut initramfs
  cip-core-initramfs-dracut: load watchdog drivers early via force
    drivers

 Kconfig                                       |  15 +++
 classes-recipe/dracut-cip-config.bbclass      |  54 +++++++++
 classes-recipe/read-only-rootfs.bbclass       |  25 +++-
 classes-recipe/swupdate.bbclass               |   3 +-
 conf/distro/cip-core-common.inc               |   8 ++
 conf/machine/qemu-amd64.conf                  |   3 +
 doc/README.dracut.md                          | 111 ++++++++++++++++++
 doc/README.factory-reset.md                   |  46 ++++++++
 doc/README.secureboot.md                      |  10 +-
 ...acut-module-add-DRACUT_FORCE_DRIVERS.patch | 107 +++++++++++++++++
 kas-cip.yml                                   |   4 +
 kas/opt/dracut.yml                            |  17 +++
 kas/opt/ebg-secure-boot-snakeoil.yml          |   3 +-
 recipes-core/customizations/common.inc        |   7 +-
 .../customizations/files/99-watchdog.conf     |   6 -
 .../files/99-watchdog.conf.tmpl               |   6 +
 recipes-core/images/swupdate.inc              |   1 +
 .../cip-core-initramfs-dracut.bb              |  46 ++++++++
 .../cip-core-initramfs/cip-core-initramfs.bb  |   4 +-
 .../dracut-cip-force-drivers_0.1.bb           |  17 +++
 .../dracut-config-cip-crypt_0.1.bb            |  86 ++++++++++++++
 .../dracut-config-cip-crypt/files/postinst    |  10 ++
 .../dracut-config-cip-factory-reset_0.1.bb    |  49 ++++++++
 .../dracut-config-cip-overlay_0.1.bb          |  44 +++++++
 .../dracut-config-cip-verity_0.1.bb           |  23 ++++
 .../dracut-config-cip-watchdog_0.1.bb         |  30 +++++
 .../embedded-dracut-modules_0.1.bb            |  21 ++++
 .../factory-reset-helper-efi_0.1.bb           |   5 +-
 .../wic/plugins/source/efibootguard-boot.py   |  67 ++++++++++-
 wic/bbb-efibootguard.wks.in                   |   2 +-
 wic/beaglev-fire-efibootguard.wks.in          |   2 +-
 wic/de0-nano-soc-efibootguard.wks.in          |   2 +-
 wic/hihope-rzg2m-efibootguard.wks.in          |   2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in |   2 +-
 wic/qemu-arm64-efibootguard.wks.in            |   2 +-
 wic/qemu-riscv64-efibootguard.wks.in          |   2 +-
 wic/rzt2h-evk-efibootguard.wks.in             |   2 +-
 ...i-am62px-sk-efibootguard-secureboot.wks.in |   2 +-
 wic/ti-am62px-sk-efibootguard.wks.in          |   2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in   |   2 +-
 wic/x86-uefi-efibootguard.wks.in              |   2 +-
 41 files changed, 811 insertions(+), 41 deletions(-)
 create mode 100644 classes-recipe/dracut-cip-config.bbclass
 create mode 100644 doc/README.dracut.md
 create mode 100644 isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVER=
S.patch
 create mode 100644 kas/opt/dracut.yml
 delete mode 100644 recipes-core/customizations/files/99-watchdog.conf
 create mode 100644 recipes-core/customizations/files/99-watchdog.conf.tmpl
 create mode 100644 recipes-initramfs/cip-core-initramfs-dracut/cip-core-in=
itramfs-dracut.bb
 create mode 100644 recipes-initramfs/dracut-cip-force-drivers/dracut-cip-f=
orce-drivers_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/dracut-config=
-cip-crypt_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/postins=
t
 create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/dracu=
t-config-cip-factory-reset_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-overlay/dracut-conf=
ig-cip-overlay_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-verity/dracut-confi=
g-cip-verity_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/dracut-con=
fig-cip-watchdog_0.1.bb
 create mode 100644 recipes-initramfs/embedded-dracut-modules/embedded-drac=
ut-modules_0.1.bb

--=20
2.55.0



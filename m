Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D8CA5FC4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:19:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9457.1790939991891002964
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:19:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Zf+ZAy6s;
 spf=pass (domain: siemens.com, ip: 52.101.84.34, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr6dxeqP2LYesmJM2lOfxMPcw72NcxSPQi2UR6B69y8j5qJsGrCHZHGghmYHTnn5N60BuF1SDauXSorVWuK/I4udm+BF+ZpkPvx8+S4+wo8wM8Romds5UVc/MyWNCZErYf+XJTrrdHkkSuMJPGXyDTWZJHJLTm2zYDUO+5Q8rty91+dRvZwAmjCFQkNWZtJ81rnWVJE+dZaGFfJkgpdPmXzs2ogFok+IVorKa7htl5QjeHojWmyRc71AbXUayAbWf2a2AfBKGF7cC3D0bfhlsHdtJxfDc8SBch9xOdyTm7eL73wQptUd7uVOo5iQd3reANTNf+ulzNiVkDLQUGxXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR4DWBQH4oFiACUP+krhxCvpHprh2u7nvn1VHxWmCaQ=;
 b=MW3jSHbq0E6VQea03S+6xAzIP8UrKsSTC3nWB8WkBpJnxKswIdtMSq9Hbo3JXCjvZrrfdS98IfkGxjcm2KWdgNaK0tNIK4eQnL0tUmgvX8flZlJWfp9I75MCkIb+g9M+HYOThy82i2+fJiO5OecjmE5YeALBeDwnKhAc7pvky+Pk0DqaPN/Bd7+yEK4zSFjPoY62Gf1uhUHN+rpkvEWJwa0AznH5Af96yMmKBiFHTLcvwAi+iceqeTtiTr/KG/xVdupLHk3R6tLVw+Dj8B0LFfANyUgVBcm25+WB6U8Pd6Pm0XAoVuEjFgdZjrsnjog8xGADYuZIAWv1lLSMQMreKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR4DWBQH4oFiACUP+krhxCvpHprh2u7nvn1VHxWmCaQ=;
 b=Zf+ZAy6sUO8VhbAl3DuGfrCF1N3kuUKqVjQvLOLzNBQMygE5NfLu8dzBhKdCbXVWRj8/suRvSaxrqWhHgAHVOqejjoLfMURu3slTBN6QepIbExP/O360vLWwlCWyDTX4c0ehsui9A96MlwbXYX9MIWPtIF+hqu+0QzRZTdEP1OyNvKkQqZwdtY+1D8IwmZhmnCX+Hq5o2tB4vTlR6UVc56p1CntRfCkwNecAr1vu9e7XlplhR3tsAaT516E5j5V+B5lqSFSbkxz3v+HW3tqy1RQakRe/8yeawn/v3TFCW6g/6D8l1CEYR6q5Jfo4Z0XseLRI8CbXugSwynwnV13fnw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:48 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:45 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 00/11] Add darcut initramfs for CIP Core
Date: Fri,  2 Oct 2026 13:18:47 +0200
Message-ID: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: be35e4de-03c7-494a-01b2-08df20770ffd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|11063799006|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	g/iPuO7c/Y4Nk96++mRzcpeUhmdolgXIb7JOfp9QerNB9DbzIkM5gjDpiBf2q4EBPbm54AWrUk5FHtTZXKLO5huxacL6S38ZE/35Rt2lgRQdvgGxTJrPTBFnjtpxno/O6V7YKKnc5V1HkFGK/imKk0Ey24KyQJZePNow2cTikV+1CbWm28L/GCkaP3Mf1CG6glKbu+cSJu6m/8MgjO9iORDkfkr2mQbCdGM2Rq/iMvJ1L2hvzoeHh1/8FOUi3PP0Su4H2DwR9we26jV/78n1cA6KVqCn94H8aJRFzxOjSpQ+shCWDpw2X/dR+byqZjt5IVpxtd+p9UnUrXPuI95ml6/L/HNfnMU+9dL7rPY1Gx0fVjxPD1e5I2QK8ctT4ObeGq7OSLBylEQQu86mwV9qjqsfB8q+nuIfCAzqYITOlKswWCWPkR1JEys+N4zpkkj8bu/2lpcaGzoLm7Vgfr+POCB/6JBa6vSpCLA8MUb2OMDcI64mPyUekxSAU1RmEYzBAa/TVS6Cr7c6mfotAMufWtBT/JyTxW9BeFj8bsp/qbE74SiCqhBttACTnJRkJbn1o33VfVOzllM6pCvLYA6zoEyqGl7C/IzP/n1ThmceFOQQfC3tz0bofMILvCH+elV5pmWQjFvXf9ncbrf1TNFgjDFcMAE00AkFrH39J9l1HPU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/FyXW3nqRktDaeyUmf12ThMfnp5W5rCT1J+k67ggt+E9iRp/z40l3cN2qT1n?=
 =?us-ascii?Q?jeHoPjr8nd5chKh1kFSu5otFFaRPWuqaDYMJ4fA8+Ifsq/bCaHSdC6vY6BPe?=
 =?us-ascii?Q?vEgx2tkIrFGPEZ3o93OfiAzt5UbygD1MnS/Gh8d6+ZQUML9ySZ4y1bfLoGKp?=
 =?us-ascii?Q?QOboksYntXriWJJZkLh00b8eeD2aIMbov7D4S9IUhXL6kV+eL7DI+ZV8nUPt?=
 =?us-ascii?Q?ArQs80tXl1HD+lTnmNuBMD+sFSQdDLRIW6ibDhoMmMIjtrDN1gpAuUg/9EJa?=
 =?us-ascii?Q?2nIk+dTlXI0rSk0R7k4eFLOB4IuU1hjkwg3Wpx1opSRwPkI29342uph6oBwj?=
 =?us-ascii?Q?KiFyIZqmnQT4R7Tj0xRnA19N8i1V22WtlsPba7Dh97lpzj2Um5pOmmFDwYuA?=
 =?us-ascii?Q?CapbNhPdbKQAnYn3YS8SR0672XnzwGSYweUm4ewQbCk6Eg9R+rp3dP6rEuin?=
 =?us-ascii?Q?qSJdiQvcJ6ojCFIehHhmVB0A2rgYo4N+0tSleBCGOVwM7dd6R5jTIDtUGatG?=
 =?us-ascii?Q?MdKXvoapRlIxQ3oH7tuSKG5iLjNLhFEbb/3CLkbNzkLUNTsIfEuclMFI2ZMV?=
 =?us-ascii?Q?eLf6L+5wRr+YWEJzUVaLZBhUoirIPokIB+7EcAO0NMRSZuWb8JmF8xpkTMFW?=
 =?us-ascii?Q?D6Og/FgEvnYE2ZoD5OpRZzu82JOEln9T2dNmH/d8yCebJSFqASNZu6PGYx+o?=
 =?us-ascii?Q?5os/Zhd/HRC1NXGiQJ7YFEg+G5Pb6Hraxpv3f2oPMse3kFgJTjGRgaJajRcz?=
 =?us-ascii?Q?fzzMIiKo8F+u45PhLgoaBsigLAnIvYJNLTuoozbwQRmoBk2pQ97cSjVzaJ2J?=
 =?us-ascii?Q?hBwLba+1C79WrUtOg6kNLtLS+KL2IgZU/judczfsD8dJBV5YqrTEtb3E5ePl?=
 =?us-ascii?Q?C9jUdNz6BXdeCj1gBekHOqTid13sZ8Fe6rVp5xZpYE4W+xnMngR7kwO60Fd/?=
 =?us-ascii?Q?GW1bAshLdsR5Jcx0IiUGbuNoIcJJTaCOYKK6cQ/0vAlybISVdNfBrDWw3lOe?=
 =?us-ascii?Q?vxFSr7xvLxwHmTT+07tPXzNbqA2YotkliOgzJ5Z7bGwHtJMgu3QdAGJ3zN81?=
 =?us-ascii?Q?vNNBHjEcnW9E8CbLdbS7mQHYXX2SbvtBFYU1lElSgifjySooDzZEV+DPD1u0?=
 =?us-ascii?Q?lVjMSsv/amBghUQLV1ppF15miv69BTl9/GPJ7gs3FOX3BPIomAUYlRzYhhqA?=
 =?us-ascii?Q?+D2N2uInZO1erwhbPqnysuwfFujr+HvgDJiC2J4DxndGa4QhizTu5F99JOWV?=
 =?us-ascii?Q?HFYD07KbFVW9Am7CgsiAnJoejATZJTEUkgU337N2DeQiPf/lJgXk8nE7B8IR?=
 =?us-ascii?Q?6SHMMl09ZW8k5j5UlKI1jw/hqwiEHetF19F4Qk8yqmWnwnreBApG3bLcqa7J?=
 =?us-ascii?Q?N9YOp0WEbHssxEgS6evE9NgV/2evgtQOluVbXiv5Unga9yBcB8pvl51NqxRz?=
 =?us-ascii?Q?Onc/AuGt8MovH3KP/28pS+VC6v/vsegYB5rrlmx7NV7gFOGY9WYvs3W0vUku?=
 =?us-ascii?Q?9fW6WQQdqPoqcGswRNDVuvlEazlDIYEPdqZKtjLcJq+wzb5MKimdu9GxKWIR?=
 =?us-ascii?Q?lkTQ3WMZu9L5DwF03xtma7Qcz9FTGj/Dn+GSkg0YkFGkDkwX8I/GTQClNat8?=
 =?us-ascii?Q?ZvP1y43LB4RJUV4JiUrzqCJhHb74eY00Uumeu/ufG+f9B5oWaDcD6nXejznD?=
 =?us-ascii?Q?gcRX9xVkGfI1nuftoJ1K+9Q2MWAC6oc3OKZ0DVlQvLbF6phkGgiaco+KwzMJ?=
 =?us-ascii?Q?ehWwT6d6g49I+ny7+Vn5d/Fx5IaV980=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be35e4de-03c7-494a-01b2-08df20770ffd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:45.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxx37VPBlWLJE8fabwchSI/3csoKy7pm7n58N6ZEMZLxVuGbvR82+MhSKotBDwJc7o5/u9s2KvSvSeDuEndgsaY9VY5PXIRoyTi8W/Z/EW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:19:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24403

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

Currently know issues:
- The iTCO_wdt kernel module is not loaded in the initramfs, which affects
Debian mainline kernels. The linux-cip kernel has the module build in
so it works there.

Quirin Gylstorff (11):
  Update Isar to next
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
  doc: document dracut initramfs

 Kconfig                                       | 11 +++
 classes-recipe/dracut-cip-config.bbclass      | 54 +++++++++++
 classes-recipe/read-only-rootfs.bbclass       | 12 ++-
 classes-recipe/swupdate.bbclass               |  3 +-
 conf/distro/cip-core-common.inc               |  8 ++
 doc/README.dracut.md                          | 95 +++++++++++++++++++
 doc/README.factory-reset.md                   | 46 +++++++++
 doc/README.secureboot.md                      | 10 +-
 kas-cip.yml                                   |  9 +-
 kas/opt/dracut.yml                            | 17 ++++
 kas/opt/ebg-secure-boot-snakeoil.yml          |  3 +-
 recipes-core/customizations/common.inc        |  7 +-
 .../customizations/files/99-watchdog.conf     |  6 --
 .../files/99-watchdog.conf.tmpl               |  6 ++
 recipes-core/images/swupdate.inc              |  1 +
 .../cip-core-initramfs-dracut.bb              | 41 ++++++++
 .../cip-core-initramfs/cip-core-initramfs.bb  |  4 +-
 .../dracut-config-cip-crypt_0.1.bb            | 86 +++++++++++++++++
 .../dracut-config-cip-crypt/files/postinst    | 10 ++
 .../dracut-config-cip-factory-reset_0.1.bb    | 49 ++++++++++
 .../dracut-config-cip-overlay_0.1.bb          | 44 +++++++++
 .../dracut-config-cip-verity_0.1.bb           | 23 +++++
 .../dracut-config-cip-watchdog_0.1.bb         | 30 ++++++
 .../embedded-dracut-modules_0.1.bb            | 21 ++++
 .../factory-reset-helper-efi_0.1.bb           |  5 +-
 .../wic/plugins/source/efibootguard-boot.py   | 36 ++++++-
 wic/bbb-efibootguard.wks.in                   |  2 +-
 wic/beaglev-fire-efibootguard.wks.in          |  2 +-
 wic/de0-nano-soc-efibootguard.wks.in          |  2 +-
 wic/hihope-rzg2m-efibootguard.wks.in          |  2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  2 +-
 wic/qemu-arm64-efibootguard.wks.in            |  2 +-
 wic/qemu-riscv64-efibootguard.wks.in          |  2 +-
 wic/rzt2h-evk-efibootguard.wks.in             |  2 +-
 ...i-am62px-sk-efibootguard-secureboot.wks.in |  2 +-
 wic/ti-am62px-sk-efibootguard.wks.in          |  2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in   |  2 +-
 wic/x86-uefi-efibootguard.wks.in              |  2 +-
 38 files changed, 616 insertions(+), 45 deletions(-)
 create mode 100644 classes-recipe/dracut-cip-config.bbclass
 create mode 100644 doc/README.dracut.md
 create mode 100644 kas/opt/dracut.yml
 delete mode 100644 recipes-core/customizations/files/99-watchdog.conf
 create mode 100644 recipes-core/customizations/files/99-watchdog.conf.tmpl
 create mode 100644 recipes-initramfs/cip-core-initramfs-dracut/cip-core-in=
itramfs-dracut.bb
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



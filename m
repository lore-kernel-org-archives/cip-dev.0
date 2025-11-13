Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DD8CD5BB3
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 10:14:37 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com (BL2PR02CU003.outbound.protection.outlook.com [52.101.52.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20427.1763028876527805867
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 02:14:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=MEUIuvyU;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.52.26, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkU+vpf6EzBQn5nS+KVE4EijhB6c0W9cDzb2UE9xk4XjUNHqy6Wwatbklmeo0bbuoKJoE1PoW3v6Vbo2OzzJJtLuiZh5cOOscUIi6WNSUIuxbWs16w9oAS3K0aNhcjTTl9JbeMQD/cLewXRTJsv2SofalTQEUOh7VLUPzDg3GKa29CWjfYVWDcPc+0uhRzJkkeLn7fw2bZjAXhTDsgBnZo9h+rrXCgj9Xl/dhNEVSDDWeQpWmTa9q2Dyxw4ltqaqPv11s0AsLCp2+cTIAPmVYc02WdHBJC/z3uedeFG/HEhLnWuaBOIoi1urI9STsb8p26ukG84NcMDBNtBTUTROtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmXlP3uf1QYihvqBaBFV3zI/ItyxhsvmQdHFZQry2Sg=;
 b=rLO/X1H7/z1hDzzZcbCIrcomO55Qw2DRNMCD59P3zYHi0yCt035PH2BkcfFEPH0I7xYpEV0aCdcKC/wxPi+UUrIxk5wfrPIE1nQOCKCBLJeUO39eQc1Y3pN/ULc1KTJKciupdioieWGb1Mo2kClW+j0sY+Q5q1Kqsb59IoIjvIJSAua7d4pJw4F4mRLtUH02mGmQH6WSDNyFgIrc5OlwF/qyenZuJ8wcaFcrobO/ERb0sjd+cGA9GR5keAal8Gt2vpOP0asVNchsY3vL4ErCMv0KH2BfDW+R6iVLJpLmtAck5f8ltLcrb1r4n6xAG7fdBoKBCC+e58oaG+Haw1usVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmXlP3uf1QYihvqBaBFV3zI/ItyxhsvmQdHFZQry2Sg=;
 b=MEUIuvyU/dDTb1/PBitGsqSC2tV/0fZPJ/+deZNbSMGaEhsI6B6aBuFz7unzV/R5fzEbDKxObBZdKJd8G9lWGBAM4Uy9wOsAhlENkLHgB1KfJSWw/gg1TR+K3GWxSge6n2pv7V83Iuiv1pl0GVBaYXnva394FrZqldmhMuGZMB8=
Received: from CH2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:610:50::12)
 by CY8PR10MB6444.namprd10.prod.outlook.com (2603:10b6:930:60::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 10:14:33 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::df) by CH2PR16CA0002.outlook.office365.com
 (2603:10b6:610:50::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 10:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 10:14:33 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:14:30 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:14:30 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 04:14:30 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ADAES1P058943;
	Thu, 13 Nov 2025 04:14:29 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v4 0/5] Add support for TI AM62Px SK platform
Date: Thu, 13 Nov 2025 15:44:20 +0530
Message-ID: <20251113101425.1177129-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|CY8PR10MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f7fc82-a770-4709-3101-08de229d7101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ao6LiL5gyWGcu+waTtzVwUTww8wrXNp6/NJKRxDf6+VwdOD9kd4/01c03/Ap?=
 =?us-ascii?Q?eENzeHgPFPmiMjWzxc5l95TZhEVpeLyE+RS0xXa6x9PYo3KZ8kzsJHz1Y7CY?=
 =?us-ascii?Q?pxMRiPDKXeg1f+i6xT+kfUsDoFEdV2LHJmqlZolqk/KOkXo55wyqK4l6b5q8?=
 =?us-ascii?Q?6V0exHA0ESz9O9gE0/+seX1S2Mt1bQfwQRlRasFsTJ5W/ircRzj8164vXeOp?=
 =?us-ascii?Q?elBy047JQKvij818IbT3mopIeIU+U8ohtqHT6fpuEba9BjsiljOftJxAmLkm?=
 =?us-ascii?Q?Fh18YQ9bx43PcSutk3GKC828xIbT5SFoPOCcnP+n04epJ9RsWlnL1p0obbj+?=
 =?us-ascii?Q?QFxolZAg/bx+DM67IFdsGEQOmijRya1jWDvVBYtr+wKDeH8LbKPepM/C3ckA?=
 =?us-ascii?Q?IfA1dAfKvyUoJO5e4eXQ4z5lZjmaNS9YmGpupeG0Il3K440QnaRY7yjD5f95?=
 =?us-ascii?Q?xySuJlxtbINUcLFCHtx40n9YUbDEMy7bgcocbDm+EpfUQ28aJ9PGMNomQJ8V?=
 =?us-ascii?Q?I0uyykRbLKW2PsQd1qZNn2BXJc7W9c2+jBuBELHSqDJ0xuciNFN4zR8rQF5o?=
 =?us-ascii?Q?aRKA/57ASHc0AM0To/TeMZhs6NEjxPd1RpvFgCa4hOvY3Ma1fE4oJSPTrc/C?=
 =?us-ascii?Q?F8m9jxUZyfA4Rl+2Z35jVNX3OO43mljNf2yNrOQ2LaRmlez5EaZgOuZRDI8n?=
 =?us-ascii?Q?OyZqGKPDx+LGnVvEQqK2mKz47XJFRZ+X64MvjC3jJz/agOsBlNjKzRjt5guq?=
 =?us-ascii?Q?sMb5ihWQjnUIAnq2td5xT7GpRW2skmlUUby5Kk3MxWi1LfAp1eh6gKLl5cXc?=
 =?us-ascii?Q?OU3w20LVfEhm5HHnoxdlkDt/rHtTJU9dwTS0gI1b7lDzJXJ5vS9+QKox8pEk?=
 =?us-ascii?Q?HUq2WZuvtO3rhwMH+XRWcHovIsQTcIwAret11OJoEQs499Mu1Zo4Fn8LWfph?=
 =?us-ascii?Q?ZVZOrQndZDjFqXHuDfcCAvkVw5cJfSuX1Lm9hYbEJxHGTghWtDAUC+dwwA1i?=
 =?us-ascii?Q?vXfVNrwlAg+zR4hqhl7RWJ8cblOgRyWQORSu//gxUBz3wgRqz21+TDEEY1SS?=
 =?us-ascii?Q?JK3jprjWUbABt8/jHB9X9k40geRlNv7GFbyGESFvHHRvHh5U+PXKcjc6FFyp?=
 =?us-ascii?Q?8lBYugLd8e8z6XPHA6Ga93D13yAFhX4gIw100+ZFVBs150ru9vJyMriTMZT2?=
 =?us-ascii?Q?7W690MYz66ZmZDSm/0h4inedvTPILSKnkV5YV0+tkUDJ1cfbiqWk6U41rD6m?=
 =?us-ascii?Q?XhEb7KL8JRI+1Y6IdSTA9e3YwomczR28ZTIOX9tK4Wv2ow33KVZRhd6+aM3H?=
 =?us-ascii?Q?ex0rhtEJoef+G7aYxh7WWu32ubVDXXL6MP4Bbaxkfblfx4KS2Rt5H9kfrjfl?=
 =?us-ascii?Q?Z1BqiDv4kmVkPgQyVa4O5lTmIKe79n2AD7EgMv47UHHyvqkJ1XmOIXNAPVt4?=
 =?us-ascii?Q?SUICIGcAi/MJtNsXZ5YQThYfK/Xo1zH3ihYtfLQJpPK7UcnbYSQQFlwRAlsT?=
 =?us-ascii?Q?8TjqAErVwD//gQCqsKC/0XXXYyj7Su7XQKs/eW1emPXSeDbpaWlkudqRq9km?=
 =?us-ascii?Q?TB/YzFXt3B0sk3iQRMY=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:14:33.3850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f7fc82-a770-4709-3101-08de229d7101
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6444
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 10:14:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20522

This patch series enables support for TI AM62Px SK Platform.

Changes from v3 to v4:
- remove redundant lines from ti-am62px-sk.conf
- replace u-boot rules-ti.tmpl with already transformed rules-ti-am62px-sk
- remove setup of static UEFI keys in u-boot rules as StMM support is alway=
s
  available
- merge HAS_DATA_ENCRYPTION & HAS_FULL_ENCRYPTION into single
  HAS_DISK_ENCRYPTION option
- fix shas for ti-linux-firmware binaries in u-boot recipe

Changes from v2 to v3:
- switch to optee-ftpm
- use github mirror for ti-linux-firmware instead of git.ti.com
- rebase to next (8b7ce66a)
- enable fTPM + StMM mode
- Improve modeling of security features in Kconfig

Changes from v1 to v2:
- Remove initramfs-ti-k3-kernel-modules-hook. All the necessary modules
  are already built-in.
- Update u-boot patch to enable KASLR with upstream version.
- Add custom rules-ti.tmpl for both optee-os and u-boot.
- Update u-boot recipe to add additional TEMPLATE_VARS used in
  rules-ti.tmpl
- Remove u-boot patch to add microsoft-ftpm node to devicetree.
- The series no longer depends on kernel patch to add microsoft-ftpm
  node.

Sai Sree Kartheek Adivi (5):
  Add support for TI AM62Px SK platform
  ti-am62px-sk: Enable SWUpdate support
  Kconfig: Improve modeling of Security features availability
  ti-am62px-sk: Add support for secureboot
  ti-am62px-sk: enable data encryption with optee-ftpm

 Kconfig                                       | 36 ++++++++--
 conf/machine/ti-am62px-sk.conf                | 28 ++++++++
 kas/board/ti-am62px-sk.yml                    | 13 ++++
 ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 ++++++++
 .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 ++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 27 ++++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc | 33 ++++++++++
 .../trusted-firmware-a-ti-k3_2.13.bb          | 22 +++++++
 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 +++++++++++
 recipes-bsp/u-boot/files/rules-ti-am62px-sk   | 33 ++++++++++
 recipes-bsp/u-boot/files/ti-extra.cfg         | 19 ++++++
 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     | 65 +++++++++++++++++++
 ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++
 wic/ti-am62px-sk-efibootguard.wks.in          | 23 +++++++
 wic/ti-am62px-sk.wks                          | 15 +++++
 15 files changed, 412 insertions(+), 4 deletions(-)
 create mode 100644 conf/machine/ti-am62px-sk.conf
 create mode 100644 kas/board/ti-am62px-sk.yml
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-=
ge9fc7b8.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3=
_2.13.bb
 create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-s=
upport-for-K3-devic.patch
 create mode 100755 recipes-bsp/u-boot/files/rules-ti-am62px-sk
 create mode 100644 recipes-bsp/u-boot/files/ti-extra.cfg
 create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
 create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
 create mode 100644 wic/ti-am62px-sk-efibootguard.wks.in
 create mode 100644 wic/ti-am62px-sk.wks

--=20
2.34.1



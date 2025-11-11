Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A8CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 16:45:30 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22179.1762879524714520478
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 08:45:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=Oks/ZakO;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.107.208.49, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqhBUUXPnO2ZA2QQLA8GABGjlMB6VUv/MwktLlc+YaPFh7Lb4Ijav3+E1yp8CukUcdzx2Gv37cFutBh7IXhjK5XbPqwssxZBPZfTqKPttyveYG+22oNNmWACPX9tGy947/0mPkeRqTb3Ep1s57SvxFtOT3AG3JV8JIHOjq+twDqr/qPf/BMOSiPzrlZGsV8XOQj7Q/MfRQ0sGkJ/oEhrDh96DhBgQn4CeYNnAyY8TZMxghRJ4dKhBApXAqjNunhxoFlyIn/GFOkC6lRh+2N982Ic8r3ByuH5/ztiF7HNwtQHFFLVBWuzStr4JqMg5f2YjL5VVig2lKuDUexlTop4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrNrIn32klFpx5lUdKKHJJ48GEDEF0ssEsQ6W57GBEs=;
 b=lzacVdouU6W2Gp9BJns2UQ9IcoL3E54ObpuZaFyqDSsLpRanpVWDUxPpmeQz7ZEoA9M62UGSWyteAPLLgxV+DZ88GST2CfRxukoZPzHWC4uIqpVm5cxhGhdL3Vo0Au+sQiASWjnFyA5C5Za7xAGNFOxSE7UPuAAOUBuXpWocZYqMt1doKvtGvqUm1v1axXpX7iCNOaoVGNAuXr8BJO1FDYE1IYhcB4/rTGRBy66S2Su3fJL/NqDvibmFsTljUi4X1v2z6euHhbBLwTBuISOW8z8le/gkZoe+wqddP6+Tg25CDF9KrICux0viZNItSyXrTj1uSufgedE+sl8Qf79AEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrNrIn32klFpx5lUdKKHJJ48GEDEF0ssEsQ6W57GBEs=;
 b=Oks/ZakO1fZhOzZtQpJMN1dxLptSFI+oTr/gneowGWgw0U642EiCoL9jM7KCKaELsMMhbX0E6C1PnvkFCh08cakNxQFNidf4BnOorPvyqUEy94FO36Ia0FkNYS/eMIQUrljuBmLWf4RbClPF2ea7jkZKib/3+7DszKzstUBUz0s=
Received: from SA0PR11CA0067.namprd11.prod.outlook.com (2603:10b6:806:d2::12)
 by IA0PR10MB6747.namprd10.prod.outlook.com (2603:10b6:208:43d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 16:45:22 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::e6) by SA0PR11CA0067.outlook.office365.com
 (2603:10b6:806:d2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 16:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 16:45:21 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:19 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:19 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 10:45:19 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABGjH9C1255613;
	Tue, 11 Nov 2025 10:45:18 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 0/5] Add support for TI AM62Px Platform
Date: Tue, 11 Nov 2025 22:15:03 +0530
Message-ID: <20251111164508.1707234-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA0PR10MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd8796d-c750-4506-a6a8-08de2141b444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/edjYOsiRjqkT+ltEu6E1Jg8243VBbQIN1d1fzm5diiMsStzXQ2iGJuJUne5?=
 =?us-ascii?Q?BImDLCIgP9Dk3nBzzVNFvI+gJLITCdOSRvvlV7u7avaOYDYKhAvmJW1KI0z/?=
 =?us-ascii?Q?HyfV6eeUGwZHjRTpX1KnUBpTgNRCu988UCYUuJbc3OwmgUMjx6+dbay30r6m?=
 =?us-ascii?Q?ASu0QLF7jxc6gHKOlE8WuVwRqJQWBViBvqJIPipwTaskHxAHubsvmN9Ae1Jw?=
 =?us-ascii?Q?F2uPLONL0xlaJ3GINmN3dwUQTT8DOZOwBDcE1rpIM/jJEOfnFr4RxqCr9iv6?=
 =?us-ascii?Q?9HOSoMz6USlP4tXRCTkuOo1jvtCtvtUWFDpkQaJO3dQRep5fHiRauAjT/cfP?=
 =?us-ascii?Q?4MeG+hcYbPMiCYEOwZhbcl6CulwcRbQth/YtEXwvNNas+CfTaf0WgD+vNMDS?=
 =?us-ascii?Q?xNnbZWcAa7EnP4SGeLDq8uFvgmGpnEQAFcDJFNPiPtLQ8LhmEgUT70dm1bE8?=
 =?us-ascii?Q?lJtRKh1VQjTygEUuo965mz6VU7bou65FxSXqrihnumvRUgsDanYUOP692dBL?=
 =?us-ascii?Q?86I9xrQeDN6RGDAsYZXYROPHYSKGoicU1AvMuZ0HN+X7MpohORrxzk2SItxW?=
 =?us-ascii?Q?24sJs+f/46xCwdGjEWwNqsQjysupbzWBmMuT02OD/+L+4E4T17sbIzlRukN5?=
 =?us-ascii?Q?1QXfZCw2cMhKcFtt5Z+9lOhFHoh2MD0q8UVe23g01iK9HKJpcz3zxcCDAgcg?=
 =?us-ascii?Q?ZEvQLVh3FPFAW+AICHqG7c7qhQHO0MlQOEMOXkOLYL+faXhNH5lxeuNO1yY+?=
 =?us-ascii?Q?7Qm9x4pCStXi+j8IZ/zM79odMgC+197yRY4rPuAmNwM2DdH8zUPvdFQQ2gPS?=
 =?us-ascii?Q?2+OtgzcmdS8g7JwqBqOcX2f3X8Pv7+lnZbAR5ZKowuOBtS/D65+dujlSujd1?=
 =?us-ascii?Q?PZFZiiwElJLEyV0G25smU22RZTlI/4+5YDpd4FMbG8JDBN091FN15sOQ7okb?=
 =?us-ascii?Q?kAimx/vyatwLuorwVmUC003Skvbxhei9mKStaGjYxU7qFwnyqBDk8AIUXNty?=
 =?us-ascii?Q?Fi+H7RpwcWdDNOwiPutTyGBI5RJT5lx+x6npRT3Yw3lESO/XRbSYjDO2vP3i?=
 =?us-ascii?Q?yUBKYCsBEVnhqzZ3aagsSOMuj9yim7REff/oO0acU3cotHXVmBk+QoBB+U3h?=
 =?us-ascii?Q?568icm1tSIQChgkQD9CfBw8GJAKqbC2oZ8mQRpk2yF7Bx6R+RQ/O7B1CYm/e?=
 =?us-ascii?Q?wSMOQLnOgFqMF8jxww5OQkkKwa3spGmJ/mKuy2DDny0gthIpzNPQRlTzZvws?=
 =?us-ascii?Q?wG/KtnBkoJ7fXSeJpMCpLscl5eWbK8FRAamvFxjEN6EkEEw6RQoo74PF/x5T?=
 =?us-ascii?Q?JDec56B6NXp7Hna9ww4oFxXeTqkEv59OmsAworaBlpEy9bBukIqVdjqM0IRq?=
 =?us-ascii?Q?rRSmO1nu8qzDos1Vzu+i7n3FGsSJA6b+JvQ6oli/RRGezO/Qsw91Zt0F2oTS?=
 =?us-ascii?Q?GdoBs2BGYU6gOTBcsgNkf6gw2bcqkrb5gubvBltxtw0OXTFprqZTOjilL3tx?=
 =?us-ascii?Q?AkoKnkOFK7PT9dMX/CpDYwhP2ZOtt5WBGRmS75Qv2clr3AO2N2eQ53seDhp8?=
 =?us-ascii?Q?cXelXRG9z46qq3U05G0=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:45:21.3074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd8796d-c750-4506-a6a8-08de2141b444
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 16:45:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20497

This patch series enables support for TI AM62Px SK Platform.

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

Changes from v2 to v3:
- switch to optee-ftpm
- use github mirror for ti-linux-firmware instead of git.ti.com
- rebase to next (8b7ce66a)
- enable fTPM + StMM mode
- Improve modeling of security features in Kconfig

Sai Sree Kartheek Adivi (5):
  Add support for TI AM62Px SK platform
  ti-am62px-sk: Enable SWUpdate support
  Kconfig: Improve modeling of Security features availability
  ti-am62px-sk: Add support for secureboot
  ti-am62px-sk: enable data encryption with optee-ftpm

 Kconfig                                       | 47 ++++++++++--
 conf/machine/ti-am62px-sk.conf                | 32 ++++++++
 kas/board/ti-am62px-sk.yml                    | 13 ++++
 ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 +++++++
 .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 ++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 27 +++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc | 33 +++++++++
 .../trusted-firmware-a-ti-k3_2.13.bb          | 22 ++++++
 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 ++++++++++
 recipes-bsp/u-boot/files/rules-ti.tmpl        | 49 +++++++++++++
 recipes-bsp/u-boot/files/ti-extra.cfg         | 19 +++++
 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     | 73 +++++++++++++++++++
 ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 ++++++
 wic/ti-am62px-sk-efibootguard.wks.in          | 23 ++++++
 wic/ti-am62px-sk.wks                          | 15 ++++
 15 files changed, 449 insertions(+), 6 deletions(-)
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
 create mode 100644 recipes-bsp/u-boot/files/rules-ti.tmpl
 create mode 100644 recipes-bsp/u-boot/files/ti-extra.cfg
 create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
 create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
 create mode 100644 wic/ti-am62px-sk-efibootguard.wks.in
 create mode 100644 wic/ti-am62px-sk.wks

--=20
2.34.1



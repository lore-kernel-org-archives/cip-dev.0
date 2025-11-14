Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3CACE7A8C
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 09:05:28 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com (DM1PR04CU001.outbound.protection.outlook.com [52.101.61.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14171.1763111122428968350
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 01:05:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=scsYp0tD;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.61.40, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWMExFSRavEHjLMGkyuPglEYIolSYB7uYpeJIMmM0zsGjV8tLpBnZktMlWqOZuYnq8DDxclnHT0YGmFVc9v5KVuYWTQBTGO9YJddOj6EQecrnhLNmm3OMHmwNDrWDopwMSOMXqWsy79+G+yvUTdY4iG2BtSzrFmBLc09LUWlOR9U5yZECBQ+NPQELChc8U88TRLS9PI8c7etkHif192JE9U8neS1eVFldfmupuAiL7NZb1+c/4o+pYHl+RiV7AhZe15KEzI40RKzpF4GXJw8mEaWyR4F4R1TuB+aDxpa+7vy4IW9e7CJQokwkR+G1Sip2NzwCXNb4g2d3LdjHoF1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfyhXJKaVFVvdAtkynZeIA/NoSU0vLe9j3VACetAutk=;
 b=Nv317+52kB/Nqrph0jAlGU/vFw0A4jrUXBHwcrozX8xgRq0Q4U6Yu2ukNevgVNBC+WS+jXx5ZyLkFw8KTDmM/4bTZj+UipZQf5PzygupKsrrWyXYy+axJp4qoLZ8t+M7vNR4ALFZB/eyBFWxCY4lloT4Y6dj5q/uEHcj9fimInrMRZfp+o6t2znuVWLs6SNoEZ9jI/81qAact17SKRsST1JUnC3z6oWVILT0elxvkjJIiyUoc/wn8L6VYKdbcRQkbaAa5Ahp1bybQBVEHgcR3XUi328CTEJqJTSedLqE80VF23a0Ak4xzFQdbBhYX2HOMvqf7P/vIwndawUu/01Dhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfyhXJKaVFVvdAtkynZeIA/NoSU0vLe9j3VACetAutk=;
 b=scsYp0tD0rcClke8B/eJAj5rE+f3SF/FJ8KzwoZqTlAJby/xNe7h/UCNeiFnIdTxovYCmeYUfiHdbg7/aI9mcUMkV0/plBsPhXBZFuMD11q5umLjRO4XMJG5jwukM3ToGtemhiWBxGEfx841F7wn7a8EN8G7sTv5ZivfBR9VVgU=
Received: from CH2PR11CA0029.namprd11.prod.outlook.com (2603:10b6:610:54::39)
 by CYXPR10MB7923.namprd10.prod.outlook.com (2603:10b6:930:e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 09:05:19 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:54:cafe::a3) by CH2PR11CA0029.outlook.office365.com
 (2603:10b6:610:54::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 09:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Fri, 14 Nov 2025 09:05:19 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 03:05:17 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 03:05:17 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 03:05:17 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AE95E1L1718804;
	Fri, 14 Nov 2025 03:05:15 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v5 0/4] Add support for TI AM62Px SK platform
Date: Fri, 14 Nov 2025 14:35:05 +0530
Message-ID: <20251114090509.2935933-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CYXPR10MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b860e32-bc35-4755-3f55-08de235cefa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bzfJ5+ziGEcVp8pVUAC7V/UfUaa4jJUlDis3fE5w6mB/OAbQLX0xK0+YMOuu?=
 =?us-ascii?Q?x+257MQqOKGlP8dVO/mcBiE0gNoqWG19DrYIJyolRGu7jbEJtXoxD0Ndljgn?=
 =?us-ascii?Q?OaO7lNOcU4daDOjeqbhDM0tyk1EXcdgRDxVI0tBxC3lku6kILQiXOINDDnxT?=
 =?us-ascii?Q?/zElChLJ63fhKuyRc/q02okpMNpD+fhb7lKoZ4jfvM1Es9Rs2aR2ZnW/6tYJ?=
 =?us-ascii?Q?Z7siBgZtN0mcGk539fczXt7Gkv8ESle3Qq7uEmV+3t6g00ZkiHY80DR0ZXDR?=
 =?us-ascii?Q?Bn0Pgn/M1iWDCAcmHWcgF/LgENcYAs1bvvnec4aIF6y7PofQpbcVbue9sPXe?=
 =?us-ascii?Q?7LDpWDTN3Ik3wYu9r+9+9qK2B2DemEB+bQNo0X1z0YgTZJA5A6m9M1nFoBxc?=
 =?us-ascii?Q?ah2y1wXmmJya7bJXSy4SZuWr72FZDRIgNXjhELdq56qbc9N1DbV4zG2rBy9r?=
 =?us-ascii?Q?eIoXHv4eSTU4PpYE+n/Tip3Kb3o4aj9LOWrytieAqB25IVtn0SadsQ7eWYKz?=
 =?us-ascii?Q?QRb/va6cr0Zvqnj46vNSzd34mhjCS/H8CxtRWF8c0COgzx/PJAolC/yu8Qea?=
 =?us-ascii?Q?ruE5j3tifhKJLE1P7M6nskLovnGlpd9vC6fUJeScOIiHir7PmddYz5Klj3Pd?=
 =?us-ascii?Q?nBfwVe3p6vE0P/+a62EuS/raUo75sgtLJFP9IweTIcUOAKogqIybmi64Btdo?=
 =?us-ascii?Q?2B9KhioNQb5U1uTQyTifCcs+Y9GALHzbP6xJkcT63ZNERU0Xa5XDHWdp/Brw?=
 =?us-ascii?Q?TIeW27fjuGKaLhlIzlRxg2pBjZHz3n9UG7AOVjJ5g5DtkwuikVtxhAqSyhBH?=
 =?us-ascii?Q?CzqQ5nyIvvWMwOp+9O3UfMqlwdZZyiW+ooJf4fpJRZ+fMWCXwC0Kn+Qkxcue?=
 =?us-ascii?Q?WlGBTmrHcw/YVwkWdNXRPlcg/xSDAEzCuM+TXY4TME8SIgAfeFxKBdm2Zok5?=
 =?us-ascii?Q?CB9+CLdBIu2IHWyYY71E8GcU7F5ONVzbLMHMa91v52fmM9yJ6SoauwmIImge?=
 =?us-ascii?Q?hnJhYMBSEXp057rYywdSbN+OyEB9fkQ/k7P0Sx+Jvhvn01AmyfZmCKkPJOXu?=
 =?us-ascii?Q?4+geFXIBTHcFSRkeY8AU1wYkdxj98L96EgBWLfqRGnAacdiUOocZuIFukwOE?=
 =?us-ascii?Q?pwurWe1xXFbYgtk6z1Eyzn+fDx0jf/NspaMP0NDhshKDyosrHUVE9QTdTG8o?=
 =?us-ascii?Q?C/tgTbqAbcStxSad4io3bz7UdxoYHQaE6dK8Xau9VUYuoEMqsc1IOaw7V4Sr?=
 =?us-ascii?Q?bDQZ1Q6v3SwJUbPiXgOUy3RkT1UleouIMW2I5CnGoNZaVlrtg4mTEN/F5h7t?=
 =?us-ascii?Q?wADB7xRM7XsNieg7njmlper31EMzSJWObGoPPQcVCrEOlb8MHvFYmNhL7Xuk?=
 =?us-ascii?Q?dPqCJR9WNEdvRzr7dqinkrnwayp0QL0tlCH6d7e77y7aI4hKME1I6BJ7meel?=
 =?us-ascii?Q?EXBzSvSb8b0GAgCizhdc79n/LcsGdfr1xYMFHbX7vCLpCuheSf47elsgvbul?=
 =?us-ascii?Q?qLPKS0aLVfs3FDFnGbfu0F0f8EA5T2WKMr73p9G4YVel7cnlaRpO3lcB88h1?=
 =?us-ascii?Q?9ezKF8UImMFFY+oCnVY=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:05:19.7020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b860e32-bc35-4755-3f55-08de235cefa5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7923
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 09:05:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20537

This patch series enables support for TI AM62Px SK Platform.

Changes from v4 to v5:
- squash PATCH 4/5 and 5/5 which add support for secureboot and data
  encryption as 4/5 is incomplete without 5/5.
- do do_prepare_build:append instead of :prepend to copy custom rules
  file in u-boot recipe.

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

Sai Sree Kartheek Adivi (4):
  Add support for TI AM62Px SK platform
  ti-am62px-sk: Enable SWUpdate support
  Kconfig: Improve modeling of Security features availability
  ti-am62px-sk: Add support for secureboot & data encryption

 Kconfig                                       | 36 +++++++++--
 conf/machine/ti-am62px-sk.conf                | 28 +++++++++
 kas/board/ti-am62px-sk.yml                    | 13 ++++
 ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 +++++++++
 .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 ++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 27 ++++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc | 33 ++++++++++
 .../trusted-firmware-a-ti-k3_2.13.bb          | 22 +++++++
 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 +++++++++++
 recipes-bsp/u-boot/files/rules-ti-am62px-sk   | 33 ++++++++++
 recipes-bsp/u-boot/files/ti-extra.cfg         | 19 ++++++
 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     | 63 +++++++++++++++++++
 ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++
 wic/ti-am62px-sk-efibootguard.wks.in          | 23 +++++++
 wic/ti-am62px-sk.wks                          | 15 +++++
 15 files changed, 410 insertions(+), 4 deletions(-)
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



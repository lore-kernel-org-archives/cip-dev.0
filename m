Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71F8C43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 15:28:16 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.95649.1783092492931487246
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 08:28:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Kt09TgK7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.38, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goFcwdwUJzwqbAn8IlvUvaW+EVy9wF40Q4h7EjJ9aTtxtrWOurd6RYARjqyxnkjHcwQXugqkqirqQiEORmLnyxBY0vhAaHvP1Y5tYBAzCXNdt0a1m76leLGObXSgfLtt5mG0y2j+iE3sVMtCGrQXP73kCfPjlpoJ2pFyotK3XKI4UdY7cDkU29ogNOWuwuzkihli1PYnND4xP1SgNwVPs8hYDXaw5Cd2NGxUcCh8ujzplU7O+C0e/ZO7LNBv5dlOXpwBfrtK0k57L3shxO+Deb2deHAmPE06W6tVhs49UYejpN/E0Lc0ljJq7cvvBjzExrgPb7BWJVakL2a+ujW+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AXT6Jd1W2oECwF7dpIVZW5FmuHbDupMtyasbxqFQ0Y=;
 b=OMgbv5+9vMdSYtFKryWkI6Dk3ZTgy3gDtv37HaeXxizHb5AeRSWaEnkT3JGplo8tibfTNlScxYcBdYoNtLgB+eFgEkaQOtsBe8Lr9orWeM27EOhiAVnVXKz6fL2J66EmGS43e4IGmZ/H4UQX24e+sy46c4bnDae/2qxWSMX0J1p0zSyOe19caBNvPafn0TrweQH4dDS2zx8DR4t3G4+7achilZrYyiqZCIf0BkhKhP3p6QnpPP8kho+spTSAmGjTrANqr1MRFylbo3jBwKc2hlaNlnX/HWJ/p08wQUsR9QjVCza7BCzJZTTwpMMZFOusgOcE0jkGyW96oAXCc0nOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AXT6Jd1W2oECwF7dpIVZW5FmuHbDupMtyasbxqFQ0Y=;
 b=Kt09TgK7pPw2QJLsWw17vhOvw7AUoqiUWa9JBx/2UKTbG7G9ssbuprqiWVleffrsjteCqbfKkvqN+6hHssgJ0d7RE5vQQ3b/Ol1I6GVkggY2A9U0QnvJgznDWphV3wfeO4ICqNWYbe7ZnCcGXdVKnv/mEMkypzpVXMxpQwyYNJY=
Received: from OS3PR01CA0042.jpnprd01.prod.outlook.com (2603:1096:604:dd::11)
 by TYYPR01MB8264.jpnprd01.prod.outlook.com (2603:1096:400:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:28:07 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:dd:cafe::31) by OS3PR01CA0042.outlook.office365.com
 (2603:1096:604:dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 15:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 15:28:07 +0000
Received: from Ubuntu-22.. (ukr-5cg4053kvs.diasemi.com [10.24.0.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4D473300023C;
	Sat,  4 Jul 2026 00:28:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/4] Add PCIe support to RZ/V2N SoC
Date: Fri,  3 Jul 2026 16:27:59 +0100
Message-ID: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|TYYPR01MB8264:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 359db143-530a-4c19-30f4-08ded917aecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	7BjMoI4KD8HbD8dxnXMO1SlndtqJ18V0Kcavp6NDp3nyXm7eUdumhJgX1qSDNQ8DPzQMwFm0PDRoTpDJuLJvECSXNxBcqqyfAKl2X5ziDYwJKabjx86WyXEso/CMFAOTFbFUdA38CvWDXlj+A/1R4R9C/ESmqOHzuGOpdOv4LyePfmAMpOublxiCMgH9b0Iqoc+azE67U8hApTv6gTpU5C0Awa854V81mU636juoxhY9jsgFar9Cu5WR0GJ8IJSi727guRKEmMBDnD2pogP6ViqAA3B8/DvbkfiqChF1LwOr4Eg5Sh25eU83gktvMlkluAOIs6tGqtrgv+mDeG6f1HgHEl9K/1iQL/k9WJLXBrrKlbWdGfh1l2zFKVy0BIt4R+PydpUeWa7wdE6YGjuVKgnONzPiqOvSffIznGF5tsNA4IUNLPn1u83BgePFCaJVyvV71LvuTto2UGIxl3zuyWIQBwRBA4jJnuqAp0piCZa+PNj/vFtS++aV8l7yyXustnYfORY08m/AFtjMAxvR1LOg4CamGJAhdXWkWtpc+NJ4SG2c3snVnhIp5Ejxcfajixzdh1xPWAQDCs5tgsMlrOzfqQgYE1ZKHPhatgZmhQIR2xWnwBlsCfwOytm+Aeq+vtXvx2Ah/Y286pFpUV19jvyDAdnigKsND+uPN/bNjLC4KW4zsp94lsVe/ODSBVREMwygvs6Me1YgheN/bOX28Q==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	TxGqMc4cONgJaJQZArxJJabeVoTnBcBnhP/0xNxAjyoU8phjG75v7VIWgENvBRSiXq/c7kd8GwQ25I9cLjir+LCa1fRujbVfqD0ljOBBtIv2Tpbm23wZm0+8QsdWfdiLWCJfY9fAVmImLUsVRamPXqsamLJmUj+3QiRWF1+8xIIyp9W5q0O0WBcUkkcKGolTyq8wWDPanQFbbwlOs72Js0Qg9p3wCZp1OmsGeKq+AHRgFpKdorb8mhP/W6F0yEWpQFd61Tzk4V1c5x3AyF6mp38jRCSLov6axarvyyZXGUbDWyMeAWVD9F+W5b1UdURvClDcMVwDhcNCOm8s5nRCvgxuB14+Xdjv2NaVJB1JPtk5+QOOX3A5eHVngWPxz9ivXyt4ds0/ekihj2ECUxw6fcG29jVFiB4phdcMK6qQZjo5LVx2xbCRD+lkcN/jjS/j
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:28:07.2629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359db143-530a-4c19-30f4-08ded917aecc
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8264
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 15:28:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23443

Hi all,

This patch series aims to add PCIe support to RZ/V2N SoC.
The driver patches have been already backported. All the
patches have been cherry-picked from upstream kernel.

Cheers,
Prabhakar

Lad Prabhakar (4):
  clk: renesas: r9a09g056: Add PCIe clocks and reset
  dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2N support
  arm64: dts: renesas: r9a09g056: Add PCIe node
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable PCIe

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 23 ++++---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 69 +++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 23 +++++++
 drivers/clk/renesas/r9a09g056-cpg.c           |  5 ++
 4 files changed, 112 insertions(+), 8 deletions(-)

--=20
2.43.0



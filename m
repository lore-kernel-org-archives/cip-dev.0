Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4EAC43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 16:35:37 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.96266.1783096527185080678
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 09:35:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=s5d4lC+o;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.50, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNDJh9G4d90t8+wETv6/AjC8Kedehgn6nsV1Ot6ybkKvxiku2IlIem/87EuTKjdBZ/ZxW6JS7Pi1+1Rh/clCs9U+ZdqyX07qEeCTh/a9Q4nFFc/6TnSkN96L65aCX7Cn18KcU9KCS8BVfQ9VLlMJxO627Evkp8h3jla9E0rtuO60iBQkrOdwiyFDy9vTJ1oJ2euTgUErc7+UdP2tPQwL1jTwwmk629vS6gYk5tJNqSQ4UukGJbi4R0XVQ/OOUURQ3HWyyrS2ZIcpbmw6apLtQ4v8v2fJrUeaIFyZn1rOhOE/RQbIqMUq1kBR2yltnF9e6Qz+vWx1rtrnDUuw3hQ0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AXT6Jd1W2oECwF7dpIVZW5FmuHbDupMtyasbxqFQ0Y=;
 b=w0Ut79NcfdAdx0zPoDuLuwAn8846MzBQJLN2Qz771miAaM3V5YxzQpXRAE/Y0UB3tpCQqRqjl+zLP9xMrbJmAnI7e0+qI2MNKpCBFwALowJBBVk//D1QfYmVuHUaFqdRdV2z7bQzXYAusR4Vsi3Vrh8OSDneYBzl+gwdfjHg/HbbOalRKxILYmxSNiV2GuZeGUKq8IOsKqOg4WxM+dvq4JSjtnlrkKOGmSStW+jYFPOXpelU8dTTM029R3qNrNVp1WMZuvEwlsHS7yPb1vrFBI2MPoJiF35w0YlAZecg5rAJzUgtZRRFBroJOHXQgpwUhmke+8CKnuRuUDzKoNpIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AXT6Jd1W2oECwF7dpIVZW5FmuHbDupMtyasbxqFQ0Y=;
 b=s5d4lC+o8rX4PN6Ut/MUqUMKfCMnEjJ1sedCSyx6YE/+r/Nh4NUmKBDYyx+H9HkQlSD9wK4j0Ly7DUu5ezuZQLz097VYESnCXoUgl5ocn1Em7+Zrf0Vx8zlRs4vVUAkHU/0nBZHl38/enhmpQxW4LIpMYMeVPHzOvXfKUU6W5no=
Received: from TY4P286CA0044.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:36e::15)
 by OSRPR01MB11599.jpnprd01.prod.outlook.com (2603:1096:604:230::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 16:35:19 +0000
Received: from TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e:cafe::9b) by TY4P286CA0044.outlook.office365.com
 (2603:1096:405:36e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 16:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005621.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 16:35:19 +0000
Received: from Ubuntu-22.. (nld-5cg2234fz3.diasemi.com [10.24.0.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 5976D300026F;
	Sat,  4 Jul 2026 01:35:17 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/4] Add PCIe support to RZ/V2N SoC
Date: Fri,  3 Jul 2026 17:35:11 +0100
Message-ID: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005621:EE_|OSRPR01MB11599:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 89cc4754-28fa-485c-d4b3-08ded9211203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	pVFofcLb7NdJmC3+581fa/Ig6V2F7MKBVXYlqEFS/bc4SnA76ZxZBBMuxDpU8ZvSIiA/U9fj/NpiavSbARCZGnG8DxiRKGdjmyTS6QUVUcDka7Y8VxMF1JVylqLuQQBY8AjxhIX0lz8BFlkC09dhLpciyInN6TvrGFIl1NOZ0KbXKLuxn3oaJ+FLJ/dXxZzgLsipf4U9jLMi10aAQc0s1KV8C9qRSeIqcRh+ggIZuzhnSfICiwkoB8Tqkdcc6zjBy+/nkHv8ku2Zk0zzDp+114TK9WhLPWnWn+JBkF+3cQnEnWJBHE3EXGjd2dDUvLfXZe/DFDLsxcpeMZR1uTISzDQNIxgiBS/vnRlFBzwKfOCH+Vvz3sL9DI+ceOUJVrbfiFeOq4jzslpQJbul+pE3UbQcluzg8t+eLLllSDJderbz5g86gct0Ppodegs0kboJcdOECqQzukvncnE90YfvS59VfYJvFE5xutjFWwXDs8ln+Q+aEtbvVr3FIRE5hGoa8P+8HWXMP57jGx/AaKZB8QjwWIi9HUcPTD6dP70/By4wrl88RofpAhoPcm/0yLPoyDR8lZ+xsWlUNEfjSZNG1CYa75rYeIFEMSpRbCBgQBBkSRHsyTu8KXJuoE/pCA88fs993ykHi2g0zEN1afN1rlF3pDP0GsUOlieCkyQDhwK20fysF+5UxBnXVTIPzo1i+9ZVaV1XDVWVXp6Qo2PagA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	sBm3JaFegKXq5dm4++q/aGz+bYFs0jequWcFVWScXKrqKjQMM/IgSPFsBkeEDWbwUKGwOueJvMrL3lq/5JhJGrtZm+Fx10Ol+LOQKsdPqXgtuzCbR8BUNVUj7Ae3TRc0v+VCGkHgeiBol9S3+j51YNNY2oJeVwlkBVkElv5MwHxpb2ZYqt+C1B3vflcwC32r32eoGkNtofzM9byr+kTKqpCfNmCrkrOfShob/WAQAjnKdYR2j/ST4gquqxupLQYSBcOv6HnQqlBWdLASWy8ssz1WGXxmN28W9jNQYCNx8qUiDcqz8G/hguHIv0oQ5kdwtx56bEleWthxStKodRJ00lGiwJuV5oWfKPz2a9b0jMwrAZ255xGti2jN42HdGsqbIujDR3l5OmJQ39wqJJGh8GSr+nroAsSvb7fGggIOW2qeUnC3E5HFWZB2F43ljyZL
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 16:35:19.2077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cc4754-28fa-485c-d4b3-08ded9211203
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11599
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 16:35:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23448

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



Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F73AC98314
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 09:32:28 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3854.1790242345961481287
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 02:32:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FneWgBwd;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.43, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2kHwBuac8vrqclnkjqur+YmokmGELQjz8723J+epKrp6NBV3dby9JRjbDKUdmYFUR83hNpyiQHUeywXMVY3ubvap6EFIRptheO4LGdxza3w2mWyhKK9vVS/FZ0aw8SOSZgFSUHLIE95ycwXld2xI3Nmv2xsjzK8G+LbP9PAvWZvinkQ9z46Jvm3c3X9ZWbSDpMVfVDpQPav7XYbU6flCDTNAGBMtCFP6L4++md001WvotmqnRQR0iDdK9ETX1+Mw5ltHTTW5Id1rDNWpJkSiJ9Bc8hev5nF2Mt57X7ZgYlGUSfKRFmLAylpi42Bzp8y+XSrZQK/isjNDxLWUnrIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ0P4/5ftNtY+vcL4G1L5Ayqmr2v7sv6rUGEsfcFUFQ=;
 b=CjSwRZJzMovUhWO/lLrCUD8F0koU+XSzqH0Mj/ccW1u+rSTsVHtamo0jestC7rDj9nQ+BYe9WOqPQJ94M7ffOwHI6HJExKgmCwpJBQJmC0h01ZIfL+MHkIE5fwVQdhLl9bjPJWdtTFNAGowH/ANGKn2BA5mn6615UI6AkM8CUBBY4L2hQASNFJ+8ytjZifE5OPA4vWhx7FiKYWIdKN/KBmMykHIdettbrMgsAYPov7gx8kLOHNNJn48OJlLcWqEM2bhBO8UXiRjrlAesNyqMxOwCz5CBmu+TqfD+Y/U1j540+Fs/CFv3qSwVRtJO12riEITE8KAWFXwWunx6aHDBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ0P4/5ftNtY+vcL4G1L5Ayqmr2v7sv6rUGEsfcFUFQ=;
 b=FneWgBwdI0kHFb/eLJYPIb8B75nMIfH1B1+GBnGu5rryqrfv92dtYUcSjSx0IfW4KiyZqwD6jJrEkoHJOVW7ZKScxxPNYlxgRgxAM3xkr1tm/C8mwCVYT308s+OzyYXQaGkx+ptEtqRQCSOsifCBMQz5+Yax+kJwQWeoGJ2Xyco=
Received: from TYCP286CA0321.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b7::14)
 by TY4PR01MB14004.jpnprd01.prod.outlook.com (2603:1096:405:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:32:16 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7:cafe::4c) by TYCP286CA0321.outlook.office365.com
 (2603:1096:400:3b7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Thu,
 24 Sep 2026 09:32:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 09:32:15 +0000
Received: from biju-VirtualBox.adwin.renesas.com (DEU-5CG6192QFB.adwin.renesas.com [10.226.92.107])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 86F6D3000225;
	Thu, 24 Sep 2026 18:32:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI support
Date: Thu, 24 Sep 2026 10:31:50 +0100
Message-ID: <20260924093156.131928-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|TY4PR01MB14004:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 08e7e811-e1e7-4101-9e50-08df1a1eb8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	mI+PvkyLIYLp10+Ns5qZaukhefx8kfj8TyCgjmPe+/B1TGF1xEr7omoxwyggIXgryrMN+KWYzEEBRX49dxWoXajfGwEK951BCAQ9Jc9L1XbcPrsVmKpPTKGOO+OcH4ONGGfzRFw2/mOnJsplm1vwe+14HAIdoYckuLFPf8oaKhH8BUXfRJk5ZIoejXuUUo7FZDVYGQJblcqRJy5YlIZpCBDlzPE4ZO6ihtOXK1RKsUdr3b33pTLkqp6zRzr4AG74Rq289Nub99xUj3KQwSTRmq1BhmKLmvFx/8KYL36I4BF4QyXHE8PN9Ccq8ouxxJuQXaDE/JFPeXA5rEsfUgpCjisTUwr6fFoZ5Ps5vXUQfRQnG6TV8iFk5vB+p7Smno47QThadCAQDtAoJoUAp20jKmPNVFO95iWwAw6I1M3YJ/DzvdP0HP8tFdYul9hgsp5XMHVmhwKY9DdPkryZ/w1+3+41V+lpNPCFe25iWd9cPLBUOO9ApZ1/7wrJVDky7ZtZHqnWBNQjJPqh79t7tHf24hB2HmfezDgEZdTuD6bcpVdBfj3/LtPFUgNB3zkwuyomGSktDwfpKS4S5t62hBwFmU/xoG63fBArWL+0Q3OSwsk5oLpj5xZV94c6zwWHK5u2N6lUZEe1wit3R1JVNrcTL2Mu5npTXhui3pvyEL+QlPjMiYcQbQ26QwVFYrbLJG/diY9D2iA4IimNH0DeY78HEg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7HAJ2gmQP2/KgoLHA2US9PG+z+lUNsbd5oMIwnWbRQfdQYks4bI69o9WBwn/Q7QG4ZdyZ0tr6KB6sX90IY5TESWNCEwPc0ekrCEXgdrlaa8QGWwp/LedrLEns39qIv+YbkooBQVpAhas/yLMMkl5+KQUX629CABNoNtpEQt8JYjFhak9vSWBle5dN29LZYVaqjtEL614ObPN3KxJD6deVW1v4qK5XhtnKFdOQDmQKSLLLjAjzexEt4TFRQOs4Vb0hOrtI0ELfBtlfAQo+BSQJr0iWInFqTaPeCwB7zMe6goMITmhLFkQdqZshBoXl7cJxGk77OHYwgwHR6zj/E7g3HHf7miUJ88jjCs/C5+hipGJ8FMORzvZQkZUuLrV/gGgSHVewBtKe+oDShEjig4sx2SfcDSH+ILekWlXscY9AJtWdB5vfuSDq2NBdGeQEe5K
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:32:15.9977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e7e811-e1e7-4101-9e50-08df1a1eb8ba
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14004
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 09:32:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24303

Add Renesas RZ/G3L RSPI support. All the patches in this series are
cherry-picked from mainline.

Biju Das (3):
  spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3L SoC
  arm64: dts: renesas: r9a08g046: Add RSPI{0..2} nodes
  arm64: dts: renesas: r9a08g046l48-smarc: Enable RSPI2

 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 29 ++++++++
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 69 +++++++++++++++++++
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 19 +++++
 3 files changed, 117 insertions(+)

--=20
2.43.0



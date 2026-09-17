Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157E3C982D3
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:32 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35100.1789636465005084184
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=MhubPJLH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.70, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blrsZcamsDFAuho3iG2GoZgUh8V1nRm7qC3C/ppX3sA5243Js4WseTYJRqanlPiFR8reQhTa82tA+FyAA/sVIAebUAHZEX6PLcTsO/0t5kDgBO4C+vDQzgHUORQrqSXTRYFGLOgrr4OLoZp4VHVOpig4nWzJOUHFfLON41++m3CCEjf1f8PxjwHihHxRA5kTXjF4ocU+erSVQ48yboFjX7lpt1j1urL9EviwNkohlzT1Of/8lxaCoY9/dEMGZOh1YcBSac7WtiuoucuVHDN+717+TxXvE6t7/8MmAD0VHhIZS+NKPUvI9BbrXmQ3wVS5MZnW8nIIyNg8eWsChk1N8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+/cgWFlR4u4hExfQl/UlkdPr8FUZ420J9r5QC4TWUA=;
 b=WX5Z6tYZPNJOWyMwzUPSaCVO56rEq38UU4OzV+G2Q1pBzdoY9+zB62WYT+pTZTyU48MmqJ9NUaJbsDrcLCONIsJw5FskI/BxQkNs3585b3+FHtsyftQTy1bpOTxOcJL4qa1ZlGkSS31FAPH4ql1lHPmB7BsH8xm0t9UCF6qSI814apzUPkYkYnaH5RvqvzKIhNkfALvmdIu9vX4ZTZnwR2MD+UbrXyrtByl6DJWIQ7Ai5TSRf8xrSGppmyqRCKOAJC3wOm15gsSCabdpjD1eE/qeZFnczgnzYW5x8lB2sGcynipViRriXSKOg69vX57KW+mkpx3ETb08/PSDBXLksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+/cgWFlR4u4hExfQl/UlkdPr8FUZ420J9r5QC4TWUA=;
 b=MhubPJLHvojasHbIr07gv/0K3OROz9AdopGzhd2PCwf86JaZSYw6dUPBN+QO/Q63j6ZJOXxwmU6lbcyQFcRg62YgBYvQE3nRzwJVC4wGOrn9J2lcmlNzZm9Y1HRuDS5bXD/oiPpiAFYMiExMaWS+cNfB0nYeOsF7+Nf39yJoaKw=
Received: from TY4P301CA0022.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2b1::14)
 by TY3PR01MB11763.jpnprd01.prod.outlook.com (2603:1096:400:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 09:14:20 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b1:cafe::71) by TY4P301CA0022.outlook.office365.com
 (2603:1096:405:2b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:20 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C43E530007C1;
	Thu, 17 Sep 2026 18:14:18 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 10/10] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add alias for on-SoC RTC
Date: Thu, 17 Sep 2026 10:13:59 +0100
Message-ID: <20260917091359.18445-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TY3PR01MB11763:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7e41d4c1-3acc-4593-db61-08df149c0e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	lHyPA9TyV0MwZ4hdB04Kzi44bKqbGjRxpc6Oz0DDn+2b53uaA/tl7ZF5XzRFD/fVGQd3OX3ya2Q98dbCMFrGRc6fDrAWTdW+y074FD9DUwBp+hAIKjGAUwqNMprqkNZB29SJ33bqzJf/udAE5cy03h4tjQYYZfGxFZ0M/IHwkdRZRLjzHB2uyOLiB+ebTiJLH6XlcPipy63gnhdkrPNjoQ6akOmsVLNEW0uOUDRe1KNMopWCh5w5p0Dj9jZTzjhhKV375YxGqVVu3KcIolfws48QB/BFiAlGF59Hanz9ayenXW4sy7MFYoACcYKdQjQPWKfnEJoaDIR4brUwea7h+Rue/QN/lS4kQprpBLZPbmHaDgdHcQ5ZrepDp1B9BcpQnxQ22TcEjD/SXt5qMitmRdjc9koyEW0iQ47djArWDUJ1jYo6jO/rU8N7hn3ZX9ZkojgnOh1nqVGca+pCUjRjXRDqBI06x+cGMeNuOVPWybRQIGhPOJTAGnCT10aOYnqatVYRPQhz9pDeqhOJYu3WMV8aOp1ox++fgIdDw1eivXu4y/4PWpTRkzWCNpQ695/2coOEmXR6HXx0SDdx7Ds103IuyQeVaEX3iTblafLJCZSOkDd8tosNngHplZWkQbirghxuWPRTLBQUn9UiQrN3Pg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	cjfjkSiyFlBVDY6JCXDBmFUrDADHJ5eO+dYTIov6xUaRYp56DOD58WsZR1qcHiq5+QPYDdDrQXTHSLXW5Chd4dNObNr66q1I3Jo77wm9pxtJIuG7Appd1pD5MHVM5eYouZwRoJvnP9JztrQFkU2saCUqmAZ93umUzHO6LDtUyygr58kmsEEwGreuVbTbgETQ4qeOws1BtDeLZbLbvTCaDD4h1JbDqZFn1CcWr5AREjco4s0iuTs6mD76QGpSnRUJITADHrSuq7zg27gEi5IgWb+34SHQ82PdwL7OuLfRGDMg1czp/kMAUrR6b0J9bwO1kZdvj4G3GZpnevPa0WNyXNrTCs/o4TqxcqC46MEaOoz/8r4ioinBF7SNXB1k8MbYzhoGwWwEvfbvHEaEALJpGJP3KxII86QG9GAf/vvmPwwgCXdPm5nDLYEdYpU8+690
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:20.1823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e41d4c1-3acc-4593-db61-08df149c0e99
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11763
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24207

commit 8fdfbe0f114fd406a1e98d185a8f9e1d193a6526 upstream.

The RZ/V2N SoC provides an internal RTC, which is enabled in the DT.
The RZ/V2N EVK board also includes an external RTC in the RAA215300
PMIC.

Add an "rtc0" alias pointing to the on-SoC RTC node to ensure a stable
device numbering.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260506155804.3984418-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index 914960100e659..29364343048cf 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -26,6 +26,7 @@ aliases {
 		i2c7 =3D &i2c7;
 		i2c8 =3D &i2c8;
 		mmc1 =3D &sdhi1;
+		rtc0 =3D &rtc;
 		serial0 =3D &scif;
 	};
=20
--=20
2.43.0



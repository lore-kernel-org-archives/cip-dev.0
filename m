Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA6DC982D0
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:45 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35135.1789636603233582911
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ijRz4p2e;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.18, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKky2qjqVt0NL35ruwbQ9WRd87kTUhWQFUMMzUa6/rJBlhbmPTYwTmZ3qwd/HEOzGU6KlmIOkEz3dOpqe9uEQNghbx2KzNfK1UxPnKn9fvmi4sGNAFk6eid5yGsUJtxkwxJWUQJMn/zI/J/Ktd0Prn9THR7+iUb+9YfzFhUMwIOe4pCjGu1vkWSX1oCxOO/UC7fN4xf43Kz68Pg2xnM4Db2+1sjEhUWrY6V3qRC8praYy0LqI+yyyeEVk3dbHeVRnP2+ZxmllESqRm5B1xhEbPO8iNvkvX/IHtGeminORKQQ1prujipkL8rUAPhoKG64tqS/U82rRRVPINs1HkLc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq8khHkl26ZvKBiqwO4Nh2nfoIZR6jkKVuvd576eBGo=;
 b=IjXMoEecchPaS9VRL9TjZ7aSQ/mGUk8O1M+bh6nASPr70JiLbJiw2S5lOiZpQqLJuYTgbQ7KPauaysZNjHkQyEpHvHzhmPJZRUI944J7cWqlyd/PIyKQ6itp1dEn/q3ztdiQn7JqwLyQ9rjpum8dS9QNdo8ZasExlQkV3oNokaJFyAVnAqSxGanamdRFDpuBcSqkhLn8UkiCl4J4uHTVMDvjrLu7FxZdC7VnOVJZ3IO8gHTCZtOcG7+idKQUvmc3dOCYU2q+hl2l2py/QcpodpzlD0lyVAbJITf/FTsEAUlELNh/fQuYMAWUsoylGfRQbt72+ZpEs6Es7HLZO3JQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq8khHkl26ZvKBiqwO4Nh2nfoIZR6jkKVuvd576eBGo=;
 b=ijRz4p2elmMXd6FK8W9U+cN9hjSs559bLERKSlcQrFGJKoTo6gg6lQIHX1pQlM9n1mpEnAQse4cv0NnGE+6HlRvnClNS6kgZ2Oh1AEodscC0TxiQi2V5ygMxcU1R59vkbP8aKq+K8nCfRE4OozGtew0TYf8/nU4+Ef5TXYhBY8Q=
Received: from OS7PR01CA0021.jpnprd01.prod.outlook.com (2603:1096:604:24f::8)
 by OS3PR01MB9913.jpnprd01.prod.outlook.com (2603:1096:604:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:16:38 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24f:cafe::61) by OS7PR01CA0021.outlook.office365.com
 (2603:1096:604:24f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 09:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:38 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id AE90E30001E3;
	Thu, 17 Sep 2026 18:16:36 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/10] arm64: dts: renesas: r9a09g056: Add RTC node
Date: Thu, 17 Sep 2026 10:16:19 +0100
Message-ID: <20260917091621.18551-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|OS3PR01MB9913:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 78e2f1bb-5080-4c4d-296a-08df149c60e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|22082099003|13003099007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	BCZINNwsP2nUH+51KugAeOB38A3BzownPjQlGHXNM7Qx6KgmE+Og4yUP9KQIu94yauJh3kDC9yszy3dtqN4MN6tqfq7TqajI3y8FBuSM0Re7/BgoJK0g9heugGqEU2nZK+C3KHiTdqW3HosRCXXQKHeQ1TPt3yfFbrX39aFs2v46/rgBVm3Md/csHdnXUp+VxWlYWpJ1Tdm66E16EqZ/gCs1yHPJAcFuCViji47Z0UfrJRB3VJHcDz+zm7vZvTlRT7EHAKKbFLthGi2L0mUlSBthT35ZLWaplhgAquvqsKU1GZX2VqRHNBuR0vXbgKUQnpfnraP0wrVzMsgT15xthru6rq/e2ebPKPYA8IgHIlcdjIz0MQkYF0GOPviCf7/0PT0vQe+75tyqCaEwvjqVBDoDTxWsRi0jOP7oN2DuGV5hKLRVJry6IeRiwdMulsPq7tad2zK2bleKOtLroZL9sakKpSj000wFF6CG0wexqJ0AoAur5RybfXIkWkarlYOzuVrCazKji6kvVQIWOdWOy0v8qgjgnXxYVqZ2b8Cc2MJ3ycLIxULzjZO0hQ1zVLoW/pS/kKSwmYhPksMDOz46Sm+ge9nCJStTK1WBgZs8myJpXeG21Ugm27xXxvRePXrwroquXW1Egri9BdelOJiYp5SApZmxuNYhYGlAr9PWj+I=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(13003099007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	JAPkRXUdG2ESdDCHKUHJxWSr5IFPpdHGYD1awCv/kyco4zE+A0MgB2Jgp63JridzZ2c3W6ZTtv6h/7obUT7Lm5hdVYdZjggQHzkodbDtMZ4HJyg7tPookD8x2rfLGcC9lAsUm8shy5RGcJHEWUQW6wuDABPdSU4lvqY3KnT+RpDeh29ZkM6BhAOY1rvimfL4Pq6UbU21FMAC7EnG5yQTuL6mmryJrTJ9rb0/A0UjQHYC/8DOJhlWjbl1lIGkIce2Pj3gBOWwuOjfm3Pj1ogAJlS1ig0maEL8a+ud7Q0S7TmxMBeGfn6P/ZER1q16X/CgCweMJGerb1yHh4KWiQoHlR60Txeei/Oz8dmT/RnXWkARl27tstp6tGfCv6z6OJy6PgDvgc3bMr6Mw5tkO1mbx2sUbuSI/kDasi/uYVpE3/oD9dE/VZE6OJ8uPwm07fcd
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:38.2557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e2f1bb-5080-4c4d-296a-08df149c60e8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9913
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24217

From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

commit eb90ae0b39a15c380e640efc0c927b012d8b28fb upstream.

Add RTC node to Renesas RZ/V2N ("R9A09G056") SoC DTSI.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260125192706.27099-5-ovidiu.panait.rb@rene=
sas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g056.dtsi
index d76c0608524e5..a3a81185c7c51 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -635,6 +635,21 @@ wdt3: watchdog@13000400 {
 			status =3D "disabled";
 		};
=20
+		rtc: rtc@11c00800 {
+			compatible =3D "renesas,r9a09g056-rtca3", "renesas,rz-rtca3";
+			reg =3D <0 0x11c00800 0 0x400>;
+			interrupts =3D <GIC_SPI 524 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 525 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 526 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "alarm", "period", "carry";
+			clocks =3D <&cpg CPG_MOD 0x53>, <&rtxin_clk>;
+			clock-names =3D "bus", "counter";
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x79>, <&cpg 0x7a>;
+			reset-names =3D "rtc", "rtest";
+			status =3D "disabled";
+		};
+
 		scif: serial@11c01400 {
 			compatible =3D "renesas,scif-r9a09g056",
 				     "renesas,scif-r9a09g057";
--=20
2.43.0



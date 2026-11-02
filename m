Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11870.1793624007300816887
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 04:53:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lMwslzj6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.39, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ2rJAq/CZZU8hoBdpTvWqWpA0e8W40XgueYUmuIr9D4T0CAN7YzLbCvfqwP9UVk9EDG6LXOEtBQs+fv3UH8BISR44CoaXMOaXf5IQciv+KoBIQ8SNz4IN9aZEP2/hmuHAQKmuuGNWxTrRMMYhPSeJ+1pmNJwt/jy66eOsZ3N0mwlwQBHMX3c1A0V7P3nuj/jsfXaSNTecn38yZcxDWx4S0PiS4KRCwuj9HTrtceNthIbmuIFgI26O7yLpQXD5bCKrc9gggZKAR+WSp6LHQeZ3cv0l4G9CKIhAZV/MaF61PFeWjIomxKGQoZk27F6QPJF5Lw2DthxUm46AB8eZhUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT9uYFJrXI3zuyfp6wej1qQXVh7YiBna6eZbIo0JER8=;
 b=HBeH097zMnW4wfFkbjNap56WkgfyGdQl+nMramJlqGhLmzrt7LrE2WW819PPmn8jYcy4/x+gXNgUVVCPBENdsgqQx6H+q2MK3vTzy4DeToVLjkBAEaN0SRN6ZwnjuDU+VBKV/jNmuqwuP8OUGbH9A51uP6ZA3IKGlCOy6WAKU48dL1s6l0CE4sFa1cud7TqqCQxvACeKYvMWGINf5/jyiqKO4z80Vt75vFSw469ceDwaxOAbzdl4zbIVcJ0LlskgnBleFCF5zurLeUkhYjrHE7K709kGahg3lult5xW26hEYV8q2cuZztlF4vG2LLgmuhjRxupV87/HMXH1n5H8bbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT9uYFJrXI3zuyfp6wej1qQXVh7YiBna6eZbIo0JER8=;
 b=lMwslzj6tQncRACMKVNRSEVWNr38k2hWIPrhigFVFg38S8eBI0tJqAEkzJfUTOjhiJnRIXu7RULHEQXriEJXFU1DK84yU9viCmjjJmSyZli6ashSKC6n7NCSa5INWsdVKyKqGJk5IU4iRSH9FuvwlCi9Pui+EXXKQvznsUwnYtA=
Received: from TYCP286CA0024.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:263::14)
 by OS3PR01MB7309.jpnprd01.prod.outlook.com (2603:1096:604:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:53:23 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263:cafe::38) by TYCP286CA0024.outlook.office365.com
 (2603:1096:400:263::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:53:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 12:53:22 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 46E6C3000230;
	Mon,  2 Nov 2026 21:53:21 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 5/7] clk: renesas: r9a09g057: Add PCIe clocks and reset
Date: Mon,  2 Nov 2026 12:53:07 +0000
Message-ID: <20261102125309.7743-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|OS3PR01MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: d937d91f-56aa-4d1d-de1b-08df38e0474f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|22082099003|18002099003|13003099007|56012099006|11063799006|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 3r+fNy+ThdrBulzp9ATOV+CseEGphim6yw4e3zpjG9Uj4mbAb2FpDv5yBWuWDFAe4WGzpqqqVq4Y6ZJXrQLN6KBdN+hqi+H3W1nLfFyYIo773cWRp2kaAg7X3x8nFLsZJLtH+rps4stG+7x2nqp9jPSe/kXTkhZYVHyODOTDc/HURB6VTQaHtxP218ivwqz49HsJTYam5s+z87a61IyUH90shNCVOGRUWYzQM1fLla5kTa2HXZ+ppzHrWGO9sTKP5QBxPR6D1dCYw3nSMDXudnVVEFCMDqBypHmHbtAJKV+treCCk9ezlrruANA3XaLhZTbi8E0K0/h6qtV8ztQgRQut6YiwJTZUwJrCrGttz6HRnvZY+Fq0aXoAm0ixBcGeQn5kbn/2+faNpQ91zSpLhvDyucDDn1FfGel4CoTx/83F17fjy/ouyCXFvr/vfl8rl6jNbgdNlGhdjUnZAqyx8JiVeQUGX5BOkFzIkoLG7p59n+lfAysLln0sQrMwe1tC3A1PjcmwJsGDBoUdfTNnI++yjN8deI3fx0ooXzCkeYRCm28AnDv9f5RyslE2G7hjav5kMSbukmrH+3rqUMm/MciJ8mbFtNS1wPcosw6jYKl7e8v2r6CtziB+dXh7x5B4qk6IA9tbaho7fkRc0YE9tQ==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(261021121427099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /1C/V8Dg41cPFXaBMXQOAzm4IL3xvjE+RNCQOGSTl6czQY3zyU7wQqfSgXb8+K3jwxE0JDz35vsyR4d5/MpPMM/SquXtZ+z1hXtaqZLHLQ/ThVazblTrUxbkykPAkMrm7iUYfnWbRgpoVNTiaErmjdxsg/AA1qRuU9JUoUUe9HG/DMXcwNUo8FaYby+YQ5PXT/cM/ef+omtZAWXzCWzHs+9nT8mEWgyMVR1HdPO/r5WucsusJOWs7JMm29+TgT+Yd2epX4UKOswm1CQt/du6cTM7tuyGoeqhGsuRglPU6bZ/pyChiCEDNE6ALWZ3DiNUcXSEgwNnBZ+QeeuGTakXfCOQYfEeuF/JbRyfZC9Mt1Ndovrjn7RDiyPhkEvCpyO6udQb1odccQ/vfzr70KbDPEU/jqVaAtgKmxfIxX72Qb6iRa+Vbb5la3+w1TEuXCnX
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:53:22.9637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d937d91f-56aa-4d1d-de1b-08df38e0474f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7309
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 12:53:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24607
Content-Type: text/plain; charset="utf-8"

commit c45d9bebf8b4ce4e50900723efa5b733e27684bd upstream.

Add clocks and reset entries for the PCIe controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260312111521.115392-3-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index f5715947e8459..95b1d047dc094 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -407,6 +407,10 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(8, BIT(6))),
 	DEF_MOD("gbeth_1_aclk_i",		CLK_PLLDTY_DIV8, 12, 3, 6, 3,
 						BUS_MSTOP(8, BIT(6))),
+	DEF_MOD("pcie_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 12, 4, 6, 4,
+						BUS_MSTOP(1, BIT(13) | BIT(15))),
+	DEF_MOD("pcie_0_clk_pmu",		CLK_PLLDTY_ACPU_DIV2, 12, 5, 6, 5,
+						BUS_MSTOP(1, BIT(13) | BIT(15))),
 	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18,
 						BUS_MSTOP(9, BIT(4))),
 	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19,
@@ -514,6 +518,7 @@ static const struct rzv2h_reset r9a09g057_resets[] __in=
itconst =3D {
 	DEF_RST(10, 15, 5, 0),		/* USB2_0_PRESETN */
 	DEF_RST(11, 0, 5, 1),		/* GBETH_0_ARESETN_I */
 	DEF_RST(11, 1, 5, 2),		/* GBETH_1_ARESETN_I */
+	DEF_RST(11, 2, 5, 3),		/* PCIE_0_ARESETN */
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
--=20
2.43.0


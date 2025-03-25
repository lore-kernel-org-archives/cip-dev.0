Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8ECC3600B
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:56:52 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.52])
 by mx.groups.io with SMTP id smtpd.web10.67869.1742914608786372085
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:56:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=D8E2q1nO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNA14z+kQ0wkFwoKJYMtQkpCFIncUf3alsQU+DEBH7ij9bcExcLsKI5MipU/PM+WTrU36gz9xn0/n7XAT4zxH4pPPEjLxqqLXS/pGp6VVqmy5qe/GiBHZVGlEXH5xzQ6BA0ewSLbYiDWj4CQ5kJ+4IfkW6BAyFCxf23hiO96vIIjd66Ms1kBdjDP+nJaCMX+aaZUpScaRJaf8sbPcBFeapwqgSFpjCGVw1q7ECbIPFntObPxlQbwgwp7YjZ/Kd5glm4GfxRTRIxbYpVgPSli0lRPJPi+YcWnMh+loqMfl5MAuG8mrSRkp+6E1ACt8ti9kkVKcZ72m7I4h+X8mjbwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAnsYzJt1hjBGEgobc5cOo0NO07xyJMosEkkwHVIJWg=;
 b=Wy57Ex3gaccfFedXJTE4LMEdTRCtILwqnoCirWKQbVzWQj0uQ1DwEjCRZ+iC3nQ/R2mFf7gcYfG04spWF27/MjIdfX4v/OAHaCJ/DcAjJcw78ZBxlRqGmmpJb7fgnOu4kdIP4KvVhteodiAWh02xsTtqnEgyEcH/Q35w5WviVVHl0PJVisoQYVQQfgG/jhWaserEbrdFfjMqTtU6/LiVqouVhtrLwu8YXTe4HbOm4TbNPOEX5IbatI0FCb82W0o2V3c/D/JhsGZ//f0A8k4wiaXTYJJ50MZtuH7hcXSdyFT6U/pbJgbklsPaPgUxbFnYvEJe8t8Wrm2Kwm7YJjrCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAnsYzJt1hjBGEgobc5cOo0NO07xyJMosEkkwHVIJWg=;
 b=D8E2q1nOWym+FjfZqhSyn/o87/fe9Hswllbg71qGHtIFAswoUuhC+gz6XVJ47WegmlEqC5xfBGuwgzW0FKeRQZmNEkT1wAisG7T7687+D5Pu+N8VrTQSx5Jgxcipb68hn4leccOlYxlzskxl80TNkqG5p6HdqCsNK1jRjFPRl/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:56:47 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:56:47 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 05/16] clk: renesas: r9a09g057: Add CA55 core clocks
Date: Tue, 25 Mar 2025 15:55:59 +0100
Message-ID: <20250325145611.3595454-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bf01a6-a224-415c-8085-08dd6bad442f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vux0UaVxCeA0SjSfUFjWiNnXghAWmrrD52GjoQD+V22ntG1wEicsMFyABL5M?=
 =?us-ascii?Q?T1WbIzbHMX7tDLQkIdb9kUIwdbJt+jPZkJjFh4KtX7xaNBobWyvmRFmy9mAY?=
 =?us-ascii?Q?FpDcWPT1vEAQ/nCU8USmgsf9YF1D7TYTHP6tLzJ8WE/uW17P4R+TKFDcBlft?=
 =?us-ascii?Q?laAQxPNIFfrp7dg7J5XM8wJqB5FIFKyw87pUj1EUBAopTsR8dVJPYHVUt7Qv?=
 =?us-ascii?Q?4w71mcccUENpvUa5nbUKIfUuUaMxn2smi91rhLKzse1oAa+Rk7jUj/IwIh0/?=
 =?us-ascii?Q?Hdgn19DLc91t/Gso8PydZG2uH1cx3lINlRS3BKWMqDMNSazwwq5mOX0E9GRJ?=
 =?us-ascii?Q?klqkmjEC0wK5mPjiwCB0tB7yDtcqJyIyEPUQ0FnGoi7zHk6kiPY2tnYslhEA?=
 =?us-ascii?Q?aBbbUiLbmpXmfPUy8ct3uD0qboLZVRnTtIteBO2tihzc8RdqXT0pjNqj+4g2?=
 =?us-ascii?Q?6RxujMJMgbEmoHgzRA3NsJGVl5DQ9P2lC1/sAOZuKHC4ql0o1JLsmWhFYHPU?=
 =?us-ascii?Q?ZRkoCtg0cWlkuenNha3rUrCoxwGwZtDPWUtZMmOuj6fzqD0/A39b6Lzur984?=
 =?us-ascii?Q?qkhiAyqUSWISFtb2SFi2mF1cpkU8NN0cP8UhWaXm5qnNR/C6RTESws7n90kk?=
 =?us-ascii?Q?TDSgxTcws+DvVlTdmLXNNh14IQzlanB7wITwCyTp/exYzqotiflJjVMqto0L?=
 =?us-ascii?Q?d4QQZPe1K9GD31tR37MTbEmG+qBX07yzQFPhzZF1aLIj7TmmK+EmcFOCYNeo?=
 =?us-ascii?Q?pQdfPL/AM7tfchgN0sQZoaVcyBHQG/H1ADHgjQYn2NtWCdrN3DdIEjgfnBRg?=
 =?us-ascii?Q?Fo55tdHbkSmbL0HmHgO/hA+KecOwb8kkkLTo0s9BVauZ3hEkiWLH+2r2qHPw?=
 =?us-ascii?Q?906Zy3H8aVNmLsYnkH295HGqBl4RhTr/Wf3MqUbIeOBP+uYs43i5VQBTIxC1?=
 =?us-ascii?Q?lq/kljJe9Za4rg9ao5fSie/XupYnuIk9ORrZKDJ6xetd+IUebbIuNVSRW/ZW?=
 =?us-ascii?Q?yEbAJrLN6uxMP32lKK9mgNr01OhDRTYwrn3VDj2eTKftJWuO9mwln+0jJ3lK?=
 =?us-ascii?Q?WFXKoamFKF/gEUIXxHI9q56qLX1c52W99qoeJrBo30Ty+HufWIpggN7byFnK?=
 =?us-ascii?Q?4eobaNkEWM4lm02RP0W4kvVhMcPXAG3f2IelfsKoiTpJgynNHMH7nZS1f9RX?=
 =?us-ascii?Q?pUXevfg7EvolYaLHzVb4OB6TTn5Kj/mGBd2W8lGl32Sb0GcHEeAQ+DbsuhRE?=
 =?us-ascii?Q?OmljBb81PYiaAsHrDpfDT2QDFSRN8dDyt70e+wB8/+sqv5QcXVMQqN8hKdNk?=
 =?us-ascii?Q?V3JN6Pk4pxonmMVdpxlZLAxLcLb9MGUb3hqJDELRVNj6VxLNlvxISpwcLO3z?=
 =?us-ascii?Q?s/i+MM7wP3eQGJ5s9vFRfJ7kIvo54RWTlYoYpTndtloN40MJqjp2oUJgV8Nf?=
 =?us-ascii?Q?M+qlAXc6RXVuVFJJ9OHKiTLBBadjzB77?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DoHDDwt3QdIj6vGfw+MaKVFriic2pQibcptTTp1UrjqXhzxM0xzvM7YWG57d?=
 =?us-ascii?Q?6p79n6oVUgJVPCHHVmJNc+etWQ1KCIMUf7vPlHzxUd1tSKZAGbhOjZAphexW?=
 =?us-ascii?Q?VWtiQi/023exaXppzq8MWFu4XRaGQSOwVzo/uD/zDPIX9AYSb9hU/KdNH5vM?=
 =?us-ascii?Q?BPrBiH6JIG33GAQwcXB2nIXMJXfX52Mdum4eXJb/pA5uv1SKaClCdyEdPTm3?=
 =?us-ascii?Q?bPFbZAr6twpeCwZx2eOXfSc5DSUUNoLEZ7JFCV6S7qrIoZUOvAXzSpzxemhm?=
 =?us-ascii?Q?0FvUpstLxbrA+S0C6mhm2HFCBzI8EyoTqoxJ/xlKR8YIUPUeJBpMeuTsoIMw?=
 =?us-ascii?Q?Z2wbJvvf205scX5ksZX/7IruZqdIdV99FRC7emzuki/Mtm04WHB02JNPAlGO?=
 =?us-ascii?Q?o/dsZiUDAmIxkBFn/pvN13tf2MoSTyo+jfEWqm6QYtbRFNE/+WOIhAcANZt+?=
 =?us-ascii?Q?Qkg97CYAK7PE/68ptEDlXT0ik6hUhuoDW2SufPlidZvFgWGmEaweq34mwQYu?=
 =?us-ascii?Q?uTJnSpe50vxe+2kHp7VYeRnvLbpUiSnYbFevfN64xaLQwKc/o2392boKQQrH?=
 =?us-ascii?Q?c9lpysm3YyvOb6gnJ3V4k+4UlmeK0HOBoawZN94AszPQpebAV5uU2gW2EMTt?=
 =?us-ascii?Q?wBplf2l3tzC6x2Db8zBqcI/bqOlBepvlLs5iqNhOwcCeSWrok7WggAz4lxXJ?=
 =?us-ascii?Q?OFoBXPsZLGJkebbge6GBIaaFPXOWNhZgBywZYPFIOuDxkl3qbaiGuUILS+Jz?=
 =?us-ascii?Q?ngYGwUsW1GdAOkXH7Kk17PgsvQ7uwmNKTAZZv9je7hVpwtE5B6oUQPa56qmU?=
 =?us-ascii?Q?iJ4Y7BPzSw2zPqFSdrYd8DoUufxDWKS1Nvs4JWfMBqyW9MilNkFJ/ZkWNANA?=
 =?us-ascii?Q?CD+ai3CrswwlvVhLSDKcPJDqHsO9WmJB7DSbUNwY5RQrCM+LYsE9DJxTci8C?=
 =?us-ascii?Q?cLSWxSQAAHrCr8fHK++8L1sVhxcpmqgZKwxZGU5UM0Cf0WYCH+MlCiBEAgxc?=
 =?us-ascii?Q?WCHp0Opvr3gNCDRVTfvLDviVeV6Mmm3h4Q77t5oF7dLT3+/wXp1nIYRUHGsK?=
 =?us-ascii?Q?FR6zPgvBKepkKNWMtPgm/3PmasNeR0eNzf7j4fWexcOpiMo7eamrkqF4HfvB?=
 =?us-ascii?Q?uhFIo2h95wNnbPSS2sIddKYeHG/HfZpbfpD08Kziesv6jp2bWR5hboXsk1UT?=
 =?us-ascii?Q?ijWXMkrHUO9yh2g35Hx8rJmoWjVStV6UO53VKlHynQtA7Kif9xhCCfjl9Djw?=
 =?us-ascii?Q?dtdWVPZBF2FIeV+3iNENyL/Yx8M5d0XMy/eagopijWJ10oFeXFRKcNvHs4eZ?=
 =?us-ascii?Q?qI3Jcm9WqNsigo5QWJQAigo9eWAN+M+Qo0KlTDn9o0QXDuSfRgA+st6wdZLU?=
 =?us-ascii?Q?P+LOIARurXK+h1vjg10m2ckdUR10WrMBdhoKDVYLvqCPhVDi9MZbAgS732jd?=
 =?us-ascii?Q?9n8aeY15ZhnbA8ar7sihFzykIpvsndXw3lAjD83Vm2/O+SeNBTC/24yo+Zqy?=
 =?us-ascii?Q?mpv+WI4sDDvhAnCR3+tXP6jjzf4yxD4ZnBGLGAuqAY8VaaMQ5GNVKXzP80xj?=
 =?us-ascii?Q?zC+5VxX4npYXnr5SaHihDnQggd4jJrEpOjYa0ReWQvFaSnuRUw/TMCTEahf9?=
 =?us-ascii?Q?9nreG9uI0tTShi85vmZuMog=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bf01a6-a224-415c-8085-08dd6bad442f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:56:47.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7y09BP6nSVzghUKrJJt4A9QPNRDuAX30aHWst8mKiReNuQXtEmiZ/owMDr8cnNjmMfRvUn5RnyHSddSk+PjLGDkcnGKnf4OF9OwqZWrcoRl2DLiKV9kTDzY+o2BBvbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:56:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18355

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8cce33aed0b6383e91bb9d26dae11b1293101381 upstream.

Add CA55 core clocks which are derived from PLLCA55.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240918135957.290101-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 16 ++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 3ee32db5c0af7..a426d0aa45924 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -41,6 +41,14 @@ enum clk_ids {
 	MOD_CLK_BASE,
 };
=20
+static const struct clk_div_table dtable_1_8[] =3D {
+	{0, 1},
+	{1, 2},
+	{2, 4},
+	{3, 8},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_2_64[] =3D {
 	{0, 2},
 	{1, 4},
@@ -74,6 +82,14 @@ static const struct cpg_core_clk r9a09g057_core_clks[] _=
_initconst =3D {
=20
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G057_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
+	DEF_DDIV("ca55_0_coreclk0", R9A09G057_CA55_0_CORE_CLK0, CLK_PLLCA55,
+		 CDDIV1_DIVCTL0, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk1", R9A09G057_CA55_0_CORE_CLK1, CLK_PLLCA55,
+		 CDDIV1_DIVCTL1, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk2", R9A09G057_CA55_0_CORE_CLK2, CLK_PLLCA55,
+		 CDDIV1_DIVCTL2, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk3", R9A09G057_CA55_0_CORE_CLK3, CLK_PLLCA55,
+		 CDDIV1_DIVCTL3, dtable_1_8),
 	DEF_FIXED("iotop_0_shclk", R9A09G057_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1,=
 1),
 };
=20
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 60016b6122a9b..0723df4c11347 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -32,8 +32,13 @@ struct ddiv {
 	})
=20
 #define CPG_CDDIV0		(0x400)
+#define CPG_CDDIV1		(0x404)
=20
 #define CDDIV0_DIVCTL2	DDIV_PACK(CPG_CDDIV0, 8, 3, 2)
+#define CDDIV1_DIVCTL0	DDIV_PACK(CPG_CDDIV1, 0, 2, 4)
+#define CDDIV1_DIVCTL1	DDIV_PACK(CPG_CDDIV1, 4, 2, 5)
+#define CDDIV1_DIVCTL2	DDIV_PACK(CPG_CDDIV1, 8, 2, 6)
+#define CDDIV1_DIVCTL3	DDIV_PACK(CPG_CDDIV1, 12, 2, 7)
=20
 /**
  * Definitions of CPG Core Clocks
--=20
2.43.0



Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4579.1794226519933509005
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=u/suvT9z;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.33, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAjJtuEhosSxsYf7fMmATK2Ogmu8FtCI1AqCuMsyNhyT3u4QJV+9Qlhx1mGXJ2N5umtUyU+09tiz6T9pOMMGMZbvcj1FUkcJJ4GIvXD+y7B54v+jE2Oe8r+us4vjAb/x0JGQ6j0sQg5NUhgLSeHnaBrYmeMezfMNEV+kkuSC992WDq66e+qxYyJURcr8bQH0YoyJP65UTVl5mNGEjaaWZ24BT9u02CD6rRYJwwWSUguQcIdoFu3WnbPLgfO1VU2R615p514tu2jX4d17fY5XXJVmQUwpA4MwMAhte3Elz+wkp+qctocpQCFUkOb5A2iFpNQhCGP82Cg94uNmnmzrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js/nrHlsdZD+Zsg0L/N5myw+ZWFxu1QFc8UmU8lGZwg=;
 b=Lxnqaoao6e6w52biWKuismH9TarpcONVfbmJ2glt+Y57pJ6hgsvPO/QxDP8NBaxQrirYK+PZI6qczsoXw3E5r0kKyN7PsTvjyeBkL1D4THgNjw2jvXFjqQOI2UF8JCWgRmLpg39RX57rIv82d09ClU9L4f0ipcZMqQV7U4CEzkQM7QO4CHNIF0z+jeJHjTbHG7AmC5T/MhzsRjsXGWKPrmTNEISWkYdxmfZAC9RjCWjjcdZSAqR87SXL5ngGbVgIh4U9V/HjvaY2aVk7Re8N1Ud7RsihVugbWx8AZyov8mXSzIg6mmhhJRTMvhwqzH3WeSqpTbxyn9SvlZp3aqcF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js/nrHlsdZD+Zsg0L/N5myw+ZWFxu1QFc8UmU8lGZwg=;
 b=u/suvT9zQEIP54uuwVfZXYhTAWjE4ay3C8vNj5pOT8k1k/NnxjnwSkeB6eImv62jzFBhvmMvyCrgVciZQLzcMJjKEOZ66HEOch2/P5FvwLccvANdjT0l//B+jXYtPE1W+lDgTKT+AshHON2+ubMr9W9IW0UgH7z4CvFXSN4uuhM=
Received: from OS7P301CA0016.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:26b::9)
 by TYWPR01MB9905.jpnprd01.prod.outlook.com (2603:1096:400:237::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:14 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26b:cafe::29) by OS7P301CA0016.outlook.office365.com
 (2603:1096:604:26b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:14 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 9FDF7300022D;
	Mon,  9 Nov 2026 21:15:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/24] clk: renesas: cpg-mssr: Implement dedicated MSTP delay logic for RZ/T2H LCDC and RTC
Date: Mon,  9 Nov 2026 12:14:39 +0000
Message-ID: <20261109121451.6042-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|TYWPR01MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea9ccb3-7534-41e1-a256-08df3e5b1be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|10067099003|11063799006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261009223027099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: fB231Gptkiax/uswqpPPlXfHerVP1PW7MduhsExDqbmlCkYVrP1SS4Mq6sjw+/hse2nkM+/Ss6xD4X5tUOYfJjUoIHm2lNw7wXDLhs8mu8V+xczK8l7v9yimHwdr8sKA5q6WiXR9U6hEB2leVeRzuCq4dZg7WONqdXtFc4i0yj8Y/ICksCFTJQaEeVIHS8E6RzdCsNHeNtuhNbiSTHiDgAOp2yteIOKJMXogYGYb/1wxKLwGopv8OrvkT5NdvyS4NT47yCtrEkB8z9W+xWbDUbco33fhGshkD17izIycWMX8rL18CxQWCfEyebKOXo0RkgrmeQ3CO0MgOGV4fRUxlahOH2f7OHedcD9UIlk/hyjiMb8AaUKjU1gmHU5ObMsLmxBiRhaScOCQBCyDU+vAcuvAROSIm9jExevJY7rwB7AjY8ti1SNsyCTdx0SH98Q8AqBnInkGXRZvE0UI4rZWfnnA9P88ncUUBxT3rGzAcAJgxHucD3wZCwlu9BdQ4HXWj5Q+yjxBgHvIx1Sqs15lKnRAUgSVOBTOz462AOdVmlu0zdT1m4M0IVqywVJKXDED9Q2xuaSgfc/E7cnsgofzYPjVjgZytthhRDC92MXsBAz4LofconVDCLcTt5nRwtK63bbvWHgTz8CzyrXwE0HNB4BrS7mbW+Xt03xet28zaeM=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261009223027099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3E1h6q7k2ev124586zVYWsO9Tqgok2eLuuCnxAoA1QhN5h+V5252rR0FfebhXgPswgTKr8hSwVI3/vUx9gJ5ePnNmT7syuF8N4jP1cvGHyVfqNk/c9xbyPzcMd5qudg9oeQjNz8Hq1varxCpVlKoZ2MjhbcUb6bpwdoPN9Xn8CnoNjmdmZDVKaMGYY59xsMC0hzVmWj51HFroKVYuLzYIUPTRgVD1Pk0gHRqbuUWEqt30jgZty5x2UBP1NP9JKZ5HqzpvOqSBg5QUC770x/oDbnD4IPU5OIXPCm2tpLx+WtTlnnW37skw7npnJ4uqPsiMgndhRLMGOJm68LVI6bxXjnmRFsDMTez6jN50IiDh9kCAjQZSNOF7ejy0zqvGr1zaWsYf0tuUulh67v5PpuDZVZvQfg33B3Ni3UUwvg6RfkmUgUIyl0IKIL18YdGo00m
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:14.0109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea9ccb3-7534-41e1-a256-08df3e5b1be3
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9905
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24716
Content-Type: text/plain; charset="utf-8"

commit 0a6643b1a5ee72f76ed0c606c1b34c7cf632cbfb upstream.

Introduce a dedicated clock delay mechanism, cpg_rzt2h_mstp_delay(), to
satisfy the module-stop (MSTP) state release requirements specified in
the RZ/T2H hardware manual.

Per the hardware manual, while a standard 10 us delay (satisfying 7 dummy
reads) is sufficient for most IP blocks, the LCDC requires 100 dummy reads
(142 us) and the RTC requires 300 dummy reads (428 us) to stabilize after
being released from a module-stop state.

Implement a conditional bitmask filter helper that switches wait
intervals based on the packaged module clock index. In
cpg_mstp_clock_endisable(), the clock index and individual target bits are
known, allowing an exact match. In the resume path cpg_mssr_resume_noirq(),
where individual bits are not tracked, pass a fallback register index base
(`reg * 32`) with bit verification masked out to match on the peripheral's
register group block instead.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260615104845.4122868-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/r=
enesas-cpg-mssr.c
index 1b505de9dcd31..e4287599006d6 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -253,6 +253,22 @@ static void cpg_rzt2h_mstp_write(struct cpg_mssr_priv =
*priv, u16 offset, u32 val
 	writel(value, base + RZT2H_MSTPCR_OFFSET(offset));
 }
=20
+static void cpg_rzt2h_mstp_delay(u32 idx, bool bit_valid)
+{
+	unsigned int mask =3D bit_valid ? GENMASK(31, 0) : GENMASK(31, 5);
+
+	if (idx =3D=3D (MOD_CLK_PACK(1204) & mask)) {
+		/* LCDC needs 100 dummy reads, or 142us */
+		udelay(142);
+	} else if (idx =3D=3D (MOD_CLK_PACK(605) & mask)) {
+		/* RTC needs 300 dummy reads, or 428us */
+		udelay(428);
+	} else {
+		/* default 7 dummy reads, or 10us */
+		udelay(10);
+	}
+}
+
 static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 {
 	struct mstp_clock *clock =3D to_mstp_clock(hw);
@@ -312,7 +328,7 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, =
bool enable)
 		 * register, we simply add a delay after the read operation.
 		 */
 		cpg_rzt2h_mstp_read(priv, priv->control_regs[reg]);
-		udelay(10);
+		cpg_rzt2h_mstp_delay(clock->index, true);
 		return 0;
 	}
=20
@@ -1148,7 +1164,7 @@ static int cpg_mssr_resume_noirq(struct device *dev)
 			cpg_rzt2h_mstp_write(priv, priv->control_regs[reg], newval);
 			/* See cpg_mstp_clock_endisable() on why this is necessary. */
 			cpg_rzt2h_mstp_read(priv, priv->control_regs[reg]);
-			udelay(10);
+			cpg_rzt2h_mstp_delay(reg * 32, false);
 			continue;
 		} else
 			writel(newval, priv->pub.base0 + priv->control_regs[reg]);
--=20
2.43.0


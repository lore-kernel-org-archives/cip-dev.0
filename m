Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EDAC44500
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:20 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66272.1782987853731246000
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:24:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=HnxYOW7N;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.41, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO52OuH2yQGYn88Yq94LVrgU2c4VFJjALaHfyJOxDKLkroxV+5GjxAGeiwEZVeq5tmbnzF6jJSWrzq1nZqWB8qTD9gcGlBlA5pgQ9VDfiLrV4fFcH7WjvlGsYM8GRHmH/e4LbfUX2VnAMeigLfRFem0BpGEUIeOBPBUkt7eeUR6MCogE434jArx2BDvp2wGRXwX07N/t0d6MNA1go5sBz8iI4dOAQXi2o1x3bK3eq+q5NQjLeIjw8TKBFcicXud96dIxvVaf+h7TBCgKjQ23OXgGPXTrYtFmBXBrKY2AI9MYkDco28oT6QgoMLqm/eiczILWX+7lykHHUvFX3zFo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCzshhXmVArFwgYTgvdXg6MjcsYeypLAW4ASEE3YVvU=;
 b=xjiDkjWRN9yMZZY83TS03ERaPH+1NoquwcSRih5fNH7Ry8u0MHDbKKtixtWt7DbGWzMJ8aAXRuWvsRybsK/f2nIF+qK2JB7JZye6CsxRXYRtD2QKCOf2cnAs8CfSq+ATwMxw4YwgzYk8TO466bK91o0ptfZgdtDKX1vMutNN8aTv8xFHojUbZIgTZa6JufB63vFap0cmhkfk86WLHkpZvnaVBxyb1AHlt9bGI/34/UUG4nnoMxpdhJyIlQ2qBMf8+XkN3PB97fNGuLlOBwfWUvYj3JuUgA9ojHuv4JFaanAy4XCLylpvORvWwaDoZ4kxNv/QPRvD0GhsKBO+jnmo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCzshhXmVArFwgYTgvdXg6MjcsYeypLAW4ASEE3YVvU=;
 b=HnxYOW7N7g6qSNr6da8bWWzQMCdGeQYX23xbjpUTnR54TynSZYLwRmVY1zA0FtG9x1FIoRxTK9ULQ++qYFjQkUhVMHG2QDRCEr0w72kRvC3KwkJ8Kf1zm0kK4urF9f//NIrujHmuzk5BzQdhJderADWLUoxueiEBocg+lSGEQ+s=
Received: from OSTP286CA0012.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:223::13)
 by OS3PR01MB9800.jpnprd01.prod.outlook.com (2603:1096:604:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 10:24:05 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223:cafe::48) by OSTP286CA0012.outlook.office365.com
 (2603:1096:604:223::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 2 Jul 2026 10:24:05 +0000
Received: from Ubuntu-22.. (gbr-5cg2250zyy.diasemi.com [10.24.0.18])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C96BF300024A;
	Thu,  2 Jul 2026 19:24:03 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 05/10] pinctrl: renesas: rzt2h: Fix device node leak in rzt2h_gpio_register()
Date: Thu,  2 Jul 2026 11:23:44 +0100
Message-ID: <20260702102349.23431-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|OS3PR01MB9800:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a9968acc-694a-4795-c868-08ded8240b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|18002099003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	iTexbeH+ZZstKesE6MEUE35Zp4BzRWH3sFzMhCV/hJ0vuU8tExlO9bVUFVQQIQwPZz4Y6rJE22HgT/s+ciBOQC2FUYBUJ+xpalxYaPYoaRVbWebe04w2RYrQeEFigOQ/xLyHZLqXr4LWWQf9ViQuAbxrYOOMvMDTyV5A33gHb5ws76vjWSQIylIQfuoM8wxf3t+CpVLo0zPuMXgUJuvE+nv59YnPV4X23brin42QdBdDNXCVZXqCQoe5u6zpGc/RTqWbdCJZnf0vRM5YMF0gxZDAP1Iy/cUn4t50Uyl21rl1jq0vfHiJQe85WHuaLFCuJ8J29yjsgn3yUtIb32LNG2FiiiO10SkAHyOu+xd5GX8KUkR8M+playvOyrEG4h0KQxIqnLziAbrqPeu7PKxdpwzKrpiCSldGm0KPtvBoe3vgs1GVR6aFrvetTHkD7VVrvqdesHT3UjVS4+PCRWkR2EfeYaEMGXsNZw/AXHklEeN0XXiSHJVWn902KS+lsxJAG7aWQOaD+U7NweDY+suNOGZJcvYg286ZBn8IgRTouBRD8quqdPEanrbPFluWYrFA4JxziBx0loVDD+O+5ftskwOISYi75UB3RorlpZRLL6Wkqu8ow5WeueT7iLiELg+9an1BDK/+h9h+vepmR852OH0LVCWwYJEWO1ktv18VaLw=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(18002099003)(22082099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	l+UsbeWt5RDeqS/MuFOOhjxPyiovePWmNSY73pNpes4DKdKAla8Mhhue2fsfzUluDB9zBUmmaO4oAn1uacJbNHDsISvg1cThf5XBISczOJfF48eFlxr83+yinbHoUBfCxPFfsK5R7JWNQpYj+b0eseDjLWrHqYlohJ6VJ9bV7ZQyG5isWQwAenPcg0kjHqnrkqJd+dex6TiU54xvoEQcjQKQQ93hr08VKUEIM3UDjZ0h1234pYtV7IN0UjacAMQwuWxbcgw5n6J1HAHwQm4ZEUfMTvlHLeDPQ8+exui8qV7agTrZGRmVBrz8GW31mvpn9wxT11Es8JfvKoTalq+uG4uuZgazPNNz8kul1OA4766Fo+73kkdGcW9+yyzbgoVxmmYPR6P6IGqovh1G1cS6kEZaSjFvoVIqcTityG1Tby7ERlvPBy7zTm75lJmJJvM9
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:24:05.7601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9968acc-694a-4795-c868-08ded8240b99
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9800
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23387

From: Felix Gu <ustc.gu@gmail.com>

commit e825c79ef914bd55cf7c2476ddcfb2738eb689c3 upstream.

When calling of_parse_phandle_with_fixed_args(), the caller is
responsible for calling of_node_put() to release the device node
reference.

In rzt2h_gpio_register(), the driver fails to call of_node_put() to
release the reference in of_args.np, which causes a memory leak.

Add the missing of_node_put() call to fix the leak.

Fixes: 34d4d093077a ("pinctrl: renesas: Add support for RZ/T2H")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260127-rzt2h-v1-1-86472e7421b8@gmail.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- No change
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index b4107f18f5d6e..8dfdedeac23f2 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -831,6 +831,7 @@ static int rzt2h_gpio_register(struct rzt2h_pinctrl *pc=
trl)
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to parse gpio-ranges\n");
=20
+	of_node_put(of_args.np);
 	if (of_args.args[0] !=3D 0 || of_args.args[1] !=3D 0 ||
 	    of_args.args[2] !=3D pctrl->data->n_port_pins)
 		return dev_err_probe(dev, -EINVAL,
--=20
2.43.0



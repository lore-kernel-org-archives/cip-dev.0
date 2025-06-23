Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196CAC77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:29:39 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.32])
 by mx.groups.io with SMTP id smtpd.web10.16498.1750674575262844552
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:29:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=k7ZgjSvj;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.32, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iju+tUOHUkYC31nEdU8wuLd/g8JKRS17kv4oe5FJvPy8LoGH6ce0cEOdyNQW3W8Ewvf9OLwd5ez7lCFQrYqnTK5NyGAxZt2yQC5kq9vYH+CrEeCPcI07spqSRwsTmn3NUtIVqgOYKS4QH7ZqX0NKdM49ovnw0KzLBVIIk+VZ24wjUwPXLODkEgl1+dkxAwSUdPRG8/hbDHSVk0qKcQb4ynfP2s9DUAGrNIakm6uwoK8/mGM6HBitAR9Ea97N6IdMib7S4UAHxdsHrAD4JgeghrDUt+vVkW4hNS1BZa1FUhg4JR8QUcrB9J0BKCvXcEcASmP+QXjFnkwh04jFfoUEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/qCwMs4jOo94xxIWtIwxnbB6rNpcBKD65Mytcr52NY=;
 b=AZg8LkufByunP83vwaJApAr7vsVeuxXAW+58CFpD7ZpyfN6TARlXxgmPfZ9c0+7jie/dNisho9mq7+dMNDh3VwlIfs6MTknHvbQIOteEvld2lJB21YELhxHnH+Ho5RgXbxCoZxNa51LsjjDhV4DxWaOjxaxV4QLWvMoRBnlT7g+ZdNyaTogwv+2cw6tumMrAqzT8xfRcsI5DpDAFPLkuQyHklAfgDyhrJWEL6DOiUMaE21ZL4p9sMkrVZ+nUQcRHFOdrlQbbEiBo6a0ChfEbdckxfBadkyjYgLEUNi7YOXtybR3sXehsVz740MgBMxqRnwwdMGVUC+Hh4Ef6o5rVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/qCwMs4jOo94xxIWtIwxnbB6rNpcBKD65Mytcr52NY=;
 b=k7ZgjSvjYdPGFce+8rca+HKA+N8XwiJt0m5RjO93901tD9AyZencGyRmfkSyrSAPuRQ0DZwC89amvM538TRXg+ZnrRhkDUXW06GTSEcbzql3GMbSo8Yo9dsfXi4MKNQhcZWV3WMJUlp6L7vYEHQGSC76kL15m1ugec4y8yPWC10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15129.jpnprd01.prod.outlook.com (2603:1096:604:36e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 10:29:32 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:29:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 6/7] arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog
Date: Mon, 23 Jun 2025 12:28:55 +0200
Message-ID: <20250623102857.1493371-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15129:EE_
X-MS-Office365-Filtering-Correlation-Id: fff67c7d-0a8e-4354-8594-08ddb240d7b1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KsZUzYqgdwdUgpYGGJoLmcTrD2WZUC3AcG0vXMVRKOD0kwOxkoQmy3cTNDce?=
 =?us-ascii?Q?yO5Dw6taxot45LxeryQ/UBqLlS3yoTdFMRi8WUbzrfbRFMzfb3R98rJYL73R?=
 =?us-ascii?Q?F2APOHbpRYUVrrggvfyPuNNtINbL6ni3oKvYbovaIuBGU+jvDT5mS6MzWZ/j?=
 =?us-ascii?Q?UPHjLqOO1OGjR3GR1Xok5tex7mscG3W6rbkgxQuVWXzUHq28dfw+pGaa/M/Y?=
 =?us-ascii?Q?jJopNq58yBZEy3fPQcHMnkzQ4/cztEYuV3asIeSfoE5EibWXpSq4Pwnjhfoo?=
 =?us-ascii?Q?i57CV58Dt1ClWYqhYub9naOZDVRCRPXMNBvTIeJAfrbMV1k3HOXeoOCsE5Ct?=
 =?us-ascii?Q?4SlKXJL5PcI+K1nzCtsfdBqGc+DKs63LXt7LEHo/7ww+KprIMuPBoEnpeovz?=
 =?us-ascii?Q?1GP+P1q/UJyTvJNG4FrmxVBU8fQFaZRpwOhHCSua/SjgWr1QzrsC1QnMP6XD?=
 =?us-ascii?Q?5wZ3U4/AVD2PqFGav97j2P00anWlGGdAqAnrAXkdqvptsWrpdsfflNy93zo1?=
 =?us-ascii?Q?IuKOPb30Q48ytnJ4dgVfbxzm6FucMVvlMq7GV0nrJt7OhwIwtTLf8r/3X3fZ?=
 =?us-ascii?Q?/vloQU5Gkivkt9YH5lGxkZMWHfNulWFCrHMgh5q21OmGueXckoGM15c0H8tB?=
 =?us-ascii?Q?2d5RR2uFkvmPmVzO2vfup/ZUwSqMrAIWAJYtWzEveFlZM0nQJYRqD91sNKaO?=
 =?us-ascii?Q?w6Hesv/npUmXGjKtXErC6Sr2L8AT0Yy38S0wFJpmuY6cYYveDwcAQGtKOddF?=
 =?us-ascii?Q?IppTa0bsrVusDG1NTrWT5mOurLgY8r+0pZeaQi2rgmZM8/mM1pQ8Xl6alkwL?=
 =?us-ascii?Q?sB7trshHyFTqPvjDKbuKYOJnt2wdQPZYcSHC2yBTGo5o6i+3dMEwA0dmOMyn?=
 =?us-ascii?Q?DJkEeNoMQCzgtvvmfhAjhn+GMH640jSH3uv2GOB908UUWysA9fF4GwHgQEH0?=
 =?us-ascii?Q?SctgP07JNAtt37IGFT6xoIACsB4iFmVj/hq39KmBXeE5AMqFByxtbuywyWMS?=
 =?us-ascii?Q?yOGf8SSuXruxqWc52u8jKWsIhs4lzO03vN0K1wJvGldJeG0/z6x9NX6MGb7i?=
 =?us-ascii?Q?s7sKP0y9hKZVbCDj6nLemgapxy3CuWXvP8Y2Ux8LL48p3IVSepXgnx7ao0Z8?=
 =?us-ascii?Q?lmNVWtPWc1FD9vfSoHdkxeMVLk5REJRzCcmF/CHOWF9XCoi1yjBdqsZTqTbb?=
 =?us-ascii?Q?P58B7QcOOEh3HIf0qRywmMHHUqq9kg1iLINAypDG6ce+BLvue3NnKS9RJea7?=
 =?us-ascii?Q?ptJzkK1GT3bSMc4XBzM0zK3kpk2hEe+oq/46a3036dVG3YeChomEH23BUevq?=
 =?us-ascii?Q?g3KYnB8n+gqHIHTF83XVwRLsbbGQdce9AMMBpFKWOpAHXLCU8TXIb0J31xnH?=
 =?us-ascii?Q?3oSr0slJNRlUJTNKLK3TZ4uaMSH2djK11ByM5054HoJ9MI0bM2AyWoAApNaa?=
 =?us-ascii?Q?51vto/2wbCp18YlTr+FBV8ZFjyzR6LjrekGSRcrqsgTRSO+HYY51CQBn+GqE?=
 =?us-ascii?Q?wgWNvVa5bE8nX7M=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9dAK0++NWpGOVY/IK2tL5G8ZRvPoBXiPgeExQgheYpXwEWcrojSyhvmGX079?=
 =?us-ascii?Q?MStgBgpwbXcZq0oHctM/FsS6bhT1dfDvs2JZqtIC4NSJScfyK8R7QH1cFMND?=
 =?us-ascii?Q?0Hjr8+9PZdXz4f9sAboy6cczyygoiTf4CFNOGKePn/7HvRqb5UPHacXgWbq7?=
 =?us-ascii?Q?epoB3ZOqzp97k/+xsijAyEYr1ohIzh/NL/YFiqtri9hQvs+oi92BfV8KsfM2?=
 =?us-ascii?Q?dsHzrvwXvHtgliiTpOG4IcOI5eA2js5flUM0NpDQuASspk8fhFe7e/YlmLwM?=
 =?us-ascii?Q?Eo3v5gCrsmH6PmJEU0btedwu0ok6T/1iedBXMf6dLF2h4WnhlZ/GoGzYBMhu?=
 =?us-ascii?Q?4gfyf0vOBhdJ0MR2VZcVxtz0XuCYOgkxQoKnrupB+texocnGjWyLccpnpm5H?=
 =?us-ascii?Q?wmvocEqXPiIVbhYPphOqAyFResYIAGRVcTlFIBlxpLGSCQokfmkntNzGAc0k?=
 =?us-ascii?Q?lhalha34yARsEsIlYqnwzIL1j149cadi0rjWZ5vkZ8lHLeN9B3lfGsB54Aos?=
 =?us-ascii?Q?AAEmD5SzUVhWk7ulBLlI32CHQntNwG3z7MQUH9cfecv2Ozy5/dm7aLPsO1Cj?=
 =?us-ascii?Q?l6D8ynEPsOgSdIqpDrkyLfNve1pBIRbvZuU9Cqb0odPGQJ/A1aidQmtsVVyr?=
 =?us-ascii?Q?KxUYwkk4iqv3lJ83PVxHq6uFjdwtU+1HcN4rcgZ4jsihbNzLpMRi1xE5rVqC?=
 =?us-ascii?Q?f3f58UAYNNtUPDT3oaWa6WoU+6tI2hCtDaVz0Up+OFsQKPsAGKYI0Ti2Mgsy?=
 =?us-ascii?Q?fTaWi+dOBxTSyVPVVNL9y+l+VuRUAIPEaQv1T2ktyyKrKMYz2hZNjpioz/uq?=
 =?us-ascii?Q?vwtbQpR0mABT2FFB6SclXKPU73xK7JhuBdzgzeT5QuWyeoa1Ap0TSIF0RhHv?=
 =?us-ascii?Q?fyTtWDX+Rk3fXkgt2U9lpaaarbrdxe2ogDKUtAv6PizKyXTYQuWLaMPAgNUY?=
 =?us-ascii?Q?nwqIZqOJp7N7eGfgbySeC+yhUQzU1nWbW7nYkGpAhcgDoo91o2VVFRpIKHXA?=
 =?us-ascii?Q?g2ZpRAJMT4tBFCj/aqW88Zb8xb79dU900cTMIuTvkQZMn0RcTQbU3Xii7hSq?=
 =?us-ascii?Q?hgxhfYh2/wGJ3IfJcf2x3mFPbOg4tcGuIYT0yRa0yfRZcYAFHwMiPDFb1PYW?=
 =?us-ascii?Q?Yw4ZaZOJl8GtXJ4ufaBgIL/sue4yD6A/E6iQO4Cal7Xt2PtyY5jTD/dAe25Y?=
 =?us-ascii?Q?O6J1ZZtYKAeWBswMUikCEs+ju30PXVXKC/p28MJZiQ1h4f6qw1gXhfnbve4O?=
 =?us-ascii?Q?r8x+JQUuk39cQCk6vYkmnFkaFs3dmrpjOYJw0uMdckCC5GEO1PkptOO+kYfT?=
 =?us-ascii?Q?LPhzXpW36QrBBagnM/P8dWkNZNaeOMhK9pKkYwfPnP8uWQTfzdSqDtWe6yTI?=
 =?us-ascii?Q?A8JMc23l9hVup1QtotU6s8dlAQ58M6WhRWXzTyM1KOLjQPf1TnJmZjT7A9CH?=
 =?us-ascii?Q?L7proJC02v2T4flUZoJdTQUkSi8kMTH3Dc+C+3nZWZ8M4iGwtHuxFyxkGSXt?=
 =?us-ascii?Q?BhGLAU3s65hIUrGYagznj6xmyPzCjEL/epsHiwIrfUOt5fZTDflJEKB0lCZw?=
 =?us-ascii?Q?YJxMErCdU3xSiwki5vCkQTl3md9ZpWf8P9krrAlK8hiKoXFjEw3lxWTJafSZ?=
 =?us-ascii?Q?2KM1kB6dN72DOn5FxcEkpYw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff67c7d-0a8e-4354-8594-08ddb240d7b1
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:29:32.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IecWHec1iWyUXEjlTBdUkOROgZ+y+kBXCjl0tr+kHaYzxSMLuTG7ETakiy5knBrUAmt9xq475toZ1tfF7+diG6Pa0wmEQhuRiOlxCZFoGHJI5XQOL2k9fc3xk3jbTob0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19180

From: Biju Das <biju.das.jz@bp.renesas.com>

commit db2bbe1e6c48f03ed1f5ac57f5614d02351dcb4c upstream.

Enable WDT1 watchdog on RZ/G3E SMARC SoM platform.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250115103858.104709-6-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index 6b583ae2ac52..f4ba050beb0d 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -26,3 +26,7 @@ &qextal_clk {
 &rtxin_clk {
 	clock-frequency =3D <32768>;
 };
+
+&wdt1 {
+	status =3D "okay";
+};
--=20
2.43.0



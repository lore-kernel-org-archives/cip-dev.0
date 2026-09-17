Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FE9C982D0
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:35 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35311.1789636591908883894
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=iAHpNNRq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.7, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9jQBKF2CJR7rjUF16hVUNNLjzQyXOULd2cQ3YDANwUS5RQaPNOe5olf2EcZx72K6TiZYz0/iLpgPXRlgRE5BuHqImQNeGI3OQFRqh1AyICnQxkeeHSj4pLLHG59PhzudLjWzx5nCALao993271Pok1jqfLoPLAmTt75X9+REaLUfkOblQ1txnQ6KHogMJm9/Fp+xTKLZ/YmpSTt24xlyRIHasZ/4NeU5efDHFxhOjsCcVpv+jorMUb1dFhYsEauJhEy9LHUql+3KYKOwaGB7unpkMDdDmUaN4l19I1dvJ14yyDQCWluNakWsHU5rTkQ8+8PyDJ4DXg5pifOITP36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU4UF1d7MM/FfhvpxSr7aaOumErEENnQsF7UDqv3xRg=;
 b=dMtV+dRdV52VyNpOngVb3Y9woiEpOPc5h37O08q6CJHsy7Cm/rLMOnyv6cODuXS0PZ5F7nvj55DBGj2ZuZxmZ3XCzdMWPlmu2xIQRY+OHuQ7Ad2oaq/iHp1VJohw+cwc9cAZMemotLhkuzULf/5Onddhsi+p8DwANGII5XkGj0FppFMOowCD5hK9AHG9+rJIdH1Ob9YRqbARXIaGx6bPaK8UsPf33DawsjwhF791hD3Dh1vKJMx4SS/eHSrhPM4Ag9VVTYAI9ZjQ3HGJg4oTUvR+zX6Eai6Co2oCHhnf4BALLbLSmnfCb3f9SdmHfR/qvC1uMlEv+N81msUUXmaZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU4UF1d7MM/FfhvpxSr7aaOumErEENnQsF7UDqv3xRg=;
 b=iAHpNNRqxQ9B5dHleeLdFcJ4A/g69p5iSlSnTrPk7Qw1Lzo4TJFKRyd8JYRL0KpzTezM0CQRYFXBEmt/ZT8IA9zLUP/lWx+e0R2rqyPzqM8hKbeIvibhGVz3VWZbo4gfc3kPIDR3VQi3SEviQ2h1k3yqASyERG9S6iisHv46Nkg=
Received: from TY4P301CA0036.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2be::19)
 by TY7PR01MB15780.jpnprd01.prod.outlook.com (2603:1096:405:2c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:16:27 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2be:cafe::aa) by TY4P301CA0036.outlook.office365.com
 (2603:1096:405:2be::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:27 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 1FD1A30007C2;
	Thu, 17 Sep 2026 18:16:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/10] rtc: renesas-rtca3: Check RADJ poll result during initial setup
Date: Thu, 17 Sep 2026 10:16:13 +0100
Message-ID: <20260917091621.18551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TY7PR01MB15780:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3ddac4aa-7b4b-417f-e097-08df149c5a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|11063799006|18002099003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	lszv2Ea6PjZmy7JHGGoRPZJtLHpkQPlZbyPd0Lj8qucKnxWuXjAMD9au2FuPW1Z1st4pjMacfWwS2ZmRZ15Vw9JBeOKBYL5cb9gZeZkPTelwwZCJ8G2e2T4ElRGPD8ZbBrmTqtXCIF43Z5oi9WFgX+KhrRoiPt0vDof90Lw75RIprxkSWCLIvUQYby3pj1QjDUyHh7srS6gAvzucIddV4mTxQw/NVZkRvhtt5rVb9ySsPLhhl/hOZfsJZXklvfvtnZ/OCDRNAMEK6j8xA6jVLmLKUZ6pewmr0MSEtBhg/PK0/ioBfbSAs5l72IhZVEaXT2zl6Mnp3Pnz6VpEQ+laUaGhoQx78X+SWuqBi+lRYES+7sCHZScAe+Pj0NDyZGrOSIvpm0PfpGccUEJa3ZT1tt7pl1E1rr7LpDclGbhhJbXIQ/ZaFYi5jwp85XRhOgioUm03NqLdxsinhGXHNxnQAICK2zxya+KnU99Vs3j8HpClhkVHWzSv1bt1TnC6dlDUhjsDgIEpuDQ1vrnfP1oq4XrG3Pkzxdgeyuu4/7xd4psEwrYBE0yj5gZM2t9INgu2GnaY2QtbWkGHmjOKaWkAgdsMGAQNwm91fB2smECQRfhhxshBbyi1KSWadoEg2KvgITZgTjRcRxfJ6mWX2O/HEg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ZnhQxCwAVh7bhE3LbsrSIuLtiK5W8v2nwPkrZjPxiwe6mHnfbGFBjCaok/eHhtgw13rY8e8qsr3ZsTK/hLiF2OCaUP4un1DI3hIooKrQFTCNuVxcPUckWpLw6FPY53woSEBqohkvSSPJXMcdSpw4h9BxJmYBaMqlpsFWYjSqxZ0BUt1ofUhBiJUE/Uu2Qo25i9jQUNmNWmxdzNvLfrej6gnAi11ifhAv3BHNbnh/AkW2BeTrtWBGCWIJYAfE7+YIoOxkSCMwMkmvBmD70WkHTnRUozAlZsk4UwYXgzpKs7twBsd+W7j3A1BCoBNfXNqgLfgMSXFsD/I7eBW7F95IQ26iDFQK5OlEWwh2zoqNq5IwKyPMJ/FQ0mAHew8l5rrHzVqfir8dutvYADvN8BiKMFlq43kZO33zFRzquIjB5Kqf63CtxFUMyl4DaiQ1Flvy
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:27.4400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddac4aa-7b4b-417f-e097-08df149c5a73
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB15780
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24210

commit fafb016d081200c7652e84202f8ba5951e659a53 upstream.

In rtca3_initial_setup(), the driver clears the RTCA3_RADJ register and
waits for it to reach zero using readb_poll_timeout(). Check the return
value of readb_poll_timeout() and propagate the error if the poll fails.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://patch.msgid.link/20260602192559.1791344-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca=
3.c
index 78d2418501b38..77739a40419cb 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -634,6 +634,8 @@ static int rtca3_initial_setup(struct clk *clk, struct =
rtca3_priv *priv)
 	writeb(0, priv->base + RTCA3_RADJ);
 	ret =3D readb_poll_timeout(priv->base + RTCA3_RADJ, tmp, !tmp, 10,
 				 RTCA3_DEFAULT_TIMEOUT_US);
+	if (ret)
+		return ret;
=20
 	/* Start the RTC and enable automatic time error adjustment. */
 	mask =3D RTCA3_RCR2_START | RTCA3_RCR2_AADJE;
--=20
2.43.0



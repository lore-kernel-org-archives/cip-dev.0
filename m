Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5782.1794388760053885324
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fyKyc6DF;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.1, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToZhf81+lHSsOMQKg76gkoHj6eGg8t//S/2OGqyAdjmMGcTVH9+ey8Qq20ZvkZdMOoW9L2O5yEHW544s/A6NsOpeRBGZzJoyoM6WfDAluqtukI5uAk7bQ0DAVDjJerRly9lB+9LrXPXXXwx/VCijbpQW6GI4JWlUt36XAbhHBr7Wx6ueeGtS3PpEvFXwUJ9D3oqpLloIHbMjuhSNhH83NZOByOT/+3RVDrcIgwr4TG8SkMOov9u78c2knuNSUGRYri3ol7Llt9X6jXS8Z/fbzlVYACoh8+DfTabA2074UsMutVptngsXsPnFT/DBr9kzMm9yeC4d5/wvLtCUqLmLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjezPGtQH/fzyxFMhMOWxuiW8rlCtnrIbkeEdlUn5as=;
 b=rJRPdJmhZwEbsg8OCVL2te9v1cjA0TbmTyMrw7cRoEhiF3Vi+xKkNM/TE+TdlV6AXDxRfZU5+5LdGnCeCikL3KxlT9MF+rFoEY3+/1kgIhoByq7hvFqPqDoxwYeVtT7kdlKYpdyQxzgRv7Jsn1eih7XCXr91k5JcZGgEQYJHHDeAD1oPVuCToTEf3qO1GbL3SPfg1CyY/vwEFIrDItFjDTu/lhQB3JMXsPNWhwgxXSKq6XMJDEXZjFtEl7+yiHQgCj7FbK9Ejb4xAC5NxXI0jehEflB+Tu5nhnoTFzcZEyCxjuHm0fbsgNuEKDC5bXaYHz/ZqX/l/0i87ueXjuiabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjezPGtQH/fzyxFMhMOWxuiW8rlCtnrIbkeEdlUn5as=;
 b=fyKyc6DFVlbSE74g41YgIrHIA6TcK3j2BGRfTPPlfgYEGuYju/jDfZ3HflwmFq2R8+b6rjKqRs2F6gtTUHBxAv50KbJCkNykgFSX4+EAnlM/TK0m/B328kVWq1JwaKkseJZmPPJ89gJTAxguFB70G8MuS1L+En1XfMfrcKauXXo=
Received: from OS7PR01CA0137.jpnprd01.prod.outlook.com (2603:1096:604:25c::6)
 by TY7PR01MB451347.jpnprd01.prod.outlook.com (2603:1096:403:405::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:15 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25c:cafe::9a) by OS7PR01CA0137.outlook.office365.com
 (2603:1096:604:25c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:19:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:15 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C90C23001DE8;
	Wed, 11 Nov 2026 18:19:13 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/21] rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
Date: Wed, 11 Nov 2026 09:18:46 +0000
Message-ID: <20261111091901.41995-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|TY7PR01MB451347:EE_
X-MS-Office365-Filtering-Correlation-Id: af6d5542-0e50-4f5f-8df3-08df3fd4db27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|261009223027099003|22082099003|18002099003|13003099007|261021121427099003|261102123227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: fH1oMdlij8XBMP0sFZX1y+Zm532i880Xio3RVNyOVaKhwpDnZDEXxNQVry2vg5WRrJoG2HYQ1KRWnawIgIpWPvVcJ45vpGVOT9MYcZqG0HNmZPA4l0vbqhsDSwn/qM2B0htMREXrAXI/ttJTXxCZW+UownARrbqMPikVqkrgVMJV9NiYri0wB1wIJHTXrcHoUHFrZUNqWTmOi+lq70jM7mMy0RBroQcg+Jy/bnJjIYJEiGFq4gbt58p/g9P1FfGu/kyuHirSBwlc7nMOdDgcKvA3Sy+yc7DsbbEAokmDOJwjmm2dJnSrD0Kl5XWbYn8hkxJJB3XQR5M3E+5Uqa30PkUMXBEIEXpEWvVNMI+vLZLEjrTiGwPNjGiM9y3Rllfg0tUWfqTgFmE+7nTm4lNRsU5tAnYc++0Nxd1VxUfw+/L8dJHQaazBjfWKlzVaUZicAn5iqP/0/cRRVfj5kZkzs7GIYbA7JGheE6YtzpT3dFwbs5O2PCVlNiP6D5BzXQmtZ/MzQ7plZ1A3xyYqiyK9/dmQBouGzAS1bOOmPcBmjg2b7zCG+uFhKAbj9IDzYYlkqnJ+xiK/TsbgyKmE5A9QhX9Vzrwi7jskNmPuWam+5xdjeWpR5fN87lFT0XMXzorF/wEycv0m6tOTb49/KZxaTQ==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(261009223027099003)(22082099003)(18002099003)(13003099007)(261021121427099003)(261102123227099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oden4VK+8xe5jiie4D4c2K4fpoIaVt9PNFVjP7mfEKr4Uz2pinMR1IQuEg2ouUV4WZr9BRcPtcNx4Ng8BcdBs14IVKmuxOKmSKfkVZjGuO+parqfMqYRIpONE7EKqutXma9NzAQmfDvtm+/5tjtZZawi30AQ0Ga/4U1vjyYCdEsDZGk7OsqmVdHr7iwuIZPbkECFWFU1vvlbULes/VHrs1VBeroh5YNFWZJz6/bKd0LihULLlbJ1lrDJdp9booB7S5VXlKcjV1CRv8XTXyhI9SKF15GQE4lqTdikVxjiF8WvyiSsWHiiYCL05X0/f7cSwwcocF32IsTR9LIGjWy28RYvHBROlNM8PT3xbIqHJ0rbcdE1awaxZTEiWQQMTi3ZjRiCGF5bnisSjf0UsrieGcZJ47z4y0H1F43rBTHP85amSsnECgmret+yplfSnvgn
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:15.1662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af6d5542-0e50-4f5f-8df3-08df3fd4db27
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB451347
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24748
Content-Type: text/plain; charset="utf-8"

commit 708546aa39560a11cf44c7ba99492c8395a6c2fb upstream.

Check for -EPROBE_DEFER from platform_get_irq_byname_optional() and handle
the deferred probe request properly.

Although the "pps" interrupt is optional, an error code of -EPROBE_DEFER
indicates that the interrupt subsystem is not yet ready. Intercept this
specific error condition, assign it to the return value, and jump to the
dis_runtime_pm label to avoid ignoring a valid probe deferral.

Fixes: eea7791e00f33 ("rtc: rzn1: implement one-second accuracy for alarms"=
)
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 03411d81b2772..9b624f49f61f0 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -473,6 +473,10 @@ static int rzn1_rtc_probe(struct platform_device *pdev=
)
 	}
=20
 	irq =3D platform_get_irq_byname_optional(pdev, "pps");
+	if (irq =3D=3D -EPROBE_DEFER) {
+		ret =3D irq;
+		goto dis_runtime_pm;
+	}
 	if (irq >=3D 0)
 		ret =3D devm_request_irq(&pdev->dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC =
1s", rtc);
=20
--=20
2.43.0


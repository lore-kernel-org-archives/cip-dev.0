Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5788.1794388763818762315
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VsR3x/fW;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.63, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbCqWVRMgkW55d8xevYPnGaBBnbXvTeCrYu3QA61SUHxaa7fJthOC5GlkP/o2mNEgVEkqt8ZViOvxTafUFxPnexnuUwMkKLjCxkDepv/29Xg4CQmesngQpQ+IS9GaqEllgjfYK0r1kAt/rlXZtFLBiN33k47FbdpR9gNF7Ldza5X6jnuCPundzkfD8l6BcXCZbwJjhPaPqQj2686lENakn9Z41I80ZdGZiN7XbQoPZEgO3dyt4D1MRqNLf2vt/RLv0zSZOi7KRHimslzM8sNJn0MIDmIlBmrQ8oeL/vBT8XbhhAEnXfTLTo5sk2onweaE1Ehi0SNqIsxKXQh7Nk9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T5oRwQn5pyxpt5prgsht3ky2XfWtCBMMpvC3HxjaXg=;
 b=Lj9jhDF/RDtKXBJLwYpXHBhsqjHqqz7KE6OxnqrT/t2JvGTE7g2W8PhP0U/1JjA4x+zBnbg/4vUr389r5yFBWj2LUaE9m8CUrRXOkFJ13jV/wI64ahoNh1I+su/qkNuSUUnvdesRlyOU03AzNR4jfzgGGiBLFrCv/SJqtLTb014tCoLECZm7HTk7lb68hBmje5iNPU7tIKP5DYDIJC5akA5qF8vRSMZ3/2MhanxbNlJ69edl+IzOQxrNdyaQrNHLQs00p90uVq/z8uNrfGkgsSOBdf+UxQ0QhaBkYGzT23Ku75kHhgsJFpnxxmIhMGrTUEzu6asapA64WI+X4sgA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T5oRwQn5pyxpt5prgsht3ky2XfWtCBMMpvC3HxjaXg=;
 b=VsR3x/fWFK3V4qvakpcHCf23rh9qNh7OQSfuOaE1y5wwThnfpQw//kdlYSBEpRmBdg3lIFsemeQaQoCl2DJce1N+DUndYA3sd6FasZX8jzYBHLFcGThR+cEncMrCzl/I8vad171pkiILmT0hzBy0FEl5KfWd/xD5T/A33K+nHns=
Received: from TY6PR01CA0030.jpnprd01.prod.outlook.com (2603:1096:405:3bd::9)
 by TY7PR01MB13751.jpnprd01.prod.outlook.com (2603:1096:405:1fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:20 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bd:cafe::45) by TY6PR01CA0030.outlook.office365.com
 (2603:1096:405:3bd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:20 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C1EEA3019A06;
	Wed, 11 Nov 2026 18:19:18 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/21] rtc: rzn1: Use pm_runtime_put_sync()
Date: Wed, 11 Nov 2026 09:18:49 +0000
Message-ID: <20261111091901.41995-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|TY7PR01MB13751:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1b01c6-620b-4b57-becb-08df3fd4de10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|11063799006|261102123227099003|261021121427099003|261021123027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: CS9kcaZklywFs/vrq0DqWT0rX6WfntWm2fOc+XbCO7vt9JSU7X8eKzCyb3darwV+KVJMj7ZHWFjmlR+3yd9dzmqVbSZB5CIrXujY1cPjiZer7G/j5XJLFT4aFdrWRVwoNVFbrMFgoYdrbgBB0/1d+yMiu5X/0kizyysShdriHTehbNhoWUzcme+5GXf/wckqKZgaulvyZMtEPo7Oi1akJ096sJYu+zvnAyr7yCS5PtnZLuJa2CvSLLR0W2xtpD2d8/kXr/1ewFHafdGE9DpdHFbH/wQ6f+v/7Vt+u8ABhNvtDhZWnV55pntbfQvOlCqyD5ZKWr+rHBZNc28XJd+58nqeLCPkWVxKN7CywqPFiinRZZkRzsqY1ybtz2OwynAXypOPAxpMf+8K+TtVnV2QkDWDaziLVQHs9nQEm4G2s2+j/PtKevOtKvYR/fUz03/GUB0GxDtpWak+uAR0Tq05nUw64TCE76jIzoZAgpDp+9F4C/0cctTpNBAXdqUzKtZh5c2alnbFBg+DwD3dek4wtXhOU3wOgxDfbM5QcGRJLkhwoXIweKS5tRCrm861agF+4HSNwE7Xg0WXBm9Fwh15UvAm0c2RiZfT28YHkCOhO/CrGTKlRT9yo4rWbtmru8sqZwwxjFmkMN9bU1XND4ca0ncUF0W8yL0kw5WoG02o/Ik=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 23shtMlTzcry16h1b4yojZ43uMu3xUY8/ilvwBr9toGkGNV8LVCH6JrNJb9gUQd42GSLyvL1FT6lEL2hJ45xETKtBs2jWtwQSwpyCiVqBmhZiYKyHw6VS/fWp7/3esjIIXriaongAbAgU+2242yVt0aFgKKztleByPMBDfCyi3KyVwxOqtmai0rsbPRVtEnCMfv0O9VEnQL6hGDw4g+gpW9UHfOxZIeI98hP1NLR+gs56IQJwLLQiPZdTQD8GorSwr3edmVkaNgPv7kYqwpgTrEfPAZ8yO6CUEboRKJN/LWnTKi1IuQ4qcjx5URAE0XPDxM1kVuezmEyb4crbwNS20SMeTgvPQFpdHfxGvzS/eDHlLRTArwrSyA5QowxC2ggSHVJ7suPjDaUE13lVF9Cnsew803FbSbr0ZK+R5pa4tBcNg/81iSP+j3VMYINzttG
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:20.0642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1b01c6-620b-4b57-becb-08df3fd4de10
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13751
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24750
Content-Type: text/plain; charset="utf-8"

commit ea0ef2e7f83be647be114d8cfaf701a5146eaa90 upstream.

pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

Use pm_runtime_put_sync() to ensure the idle check runs synchronously.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-10-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 0407b48af8665..7c582f9264923 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -493,7 +493,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	return 0;
=20
 dis_runtime_pm:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
=20
 	return ret;
 }
@@ -505,7 +505,7 @@ static void rzn1_rtc_remove(struct platform_device *pde=
v)
 	/* Disable all interrupts */
 	writel(0, rtc->base + RZN1_RTC_CTL1);
=20
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 }
=20
 static const struct of_device_id rzn1_rtc_of_match[] =3D {
--=20
2.43.0


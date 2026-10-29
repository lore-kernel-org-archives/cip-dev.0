Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10411.1793276084208471056
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 05:14:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kzzxTNig;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.54, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgApZ6t9yAVaDGO7GDi21wai9Yl35OwGpahfKGjkfbsrOsLlisTmBTf21ygr3M/EzL+WOlKg2hJSk/WaHIE6hAm3jKhH5OQ1TXIWJU7p0q16X9k6N9Tlvmqk9L0VZciPUWR8X2TzIQeMstLILmcRBVM7qfPwn7oftKNa5SSo5OH4ojIEj2dFp8cmZuiMy7cY+vSJ++/641p5k81ETjwTLwY74JDc5EUiPZSeR2ZJL/SkKshy8FfYJhA69QQziix+WzlJ1scMHydMFGFRnHN60cw7FRhNH52ZnNMnIAcy21d+CkM/Kq97d9e0N6SAa341fmRuaCdg2p95y0RxcbmBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCjXJkeHZPp1uoopCEw0HDp30SmoNYugyHZL4PQ39+A=;
 b=jzq3TCQwM1ptM+010rn3Ih5/0uI91sG7Hb9gzYMXe1ymxIGIrAnesKfpSHBgzh1bp2Vj3u0GGuJUWPRUb6Z8W8aUkFtuweo0eAf5lom7WYUOwfhlqhlDFXvzUiB0ObeSnrz/azYqw0EwEkeexBhPIR+lrMrL1J6FNi7Gm/00L5ZSJT7xwfxb+zDnhn+xwEc/ben8dUSG3y050rTjgVEChBygboUipuNF1Y85ITX1+QPkFW7uR3xDmWyPxoyCI4ezOngWAjTNGTombQKCLDNDO9O2n/6poJY5MOR9if2som6bVlBXNp3A7VHpNhUOmQauRvvHuoM6fUP6zIHKNRkGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCjXJkeHZPp1uoopCEw0HDp30SmoNYugyHZL4PQ39+A=;
 b=kzzxTNigbm8XA/gbFkQYXcTzXFtU2lE3NLGDBAA3mYOPUkl+NgVRarIpbND8dbosMmPt2B7wJtrhsTmB03++KyRAslSyXMozfOpVbU+7pAn6wBk0pN3sQEwGjL5s3tJjRWv0blrtKA7tDVnZ3TEygQI1wjAkns2wSvKt0oHIX5o=
Received: from TY4P301CA0079.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36f::6)
 by TYWPR01MB8675.jpnprd01.prod.outlook.com (2603:1096:400:13c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 12:14:34 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36f:cafe::13) by TY4P301CA0079.outlook.office365.com
 (2603:1096:405:36f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 29
 Oct 2026 12:14:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Thu, 29 Oct 2026 12:14:34 +0000
Received: from Ubuntu-22.. (aut-5cg4070l2c.diasemi.com [10.24.0.241])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 8BCB1300020D;
	Thu, 29 Oct 2026 21:14:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 4.19.y-cip] mmc: renesas_sdhi: abort tuning when timeout detected
Date: Thu, 29 Oct 2026 12:14:32 +0000
Message-ID: <20261029121432.4909-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TYWPR01MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e94c19-9f50-47bc-9700-08df35b63202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|10067099003|261022075727099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 1cGBLnglO7GoRwTdXIfOLc0z0UpKW+DmVHFDQngZ21iYsh+DJfgq3xatuIWmC8SzLQnooJX7/eFmeht62mpbhuuSbgcYyw5hYVWuMTgBEwIXECAX/XkIZY38DXbZLmio2mGFs3oOtT1jRSKHU4M2QpLoIZZEHq3uqYyYysNjR462lcL+V+8ecnmyhH2MuPK+qyBieyhukrcp2J7A7nbYqONvgwjHqwsu4b7myoaCdNOMQnwQKK4r4p9pAMEK/vMTHPsDul1TWMjayQvkvK1NeIf05o/f46VTnCB5hKX3WXd8zd+ke4lcYJK+Qo0nKP56es8zazZ6GWEWxOcqQew3qvFeWANsuw1IBOQxS1t+4VFUDXTTHVtBAh/xFaHpk+tGH89t/EhYYGvoVMS57CoyBW3AW9lb+KHslIYluAtoZ2IxM7wQmYnXYjf0KuR6XZ4QOPAeudqkkT9pcaT8N6HLSo4MhwKPRhuVDIbOB9YyU72fT5sHzmaQPTUGLpo2VIAgfBzjX/akOnsFB4aAvGOZkHDfypB6oRcz1J2TpZmAoqpRrO7vr77YPnWWmvAgXP4WnhRAnIQ3CyrT9J0Fa0rHwi9eoEop6S3qijPSdWKiXyHdptfdcBLr2CFCSjPPezOa+5RlxdGZcGXGPWrqxf1Taz1IfvnXaAN3Z6FnReNxV/c=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(261022075727099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DA94cshaGfzNsxGBAxhgNQn7LTHmlpLxnAo2bfAOo85Ewquj1aFnefQ69O+bUNFl+nehAioqgec5A9Hprjp/z51Ae+Iuvc48U/vsd0pG/hXW4QPjvbgz6I5UDph30bGkeYgixtecgMUjVeb2l5nBpM0ok4LdN2Jh21PmnfHYLeDqi80uWAcPirSKwHeQ7uV3gBJW4pTq1aYz8RAn4qZ+5VCdWLhCRDDmym+bBqxnA/A20VZM1ztmf8nmyGOvTLzpBF53V8PfWtLyTHU73HJNDrRCT77igtdkHGMVXGgV17GxYvi5IdBZCagFnydDAuGFBsOrwBsIpcIqsP3qe3GH8J0ZJb/BjOy7oLvdIIBDj4BjDW6hvZ33rdaHXtajh03ok0YSraRTUc2XQHIorYIlX2rM9OUrYRibndN61NaPHE+C/gL+oMMMXWe6YWvG3D+H
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 12:14:34.8740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e94c19-9f50-47bc-9700-08df35b63202
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8675
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 12:14:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24569

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2c9017d0b5d3fbf17e69577a42d9e610ca122810 upstream.

We have to bring the eMMC from sending-data state back to transfer state
once we detected a CRC error (timeout) during tuning. So, send a stop
command via mmc_abort_tuning().

Fixes: 4f11997773b6 ("mmc: tmio: Add tuning support")
Reported-by Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20210602073435.5955-1-wsa+renesas@sang-engi=
neering.com
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_c=
ore.c
index 72ac12eb89b0d..caefbacf56f5d 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -745,13 +745,18 @@ static int tmio_mmc_execute_tuning(struct mmc_host *m=
mc, u32 opcode)
=20
 	/* Issue CMD19 twice for each tap */
 	for (i =3D 0; i < 2 * host->tap_num; i++) {
+		int cmd_error =3D 0;
+
 		if (host->prepare_tuning)
 			host->prepare_tuning(host, i % host->tap_num);
=20
-		ret =3D mmc_send_tuning(mmc, opcode, NULL);
+		ret =3D mmc_send_tuning(mmc, opcode, &cmd_error);
 		if (ret =3D=3D 0)
 			set_bit(i, host->taps);
=20
+		if (cmd_error)
+			mmc_abort_tuning(mmc, opcode);
+
 		usleep_range(1000, 1200);
 	}
=20
--=20
2.43.0


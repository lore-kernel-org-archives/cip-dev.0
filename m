Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.483.1795708604113983537
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:44 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=H4NUwHrJ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.9, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BB2y0Qcp08G8FLdaPHM+PaVYHgAtjIgc7H1aFGtGGgzeTH5JkL9XtEJmmE+EJLy4ANX5nUk7qKtNzvFQZVU849ibhH2ll1Jk9dzq5heQOZPYEwg0weMrObgQv2fFIY3Txu30GQli9k9zdHlRr069Qc9f7yzGnvAFDN6qLZ37yq6u2oKHZi4kc+XKiuHFQFkF5g2Oe1zNm6xVh47Evbfr/7npw3uNYCc0xQGvRMVi0NiqG5T7ONeqaC/1Umhmp6xo9ptSVMHRPZPb8VpUR7Ka+Yji51NthyZwOhqBZaWe+LzywVyFDEqcTakKJRSpj9+v3WpcT9TT3gy9+HyIXjFDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGDXhNk4d1N1TGDS3dkqELwW6DUkKMIdsnWU7v65MFg=;
 b=PFhHIywCDIwSsRtN9oUnIvddSjJe4P22zUZaNUu/Wx3DXrdzDqLeXJPpkUxscA2wNucq0moIQX4NrocAUaE9YGoS+pQo3LbHL8NDK8Uvw0aCSkXQZe8NpsZkfI9kwY+UYWCmUjwAuFMVyP/4YerNcEZ9QujPOjDf0rDlojAvPI2DHcwd7weeBWqXWdcw0QOLN1CzPLe6hvBij52uv7PSU3YxTo2c6P6q7naFBlzm3RWDT5gU00vbHTL4IsLKcOXzY0pLMbYK6LOWBEfRCzuhMFFkchigv7jhZiLAiepXiMRXy3A/lfx/VhPQzNS6SyyjE1iDXAj1eko5qIuhBrBuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGDXhNk4d1N1TGDS3dkqELwW6DUkKMIdsnWU7v65MFg=;
 b=H4NUwHrJZVHDKwAMwFU846C/PQRTMpHLBA6VvHh6VzOtkHxm+lZVnaCQpKbp0txhYiEdufexuPFLVe1VDoKpkuaInX6MMwdZnzh1GqsyaQSp9hWQTbmw2BEINQ2+i+JOCJbI2MDiGskiwgaEUx9n+VExSv/ZDFWlYq2iGMYcaYg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:56:41 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 13/23] dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled
Date: Thu, 26 Nov 2026 16:55:35 +0100
Message-ID: <20261126155545.3834937-14-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b1539e-60e7-4059-2322-08df4bd5dcb1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: R933waYeOqzuRt0416fg1cig+J5Gs0dT4hLaUk0UGpl4gvKkXmjviiIyylHXB2KFwv2UGNjg3nnsu2PtFX/naCaXU7pvppjol0YjoYi3KjIMbvcrmfVzbjYHdCPn4ca/BgL5ObJB8tzvvtQvZUX+OnJW1Nad0GJc0MzDtl/bx+VGVH+qkqt/TEuzlOPP52qi8RfIvK5OJSRxpv2PBHjFaaTA9TFtWylZUSuSIfgu80KyK/2Bxv0iafKkilmQO/lmsNvxFpvnE3zFnC042wi3Qr4XUb4UFUjuPLSc6yolGt2mS953qDdMxeeJ6Oh7buCsXGhwTjSCVJJySjyDgQymS0i6vle4t15vh2iXtVk9fdpAWTID6eXXNpPP7olXNWZkDOirYklGeOKOBBo1Uwr1gvZfVSJKyKgbZ5A4Ur0/i8mY5yPkUCe3tW1b2i1ev2FgPFII9OTT/qj0pE6AFi42TgZxMrE3jE9MxgPG6+NffuXqEw2Kth0S86Dn+QnsAflP6HVbNToMP9/KeoE+Uw/KQi9mBqrZflxGsDsDf6YZ49wKwowUTxQpTJbula27j1y8bOj9NN+/G44xzQk1/kqwlHPseSR9d4eUq+8u/G2kLTyYhFbHjNTzmn0OWBNSBlR+V02Pyi+lYo6YX4HoFYYXQaMI2ozBfM2zKSvyeihr2VI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1SVJvNUAgNzYVLTwwm2TXUngXSQiwDKc4oxHk9w1tHc0HKNzq1Odqq6Tj709?=
 =?us-ascii?Q?RhxS9xV6+HHCw/FbTlOVbnIYUAsGyV1FfHLH1mBMNs+20VdkEvRBZmkjn7JV?=
 =?us-ascii?Q?kcb/nGs85SYUy0C61hRhRhhxTlV5nIIkKrfN5MkDSvHUheTCxLMfjw6kUnuR?=
 =?us-ascii?Q?4diVelhmkBxdxWFBynQq7RQrS55RWco0h4lr6gSPHRYrX1ktQeLAplPl/ERa?=
 =?us-ascii?Q?QpesdnwmH8LWaktlc4FTlbRfvElgHFLiREbAFEy73juQ4Fx112wN8/TRrKC0?=
 =?us-ascii?Q?EqqhZvtRm8yBEOMDEKPiIHM8orISrVFih2NSn+MB8A5ljRHeNo6K9jB7PwTL?=
 =?us-ascii?Q?yhxSQxwB/szafn1+2n1mZZDizk2bYJil5M6zCQvalLtb30wK/HsIzTbnJbIq?=
 =?us-ascii?Q?2S7tGxWMjkTEQfXlBXIGsrXSDI27Rcc/4f0j4r+jbnsvwBmi72ZqnAnY76rO?=
 =?us-ascii?Q?8QI+UIWsg16z3kl+BTxNPuqINxQOwgvVcICtA00QuviS6SdRzdn4Mh3XMsIE?=
 =?us-ascii?Q?pyRNtd2lcEB3XMNJHjENdtaDoCV5E03Aje1G/dUOXVTHo88Yc5mz/TriOvEp?=
 =?us-ascii?Q?4UALqT6+AHg3VX6W+5qHrm0z3Tq6T8thnOc+1KsYEj1XbAhsbHBW9QllQHik?=
 =?us-ascii?Q?uXEMGPjheF2+QnbipOrP9FiS+1Kf0gScS9RnUcBUG7YB0cY3Q2cjMgrg13z+?=
 =?us-ascii?Q?NnWJmg/6aYHQEBgQdp32DLRb5Fn2FIFoFGgqoQjGL6H2vC5zi1gt9YJDplZt?=
 =?us-ascii?Q?/lz7T9wPhGRT65zsFZppQaWtnbpeZhWWJ7Lbo0Iq0FpNYTI/pduEpOeATQiL?=
 =?us-ascii?Q?ojM36XtOzreE1BBKjF2Qmnm5PT/JP7BAmXCsrHNxXqNVby42o9X3YrxGTOd9?=
 =?us-ascii?Q?Tuv//vWfPxeD0MZwcBN/ZMudGMTllWam2QEeibz8FqawZ0hL8SqdLWTJ90AK?=
 =?us-ascii?Q?H0ZEmv6bYwpFvZcP+RugZh5w8qE/JsPZSiaVjP+FLS52WEUgByyuiVkKO15k?=
 =?us-ascii?Q?RIS9MVPYZVl+XTpznxbXdmhiVOVuOhKPARnLpweOUnfOcm5l1XpScfLid8TY?=
 =?us-ascii?Q?AutKf7ebZ3T4c4izF3x5Caec2vq4TO55GKw/tJT/25Sq6V0pov0PbgTD46vl?=
 =?us-ascii?Q?6Dmn6GWxQT6X/ZILRSQoL0uMrTExp2icxXmkbCEDg9jLjEdDjQLFkLm3AN4s?=
 =?us-ascii?Q?4faw1mn496VjCZu+uJojchTNOx1c4hAxG4x68SIkhL/W0c6LiK/PFFN4/XJe?=
 =?us-ascii?Q?mH+H8I3Zwt3ksikLjyWpjEH7eUpCHs0ku+mDpSRU06wqXjzd0TAOcOY6mD8J?=
 =?us-ascii?Q?u23bvWNm4UKC1b5tp8UaoZWZBCQB1jWhV8Vwd2skQtV0GBYFWwEutavjbDig?=
 =?us-ascii?Q?j7DD95qqHqpnB0Pcrt/NVbm5011UVgGcwgS3qpGWTwT74aB7Hw99yf4UEDOR?=
 =?us-ascii?Q?JTWZ23KyvWLIFdBispk4CN0GZJNTOAT4CnzClqUp1U2LzAzTZkyVAC+wbah0?=
 =?us-ascii?Q?4winJn/e4FKMtHj/EpE2tj08Wf0SttyJU6QhghCKtDhZhJz0ZyRudfFEAZm5?=
 =?us-ascii?Q?D51RIk8vaLBX3QabAcXBIGxPK0oaxsl27GJ9iO0QpbbmgpXsISR/V2NWXRgk?=
 =?us-ascii?Q?dSUtf2xHBPC4xrJHlQdyLJt5q4l0MaQDutMDD6hpjylf9EbfAoklR8IjoGo5?=
 =?us-ascii?Q?vVrbDTQoHDG43NX9uAb6qQ4+hxaQ1wEtWTcvYaWQjDBX2KiaPAhoRlF0afaA?=
 =?us-ascii?Q?UykExiYA8KpdZtl2ESuT5H2m/29/Gyq/THtf/cSBa9RjKFczEqPg?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b1539e-60e7-4059-2322-08df4bd5dcb1
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:41.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wZ1pfptPucMuI+Ltcjn6Dxt4aFCvi63UZDPpuGoTIKaWzhW07Ci6Gkfs0Ixe2qv/CMrJgE4IT7jZC2/xXcVwoXSSmcjpRxTA6Zk8FcZ6hfdL2CMjgmo0rkEWTeaUOVS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25204
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7a94c109a5def4f0f25705a82ed5870f794ff4ed upstream.

Add the rz_dmac_chan_is_enabled() helper to check if a channel is
enabled. This helper will be reused in subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-8-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 2bedee219938..aa1a1aaec026 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -279,6 +279,13 @@ static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan=
 *channel)
 	channel->lmdesc.head =3D lmdesc;
 }
=20
+static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *channel)
+{
+	u32 val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+
+	return !!(val & CHSTAT_EN);
+}
+
 static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
@@ -840,8 +847,7 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
=20
 	guard(spinlock_irqsave)(&channel->vc.lock);
=20
-	val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
-	if (!(val & CHSTAT_EN))
+	if (!rz_dmac_chan_is_enabled(channel))
 		return 0;
=20
 	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
--=20
2.54.0


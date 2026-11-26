Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.463.1795708571350725930
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=RWflaE4i;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.22, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsuYKIFP0ZKVPxWAnsivRPu5eo+ZFEM0Nx1GSRs4FydnMT4zzY5SVGfClxAewsbFvwjneG2QHWn4pEfjFda8WYD5tGx6lv8Syt47nyrPuGjEUPh3eKPechdNMEJGkekBgIbNas+v3kGE22zd+g7fr9ApgcqzgnMV07omYdayNGli/lY5WId6qshOiJiTQZS2S/i4p2fDb2l8YTXpQfvKMo8vHarklFBZyErXp10FiK+GIuBz1CJZcLnMp8i3N6jlpWGn2FwdHgqAIdpZkueAaR4BpTl2LwmOf2BPWKfR9Ha0ghaM5OGr6hLTRA4Vi0gwqHtrRIHddkitjXrEinAq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycqJtzZYLNhpHmu+hckQmFrPQghA0CzYKIBp0G/V7yY=;
 b=iqurnOFvLqvADz5zjzvJu+oeCDs6tIo+cMZ3HaBqxbqdz9VzXTKYS6kdFot7MY/jdB/UDMi5hL4Fwiby/P1CpLyzSF6hhtrpWzo3l2rzCU1u7Wzz3Kyi6ljHad0pH0JoO5ppYNJRa8VDlpFSWZ91GNRCbM6YLPCjsguOKHPPqzQptcVMPP33f/A/jYSNagKCHOct7tHMygdrKsgj1eAdegXgmU6OWTnHEsGBkTTiEp4JC0XQIF+MItDqLU2/MgSx/v7tB4MhA2T1Ry10cSSMJu8btsvp0xS0Jx95lZ/3MmJz9q9IqhwAuVHk2Bgu+bwO6I09MYvbm6ehwGJXsLPCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycqJtzZYLNhpHmu+hckQmFrPQghA0CzYKIBp0G/V7yY=;
 b=RWflaE4iobANoBaeIXXyF98qA09nvywPXoeXMHoZRlpjJXMxh3k564SqQKnjw+LQ1zPpUClV/Uw7jxt1ypz+e3vSCott+UKYGjLOXRm66/kngIx3ot9GNmj6QEifkEQenIZITNgEbggm01jtF05URN8PB24Ngs3Ft85y8Viv4g0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:09 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:09 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 01/23] dmaengine: sh: rz-dmac: Make channel irq local
Date: Thu, 26 Nov 2026 16:55:23 +0100
Message-ID: <20261126155545.3834937-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB16957:EE_
X-MS-Office365-Filtering-Correlation-Id: fe107dc6-b995-4ed6-1aae-08df4bd5c956
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|260925021911599003|38350700014|261021121427099003|56012099006|10067099003|260925021311599003|260925022911599003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bSFQl5H8x0swT7J0KNzOvXtTxGvjqBX2nlZzMHKnphbe9Hzgqjywl/dD9YFp0sP7EoYBDSLEA3Fo1svCikAkw1XbBVXpugMM/ByFqs/8bov1m4cmHcnMbcReJBrD/+yIDfmadj83kLjsd0QSn6uTgW7WvnYl7ltkj9m798soyWu0KTuKDyFXYCPLfTErlcbNagZ/1EER1wO+riPqFTOM434dgeS9mSp0QWvIxMEj2v2V029Wob/+cvvON6RADtc2rIfdteEEA56jpSrbjUK/khpw1HY0pZRtJ7/A/tKQkpAeRdaDk41qOf1tRwjrTjbuIE76uWveu0B140iqnBdgF3Hod9HXXKRWn9agIRGzl5a5CkZSNxx3VAXyu/xMswRHESeitAeXRc4Gr0s3cc3unNlTZYmEr3wtkZD63YSylogRIkZcxmbbJ5ES3NWfngtVVm0j2882s/vVlkVaiJ1yLaeSOIKyqChVdt3EX8RqvVfZUrHof/VR1lJHKArJ9h33/dGRYeEhxXHlA2+rKKflv6tNXV0wA0IBva/42UkRBjMEAtYX7Kuz7T3q1HM3J/naXtugzbGBU+l3dERaFtyYlYMKtNBcdaB5s/3GF9AfLKQzZ4utBobTg3ijz670hdjyBFe4TB092nojBgBuZPuEcAbXTpgCc9TGtD/yT5r/b5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(260925021911599003)(38350700014)(261021121427099003)(56012099006)(10067099003)(260925021311599003)(260925022911599003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ta3yhbi2nzM3VAr0tR1mmLOdDKrEj+cJ1U1evLQvDDpXHNX7Hpz0dx6WRV5U?=
 =?us-ascii?Q?7NpIaUTqafpOwXa7dpwElnHyINk60cs32GSHEI9jXdhj3jd3e3lnZ/2HDQ9j?=
 =?us-ascii?Q?G26z6gM/dH356sr95PMCXwd9NgpjQSqWHoYM9mfD/DSnkCi47cbKI1jYL2jI?=
 =?us-ascii?Q?9Oxh1ahyaGBPoH6NZwdkEdK1KXCk2ON7C06rrIWYcUdyLKNIpfLH0Jm0yWd0?=
 =?us-ascii?Q?rUh/tBolfvdPaFOC9G25lkipj6FKqnGsq1zjiT61fKIKiWNFsL4ft4VBW1O8?=
 =?us-ascii?Q?PHKMmnChkdhl71FGR5wJA3ERXjP6nX2Vtw+Jez7iPti6mLG7sHtSPzD0IBzh?=
 =?us-ascii?Q?+ASETplfEZykLhJ8YlA0esS192WpPNqJlaPccCiimeM95b6U0r6DfjT2Qxr5?=
 =?us-ascii?Q?HbG0Fip4shzSrGxA+MVhz/NkjruqPAgujknBRXMkFqEYiJ58Qv+Z3FW4mcvn?=
 =?us-ascii?Q?U0c0gwBgs+ep6sEOyPXavcP6aoyi2DlIznUUIqs5yI/Fs8Z73gXee4xWd0Ue?=
 =?us-ascii?Q?UWIFMe2dQoCZCCiefteOCpeDHn6OcjdqBO8TJ1EMN6KX5OW5P6WZjelm26TT?=
 =?us-ascii?Q?Avz58zLr+hYzpw5M4qVyTXxVooI/L6nv4xe/U9i00t4UGUOrs91Up96Kximg?=
 =?us-ascii?Q?ray/WRQ0ZzVcddt2whE5B3AerdD9oXU41XOxAGHwixF4LMlFAd8AWYuAlR1x?=
 =?us-ascii?Q?1ZpqcDgVvuUi5kNl80czTDou+Ll4ldWvJStUcvPTDVXEXWw8E0dTdgg/D+Hk?=
 =?us-ascii?Q?z9ZX6KaCNgpT3G+F97jiZ/tUP5SyhbIVG2HlheCUoa3OYQU0MgmAREhgVddV?=
 =?us-ascii?Q?b/aIwecuxqJfZ4RJazjzbGssnO8AtZyW8/jq0vIIO3IURfuNWpE9qPJdtv1f?=
 =?us-ascii?Q?cRbQc9jG55Vfo2iyLXdAc2r77guRo9ZYSZr1Q6m38Byo7UXF4Ffc7vgPeXCD?=
 =?us-ascii?Q?KOS4PRTK1a3PQX2x5ktPP5x9HaPtz9BQ3kd8FmqddEouexURB6SJwLuYkmOg?=
 =?us-ascii?Q?YN3Vwzgqj/QYp2OLwAWajETKQMzLa07KG0++NtodEuUOzaBGdgUccd6g9Kqb?=
 =?us-ascii?Q?BSWw2HYB65RKdFyy1bT23Qv+nLTgeVANxnf3wGjUcalLQImmMEUlF/RAZFs/?=
 =?us-ascii?Q?A7Z8JpkxoEmISgBTWgB/Je5KNs31pt6x8+EfE6Vp3cWyMKfyTTf4G2g6pLsn?=
 =?us-ascii?Q?ovf36qIcBUZIp+Ii2Uhw6rmHKr+d81p16uIhSH7sfChZymDuzOqMgiAFWD2k?=
 =?us-ascii?Q?ilzvh0dHkvizWZ8tnyKOulhkuySdFS55UAO06jMmiBTXkC/OsYBf6DYugcwJ?=
 =?us-ascii?Q?fcPFzQBaiNRTwjbXozKymBmism3JVYpli61mkaITGwDuXvXoR05549M8HcmC?=
 =?us-ascii?Q?hLKb5A+qud5d9PMNvprSGzDsKjp73IZ3iKMVQtrsJWZt4IaG9hgSy81iKCJP?=
 =?us-ascii?Q?M9RPZn/uqSqws8pZbFcMIbIMAxbU+xsDUcouwFE95ezP1vI+08nz9A+qeU4S?=
 =?us-ascii?Q?zv7U9jMMcGdW1dCg1kW7uV+EWtiRV0ewKdVdwtvJ+qYCKp2pnrnFAlPKcv/E?=
 =?us-ascii?Q?FIc1U2vxhw8fmv5IjAcKUgDQlPcQzWC+DVZbI4fad9Ui3IjNa0kttebv9Gig?=
 =?us-ascii?Q?AvJRzCVA0371B8kF3pEvTbiPmdlMm8HIh85w4F3Z1JBXY9jT6KtdLRL6zIbm?=
 =?us-ascii?Q?x2HwjxTxfBLUL43PCMblLzpRPuHFrRNg/c/YHxqiMKULHo1s1KpW4z8u0RqE?=
 =?us-ascii?Q?ZAf7+qJlIfyqZEiFyObvsZdjJiYiZ8DBRWYd6r8diBCDSjMcgt6q?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe107dc6-b995-4ed6-1aae-08df4bd5c956
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:09.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tj1bh1pDx6rsLwBg93pygWAtjnPY9OcvHtiASzTXXvew+12VswiCLz7KZbz/6+aOwjEjlKfYe97Eq0RGk8V9GPgDSt+m4g1poU5eGW+i78zVRsoX/bqBaFg+oIPAKoyJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25192
Content-Type: text/plain; charset="utf-8"

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit e0c51fd02f9cfab341907f6764d2f15c134eea55 upstream.

The channel IRQ is only used inside the function rz_dmac_chan_probe(),
so there is no need to store it in the rz_dmac_chan structure for later
use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/312c2e3349f4747e0bca861632bfc3592224b012.176=
7718556.git.geert+renesas@glider.be
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[tm: channel->irq is now stored in the local variable irq at the end
 of the function instead of at the beginning, since commit ("dmaengine:
 sh: rz-dmac: Move interrupt request after everything is set up")
 already moved the IRQ request there.]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index dc744823a35a..dfe9ab617e34 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -67,7 +67,6 @@ struct rz_dmac_chan {
 	void __iomem *ch_base;
 	void __iomem *ch_cmn_base;
 	unsigned int index;
-	int irq;
 	struct rz_dmac_desc *desc;
 	int descs_allocated;
=20
@@ -805,7 +804,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	struct rz_lmdesc *lmdesc;
 	char pdev_irqname[6];
 	char *irqname;
-	int ret;
+	int irq, ret;
=20
 	channel->index =3D index;
 	channel->mid_rid =3D -EINVAL;
@@ -842,22 +841,20 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
=20
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
-	channel->irq =3D platform_get_irq_byname(pdev, pdev_irqname);
-	if (channel->irq < 0)
-		return channel->irq;
+	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
+	if (irq < 0)
+		return irq;
=20
 	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
 				 dev_name(dmac->dev), index);
 	if (!irqname)
 		return -ENOMEM;
=20
-	ret =3D devm_request_threaded_irq(dmac->dev, channel->irq,
-					rz_dmac_irq_handler,
+	ret =3D devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
 					rz_dmac_irq_handler_thread, 0,
 					irqname, channel);
 	if (ret)
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
-			channel->irq, ret);
+		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
=20
 	return ret;
 }
--=20
2.54.0


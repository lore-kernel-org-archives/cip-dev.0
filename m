Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4658ACA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:10:14 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.43])
 by mx.groups.io with SMTP id smtpd.web11.1075.1755706205436509716
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:10:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YMURh/Z0;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.43, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDtHI32qBLm0V5k/fPIhcl1gawGXiqansmSgFz8O2plVaShEQBSno98flBW1zXvnsClxvVH4F0yqlhaRhDUR+mbBlE+cAkpM3sY6DNIVuwF/CbMatFi3LX9jkK5VSn/F4zcWr1DquL+B6bnfIiwaxbxnaBJwSXG4Y319FQu/eie7xgW/V5O1WQtTKHhTR0Nde6PACYlUgmI1Qa56ZDZklSDgNQ02Y1iPKERmUifkMJw8KR/ovT1LiOLb6mEC65ueNL4/gjPsnmurfsSg7MHaIS3xEsFsnTv+FTOEWeTxlRjnKQGeczrU/T2j1P/4i0NYMFB9XiMUytK8xS5JfZiNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nr2A3///+R+6Uill/sUX7XX/n+6To5goZvUR8EA5pBw=;
 b=luwsefEt/6MGx/cbF7kd17i/yMULi21Opb6q9t4irFkzsXyVI8YrXKVqapSP2Ztajd1cL39S3cbm+ziG3jKqiYN1GUI3lxTh+ng2Og+H/g0dcT6WakDFW8YzzaHvU7xRlWbWpY7Pc8TeVIUUMGcmkQ+/q8/3tugAmp6aTnkOw9S2gAXW366sXYSnOJeelhn8+WJX7PIgM9lN6HQ3ZIAEHJy0WPuWO71kHlZtIvonx8cwMPuv891ZyK1IbjHhgLlLk3K87N6cW/QFSK1ynHoAJklCNwJiOqv7yGrnfmhsTPbCkfztCM0QKLwXULuzZahqs4h7NRIBodCfKIlUEHprsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr2A3///+R+6Uill/sUX7XX/n+6To5goZvUR8EA5pBw=;
 b=YMURh/Z0BTDfTRBnFcChdxDkqX3O3VFqydiinhKW8wIy5dp0zOxkWd3i2P1NdCP7W8ILe6q/r1hjO9xFlflKtDjuLpozlG3Md83RV6qF/h7XKcRi0ZY/XUpBce7/qefeA3rtsRr4bd66qOOQn0llqeinSVg+Dh7YHBdoYbR+0Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:10:03 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:10:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 40/55] media: rzg2l-cru: Add IRQ handler to OF data
Date: Wed, 20 Aug 2025 18:07:41 +0200
Message-ID: <20250820160758.801813-41-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 5deea349-4f7f-4a00-8d82-08dde0040578
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y4twTBoc1AeUYBlVIU2c6GG+lStckT6jrDMoF75BbCnheX3Jq781LiovwijZ?=
 =?us-ascii?Q?xzIVU4WVsssOisY3JGXdZ8//S7b4RAPoH23kZFRoBHvm+Ginqw07pls8+ZNQ?=
 =?us-ascii?Q?5WtI4lrZIKWUVqAfAEU+08iiU/zi5gHwjxAEQd2fm+mCxVMzaEoCBHlpJzqI?=
 =?us-ascii?Q?WrXoObUNos9ZTX1Hu7rFVW391Ht3K59DfAqWUXE9aiySh+mImDkG94dpEqep?=
 =?us-ascii?Q?MeoSVSiqV4TfN3VzSfNTIkvoO8iJwCmsM1kGB7yTVbmOHh8zRqUCC47VhePg?=
 =?us-ascii?Q?Snhc1rtnWX/9hyKCKUWoKozHlZXP0Z/FMq9jhco2y2sDpRfVx+EeIKjUWAjE?=
 =?us-ascii?Q?Otnbg4a3i0EEjOcoW8bkdUg+tIs+YPrL/cYfERwvcRPUkhuz6xVJF5UrNf2Z?=
 =?us-ascii?Q?NhQqCkLKDGVGcALLgFkTrIHPc7iIByL5J6hTegvjxXYpgF9PAoI7YUDj8jhV?=
 =?us-ascii?Q?Rlj1IyMC+54HNQKthJFK6HKT0DJmMl3GGXXAc17q7NBJ3mDpwpSh4iKtW7Hr?=
 =?us-ascii?Q?S79LBj3/GFYfbtkqyE7QCqEjmtEPuwR7o+EMey01T2XLK0Ov72Rj5/rrCbvN?=
 =?us-ascii?Q?r95rMTl0D2/L+XUJVE3RHm79xe4F7ts8qEgahbNaKBgyriUYH80s6nXwZLaA?=
 =?us-ascii?Q?kDkHzBRUr8FdKtCjvVni2OEI0b9OrtOxnuULMKHrZ3XGDJ2fQjF6iDqtW1Sv?=
 =?us-ascii?Q?soeElPFY0T4Xqi2KDTZtBGhW9oShR6XS0nK21cdYzbDJAx1HeXAGrdxCb1SF?=
 =?us-ascii?Q?2MybR4OqyRzH6KFBJ2fOWafrsEoWLqBpYTZjzUywXW4gB7M17ZlZaHoezOhF?=
 =?us-ascii?Q?N9M2GXh9QTyhqhVFptv9doDw/eXEQ6irhQ8tQgY8VpgOoM+wSmDD4n8hx9jb?=
 =?us-ascii?Q?TPcWvMWy54U8Unh9DhndsWPd804idv7Fu2NtI8SeBkkvfgxyMw+rqEDHD+Tk?=
 =?us-ascii?Q?e5zs6hg7iyTDBJUcb7SlQaOuPmzuca78iDc6YPpC5SvNQNhZinMRjxnHLNLI?=
 =?us-ascii?Q?RgPK47ZC+Ib1CmGIH7oGbmWfCr1WCCckuTDg6qrOWPtssz+CjX2FonIQ2lKl?=
 =?us-ascii?Q?pcutEY5auHdypffwg1PNKVJtxxXkJnXbU5d2q2NnCwhhLdzb9vnmn5In1uVI?=
 =?us-ascii?Q?oAMaGi1FjPgql93Q0AejO8dZ7TsKbw8t6I1yrUXddpLOPCL0UrP7RLL1a8zJ?=
 =?us-ascii?Q?MSPonL4aQniPvfZjehvOhQQAgbDRtvliJm4CTWZVq462NPngMsLTX4YYtCyh?=
 =?us-ascii?Q?sextesA+sDEmPRveDyU24Im5dyCZzmfSihsVyl7GDnTWnSbmj6vrwnoXTi5K?=
 =?us-ascii?Q?y3YwWa2IHOww7a+k7nL7yPahEaj6Rw/o+SQWD6TqvN3PvsJW1wuzVUwoIqJv?=
 =?us-ascii?Q?pdPSW2l5Df6md3tM0SlzTd9w6+l4IUb0r2Zg1R7xP+2FtDkE8BPWxRccCjIj?=
 =?us-ascii?Q?MlZHwJMoglYW+m9XULiBF4nvZqhDvD8LxwY5gZGZerp1HSsw2n/Qp0IT+d9n?=
 =?us-ascii?Q?mdw50mIHMCKc3GI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aEr3TV56oTPgIgLgZ2ZVYCnRMfM5uNyX4Vids9gIc3b/5OMAeBP9GIhWGo5h?=
 =?us-ascii?Q?i0MhdzrShBm7Ap1jYkreN+lGpkHuE9J51vWsJgpLgGgC8lw3xMcJ+Uo3Svut?=
 =?us-ascii?Q?g57vjtWn95k7DjQt9kf+zA7LE3O4Nrhmht4JiQf6DLiQBB7drruj4zNRWQIr?=
 =?us-ascii?Q?0lZA3/Ta9nz0CPHKn/Q4wW+m/bLQj/GRt0LnyC4cziybKwfdh0GFB6KlTbCr?=
 =?us-ascii?Q?8Fj1aX++/BIfC79cqYTANKoGQWwC9DfLo4tuS4Lu0wWdRzuH3zlD022wJrBK?=
 =?us-ascii?Q?AVenAHWV/bUjcNCWz/JN5+z5E6Q/g5OaGdQvyIG9Q2CrN+Nq0VM0phT5G/GO?=
 =?us-ascii?Q?9D+HYjwQa8VCbj/eIxB/msUmKstW+HtlHQ1cJ2pmN95Dxi/7nPxtJIy8SUbF?=
 =?us-ascii?Q?rU8BqKkumOeGn4zAE9jBw//cRwkWlHzSbEvFZrYGeoZMoD53+eDFMnVj7Ei+?=
 =?us-ascii?Q?08CNmsAM2XrH0q0quGhjTtrSwkXwLOMWtKza5OO8couhkFQVoOfbWRxcBixD?=
 =?us-ascii?Q?3HuRbfcfNf9vD1wGthvDcNxXtcDPktYmoe8USxE04/gzcmjPc6i9YUC+5eVl?=
 =?us-ascii?Q?l4khHr1fmSvjGLgh9lNJx3sJJe7Y7XdGW/vzG2sZpMJNoLTgz0/YIZvLNk3m?=
 =?us-ascii?Q?zOEvEKUybnbHa4bvJ0Q6dNTUcjuzGf+Yb4edoyxKuxgWtm/TzMDQUtx2W5v5?=
 =?us-ascii?Q?QLlqrFgU2BXYh6H+UktluCk3tr54OsrBRdXUZDQLdpXCxm1cC623ANCLKk2d?=
 =?us-ascii?Q?phXEbznzZiAjQoPHLYGZZM41wLDOS1J5U/HIXw3xNjC7IpatWnD2kgtBXnHQ?=
 =?us-ascii?Q?rZP4ZyC0R+vMgZNejndLCWpNWxju6l2ZX30PaCBZupitrrCg9JYxpU95ZSZU?=
 =?us-ascii?Q?BTxaeP4NhDoqMPKQFj9qeJOAN+qCZvd1p65uipEx1t+u7XREbNlmeUAruYzR?=
 =?us-ascii?Q?iLcUNTQORsj5lSnoDfHWupayEB+nch97huMcZbCvntfnqml3GXARRMINRDwr?=
 =?us-ascii?Q?PtbM6jfdb29Hw3GM04DTvJ4xZS8cBw0XUk1iwTv4V5RZk/6e/vr0EGeyJGk8?=
 =?us-ascii?Q?+y8IOa9i8BHWrURN77yO2Oeh0YmsP5XiOAEn3NJDDFmdhzy8I12LibBJQ4cN?=
 =?us-ascii?Q?CgRo0dX2H9IO87xP6clWZWHk2/OpH+2fUzvdeWR+6q7kn+PtGIIWJecKwc/7?=
 =?us-ascii?Q?MAO0OONnKz8IcRumDJVZ2BNLX9Gk7nfGCnEW+aqgkBzqKTEDNEpssiaTXMrW?=
 =?us-ascii?Q?iMCPD919bIQX71EBJzxGLl0MnJgDD1z/WHE41KnxxYPpigRYivfIHLA7s0BU?=
 =?us-ascii?Q?3B1ur1JQFVvjXX3MdCTs5nuPIVtCz+zPMFsDOTUHthMaS+Fu9ZLZoVhq6usm?=
 =?us-ascii?Q?/yOUwOfXOPFpBVaQPv37BtcnlIFXAJxTY4fakQHKaqhwrXgwyawP4d2qrLUU?=
 =?us-ascii?Q?6GnAyZ0+Pui7Ren7vU0mIvm8aJI8UWo9F7I+2fiyUgrjNJDrSIIT+xJsRhjT?=
 =?us-ascii?Q?jIDFEXsynX98SLKeuFxILlbRs3F5pF1ID/Su8ywonupCwqk5WLcQ4ZTil/2X?=
 =?us-ascii?Q?ah2VM9mfom6eSY+F5fDv6pyRQ6ngYpTnTbS56rMJOenbWYrG9kCgMYycy/lF?=
 =?us-ascii?Q?JF0DQ891XUhz2KUqLJ6vfXI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deea349-4f7f-4a00-8d82-08dde0040578
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:10:03.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xojBdocmsKxovcMREawE0gaOkVzHHuCB4ASxL0O+v98aTUAWgVmK3JhAJ9HuXQEqvqGSgERuRkTRPk2dirGkFLUW0TuaMnhYlw/bMRdXp0mjtBgK7NA7lYjl2A/hU/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:10:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19921

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 2d9e3eb740b7d256d0ee53a6a242f0ffc60b0c9b upstream.

Add `irq_handler` to the `rzg2l_cru_info` structure and pass it as part of
the OF data. This prepares for supporting RZ/G3E and RZ/V2H(P) SoCs, which
require a different IRQ handler. Update the IRQ request code to use the
handler from the OF data.

Add `enable_interrupts` and `disable_interrupts` function pointers to the
`rzg2l_cru_info` structure and pass them as part of the OF data. This
prepares for supporting RZ/G3E and RZ/V2H(P) SoCs, which require different
interrupt configurations.

Implement `rzg2l_cru_enable_interrupts()` and
`rzg2l_cru_disable_interrupts()` functions and update the code to use them
instead of directly writing to interrupt registers.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-15-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  5 ++++-
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  8 ++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 19 ++++++++++++++-----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 254afe5e594a..1522c3b10c73 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -275,7 +275,7 @@ static int rzg2l_cru_probe(struct platform_device *pdev=
)
 	if (irq < 0)
 		return irq;
=20
-	ret =3D devm_request_irq(dev, irq, rzg2l_cru_irq, 0,
+	ret =3D devm_request_irq(dev, irq, cru->info->irq_handler, 0,
 			       KBUILD_MODNAME, cru);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request irq\n");
@@ -356,6 +356,9 @@ static const struct rzg2l_cru_info rzgl2_cru_info =3D {
 	.max_height =3D 4095,
 	.image_conv =3D ICnMC,
 	.regs =3D rzg2l_cru_regs,
+	.irq_handler =3D rzg2l_cru_irq,
+	.enable_interrupts =3D rzg2l_cru_enable_interrupts,
+	.disable_interrupts =3D rzg2l_cru_disable_interrupts,
 };
=20
 static const struct of_device_id rzg2l_cru_of_id_table[] =3D {
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index ca156772b949..3f694044d8cd 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -34,6 +34,8 @@ enum rzg2l_csi2_pads {
 	RZG2L_CRU_IP_SOURCE,
 };
=20
+struct rzg2l_cru_dev;
+
 /**
  * enum rzg2l_cru_dma_state - DMA states
  * @RZG2L_CRU_DMA_STOPPED:   No operation in progress
@@ -83,6 +85,9 @@ struct rzg2l_cru_info {
 	unsigned int max_height;
 	u16 image_conv;
 	const u16 *regs;
+	irqreturn_t (*irq_handler)(int irq, void *data);
+	void (*enable_interrupts)(struct rzg2l_cru_dev *cru);
+	void (*disable_interrupts)(struct rzg2l_cru_dev *cru);
 };
=20
 /**
@@ -177,4 +182,7 @@ const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_=
fmt(unsigned int code);
 const struct rzg2l_cru_ip_format *rzg2l_cru_ip_format_to_fmt(u32 format);
 const struct rzg2l_cru_ip_format *rzg2l_cru_ip_index_to_fmt(u32 index);
=20
+void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *cru);
+void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru);
+
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index d9135e2825fe..d5a9149baeca 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -300,8 +300,7 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru_d=
ev *cru)
 	spin_lock_irqsave(&cru->qlock, flags);
=20
 	/* Disable and clear the interrupt */
-	rzg2l_cru_write(cru, CRUnIE, 0);
-	rzg2l_cru_write(cru, CRUnINTS, 0x001F0F0F);
+	cru->info->disable_interrupts(cru);
=20
 	/* Stop the operation of image conversion */
 	rzg2l_cru_write(cru, ICnEN, 0);
@@ -393,6 +392,17 @@ static int rzg2l_cru_get_virtual_channel(struct rzg2l_=
cru_dev *cru)
 	return fd.entry[0].bus.csi2.vc;
 }
=20
+void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *cru)
+{
+	rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
+}
+
+void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru)
+{
+	rzg2l_cru_write(cru, CRUnIE, 0);
+	rzg2l_cru_write(cru, CRUnINTS, 0x001f000f);
+}
+
 int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru)
 {
 	struct v4l2_mbus_framefmt *fmt =3D rzg2l_cru_ip_get_src_fmt(cru);
@@ -414,8 +424,7 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_d=
ev *cru)
 	rzg2l_cru_write(cru, CRUnRST, CRUnRST_VRESETN);
=20
 	/* Disable and clear the interrupt before using */
-	rzg2l_cru_write(cru, CRUnIE, 0);
-	rzg2l_cru_write(cru, CRUnINTS, 0x001f000f);
+	cru->info->disable_interrupts(cru);
=20
 	/* Initialize the AXI master */
 	rzg2l_cru_initialize_axi(cru);
@@ -428,7 +437,7 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_d=
ev *cru)
 	}
=20
 	/* Enable interrupt */
-	rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
+	cru->info->enable_interrupts(cru);
=20
 	/* Enable image processing reception */
 	rzg2l_cru_write(cru, ICnEN, ICnEN_ICEN);
--=20
2.43.0



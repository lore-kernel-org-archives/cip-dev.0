Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC6CC83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:46 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.22])
 by mx.groups.io with SMTP id smtpd.web10.8391.1751619997278052905
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=T4rc3auY;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.22, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1DQFBVMZ1J9O0gVUSXO6E92EftpQ7mcZYAbLfnIlSAI636u6AuXdXLwRV+WyeVt/ZVCji8qfm7Uw/rVf+HvFGJhKEsnJO1rqrg5tLvBoU4xff3HUxC/nYqNIBGt0mI+Zg5loLkpmfxt+ZVWHRbkjSpP/vemMUs2fZiOvZhtWddC+KIH2qMFoWlDdXOYPtv4jPIQqAsaDN/G7TfY5zGTBtx+3daxgrAmZOshZRuNkdR4gWEZzaEURq4Ni7wX1GPZfpL07c56GUJX0Oq9eIfqiqZwuQTjnSyRIJP9x8AbG6aM4/JghrlAumXkcOl5Qi+St2Kt077lfmjJqqZEt69/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ+Jy82IteU1z1jZpudy4Hgt4w9V/oJ7+Y4Bcf5z5uQ=;
 b=J9uPN1feHkrb/Bjnm7C8HCy4dobqAx4XNaVR6zWtGs2laOQIgBQk50H702AOvmvTjbY6eZt7yoMA5dv/Wu5t1cxpX72K/G6vlzG3f0joTJfV1A6nyQhGOxN2WVVdXMfM6OQ/aqKbER+WbEbo3zrNNS23Ad6chrWM3OBVUipb/rniMIVn2PLvdXVGPb6uj3/5evP2YK81FJJO1eL/VtFGp90E9NE6DefhtLnslDYihK9JZVxw49IpxWs2TDlM/IzCARXtICS0LARb8GRUItFsi5x6F7QB1TSJsS4l3KlBw+hbW6Et0sI5Xpe65nGuAUXQ3sqOvvljuPEByW/e2yHW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ+Jy82IteU1z1jZpudy4Hgt4w9V/oJ7+Y4Bcf5z5uQ=;
 b=T4rc3auY2cBEmk+GMV/33h+os8xnqG0gqa6JeCL9zHVi6jPWvAfkAnTNQwQ7Yr2CitAuQOWIj+T2PEDb4tCLsD0/WnGlbFMrcS5KMKI+evjEGlXl95EI61HKS/2ByHzMDXEybAuGxryjJQv5MgkKspI9NdepG8VX1cAaFhouCwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:34 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:34 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/14] irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
Date: Fri,  4 Jul 2025 11:05:48 +0200
Message-ID: <20250704090556.669652-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB13039:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d2e548-0b28-42d6-8f26-08ddbada12fa
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HadlMeWus33ZBk2E2StaChb9/N475TtgxR/cZEUDWeHkvRInncvIFOB4PxCf?=
 =?us-ascii?Q?7FHJUY43dEex2Ys9urOUcylCP9y6QptsjIr/evhnUU+oJr410b+EGgPiu74H?=
 =?us-ascii?Q?qbwJRyYa5z4GOyzNKn/qsTUFjlH8baF1fXBy4SRXBt+txalB80oHUrOV3qXI?=
 =?us-ascii?Q?AcumpXucoeuYRnVNXhu/wgn+HVC8ZO/XY+UqgeWXqOX5EVne7uRvfavOiKhR?=
 =?us-ascii?Q?2DUaceJ2hNH7MiWhNTm9cKJksWvyBEmhbrziMR3PBLXU/+NYtAYhGcyS6Yyr?=
 =?us-ascii?Q?78oI8vZa7PwcMCqgzxflgAvhQaG1VwYDbaubfHjYz0shxDRmKkVvBOMRvxgf?=
 =?us-ascii?Q?nsfgMhL8Gj5CaK9JQ2Ss9pjJNqy73jGQrrZI0q21GbLxazC5jpz9r+R1MUDv?=
 =?us-ascii?Q?bPrT8KtPNrApAurwg4BXn3GyWMgruGWsUcd5nPvW3Gaq8ttKl5sIwdTwxc5k?=
 =?us-ascii?Q?ZsVCvkDOZyb1MBkCq7mcQhG5z2jRmw0mWh31PIJ+Fofen6rOLaskkduUER3z?=
 =?us-ascii?Q?ppsjI2QjcM1JI1u0SADC8lhxNACJcmtq44pUtP+zGf+JRgQ3TjtN1ZG44zou?=
 =?us-ascii?Q?2iTKD9FjbDcDGsWBE1770UMlaoLFSkz9VvzwAAV+V4yLh5haXEoo2vpQP2YW?=
 =?us-ascii?Q?TvzXAKQbkNRsOe3H7XoZr6RODCZZ0nsmtC9VzAscmM0WRSe77cWOr/73oyVc?=
 =?us-ascii?Q?noFDUblt4KdExhY9lehHJmbS6qgj8oxJy2uUa6djVIpurkRL+HmK3bluSJov?=
 =?us-ascii?Q?W45EIvi1h0LVMQlxVfbKfcbyGqXwHWwfVIBssG3LDbvNkYqf7p9fm9Lj9niR?=
 =?us-ascii?Q?liV2OZWPXmpYIDEYXv25GO91f/EWW4djmvivf3bu20mr3ocNt41ATCFdFvYR?=
 =?us-ascii?Q?vfzAUrLtG1SDluks2yD7Urf4kj6tuAtx8xN7sWeispoZ8qo9Zfq0O6f753G8?=
 =?us-ascii?Q?GXAuDisyyrcicKJOyc9QGeHNSuWjw80pc3NEDXzWCRe04iicCf/5zUWaztQV?=
 =?us-ascii?Q?vPUTd8sMkvHOudVr2ldClxuW3sObeyo1R5IS/clkRiLA+xUR5tH+jLKDhraF?=
 =?us-ascii?Q?TXd/itvl17WwR4lvPw520Z6C51CxATEy970oR+HfgY1AT5X6WriT5W/1fCFM?=
 =?us-ascii?Q?fo2iffB9falJ49dedkzg//F4NOLSn0uFeYmlV+GuGv3vmfxhfXdQk5TBa4im?=
 =?us-ascii?Q?k3UIlvvQmcKgz0vzu0UNHj/fXz/8+j4Egz953MnKe9lkuktPxa4vhh/9C9Sa?=
 =?us-ascii?Q?/Oj3TQoeiVdGbnwoH8F6MoJhMNKDM/TXCw3PZRqkRB2R0jhZe/JuNeo0Iisd?=
 =?us-ascii?Q?MWg/S5JHiqe35OlOo13AllRqlTv3Sihbh/PADeh+h5fzpbQPsUgtZc8guaSb?=
 =?us-ascii?Q?e7SLG+V14aC51LS8xE3hPVHC0otf4uJ6VPHHaKz/hsv9ESR9kHTUbpjS+DUH?=
 =?us-ascii?Q?4hSfAa0zdTY6DnJFlclbu8TS6fYlZcsNDEBllPij2moOm+U8YOxWELiMzgP+?=
 =?us-ascii?Q?U/Iktjdvbd4IwRg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+FLqlVyMWsb9MP1A4DKMNpJn/NVn3cypxIrZ0hu0PwmmcHXfmVEyViNT5b1s?=
 =?us-ascii?Q?mCbUdw32CkPYCUR8jnORlOOKlPDLvPS/KHSAurup07BpMZpebteDyWZZpEKj?=
 =?us-ascii?Q?r5l/fDmrZaVjeGicF8syMK4gacwyxrp2T83CX7WWnmtVKjZ4r5MoG3XVbWbR?=
 =?us-ascii?Q?1M9YWMjMMLFhBC4zO0Cf43j7T12v0bk12e1/e81P5gt+vXWbQBbAn1kmBMJk?=
 =?us-ascii?Q?uMwBzyYb6BA+kj6bF3tFVJkFAQ1u81REPhFZqA/nfEmMaZqWqLaLQC2TYsfw?=
 =?us-ascii?Q?fnZlx1zTTEuOWnchqdmss5y8dTi+86KHtA+gTpY0sQjAXXKCCa2Yr/VJF3OG?=
 =?us-ascii?Q?TJt1x1VP6TtCu1Hb5SNyZinkko7xTZOjwQt7SVUDzwGAJk+ll+tgP6TKgBZn?=
 =?us-ascii?Q?c7gYHYkHgyWI2LnJdxE6TjeSUjMR/TGYgY0ovaXzpx9ekUIsYS4nCp3ufOnR?=
 =?us-ascii?Q?Vac1rCwOSVqBKkJ2OUz64bb0SxoDkzkTfUiGYKG9LWBn3dDwsXZscXn/0neF?=
 =?us-ascii?Q?m16QmXsl0Dpmd+MLEqdOIschxe4v046fB7P581JJrP5MC/Acyh5Fj/ejkVfu?=
 =?us-ascii?Q?a3oWF8WJ/W3yXR7DKAjPdPBC/AS7JGOyQ5X6nB3n0AJjMJMxQ6rWvo80mwmw?=
 =?us-ascii?Q?HBKPzdI5SeV3WSk9ChAgcCkVf6uI2YqJD0zP5WDqfQA/pHwqbwwQ5L5+1CjD?=
 =?us-ascii?Q?vYJ8Nb01xodfKdZaXRS21+rzTmD9tYyftkV6zszxSM9gnkiCGcVa4tBLTi0L?=
 =?us-ascii?Q?QKA4nyPD8b4pNDhlNLAVc2sbEGzaxe1Aad6mmYr+AojkWXB89DsNcRWh2rob?=
 =?us-ascii?Q?ivf0rUHgleStIwEb1pcKAq4bL1EXADSsFveOzwynXqFhhOTLj/hTiWU7HNJl?=
 =?us-ascii?Q?pubaew39+44jxJR0LG63tjYiZpLSwTt5c4NK/3Hbf+v+xyD1XA/b5RyQsxcn?=
 =?us-ascii?Q?RsHllxP3vDTqjO4oSPsVjyQjqy4m77hzOqIvBcxSstRCNziUfhDT3WyzE+TN?=
 =?us-ascii?Q?hKDFxN83Uss4ecBucy+/jN9oXTzth12vBYJGVztbs9bXtmexD0gUbHoh+GfU?=
 =?us-ascii?Q?dOrik+esNvBFlSoL8TQZ3L6ZTGG0oM5ZpbfWCA4Qs6sPTLdof99cBv3046wq?=
 =?us-ascii?Q?y99CEUAIx1t7on3A7KE5OshbyuBBNjx1VyiqGfvszqxkS7tkgw3A/luJc0la?=
 =?us-ascii?Q?x74KU+VDdx52Mk/grDoxh0vUv7gBlvrggStodwb+vi2BpgAY5wQ7ShfyWlkC?=
 =?us-ascii?Q?u4B+p+yvRnVkr2mdh38Dwg2DCD1PDUW5c2RJpuNLI7LTO/hqFxKoUITQS8Ia?=
 =?us-ascii?Q?AW/ME1v3z35MXpPz1cEFpSTsGtIRsaZmQcWvwf5qqyLNX3HctR+rUHHIdmgL?=
 =?us-ascii?Q?dlhf6v/UoYD+NDwqscztSY8+wMcKagL3lHAxpp1Zuj5kIqVZF5LVBJlbJou3?=
 =?us-ascii?Q?YjhNckpPL0jifY1exijNIiE7QwmvY25gHFX/0QI+jrzoDD7IiHEbCqYvJ/tk?=
 =?us-ascii?Q?lzxoewbm11mAtf3X5fQQuAXPwSO/bLFBSGnddRsUO83AIMBb/fGr+JTNIlr5?=
 =?us-ascii?Q?8FrT4ZlLfmPP2+kGh0sI8HB779N7qKmth5I5TvRYHGtaKUrIj8L/7rlUYMWt?=
 =?us-ascii?Q?GSzpOy4kfF7UFWQWaFz717M=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d2e548-0b28-42d6-8f26-08ddbada12fa
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:34.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUWXA6TrgndRK+diWDNvi8UYxrm41czyz/H3xn0eJ1trkaRCQWTJ3BZ6oaPH7dmRyrXQKlIPR7c8BRbAaMhW4xIITRdIicGoOw2NvutoXt1WzexsZ209i985smaXt6xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19335

From: Biju Das <biju.das.jz@bp.renesas.com>

commit f5de95438834a3bc3ad747f67c9da93cd08e5008 upstream.

Use devm_add_action_or_reset() for calling put_device in error path of
rzv2h_icu_init() to simplify the code by using the recently added devm_*
helpers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/all/20250224131253.134199-5-biju.das.jz@bp.re=
nesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 37 +++++++++++++++--------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 0573062c89c4..d724f32dde8f 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -419,6 +419,11 @@ static int rzv2h_icu_parse_interrupts(struct rzv2h_icu=
_priv *priv, struct device
 	return 0;
 }
=20
+static void rzv2h_icu_put_device(void *data)
+{
+	put_device(data);
+}
+
 static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
 {
 	struct irq_domain *irq_domain, *parent_domain;
@@ -431,41 +436,39 @@ static int rzv2h_icu_init(struct device_node *node, s=
truct device_node *parent)
 	if (!pdev)
 		return -ENODEV;
=20
+	ret =3D devm_add_action_or_reset(&pdev->dev, rzv2h_icu_put_device,
+				       &pdev->dev);
+	if (ret < 0)
+		return ret;
+
 	parent_domain =3D irq_find_host(parent);
 	if (!parent_domain) {
 		dev_err(&pdev->dev, "cannot find parent domain\n");
-		ret =3D -ENODEV;
-		goto put_dev;
+		return -ENODEV;
 	}
=20
 	rzv2h_icu_data =3D devm_kzalloc(&pdev->dev, sizeof(*rzv2h_icu_data), GFP_=
KERNEL);
-	if (!rzv2h_icu_data) {
-		ret =3D -ENOMEM;
-		goto put_dev;
-	}
+	if (!rzv2h_icu_data)
+		return -ENOMEM;
=20
 	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, =
NULL);
-	if (IS_ERR(rzv2h_icu_data->base)) {
-		ret =3D PTR_ERR(rzv2h_icu_data->base);
-		goto put_dev;
-	}
+	if (IS_ERR(rzv2h_icu_data->base))
+		return PTR_ERR(rzv2h_icu_data->base);
=20
 	ret =3D rzv2h_icu_parse_interrupts(rzv2h_icu_data, node);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
-		goto put_dev;
+		return ret;
 	}
=20
 	resetn =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(resetn)) {
-		ret =3D PTR_ERR(resetn);
-		goto put_dev;
-	}
+	if (IS_ERR(resetn))
+		return PTR_ERR(resetn);
=20
 	ret =3D reset_control_deassert(resetn);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
-		goto put_dev;
+		return ret;
 	}
=20
 	pm_runtime_enable(&pdev->dev);
@@ -496,8 +499,6 @@ static int rzv2h_icu_init(struct device_node *node, str=
uct device_node *parent)
 pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(resetn);
-put_dev:
-	put_device(&pdev->dev);
=20
 	return ret;
 }
--=20
2.43.0



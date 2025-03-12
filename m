Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8DC36001
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.1])
 by mx.groups.io with SMTP id smtpd.web11.34876.1741778835938162060
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=npjMPd8x;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoTXZmMfUtaKnv76eZHCaLnMJyH+UczILqGOgal5yIBW3RWFSkakCIv89Ic97U/fbp8GjKmQHZwr1saoortJl3vUBPEMLLX8Nq6GOzUFXq+aILysO2QLlaj8XZarOembbxgNvFSuwITQay7Ry7Nza1jT+NPnRJiJqpDG1iP7hkkVoi3QPgOES+dxMhEqVEvx9sKxBSGu+J9VT/ixsxkUUgw4BYs+HrHE9jNOsL4URQA7g4+bhYAp4VkrONdO9ahuO7xOOYfmQnDoocV/r6PQk6cOfkSWTkQv8scP7zd14P+qTmkq/sYfY9kBsN4ufASv+pbJhjvu6Jnk8808Qfb/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlYelGc2FaXpWkFWHMxielKQYbvWvy8s5UB73g0DGKU=;
 b=WPwhrLApV/PWB93dUPXNoE35cgTKex8itR85K7LglptLwlwqNrQqX/5hBHZjZbYF45fk08NUs+k2ILAJwGz2yL4RvtQNkaYOPEEKskYF627jGsIwiTuAZgdGPK+2zcNXcXzzZ6S7QCDCGevqDZFldUL3VUF0ADpz2Jj6Pw2lPqTkSvAf850cC/y6GRix3N433PNIeC4ZUrKkaJBkM8Uy+JudDsVbtnw3pYOHFChHgNUCB4gL/ch4HMav24YhY+teyat6kYyVJ8MHl9/SB2opIy+Fr/gwBxM6y4tMBU7hhYnPiKsHjqCL+l9tcwyfi6FaGWMVr58XJ+1qWTJ4VYNaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlYelGc2FaXpWkFWHMxielKQYbvWvy8s5UB73g0DGKU=;
 b=npjMPd8xEwQzOFEqJNy59mlY8Tc/pQ5zEcSJxmWjnz4/Kj0OZPdDl6h/b78Kh7dn64ZgH6h7I0LyNH/LgCj7hvCv8PrkMq+Rfez0Fld2CL82ldksmJmycEXk3RHiC2p1wg7aY6JKTyWGoMQq8zAf0Dd7QTgCWDa1UDNGQBttva4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:14 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:12 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 74/85] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 12 Mar 2025 12:22:51 +0100
Message-ID: <20250312112302.1605750-75-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a13c8da-5651-4272-3396-08dd6158d5a0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rLDGU6nJ/y63w//iJK3o6eV7D/WlIrSK7DtXQq2T90ZpthbnquhBspsAQwFl?=
 =?us-ascii?Q?E6GVqSMOzbe2RZZJwX7UL43pkyI8+XLwcCnbEx0xltNP0AJeR4AIq0roxtsJ?=
 =?us-ascii?Q?p7/TBH4jd3qsGGKpFBbQ+7FTiNsg1CaILG7gtww/Eb9+yGTyX/9aMZjz/49S?=
 =?us-ascii?Q?Sp7L5fwEbzJEKdwgZrMWlBVZj2/ZWhrlsAzWMQu3veWyvln5KKWvxV9+LAM9?=
 =?us-ascii?Q?exXMp9NMXPU+WE9ivIsQjHqOG24/rTNkViQMQ+LNbZGTlTi3k1RknoUCGrj0?=
 =?us-ascii?Q?ntun37UNPTFEE/FgLtjeCMZI7Wqn1nQJeneoF2MficWOS8ZLOf5iLXJwqfSg?=
 =?us-ascii?Q?hys2Z8FCl8NqLlCJthJRrF36AbY6PcXtQMzwHBF9OmcYEiKVnE4VpdrzNr1d?=
 =?us-ascii?Q?AOQ+SBH4POa43JCU/tZf0q2V5vxR7yEVXUMR+FvT9dhz4+GCa8UcnLc0vah9?=
 =?us-ascii?Q?XJA95GSi5ZUqqG+gAw3cAiJT0IJ4lBsIbVACBt7K9EMlEPBUTQAJ7ZDuCpzb?=
 =?us-ascii?Q?xYItQ2fbnEwKp1aAYcM77GqA1ifORHb/CD/l5EtXhyAqi4b4BKKhAE7qDJzq?=
 =?us-ascii?Q?+NPYjIDSvlnrhR7mtplmji09BcL30ItH9wSP1mNJjJc24aa3WlTszbgSoGWI?=
 =?us-ascii?Q?Je253KZ0UzJc7qjTnGrpQzDBTB9fMte70sQ9PuVlScbuLMkSzdP3nu596N3G?=
 =?us-ascii?Q?oklee9D2hoT4CQUkfwwzHFGXTmJBrY1jWu6IyzUQWcRP/6fNsJB7+icRmQtM?=
 =?us-ascii?Q?cM5kajI4KmihiMPFZ7TtIu4ppfgya/OnTBw8SbF0TssRvfyc9hV4UNp4wfb4?=
 =?us-ascii?Q?ixe4APTFJXivOQh3E7ceqDgP9VHwLkSrYUp8V9IfrFIHnCdBGwM9bkI5JsQY?=
 =?us-ascii?Q?ABoY7XJsUCe1MaGeQDmRZ/VEQyiLn/wW+6y/x6R144qUIcLth8Fqz3CfevPF?=
 =?us-ascii?Q?Yt9jewLIorgOT7YYbi1FxAHzJTpXj+NTZ+Cf+1Kv8gMZnSE2r23rXO0wBxOd?=
 =?us-ascii?Q?HGhrzBU9AfGN2U+EWuWKOkjhadcxQgBTovDT/wL4UE1QwTJf5hT9OMoMTzOA?=
 =?us-ascii?Q?gpx9op7oClZnhM6EtYT2uTGvoG+1nLlzgTsW6clZGER26sGufQkGGnGlR+ZX?=
 =?us-ascii?Q?FQvy6UQMBdHuyfFzw/x0VGK3MYgbc0LgZDfQRqJ4/rYnfZWT+AtmxgXTw8/v?=
 =?us-ascii?Q?PKSGm44hm3uIF+vU+SDsViHH1bzVGlJYB7OfVS3bdGH6Smd2CLyg8Tpm0Irk?=
 =?us-ascii?Q?aH7yjHRBAS9qyclYS2ku0dwZI9MRVa32Y/PUOaY9NmDbgCRvMzkwNG6xgvWF?=
 =?us-ascii?Q?TfOvDzEoD5V5oZXmdSOvzsIhByzZnODjuJfW1yqbT1IEVBcOt5sBb26IXqbY?=
 =?us-ascii?Q?vt3q6lbFdy9i9mNGCNaq2lHnuOV0GRsIkla6wW8pqme195ZBtZeejbyXPv/B?=
 =?us-ascii?Q?8ZHDAJKda1NJIw73Z5h1uTW34fUYbqg5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?B9ajDzfV0Q64wHlZtVUhphLNA+7DgOtyvd1oTzK4eFNWHJG9oexGn7a5zUkP?=
 =?us-ascii?Q?noXmzPb5Mm56WBP8lQoswcQrDodMWJRm1mYN79yj97BLjcq9qbk/b5wXSTKS?=
 =?us-ascii?Q?6mGM6Ygx9fRTV6bObsjAFURMnasF02MOgJCHFbvuqHW6gGi0KmL9PsAU6S9F?=
 =?us-ascii?Q?Y6Rb/zKaPodSq6YE0eNl7MENfpQ9d4ZpKmDJOQezZgMy1K9GzSUWbEn6VgGp?=
 =?us-ascii?Q?wJskVKcxJ2K1CgGJ40D3Jp9BDOOlqzzN0ts2GPfmEEvtmy6cHjqDFZAwdWWy?=
 =?us-ascii?Q?HK5qMiB7xBOOO1O3Lv6TtX0P4rdEIaugbWptAkNS0mIvHqI+zWV7sXYjI8C2?=
 =?us-ascii?Q?1Mfma4mL+rMalcge9QQbk8mJp2tcUQVOFfX0gPHoGi+3hwwr9m4VcjkeBNRj?=
 =?us-ascii?Q?/HAWzQGNc4nUR9CoTIKxgmJHHKT3Q127E1Jqe3WaiQmQFmvEWvNueoE5OS2t?=
 =?us-ascii?Q?qmLTtfFhnPO9WYxyfTUOeBh/tHus12jNN9aqJnDoi48nw/CTSL/okNJ6GJWg?=
 =?us-ascii?Q?09myxGZLKRlY4EPfSdlzrWMWUc2mQgRJP74Tqa9VQbOtBB+WaC33G/3AbASg?=
 =?us-ascii?Q?Gkg9KmAsbcAZz8e0ntJo8wSPj4agIXGbwd1Goyl9Io5lsOM2P1iqo9z1fq0c?=
 =?us-ascii?Q?Uc5mKD594ZUbLlf2hB/IU8/t87bPOGk38lbpa++Lzozg4/mVKuS0/a4CnVkK?=
 =?us-ascii?Q?8/ZdoBLvEvjfPswTxbPZTGo6mfKh46M2Lbcy9ThKkbB+FH698V4QMJ3nqpsl?=
 =?us-ascii?Q?ZxTmtLVAt4JuYBLibA47m3g+jIiO2KJpncu6VXiacLBqhSanJ4noBmOY8gzr?=
 =?us-ascii?Q?ah7pBP7bILrQnk715BNp9aMKR2ma/lJRpgQkrJud0tZmGThYZBfi9AzdtLcr?=
 =?us-ascii?Q?Q0cb4JvdqmBj0oi7ZAINB4ZMTiJnRVFq53E9IaexRjZXDhuiowdP3vWJor5h?=
 =?us-ascii?Q?pOq25DZjvNyiojVJa79SaJ5QVHRY4Rb3QEm5uhTv+jGO3yndJ0YbSbQEWXr1?=
 =?us-ascii?Q?9ILom3gGIf13iY8JE9rWtq3ke7bmiVBarVJv/7vEDnbtHo7P9Da/M8eozuE/?=
 =?us-ascii?Q?i6a1/33gIAMjoCqsivmcib9551ZjZJszsTRcce4K2rvFPVe6bW8si4UWw7dz?=
 =?us-ascii?Q?2KqDkA1nWEwjV85weQKAQq5NgGUQWqwPndOWXxZwd6XJjMwXUs1MGMswByo2?=
 =?us-ascii?Q?0RhrdCF2d5eEXXrjQRt74qlzljs9XUNsIMpy/8Nu7vbOgquf99jUAbHbVu6G?=
 =?us-ascii?Q?zo99US+xCuqpiS1HYByn75ZTTEq8lmNYoc5Ps4zqmPqQmXlWAvzK8r/qgAqZ?=
 =?us-ascii?Q?Fj5SuVMvk8XdAqufyWlotpPTnEsMUJg8ZF//KeuSOk+9wRyxf9eblt5BL8mK?=
 =?us-ascii?Q?Fj84kHj77ZFZjLqD53/XgyD/UQtt0vyxgVFt41bUSVWfI2Th/MLngQ9Z9wC1?=
 =?us-ascii?Q?fyDuOGlr2C3C+BJQYc/iFEt/GNI6jG15DP6wFAXPAVBsUDrY66tcrUPF6iaA?=
 =?us-ascii?Q?PMKTihvSgaQajaRV8d9AR5I0XPz1oCefRyc+419wqhQgwZ7a9+04jW4p9Uc/?=
 =?us-ascii?Q?DVJ2BWazxZl6Bg+ch7BC495UZN6/QT4BDYOIoZgB2Lt94ShASu9CgAQLJ1rs?=
 =?us-ascii?Q?gmdISfkaIVdjQ3HxTzrROpw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a13c8da-5651-4272-3396-08dd6158d5a0
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:12.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A4NhafHGna/ihFokN3TaSpWU3yqnoMaRz35GvnqIXeJXpBsHdLYypBM1Rs9JE96hd2X/EtxMEx+x9UWVzXYCp+6QPrnDVbWcKZqM2lvXcwiFgi3nwUAid1qmHbVgdmh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18166

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 239f11209e5f282e16f5241b99256e25dd0614b6 upstream.

Relocate the runtime PM enable operation to sci_probe_single(). This change
prepares the codebase for upcoming fixes.

While at it, replace the existing logic with a direct call to
devm_pm_runtime_enable() and remove sci_cleanup_single(). The
devm_pm_runtime_enable() function automatically handles disabling runtime
PM during driver removal.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250116182249.3828577-3-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 19fa3f8f4a6d..9aa1db20c700 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3063,10 +3063,6 @@ static int sci_init_single(struct platform_device *d=
ev,
 		ret =3D sci_init_clocks(sci_port, &dev->dev);
 		if (ret < 0)
 			return ret;
-
-		port->dev =3D &dev->dev;
-
-		pm_runtime_enable(&dev->dev);
 	}
=20
 	port->type		=3D p->type;
@@ -3096,11 +3092,6 @@ static int sci_init_single(struct platform_device *d=
ev,
 	return 0;
 }
=20
-static void sci_cleanup_single(struct sci_port *port)
-{
-	pm_runtime_disable(port->port.dev);
-}
-
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, unsigned char c=
h)
@@ -3258,8 +3249,6 @@ static int sci_remove(struct platform_device *dev)
 	sci_ports_in_use &=3D ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
=20
-	sci_cleanup_single(port);
-
 	if (port->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type =3D=3D PORT_SCIFA || type =3D=3D PORT_SCIFB || type =3D=3D PORT_=
HSCIF)
@@ -3425,6 +3414,11 @@ static int sci_probe_single(struct platform_device *=
dev,
 	if (ret)
 		return ret;
=20
+	sciport->port.dev =3D &dev->dev;
+	ret =3D devm_pm_runtime_enable(&dev->dev);
+	if (ret)
+		return ret;
+
 	sciport->gpios =3D mctrl_gpio_init(&sciport->port, 0);
 	if (IS_ERR(sciport->gpios))
 		return PTR_ERR(sciport->gpios);
@@ -3438,13 +3432,7 @@ static int sci_probe_single(struct platform_device *=
dev,
 		sciport->port.flags |=3D UPF_HARD_FLOW;
 	}
=20
-	ret =3D uart_add_one_port(&sci_uart_driver, &sciport->port);
-	if (ret) {
-		sci_cleanup_single(sciport);
-		return ret;
-	}
-
-	return 0;
+	return uart_add_one_port(&sci_uart_driver, &sciport->port);
 }
=20
 static int sci_probe(struct platform_device *dev)
--=20
2.43.0



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A73C36001
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:20 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.50])
 by mx.groups.io with SMTP id smtpd.web11.4378.1742379436922788295
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:17:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hIbEf0M0;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8doWqKe9LAXPAy2hb9bMlHb4RsgzHXESErDK2+TJw6lpmx/TY0MraOxqZDH0tqbbc2INqwuDoGQJQGrvQ1ivqVpaapF4ddYvYKvHeIBqFCGNuvHiULCPusVbrFRu66FyfAoDaXNcwlvlwPuYmgJAHNkdjSw+L7u6k85FDKBnGMfC72YU8N565+Bw0SfwD9m1qwlXD+e2H34XnkCJJpOgqpMAO1Nhrc/KuBxQ4KNoHBMXq4Vf7Inw0IivYAKs/LJfTHIOz5enkbUfxuC1ffSgZmnslaUaX3huagiPCeiE0yg1jtszrn+HdhsXTvMARpFapdCUkbRB8lhBdG28LwAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJfnaNeIduT4FE2V6EKC7MXU5ed1WdN6TjfMV8NPnfU=;
 b=Z0ShgNLBo8PUVNrjdoOF7zQ/o8zBbYRcu2E5j6SsZL1h/0IgjWgDvF098t0jiADk4c5XKlHBhTGtOJ+hBsgytQKvtiHrSUWP55AoCNspdD9LaEyyyIdwlBGw/iIpN1fNNiw/wgRuRD9M++sPsPygHGjc+cg1eV/Jf0LD9CfJpI7FJaQqnX8BDvKKrm79kdiB7TmVy4VNplFDt2QTxQ/lNJTew5FLIoSrvePd4jOXc3eontUO8rvA89hQzgpOmXkCnDy84SgWNxxasRXQ5DHKJfZaKFHZ/HBYGMiPJZha4bS48KkjYLHitOjuSQQNmoPn9CjzEz+owE/b3pXB5bD6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJfnaNeIduT4FE2V6EKC7MXU5ed1WdN6TjfMV8NPnfU=;
 b=hIbEf0M0IuCRNqvLXuyJ/nZ/0Pd700sirkqdd9H9EHFDjdqDajAKyBkx99xnjoCfZxz4E883oJrUfPg19/3SmY2MtWo6EThqzB1KldSt8ORSNABnbtnF4sXSF3lg2Pd0KLIrAvQyMk1o41Bos6DmigJTmEE19E3GldSWQsQpYAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:17:15 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:17:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 10/12] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 19 Mar 2025 11:16:27 +0100
Message-ID: <20250319101629.2407727-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB12680:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8bef6b-fabe-4e16-0a99-08dd66cf385c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YmCzt6ZrVxuMrm6aIauKHAo0MSyzcALfEIyYxQ1wuk+Qd1GrlOWTnCncU97P?=
 =?us-ascii?Q?gydprG4dWPZ2bE3Oe94QYvU9WysXboAX+s9mpmoXL3C+kvt9hgYHnzp2FiO+?=
 =?us-ascii?Q?GWZpTcYH+xjF2n9B9h/oE0zd5yTkuowYol8bjRrB8ppsj1afiSBMWkFkZJQE?=
 =?us-ascii?Q?5zv8VTCM1DWlEnzmWZv/tWRbCvIsNDODhEisOOVumgN3l4a5IYA4BKSIoP3v?=
 =?us-ascii?Q?5pTlYb1+KlRwsFvGmYXTs3sLjTlpjQ/t26S5GvVDWcw2NfSdpUD5AW3ffSV1?=
 =?us-ascii?Q?DPeGpmruPQin9b8h94vGFIcSC63tvK37VsUzO5Ninm+TeY1+pBsBMIng7vjZ?=
 =?us-ascii?Q?HJGGV6TYfXtJUE5ZN1jaTeGs959ldot71mDErMSkFkmjy2udQcDSBMIjTfU2?=
 =?us-ascii?Q?J1o0HbHQArml5g68IlRorrnj9G4rQ6P1qYjwlvyMNB4e6HYF4cpY+Bp8CKXp?=
 =?us-ascii?Q?Ik0PXPvP2oUVTVoR0bYe6+Ez9r9IWHxJ3AVHHwEhoC9z0UYPYohK9y/m33KS?=
 =?us-ascii?Q?P0vkxZ7ewEn85LO/YsV3U/AxTa7s8BT2Kv580F1NcSkQ/LoF9HBO/z3RPJSy?=
 =?us-ascii?Q?c3eM/7lBOSNHG6YWsS+7hpNT1aJe7CYfF3QRtjclRoSPSwmcz9UbZeD5/gr6?=
 =?us-ascii?Q?08MHOXYXAPDAfSFYOC917MPOg8YSQxlTDf7FtOrRm46letK4gZYiK3Y3JFgp?=
 =?us-ascii?Q?S/5xxAPgqCzQJhVvvBs+RN9VL0nNECPHi4BfFhvbRvTCjfI/XkyV6Us681q9?=
 =?us-ascii?Q?zgziP3lRYZsR2HcjfMrAcFfXNPXfIwQJT4XZ0OULSXhdVDPqvmrNWoNPFoFO?=
 =?us-ascii?Q?h42mkxEOXzNJy7RZ+F9JoRobXCZfrR1bYMLjn4jsX+RIytFf5LLfV8GRJIK/?=
 =?us-ascii?Q?ZvhjyoKDHfzh3TDNsmEvXnDR3GOUrzjL0SC1Ne69gZlusdVAJ+zqQZ21OdGs?=
 =?us-ascii?Q?GG4CWNbvrt7voCjh89x3sSixXegVEgqJi8zHnHW58dSo80mqwBmz4H5l8rx9?=
 =?us-ascii?Q?S1RL1rj4cfG68b0HrjlHsagW1lpwD4pcbPgI7LrQHpY6Uep90ORwSpjxcLOx?=
 =?us-ascii?Q?gAIeRlDZNd/b0sijSfICbxidfd4asUAdEqvNuB5j5I6vVABJXOwYKyaJ7w6S?=
 =?us-ascii?Q?HM5Nf7G4SMqkAnVni3To5d526XimRIXil+xry5H3GffU9Zp4jJdS5f9ySfZ+?=
 =?us-ascii?Q?+XS9OPvxLgAN0XouvYRd3KAJiUsNWaliHyBmsiS1bxdVK/vooZBrWzrvBQk0?=
 =?us-ascii?Q?unnPCeo+MWpZJSEbvqaMqbAUNR6OoJbsXaeNKrDBFBNX/evPUm5SX6X7G1nj?=
 =?us-ascii?Q?AjnN/DAVjbextxDb+GyhiEudGA9YiSvA05AFGLZUadXhXW7sZ1P09WSrxw+U?=
 =?us-ascii?Q?ab3jBgM8VseePb0UfanAxKXjp3QJgb+CK8IisFxuh4yUHOXB7VDWRfeE6HNI?=
 =?us-ascii?Q?gaYuwwmHJxURxhxL7N0mlgLQdqVWgSmC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?U4MWYFW2DGDQZUHeNRKyYpTNb+fTu5/89nrNb8MAG3xyPr6qkgPgmaAUGhed?=
 =?us-ascii?Q?nqbonXJQlloaVg3KRpTB5HYR4aGgeLCgzfNmEiJ7d5J7RdwevM12tJi2IrLA?=
 =?us-ascii?Q?9Ck5UX8xYlsVPUgpNfKY8UX69qVCVAtBgjAL8RGysaOVT7SksgDGlWWnuhkt?=
 =?us-ascii?Q?K+Fazr1fxG/YGEzmWo7nEsGWTUoChV370hRaxcPdjUnzolI6EmBa1TkcAxlw?=
 =?us-ascii?Q?RTjQO7DYNnZwBiwK6mgueJigf1vR2wD87sFzxqNRdPn0mtuWm3U5/I1cJGqw?=
 =?us-ascii?Q?g5y7zT+Zkuy8uTpbzrAR9mVljDqg7YRW1ag1Csbh37E1l/71XyVYeX9zl97l?=
 =?us-ascii?Q?FzAN0cEUsuFg6UrFSqPao6OEi6Elu2lzlxYv4eg6TizTxi/HKDcvImuAswMb?=
 =?us-ascii?Q?1tVmIHKhC59N2Gts7NiHSCJrh89YRFq8dUx1WURxfbPPFp6TR9hXWH6LIsCL?=
 =?us-ascii?Q?hC2GJDRM6yrl2FticvSNpBqZkVvl9w9ltZze40OMPZelH+7g7x1ozkn9riEy?=
 =?us-ascii?Q?or7lvfvz4c9BkrhFOHmOJB2nv/EqzaONgT6tLRmkB6Jmea+Hv2bOClP5VJeA?=
 =?us-ascii?Q?Hy/c0pJZnzKf0s7x9Nb4NU1w9j3H3tlLXel4yRp0iquRwV10y8Hj7oG7wXZ/?=
 =?us-ascii?Q?uSIo+r6LhWuD/c3LzNZCfICPYWbK62K1i+VOe507qhnuCfkDUktEE182AS9N?=
 =?us-ascii?Q?Zvq7TFBLXVdZNTxuXU/VVlIgRN/YlufUkmYDfSCCHjckDGAxTHZY4KNOu7JR?=
 =?us-ascii?Q?fHRb1xbyiueREak17Cl2Jd7SQtQZVkitrjWVft4/uICWcVvs+Ni2GF9qVJ8R?=
 =?us-ascii?Q?0g2px8FrJw97KoaXn2EScb4/WqC51xbnib0pn35dyTeEGavSfZYscXOUSjWd?=
 =?us-ascii?Q?eTqLnwziBHLCySnIFhPQmqTgCx2Euc6RLO7P63HXOTGVO/RaFzCQA0UScMvr?=
 =?us-ascii?Q?zEGPQjf6jMbYIpYUcPmvE2u+xSJaXzG+y/he7bJRBrGPiPN9nDBsOxzR0OQo?=
 =?us-ascii?Q?BBRNBe5397TpaQWKYt8Kk5WNhk4QtWa70bK7kgu3qFeIJNsTzV/lgKJu39TP?=
 =?us-ascii?Q?xEkhg2XHxjtffm92Oc/zIzGDkHEZXdfh5nirVCI/fx8s1dUw5BWbuDros7kZ?=
 =?us-ascii?Q?taMSWHK3wwilV7DKovqZg2JSwuOzBnXnxiz3KxqIPk+9E346d5e95nqMec+c?=
 =?us-ascii?Q?jHOqO79xXol8IbtI1w6DOa7GSwEckrmCB5UjeL/eZ4tlPGxpETXqSUrvdzA7?=
 =?us-ascii?Q?w4X9awgfaMDK4fCB2i2whZbQiW0aVTH0olrFqRdTIXITT7hL9Qn33u1f3P1U?=
 =?us-ascii?Q?aFo6CJwJU+VTnt1oBrHf9HXptcrHQy+GFviimgavJdTXzGzubCiJpllaIVhA?=
 =?us-ascii?Q?egCJI5TxApZW3elqLtMGzbcFgHWdDAos7H/L7slmdVB9YYpbkvtLSdyLN/OW?=
 =?us-ascii?Q?PfpHnFGsiOyfJuirVx9xMPuWLEng+QkOxOOyah1rp5AHD+4p7Qh55VxBYETm?=
 =?us-ascii?Q?6e94ntIQSpBwQtrDdvQH/2a9w0Myi8YLxPM9Iz5w/tWltIWPPpwoxjKijsd1?=
 =?us-ascii?Q?mVBExzBqE0mzjmfVxnaPc4Pr4etGtXeI9h48jr0PjhdXPlOeLrKoRFeGY87S?=
 =?us-ascii?Q?YeSxBwYTOPVPWDGwP+UCTfo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8bef6b-fabe-4e16-0a99-08dd66cf385c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:17:14.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iz67Q5bgxgpDzRj42jOftnj7pELrRPUyHOxjjLVs0bBJwLXFafpros5EZlhknBxXti9M0AFDzghMnFPKzPYO2ArFSHc+p7mVJFlZz7iVMcuZmcH4wJ/UVeEDzGnXIAzy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18271

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

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



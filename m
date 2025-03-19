Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42179C36001
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:49:10 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.50])
 by mx.groups.io with SMTP id smtpd.web11.4022.1742377739832156223
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:49:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dERQIJKS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jakxk3ccINGzBR7snoqc6bHneL2v9Dm0i+mXmjsTYD/Qp4GY4RE1RRkUFu/NGtJ2NSR0d2B4vHx9TtxRVtOQw7I/SzhlAABE2haTOkES47ripiuybvV12vW/pDLt2OeEFQ8x+HEoaqIxBUprq5pxAl21yk06KXmJFg1uMoxInXR3O9SofjLEUGDpJ5W22jsVWSINsLwX0S4+mD+wbocEoxmhElQGg/kdYMnBINC89BeOl/4WiNRZjL6d1O0UcfXNidzjcYkbSlVdEDe/u51FElgjccaDxTrAob4LEh/L/dDreqGsBWcPn+tffbNoN1oUEO9+E7Z30JO20dYXQ8ApwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlYelGc2FaXpWkFWHMxielKQYbvWvy8s5UB73g0DGKU=;
 b=NCzQXMrW5WCCUZ3JpOO1OptXwtknhUf2LPvlzFH0/7FKMM8TrqdOCe1sFKx+6aZ3KWR3YYv81QHUH305F1Wdd0rKpdUUgLGo+7Z93wvemjglHyDNkETgrIlq/xk2mnWL3+oVOsGmsgXKLMbPnT9iiEEe5t4NafOMb4NUYqaX6lCFcGJYFmhcArEVUniHCjr330W3Uyzn1Ui+Dx1ABlJmDtObU1OI7nenWMoahK4HFHXZvj5rADQB0IqEOQwUYpgTDS53QFymsrJBCnSFm/7lFvB7/9bu4OvlzkId+bEZMRp71Zq8PXD/QoyTGr+uXVyiM924HaszAfk5aOOJJwyN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlYelGc2FaXpWkFWHMxielKQYbvWvy8s5UB73g0DGKU=;
 b=dERQIJKSx20TLnjEWZ2TZBIMXlu/zY5ToLF5WkwV97TliUFbEpVjku/3FeLhCvUS4nJrXS5S2vDZRwrGqaFE2s8Bc6F3vStq9IslMv3/BElY7zgsqgp9LIAWRdh/I7kCa1jt7AghSrE+jix6TxYrjkqMLm9ysJxiafm/VlWz7GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:57 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/12] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 19 Mar 2025 10:47:52 +0100
Message-ID: <20250319094754.2404386-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13904:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e17934-c64a-40dc-c7e5-08dd66cb44a5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?t7gBpGhtiJqUhqNWCm0g82JRiN2BTFEBkIt6cQlF5kVj1yKTAS56+aYTBZrJ?=
 =?us-ascii?Q?OsPj77arhzCDfJrJsdaXTfGLtGLsHQY2BeAAgJRzIqyxdRqt7xTt36z7nnx1?=
 =?us-ascii?Q?oh4UqFLh/Q2u45WQakasM9ctuJDF5pHbIjgsUe6q1weTShgqSarZ0hpu+0sv?=
 =?us-ascii?Q?42LKplFc40HpIuc97LtzQf/XO74jD9pKsCKzv4tEGuHy2ss/74KTbkhQJSZV?=
 =?us-ascii?Q?3vVE/n6v+ygpDXOmXsVSy33Wn9zG+pfVxRZb3+NswX5kSnB9i5z/OXaeBfyY?=
 =?us-ascii?Q?b3biln0ZGfKxgC+7sCaVDTEPN4I1BJ4w1GY1SFGl9byVsRPO7beRtGBqHUBS?=
 =?us-ascii?Q?LXlTRZTHhg5wtO5ipRIVqyQpS3lIphkLzs/1M6X/XL5UCJKBhCPq2m+vzuL6?=
 =?us-ascii?Q?koQS46KvNqWxEEuWwS1ZmvmoWYT9EhHNBrL+7EPtlGTGObu4qrvS6Pu6NpmI?=
 =?us-ascii?Q?2UX2gN1bK2NstPtF1db33AFy6jay49tCQVAOf79NFvucQa6ysWUULFi5cPBE?=
 =?us-ascii?Q?3zxfDPfrPBEbJnWr7GarNqvvyFkuIdg2dx/yzIeLsNPT01WPSmVA0zn+LIXx?=
 =?us-ascii?Q?gnyHf/CDlhg+rlU0Spb04cUdop5yLYigz7XlYH82lt41JMQ+poNp14XsfWJu?=
 =?us-ascii?Q?6BOTs+Y6dXe7se9iFfO+HKp0MMLGHHxKFt0QsA9N+zyaNWiRfOSyZKwAuN0O?=
 =?us-ascii?Q?QepWhugnhxSaiXUFMu49DyPK1clu2NYn62XTAWN43bGTKJRQJINsRKttvObC?=
 =?us-ascii?Q?0lqNfDaG7nDCWgrqFd0iwtIRdEIcEg4vZamMF+usOzPdZCfk3VIvvsRrdEOa?=
 =?us-ascii?Q?v/rZ3aGOUMkFtVr1tRo35gPOlFPh1K9LIb/YcJ7DAlblC6W7eGGXe3TreqgC?=
 =?us-ascii?Q?0RpDtsj3NnDckzCjoJEgGekTgznSApLk7ILd6ebC+gpGXcCg3qJJPMPyI1Ct?=
 =?us-ascii?Q?GOR0D/yVKGHjAEX/EuecED5MRLpqWyjkXhWsZSEyuUwGdzJCSEXhUkcdjvtS?=
 =?us-ascii?Q?Dw2yQQoXbmqYBSgB9BKl4+9U3dRvwQmiUimxCuWkW8J9GIl0EOqfzBHXC9LZ?=
 =?us-ascii?Q?Q4H5CXydO+4RQqRVg0qPvlHwNCX3ak45RALCoJbByJawiEI6XmzFVbeBTcoF?=
 =?us-ascii?Q?5gs0hcOXylj1POHmL7uKSM2B5RwiT1gDsigUF8rtq/q7BdI7GWFXpzmB9uqa?=
 =?us-ascii?Q?OdX5NrFUdGu6MaIn9BjRkC/Qn/47xCyCA/optBMmONV1MdtdhFR0VfTQhrVp?=
 =?us-ascii?Q?aywBcB+Yf2Bk6e8vtxa22XLzy/qROpA4MJ+sO3jqUHoIQ0e++MxaMu6JKphW?=
 =?us-ascii?Q?QTB9dmQB5lG5HgevmieX0sITvHoCqCZxPy1e+fVj88WZmMR2VVHGINBpBlPE?=
 =?us-ascii?Q?D6yUm5NSC3WChzKFt4MW/Mu1W+md4jF/G03yHZER6W0HCgB7KXfYy6O10nPf?=
 =?us-ascii?Q?ek+oqPezfgxLbEM4oyRjR0rZxwxt7CWk?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gCiXVk441diyOnsAa2ENYgT1vlWo8XIzTz5GhBjF7Jv2sLdb5RaDaiynhurd?=
 =?us-ascii?Q?fQ3OQho4u4K2vCYOlZ1ME+XUILNn3LmcSbS7C9LKg1cANw1mN4ZCEYZJ1mzw?=
 =?us-ascii?Q?ATav7guwv8qLhDe/4260OaMLZ3wrNyIZbIdlzZ0woXehXDQT++ycyFAs+AzQ?=
 =?us-ascii?Q?EbeUCczy/mXKkiZL3FDJfMqdxGbaWo4eqitUNDdXPrgUiJ2fw+R+WRpgT5YH?=
 =?us-ascii?Q?OdVlqCttPnSi+VTimODIUldKpOf5lzihDPgLFbafRiFaDiwf+2azJ7oy7zZn?=
 =?us-ascii?Q?DLYd4DYYaOR68Zbh/IuJAgudrBHTxBB2FeQ2lSx5EI908vKtMzU+1rb/ZfVa?=
 =?us-ascii?Q?spVkgQoOzI6672mscwAUgiuvmgN4aiN8kOh0rtkbScNyWoc/IGguPpDmD1Mt?=
 =?us-ascii?Q?nTZt3PcUyfHIndXW4LB4/DPHXLPNKSXoZ11+OM2e0WgY5x+ho5Y+w86wdWqf?=
 =?us-ascii?Q?C17t9E3WdSkk3CT0+Djh7vHrcqPBVkidSHjM8kDRW/ktzL2BuC3hh2FgoL2V?=
 =?us-ascii?Q?MWYdeOKSTrbvrDBZBLM6F96OiaRbU6vF+OIC4tvAn7fBCyYSWFqaQRh5jjA0?=
 =?us-ascii?Q?yb+62tKNbbqLda9mafifhLkUTO6eD532jfKh2k28Vb9uFZfABP7rPBIo/FUL?=
 =?us-ascii?Q?e2MOgA2j6LQnlayR8EA/eeo93A4GLqGCRGsOMjCBgVLz+fnl06MMD06WIfip?=
 =?us-ascii?Q?7ohqrjRwEkBcjb75KGlpVm1FzM0fgxq6SmiZgQyDU+Pn6bz8YTKy57/6nsdq?=
 =?us-ascii?Q?/IbVtuVMGGhayb3GQn+LKm7gZEEOI1BWQDh1zvy4qKf2rYWeSCt50wb6w+//?=
 =?us-ascii?Q?8NYqv/csm3yp0/RMgCOLW+FrLbTZs1ge+AJiR8o4KD+K3QS4x27CgwoMHqYs?=
 =?us-ascii?Q?vl9rIqzYwcHT87we8/fOtE+IExms22DNQVsJKjJG+oTPI2tGetnRig2aiR/n?=
 =?us-ascii?Q?8A6tzp4d1YzbTLOKB8n2aJCBckDStZw7rspsGLUG9Zr0W18pOBVxCnr0FAGY?=
 =?us-ascii?Q?EL3p4+tINxGSa1Xu5rFAc1oTZ5dUwdZNOuWXHMCVufzDWPdiUoZmUkVyJRQU?=
 =?us-ascii?Q?DdyeQNwZ+nzdzMkhk+/Mx2IcvdrXg1hK4KP6Ava9JGLYk2IV/fhtDRb06gPc?=
 =?us-ascii?Q?+lpWSu0PwGlkX+UjQlBVFi5qCVrkOajOvGIsVdH7Es8GPXBBbBHRro3TWj5e?=
 =?us-ascii?Q?EslodMcKB6wQ2GP4VsAd4i0yCMWb8W9HPAo7vmMr0oN5UbC80V/aPpcwn1pR?=
 =?us-ascii?Q?VNawX5RY5R6khJT4W7j/V9rWQLikwEWd2k0w+Lmu5rE/IHFonFTyCYkinOBQ?=
 =?us-ascii?Q?oJbeWrfs5MrSeNVSsH04vnLKNOZaCnTigQ2At4HHbvzCx1Lm3ZTd8Lb5vUHi?=
 =?us-ascii?Q?VfGYjA6PGiOvU2bYjJGxk2TwyXKtHmjv1h4SVwU5d8gAWvmTL+jLXjlcdIh2?=
 =?us-ascii?Q?k78hXbU5cFQPBB0pfVhFQcajR1zmng1xGXg1Wh2+tSVTWRbKUYwBiKNTgPxY?=
 =?us-ascii?Q?1jhUFNJimfocUUEJ+6FTvT6veB9nIxQlCFqbNkoEFZizQjpGlrYgiRC5cvnm?=
 =?us-ascii?Q?47dluIFES6qkv4VjcAmbpYV2irVrOTDris0tQwByK7iOT4L5JlunExCOLSCT?=
 =?us-ascii?Q?o/4EKNo8JS2RbaSG71fmVlE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e17934-c64a-40dc-c7e5-08dd66cb44a5
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:57.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8APkzyOloJ2WFWAn7/Fh372J4PJqCBOIsGLT3AZSkkjNR5UgN5nxf+IEFXB0KXIqM/pL6l7C2e20n/O+UlMYZcm01b5RnhBH3pZg81mQ+bZhVNMPydvsarzhiyCa+0D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:49:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18257

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



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F04C36000
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.45])
 by mx.groups.io with SMTP id smtpd.web10.4378.1742379439834970103
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:17:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=q2ihW05u;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.45, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9o5K9S9QrtI7V+3YBZeAi4VkkAQYL+/Yd1Prb1rGRsaXKd3rHWetpSbsVj0f+P7uFbvRIH3g5rXYvhp5iSVwWRf01l3y7ruYNip1m7EisXAB68IfR+oMWi+1E4VyE72xEctnlp0KWqjZ/DUe8/Jj51PMSdTJmgalTtDda8MzrHtdfyr1aZe1T+5spt76D80bu/I5kG9WDDnqz6tds35du8bmAT2bZZ0GQ7y4vdwvoJn2B9H0WU/pugiJyKuFJsW5rBM5M1rjXZVEQuJNzQhEICGezXfzC9lgI2Euol0ms13o65UAtYaYQudOpLo3+fj9EHoJU506vasCrtn0OoXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw/ZADVXjSCG6UWsP8BrkGe718f7XRQ+zbPnaANMg8g=;
 b=AhN/cIvPwfF94hPpoHn3fbrbGUzxIlhvpBxQRSnT2Qz+bkUYyhgm/FoxVx9xgbfWxKIP9EEoF1WDxiWkDSooJSaleWxSO04Jx0xhF61ciDq5qyONLvnMg58jz3sxdjHZwDQjBLW/VGYmiNsA3ERUhtpZlxS5DHTtCvJHiKy9HM5tdobAGN0TAnZcUQZkhfsiKJ+GEG/07zIWxXKGQ58mHDCruTAf2OC7p/jsLusPekS66arU+bt62AczUuYnfLLae+9TBdm6lnVf5i2FPKWIM9o8gi/pHsGkfuq7aJ4aU0YBg3Y7D8cdgu8IAqkQg3XRuzaHgZb2xqJ/YepF+Vo8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw/ZADVXjSCG6UWsP8BrkGe718f7XRQ+zbPnaANMg8g=;
 b=q2ihW05uIDOeWTe64pIK0Pzkl4XKeclx0bdsci4Wh01cHTQhCs9puhvUg1TLUjW17h8M969p7YCgh6YLp8/SIikoCmk/Q/eYeXxOhmD7YMs7wLhh+Ww5g4cP25XSHUEMNjU/FlkOHCKi7TYuXC9KRxVt3vgLOcTkLaB8QmL9pJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:17:18 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:17:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 11/12] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 19 Mar 2025 11:16:28 +0100
Message-ID: <20250319101629.2407727-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1debae15-4721-4726-45b1-08dd66cf3a24
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6zmhjjxD3SU0Lo1SmoG5SZ/fxMuKBgmaBIYMziVm4WA5791BXDnw/4easAqL?=
 =?us-ascii?Q?wD9uQ53sLjO03cAKX1awasqvTUxmEzccVVDrXkIl/j+v9YCR7PYpocsQgW6A?=
 =?us-ascii?Q?vE+f/XBcbEqF4JamgrvHK4dIm5XtxpYEOFyt6lRFWlZDCDsb0w/eB+nXULHS?=
 =?us-ascii?Q?whYEMgjyGfrsTfmHNqxMln1tO89CcrCqFkkVtUY/CSxTUqRTkJbtQvi2xXtw?=
 =?us-ascii?Q?GEpbUKJ4mF2lJkRz4GzlUfRAnRMmCPByuwxP3PlAq4sYMJH2grn9d8uJ9C5v?=
 =?us-ascii?Q?IwFa51LSPQzv1o5F8/Dt+X6NTMNi4rXk1TixT9bxI4dvHvncMaUeb6l8CJuo?=
 =?us-ascii?Q?uGlaSHIuUKOxRt0hG2U1qOTxlRyxzV+eH/xWOictwetiee9N59E1FTD1/ExQ?=
 =?us-ascii?Q?X6ZhtwIpxOlIYgOmYM7kfYoHixMR0V1HJAGSrfKT4q9qhuRH7dbrWstdep1G?=
 =?us-ascii?Q?vXJbzwKSkXWw2WTeyx1AbJbgdwlby8Ub2gZNPTzs0YmRsXDDqvcZgpjXMJVL?=
 =?us-ascii?Q?sbC7VnVd+magCJiMI3SR/7f9RFqEn9mhH3PFLKuZv0ZNSdeHRk3adUScffZo?=
 =?us-ascii?Q?izOmxhG2XYWsaKbQVWtrpQ+s03k1w1eL5/WkhuWUFkyKKWgQ2EddOsxVP8Wl?=
 =?us-ascii?Q?f0Clu0tlmMJHW2kFxX14OFfKlDCqn3bTN+DaP122fCWXv2dF+YOvS63uyDgh?=
 =?us-ascii?Q?8OM5D38Lq+6VDpSsuWYGMZmbqD2inWl/cwTIP0TBaaFyuBKMNjKx73JjLRzs?=
 =?us-ascii?Q?9hZFdfD9j4cpOsvt3cm53VWNAHf+Po7ql4kp6HHpoVgrqGuuVa/xUl+2CoZQ?=
 =?us-ascii?Q?A7u6/MZjCuwAfPW6OBsFT3jrJl7wGKZ1hrw+JIK3BkIC8jG4caRC7MS4CFYY?=
 =?us-ascii?Q?qYYA9V/cNvm4FqbshibirqP4xqBKLMdly5w7Kr0JZxsQOfvOC1V5x4VImxYY?=
 =?us-ascii?Q?XeMxPjKF8PNPwpCFgR2wwPH3PKolkSCKuk3lr49PieBDTXRmMp6nPkhmqq/C?=
 =?us-ascii?Q?q9I0fqwy6S8k6D1uAlyLm4yKCN5ny2EXs9fMG/e5Qqp/ibsnK9SyZmWjnYtz?=
 =?us-ascii?Q?RndNh7gkoDowpHJ/d2ONX6WHhjdCuHj+d+VYCnGnGxk5+ZpFGVzuLALCyQ0M?=
 =?us-ascii?Q?tq8tfyaOZs2TlhdtpKVkNX275w7U2TaoDSvTPoLgvQaRBtOGZameiconUNsQ?=
 =?us-ascii?Q?NGbQg3+Xhx+oJJ3FQrSDR1DXiZ3Y6e6PCXw/nqGkEGtRoZnPZSe+7+Q4kiGZ?=
 =?us-ascii?Q?vFuyqIkNOeiDt5DrQn6xk1GNZwkdfcCiRWoa6Iv74Ez+tLCH9HTuy17M2wMZ?=
 =?us-ascii?Q?ujDeFplyo9nPXlwpxnX+7SfHACcHEquNp2ThR+bJuO9Suk8FCSChwd7jgvu6?=
 =?us-ascii?Q?k6H8RbxQSAmwg9x9vr+QYJnEQnoEqjqkJP7XS1rga9y9yMgtNuBbNl5lr2Ia?=
 =?us-ascii?Q?lc78U5fuvzbEhoCQyCjk0EkV87tX2SF9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ue0bhhgFpiVW+ZtLfhuXSmhMZargetp8xulY/eQu3wHaD6J8qf3ZgBGkqG2Q?=
 =?us-ascii?Q?BjBd3BCQP/cTpbUiJ9cWNW/6aLPgYSWwWzpKl4bxnwbiTWPtALAO4/Ctvi0G?=
 =?us-ascii?Q?2wvt4VtzbVqkc/peDGnWwBIIsPwwYL+3iEPDFcUvvn0UxifcYBbo+7j6kczk?=
 =?us-ascii?Q?2FkEVkP9+y7pH/LsdGQlcrfAHgQVsOTrzl8XJvnV1UPTOQ/0/SDER8Ntr6Bi?=
 =?us-ascii?Q?gochA5Es1jHaau9CGM5CQgGEb+tt8miywyauPblAkbgWZIn/ytkA1CC5MRap?=
 =?us-ascii?Q?hjxBUgFcvElqBncVlQhnHLz9tD+bQKRO0wB0R5G0cULik2W5bGLgVrUnaJ78?=
 =?us-ascii?Q?eE0pkJ0WX8jou0O5aP2InZAC8e6e5XcHJZ0d7TfKkqpHi4DJN+CsEfjIYx9d?=
 =?us-ascii?Q?5OFt5zDQ6Lh9/XFu+UDbGiLAy6j/Xoif63P71FTE2PWbhInOlPcIZjNmAXlS?=
 =?us-ascii?Q?mrluMmWyMjlTs/XHQ1wRQEqroPfaRuna6fRicVccntCzmp/Pfly5eqBBIF6V?=
 =?us-ascii?Q?p5lzAxa08Rl3W2txk7tfZ2ChhidVnOKSqGwd50fVCpH9g7PtoGAjvg1nG+fp?=
 =?us-ascii?Q?IlDCBIkcgpoF/hl91JVGjzTrdAR3QkEaxlg6m42TIX0HUd8e/oc7MTOgAQ+x?=
 =?us-ascii?Q?G+TIJA52yJDdAaBw3m5LpylF6FUx2jEKsLiSP/AFMQAb5+yrfY4AjlGKI5y6?=
 =?us-ascii?Q?tACuX8u1csH3ae2+lA8Bhr4Rm/2X1kPGx4AnvwiV/b3vkQuAQJX9pYJE8kls?=
 =?us-ascii?Q?dGHPU62XOmAExlorNNkYD112ldfk+vwmt+ArX6PAaLklZIXEzpGy7hzLgzA3?=
 =?us-ascii?Q?g0Hh7wS++YGEdFrEI6iQGuS6cHP57eM5VuD97yvyp0JsUrQjY01z3XT5XQ6u?=
 =?us-ascii?Q?GnBCwjaekOkIo77JSEf0H9IfrqsOMA4GlLlL+XCsx3A7jHhhPzga/sExYT/m?=
 =?us-ascii?Q?39Gk43WM/z+D6KQnE1HWjokjOObFeFwfBBJ3JmcUXz7nqDWyQxzB/MaJvdas?=
 =?us-ascii?Q?zBuFMUdiggy1dH8ciU8ztk1fK0gY4osUe9+eIBrCMSrubq6EX8Mo73OWOu8v?=
 =?us-ascii?Q?+znOyQ8RF/Y3qTgu7ubqIIKVYyPYj4a07u1GzF/rX4jqr/muZcH3GpJKmGQa?=
 =?us-ascii?Q?T8XfEV/3fzVGxBzIaD+57BwO2o9oxxkvhBrpsg3CtUxIGh0Iq7U/qS+WpfAI?=
 =?us-ascii?Q?gSlnxwyUasoApA8YMhmKaFs8qROKSiV2DX2q4ijRoWhljLax3n1YV3dQ8NkJ?=
 =?us-ascii?Q?3LUGsl9PCXHevSFEdUdUgaOoEux3u896xrJsz4Eb505bmAQer8CiJRn4axLy?=
 =?us-ascii?Q?GmgKW37SCcygufaEViYmmz/msyockseUL+po8BM3Iti7ZizWnaOyWdFMB+yt?=
 =?us-ascii?Q?ySa8WJoWc0RezNIStHGXzqewYiMBBUBK2gcy4ULnxCXZwJ0B+rPP30vSpPP8?=
 =?us-ascii?Q?AiyYfQYB0AZmoO4Hh4ZIq6aPl14aSy0t1he5PH/XA+9YWd/eZDYiaCk5RxtJ?=
 =?us-ascii?Q?klZ7bj0vwxr+tDeqdAPbE/XWa/MqpywYrAk1YDAgBpdzNM/Vu2AOaf2f6J99?=
 =?us-ascii?Q?uiDb54luf9DDmkdS3Fqi2fTQsjvf5WHRXFMD4NYC6+QD2ISX988Arg245oOm?=
 =?us-ascii?Q?gHk4Th0cLhpjckP4e1Id5+A=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1debae15-4721-4726-45b1-08dd66cf3a24
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:17:17.9876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYTKk3Ufc6U17qsoIZeLSA7gwQ84GpG5jzrkk2xGImBCjdl5JoTOWynazojuqPiuLvc4guKeFwfgjFTHweh0na75zHAbvBn8dugB9KexmlQIMgP9KLJuW5avHaWGO3kw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18272

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5f1017069933489add0c08659673443c9905659e upstream.

The early_console_setup() function initializes sci_ports[0].port with an
object of type struct uart_port obtained from the struct earlycon_device
passed as an argument to early_console_setup().

Later, during serial port probing, the serial port used as earlycon
(e.g., port A) might be remapped to a different position in the sci_ports[]
array, and a different serial port (e.g., port B) might be assigned to slot
0. For example:

sci_ports[0] =3D port B
sci_ports[X] =3D port A

In this scenario, the new port mapped at index zero (port B) retains the
data associated with the earlycon configuration. Consequently, after the
Linux boot process, any access to the serial port now mapped to
sci_ports[0] (port B) will block the original earlycon port (port A).

To address this, introduce an early_console_exit() function to clean up
sci_ports[0] when earlycon is exited.

To prevent the cleanup of sci_ports[0] while the serial device is still
being used by earlycon, introduce the struct sci_port::probing flag and
account for it in early_console_exit().

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250116182249.3828577-5-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

 drivers/tty/serial/sh-sci.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9aa1db20c700..f8e4062d9b4c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -167,6 +167,7 @@ static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
 static bool sci_uart_earlycon;
+static bool sci_uart_earlycon_dev_probing;
=20
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3385,7 +3386,8 @@ static struct plat_sci_port *sci_parse_dt(struct plat=
form_device *pdev,
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
-				      struct sci_port *sciport)
+				      struct sci_port *sciport,
+				      struct resource *sci_res)
 {
 	int ret;
=20
@@ -3432,6 +3434,14 @@ static int sci_probe_single(struct platform_device *=
dev,
 		sciport->port.flags |=3D UPF_HARD_FLOW;
 	}
=20
+	if (sci_uart_earlycon && sci_ports[0].port.mapbase =3D=3D sci_res->start)=
 {
+		/*
+		 * Skip cleanup the sci_port[0] in early_console_exit(), this
+		 * port is the same as the earlycon one.
+		 */
+		sci_uart_earlycon_dev_probing =3D true;
+	}
+
 	return uart_add_one_port(&sci_uart_driver, &sciport->port);
 }
=20
@@ -3490,7 +3500,7 @@ static int sci_probe(struct platform_device *dev)
=20
 	platform_set_drvdata(dev, sp);
=20
-	ret =3D sci_probe_single(dev, dev_id, p, sp);
+	ret =3D sci_probe_single(dev, dev_id, p, sp, res);
 	if (ret)
 		return ret;
=20
@@ -3573,6 +3583,22 @@ sh_early_platform_init_buffer("earlyprintk", &sci_dr=
iver,
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
 static struct plat_sci_port port_cfg;
=20
+static int early_console_exit(struct console *co)
+{
+	struct sci_port *sci_port =3D &sci_ports[0];
+
+	/*
+	 * Clean the slot used by earlycon. A new SCI device might
+	 * map to this slot.
+	 */
+	if (!sci_uart_earlycon_dev_probing) {
+		memset(sci_port, 0, sizeof(*sci_port));
+		sci_uart_earlycon =3D false;
+	}
+
+	return 0;
+}
+
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
 {
@@ -3592,6 +3618,8 @@ static int __init early_console_setup(struct earlycon=
_device *device,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
=20
 	device->con->write =3D serial_console_write;
+	device->con->exit =3D early_console_exit;
+
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,
--=20
2.43.0



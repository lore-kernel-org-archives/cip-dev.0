Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689FEC36000
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:20 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.46])
 by mx.groups.io with SMTP id smtpd.web10.4376.1742379433780974653
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:17:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=s4RDoXpS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.46, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKNjZzdPuKatKaSnK72nPrM9x51KX8OweUCDUccpRGb/kG5PTnPYHS6MJxZEhkHmmwSCYME9F+IAxXLBaW6xX1q9F9De+v/w19v5rstv+buteLCve5/VOfF5iVEwv0+qMdOOnIlmT8TaG2Hb8gC+DGHeZ9UQev7YRXNA5rxrZfljaaTdyptiFnIKhaP94eIqHBpzaWAuTZeorJPiTl1dM8o1AMDMa7qs2Yaq7Co1qNKCP6R3uYYaOfs9jFY0Rpzeh8LGDqgRVBS5AtnlmRIhsQyCn5hXYChm9kf3iHBFI2DuipqhxGOmouqxAWhjINqTzewPCUSPM9E1xpwRBRTRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7733/hKfw3RJ5EHNFEeqQ6Y5u4AV1+PxJNkOgF5F1h8=;
 b=C8vMJ74lwpWYA/Ny0zUrhEFZTby+sSTlfvct3Fa2K/DS+VxO4GkVNQyG81rFjLDsH2DrYN7HcVo5WZu12THWXnv2dd/ymkXq1uBOMaZcQwYI1KLUGHWeXQrZavsbW1H5+CzVW/Hmb3EImG6qHECGL8ebngt6/mAEy1PO/U016HW/6WBS967fePNpizm8DI2bR2zpAV4NRYHnUMokZrJgHGy35fPmeIyHL06lfpjLBZR9R6kmDa2xlGer9ERp6dJALWykBZv0wxo/+tXGcEwBAABNOXbwWNCGDu6tlZs6IWrooOLUbnWT7ESK1OC2e1BKrJmBg6PfVDFSuGTUWvaoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7733/hKfw3RJ5EHNFEeqQ6Y5u4AV1+PxJNkOgF5F1h8=;
 b=s4RDoXpS+I0v8gLrmmmv0sN6aHOC8lQh4KiMNfvD4oJEzApY8PecctK/Wpor8RkNQjcB+tb7LKBXj/vUoseIgfZ64ZmILoY2O85app2qAbDPmCXushM2KTxUZkFcnOu0UN70r7RM+qcZObQ2WH6Blsnx5UmurUyoX9ETOfhUsgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:17:12 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:17:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 09/12] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed, 19 Mar 2025 11:16:26 +0100
Message-ID: <20250319101629.2407727-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90657119-feab-48de-62dd-08dd66cf3684
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8BXFiNKWpE2xioJH7iUihhJ3Uelfb/SJwi7bzYxPusQRa722IUAZm7yDjJLO?=
 =?us-ascii?Q?hP8MwXyoVtoq5Bx4mlbdXSV2f2jWwGMQiF1i3XEKUrgTTiC5bRFrNW8uQ9B3?=
 =?us-ascii?Q?kjEVyTLBzNBKTYHZwMd0uMAzgGoELEn1guZOek9JE6mXxnVm2y3G0H1AbSy/?=
 =?us-ascii?Q?y9j0q1JTKohwGx4bc2WjrIl0OaxlZuP7Iyq9EoWicZgiyPWj1JpjRGxKS9WP?=
 =?us-ascii?Q?5OC+yoOf3auRUFyRMmaj1BN0Yq04uyGgElOjrmR7U6nm1/Xt1/sAwLsxUyxe?=
 =?us-ascii?Q?xojrW0eQ3CJ9r7EpiMr4QAAxIgQQ8G58epxuInyn2YSfwmQdh6bCek1eatOX?=
 =?us-ascii?Q?Rp9LGFrkSU+jVYvuJVp8qVsEMtJO/jGJwjb4y9pkMukbdyY6Orkz3eKp5nW7?=
 =?us-ascii?Q?RaOMNvF1xxRV9erKrg6+j/tHJHXTVZuXjlQBLi4UWDesjzvZ6TtmYv8Adytp?=
 =?us-ascii?Q?Xn2UKT3v8zBzFVP4eQbA9di6e7CLKz8BONbgFB6A8VpHKG3Ihul6K9wROIT8?=
 =?us-ascii?Q?Earv81FbOPI89Ag5Xptnjql3qaiF1NTrto2aeNSh16Cuucfb/KkQRTp26t3m?=
 =?us-ascii?Q?3ztaYq24QLPmb9itqxuuCClIYPHer9nqh47gq02yKXDi5EM/AZf8rIa29JGP?=
 =?us-ascii?Q?37kBzq4/7a4uMgHCD5ECv3RyM57guFr7HRT0kkKQM7MZciQmyJ7JBTyx8UA8?=
 =?us-ascii?Q?svHgWGlhMZh0b5SXWqBePS8D2qsOi+xXjiH6QDD7COQk18Jr1Sf8BPKZkMpR?=
 =?us-ascii?Q?ksPfwrOZuIohHgGfkwDExG/2R59z5rr6NlTYphcFO3xeffpuByQCA/WAyfXK?=
 =?us-ascii?Q?2xde73YvetVM92TpdYXCuUsfAW+tlSuTM/VCA1Tfkh0faARQY4O1+0qEMBY5?=
 =?us-ascii?Q?PFMNEh+N8tiq6Rn+kdnHMPMSgrR66XPEdkkxehFGq47MzyCYNZOxc81OihvS?=
 =?us-ascii?Q?52HyBkiV2Bii69FhnD3sc/V2haYd8Rlq+WjfSyGkggNXr0x8SaWTLRyJ1zyI?=
 =?us-ascii?Q?iYuZAsgEgiQ31AON29e+tMO54lZ+hLbvXoDI7AXMe8pCDdaiBVPUTvwjiAmb?=
 =?us-ascii?Q?Ts32TgyRZJY5K0dVNY8CNpi9EWSBvTeF7ZnmjpNVm3nK4p4gDrz08ZiLknGv?=
 =?us-ascii?Q?n8jQORGxrwDWKKXQI64DiuotvQCToo8Fh4TzDpauMvapSWVXSSib17Zrk1v1?=
 =?us-ascii?Q?Os1YS3ofvD10JkG7ytyNwS54PPLrcIMhwclb7q4EFI+FuQfLIsPXG1FbCw9Q?=
 =?us-ascii?Q?qL+mAmxbIt37TZnjZROCySZYQESDxAakc3bvdyIMeGBKz6McI5kHeHmoAiQk?=
 =?us-ascii?Q?i/j57NMzc30zvcgZW3IWqGrbWzMzXNqCm3Zk8cqR5qanJHwmkkIC4JGXlfZF?=
 =?us-ascii?Q?EQhlVwSFe4oInEbBVD8J732wRL6rl7jIEKMmlTgyMzKb/Yycq5uxKncJpdCN?=
 =?us-ascii?Q?nDgjCfUPqfWef43jf4gfYWCLoI41O5sF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NHFFXiJJTkauM6/szjS4tNp9kedjNHfFx8resAeaz0puB5UuzwpXzChtVMfn?=
 =?us-ascii?Q?uoOrJFa/QsKpG91rapxXFxVmj7OEuMbqK9Mwjg8d5suWEnCdse8rjY9sX9lu?=
 =?us-ascii?Q?HJ9eSzeUaLQlgBE+niTohvGwuthTSJVkdfAx2iJ+7r/wCYd1pT9z4TKcZDlW?=
 =?us-ascii?Q?iyNfP0JCQbvnlBDN/R+ILitO9ev4Xf8geiql/sIcf9KrS2H5zrvClTgk4/t2?=
 =?us-ascii?Q?Zu80Hk5LBUCrh99tRKmz8RXmaocv/fjeEtAOS0WjuGlg8obTUWoBE8+fsc09?=
 =?us-ascii?Q?5rvkpMLRFnHv1t5jl5BhXGbc10KgcEMUR3+asz+efuatlM9HMQvjD3i7HLlJ?=
 =?us-ascii?Q?AXiuF3+pPLEWeuXlRlpdfaj90GA4Zri6xikqDNLcj4HuCxCmCzf5XzotrlT2?=
 =?us-ascii?Q?fhU9tq1MiV5nyQGDun329hlJRW+zJGXcUys/OUiObMT8rE5cS8du6NjLGbpT?=
 =?us-ascii?Q?IQwbvrPyP36WLyL4JRC1OS9BGrl85Dq05LdmbZo+vQtqYsKuSApdJYgA3cHn?=
 =?us-ascii?Q?2pEXkFKDC1RvpKkkJWreK9eqn45PhfcKzbyh5FYCGmvP4gljypYWIw8xQ6dt?=
 =?us-ascii?Q?+CX/zwjtwnBha4+V2MLXsdBlYAIomSSvsM47Ef4ohZz2zHbhZMQ9jWr9k0zH?=
 =?us-ascii?Q?j4/yRiIbMfZSkY4E+wG2DVMOTCvLsqlX3FKQDZJ5AzaP8nZj0q060WkuYpPH?=
 =?us-ascii?Q?HPeMHdQletGp7ffi3yaknCIceTnZOc6udO21n+0SPSfnU6roFftitDRpfoL7?=
 =?us-ascii?Q?/1envzOLFilZUyIbKOg8BL6MaKTJMtxN624COezAO2EIRE+wA30lyOHPHGeO?=
 =?us-ascii?Q?8SlIU7+3cwO8uMEyDi6QmRXueUrL08goxXRAT/QjnPYOZcUERAr7E2QT3/zn?=
 =?us-ascii?Q?RW84RBeI43GM3rsMQaT49ythGN04VST7Wt+4wAymg7tJ5po+H4DigaC+sMe5?=
 =?us-ascii?Q?DcI8hBnX79CnYxb9CuZfsyFqlEyt3H2EJb2dMi52uiyeA25U+oyxtELfkVL8?=
 =?us-ascii?Q?Wp7X7vnnbe4u7n+FSsN+n5P3S2wgzQ4h44Jab5ocFtLKPZzCA7/+nDzZHM4E?=
 =?us-ascii?Q?/EXPR+qlWm81uSOaLWndGX/arudbHQEx3x1wBk+lT1Xw6zx2VlFjLoz9uwpN?=
 =?us-ascii?Q?7rTEv2q0Td7xGkgjhTSHIdrEzbLza7umom5A1K6neOW7vr8AQz53SMkHZtpq?=
 =?us-ascii?Q?CkTaKf+pzmxWAPs2138MPNH/HL1qeO3fpkLqzvM8TrXF7vSL/w0eQXh5gDG3?=
 =?us-ascii?Q?wMZiB3HVKK/iVa/MPf9gc5Z1jYxCHTYEGUCMhYa6Fm/juk3V3gZDygXv9nbp?=
 =?us-ascii?Q?lsH7CMA4iegE5gEt9Kggco5jfSpatHcEnaumU5GmV2V1WhleQxhikYZOQ3pp?=
 =?us-ascii?Q?kwSzuoGF0rxIODKr8ho3BI//Ng3GyIvqBNbk9QEztCSi9farmz1Zo20tzI7q?=
 =?us-ascii?Q?yE2BzADbLwU3KZuaKJpmagtlB/vFdMqU9nmFsFg6vOMUjdiWEM5GN8rtYwTe?=
 =?us-ascii?Q?FpvvnETXl+h8+4bZJ/ZjqvEOJ8woi1umIsvwpnXCnTAOFtv6mw0bcnJbNu06?=
 =?us-ascii?Q?NOIaYPPhLBRSgo3WZwbc7cBe0ajcVluwGeCHqdnH/R0pGr/PBWz+68sSQfxy?=
 =?us-ascii?Q?+E3dFyRDBN1c05a2GSrvnEg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90657119-feab-48de-62dd-08dd66cf3684
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:17:11.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlCTv750JFK1DY1G7u0BzFt+IIFQJRV+TncSpSM3vz+hGZrdJZWM44rhiq4bUt8cxP4pqY6MSM92oJPPZbk6QJ5vhW/x7DZd8Fu1Nyqtqy5e87FpIkYvQiBJ7Qxb7I9T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18270

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7cc0e0a43a91052477c2921f924a37d9c3891f0c upstream.

On the Renesas RZ/G3S, when doing suspend to RAM, the uart_suspend_port()
is called. The uart_suspend_port() calls 3 times the
struct uart_port::ops::tx_empty() before shutting down the port.

According to the documentation, the struct uart_port::ops::tx_empty()
API tests whether the transmitter FIFO and shifter for the port is
empty.

The Renesas RZ/G3S SCIFA IP reports the number of data units stored in the
transmit FIFO through the FDR (FIFO Data Count Register). The data units
in the FIFOs are written in the shift register and transmitted from there.
The TEND bit in the Serial Status Register reports if the data was
transmitted from the shift register.

In the previous code, in the tx_empty() API implemented by the sh-sci
driver, it is considered that the TX is empty if the hardware reports the
TEND bit set and the number of data units in the FIFO is zero.

According to the HW manual, the TEND bit has the following meaning:

0: Transmission is in the waiting state or in progress.
1: Transmission is completed.

It has been noticed that when opening the serial device w/o using it and
then switch to a power saving mode, the tx_empty() call in the
uart_port_suspend() function fails, leading to the "Unable to drain
transmitter" message being printed on the console. This is because the
TEND=3D0 if nothing has been transmitted and the FIFOs are empty. As the
TEND=3D0 has double meaning (waiting state, in progress) we can't
determined the scenario described above.

Add a software workaround for this. This sets a variable if any data has
been sent on the serial console (when using PIO) or if the DMA callback has
been called (meaning something has been transmitted). In the tx_empty()
API the status of the DMA transaction is also checked and if it is
completed or in progress the code falls back in checking the hardware
registers instead of relying on the software variable.

Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20241125115856.513642-1-claudiu.beznea.uj@b=
p.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

 drivers/tty/serial/sh-sci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d1140fec861b..19fa3f8f4a6d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -158,6 +158,7 @@ struct sci_port {
=20
 	bool has_rtscts;
 	bool autorts;
+	bool tx_occurred;
 };
=20
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -853,6 +854,7 @@ static void sci_transmit_chars(struct uart_port *port)
 {
 	struct circ_buf *xmit =3D &port->state->xmit;
 	unsigned int stopped =3D uart_tx_stopped(port);
+	struct sci_port *s =3D to_sci_port(port);
 	unsigned short status;
 	unsigned short ctrl;
 	int count;
@@ -889,6 +891,7 @@ static void sci_transmit_chars(struct uart_port *port)
 		}
=20
 		serial_port_out(port, SCxTDR, c);
+		s->tx_occurred =3D true;
=20
 		port->icount.tx++;
 	} while (--count > 0);
@@ -1249,6 +1252,7 @@ static void sci_dma_tx_complete(void *arg)
 		uart_write_wakeup(port);
=20
 	if (!uart_circ_empty(xmit)) {
+		s->tx_occurred =3D true;
 		s->cookie_tx =3D 0;
 		schedule_work(&s->work_tx);
 	} else {
@@ -1738,6 +1742,19 @@ static void sci_flush_buffer(struct uart_port *port)
 		s->cookie_tx =3D -EINVAL;
 	}
 }
+
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	if (!s->chan_tx)
+		return;
+
+	status =3D dmaengine_tx_status(s->chan_tx, s->cookie_tx, &state);
+	if (status =3D=3D DMA_COMPLETE || status =3D=3D DMA_IN_PROGRESS)
+		s->tx_occurred =3D true;
+}
 #else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
 {
@@ -1747,6 +1764,10 @@ static inline void sci_free_dma(struct uart_port *po=
rt)
 {
 }
=20
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+}
+
 #define sci_flush_buffer	NULL
 #endif /* !CONFIG_SERIAL_SH_SCI_DMA */
=20
@@ -2083,6 +2104,12 @@ static unsigned int sci_tx_empty(struct uart_port *p=
ort)
 {
 	unsigned short status =3D serial_port_in(port, SCxSR);
 	unsigned short in_tx_fifo =3D sci_txfill(port);
+	struct sci_port *s =3D to_sci_port(port);
+
+	sci_dma_check_tx_occurred(s);
+
+	if (!s->tx_occurred)
+		return TIOCSER_TEMT;
=20
 	return (status & SCxSR_TEND(port)) && !in_tx_fifo ? TIOCSER_TEMT : 0;
 }
@@ -2255,6 +2282,7 @@ static int sci_startup(struct uart_port *port)
=20
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
=20
+	s->tx_occurred =3D false;
 	sci_request_dma(port);
=20
 	ret =3D sci_request_irq(s);
--=20
2.43.0



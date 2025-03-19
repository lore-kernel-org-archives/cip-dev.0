Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62511C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:10 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.46])
 by mx.groups.io with SMTP id smtpd.web11.4376.1742379428032904135
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:17:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mg0qUHDH;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.46, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ix3fFCLHFKfOMEwhwfWbEqpG4fzgicJ6bEh6ra6/OWkF+RnUVPuY6BBPoojYLBF9Nz2aF4OXMv93IpPu8hC76mJzvsUJtTSIDtzB0EgEwCGZZCwTVtPn4Iw6Og9LHRNxaZu/RAyEL/yz80T7NNf/wtSZYsdZKFv0jMCjhVnfxC9e/+2GP6dI2NUc+bYBagx2Zuk7uOQ9V6nJ/BrohptVS6kl7N0jU770d8pqAEmHKFMnX6OZdosu7PHeggtW9UAt151mwRBTgrAjOfseAjuvoLg6j21l9OhQzUvXfD15Tp4pEPEzMAP3KBIdP/OjhMEXuiGLBC9XeNdHNrUeJ0WSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xSYx7LMNQoZTvWKW/i1nqr8G3MqH8IMuxHsqPTZ4vw=;
 b=aaHs8cyuD5q1VkWNO8t9jRXx7yBPCEGpOPMhvCOQVmnqTkw9qiqquQCzx78jl0pAKnl0FQkFkw0sobP53lcBvp7XawXQ9POGuuefNtXiAnhcgyv6xkTwy/vUVzZIYpsOpshSOmQOwMNzkwFOIISLD3eD94KQa5njO5SEbjJCh/NzuRDeWN3ZSziIquZY1uSoexSWKkULkYGG8EWrf5n9EW2i0b/zS7yKm6GXc5gRWXzI2EbTw8IEYcGBy8sL27hMutZwncjbPde8aVIOJLREqaxV9Co8ovqmwrcyuBX9f5C9fsq3FpDc6yP8xcz26E+ilrGkUalY70tuaYurLlV3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xSYx7LMNQoZTvWKW/i1nqr8G3MqH8IMuxHsqPTZ4vw=;
 b=mg0qUHDHOddFKzd+/VCsV8e5tIH/yjCejeJdnDsdSTEfYVSb6+JobmlpM/frdBFXf4+H23IHnTKdRPi/6eY+CeP5vnCQYerGiExlkVTGVI/DWR5kJdWonTl1zF7M7yux1fNq/FUOGehrGrhUhYFqGA4Mey7yoyb+QWEo+uqJN8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:17:06 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:17:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 07/12] serial: sh-sci: Add support for RZ/V2H(P) SoC
Date: Wed, 19 Mar 2025 11:16:24 +0100
Message-ID: <20250319101629.2407727-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8325721d-9a0c-462f-fa94-08dd66cf3313
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3USpQiZkty2fqjXSgx0NEuQRWMnNkojhQiruuuUZnrsjYaxZi6giPQmXULLF?=
 =?us-ascii?Q?ZzzN0wR4djGyW25byjkjv/KHLoUpWpRc5I9fvc35hZPnw6jfXz2n4tv2wBlB?=
 =?us-ascii?Q?Y+MzVuhbQHszCcIVjVf4KdzhV52UM3ZBihkHXarGMHfgKq1TGnT23r6nXshY?=
 =?us-ascii?Q?iglXPh2i/KOPW4uGyYt1HvG6zi8KgTMSebbaSXTI3RuBSTSEiaATQU796Vw0?=
 =?us-ascii?Q?IC7ECYaHeL6+sX+EJPmPSeV29kI+C1rqGkOfiokJmiVkWVXe+POS0uLcGwEi?=
 =?us-ascii?Q?qEL0C7rndJp5H7bzW+ZZQJzBsGflnBYVKETDJqtaUp6HoMyd0v81rzWBRuOT?=
 =?us-ascii?Q?C0MoG7Ps6MZRfC8/8W489fGBRawIjTgQl9zoifCDh6zAR/jOfe8MjsKW4H8n?=
 =?us-ascii?Q?tPnoPpB5apXOrvfhHhiA2J/CjRd6RVR2ADIHC8cvbQsOV6bCAcaJl/L96NbS?=
 =?us-ascii?Q?w8QUF4dD59Iy/tiI9B6IUNizR+dvgzoMLxwiHcYLUUS9f8c4BEUgDPDAiuwo?=
 =?us-ascii?Q?OSVbJJVA4gdeJ9Tsa6ncjXAJ9g21cNo65agXMDgYnQv3lKqD8NBkb9VmL8ga?=
 =?us-ascii?Q?1eSKsHnrq137ED3YTD5NvcShwZI/RmZQmgfiTRrNocPMAzrFMR0Hkm/kseyr?=
 =?us-ascii?Q?OXe0VKs/RF8j4igVTtNJ9uKMvW7nsUvuzmFtRTLjtsKVp3tObkeOyDufwb5D?=
 =?us-ascii?Q?LjCIb+lQPEysEsVR0AStK33E8Y6u1uDb0C2lzPIHkwPMDgyvFVE2FHyeem3l?=
 =?us-ascii?Q?2rdtU30KFCDuvGCN+vNYSTzA3nU63M/rSmqWisqTZiN2p9HInz1htzgzjbx6?=
 =?us-ascii?Q?O75HdNLGtLM9ANZKkCXJWW+u5ePTQyGIfj3o07LrvoQ6FI9fbyS5ZCpaVzDh?=
 =?us-ascii?Q?zyfzTSXujm/fjSzcDipxpuYxlAXvPBRwFAp6S6i6haSFtV1FgpzY52UndEeF?=
 =?us-ascii?Q?dSAEWstm46Hwj2LM7JdZTs3vrPqNR4miN3M18u8xBvQD4MvYHVW79G5RjTO8?=
 =?us-ascii?Q?nVnAUt80k62hrssej9rwBgvLjNSX80gNVbN2lRc55KxIrjfPMRj0V/hc8rpg?=
 =?us-ascii?Q?X6+ILEJdNl5kQ8TCQk0dhUZOT1HhLHP+GdBd6Xm7BuiZwWfOKIpTpzpB4lCD?=
 =?us-ascii?Q?cKzpqbm6V+Xu+UqMGaoMqx+I6PDi+t/OTqFXSM86olJFEnpkGAW0TReZFhXA?=
 =?us-ascii?Q?AaZxIcYmfNJ7CHTpFzgJLw3F1RpEDXa6dSf4etoPVgV2hc2/XelZ12XvVMR9?=
 =?us-ascii?Q?ca6aG5GCrNn2ony0K5zQtuqvlMNGKMlKiZkA/0St1lb+p+8rE0NrTNtpcFNK?=
 =?us-ascii?Q?NHo0gb2Bz8xLed2oii29dGmCzpbGsXLTi/ToD6NbQinLptCxRryylwKOnY6C?=
 =?us-ascii?Q?hvqh6yJBsI5hMzQw6g5bvlj3RFsAVA/q/KXMJBWZmon3a3G7+v1gmq4EEkeN?=
 =?us-ascii?Q?84tDhiJSB7BcV/9sysd2PDtnVP7vJYwJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p7D0JA+gjiwxn8rHEhGihJjwylDH2UaokdI6VZrreWS42RuYMh9shXwnkDV+?=
 =?us-ascii?Q?vJm93e6FGDE1WfDfBmvg79SN6ZB1NzEnp7xCIZPM7wVAj6H+rZrz9IjXdvYL?=
 =?us-ascii?Q?tNzkJlJIEDGxzJP7AQfvhfPmDVLYqpLrHReLhTDnxw79I7yXXL0llvl7QHRC?=
 =?us-ascii?Q?iiko4yL2ANC2Xx0ceVKqxZopcZSNMWcxRgzdxrHOoveF1Prn8uXVkXkEQ12/?=
 =?us-ascii?Q?i4VO3TegE58B03bD6gMnCUWLg/Ci3cYfKFGB1hbJIxWaw0HGlRDCNSzW6bkL?=
 =?us-ascii?Q?/FadozvOnMc/4Z45EAHAOOiUWM9MG29duZsRqKTm4Pvvx6oVWRn4NJMHru0o?=
 =?us-ascii?Q?1+wd/8jrp4K4BfRtBuySAlSCNyeftuF8qu9UOXqzLqYqNHAPEvDDjfW758TS?=
 =?us-ascii?Q?tp+nMbc3CeKjvM/vlEusgYdNBZ7BNOaE+Jdfrcv+cpFXDxkkHMnh2DOQnETC?=
 =?us-ascii?Q?3M0dFYjefywdaZnpm01Lh4j6WDi6njXJO1WmOauZPcW85+mZ/7W7+xbVE5dA?=
 =?us-ascii?Q?K8AWdO9GdZ75i4oA8WeZikzboIFCEMu7GNOpGGp+EjdD8IZLsGPqc/DAudbO?=
 =?us-ascii?Q?wN1oWYlJ1JZUCzLWnq55gbD7KBn1Zjc9Oqbq518BTjp3lIT1Jtz37fxjS15X?=
 =?us-ascii?Q?LKHhszdqQEqfpZXDwI4SJ5dPS3n75jMKUHXLCrBpXgQhWXvcIeUZ6Zv4655I?=
 =?us-ascii?Q?fbgQNz3CB6JRDHwz1knl+hxtnFUPxjHvtrem9M7/xhAuQHy2p8vGK9fEUPOM?=
 =?us-ascii?Q?ZNRISJ0mKT98EU9XSPK3C0KyjHT76rDoxzl8mmnTJG/J4nEvD5Yri/RNWpnQ?=
 =?us-ascii?Q?b1dMokcIy4h+QRNdsf2ecNEfRiBk0cLJM7KPHLNnJZiuQRYLncNwhXU0LSx2?=
 =?us-ascii?Q?Aa/o1mVmY+MQJMgdpa7zMqNc/zslX4tm7Rh7BbRtA2l1QHm9aLsOgzJjrWk6?=
 =?us-ascii?Q?AZoO/CXzIZSyfIiOakG9Mu0c524kJYDLaXr3pBy/AnWp9JKtAhqA7masRvEv?=
 =?us-ascii?Q?i2mzii/ZwmI3lTg4Jfms9zGfyrO2Fus5Sj4yHh5hwI3h5iJIs3SKB8fLYla0?=
 =?us-ascii?Q?Vr5Li1wID2gP78D+Ty+RhKxkZlPN/JVwh7QXA+67OVLlsVtk6v+sN2w8jFwk?=
 =?us-ascii?Q?9wRGu/OjBzKUCxLgXLIcYzWrRb99juLAzvmvCYXrAPfzDWrWr395N/eCiqCK?=
 =?us-ascii?Q?K1mFF+K+jgecZD96XYI3z8gLtKEt5JaZrxaQBn7CsBisrZVvSsm/qLFvPm5c?=
 =?us-ascii?Q?Cr5F+3lfPiVrLKY3R5dmXV1rkD9mnGnD/tKeixK1iqXK3RthHefiYCM93D+h?=
 =?us-ascii?Q?yQipkgrPvA3PZz/XsfkrjEN2IsF65tZeAgfcZw70zNGPDKYOZxmJZDftCpiJ?=
 =?us-ascii?Q?JSgtnaFI4M/6Ro/g7LHbpzd/fVDOCJPecEHn9E8u1S1Nn75WGhsVGrkAF2RG?=
 =?us-ascii?Q?SqXdbLI/v7yjyIRYrl5BTJomiL/+VBH9LaZepmBVnXbKfIx/3APUqOzSoNSp?=
 =?us-ascii?Q?3PjjSsIZ7nKyTTPwIPm4rCXcsXpM6V28bsHnb8aqmtajkgHrWTHQEFFwQyU4?=
 =?us-ascii?Q?/rqD7VMIpD3LQiPH6T4hCSl5zPgO+zQrdf2bZRNYWUgPwGeSYU45wmqtMMjI?=
 =?us-ascii?Q?wPqsi0pm9+D7IW6z1/2zjAY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8325721d-9a0c-462f-fa94-08dd66cf3313
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:17:06.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdFeKnGBht6tc/D7oQYUmjPptbjKtnuSqnZvHR32vrkfNSZT04z5p4qneQSSko4ZECuuvE3Ik6N4da171U/I5YDSjRNA/ywj/2biFcd7pu4KLQ5PQGKxlbFvpikyJLea
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18268

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 2f50304e9efb69604040feadc13f9590be8cd391 upstream.

Add serial support for RZ/V2H(P) SoC with earlycon.

The SCIF interface in the Renesas RZ/V2H(P) is similar to that available
in the RZ/G2L (R9A07G044) SoC, with the following differences:

- RZ/V2H(P) SoC has three additional interrupts: one for Tx end/Rx ready
  and two for Rx and Tx buffer full, all of which are edge-triggered.
- RZ/V2H(P) supports asynchronous mode, whereas RZ/G2L supports both
  synchronous and asynchronous modes.
- There are differences in the configuration of certain registers such
  as SCSMR, SCFCR, and SCSPTR between the two SoCs.

To handle these differences on RZ/V2H(P) SoC SCIx_RZV2H_SCIF_REGTYPE
is added.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240604170513.522631-6-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

 drivers/tty/serial/sh-sci.c | 61 ++++++++++++++++++++++++++++++++-----
 include/linux/serial_sci.h  |  1 +
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7c93c9a1079b..ff69124e5336 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -319,6 +319,37 @@ static const struct sci_port_params sci_port_params[SC=
Ix_NR_REGTYPES] =3D {
 		.error_clear =3D SCIF_ERROR_CLEAR,
 	},
=20
+	/*
+	 * The "SCIF" that is in RZ/V2H(P) SoC is similar to one found on RZ/G2L =
SoC
+	 * with below differences,
+	 * - Break out of interrupts are different: ERI, BRI, RXI, TXI, TEI, DRI,
+	 *   TEI-DRI, RXI-EDGE and TXI-EDGE.
+	 * - SCSMR register does not have CM bit (BIT(7)) ie it does not support =
synchronous mode.
+	 * - SCFCR register does not have SCFCR_MCE bit.
+	 * - SCSPTR register has only bits SCSPTR_SPB2DT and SCSPTR_SPB2IO.
+	 */
+	[SCIx_RZV2H_SCIF_REGTYPE] =3D {
+		.regs =3D {
+			[SCSMR]		=3D { 0x00, 16 },
+			[SCBRR]		=3D { 0x02,  8 },
+			[SCSCR]		=3D { 0x04, 16 },
+			[SCxTDR]	=3D { 0x06,  8 },
+			[SCxSR]		=3D { 0x08, 16 },
+			[SCxRDR]	=3D { 0x0a,  8 },
+			[SCFCR]		=3D { 0x0c, 16 },
+			[SCFDR]		=3D { 0x0e, 16 },
+			[SCSPTR]	=3D { 0x10, 16 },
+			[SCLSR]		=3D { 0x12, 16 },
+			[SEMR]		=3D { 0x14, 8 },
+		},
+		.fifosize =3D 16,
+		.overrun_reg =3D SCLSR,
+		.overrun_mask =3D SCLSR_ORER,
+		.sampling_rate_mask =3D SCI_SR(32),
+		.error_mask =3D SCIF_DEFAULT_ERROR_MASK,
+		.error_clear =3D SCIF_ERROR_CLEAR,
+	},
+
 	/*
 	 * Common SH-3 SCIF definitions.
 	 */
@@ -758,10 +789,10 @@ static void sci_init_pins(struct uart_port *port, uns=
igned int cflag)
 			/* Enable CTS# pin function */
 			ctrl &=3D ~SCPCR_CTSC;
 		}
-		serial_port_out(port, SCPDR, data);
-		serial_port_out(port, SCPCR, ctrl);
-	} else if (sci_getreg(port, SCSPTR)->size) {
-		u16 status =3D serial_port_in(port, SCSPTR);
+		sci_serial_out(port, SCPDR, data);
+		sci_serial_out(port, SCPCR, ctrl);
+	} else if (sci_getreg(port, SCSPTR)->size && s->cfg->regtype !=3D SCIx_RZ=
V2H_SCIF_REGTYPE) {
+		u16 status =3D sci_serial_in(port, SCSPTR);
=20
 		/* RTS# is always output; and active low, unless autorts */
 		status |=3D SCSPTR_RTSIO;
@@ -2132,8 +2163,9 @@ static void sci_set_mctrl(struct uart_port *port, uns=
igned int mctrl)
=20
 	if (!(mctrl & TIOCM_RTS)) {
 		/* Disable Auto RTS */
-		serial_port_out(port, SCFCR,
-				serial_port_in(port, SCFCR) & ~SCFCR_MCE);
+		if (s->cfg->regtype !=3D SCIx_RZV2H_SCIF_REGTYPE)
+			sci_serial_out(port, SCFCR,
+				       sci_serial_in(port, SCFCR) & ~SCFCR_MCE);
=20
 		/* Clear RTS */
 		sci_set_rts(port, 0);
@@ -2145,8 +2177,9 @@ static void sci_set_mctrl(struct uart_port *port, uns=
igned int mctrl)
 		}
=20
 		/* Enable Auto RTS */
-		serial_port_out(port, SCFCR,
-				serial_port_in(port, SCFCR) | SCFCR_MCE);
+		if (s->cfg->regtype !=3D SCIx_RZV2H_SCIF_REGTYPE)
+			sci_serial_out(port, SCFCR,
+				       sci_serial_in(port, SCFCR) | SCFCR_MCE);
 	} else {
 		/* Set RTS */
 		sci_set_rts(port, 1);
@@ -3226,6 +3259,10 @@ static const struct of_device_id of_sci_match[] =3D =
{
 		.compatible =3D "renesas,scif-r9a07g044",
 		.data =3D SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
 	},
+	{
+		.compatible =3D "renesas,scif-r9a09g057",
+		.data =3D SCI_OF_DATA(PORT_SCIF, SCIx_RZV2H_SCIF_REGTYPE),
+	},
 	/* Family-specific types */
 	{
 		.compatible =3D "renesas,rcar-gen1-scif",
@@ -3558,6 +3595,13 @@ static int __init rzscifa_early_console_setup(struct=
 earlycon_device *device,
 	return early_console_setup(device, PORT_SCIF);
 }
=20
+static int __init rzv2hscif_early_console_setup(struct earlycon_device *de=
vice,
+						const char *opt)
+{
+	port_cfg.regtype =3D SCIx_RZV2H_SCIF_REGTYPE;
+	return early_console_setup(device, PORT_SCIF);
+}
+
 static int __init scifa_early_console_setup(struct earlycon_device *device=
,
 					  const char *opt)
 {
@@ -3578,6 +3622,7 @@ OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_con=
sole_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_se=
tup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_console_=
setup);
+OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a09g057", rzv2hscif_early_consol=
e_setup);
 OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
 OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 1c89611e0e06..0f2f50b8d28e 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -37,6 +37,7 @@ enum {
 	SCIx_SH7705_SCIF_REGTYPE,
 	SCIx_HSCIF_REGTYPE,
 	SCIx_RZ_SCIFA_REGTYPE,
+	SCIx_RZV2H_SCIF_REGTYPE,
=20
 	SCIx_NR_REGTYPES,
 };
--=20
2.43.0



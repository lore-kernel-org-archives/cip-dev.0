Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F964C35FFF
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.10])
 by mx.groups.io with SMTP id smtpd.web10.34498.1741778826218259106
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QCWjI7sR;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0na9ckv4CQUmO9k4/zlgVxZf+wroei88rPgJj7XBG+n5G5qkBm16Xuc6Uf1WJzzoKayri9OxVm1fgF3PCsMQRGK2tG8Q3t6j+3whFTdOPF790WJGCLcRZjW42jmjtpTC6UH3ROti7NySEpiaxgjkA4QcB84pyBqVKa9DFDA9/hW0vj3PenCJGeYZr7oHECR4HL/ktLmkaERk7rFp2e90ZcYURO6/WQnxvbBaz+5fwXkf7w6PcBvV9gvBinkqISqxQiQPL7f4/Xbkmy/ItR3lFTlVQfi4QdVIiTORlokeySs8E87Z/CC01JPcqkfTrQgolNnRxG/FUhpfLCfOKhNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRdoTNUXCACMer/PMrgO57wn65kdxXTAE4gvEySiIxg=;
 b=l+z5TG6MU8lrwsUmIhSpDesauXU+c8+c7jLaL1N5BYF++Ds8g02OZc7boac+25PSkiw2n7zgo8y/vSMOi02bR58QfoeKEIL4DMH73HOLvBnmzPjcId3X4S4bsyrJ/sFaXjJrkKoMFWOlFchhh31+bq0tR+61cLfhuIvSnRo3OrIHuPpBNRlrdg6l3IXSCvUc5xPW7SxuH1jo4CnYQcGtRWsvimCJx3mnjeLPt0eX2dtG+Tis2IjhWXWWN7CS0eVMlz/13qTi28Y8hKHatpkvGZaq+IAFCR4yBVmq2jw3qvI9qTyp7GDfxBY44g6VH5o98qNTc6NH626db3+/z4jDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRdoTNUXCACMer/PMrgO57wn65kdxXTAE4gvEySiIxg=;
 b=QCWjI7sRkzifOaS2R6+rGTczFhnw1ccWftT1DegeUYPfWq8ojtTvCzqdFv39ySI0eXeu2CXsZlV80EGFOaep5HwSmniRs+HXE2l3H1NjiyClhdwKjfWF1vAKGLJjrIfse2466GQtAsaDqNCMJV+wU63m21OYv156rFJ+FGWc5k0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:04 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:04 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 71/85] serial: sh-sci: Add support for RZ/V2H(P) SoC
Date: Wed, 12 Mar 2025 12:22:48 +0100
Message-ID: <20250312112302.1605750-72-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 40df8a6a-ff87-43e0-44cd-08dd6158d081
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BlDIT9HdUOcwydf9koHUZrlkl+VfzV9vbF0eRTv3qtadrycl7b7ndMsY1dSb?=
 =?us-ascii?Q?2/Nm7alIXaUJqSPA3dJz3zxVKOHyFfHHBttxEB/hVrVvhVx7lJxMMdjL5e6z?=
 =?us-ascii?Q?LTIxm9VGeUaOqBHvb6XuVICQD0NwaMRsaqpeA7s1biZx+HXaC66oynbJiNO7?=
 =?us-ascii?Q?oC5PCzfcjIWKTHqy0gfOLCKq+9xGIp+ViVpbvU6M3ZqZtuQ3RYfaJ3a8Cfum?=
 =?us-ascii?Q?yc9pY1enoiowXFzv7pZ6eK3Gg90ByeCPfm+11hf+WPtnP/Xe1ke3yKCqGVnq?=
 =?us-ascii?Q?h9cBTLWZt3ybFXGUqboiAMf8IYxiab4kOP7dqk1mHG8+GfRl8w/nKEBoWQLy?=
 =?us-ascii?Q?ubW+0Xy9aByb+b4a0GbEXV7Wo1zCkToWP6R3y5+QnzaiVS7oi5pLwzkgI/yZ?=
 =?us-ascii?Q?ivcN3bgPiVVtuhDjH0ip3b7XakdYQRvXSwiBPvjLVGy/tzTzeqF8yzue109T?=
 =?us-ascii?Q?r9kiYuzuML0lNz23odVkU1JLS91i8BS3AHOrMN65jW3X9vKtTR22GGWK94ZN?=
 =?us-ascii?Q?zDRMXPW6LW/MtwrDej5lDciNYSELhNolvn1+lG2bnu3grkHKJc22tw2CkRlz?=
 =?us-ascii?Q?BoG3hSglYwNGKOedYazviQ3fUggKRTsXDZhhDfMrrpDsWvqiWpHf83n1Dffy?=
 =?us-ascii?Q?jEPCq7Ke4sgaaYd7zzod6hjCeGyRK1LeJPiO+2o9kClMdPxIHvnkhKYaNaYO?=
 =?us-ascii?Q?vGZV48DfBI8LdYpxfXdYO/Dti0LIWX3Kig/3g3xXoKIuKicGL5tGmuD7vOg4?=
 =?us-ascii?Q?9i6NcBS5HNZFL4hOjYiYlcmfkL7YuR3yRsKDUG4LgGEmH68VIxUxicVzRd8A?=
 =?us-ascii?Q?NZCos/r5rMwvMjmYxiy9XL8raGDQ547RrEsta/SjJROzQz9n85ObU3unv7a7?=
 =?us-ascii?Q?1f/7bC9S8U+jQjwtxBDyT8MI8qLmlRKYHyKfOxe7MQbtfGLazGxFaWCiiUDS?=
 =?us-ascii?Q?2h5bUmHlYiflhVAl5yHtUNP+QC2QHZ3HT3nUszE68vTGRbVd2/RuZTBGj+s5?=
 =?us-ascii?Q?dba+oONMqcSs5eDd1rh98V7WYZN2kLJd9tZDs/tv16bYhQYW+QuIyKwf7+Ba?=
 =?us-ascii?Q?X21tlMGqi53RY2coI6RkFn2wMk496OmjvIlvK8oA0zq5Wqvj0PXvt3EC8/0a?=
 =?us-ascii?Q?r+Kls/PqHzI9Sl5vjf4ge/y4fcIvzdCEyeJQJFvi+SLeREBy+dynYNcE0BUj?=
 =?us-ascii?Q?zbOg8bu3TvR16aMeCXG9wsx1b6q3y8BhTj2Puu4mjKsakcVS8fX4jNmLW17E?=
 =?us-ascii?Q?7X3n4DkEfn1P+sWG3sPGZtHDnTD0uFgtGQmFsZJQe9n5lLW1AV86AQBA3kgm?=
 =?us-ascii?Q?Ai5DBgd7xtUCAsBI8hlCnJSr858RDmsb+Oxaphqi3hFQyUdFRVsx6wgAlBvy?=
 =?us-ascii?Q?lmf1VVgWDokYQiWSDIdg3/wmbE6DNqAEYo/FZn1lXAIsxk8vipdg4YkTsZ0F?=
 =?us-ascii?Q?7ty6T8fMNxlVmjeVkcd5uGvHK1VgbtfS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TLe60LM9E62JrrUnKZ3MS0oIF/P72dVvPmeeL0cYoybbgZMg9RmlpRtDRpzO?=
 =?us-ascii?Q?gKey3qxg1GYR6aflA4UgDryQV1Qb/R2c9b0/WTGFkxasEnje6TWpJ0zalC5f?=
 =?us-ascii?Q?k0lgMJvqhIKGpDxPL3glbzqt7qSE0Mn4A0eufkpa9NZ17d9N7xDa85YNbrKs?=
 =?us-ascii?Q?QWvAwbDQBj9RMsPUx3Zl4QShDrSesurFCvDtBzOOx1hugrxTU/myezeFuEtr?=
 =?us-ascii?Q?bkPiQWtP3e+5bq6ivRbtHMqmTitA7BaE561BS3GFDXjwHJWJ5jtQcpiy43bd?=
 =?us-ascii?Q?qt7Io0Nbag5VQ2Ypxz/0SBtOkrIPUL4x8pOq8h7kXKRP830ohYQug9Q7PeXH?=
 =?us-ascii?Q?elKT83ijdNlfDrK4wz2TcJcE5CZpAE0gE/6OUeBybPDJ8tYkua8ED5eLJ3oc?=
 =?us-ascii?Q?bl1weoQKhlR53jc+aKsfFhRtlyC7PtixcZUPCJL5f+IMz6yelTgFH3wVN4g2?=
 =?us-ascii?Q?nsp2zdc6qfnI1GNHonHRUj5bzo12yt5FrpcstUFrzTh/4a119B+1WQPNQ6eB?=
 =?us-ascii?Q?zEZCWOv31SNWIAjkEME3s0F7qYOnfjPt5SZxigmSLF/0l3yo6v1tq5x3dWfW?=
 =?us-ascii?Q?SMiuvSzW7R3axll9bVteZSh9IR+lksJnQOswbdSpaxkA+Fy2U99R28nBg4Q9?=
 =?us-ascii?Q?YExsmhbZPXuB5EbHiWd4Urf0iybAkY6lrH3TQahlhjNFlhYh9zkfxWVP6A+7?=
 =?us-ascii?Q?bSHf+XlIcFRHe3RuEZ2mPIHUtxPNoxKzqej2gEyz/yA+Y1/OZqq9tc84T2Wb?=
 =?us-ascii?Q?4cUbz1ZMYf1qUlZnSnTFj6q6xOR90qk0m5OFV9cQFHhFbZeuNl28rUXdbLNQ?=
 =?us-ascii?Q?zfd3y8TgAk9YA4zsQ/D5wZyjtiPdC5cy7Tdvu7m8Qb/2Y0HF39fxmsuaVb1C?=
 =?us-ascii?Q?8mq+W9j0o3bZhVcKOIXWF/UVZfFLU3KZJVtUTqExDVKq4GLBeqZOa0SNz/uU?=
 =?us-ascii?Q?pvdsgPq4O2lI5oDT0VbesvfdfQBieUPwFpy5jPPhH/TZqLQjQSVKhgjblxo6?=
 =?us-ascii?Q?CvlnAP21geJVxuk1K7H1CwvRu1H8cWrJZ1DyJyX8DcbgUkpEr+XIAlptsB4Y?=
 =?us-ascii?Q?Acde2HR1cOAM79iNdJ0k0AgTMIsKKy8ut+Vc4JL+GacsMsobXRH//d2l9OpH?=
 =?us-ascii?Q?g2cLHTE+nCNTaI7Qo9d0l64kZn8vFlYem2mDY5QV+XrHSS5hYnn8ilh+fu5p?=
 =?us-ascii?Q?JUqnanj00NvZwNMuIjyaR/etTmfpulYDWxOBO5jltn0SHZsyjORy29TSe0uM?=
 =?us-ascii?Q?fo70fFqzgunnsURuKDD/Yy4WH2qN5JlH7WgqvzRL70Qx+pYsaLwGyPCqcR10?=
 =?us-ascii?Q?ss6G+IqeXsRAEF+sJfk78WRzNYl2kUqW3P5USe8utgmgnxf0vxeOegU6qzQb?=
 =?us-ascii?Q?2+RsX2ivpLxoWgQMM8H/USzpi606dmQLaXm1MqLq184xq6+TjGfGN3n08im1?=
 =?us-ascii?Q?vuucE8QYJOqOwPYwdFF/rMqL4G4FXJmkFJt/xNIIKpI+OtOhmAgeJuV0o4+Q?=
 =?us-ascii?Q?GqwDfhTlxpDeBp8goG93EZvPj3G65l1S7PJW4s+sHbsCqiZYjd3zP7zljGuv?=
 =?us-ascii?Q?ael7oFymcsv+TU324AYPUTttZLSv3N3/1FES5CIJ4G5svjv8ZMOKB8E2pfh9?=
 =?us-ascii?Q?FujV/0+4gNONpCJljR9X34A=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40df8a6a-ff87-43e0-44cd-08dd6158d081
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:04.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCbfV0SVgam7HkpwxBp9fsEW7x9UUdG+2F7Gd+bYMX/bzw8w4j1D4YBX1lYAb2iTYVar8tnuqPgse0/R/zowpdxV5o3u69VfRT9NwPUR1cho7Xq1/hzjq1tg/wif4TOv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18163

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
---
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



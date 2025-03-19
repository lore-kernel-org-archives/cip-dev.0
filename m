Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403CEC36001
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:49:00 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.58])
 by mx.groups.io with SMTP id smtpd.web10.4032.1742377730999214962
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:48:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TzjeIJ1G;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.58, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq44+ztua8iEGpAqUqospy3te8d+Fl4aEQFHlCllvSpYjPZ0YcjXm4jaWBD0YouOdbIholhfcyNs2zKx9PESPBurZ8W54Eod1zngP0xPCzN30+cUKcROLyI8aCfysHuiwjDUtPKI6ah5mNRQKj9SGsR4py6MyfL/e3vQVSwe9P9rMWR1IkterOec0SJVTUdRFZQrizuGcsJo/QB+h/BisanHsQOx6o4jFdKw/W/9atXOZ/OZUl8vwy4g8E/XiMp/+qfX9N+XDeqhAuSRCCi1qw6mPwIv752uAo7Fsaw3Ff8bo/z2VqiG4snhax6y0/UZBR/dPr0aKddKxZr2eLdsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRdoTNUXCACMer/PMrgO57wn65kdxXTAE4gvEySiIxg=;
 b=M+X3LRVfbxBcgphnPJuWmtb2bMuCaQnsuc3UcnGz5zN5wo5Fi+usa70L7+k1lrYy28UKy34rdBR19ApXFVC2SqqlGqvYJDmhDrAbBDCbv3mQunvaWePcPrFx6i/hI8/ZG7TzmViCBUjSSyLjFiMqC3sP4gZyds48yzBU4kpMoJNcAp2r0aNGwUkTZ/4jie4ChrcXS746qfW6u7emGHYoItvVLbiSrGSrqI/1lbY4MWEHFy8xaFEhTYyRiISLwCXwteb2Ra132fBkB0hMgZCDz4JNva6skGZfVISUhVIBwaDZDXdrxivgEOC6Ic53S4/Jpr+B5iHeCwoQeWUMdhQCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRdoTNUXCACMer/PMrgO57wn65kdxXTAE4gvEySiIxg=;
 b=TzjeIJ1GVs/CHi/jqAXxk4/AKpfR2ayjawNwmxbT8HNeSqNzAbSPLuL6JF8KMSvP3vmOwh+iGtrlr1KQ2fdSE0Cj8blEzQSHlPWjjqhA/331n27er2bg9nYTM4DP4aMFWKlo5NO2LJpxXbqEElOQ8KL34UwU+G3RJIMjxO2yNHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:48 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/12] serial: sh-sci: Add support for RZ/V2H(P) SoC
Date: Wed, 19 Mar 2025 10:47:49 +0100
Message-ID: <20250319094754.2404386-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ac1267e-1494-440d-8680-08dd66cb3f78
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Aq0mNtfLw8M8EPApanj1F5tGvOKxLzcT3FrpeltVFJ7SzgJtjYcXtHoDNv26?=
 =?us-ascii?Q?u2twsLZEMZ+GqH/9X+a4XEDVLoCFHoQd19D5RWyO5bIRwG30pIUReLALZugP?=
 =?us-ascii?Q?f7wDcXR6bzsRoFmxuZ5nBgxhkNaHOPrZEMenSkibZzX7TD3puOfE1f6yXyHT?=
 =?us-ascii?Q?TkBxnoRRUnrKlEpHjb0dFFE/NKiXEvwaz6V3uveemLWRFd84FY0Pb9SZnyL5?=
 =?us-ascii?Q?PYUF3CoYBqObL02tV4/Zhg5A1l+SVvXTBJMUpJ5R1HWx6jxAmk5De6Hfypq2?=
 =?us-ascii?Q?T/gEefqaR/yR+GLdZ77+P05gMsQD9+9tkP+blo2F4+9Ka4Bgn0TNDz49oq2u?=
 =?us-ascii?Q?4pfaaANokCA8jP/Lx4dPpzDw4xZ0mM+h7+r06RweqwXE9VshcyOTE3HLc65r?=
 =?us-ascii?Q?Ok+56CuVGvk48tDVZHtUh+fNLBeO0JCOFXW9AWC6779+v+int6sK7VuwnLcI?=
 =?us-ascii?Q?SKkaqe/rqs3qdz5XqTWlEljp8wRc2uVHLYRj0CMBmuW9DkVQaqqKyeK0DNjk?=
 =?us-ascii?Q?yIACycmyDkUuypb7sgfWVn9pJGEPXLV67BrZJhhCXPKwrqmsgFxUXonqbwXH?=
 =?us-ascii?Q?Fd8OXioFg62AN2GEhuziWyUSKCntT02/3duxZmcqnZUEQ1fDiNRU6Q1P9LVs?=
 =?us-ascii?Q?Pm+qjAmh0OXY/RVh3R+/OSLx46GZlZVhNzWCW/XjAC7eVs79DZ3QysKenpBj?=
 =?us-ascii?Q?mreoqVS79dQV4eidCj8zpNxvyerN0sFqdFnyDBFqUOHS/4fvO0q+U9lFTT+X?=
 =?us-ascii?Q?/RIdeEg2rD2DMFpjq0Hb/9IZXkXR5YL2ixy8lVIkhnIQU9Ltfky8yR9jfPeB?=
 =?us-ascii?Q?mn+4FPhronUUMQtrpjmeOrpHJwsdV97pzTefeLlg84PpOYRA8Mm2ybpq+WCk?=
 =?us-ascii?Q?JM7vqFG2+wunaIVN+q1GFm10dawRisO7NNotbnpMA6Ym48Jox8Iaew8N68xF?=
 =?us-ascii?Q?AfkbgPGOiZn6djhr9zxvTkKCqB5ykpASacV84omgdMyenHSqTK3OTts31kMj?=
 =?us-ascii?Q?o1J1je8MTU602gkI4C97f0RroUtnG0uvTIZbWXPpcHBIzdSD/svznkz/r+ZY?=
 =?us-ascii?Q?DOQvdjBDIOJFvOLCCFxvCVfsmwjjauhuIg9m9/6aVi7Vor4doKURQ1BbcpmM?=
 =?us-ascii?Q?YXO0exen+remdPSulaHBCQB8eujxxZ9Nb+1cQCKawNZPSxfajoT0eYHO6fKw?=
 =?us-ascii?Q?yijSjryy1V3DvsBSOwE+ZPMaGt+yY+MihHjgv+ngLljaXoN4niXIGr5vC+d8?=
 =?us-ascii?Q?M3P7zUxlEwa/XUEIC2kxjBmUjGkx4+GCFxzFwH6xdZSqU30tI2w5WhCc87Sf?=
 =?us-ascii?Q?yGdE4TYOPM1yGrk4i6e9PbZAeqhodHJPhEU3M57ZjxxM3l0wA+QH6dvtLbIa?=
 =?us-ascii?Q?gYFa1UPPTUjChvQg5ZfdjgOTRn1FD0k1+9/Azp5HXlJBTEZrD8qVoGrH/V3+?=
 =?us-ascii?Q?5uPSbvhbXcAhb6jmkfQ/U9Fy6LxnJN2Y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xZH5ac2WCiyl6UpgO8NZBNrmbYrtpnF8oI+PrzhJajxDJC9XzrHZ6YcjB+dk?=
 =?us-ascii?Q?H29y0+v4BdLGQvHmZYF1nZH4k6Q2qLuipP5p7hxfrs9Rp+/2NdNt3MJpgoL6?=
 =?us-ascii?Q?F6bQRZ2/74qqVq2qL73WwORm7FdJ6SGbXwhKo861olgNkv8nL2a3H3okTnLW?=
 =?us-ascii?Q?14UHDS/13efzBF91SeJ/c4De4O+i0KWgBqqFrOlzsDU9bdDbItlPoypHK7KV?=
 =?us-ascii?Q?vDo8d4tigjvvRDyLore3kM210g5dfHJSktUHPMg/3/pmd0uweBcP0gKRds/d?=
 =?us-ascii?Q?kmIiXjZiXa0+Ixvmtg+KJWV+Nbm/OuVJeQPW1QoLA0O6CuwRCpJYY9S+dN8B?=
 =?us-ascii?Q?F8tiIy+AbUPXoh7d6O7eJq5IgyJPF8OLXPAI6JAPLDybZ2VDRWuoi7bsh+w+?=
 =?us-ascii?Q?xUFvAjzhRhVLY3dJi7xQDuGlqC8daW3Wi/JNB7KJRhaKKaqYMr4+xEwGDAYY?=
 =?us-ascii?Q?bogVPmFvGAcApS8WEiGijubR3FoeWOFFQZrqCmsP0QM6RWb7yC7swMV6z8YW?=
 =?us-ascii?Q?HFUxbA85q0laClifGL9Cax8TLhvygkMrpfKIUub3+YBEOmD5+yJCwMcIuaxx?=
 =?us-ascii?Q?oA5tS+7rifdsiWg6s7VUgOujrxeLEQxMkKukjlaehpbInIZwsHPQ26GRB/C1?=
 =?us-ascii?Q?UbXGZML8vYhSEJejiEDSRbMPc6M3d0KQDFW7liOoBSUSFi+VcTetwTQ7C1Ul?=
 =?us-ascii?Q?huIYWBJgLws2pK1OnrZ+tfHnupJ7E+l1EdU+XrBTITHOBwuY/varYdBVV7ub?=
 =?us-ascii?Q?kXudFe+O/ZX3TP6y1YMHj2Zs5FW0AleSNxXP8leaS4v4pRXk0XIMRiAOhWWw?=
 =?us-ascii?Q?31F4zxCYQFhJVnQBHfphkr6yyBVsX+8Gu8kxmTFm4pI0ruchFevnfNvQuy20?=
 =?us-ascii?Q?FZQ7wmBaP6AUDjzxoAz/6VTGkGvwGcdXWXOuqbaT43C5ppeG/tevm/zMut0z?=
 =?us-ascii?Q?G+394EDP2oAXkbSwoOUrFh2jDkyKntG6uX5fB/YkSCdIaPh3NvyKysu/+7tZ?=
 =?us-ascii?Q?jmCIZWKpOCRwJhRlmnwBu1lyALtWHN7wd7Qf0bC6IraREjjvWMAfZ8uihmWY?=
 =?us-ascii?Q?rleiL5mnv0pzjYKXDsKQBIUpGQg9rV+3G6l5Ww7AlnpB0JNj933xhaAQN+uK?=
 =?us-ascii?Q?orkSZSzjbj6x4SDwgXGXsQHr3F3Qlj7uiJlQ4+DOr+z4EaPbLCs4ZfhJKdXu?=
 =?us-ascii?Q?8mMlmykLGGW7Te/eZ7Aq4jSd1maikPSjebbX0YxlP3wzql77FRqDEKwaX4+s?=
 =?us-ascii?Q?X3wbEr48LSOjRt3MT96uyVu9qV34UlR3uUWyHLkU/KkdHamWCcawudZ2JClZ?=
 =?us-ascii?Q?cx8EWBozcSKXH7HAUG5gRcAJM41VtEoAeRtzSuPuVdaacOLrpWtDao5VGwSf?=
 =?us-ascii?Q?Yfhqt6ZukNJNhqnAlYQDB9PqIVgQ7jLRhgKl+gNU2sl87J3/N/3w0Iy27nGb?=
 =?us-ascii?Q?KrogIUo56AEOdolmH/e5XvQrEAMUVUBSTzbePaTKYhrBiSrt7pobgXTVFx3L?=
 =?us-ascii?Q?9iIePTA885Gqt7HGIagJ7xj0JZu+86PjXhbVAdEYY40cDbwJeTs3oNJsB+ZN?=
 =?us-ascii?Q?W/+tJ6fXuvo8PW8KwoFXHIsh97Ctz0n9RN2Bra5xO5xwODH8zvM0sAHaZI57?=
 =?us-ascii?Q?dMLK7AixyYu3NfZ8+sqy6vQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac1267e-1494-440d-8680-08dd66cb3f78
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:48.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goZdzi7VMY+zBUiavM3bofO4mLqdBedxl2gpQok8gGM+3rzjeG7tGORAQkJoGUv0i3OMj+b5JIuUEXuJRGK0ks89tTcOw2NTl4Mwb3UcHql/QfjkYTwfkduOcTCSczdx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:49:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18254

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



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A238C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:49:00 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.52])
 by mx.groups.io with SMTP id smtpd.web11.4018.1742377735650642023
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:48:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=n5N1bpji;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKxeD10sgs8QcanHcZNiw8RKc+mCQ62gIm7QT1UJzYWoFr1g+V0ui+axet2Mu2GeIovX6RayaiYmU5FC6tFCv3ZrWKZthffVmecwtJb4LS+zOZpgYxCD7IHO74POdKHV/XRh+ZKa6tIef+wgnIhFxG6lbY5Gc0/7bDh6ejJQLuJNafnoaDpFfhAMjJguSwEMUVrDPz1kpDUZtT8cr6xnRjHGpGfm25myXQTwQpv8x9DwnXWVSgG+YY0KCtndQhsyxwbKvzrbllUWSZ9JBD+mOxTdsh0Hi8F94Rgw1XUAS6Qb3Yr/xz7JLFGWkGZTpKW7Sj9u95p6324089AjQ08tKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yapM+bRRE9x25rmlaH66h/bno/k5aW+kSWO3g3B1zJY=;
 b=oprzuVnR/3rxpNTGG5sjr3OiI3DZIyCeDTfT3+I5j6ocQXc8n7ZvK7C4NaVM242+EyaV6N5iMp5HJ5KAClWlo6jMgVCrKJhRPn68vRe9P17h1VGA434a6XaroXq9olM99j39FDlsqRGrMHTHYjwX32xAkqjTjJJS2Wqejay+5Y5swJEFfEgOzGaWkyDrjX1QaFD+ZXtpEvJeW4VQSPbf6wCXPiioSPCv9V279f9NJ9AgVgxcChiupYqaa5rezuPC3Gk/QmH1cppdFnhWB+nSuzmhrZkcDVY2S957NqvKINyjsEStXWg0faPOTX6E9taJi7hJ13SJcWLY4ZfcDCnTEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yapM+bRRE9x25rmlaH66h/bno/k5aW+kSWO3g3B1zJY=;
 b=n5N1bpjinWbZRjc+d7nBHrLTByx051/ctEHH+tXShPQC75HrmCNl3Wd+qbFk6FPvg55q+zVBBDou8zHcRJ2h0FzmqyH8bNswI2luyechXIycZwkCR28a3dro5OlrJhxB8mmFWyzwoUb876uIkCSA+xNzhl4dn4CCi4uD7HdxtB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:54 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/12] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed, 19 Mar 2025 10:47:51 +0100
Message-ID: <20250319094754.2404386-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b3c9255-1a2c-4b95-1feb-08dd66cb42e5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QTBuNdf4+KYPkSc5qam/j5tG9H5fOjy1myIKbsMH8ZznM75xB3PL9njSmb3o?=
 =?us-ascii?Q?vA22ytk47r9VBzv28lHnhBz1fGGwjsBpmzaKsBlasKnZ2R55ObHx4ExbbwUD?=
 =?us-ascii?Q?e+0p5EAgA89YNZhSNOMsUHtev976oJvAFc3cxZnEMR4Hbf6WunGQUQA5sLQF?=
 =?us-ascii?Q?yHdJ7YcQz2kbzfyOQ4nKzi0d80M9p8cmnbx3YhGcrAbQnUw4HETaRebhXmc/?=
 =?us-ascii?Q?tO+VISqh8dJvmnk/JmiTRSyWjEquxy5VtDgFEGdmkZOAP47Va6i5tiGwW2CB?=
 =?us-ascii?Q?IUHmvsJnnrybibevMq2R0Jhi9/C82ho3iOeFiVKrnRyeMEzOyXYU9OXIgDCi?=
 =?us-ascii?Q?JTk0sWEdfE/dVI8qZxivT5xd38plhFnCeQowG0OsvjXsUh8v5Nx2C8cOzlaj?=
 =?us-ascii?Q?G8EDuP7YYJ7o0kKfEjlcN/N/WYOLz3O0Si5tUU/omGNxuPi79yoHagLcXWhw?=
 =?us-ascii?Q?/TbcdnCP57sGycT6TdJMiuA+opVNCKlXSwHpUU7YrGtrR43DZhOpp2r4zUnt?=
 =?us-ascii?Q?+vgyrejs+VlwKwtIe16qLLExolzuA9UXkWIi4RameJy6kboooU7kSEO4LVfX?=
 =?us-ascii?Q?Bj/CkXQNsxJ4TZI1wC2laKMPopBOsX1+0Ki21PMXKehue7rRoETZ4br653Zo?=
 =?us-ascii?Q?HKkQBq6spcCDyHGlXuKCXVOBy9dP/sGTvr4BSWDJRfJKTVmPBV+7UZbUZDbc?=
 =?us-ascii?Q?999+eacGNiHzeW5SsUtTJjeEpFwa9+eKgpHc+snSq4MoHlwPc8BbOeEGUTi7?=
 =?us-ascii?Q?GErU//kmWkheAczDsmEONTsZ4LNqI3bRjUR3oj5cb0ewJz57Fs3jaomd+wMZ?=
 =?us-ascii?Q?E4bwPNPanGnlWKUhh/pcsjxhDfG/ethhjaALyOrDPVyWx1o0aLIV/OP3WvMM?=
 =?us-ascii?Q?GD8X4PLkIIl7Qa0GFOUo8gXOCrCoH2SvKcKeFvxwMLn9Nvg59AfU8MfqgZzT?=
 =?us-ascii?Q?/tHQJ0NVC/1a4oAECc44dZSr9q9Ld3myEd9jbaOWOtEz/kYFmn0rY95He9vy?=
 =?us-ascii?Q?ozGTADRhkEvjc8OZNzP6+0YSWRZbixp2MSVRVL8CpTtTvD5kXWO2EzwRPm/A?=
 =?us-ascii?Q?YdT5U6t13wiZIFJjRI/6yoxd3/z+y2cBOiIzkcTbIPAxkyBPx8BAjNBYcpnH?=
 =?us-ascii?Q?gnkuuC77U0BkyHhLzE/C+6jPkcPDS8FaYvQ0bqFeLnzCQNyVMpcodDopODE/?=
 =?us-ascii?Q?p3NAmi83ATitfEfa5Y/kYA9NZ+XnoX8gguoj82QlNKKCYXFMUDF2abdMQlt2?=
 =?us-ascii?Q?qS2hCr2Xk0/i/K7CzPn8L58TBuw0FsnmVN/Z4nDLzTg9ahXy6XfP4tvAusMY?=
 =?us-ascii?Q?+9/MwyyEnwCzVGk3MEk9xd/DYOo0BpkO2cPg7CbqX5Q3Rm4IEuwTXf82M6Ju?=
 =?us-ascii?Q?iTKjhZYc9pnb3APvbskfbvzXsJFHU5MKGUKoB72Zvo6HAqcfL0tvCFIB9ZAG?=
 =?us-ascii?Q?SoU93lqgszAPZdhDjtheN2G65HP7+LVM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i0faSTPRDxWeb5Yah8SdYX0Wxa6RAvj9pcdIhqEmIIDX1ux2AKzlSM+km6jg?=
 =?us-ascii?Q?sisW6NzJppM5t1WkeJ3Llp/wAOGT2N4+dDwC1YghjCFEH+mLG4oz7VBWDF/P?=
 =?us-ascii?Q?JqC+aysIhbJ81bp435bjmL4d10sJfeo0oiWk1OMF0huep0XiVR2oV5rrNMZn?=
 =?us-ascii?Q?lO8byRv86QjGa8+Raxe6ELIRKBfMwhaADfgZb3QvXVqtwChXL68gj/RLvVCS?=
 =?us-ascii?Q?RatzInPCTXjFAYLRBHpyer2I6m9f06iJ/0ZRrkEFSfteN4SW/ZmTJV2R3mPZ?=
 =?us-ascii?Q?xmAprhQQPuo5vbfnNNdv3WdHj1qLHL5jLz4R5/JOGc0Ep9XQdbc7NNAVKci7?=
 =?us-ascii?Q?KCEL1N+RwIPbWd0ntbPOEyqjjcaYJGl5ay16Yl5wzCSePH7spgGRNLOm5kUB?=
 =?us-ascii?Q?lxyT2nvm9axkaS8q5NfRHs/0nql1KlZ5HzuR5S2N+ZKvkSfkBKk7UGD8bzTz?=
 =?us-ascii?Q?z5+aEuHfNWjSgZMKzARbJ2tdQGtBKMynCu6Lzqux2Cq+62AXuKyCyS0W8IVA?=
 =?us-ascii?Q?ObPg+JzI+X/9jvktmT3ToxGPdYGodZYKfuoO97NfF11IemUEe6AOtEvDmuQB?=
 =?us-ascii?Q?D4PB+hoGPnwPY39DvELWjPtm/FAYGZYdBEPB5jfeD3QG7rGr5IpsJqc8B8Dg?=
 =?us-ascii?Q?yLtGia/2VZzkDMomb9/VPJA8gYInk4CdJNdpy6Eidlak/TLWwGyJaABlM4Tq?=
 =?us-ascii?Q?Fa/6j1yDWVTcUEoKycrqANTbRBXzBt6bz4lOjLx/dC96YTKP0VrodhB18eEG?=
 =?us-ascii?Q?7rYF36eV6bENm2LPiz3cKokZV0Y+N3j0LplhOwj7aiA0n/OvRAxfZFl63frA?=
 =?us-ascii?Q?ZfzunLXJHuwo3fUY1QPSVI8KWz/olH6NDVRadA//9ghAL3blJpRcVzMxw3AB?=
 =?us-ascii?Q?1GdCAMDvK/ynrahoJFijbqmvWwaVaeAJIXRTV1iZ58oprVCVibD9c3skjS6y?=
 =?us-ascii?Q?drtv+5eZJ432wSrELO5icEiqpWoZM18VyNbjIxrlWiUzQOrG3J27GS/myASx?=
 =?us-ascii?Q?2Rhr8kNAR+zBvYIBGMgJqRbnBvRp+TUiR52u2wHCSf0UJvNAJqcpWY3mrPOo?=
 =?us-ascii?Q?sgV6XyZX+o2i1aXhuQ2z0TrBpIT9u+e+CBeWmDW/50Q7IyGDZBR8BtINvh0+?=
 =?us-ascii?Q?V7RnSGmPet8LTwK6OIqCwR9/+U8jH8RHFfRbAUHtOUztrgOnHIqrNg9I1dJZ?=
 =?us-ascii?Q?C1yLRnrj4sl2w5Bl7zRedIjD/RN14U77yYUmsl90yIqIjmLSS332yjeJyFMc?=
 =?us-ascii?Q?6kngSOlgjdjHkPAhVBU1G/uHS08W3VHXHYbORtBVC4oFKF/4eEAQVpYQM4DL?=
 =?us-ascii?Q?IuQIkI50eR7y02Q+0glm2i57HQSC807khVcqLAk2mKSev4Ge6LtwTZkvIkgt?=
 =?us-ascii?Q?qSuZOTGhW8ANbtZNZgPD02w998c9qupdq7ZzgPv4o1mijACYeOojq1Zpx/CM?=
 =?us-ascii?Q?ddmtJYh3ET40aZAFhrbKMDctMvG/DAa8xog7+3HOZU2y6B+TSa5WhO6Gl2WJ?=
 =?us-ascii?Q?0jlGN4DXpcUVoJDcS+c+3/95k6FS3VA4sHbi565huq9QzFlzqpn5XTJx+xW4?=
 =?us-ascii?Q?HRrr3qhAZjde7OV8zmvEAkVEb5p5G4Gv+otcElvOP1b2EDy4dMVucpnOa3Z6?=
 =?us-ascii?Q?Ow918qoXb5HDpJbwFIOCP7Y=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3c9255-1a2c-4b95-1feb-08dd66cb42e5
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:54.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PTtU/OUKOKiVP5Arm/BQtgbFhT1r6GfKDhrlRb6CHZD5+S/jO0FlWd0/vg9oCYm3fJjVCy2Ng41LUDk6H7YrHMm8hKyBHLNWMGcCIpmc3jjl9jB78FCSey7L4Qrvz6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:49:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18256

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
---
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



Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4180CC35FF4
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.38])
 by mx.groups.io with SMTP id smtpd.web10.34499.1741778831695813421
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vvO3Znop;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g77vx41UD/q4ETWUq72XYcRNQxjSoYmIpBEvg+7FGUc+Ot710Kb8hxneM+NZ2OBg1mvUANYDA/uA0WrIvjZo5O/Ji8y8vyWpTMIvh/iyatxfo5u4HluO3RW3IFHE+jk4ZtIj6x5DM2XnDw/PMJL73x7jHpQq77Zv0aZ7pDg8iy4+5CpWHbESVIXXnbIi+bCODnVzEVQ6F2IYYcJvf3reMVM/aFxU13Bw78BUPAwAgIao98vraYTNnBLZxT2fa8QtIYKFIjWwk/kmogl+gQjWc7Ov3drCmls/XCbb+dgCk7P2PrnRsA0fgj0YiZHmmf7MuxB58ocaEiD1pjVoY+oywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yapM+bRRE9x25rmlaH66h/bno/k5aW+kSWO3g3B1zJY=;
 b=cbb7BoHfJ/EC2QWn2m6/OW9WQoRcELuDn0fA1xmdVzx8OJw7DGicfpQEpeWInFTY9zAPQqjlGbiWK6dzlPhWxyVuOV72V+PjpmukrWa2FuCekc/VzHlaCiiOQ6aqNBTVabKXfxtEvt1V8nkBYjK+yQ/nEnucu39KtVOgM3y0/x/OHU8zzj6TTieM4OALlvm0U5jHO38m6AfsN82mbnhnpIwtpVESulpqGkMia2tH8177G8UXHoBOT2kTNVpNoOqrxV+AyM3OIGQ06TosdGGxtrbAPKbDS98oJHkZL/k6cfvXUkUu5r6N8WSPSLp8YWrlnEzq38u30GeF+SmEWaIn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yapM+bRRE9x25rmlaH66h/bno/k5aW+kSWO3g3B1zJY=;
 b=vvO3ZnoptmIh2EyYv2dlah/j+ZkKwN3LP0aNxFHcyE0kkuoRgHBxFmVNhDlL7wNyd5+hmJiC8Vibg3c9A+N7b4+kgqkj3vq0Aa+mWsRXhGVrkFdn7fm9QvfSumG71rz2l4XVDLr033MpRZseuhqLpM3VvLz7l+m+wP5IVOVkb8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:10 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:10 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 73/85] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed, 12 Mar 2025 12:22:50 +0100
Message-ID: <20250312112302.1605750-74-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: e57311f2-13d3-4aa3-b0f0-08dd6158d3de
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oE9AJfihFo+7FB3z+y6UcBZMtBk+tHfSoF0CPqKmf5PTKT5zUYOrgvJ3zBxY?=
 =?us-ascii?Q?24YW3RFApePxFjb/KD9q9VFEsKefDKG3Fz+5K7ABGgw70STydI/Hyo7gN41T?=
 =?us-ascii?Q?oZRFy+bBeTx2sZRO+pk0QrNe4cRIofCQA9ZlzHzKPQvZYkIVTXH99grucfHg?=
 =?us-ascii?Q?X4VNgkOWvLdoAEIY1tVEnSCRcbZv4PrHOlBTG2R3zKlT+uwKsTF3ohxyARg7?=
 =?us-ascii?Q?hDkQa9o5YmspyiYavPEO28Q+Ky/B6/9XbODnMJugYjmWQ7DXLyNMiQ57R0G2?=
 =?us-ascii?Q?/sZID1ko6tCh3HxnoN+rxFU8qjTAyfoT4Imb9pFlK+gG/KF6yE7t+nF6UWnv?=
 =?us-ascii?Q?lA17DnSzWjj+A/HI1lv8g/04qp4kSGf/bdI5LLeOxet/vCJq+rseDxf6SDMn?=
 =?us-ascii?Q?MbnI601wONnoto+21+k6EQeSYIezcpN37iaRIkzi9R7YIUbRg37D1tkbfLNB?=
 =?us-ascii?Q?tljMdXzQUgigLVs4PPlVwMur76wEba2zARE3/52JefbroUroVWBtVJ0Eu2Cq?=
 =?us-ascii?Q?FNcR9/rD3+X2Iw+EdZ8MJ4/fUPZuIc+bZ3YexWX2bJQPkk0kibF3U5HU8VBY?=
 =?us-ascii?Q?cjbLtF5f6VoJucs8nVvVldhUCSf/Nd6YKv7AL2ATU1saXbIw9pwZByfp3l8t?=
 =?us-ascii?Q?mYaC2t1wOQY9Ef34Xea4slg3PWsDabEep0BAH9rzpKmzYl/qSfrbxZtD33Hz?=
 =?us-ascii?Q?Qpe+nNLVOq6BEsgexkoL3DdpYFPo8CPGX74/PmACD29nLZnwv3ThE8WY6kTM?=
 =?us-ascii?Q?KM7MEBPR3HX+dMZ1R+c9QAQS4gKXfD5CD5afMLEGsyYtzMWVCffOyBiqMBIT?=
 =?us-ascii?Q?gti/dRgAzQ1z87ZNN14hPMXcyQB8LvSr/ViRx+HEr/iADDO9xQhogKBErVP4?=
 =?us-ascii?Q?LCenejk6vf4JSMT8ErWxb84pS0wI39FmVfSm6IPw4kwKXWSqTblWdTLnMhjs?=
 =?us-ascii?Q?5U4jTIu0LwrBGwYPJkLiO1GeYV+ADrGg609ioXs+VjDw/UDyaPUr5Q2WRGLe?=
 =?us-ascii?Q?AjYn79oMkFdmk/MRdKU2d5bCQoPpu0qFZWyqoygq8FJbjUJP5ApMO/oLUurN?=
 =?us-ascii?Q?qGUHQyYf2Jqv+u3eb42HtCqNRXn1JZ8MAoFQEfsQQ2bVTu+rBBlnwhcB8gl7?=
 =?us-ascii?Q?ED4ZwJAMt5/xD8rlRPk7IkaKeqI25KVRcj+zY6OXKcZ2JNrxhcPRs2+gnOVD?=
 =?us-ascii?Q?t1Y4j+dB8XiheF72cc+j3AXle0lNbdryre8GaZpFz44VTGZssMX24Z+U0K8h?=
 =?us-ascii?Q?nBa87lbVTKktn2U3+TeubhSkRdY3wFPeEPqdERA+YgXWzNl19YzcegX03/3f?=
 =?us-ascii?Q?FxfbOgEuB4QfnDgCgY+/0AIpVFjIKb/zIBNDXdoFzzEL2Uy5s5pxJ5btmaKA?=
 =?us-ascii?Q?agP7gI6k1P6c9gycHsZ2lHmglOp4tqycdu2xU65+L+kg7Z9tVusGo3dvuAzX?=
 =?us-ascii?Q?OjJP3/NlIrxMgzQz29tRLxaDa/cLt0Ar?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a024tJpL8c3BnQqq2QYWxNFB6aSPmHqChy7Ygef/KxsBTwRBlkTO80xcOP+E?=
 =?us-ascii?Q?zH0FyUvPBoqRExg8yjHXLcojkunYnlZmHL4qgFrnd4yTtfscpqsmborhQsCm?=
 =?us-ascii?Q?4jrF9jqVKyni7o0ctcZO3tnVp23mFPt3UYNP1igfMSZbVQpUSrNc5VLyQget?=
 =?us-ascii?Q?4aa8CaCu6JStxQI+WCFkAkd3AmoCZ6yceHnFbkKx72Z6faBzSRYcyUM1lkvc?=
 =?us-ascii?Q?Qc64JOsxdQahdMRJC9T2ObOscR2jtHX27gmd/gabTCWYt+25qo/50B0nnkgU?=
 =?us-ascii?Q?/y7AJYW0CT8ZBw1B9zlLAJz/v6alGbKMo/IbgErS75xtjz/AR0fgYpmWonam?=
 =?us-ascii?Q?hg7Qq29Px/lATFcvzKcOW+h2IMeN8iBCnpT1rvdueE8pgzpRutksWqT9OOPe?=
 =?us-ascii?Q?iDNk8yhBJq770I6bqk7gUMD8K6lWrNr9x0E5ojNnWlhkLq36cg5CS33dNbIR?=
 =?us-ascii?Q?2ZIWr5/fdC9cHiOBoj1Wk37iyDIOTibYC+5zug1x7bybIUsWS/+pJWOg+0xs?=
 =?us-ascii?Q?eWeLenCTUeMJ2riptkEKkdpnB55wqWzSw+gBwJk4RSDS6NMZyXsaB3IG2LLX?=
 =?us-ascii?Q?e5yNEZXryR+Cwwi48t0Q1y5PVJ9hXj9Wjz2/eWFaG6sFUxwjJ3Htp876EVhj?=
 =?us-ascii?Q?kxZTT68TX5rXnxJ5Mw4+7ljkHjrdQGsBhSgf8oGW82Lv40GkwMVsxazJ2F04?=
 =?us-ascii?Q?9H307vmCYgF1iPpRIaOe++IQ87FNzCRvE0slrdFaI0KoEZTpcOi5aWIqTPsx?=
 =?us-ascii?Q?EzXUYl/DrNuNCQ/2PFtuO5amMCQKuf4Vyja8x0J15pwdtbHuBcUuWvr8zi+G?=
 =?us-ascii?Q?DKDMS+sJcbJilRyUi7js8RqBnGZ6rSXJfWQQx7O2D258S/QQCJsZkeapzOZb?=
 =?us-ascii?Q?QHxVXLNSoI0Z3li6Ep7tq/8CQ+K5Qq1XiYyATUvNYEmpz04VUFpR0NHRNwjY?=
 =?us-ascii?Q?PKxAzOOf1xC303Jjbyjbq2PGkhdzuUjoJ9asWV/wyUIxuYdBJ3+c0TBWxH5E?=
 =?us-ascii?Q?PXPtzkUMjla4iMVRhl9cD+vkobvfd8WajCsHWzDZlM+wgvzOs42M/A9ukseM?=
 =?us-ascii?Q?8K46YYqtoM8oCMDN/ZS/8jsO6CkWJJMx6LhUuSsgHSh3pPXb1++460bcr80S?=
 =?us-ascii?Q?ofGKNXux/2sDCgkYgPJtPyL9jF4AKut1/ptd+NOPY7vARliEm0hd8z99CWq2?=
 =?us-ascii?Q?da5U5UvB6VZ1klqx7a3N+o2SASsG6BWiEwTKEj33wi4l4N3Fa4QOsUx71QQN?=
 =?us-ascii?Q?SZEv9+wTKslvJdOlHblvxMAAVfNk8bV4cME5PrMA+eTmN1n312yPEB+ngI95?=
 =?us-ascii?Q?xNjoWFqyg2GOtEpi02LFGuyNrEEN42CaIsd1X7gdtK4kDI0GAHCx3FI8T499?=
 =?us-ascii?Q?Xuh36Yym8/CuqnK6owJeaifizL9YYkJlEG7Vc462h5X5GCqvjrHIdCIRLCfg?=
 =?us-ascii?Q?cj0plB2mgk0gDo427xTVS53X6NZBvqa70xotDdRurZ5nBFamwdWxKI16SHMQ?=
 =?us-ascii?Q?2oLHJAWPa9ETw4uz6clbaRwBXeSk/8w2dWcTpNQJXVJKV3OdqaMhyeLZ8G9Y?=
 =?us-ascii?Q?9eLEl/c6Xm2rjOiIflDuUWv8WIhiVdcFKSK3M4by6/TtOEXgUDHJ8BURhEqi?=
 =?us-ascii?Q?9K/iD7ddayQnmjO808MqwSA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57311f2-13d3-4aa3-b0f0-08dd6158d3de
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:09.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jHl012rHficeQgFGQ/T5QvVUnfy+MoPQGm6ciuBP1dVcr+MMxPf1RjnnuY1anEIvqR1efzBV/zt6sU6Iqhb8+vK2aF1g5J1Ci9SPFmVFwi44KuJWSX4gN1W3W8t+3sv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18165

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



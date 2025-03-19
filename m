Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402B8C35FFF
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:49:10 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.29])
 by mx.groups.io with SMTP id smtpd.web10.4040.1742377743612091443
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:49:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=uEz0PW19;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsFgBAZ8kyN7ehNKRV+ro7udPgQjqEvzDQZOM7LG0VkkiVFsAqPjocU4sLhf0VaUe/dnRfBzfjp1p6r0dN0WGJ156Bl8zN45b7CTHq+hIMWyw8Cs1TmfGCiUemrbJMCIaxtEnkb37qQ/BpMP6i5U7ZE48wd6asKqk5CsWklS0FbpQeHYlDXhdTxr9bP2vbBTjGYTcl9NECjMFze00auj1Tbd4oIdVrY6OOYGaHAbB5gDg6nuuOnSoiTg7CkmEQE1eOko+zuQ9PCJoSTiAWGbEYyT3UnfylXr540ffsElJkJ2l1l4c9nzc2WmKYbWPLEgfEwxVNgBreSt3u1cGH48Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWGjgrPUCJLQ57u+SpvjJ9ZrjNhB0nEDdZXXU3ECPbU=;
 b=C9/CB4/OziFivBPAs1i9LlrUiMKElvBYrF/nT/9ixcYl7GEZp18xcFUk19ICo0D4AySled9MKnAyEeFum0fSS30DngYikao98YgnmUozHmIrw83Zs9ItNkIm1kN8i2B3ZnnJbCCUZoAbE+gkidq4unCBnHc7GLuJmviIaSSesDdlvvlxnC00/jNditFzalnuH2hwJONc7Exju1Z5jiBaYXmzHxbvs0ciii/EQa9yTyswun8Ntv/RxZcgwTr96H67e1zrpC3q/qozT1+oSp5NPz1wsmBy/Sbme4Y5M/6PDBP445I1wGhtOZHqE+lxwU4F3R6lTcxgmB9VyvvVLsGc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWGjgrPUCJLQ57u+SpvjJ9ZrjNhB0nEDdZXXU3ECPbU=;
 b=uEz0PW19pc//XaiOeAVrDptMdB2h3dbjh6YrRb3UlfmX287fDgq/CvD/bxxmodENOybNWMZ0xzXuoOPbXFuFZDiRkB85E3FRc/fEecQPxfuZV38c7yxswmnHcqpiA5PrLK6h9B7dJOcmyM+7laub5hTczL3mCKsHo20o858nzX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:49:00 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:49:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/12] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 19 Mar 2025 10:47:53 +0100
Message-ID: <20250319094754.2404386-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2490ba63-f0fa-4b67-85d6-08dd66cb466e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?psVvmdxsUqY4CTsEy6JNY3kVTm5+clSaWYzKIaame2+av+OdUfx+es37rAcw?=
 =?us-ascii?Q?C8HIvXEOfFaI+ts8sxNFGEwL6mldPJSiZLh0vfiqJf9MWS2oY5buDC+Yj22q?=
 =?us-ascii?Q?hOzaO6DbOD6ozIHwT4LvVRCjn/+zOi4WP1+wwPSClxoQawAQXvrVAq4A4Xtv?=
 =?us-ascii?Q?NLsESoHN6wjspsOY0a8ze3xZCnnIzZQo/RdSIUanW80FI55d8zIKDeSpUHeL?=
 =?us-ascii?Q?mJWu3aXlePpqrMCvGZb8xLXY+7W4K6Gtevzo+xMnxGTiA6huE3MbRtsWLDXF?=
 =?us-ascii?Q?aL8hBpJ16w7UwaxvubSfZo6wUBMrt+7GtaK1DPiWOnLK5/7JjXsHHd0eP6tq?=
 =?us-ascii?Q?bBOFrRW7yd27KaWDYkEGOk1UJK67K+buy75ZIwvODJH1oASKCfLtKsdexj3a?=
 =?us-ascii?Q?1/WXuNwIhP+hl5Ner90x7TO3Z8fDFDStuUXFT/bjb9R9vF4nm3gpHhFcmgSl?=
 =?us-ascii?Q?6qXlDvUh4xQNijefJ/DqSvTCQzTZQ0M307X9LcfRBEpuxPYAl8CeKAths+Pu?=
 =?us-ascii?Q?gXmLAteg/O0fVqnQdTkj8NvCa6sl8KKzHmXnDxCX6YQ6Lm3RLXcC6Y/jQgsG?=
 =?us-ascii?Q?shA3+8Z5pehpDimEZxTDVxyTYwHsehjkjQrbky+hBOY6/SbvUe1eqHFRTLoF?=
 =?us-ascii?Q?iBTIeJ1zW/BrVhwYfSdKrAQz6LOGrYXgumVPhWCiy6wN9t/2pm1yKeEnyu0r?=
 =?us-ascii?Q?ZuuOcZPXPuM/B1M2mCpB0ZPXW21KH33eZDMNUwb36xzbs53ZlSqaRC+lHsQD?=
 =?us-ascii?Q?ebL2iTxnORZR+yuWVUDJMe5UMpDJXjjJu29RNzVTomnZHbwker1czH8fyqxX?=
 =?us-ascii?Q?T3Q8Y434Phi+bVR29lJgtWaP+gAUKZ+v+NdvmgysHpUQpVDqkAdX1mUWDyyW?=
 =?us-ascii?Q?rhe2pHF4qs3bCxv63wn0c8z9ILRrzqDyreTexHA3KVsjP/gLNZermwnHcXNx?=
 =?us-ascii?Q?N+fnhLJj43Hcnm5ucsiG23W68Zi6/DxZmv7Rd0Tc3TWmF5ADKsXNq6FjSn0f?=
 =?us-ascii?Q?pSqLCxeWCHf5o1IgqoNwJe+XNwzFDj5hr60j58zMk+ulZ1+v3HZYpcnNEboT?=
 =?us-ascii?Q?6h9XhqFJByK133ZNo5ntzG7Kxaw24WszYqU6T06YeoAcIIF3H3gs3IBvDZJn?=
 =?us-ascii?Q?uHYDePXcw5o4+lxg19vnUZ233J8mOSeIF7qjSLeL7hQjh+mI0zQ/9GldK8Rf?=
 =?us-ascii?Q?8HLrryK4V9GPJoHnJNXnnqcndRsah2o6rVxs8/2PA4p2MwLj0xNLhS2HKM0w?=
 =?us-ascii?Q?juHm3iYfaezUpfoDjPt5VlTlKwa7XIjjnM/sAk5LOndOFcRozlTG5KE9OWOc?=
 =?us-ascii?Q?9ng0aoD8xxS8g2IWZeX7/8Hndte7MyDKEr2qWuUOZFKhdxBqz4IeDsQIpfJx?=
 =?us-ascii?Q?xV1Dgd0P0UoZ2s3uPavKQBIUWqO3U8C7nNVhyRdWPsnM51X0GZ0LNcbZ8anD?=
 =?us-ascii?Q?Oj+Sct4h3C+KTIlfOJBRNdl1VRd/Dotr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oU3CNb7Jz/C33vobUoOq90R5PXaNjyD5/kmBntmNqhNkbbFZwHkDLjx0u9w5?=
 =?us-ascii?Q?PIdy1bQ/92Vxe43W6252mIwBYgfwSuqFDrPSoNMk31zqlcyXX3vYDWK20PlH?=
 =?us-ascii?Q?cTXljc94EsLqGO3pwQwbKIL6jK1JVM+ZvVMY9rCFm5cQ6vspwLHRGGX3sE3r?=
 =?us-ascii?Q?dhoIB8BcJxCxwNSZUrDDzy2uL0y+45tKy1OT2gUX5rGNVoFmjRKXglc7JiYR?=
 =?us-ascii?Q?JlL7i85JxItXpfWS+TQsebyGPHoH3l6QkDhfbYXXLJUDieb99B2cZcPBxe37?=
 =?us-ascii?Q?MDH//ulU9IzaANyq+SxIWYHLl3vjQ3rSTABZU6O4JvEmDP6u9nitw8AGUFc1?=
 =?us-ascii?Q?aWAAbmcZqhmTOLQgZoN1sftcq5KRHH208ZnYTFl3DyQmGpUiWYB1uyCg2dKJ?=
 =?us-ascii?Q?tR75MS20+U5m7CGG0DhEMM7tqSJELDA9ljQFw77mYOnvxqaj4bn6B7XVU58D?=
 =?us-ascii?Q?XnWO/+P2AAwN42Ux+grRELbdcKtX9SfZtTTBLN6AgyT4SyUx1zLqdxsX3NJj?=
 =?us-ascii?Q?42W7zttcx0DyI9RdgtcCdJVvuU090oqbHnP485wzoOsgKl1RnRioKK47hjmI?=
 =?us-ascii?Q?ZW2elp2MO1ttuIKYV91KYCalEUFuL8wajqMmi96en7QeSYqstDEP3St1dUQC?=
 =?us-ascii?Q?rcaC2AkgLXEJqS+VT6O27wZlhzCK7AigZxbyZsnBLhhjiRMUijP06udW/gwf?=
 =?us-ascii?Q?fTiJKfnJqg31e/ennnup3PwC4Y/Qn0Wz5EHFjhUtkpoFUivkpeAdwTArGx+y?=
 =?us-ascii?Q?xGVc9Gw8ctdZHMoUS0tz9bj37Q+IHoEloQk0qna+OBs6No7YGVjmKpgbCkVu?=
 =?us-ascii?Q?cTIT686rzqwTtWxbRmheynAgPhwx/pE4ZeC2gTnppJNQmMDjzWAaksI93bOp?=
 =?us-ascii?Q?wi80+PpHO9DfU2CHTSrQZf+a1DaXjH3CrmctsIH40WQCl07EJZr75oX6yg+O?=
 =?us-ascii?Q?GhJ0SyAcY3Q38kNzG75SRHrYH4toT4c9ULFnj+xqMtatGh9HQ4uwHr/BTeXq?=
 =?us-ascii?Q?FPYE+QG/ddwYY+ngzMODvdKgfhbLZqt9gMqL0qToK5+N4JmhqFh94Zb9KE4d?=
 =?us-ascii?Q?uipS9eqSUxdXoI4u+U7qZJtsA6+TfvhtrLlRNL34wN2VRGZpL03W7dHiZ8rK?=
 =?us-ascii?Q?6RarX1hF/BHVFCKgOWsxaMmjI6svunldwKzmnXdJ5OwB8dn6qc4+kiC2Fxqx?=
 =?us-ascii?Q?RZbRmyivJs14hQ5n1FRUHuNh415OwrDn3OzI8yXbSqi/Vx2ECRkGSLj6syzj?=
 =?us-ascii?Q?M30mkqAff84brWgUckNakeO35VhNu91OHgUF5tgF1sE++IzBCck6+OP73qVT?=
 =?us-ascii?Q?IhYk5iPk+u17GJf1aGytSmVTHexscVofdD823V2qLKiyc4sGtQJaiHMrFS5I?=
 =?us-ascii?Q?uvZV7k8qi+tKNtbMCdUMqfGiaMdtIZ4aAUq5I7hSe6kCKB10Ov981YFABTic?=
 =?us-ascii?Q?JzcAoUJa/qeXPfEt9QQcvryMi4W2f/IVn2AjUeaZfGF+93TApuFpNJyUCqXq?=
 =?us-ascii?Q?wkM14bSy7i4M2RAOb47AKZj8i/1rRCVreh9AtyyZ0IWlBhDhNShZMzwX9/8S?=
 =?us-ascii?Q?aAnBUH2M4mJ1y81FVB3pPX5movSRwZMgx+QiyOAK8nCiyQfnskCvTB0sWl4W?=
 =?us-ascii?Q?EF3U7P3HzsPvy/J7y8WOITA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2490ba63-f0fa-4b67-85d6-08dd66cb466e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:49:00.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wETz7hfr5XR9CHzW0XrsrVRrrVrX4z7Sf4jKcex9gNubttx6RbCjvKLoN/ZgiVl830kJQwEwJdZMz3VjgJzsJUonM6RXwkB8mnJSz2ltPHCTQ7vw1gsgZF8ZTAFqCCVz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:49:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18258

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
---
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



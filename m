Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED4C35FF9
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.21])
 by mx.groups.io with SMTP id smtpd.web10.34503.1741778837933434840
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=E08kB3iQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.21, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUjtKRVJMtKNP2U0PczviMX3IYAkCsWeWKjZffaWi1xKzB2hWKBSyXhYPFmtlv2ySPfpumv9JjBuYnRSQNBkCf2Map4aIjz6kxSiKMB/9stPENFwkvdmpEnV1qYHAMpXtb9NQnf4eQAb0TM8Ku1rsu2FHTTPsUECCbS5/Dxng1KjpP16ltiYcdXS5keGLso4LjVPucd8kiHjYMqUGNfGpaPGh6uLDcjw+SJudc5ZfXblaaCP7Gk3RS2tsVt3O4arYjKZpJ/TfB/He8RL00D2dlOEsTXACzpXrq6RiYgjHAhQXDdovGCRmFhEwrNwP2qj6V4lFPeOfELEhMjjbWidgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWGjgrPUCJLQ57u+SpvjJ9ZrjNhB0nEDdZXXU3ECPbU=;
 b=td+nLYHAW2HBUugPgZ2H1gPO08Y0pigCEC2W+FaC8i0eWocvxvUFd7V1wxKydevs44HwKXUR+SRdYHqMk5/XM77kmj17e4HFHIDD0h+TZsxLETaOripzLkao/Yq3HYFv7y9U7Fs4CpH9xWS9QmEPPqeTNtjxNS6JMF5pF0dHkO0CXHFAsYzpBy4evRcQAgYVQasKfWDejiV3JuicKEuTUU2hkRhC850rkj6Kkij5842eR4d3kFZmvN6uSnPw2MyNwtZ4xsa15oisDhYonB9nLw6HB8+RYN5PmiAm0tx4gPi+JuVDex2QzgAHddCSo9X3ZKqpKHiWRQNeCGspmev4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWGjgrPUCJLQ57u+SpvjJ9ZrjNhB0nEDdZXXU3ECPbU=;
 b=E08kB3iQIw6VB42LUObCx/r98YXD/iJ8GZyFQPYPmJ2SbOhM1xGkgS64uP4YpefWmnjv1nHf9RNxkcOMUXO3/3rdtbquWLZxbRort87ZIX19dTWGuVSf8J0K4pzeWFrQ2ImheGTTxJC2mhI7Ke7mUdqJ/tdk8Xzqc31c9fCpJ3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:15 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 75/85] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 12 Mar 2025 12:22:52 +0100
Message-ID: <20250312112302.1605750-76-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 405c349f-a16a-4a89-6500-08dd6158d75f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1tt/EEE+zTTlRpqfyRmNxspdO9cHiJqAHSWRIbwUzo1qSMaP+ampurnbe8MM?=
 =?us-ascii?Q?mVjsVlbL3Vs3XXlfHUDgWiFXpDC34EkoSA65ytNEk5fEqPv1E56/L8Jc29kd?=
 =?us-ascii?Q?hJWXNGxC4C6oAKf0QB1EUcZTYjtoxl4RxjXIgYV6jhHnbx+8tRZObmaHH+Vb?=
 =?us-ascii?Q?xOyY4yo6LL3N2R6f+dBmmnOx7uOO5/TcUpLFbvP2R5RfDMQ4ms1RFmAbYRqr?=
 =?us-ascii?Q?r1/QTmrX6XcHny6WvrCH8DlUJX/ozup4U1X+7tGfQRDalTnnxztMemjB2Ad4?=
 =?us-ascii?Q?bv/Ou9rLsfvWeOmdw1BwNxEGF6mEOm+y75a/B3alp4ZzaFuNRJhdHPmPGp57?=
 =?us-ascii?Q?tBRmu7KGMV87iPRtWGVtWwebmFNFszhHOu78Vi9VsFWAIsL791lY3xZe6pZ5?=
 =?us-ascii?Q?1wzBvlYAntQZ11crpjxKQwD8TmIuKXnMXvlDc3j5QsNzfGFuZvTMiHTU8on4?=
 =?us-ascii?Q?chiDn92RHsuNJCmdK96vY69EddB73vdQmylOIUQXakAuUl3XNpiySlCs2jrx?=
 =?us-ascii?Q?pcrCmdbzSSaYFrBBCbhEQUqo+3uE1tKtcSrj0vN6rMmiw6rSYG0vBBAmBGAR?=
 =?us-ascii?Q?e/IZ0afItZoPlTfAvlyvx2SOCGvSO/NXHSj6x0L47plrrS+dtT3COySZEBl/?=
 =?us-ascii?Q?NVMk44c5t4xQYb/g7icSa1pbrRvN75VNBYFvqN/TOwmgqujHpMoL0j80uQlw?=
 =?us-ascii?Q?X72nYw7G2Ou8SALJ7SrHsID+lSR6n/xc/haabexjDLVMZKb3y9E4BehMsTmX?=
 =?us-ascii?Q?16j+vpAHlbUR8RTXmW7HE7qLnjyzJ0Hw6kSg0BV0GAb8pXSLAlgsc2MNY46S?=
 =?us-ascii?Q?IdcJHG0kazQg2PDBYf9E5en17wrw+U8jpejRAP0spZ+SSWk8CDc25etTBZrZ?=
 =?us-ascii?Q?zCJ32MzU1MJX5zWdoxzEfqZYqSxUA1azGcUHAz7+rdiL607t1PTJa0BS39Xa?=
 =?us-ascii?Q?ttEIgAuM1CWMWXu3+JjKJWJ7NrnltQjLGfiEk5EsxI50VhA3KEtJsdFhoPwb?=
 =?us-ascii?Q?LjGvwuSEdkvdxBcFgu+Rv9jyyYcF9vnzMXyGCrSfdJTbkxow8pFbAKsX3QcY?=
 =?us-ascii?Q?N8CPKmD2kXjVo9S5jTg3vRWtqv8nIP6Gpth2ouIR2/wRCY6E95Ze3yKNKWfq?=
 =?us-ascii?Q?X5sJmiVXL626Ca8phSXue8w7JmZelEf6KAiY/qSy69eJYu2Da5VNFfYrajjO?=
 =?us-ascii?Q?wu+YnscS9q8ySjKeYLxLoaQPG/GMYDiRnwvYStN6nOh887i+hs9DjmJisLOh?=
 =?us-ascii?Q?AeC4ygUkR8PdjLp+sh3Mr9trHiUrsowBtI3AkUCb4qlp8Gd7PZfNIbKj1H77?=
 =?us-ascii?Q?JSk9z9L1tDL5do0Zx4TITN8+yczQd00JZjk9BHhfh0cd7AmB9RxktnYobcKN?=
 =?us-ascii?Q?tu0lkzKvf3EIH4DLX+EILQCZZv2U7yjMf0K4liimh8LiqR0+51S51xgtNwRZ?=
 =?us-ascii?Q?B+lkqu16zaQewMQbGL/G9krFJNwagHS4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YBXCrmC8kidosIkFGOnDzyxh83rdr6O78njeKO2eoPe1nabrZ+QsKN+UmzQG?=
 =?us-ascii?Q?l/7efl5N2kPBgXYl1dHaknN4T2GtayRx8j9tD0lXYwFEL1gJlfOvIcpsAl2F?=
 =?us-ascii?Q?PJf6A34QNp/EIoZ7GQDqkEDi4uCQFhGqYK8P/CALRB0SZkWUCy+xAP8B6r4E?=
 =?us-ascii?Q?GJ6Fc0mqWsbXhFu55p4Oor0+Z/Nh7TcPO1mK95kEwN4aICjLkXXPxIgieGb+?=
 =?us-ascii?Q?LugH+n3ernwfOpg8KYPmhhaTGmOoUdHUqbG1NcEfyG17PxmpZAVQIBhuUJGq?=
 =?us-ascii?Q?ffb9xmYo0DuLQHNgHhiUGu+CCF5Y+6nnU3dCeZbfupgVvaeXwK60B7X3E9Ml?=
 =?us-ascii?Q?XzzO8yhcYksRjmDXzbzt9ncfrbbubR8xQX3Rl0OQjpRHuns84MmaL8wS3qSz?=
 =?us-ascii?Q?nF7La/106B3SHV/kDT7k2mfXykp/yopRU35UqOsKXJb2QNJaf7Tsh6hLQQGH?=
 =?us-ascii?Q?GeX3Y5oJB9P5bMpmWs0nuDyL/KESiT3Zwx8JUu416HGrAi2UTBtJpKlK9s2+?=
 =?us-ascii?Q?oGSBKowolqtmOehDYkK938VI3tvIeZ9HV23I1B/XwZIHP5+uL1AGCYCvDqVe?=
 =?us-ascii?Q?vKzcxZFc8wVe1N6LDiJJj5t39qzr97GlrW+pDLU2LUXHSt857hSUNj/4xW3W?=
 =?us-ascii?Q?OQIFarxY8xj0YAUM/eoY+IHSXaHvrb9vxSoCGfJ8qOTHgzJZechYQ/cgavbV?=
 =?us-ascii?Q?0Uz2x1qx1mmwxArDLaGi1xxRvbp99rXpVm7BIv7+jy2pqk9xTALenyKWaHhB?=
 =?us-ascii?Q?DCVXX1wHpY+4g+mWsZKribruOkWSNNs1wRIwqDNxv8IGPphaX77pJyYQviBV?=
 =?us-ascii?Q?2S5XVipM218RiwFnEO16wucly7MvnSHItDYMrpNCE1GH9F64L4crPPVwaxpf?=
 =?us-ascii?Q?yrO9yPGhoPkU0Zu4vIrM1DEDitpK4fq5MLQDQsOXODXW8kWwdOgwpz8vjuig?=
 =?us-ascii?Q?glz6iiQZpbs6bP0/4sgzDrFivLnCvuIPs/MMuFYaRLZU6Zl7WHJDx1/QRtjh?=
 =?us-ascii?Q?3e4tlt3aHRHrE8udkeVEj2be3F1RJPddunzlD5lPcw2WgnKT4kwMYabxlpf9?=
 =?us-ascii?Q?R02D/zxLFicGhb+DLln5fbb5E67tdvg8T40VdfMtv1k6QPc+gCJPWlQ13AVp?=
 =?us-ascii?Q?nXpwoeD1eJAsmhw6Fllsiw+hrRxKl3flvsxzLWnOC8Nf9HF1ELyCFZV5IZzS?=
 =?us-ascii?Q?2duvHGcp2EhQ2zZ7A4wzQxg8Um5qjelqHM1MsCDcAuyc4zMM7ALbFYxFebdk?=
 =?us-ascii?Q?nKBkC6g+/pXDgAcB2wHjF6T1jwU6xz2IobYZV4PvWh6KeIWD1hhs+wE0E77L?=
 =?us-ascii?Q?xK/LrkfHouPgItog+qFozDzt43CWNE9nCIvAUlE/Vtvk52UNXR32K375F80M?=
 =?us-ascii?Q?fVfj2KX1DiBm+H+lPywOvY1g13Kcdo0GEahOGe/V11W28k8bcA6beHH1ItzX?=
 =?us-ascii?Q?wpDsWFWaaFNXj3Q14BLmgqzTeLyFtxXGm7QyrpI98UPpZqHhj144BURfsMT2?=
 =?us-ascii?Q?+Atht7NkV6H6o6mXomkkLkpZ7bWfFrEJFHoUBRI+Y2ciWNQhHBit7Bmdr6ZG?=
 =?us-ascii?Q?DLLEbW6WvqfqciN202nRVc6BYm9SFhDSQVOsuSWEW6RTp3FIfYc5bt0GWjmq?=
 =?us-ascii?Q?3mWrlbFoaf0OdeKvge4GDpE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405c349f-a16a-4a89-6500-08dd6158d75f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:15.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2P+7s6Xrph9VPcMC8zTqyBp/VD7RgQKv9MOYZYl3evn2e4wAlQZVKzyEPA2vfahjesrADEWGzk5BKL78FtzYSzxnYwx4hFZtpafJ3N+HNTd13/mqOa8YjoFTTBOluWN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18167

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



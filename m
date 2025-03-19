Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C3EC35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.60])
 by mx.groups.io with SMTP id smtpd.web10.4379.1742379442786752127
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:17:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=BzOANatk;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg/5EwAFlySGI7XEebaNRBR7UFi9HoeS+b+idtvo2qLnCfnOeZwnb5hPr/EkGz3V1sXxMBDQEFnR4jbsxsvqRYtRdaGeEE8YDnmJA8OdZ6Cyww3E4CqfQ9DwjvLPBHGSph1Lo6CJjbrLINMCJl4ubAkHQnpz8M56T+iRsokLuKPjp/pjZawEkAE2YKhUOPjQF9Gw3TYz+gJOKlO2kMqIWatPSbUMjf3pNLFjIXUw3HoI6krbTyUvi/9YM4OFQce0fLNiApdyVz2wCOmBY45J38sbZr5h/qfBjHPvf6mKQdDXdVlYfW9m+WdG3NvIcXu7FVWAt80293aosx2RmbKGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xldODGoSTDAaB8M38lKTo/KSHoDeCtAR7p5S6TC7Zxc=;
 b=NFWF0GrAwWvb7dMuklahK73X7830DXVyxEhVrbJTuIkTVMtly2geSSZIQcJLQaSotU3/jxPmycIU5+BRxfGbVqHWVBsfl8NpHf+mQXsNq8WwtGz1RIW2OedoX0UKZlhEqlv4zC5RNvhMq62/WjfCqWQWMqSGej5RaUJnR8/+NBdcyqDeGeZ5u1mwiUgy8vfys7KdyE+n6Ga1r2ja1G7FsiLrNePRGcGuYTtSdegpAmiMm+r5b81RPTh68pR041vwGZmUJGVh2WCbsErt9QYLKPDoPQ99UWAy2pXnMH4uLk9lDw8+cCAaSZhJcM+LW3jcdFnqNMJnL+iBkY+wMfe9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xldODGoSTDAaB8M38lKTo/KSHoDeCtAR7p5S6TC7Zxc=;
 b=BzOANatkM82KIgz/mMAfrJWLC/aWu+0gEsUbjrCc+tKpIKTF0imbt31nmvC4Zy516HLNdetrWRtwBJF9gaqoXZ5QbQoAaAb7JGigLzCpoC4oNM89KddKirWcckaQVljjbdVhnvDuAN+2C77UtPxCeLqBEz3aBWyoRBre71/vmEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:17:21 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:17:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 12/12] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 19 Mar 2025 11:16:29 +0100
Message-ID: <20250319101629.2407727-13-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: b057ed84-f0c6-46e4-ab1d-08dd66cf3bff
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?b+Yx0zRAyzIdMkKlD1waKAtsbGzUNb0PjTBtELFJkv5dWnjf6nnatufW70AM?=
 =?us-ascii?Q?bO1FsL0nYYSR2j0ELpgrDFXfyw+i3NMc/4Oy5K++Nl9ILnymY3jdaDzExe1z?=
 =?us-ascii?Q?Ol4Iocdcxxw2hT8E/qzrtzvbaW/ehucdLxdgvtt+HCO/WnTuvTzzrm9LQvUC?=
 =?us-ascii?Q?uR+1hsi+v7cV9vreLuaCP8onwlM1/mpRMMkyLONh/qmx7yM/gAiPirH+7Vpk?=
 =?us-ascii?Q?WU4TCDLsJROeDEpT27A8sNTN8gZsQSXpmVuXZrEUcmKRWIBeWW0b77H/SAAK?=
 =?us-ascii?Q?fKaCAaw2l3c5Q1JkCJzm5LMIZ1thckv6Q6L+8K563hnpGSJufoKL6HyDtAV/?=
 =?us-ascii?Q?wPZ5fksWWjPMIndmaiKuINeScPcK6v0hOFDhhsy/PFfbuJdArxht6mKU1771?=
 =?us-ascii?Q?DOytISfUWlDu8MSq7XNb1bzLV4bM1xJUtsqsVdLj4DFIR6/R7uL0jlK/J3iS?=
 =?us-ascii?Q?F2/flEnsl+egmPzdbZQtvJr6nyEDitRUgwRgcEn0ODj4pIyoVB7qFO00YizA?=
 =?us-ascii?Q?fMn40M91FSSd5Yzk+jocQQENHktGNJVl4AmQY8No8erbU9FIqg6SWG7syYbk?=
 =?us-ascii?Q?boI4dwGdmgxmvNUXVE+VIc14cPmk5vLr7DnzfzxPSnQ4QXsT64sfiNR6PoeG?=
 =?us-ascii?Q?0H0/oOtHdTSpPKjIf8LWVxUTRdasUkGf0WMF8W0jJRze2M3ID9miwxLWhv/h?=
 =?us-ascii?Q?JbBUi5vxpZqRohpGWedkuv1IGRs004ixu6u/bhmvbgS4dHc+JSmTVQDiFY8F?=
 =?us-ascii?Q?PT7ceYDbNp0KEd4m+f/kyw7uqb4rfX5OlnR2cVEy/1D9Ya2Pj0Y81hL0tE2g?=
 =?us-ascii?Q?TU+oi2T7qXDJVZRaRjJSURt6MBdeWUaC8bQUWgjq86mlUvp/pufJ13x+SGy7?=
 =?us-ascii?Q?Bl5APLuX7z/2ugvO8DIMB4rhvcTH1QYu2kgYySPkzYvqiHbM7qwVgvTl/w+1?=
 =?us-ascii?Q?y/8FRtlfYN+z/X0KVA/xzBWyqeeFEbI23GfhgOI7AkMfMmzudeqc4bZ/tLq1?=
 =?us-ascii?Q?i848ARon8OhraDmfu6eOP0rAVJTw44XjfXe7/BAzCHabYjFqk4lEu0YvMmks?=
 =?us-ascii?Q?JBnRND+9jCplZIglrnnYDAwmrP0SpGKLrmfNAkcDnSht9K5IGMLSKMFfrwI7?=
 =?us-ascii?Q?mUy4t/GT7HNpZDsXDpi6VQrH3sKIfUHAyoN1Z6mVcvYckVUM6gkn+Tp55EFm?=
 =?us-ascii?Q?xeEwK9MzUi+X6n7UmXY0QSmpTG7/hcqLb0/lP+nMbViuAeS2qHl/sGDSojgH?=
 =?us-ascii?Q?YyvNCqixYMkrOIfVVI7L8qkX6QkP4tLXXE6g7bEMsHX2JFCAicWl5birbQS7?=
 =?us-ascii?Q?PQfWNzRENXaZ10zO0tBCeCkg/16L8YfBp7thidRAMAJVtccm4X5pQcHUcTja?=
 =?us-ascii?Q?1sLJmAD1wurYCHECX5DML6jS2sygJUHtBBJkmaUwika/pnaEbzmteXYFWIHC?=
 =?us-ascii?Q?6H0Q2jNFJqW/Egoj6MxK6rkPCeL7fCJS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?b2CdS/uD9JEo+ns8IjGmHkqN3/BiVuRfw+WWa8gCKSIdEg+PIkA/eMwN0AQu?=
 =?us-ascii?Q?tYqDyopIHUpiAU8ZCb9J4pwsCpff9Oem4p5unvI4Pv10f5VvCzdaRJOmnqhr?=
 =?us-ascii?Q?bzFG6w/OS98xiJDDmJhhmMTEcFerX1fLfP80FgeSV3YCNAvSgpU/mtyRNqIy?=
 =?us-ascii?Q?uBAUDiFE87V4n2bJQr50hThReWRVUkLv/nrOK92YLgNG7/anN2t2RNwbTuHP?=
 =?us-ascii?Q?GhtphOfLcYUq1eOT91d0z+zF3GM0zo3uBCWmSjSe1J4AJdox9slZTqpDaG/q?=
 =?us-ascii?Q?HiWE4HTmukd90Pghb8BW47hqePrUdLplyc4GL0PuAnDmFkB7uWE72dCAAWSa?=
 =?us-ascii?Q?PAPTKIzaClsBQ5WnvhMuWbzXFDTBxHunylP0FycQZzlP9MJE0yecFyPe8Psz?=
 =?us-ascii?Q?ZJeq4DM3HgvwyW9Nf5l6vitlckq6HM2MVgfadHN6xbLxLWqZ5VZcv/boNF4B?=
 =?us-ascii?Q?2jLCPkEHqmxu8zhV6KEWycxo9tpD9cylcG1Xo/+5iOp15WjztJ/+Ai4y0Ltx?=
 =?us-ascii?Q?4hTzYvAesd0z1PEgscES6bPieEzawfgJcB0fF92GqkNMuGLskcGtAcXAvLCB?=
 =?us-ascii?Q?PFAXUaRTJFLmFbZcc6b7g8RYokIuJ0BxofEhM5mryXJIMXeN6nV5TLYnakfL?=
 =?us-ascii?Q?QYGR5NGdJ8VVIcKtXX7B1dRgwknJ75P0iHQ26UZkCbgT9CaQr6kFFPmp7fkd?=
 =?us-ascii?Q?uDH/Gc3kNHHC5ZXLktGq/Iod3O+WbzIDeHigSqJpLf5ZOcvOd9PWHy2A3cV2?=
 =?us-ascii?Q?wGUzRL8HISSkm2yWCvw/6SWGGU2i2TdayqI5/MgwQWyNnPSFpNITQ6D8cDXI?=
 =?us-ascii?Q?AlnexMgUjhWVecKrXhcpYRSsjGeKuoYWU1h4b/A3e970XIQnW+54TG7jc1z/?=
 =?us-ascii?Q?Aj98q1STht0xwbjYiC1p79OVM9YsdlqhGzB+ElErazBmwLhwZI4vaUV1a34e?=
 =?us-ascii?Q?Wx2+gkx9CkTyQrvDdWfHQWLfUl0veThEsyNRBsuXHf+5WQ3IDrOIuT8/A6bd?=
 =?us-ascii?Q?OfMtcZyR1lctwS2FiXY58XI5vV7NmsFMgIxyzn04uLorW8GZtX4G1C+ABvxa?=
 =?us-ascii?Q?SqpkWh8v9PPUdZW0EVdhAvCXXHbIrpTH2f0ugTOi0vAMNLX7G+JZC2TdpJOR?=
 =?us-ascii?Q?XwZUM62QB6FFh8mRK8YrMny6inrgRWlyyW6O2BzbJ7kZUvcwZV8XnW788UtJ?=
 =?us-ascii?Q?MtCYJgV2Kv2fWGEmkWUIGoLzoBbSsGAJMREKI/3qVSmrXcZFajrPgjVhz2Ol?=
 =?us-ascii?Q?0OpkyO72FVgGH4Km3CyvwTWOEnCoLREMBgwGDL8loxBZF4w60d0B3sZEksW9?=
 =?us-ascii?Q?UW1LLj3XhvWrdk0gpoBWBBi9KqvtLDTAA0T5IQCL+r9BpiLcN004e7GhWnc4?=
 =?us-ascii?Q?w3+b0Ww5lTWG0foatAZDBZ2+9M8z74MmDxJtBYpXVw2z7DZ+5+qKaC1VxsmU?=
 =?us-ascii?Q?/EnxVFrpFeTFsSjLpID8I+dj+uIy7pje3wxR8N+vx7LSs18vTyQh1F2N3dRD?=
 =?us-ascii?Q?ZRuFx0ZVcwuLuboOGQEPDkaIuXaTSxeHi96Id8fPfpG1BiywEkbRArzGoqU9?=
 =?us-ascii?Q?OVoYXK7y/ytGiKPyMnFaM/eS+IqhgUJVvr033xk8yNuZ86Uw7lvsHgPoTnDR?=
 =?us-ascii?Q?GUPkNWTfUXgA8fgHpAbSqIE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b057ed84-f0c6-46e4-ab1d-08dd66cf3bff
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:17:20.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGYJd5ec9H+MPM+gWN/wVXqOy/rUdWk2tNh3zNFAqEGhlkctbQ8MNE0DLzFkViqhz50QAfqwb/aRUxipfZk370/d0BW8IBBmZJag1SSKR++xnH9DdmQz2A7maNDzwvbA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18273

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f upstream.

In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
with earlycon mapped at index zero.

The uart_add_one_port() function eventually calls __device_attach(),
which, in turn, calls pm_request_idle(). The identified code path is as
follows:

uart_add_one_port() ->
  serial_ctrl_register_port() ->
    serial_core_register_port() ->
      serial_core_port_device_add() ->
        serial_base_port_add() ->
          device_add() ->
            bus_probe_device() ->
              device_initial_probe() ->
                __device_attach() ->
                  // ...
                  if (dev->p->dead) {
                    // ...
                  } else if (dev->driver) {
                    // ...
                  } else {
                    // ...
                    pm_request_idle(dev);
                    // ...
                  }

The earlycon device clocks are enabled by the bootloader. However, the
pm_request_idle() call in __device_attach() disables the SCI port clocks
while earlycon is still active.

The earlycon write function, serial_console_write(), calls
sci_poll_put_char() via serial_console_putchar(). If the SCI port clocks
are disabled, writing to earlycon may sometimes cause the SR.TDFE bit to
remain unset indefinitely, causing the while loop in sci_poll_put_char()
to never exit. On single-core SoCs, this can result in the system being
blocked during boot when this issue occurs.

To resolve this, increment the runtime PM usage counter for the earlycon
SCI device before registering the UART port.

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250116182249.3828577-6-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

 drivers/tty/serial/sh-sci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f8e4062d9b4c..3f5c319215d2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3435,6 +3435,22 @@ static int sci_probe_single(struct platform_device *=
dev,
 	}
=20
 	if (sci_uart_earlycon && sci_ports[0].port.mapbase =3D=3D sci_res->start)=
 {
+		/*
+		 * In case:
+		 * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
+		 * - it now maps to an alias other than zero and
+		 * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
+		 *   available in bootargs)
+		 *
+		 * we need to avoid disabling clocks and PM domains through the runtime
+		 * PM APIs called in __device_attach(). For this, increment the runtime
+		 * PM reference counter (the clocks and PM domains were already enabled
+		 * by the bootloader). Otherwise the earlycon may access the HW when it
+		 * has no clocks enabled leading to failures (infinite loop in
+		 * sci_poll_put_char()).
+		 */
+		pm_runtime_get_noresume(&dev->dev);
+
 		/*
 		 * Skip cleanup the sci_port[0] in early_console_exit(), this
 		 * port is the same as the earlycon one.
--=20
2.43.0



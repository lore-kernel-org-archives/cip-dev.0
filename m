Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63552C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:20 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.54])
 by mx.groups.io with SMTP id smtpd.web10.4374.1742379431466284348
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:17:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pD98obB7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=un/MDc4NiLkGH9flIZwC6amqOpfwE00eif/i3bNbDCgVxCuVkztOk0rbntpTDYSAJqKaNjd9ix5/elIG8EjXkm+a1PQB4+btYzZoYV7KuWdbYEAX7iYHExNhBjvVdRw0gua9I8oyQtMpFjg3kJs3ZcCGYyfqlcq1gxMIke9KFOF5K/PAAmy9WpPqpdQdimUkwT6Is49k72J2uiAGqCm7PDO7HJUc/xYPyUi2PUiBp9ZsEL7STXnN36FhieiIj2AXQHGJiFF+lyMwCwvw7DJLKPmEPnbfWEHkg5mnYbOu31YNjSnCsNT3feWZG6b32+dx6rbgDo/fOhKyR7MBly3Q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYwLB/9twWf1mS70Uh5RgkCW/kYuxcrXvN/pUYJe9rw=;
 b=tE+eiRGFkFDXfP1KxzyA8RIS6XHCYRJwi9kD0eUDUKAIF0PCAncerpafuExkmVrqe18tp9JistERyiZLQahonlDcjuTLu6aLa4OsleLzwQHxJIimC7SrYjzxQYTV4H8qUFFil/Lu+GX2Tfy7emCZfuTRPBZ1fizn03O3ZQ1Xni9VlPYuwH7M4Gd0Itt8uBWUOQot5ru7Zww7pfGdoYQu66R8VA0Ur0qOLqzF7sOnBTa+pFzNqSc21i3oVRzSQXCzhZikl9He2zmiNLGltCo/mBUyUHFNQRyXPsTyPY0JsNhDZk6W6/UKJiY8cYxtBoXxAosGVPMQ+2uWitlwg372vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYwLB/9twWf1mS70Uh5RgkCW/kYuxcrXvN/pUYJe9rw=;
 b=pD98obB7WUCegzXTJ3E2Qvr/9aG8PHVxn1yVWlYG4oHDan7PB1sCRhcA0BQG8QWdVyxrfJ2B2R3Iz48RgnW0vAnLUo59pUrhQDOnsozpyNB4vVG2brIPyXQwhsRLvEv0qulp1sA8oD87cCgnBIfWXC55CrccCbdHaxXEGNlGKWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:17:09 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:17:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 08/12] serial: sh-sci: Use plain struct copy in early_console_setup()
Date: Wed, 19 Mar 2025 11:16:25 +0100
Message-ID: <20250319101629.2407727-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f081f539-b47b-4789-8cd2-08dd66cf34df
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1VyE+th5fUGx7nQzTkjLGORe2s8asE++i8/Vamnr9n7OK6jRDUOj8A5WRX4S?=
 =?us-ascii?Q?T/wmZV5InpZ66NNuqEIOk3klWe0IKVeBQul3J27Y8ysjFNF9WM3xFsitKpsE?=
 =?us-ascii?Q?hbaXNMRdgqKctI9CT6qZuHYLZdbxbva1XhQ1oCy7CTHSbY9nD+qHsERivINn?=
 =?us-ascii?Q?wDhZqnK3FrN6nRgUjd9fwqTZ4rZp3q1v38AveFk8yaq+iNZJmwOre90yixyA?=
 =?us-ascii?Q?MWXp1SkHYJBJsKP4wY4iEnxS5YUKd+J7FaFVv5HKAEuVTarQpgOdlcvyQtI5?=
 =?us-ascii?Q?JGelQqUHaakt+wdKPo8K4KzUdvhj90Y1trGIoqFMsD3I+0MHS2hIVXYBPray?=
 =?us-ascii?Q?IXc/ZBkKKIjLJLj0K9A8njc0XyKIs3IsRG+grLgXFoFYqji6aW1ZmXoYKD4b?=
 =?us-ascii?Q?MK0IqyVnWHAwLZQO4hs/QL6FlkNdcv+0CGvM07dmJDGzbIiC+lJIVLK3P4lO?=
 =?us-ascii?Q?YUoZtIXs5xelpVNaMgP/Oqn99gfVZBve5/3gwuPAQi43QEQFPbyFhg1w1Y/S?=
 =?us-ascii?Q?OdujNkFbu8t4J0DhBtdmQb4CGgY6JiN3I7/WJDOnV4c50PbwNjWCuy6+Eip6?=
 =?us-ascii?Q?9GjKxUZAvfraixU8xbWHhOlab9QLu8whjoqLgFJsEwLR/4u2LYv8615rQa/S?=
 =?us-ascii?Q?wOCb9nl25y6P3u+/5Rrij/W1Zna9XSYGseqI2XpQ/2ROdAHT76IVjtP2Vy//?=
 =?us-ascii?Q?7D7WJEuLoJGVGinHWvmcf1a2p29usHz+YWXPOKVW17Vzr+0nHG10mnevyELt?=
 =?us-ascii?Q?+sHOecpUIMQtqHAJpCQv+2uAROD+0Ah5S7szILP+XXGoD2Jjf9x61gDKcBvr?=
 =?us-ascii?Q?NbuasteJW8lEYOyQ+edyzLXBrDdz5QImsj0TJmT7yIE24dQJjenZckU/Qw/i?=
 =?us-ascii?Q?9/PwO2tD8SlCttE3Jckwq5zXACP/KrRLl4Oy/05TXn4Z9ZAFihy2mEtSF53v?=
 =?us-ascii?Q?E4bVZMRRj2jTVG8wNr5iw1d99v7BnvL3+PQSb0mJrLrBJnde7V010W7ZKk6n?=
 =?us-ascii?Q?37T505ehuMbPsydZngipcQtT5RfcfpE/rKjStfK0Rhq9nKnTi1QzQ619k5az?=
 =?us-ascii?Q?AibfVnqwR8jZDoMXdj5YMIyaE+mdRH6sk/Ge4yzTTwHQ4mWYOOhn6bCeEDdP?=
 =?us-ascii?Q?NkMDIxn8lUEuKT8xM0jlbZN5A4Q1uVYRVdls/0+EX7+pxFzN+FoXYV+Qs4l0?=
 =?us-ascii?Q?ZCfuphcmdDIZCqkmOxmrbgDKMRDDDJJuBomjgDo7vwfyHr92eiAuSvwTv/fb?=
 =?us-ascii?Q?3EqsQXI8WMdrwHbOqykSeEDWZmn/bIi2fbLenVUgAdPI2MPLZSBQ3GNdgHek?=
 =?us-ascii?Q?JZ3jF3h4TcEyL5qQhZAN6nqjJDdEocjWzJrTsHYgd2cYS+vh4OZZqj43OBYv?=
 =?us-ascii?Q?lBgSTGFbGMKlhJ9UrwHfSDrPay530GZAtaABNN4I0mLSPBx8wFwznWYfY8xo?=
 =?us-ascii?Q?b7qVtSuXgzxegnRaBaoU/T3CrXjGQ3/g?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GcEvEbsfa9709mbDlMqOuulpImC9bLLSOjNGa8IhK5VKCWvTEr5/QZ9XKZ3a?=
 =?us-ascii?Q?KlQeNWXWDauV5c7rddNHBolngjezGC3EpbnvnV4EelAK0gGx61RhAFCldhgg?=
 =?us-ascii?Q?90gcANMDlW0aYEbyy0nPVK+MQMEtXbo276n+ljG4dhbNRuFKW8YBDP0556Ft?=
 =?us-ascii?Q?by6+PLw7QwZQ2KW44TfdihJY5n4rdKR1uZywy/US+Cia7SIzrmRbQ8uKm/R2?=
 =?us-ascii?Q?TtPwU57GXJmgT1SzLdEWyv3+VzhDbzrSOr8936fr25dY2XX8LchXFyT+RtpC?=
 =?us-ascii?Q?onq6Xzw5U/hKvgBDZgJKWTmWAvaK/99N6vDCpo81icf4d3ibLbbVPn2hvu5G?=
 =?us-ascii?Q?9lwvW31AE1hiIkhAnNuH85uwBWX8yWqXY7rG6jT3QBpMfqW+lk60ET+Y8oIu?=
 =?us-ascii?Q?wAaclwRHvbOKAgfmCmHBA7vxkooiAV17IOV4RNySmhIRNqHyLmrvcaH9Je8M?=
 =?us-ascii?Q?VS+zLhFKjad9EOBT7GG9eye0pwBBfxgwmWKK+5ggIdWjD53gTZo26l8/8yAY?=
 =?us-ascii?Q?htdnOs1Zokt9EZYRFP3wCKrmouuQ/xqFhBX5M32oNkNVQPfZSsSrFtdiM/KZ?=
 =?us-ascii?Q?sR874j+QMVUdnCDYVCXBsBnKjcAZ2a9xqDcm+Br6HnkBX+9U5I7ExCOG5wyH?=
 =?us-ascii?Q?bNg9ntTBcOxcNNc9Psv5UW8l1AebPwdNSp4TzjOUf74xVDo8mr4M4NQgJI4v?=
 =?us-ascii?Q?v6YVsnmZgr66Od/UZUArZmBRYE80XNZoDqivizPl67nQ9nC4jlsRWoPSBVwK?=
 =?us-ascii?Q?xiBTQxLjp1x/pA7hpTloz5UbcRg1mdG7Jl1Yk16mhegt95lrVws8jBqrzQYe?=
 =?us-ascii?Q?elELdWO9Z9w78qmJCpxvg+Or2xrcI3U5hnBwnFSm8TJGF/z6KP4V4uBosWQn?=
 =?us-ascii?Q?YD9Gp4lUDD3eD8OWjjPo25O9HYMClTfI2eEu0REvRthPhvvLC2ARxPPIpdze?=
 =?us-ascii?Q?EFANxt8OEPz8pzIamX1lW4SpnCVTk0z73oFUo4K7I6MWALFiklx3JLZ/j8gd?=
 =?us-ascii?Q?BYwlibxkNtQgf2mQe++9LeUIXQp8lUPe3NkJOmmn8UH+xmQCCb7U9JXyxuln?=
 =?us-ascii?Q?Ygo0/8KvPXyQEhbin8SLbX8AFviwRV7yaDWCV6ECQeVCy4ZU7EG5nkJ8jA5D?=
 =?us-ascii?Q?PnMOl8johBTw4cVz/zlcj+gsZLzFohkrHcFrQf8gmf8DwtgZ28uzJVXFwcwy?=
 =?us-ascii?Q?aKLWF4dDscYEqY1hgDjsVDQEkN1CZ/P3Rkw45DrA263PazxvOJi8OMa5OfA7?=
 =?us-ascii?Q?Z+1DzVpZ7If2932yFaI0HAdvvx6fQvPQ3r/wcAnFhUTd4h8XgfukSZCjrKP+?=
 =?us-ascii?Q?j7ye2OxxlsCVpU+0268W4DQUESyy1wIR1rIp7CdtIWByCMNE5GCnSSjYEOTb?=
 =?us-ascii?Q?hmd1ugvGPcBpFYUejOriGyEE6wyPQueMXIe2LxOPdAdBqFsqRYYAMPRGGEXF?=
 =?us-ascii?Q?nSE2EIDgETnlZfq/9SRPPd3gUO6LgWRYskaxrGAEWhSvybsh2h29TVRyjN9e?=
 =?us-ascii?Q?jAjOJjOLuz19AXm53H2l9rxKwH1oe74gcJScS0j8qoIKi0E82MVXkboWClRW?=
 =?us-ascii?Q?30d99PFgdcr3dcbgUXvQn6gIDgks8LT+WdOTRPumI2qR615E9jaFamdJ7ocd?=
 =?us-ascii?Q?KSshOyQFC9yzbYMXQ3tqgcM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f081f539-b47b-4789-8cd2-08dd66cf34df
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:17:08.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OmkadUQgndktg60rOomX5ZtB1wmKjmdmUiT/hnx67gReJqWeZMGl+sBVfE/g3TG4B8LF+UiWdhwkIYuvvhj9UqBGP9G3C6K0IOm1EhL7VLMa96xaStQadDklxmtzS0Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18269

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c1117a2fefbcce30cced3a180585e0adebc0fa89 upstream.

Using memcpy() prevents the compiler from doing any checking on the
types of the passed pointer parameters.  Copy the structure using struct
assignment instead, to increase type-safety.

No change in generated code on all relevant architectures
(arm/arm64/riscv/sh).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/e097e5c11afe5bd4c01135779c9a40e707ef6374.17=
33243287.git.geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ff69124e5336..d1140fec861b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3566,7 +3566,7 @@ static int __init early_console_setup(struct earlycon=
_device *device,
 	device->port.serial_in =3D sci_serial_in;
 	device->port.serial_out	=3D sci_serial_out;
 	device->port.type =3D type;
-	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
+	sci_ports[0].port =3D device->port;
 	port_cfg.type =3D type;
 	sci_ports[0].cfg =3D &port_cfg;
 	sci_ports[0].params =3D sci_probe_regmap(&port_cfg);
--=20
2.43.0



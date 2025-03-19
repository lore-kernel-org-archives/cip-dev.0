Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E98EC36000
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:00 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.0])
 by mx.groups.io with SMTP id smtpd.web10.4360.1742379409972823433
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:16:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dCBfqLdz;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.0, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGjBKm1Zf83/nQSE0A9M9U511+G6tKfnd02y8/AAV2nf9RtB/ggrLbg5TuDygScwAo20qpzU4AANajUMdPzIhkaTKqrlsAF6Zpeho4EOYFPa3Sbq39NVSjdrSS1SCpBAHvw9AV2lFjzNdp+ybwBWBqbZVf8jV5XTOwJvpSs/lCHrFtb5qRnaR73AKCW9rjvcvKW5E65V54kwnUwdNRONI8T/u6joBpVcyh4PNjyxL13oLO6ROtnRU5QpqASwTqThCHhm+A7cyIeXJDG7gB2Qj9lfZJD9yIAZID5wsPFyBmwfOO7LyVBtFr6oalfruSj6cVpEio37SML7Rnc6IktNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9NKOTPT02DupfiT58dEJI6/19k2V4/vx3Y7d61jaEo=;
 b=ajcghobJCLg26/UgjFnc3tixVNBk1HHulC5AT9pwDtIwJkr8m24witAkYCBxmY5H7RXijzcnNVOodMpgbIDnk3lugvdGwkzgowDWRwCD6UBTnXaywaEMMUnFFaaN7/xr9yyceUZ6ejV+nXIUfJWKtFA8di3R0ZFkbhLKNkDLGpoF51rDj0DjFwEaf19yVfAX+Whunf7P3+FMKc7Idkx3gHQ3AE3uc/r8ghFaOmzc0dBQHB5bSinyO8/X1HrmrQzBdEYaQgZNDnx5ZQzoU86uzUfForw8iEKlyhLWCWF7oCwqkCe9C6/O+f1Rkw5vOif83yWxl0ksF6OOPz3tQbcaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9NKOTPT02DupfiT58dEJI6/19k2V4/vx3Y7d61jaEo=;
 b=dCBfqLdzdJuNyAyvDTogMQyyFZXMJal/DDwwLzE4cVHXwpRepd4H0e/7inEBJ9xATggoCZ4KC9k90t5Bdp/FxXiMpkj+YQBut5Krmbwhr/tbNoBtNLQ2wczbzRuB3S8W4+eOFDJOy4fZIGxAWF9Khidll6VDmf+FhfiHdRDTILU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:16:45 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:16:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 00/12] serial: sh-sci: Add support for RZ/G3E serial driver
Date: Wed, 19 Mar 2025 11:16:17 +0100
Message-ID: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB12680:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d5d87d-9935-4e0a-2419-08dd66cf26ea
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1BQbi+YLHbJmp6nq8T3kM53lvzRV5+MJzatNmKEfZg/lBWZ8H1aDBitnWP4D?=
 =?us-ascii?Q?F6YyO4myU6niErMLeRUqJ0dNkvVWN3cpYuRVkEKLcABHgsZmY6pyFi/nbcn6?=
 =?us-ascii?Q?aEqfO00jRZXaJD6t3wtvQuK+57t+td6G09dxBvXf1h9PpA7eWJYxwAYyLnny?=
 =?us-ascii?Q?cigrhhozxcaEnL5tb4RqJIqVV9I0LczxxBed/MPyHfl5VHoRilwA9FyzmUZl?=
 =?us-ascii?Q?2tenc6d65jaQUIO5V/geHoru5Rm8Q6hvC0qu1Y2PVfOKRP92ef5ZVbYY07Dg?=
 =?us-ascii?Q?z1t6cySfYno37wK2myjaBrAJvVUpRgzrjOtvf3aS3XA5r9xqru9nAU8DWUH+?=
 =?us-ascii?Q?TSpie7wXz9CCB5D1soJlh/HX2VLLBiOSEuaQA96kjcBkvKBlkaPga+gi8idh?=
 =?us-ascii?Q?L10Gl+5lWE0gAPgMSXyRUID/6OBT3QMH/I1q1GyMmZAO0zyyM/ew9N7rXsKy?=
 =?us-ascii?Q?lUvwjaH5qryDUACDDqM3NIvzLmbuDv3LI+OyHS71SrSmp/FYgFrsDMrzCl4u?=
 =?us-ascii?Q?MLaxpp9T3f4st+Pb91CaseetmVvMnO/svjZFTkhswgntuOgamnDp7U3FH7N2?=
 =?us-ascii?Q?GCk6vNljUAfDVeS3b0oQL3GJhtQCGhFJoxDlK9i0ZCWAzjul+IZTtQLH1Qxo?=
 =?us-ascii?Q?0OBw7PXS+LuRP7wgMw4PJBt5W2dOCSngVD3284f5zazD2/9lTWXIR8PiZxJk?=
 =?us-ascii?Q?c4PlicIeSBRoO/XD1L/f+QYrepMF62oc51IDIaG5rVwovAZeAYWBlZe4rl7C?=
 =?us-ascii?Q?cRi2uKR/rBbAXaOF9qK/O0nqQjKQ2UY0mWcfN0rHqyf9fC5eSChajtYtdXNo?=
 =?us-ascii?Q?VrMsqzI2x1hw0sQc+wK5e3YB3ch9ML95V9t2p0kz0UUyNgpnwGG605bibk2R?=
 =?us-ascii?Q?dayJ/39WeDdZ9KAR7yudiBs1/vJ4niwpJPAHtt9IvVySKO/wSDVhDDYc2sr2?=
 =?us-ascii?Q?jmEOGlC3NhrWLUZq2x+NvG0z/eZZg2BWQXOCifUemz1dXTfPhzc0xUA5B5iF?=
 =?us-ascii?Q?EdqKLUWcvC8pqqo4aht92aMR8pvjPvwgJZ7z8ruwMVViVnpiMNlvF0XpQOyS?=
 =?us-ascii?Q?e0l/ljivSSosUefMBTETJI7qeIq/OVkNTE86A4cAOcV8qfNn3RPRHLrnTWoR?=
 =?us-ascii?Q?T1oOaLqlqIlsKw3Zy6QO/lgTOPkFwQ9FeE5l7wAVUEYX5/07vJL6lscmEOTd?=
 =?us-ascii?Q?G4AkgbjYeHZlVdzXmmu8fKFh+SLBj6gEpojbi/159zdoA1siKl1Oc3FNvXOK?=
 =?us-ascii?Q?GU0KNWybmX/krj9+IU+yJBSl6Ty/VzxabmrP1++RF6sTRFihfe2ZWeMspItv?=
 =?us-ascii?Q?IkybPX0yGWhO7TfGf0Q+HT5DzL+yei2xZcbg8PYFupVSRHsKIYPDNpzjh69c?=
 =?us-ascii?Q?PyhHvQasklLpnWxRlemj1+oJ/iUWqtZiIQeeF34JuEtFLY1wVcawfL8uMoWd?=
 =?us-ascii?Q?MHa+op7RJSKv+sIl3pW1xVPwuf1DcWni?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9ygjAW7AjXbupg8tyLAUSkWKLj0wwgJxLpfTEzaubmSrHTYcN5sTQWzicOzR?=
 =?us-ascii?Q?W/uhP8no1SRrv91CLkY5aE5rDYW1k6GltfKG5GQVOALg09fWVnI+GJ/VnKRU?=
 =?us-ascii?Q?ouAwRoaBTov8srQtFACSMa4Y6kGQUc+kXVsSQ0lBQ8rC2/HeY4TrdEcaJLc2?=
 =?us-ascii?Q?OTmwQBXUt5gjXZRwgfYQr/vw2Nkj+bSVHBBl3dR3UtADACVhNaKP5QAsSdC7?=
 =?us-ascii?Q?FJ+q+nrlHCT+xwWVRLf+5S8Jdbj8oTLa0HTQwYfY7mH9KisJ9VyyFeDZSGsk?=
 =?us-ascii?Q?yc+qwD0AR85HtC1O7v8UOTVSQayuI8KABiCJhazy2viZVG1WIv3YjU49/gKK?=
 =?us-ascii?Q?pobnS9GIamMQKsZaVXR5m5l72HBx69psYMQdFwK/D6ORfNBHz9TTNy2GrQf/?=
 =?us-ascii?Q?VnDWNgZN6LRXMRb/Yk64rNhiFA+M8dmPVgFJnbhN3vfr6zGxgDSJ91jpUfSf?=
 =?us-ascii?Q?NPgUusDNyvrLcRejopcqUzKm7ZcHCK8Rq8GxsCzhqQDWQbWXOW/qgFUE/YH4?=
 =?us-ascii?Q?PlmuqXCDjzrwlYk+ZE8GUuUfDzdAybAD12+3tP06J4VFuAHqcwsj3wsQTOF9?=
 =?us-ascii?Q?bxO5JDn4nZIb+S2qngksn2lSBzYVZmL/a3YSiGwFnK65qFlGXDNkJn8jX7HV?=
 =?us-ascii?Q?gUAAfUU+DDFIkksdKY5deLxiOG+qMvicm2wJONtNUCGf1Jrzs2uvfpns8DYR?=
 =?us-ascii?Q?tyaJJG8/Gc8DRwbXNztjN7q1Qns3L4PbIEqOa6mfFOUJHQENz6kGylPj/MYA?=
 =?us-ascii?Q?KwbzchRF01xUR8MJRi2HTzzsqhhhSnBIdX6xH+VYBNjcNQBjJj7vS8rfxrHW?=
 =?us-ascii?Q?MBjzmuJ2qjqmBYraEtjwaJo7zla4nTZxbD3i5yCid2QhJ366ChK8U99EoqMU?=
 =?us-ascii?Q?n/X21ETF2PGQKqH171J7Fp5tVORkzrsK85v84lVoCQy0bJdnolf4wBx+OuWF?=
 =?us-ascii?Q?XK43NW9tGLyEMR6AgfYY43xEL0iscZVzdSPj8IBgkhdkQsTlKVZ+2vzD5fe5?=
 =?us-ascii?Q?oWzqMagw2HLJC6exYWNiGEggAaFDq0BAiorDueHxLy1B3JIcQWRJkNCsOb3X?=
 =?us-ascii?Q?b0GrEfpLGcYTgvQnRPTMR5MaDXTA6QxPuWL2sqA2kf872HmIrKQGcbwt45c+?=
 =?us-ascii?Q?FAGS9LkWelukv73X/8QYhLE4cljlBRmTbj1NgpXhmb1ZvtNDp7F+lWtxbGSo?=
 =?us-ascii?Q?3eDB5GoltD10IJhOCuSck/4Uekv4Lgizo7NAPYrNjUYzVWiDhgczjN3NH0Fz?=
 =?us-ascii?Q?OW71pNWoy0BURkixDUsXvxSKsfcbXxdWLJbL/9Rm0iYvBolPQng/oGbxMEb+?=
 =?us-ascii?Q?DswDFX32VUswiDpGWs5AVmiJlLzHbKJ6YKSx7gPWZ+z/e8jZBb4NX4z9wjay?=
 =?us-ascii?Q?m5WPYx1qMW78MEAsxv17fBt8yCIZzayxA15Y4zObTpNawYA+fMzjVDhaExbT?=
 =?us-ascii?Q?s6RRNLLGVhaYeQPzOlMhuke9TSj2F3w3emgJh6o7RpOUQvW3L5muvTyY8oZN?=
 =?us-ascii?Q?RfbpxxIQx9bjy5bDIKOJYFH+p2Yj6z9p643SLV8LXLCaRqk3/rZfnXSxDbtM?=
 =?us-ascii?Q?PC9LgEpEKm4AQxgDyDfWEgLahlzCC3XkRoTPv/GEhEDc/+TVZkmKuMHfZhYV?=
 =?us-ascii?Q?v0oFxdNJIm0G+B90O9vBd9w=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d5d87d-9935-4e0a-2419-08dd66cf26ea
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:16:45.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWcPccnRkinxuPXyhenJIIlhPX4ll8cBBMZp5PX6jDaGUVZFNfxHjbHw24PPoIfZjIGc+819a5k4OVcM484E8a/9mcUHatNpWaT3IyZPSyLjBxO9TITHs10UhkwS+wTb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18261

Dear All,

This series add support for RZ/G3E SCIF interface to linux-6.1.y-cip kernel=
.
SCIF interface in Renesas RZ/G3E is similar to the one available in RZ/G2L.
This series add also some fixes found during SoC bring up stage.

All patches are cherry-picked from mainline kernel.

base commit: 8da62141b20b (tag: v6.1.129-cip38, linux-cip/linux-6.1.y-cip)

Thanks & Regards,
Tommaso

Biju Das (1):
  dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif

Claudiu Beznea (4):
  serial: sh-sci: Check if TX data was written to device in .tx_empty()
  serial: sh-sci: Move runtime PM enable to sci_probe_single()
  serial: sh-sci: Clean sci_ports[0] after at earlycon exit
  serial: sh-sci: Increment the runtime usage counter for the earlycon
    device

Geert Uytterhoeven (1):
  serial: sh-sci: Use plain struct copy in early_console_setup()

Lad Prabhakar (5):
  dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
  dt-bindings: serial: renesas,scif: Validate 'interrupts' and
    'interrupt-names'
  dt-bindings: serial: renesas,scif: Make 'interrupt-names' property as
    required
  dt-bindings: serial: Add documentation for Renesas RZ/V2H(P)
    (R9A09G057) SCIF support
  serial: sh-sci: Add support for RZ/V2H(P) SoC

Wolfram Sang (1):
  serial: sh-sci: describe locking requirements for invalidating RXDMA

 .../bindings/serial/renesas,scif.yaml         | 141 +++++++++++----
 drivers/tty/serial/sh-sci.c                   | 160 +++++++++++++++---
 include/linux/serial_sci.h                    |   1 +
 3 files changed, 242 insertions(+), 60 deletions(-)

--=20
2.43.0



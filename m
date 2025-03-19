Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7717CC36000
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:10 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.71])
 by mx.groups.io with SMTP id smtpd.web10.4365.1742379425027528465
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:17:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OGHaFZxh;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=db1ZARHp4e7PxFCM/MPEDcXZwPw0OhQgG0oKki/93PvEXPPCai2Tp4c8mBTJ/9TONEcT/aOw7zw6OI1HSlbopq7GM1Fz3ck2V5IE92TYt4TB8NmRwouNvfery8X+KLpCv0Nn52zlGfkKF+3ERLtCVfgRYk5F2BQzJO1Y6J/zTFF/MPG+Z9uEdp773K7DlLpIFPShURY8OJnNff8nD5vkbCs0LRLbTyq5m+WRExtUBeqNmHgguq8q+Gc1OC2r/jC2wprgKxgLAFm3bqE7Xu2tbts58o4vUHapALCppk2FAjXkHVNUxzKzLKuKIVz3HS9IyhwyGt1jsv28ruaKyzaZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bregE3f/WQduKnMpDz9Hcd/JBlTPJZSjFb/tElRnBuM=;
 b=g7sijT7+Lecfh7Acrdr7EVohYQDmKTPK5IWUzTtaWRh8w+3q7Osb9c4RoNDmLrYnYweUzWjSxz7t6PwhWonxlURGF0AkL3IFsBq47BEsSnaJRw2nxz+JU6g4mi7TLO5FWqGdkCl7PffeSxxnljPwJ2zkvNnJO2k3kwnUdrga22QtQlYIag1igPPLbMlaerIHWUxVH8zJmIjzoUe4bgTekApMP+3wCWNZjbsSGnqxid65Wk6OJmuTC8JcXE9HcHAemfxfVjKabUeOXayKkd26vESA19iknTLGYHWg3oQvs/+u95BA1/uJ8N3MW69or1YyJl7XsbWVl19o9Mq3foD7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bregE3f/WQduKnMpDz9Hcd/JBlTPJZSjFb/tElRnBuM=;
 b=OGHaFZxh4R9/4bPUigiUeRiLZKiOeLmdIMBSMwrfAx4HQUxgzrG36OcSSsomJsiiDPoou49keABC2+FIoC3eIgxQtP8LbBQHmckbi59Hc/CWkGa/VajDVXCu7srA2QY/MMoOBLOQB1BphzXGyKZf2qBak9DBRQpMfLnqFstBX98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:17:03 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:17:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 06/12] serial: sh-sci: describe locking requirements for invalidating RXDMA
Date: Wed, 19 Mar 2025 11:16:23 +0100
Message-ID: <20250319101629.2407727-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f1bde8a1-f417-4bde-4e63-08dd66cf314a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WNfCXhK/r/LcGpgvXkrCx2Y3vxppjYvW917Y/vpW6dGVyL2PSL2VYTA4tqhr?=
 =?us-ascii?Q?MCCG1zxtscDH8yBHfjJ+OHCQ/g6H2EP9ZuZTkb7744Z9EgCNpK1k4irDn3/g?=
 =?us-ascii?Q?WzdueFMCqwl5sOxTj767tpfeOZSdRpwg8uzN/9iHGj92eP4NBn0vJeQcduFL?=
 =?us-ascii?Q?/dldc22GcR84lAcefHrPY5RaHqXJKzE8owv1ScczNAGmWSeD+9zPBjndvwWC?=
 =?us-ascii?Q?NxhU0XTw4Y7pASu5AYEhRpMgDaweyk5JY7DPItiiXmaD8zfJP23TQxzhM26h?=
 =?us-ascii?Q?97Ou/siKcjM38LWtWPmT8QSZu0vud31oWu4vvRsjLee9nYia5wuIIoATgVhv?=
 =?us-ascii?Q?PEAOhFn69Nq2AJPXbJRDHtvqWSFdm1Tj1BKZRLSFJijIz2R9z5nyhLMBLAB2?=
 =?us-ascii?Q?xlzTwX0nsiuuO8Gh8Ty7RzJ5B4pok+qE3qXhVvwVuvDaHVNgcqGYzFNPMc/4?=
 =?us-ascii?Q?cxGmBiDdkSnbzVRfpmRprnUpV6XStIatBJdJJd6IcH3iAlrriE6kdYnJ5Czn?=
 =?us-ascii?Q?zTmyPjtRRRndrXm3GA0AEobrSkt4L6VPD9ojMkc44RR//sYIJRw374jwI4sh?=
 =?us-ascii?Q?yHgqsqFewJXkmOOt2R5z9tJqHy1LWivSiyulb1EMzAIwOG4uHsSzhQa7z8+j?=
 =?us-ascii?Q?ZGlaDNgK18msHjoREdI6cOa974I+jE+xrN7e8H8ExEwbJAqpyPg/j9YayIH6?=
 =?us-ascii?Q?TJNJmIdTSHGw+nOH7kyHCbHNLjjx4CQOzwm17MEW4iSTJF1ZBoDQygHu7WTo?=
 =?us-ascii?Q?Gau7idhoE6mpC5aQqrBx8VJ4+B4A7hbUystmGxYKgif2Enl13+YJi7/GLLt7?=
 =?us-ascii?Q?pcK7+Ld9+8wH8iHJbJwmc1/ol2EbR2TncxUoVtJxv/Py05No3bkbeYfcBaYO?=
 =?us-ascii?Q?E1uawZUhoULm36aeIT/yQOOWTY62wMjHT5Iu/oW/WWWCDypFEVO0DC4nOwuA?=
 =?us-ascii?Q?UTf3b3nJmu0pyFG8xatRBq1oCq70ybQK4RVakyI3cMfkC3esYP8EJEK7JMqA?=
 =?us-ascii?Q?ES1/3ScCOVQ4dJ5uVYHKu3o+FbwWu7B1jfWIHgCU0B9FoVlUp1ApKh2f4eE1?=
 =?us-ascii?Q?FFuKyTGJpmvFouXI2INUjLpQc8ZzjFahGxIKSWOJWc86k+x0XQnFHHNV3Zm/?=
 =?us-ascii?Q?JKtDHu87SiBbVLBiX3Iguoo6XqgL02+jZW9pfNzj9sVpGTzEYYWumYHjTjN2?=
 =?us-ascii?Q?5M2LlPL++fiKZqknskms9zVRZmTlUeX6LsqpRFekjjp+REZPRnQMGO1FW7hA?=
 =?us-ascii?Q?2LwSg1gD1W0jwjcs3sYH/6H15V9km+G585xv0nZ18scdG8FIezL00gxiYI8x?=
 =?us-ascii?Q?EaZKVMjPCo0EPEe0+DUdlTR1X/0kRgUZeVO4whlustK0Q1vRGeuxJ+4j3nXu?=
 =?us-ascii?Q?iEcbJYbzeIs3+3mktGa6gTwYpWBBpGpVu53l3tUMeMpd8dB9Oty2kn7OvkK9?=
 =?us-ascii?Q?vnPvkRw/N8aFk6ond1jJL7B5e+Z8t/Fo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qrJmitqQyhomoUETKVcwk+rq2I6FSiyIGXzxGVBax2Yymmy+KN2FstsDVFrK?=
 =?us-ascii?Q?3lN91hbYP4xlMMJvPAYGn52x0/aQt9j1FpcNUwDDhK+HDTZTDPKPnkM3tQzc?=
 =?us-ascii?Q?r4QFuHumEwsWHiwYfIG3Qa+4HRzJudF88ZE/04mY33ZkkHSzzr75ElPHGgn8?=
 =?us-ascii?Q?H/GsKAOY9821naXnL7TMYoctPorHGxqbSzkt7L0Nh/78LHPxdK1Nxql9ZnPi?=
 =?us-ascii?Q?fPnhP/1MuNf5Vi8Qr65Sy85NJPfcBUoTZFTZJlpyQy8BUx/LdPITzghEGj7l?=
 =?us-ascii?Q?59HZt6tNn70OcL6kshKE3LFZbyeTUJrZP8BfWp1EzAgflHswSf3xMVFyOySo?=
 =?us-ascii?Q?UeQXBIBVlWs3v2OIfAEbd7ijdM1+DagTzenkLfNyDKV4xAwGS+rnfU6srEUZ?=
 =?us-ascii?Q?tpniDbuAJB9t3HzuNfiuvbN7KGnzeG/1mKzRY+S3qATcG8qFMZmTvbJR+kfM?=
 =?us-ascii?Q?Admzz7pNmU5z9Pv87MTTJuIYcj9h96jWIRkrXhc3idZKIapXHuUqOqWwKCmj?=
 =?us-ascii?Q?04h2gFgn1iSWYEU9kehHo99Fzp7df2n5m6VCVmBtvfBeFkFg3Cex1u5R5mnX?=
 =?us-ascii?Q?HSrHbpR64Uh8DCFj9AH8bWmkEClNnRROdjOvwoxDCBKmQU/5QbvJgnXUL4Z3?=
 =?us-ascii?Q?HqDL4cbRy3k+mOO3D8tRrf6w5kmmZricYo+cUsL4MxXO/eS37fXjQWERlKme?=
 =?us-ascii?Q?NDhwfYTskJcq781LkMF5sy4zNe2g4ko9G50ZM3nD2BJrKnGbAU1topk+JMjj?=
 =?us-ascii?Q?7vsQ7isekWK2Ahx3tk88FsnbW7TQKM0Qbh9TRDE11dv0ivn1XIlARYxywkH8?=
 =?us-ascii?Q?Ukl6LLPeXUVGc8Frj0Ek3JhnKzxk68toKdXYlRrLNOlTfrIdep0FV1ilMUC4?=
 =?us-ascii?Q?Ciz0fl6QZwxis0yNQJ45GHLiciEBpNLx5f4C2MB+6PD5fA6zRY6XjDf5A0xS?=
 =?us-ascii?Q?fl8V34dJ/il8o9FRVa4pVfTluhZTL0vUXA1GukFvpy2Fua56jDyQrKq/QcDP?=
 =?us-ascii?Q?aUf39h+nxYXrv2Jb3p8fHvLky/F0pncQSvzWPrZXxqrasyhgWIe6UXBFQl7r?=
 =?us-ascii?Q?N7ypvBbDMEb44UGciyYpKXf4B0+Vc7kXth7P7PyiRLNxua3l8cyKJSy0BlOc?=
 =?us-ascii?Q?k22C5W0zE599Ij4Un6BUfGF6t6+KR3W6pv7vYCSbH2Je3dE5IPreDfBwQoQq?=
 =?us-ascii?Q?DbWseelOTVB7FE97scrRxF2yriKdg1X7pzjkQNlUYP7cPGX5tBr94iMJu0Gn?=
 =?us-ascii?Q?61QhpaXYHCSyLuXoL3zhSjWGR3X4Y0vC8+cTIcrYxQp1NZzjF/BsezSaQpXL?=
 =?us-ascii?Q?xuZBR06TZI9GGhMEMtpT+dv7QCXRPiTty2olxaR9AdZVENHETXYPD8Oofiut?=
 =?us-ascii?Q?5LsugIHAFvwwA7Zps8AiAtaTH7LiW5skehuov/FsEjCoecjCE8fuXhERqZzd?=
 =?us-ascii?Q?d8Jhr68OSEnpXKW2nIzJVqbBJ9vWwLnzcOtU/T987SFwTtR9691jr+wHGgcU?=
 =?us-ascii?Q?NNVn37jj+s4YWdigkzs8PEjQSahPol2CEw74F1PWuLdDR/H8hJVNIFwC7O9S?=
 =?us-ascii?Q?Q1AE42KvLUxY5hLb/qJFyzHhr1cP6ONXB9M5FNY2wCOpvtgJZLBacYc3/6XK?=
 =?us-ascii?Q?n8cePolESiA45XPtws+Pfu0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bde8a1-f417-4bde-4e63-08dd66cf314a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:17:03.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o2nZ+5jUf36ShB9BjcHRWoUTVnMTixCis/Qt45uYhaMVWb43Xjaz2uLC0eZH3NHaltDZ3W5r5ZADvy0X07tH3eCemBCmNOj/jwg6JBFkrDRI9D/ABCxrZLHKQJJoPKJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18267

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 8efc440549087de41abadf62f4bde1d827135338 upstream.

Make sure everyone knows that calling this function needs protection.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240506114016.30498-8-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

 drivers/tty/serial/sh-sci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 69f8ac561513..7c93c9a1079b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1264,6 +1264,7 @@ static int sci_dma_rx_find_active(struct sci_port *s)
 	return -1;
 }
=20
+/* Must only be called with uart_port_lock taken */
 static void sci_dma_rx_chan_invalidate(struct sci_port *s)
 {
 	unsigned int i;
--=20
2.43.0



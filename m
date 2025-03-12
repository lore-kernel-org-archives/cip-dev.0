Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F471C35FFB
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.50])
 by mx.groups.io with SMTP id smtpd.web11.34870.1741778823167942183
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Mxa0J9lM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIQTe5N4qZdNlrT60R2/2udDpaX1lFplyTGU/7+luQGZei+EROTEXk9Ar9lsjxa5RuorKaWo7Lgqokdu0Yze35WRgYF8DOwA4Ytv5qH7VF571n53Jmz5JXzf1d3Wu/4lAtVTdN9knDg9mMzCPiy6qCxy3s49LTAIk32cUU6NY2/fwFBwBO4nWPU7CuUNsBSWI8WqkQf9Ccd25ZRV3apdbsqV3NJEiNMqsM6U/v0C7TAbmolJlv2P94hZnLmR/neolhQ4mslACbkBPV92jVpbwWpfcMg6jkPjs/ijTQD8sE/SZ7rg9SFyIz6JrTYUNH/TuBZovtsavmv+fUPcQmskCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UreD2GRMIY/E6oKAoZDWv4UjfE/YKBOrtl6mhcrGbw0=;
 b=ajAFjmReq09/cQmIaBVUCetUmO0bV9Q73XCn6mcLBw00S1XlAy+TtNMeCPqA0o/Db/07XrxC+SpBoZzJdYc6qSbP7fbBtmUQq0AaThlkQvKH3TtDSP5wdjFjaKm0TUXcxcicMDTPjuaXel8V7bYUJbodDHzzbZhQP20Wocz5+kuJ5AduSTtFKO+fWeYzqxmo3oPpOw6v+Mde17D1x7FyrXRCcSUoPeXF3zujQra6LCPlRDsxgEegMG+IibV3S2GZlItQDLLt6L+5qkBmwP538zNtDeZ1wQhB67WjmW09HoU1UXZes+du9bSH0u2XOSKrvUOv4HmYcZDTz0MJskECsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UreD2GRMIY/E6oKAoZDWv4UjfE/YKBOrtl6mhcrGbw0=;
 b=Mxa0J9lMKoTYelCT/6jv/eSP93SJ7u4vKdIhCiH6z12EMAzP1Ngbh16hIxu0FUYIJzPD5rq2fH/YSFiZlJtMsdOJLzlQeF0NteIpRCCpzx2XEnSfkxn/ClTOUNzsBRG4hhXeXHjnxMvPWUm9fR7bOE/Pj+K/g4v38s1tJB+bqFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:01 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 70/85] serial: sh-sci: describe locking requirements for invalidating RXDMA
Date: Wed, 12 Mar 2025 12:22:47 +0100
Message-ID: <20250312112302.1605750-71-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5997a1-d3dd-4812-b396-08dd6158ceb7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fEM8oq4eYQZIOStl1dYyIOBPlAVrk28vUhj2vuD5k6XZ4tkYfdTYv+p3BiFR?=
 =?us-ascii?Q?9TwgrH5snnDDiOAk4IqTUE0EgpOaZXMGCTHrYZrN8JoQgvV3yNpGSuOkyeCe?=
 =?us-ascii?Q?FtOVfnSjDI2iTL+ngKXKNHVQGhQyRKv8uKJ3/DS0UJ8vKtCwlZfdmOQw1sn5?=
 =?us-ascii?Q?MDJewE1IC0nZOlROAAH7xG0jCH2zJml73BSvIL5svtSROzg5TxS+HlWHer3T?=
 =?us-ascii?Q?RFBwRUotozLS9vqt9jSYgvCD+2OmelFFL62IOenAcRh0heWnSVMjJBPkvjLy?=
 =?us-ascii?Q?rMJYlKZ/wvaVEvTiQD3p9WJgNrZbfK8e2YbjOxJ4Sxo+bOjJ3rJ2vE/dtln5?=
 =?us-ascii?Q?UImK9Qz5+wQ7lEa82xVtcS3fnaePPLCA17HSYOS5s5Pd53Ojr5mCr+5v2HJc?=
 =?us-ascii?Q?wQJDLIa0RvrXClan8CxWSEOk9mKutr63GE8/K4K6SHdBESjPO3UtbhnQB7d8?=
 =?us-ascii?Q?phjKG806s60b71ht3PH048GRlNgYzpR7am9SH4MDYAHKId/keOc701O3EYDd?=
 =?us-ascii?Q?ET0Y3pttuaNI0Vf8SrXPp1J5fpjDpiR1o9phQ/DXcNM5CVKS5QhzVd8iU80f?=
 =?us-ascii?Q?55yOhaOTec7NKYtBHRxt3OQpIHN7gy4yNSS7e3PNvuP3BnS5Q2qucC/ZeWBI?=
 =?us-ascii?Q?aF8HwkuT1mV2vU7p1PPdEJOn0MpZ3uw0X/xxYzu7wzyr2PcYy8Ew4iUglMO2?=
 =?us-ascii?Q?UyNqccY0HeulTPg95xEULVH9ZZMM8utDHmjNEm8LPLkY8hXWvpCyQ13YHOqP?=
 =?us-ascii?Q?HIFIM14ghsbbidls81AaXickmNJ8hj4B/Pyyj9+TTPBOYcsNfOqo339DoAxT?=
 =?us-ascii?Q?94DJWRqa3U2RJhAZe+tw09K55Rwf0Vdm8ZNr75nPYCXNMXhUhl1JZ1682dlC?=
 =?us-ascii?Q?REFcHcmUUt+G1+VqGUyXAmCOIBTLPWuV4AUJlm3T2NV50DB+4mf9rVe7zuDR?=
 =?us-ascii?Q?tSnQgoMpuv75gBpqqjbLBYq7dgtjv5/8oiHp3G9BV2KxTwIAQnARb6ZWZoAt?=
 =?us-ascii?Q?g1yPqBUajGA4lHu+0VLHjI5Mk0CABfx97/2yBR15KWzNywzhGVAeQFRIylKp?=
 =?us-ascii?Q?JsEpU+0rn5zWusaD+MAFXBYTaUOxR57e7uOytC9drPsxi1llEkdSSpJ8liCW?=
 =?us-ascii?Q?vSvz0rsai2/wmbpm5rtGmTW4I/FRq7q8W0tOGsk+eEWR+4+aKpH3cluRcWOg?=
 =?us-ascii?Q?MAmRjzbzJz7loSaiqbLRwQPbzRBcOJg3kXAY6NWpZI6PlnTsAS1romXBr3wQ?=
 =?us-ascii?Q?v36JHzrotYC2K58viSAs6DxnVwd03FnLCNARJbVG2u59dcFNwsvSV2Cmjss+?=
 =?us-ascii?Q?5WI9nRN27pjTaLihv/XiarKNeizDK0L3mhaNdZUXKj2amh751D+yCxAHYKMy?=
 =?us-ascii?Q?V5UNfLZ63W3pt5PhwkLnFjf3ltqIjFOOmXMWuSPxqepacAXaTHwf+DSoEX/L?=
 =?us-ascii?Q?6a0hz6iWrHHqYT6SNwVKfcHAMPz+5Vb3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YKOYzRADu7I8+xPS9Ida/X+N90lz/nQJu7jRQ2BwEf01Fkn8sXDvBdo1P2Dh?=
 =?us-ascii?Q?yPxbrqdsgEeAIDSlMp+zCGXiKrwGP3noZM/TX0rXHCLdf/U344gvcqzqynG2?=
 =?us-ascii?Q?3vlLcWLjmwGPCqqSaC+khTgSWmn6X8THVE2p07rUnKBxHCBf3SIDf89kZNLU?=
 =?us-ascii?Q?TMc6G2BnliusYdzEqB7+E6zgV30QGT4pChG1F74ACiNSB2wv0IlbUIcNIn0q?=
 =?us-ascii?Q?2u/vxyFqe0laFOMu3C0YD/LT1E8nLrSamt2dqyKBp43Xgwo6W39OXcbBU9WL?=
 =?us-ascii?Q?uovrkHqYtCOJJB0XQ637SfonRcRyvevkzgzPLnu21egMHZ1PmkEIfEe3j4HI?=
 =?us-ascii?Q?xpSENkNIDfiNg5hs/uLcOr9eDfpW6PzGuqynG5gVViFg0v8bbHJXB0Gngm0n?=
 =?us-ascii?Q?EAxedOwFmfhxYLiJJSgcevTlOeW1fA84H3a3DIaayvPDnIqSjq+s3VMsds7H?=
 =?us-ascii?Q?Dsiy/kOqYTxwWEBYc+GD8iRw6zZSgU2dhglOKajMiCecU3/muN0q01ym4h1S?=
 =?us-ascii?Q?T4wJW7veUyQsZGG26vzPfz86jFzzLXYIK5BHLUPHGp4fCgGr44j114mhrQdk?=
 =?us-ascii?Q?MYpslfr1jxZxzxEwJRYRz5LZ1QjEfvZ9u3qdcMs+LKvctjdhpBqFN+VLDWHB?=
 =?us-ascii?Q?45tVKOv6kl10Eyg5dosEk//tfvUsYdj2cEdE5QCKachJc/pf9NWx5kpm3MDl?=
 =?us-ascii?Q?8qdiHYzExXjmUUABPW/vE1so4ESNFNGa8QqMLgnecotemch89FEYstFo26hS?=
 =?us-ascii?Q?a81StlW73ZLFSIcPZCTMwtetTRBneg7Sj11aEGj2dnNcH0/L2LEG2e12FxZs?=
 =?us-ascii?Q?jCwQNrk9Jp3VxTdrwFiWgrR5p1Yl1KSjmRtljI+vi25LC7MvTd7UBibBSWKC?=
 =?us-ascii?Q?Ehwj+mZOI1H3YuNl7o/MQjCWI3hVDPv8HOHJiubW++8sAaA0gfSWkdp4JvXQ?=
 =?us-ascii?Q?TbLlWKKX8XVCBbi5hGn4YyHNI8ZQc/MEkGhq/ao1e2nKBzxTr8nEyfZ3xYhS?=
 =?us-ascii?Q?7ijLljdcObbaIC77Vy7MW9q+AsqA96O1Z938itiZc5QzisIhOmwQ8fMJgeSb?=
 =?us-ascii?Q?qSzqYpsizEb3VXrx7fcbeoTEYmmNSHMOJ10Oc/u28lDk0YSi250uduy/7lIW?=
 =?us-ascii?Q?Om/XEGLaWRIGCNPPHi/E1SkWIgIK6MYya2Wch2GyYFTfpva2nhmGZjykay5U?=
 =?us-ascii?Q?qOcEeAdDEydbEoOJE+nhE0y4keseNpPTLca5//HSL374/gECA3f2rOVOgRvR?=
 =?us-ascii?Q?XAOlqKe2tgoua4NsKFgNFYR3UeWDUVzapHwDOVq8DVpHbgmD1Zc7ePIuscei?=
 =?us-ascii?Q?Q7bOtj5+ktaFt7KJNkRtd7d8X/NisVLpg35/RYjKjRq14HWNIw7fSlgKmpWd?=
 =?us-ascii?Q?mUP4ch6KezMhB5QqSBVebLQLZuomveMr7d8EBL117layeSCZg9OqLv6y/Gw/?=
 =?us-ascii?Q?iBCj/Hss6O24uEt6jLrzNjkLqppdHLnNeZ2M9Wl58pa3HIDziPzvKRmc6oLp?=
 =?us-ascii?Q?LgyQZkGfXwv08V6ElZOJiPfcLDxbU2xbotXPRyMDYYTC6SYsgn0pGiufWggZ?=
 =?us-ascii?Q?47Cjgv0i5SiFd51VxvjTKoaLAeUj/LuenzxwLO6oWHghOqVQbbPnRuTQ7EC/?=
 =?us-ascii?Q?avtIEZYU+M488V3LSXzkGmk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5997a1-d3dd-4812-b396-08dd6158ceb7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:01.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lg8/CFau4jEwVMjN2gmUEc9zcs5ubXUbvvQSYO0W4Od164VEc76pY7HWackjceqHvQW3lJsBGouGSSmwxXZwcYYzREuXfLFZPW2TsuM8jWa4AEpb2nfwGqGPTFw3TVub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18162

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 8efc440549087de41abadf62f4bde1d827135338 upstream.

Make sure everyone knows that calling this function needs protection.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240506114016.30498-8-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
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



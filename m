Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EECA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:23 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.57])
 by mx.groups.io with SMTP id smtpd.web10.981.1755705977281587998
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=oeKHCSRJ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySTURn5nYZ++gyDWoPpIEKChIER2utK8o3d/vi3YoaZaMuOJ06OiC1K/CpdLP66qQYQHK2sxV2BPbwWOizHYILmlySw0EhG7e6uEO6n7VSNTl2za8eMTz7JiN2Z0yL1YmGWEzi+DUxxRdQXc4p//L6WWPgRENLrd/QKBTyFXTHFaSur1AJAz86sWxBovP9OmcCNVbqsmsxmedLrtPez+Cl/Oo50uIrcI9jkun0ywHzKwEPGMoE0G0s5FNfW4cyPfrdniGvRLgEflLjWgRbNQj+g5lqh1jU3qoGC64R8RgYk7/zcy7VseSVO371SpI3pSV8nrOmTDlh8MPAG5Lxewsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhFClFbFnCUMGMoJvFnHqknueImNs6Hpypezc3nfDGg=;
 b=SC6w6wu0WSVj6k5oQYMtUa6MXS/fdK6CJ0cdsi4jOZx01KBgJqig4HN3qIGDmDL8Qvi9QYR/scPgl63ti6+SaUWCU98uwWHJkmHEpHu599rA7ZcYlO4oVShNyrZ5rYl5HiI2hiHflM4eotM4MUCv5QOyed/ICBeasguRKOjeEfBZ00V414eNRlWTka6WpbYQkd8mkI4E9/R2CMShOxlD6O0Bsr4rh+FUJO+AqhKrH/TFKbE1APoM48RbHnq5ErxRWE9uHI42RvXVnpx38pJVhV/e+mJgBqQJCX6Z6mrLF9Ay4bThVDpE0WvbkEIum+BUjclCJ4s5rKe5zDKx9U1DPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhFClFbFnCUMGMoJvFnHqknueImNs6Hpypezc3nfDGg=;
 b=oeKHCSRJSkEhnBpZcjrJLpg6axShzPXdzWbWkBnw1WcCvQKuiMQt+7Ds/HfjEVMCPewmD394js3ySdWrjiG3SOeSbogUGR66YywycfaRVM1QWsRczMZ7LBOXNeoKHsZQYzY4peX4A2WOcuwDIXVqEoAevTNLywNw1EVX2BAPJis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:06:15 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 38/55] media: rzg2l-cru: Pass resolution limits via OF data
Date: Wed, 20 Aug 2025 18:03:54 +0200
Message-ID: <20250820160413.801341-39-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: 528215a2-2417-4f93-ef8a-08dde0037d8d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yrNxdJYFkuxhF0Jejz0CvwY7CR4DFMVDTyekRdff9XSjYKMwFl5wjHMdBDEU?=
 =?us-ascii?Q?wSh7H9acSJj/UGryyYi8EnTfOfNtdq214MlnIffgvM4FvS9TKSozjNyD966O?=
 =?us-ascii?Q?ovg2CO8Wnx6PjMf8oaOEdyxOkvjP41tSBJXwiJZ8j1bY1MHsl7UPY7MqlX7k?=
 =?us-ascii?Q?h1cgOTEmlv99Njb8WU3XVf0sDV6iCJ8nbEtB+T9KOJoqyv42oJsxJ9Mkp4jS?=
 =?us-ascii?Q?6lzCbubvJMuwWx1FvDE9+HnMdrmYkpBBOEy1qt5KpXf1WVNVTQ1UQdO/2iAE?=
 =?us-ascii?Q?v1mCE5Bk86YXLVOBEZ0Mr2McvzLhKJ7kUCWLkORQ4eVekLiD9jFLxLjxw0vF?=
 =?us-ascii?Q?zuJWqqG6of3IkCJIncvIkd+HG2+zW/VLBfL99HClHrDhDEjro6tJdrNvF6ql?=
 =?us-ascii?Q?eLEcTzt+9QFlNZvUMA1/w572MbK7os9u1bJkmcdGIWFstGbQ0vn40iPS+nJ9?=
 =?us-ascii?Q?iUdo0ENbiUamr8fJKwsyXLI3YWZyP/xh+F3hKY7MtMt2d1I3mv6OJecFK0Mo?=
 =?us-ascii?Q?ss8V2hhbe26yVfp+q527Uds6rZKwrdBBL0jwX/bMziCvQewMDIl5MyyVmT/X?=
 =?us-ascii?Q?ZK1DZLBBhtNQIpFREO1KkG1psvUe5f7z8dR/jgv3m+EfKRSQrVNqCNTRjZO8?=
 =?us-ascii?Q?KPXTdiVwpZKf28GvGW/GN5FCX4p4Fn4bWMFju7JUkJs2yJQgho4RAiaADYGs?=
 =?us-ascii?Q?HcAfYQqxxOsIPyh+l8vG8uNTBdIbIi+l2rN3MbOvSMsWyFFIktFt4j3yJjoX?=
 =?us-ascii?Q?XAPKaXVP1hTRc1Hop67Jkv3cFUK3le6PmahTocAa8JU4mLDFaVcm5Yg55TVL?=
 =?us-ascii?Q?mrikbZEJwN8BL3dmvw5ITe8oibxkFm4y65RMSZ89o6ilBUDhf70NGbqpysVC?=
 =?us-ascii?Q?aFEEfwEM6+T0umF38ZAndb0YLPSUhD3sSwrq6GbyJKz5xbbw166O/q/5dAXm?=
 =?us-ascii?Q?Iyt0rQTbH6fm7W6rkpmQ8V9ZEJY6zEd38ksxFY9vg5mIvZZfsMxEkYjhfK1j?=
 =?us-ascii?Q?BCN2AtxNRrNiozmiv2NJJ+peyajPyk2ecNgPGWweGjikY5aIpbzCb5xOkMu8?=
 =?us-ascii?Q?APwqTUarZUbkPzT5WhwrcVK0NliNLROQO/KV56glLyhtquDRWqZbjbrl+/M1?=
 =?us-ascii?Q?PtBcVG3FEpNGuJ0iqKztODvqZ51QCMHem6Ec7z1artoPbDZM1wE0jmgZQzjD?=
 =?us-ascii?Q?GZ+/uyRt89Yzwijr1poWu+tjXVWTcq9UNbEr3cw8O86ZXvxydE0oTtDMadEH?=
 =?us-ascii?Q?B7Mq0iWKcMyndCjAXtImgvrL27as3Yxr0nLKQT8J9Gh9VSxNnUalFamEGffs?=
 =?us-ascii?Q?3ziDtrtmTRjWmTmwAdf5nh7jfzqMFuRiPLnJbZQ9QY2WZJZAPzh74OBUObgI?=
 =?us-ascii?Q?Fw7mosny69167qCim6fUBON1+DEdEYoSs0KNMYpGWJrMCuGiMvqAz8FTJEtf?=
 =?us-ascii?Q?1hMX5Qg2yPI+njISZHC+P1ymxqWTKTBry3+EAhx3YwgmJE8w6RuPAALZU5jb?=
 =?us-ascii?Q?3mtu/6J/qCs+uMs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Q8+7HEw3KxLKalYSl0d+wY9s2YFEVdTdzo/R9H8XvtPrujdkezsOwrq7LJWV?=
 =?us-ascii?Q?KtgYeOGj39DRZatgvAZfvUESnk5v/w+Z9XeCtw7gAH9nsAjmMTr8Jj96+OYT?=
 =?us-ascii?Q?zXa443vc3EYkR1kf0a8iy2S51Vzngca1KMw7z9bGxKmUHjDGSh9oIuev5T5i?=
 =?us-ascii?Q?p9CJV8QBH+37L24zmoQVYllcdCwG0vVbXIrDMS7WsKBVsC8pZqN2ofcIJqTU?=
 =?us-ascii?Q?eFZcts0POTG5zB8V1ukWQuDpMN7S4LoD3FLW6cs2oV0b13fN6w2j6NXTq+NK?=
 =?us-ascii?Q?m+DmVz7LdCsgkGPqtDCGbQgW2vLvybJMg+fyqbhoTPxvyEe6sMToNYqxExzn?=
 =?us-ascii?Q?RYMTDnrxmlNjG0IU8WCH3LaZ7ECVuf4ru7MovMv6kJFIB7xKhnU79YIQPqE/?=
 =?us-ascii?Q?7BNNfTCUALC9Hr9Yizk/N7Rh++R7z7lx9B0BPrs0wIDUHRwzTcLRtAB0d4j3?=
 =?us-ascii?Q?w6ygjtDvalAvdC2+nupnZ4ojo2bap6pnY3Y1NaAWA1fEI+OYNZVzxtxaBNc9?=
 =?us-ascii?Q?KhmmxHIjPlqOlBYfN8WkwDOiP7VOUp5WYsknZ858+Se+XWvC2E5al9olF5Sc?=
 =?us-ascii?Q?NWWsaB4YH87OE506gasPQpImPzODXF79p0PKJxqO9UdR6/8tlMD0qlB+R2pz?=
 =?us-ascii?Q?LlpXLLbwGL6lS5avyY+d19GzxLBKf0jzNt3lyrrGyV7SQtG4Iw32RG4nR0AS?=
 =?us-ascii?Q?JO7uGnDTKDvuhp+IPayZEeDQ/U0I/izpJjYegXqKmlFm1dvE0OEaTNz3xjyJ?=
 =?us-ascii?Q?8NcxyzNFbgLrz8qYFj2379hcmDDLSfbHlJIulT1MA2PybLwjaSkYu3L8wNt8?=
 =?us-ascii?Q?WYny5M+1YxhnRILnBXxkYCzf3ZLaww4pGOY7naI8S11EzUguqJ+nTeeXh55q?=
 =?us-ascii?Q?oxC5yuac/Um5yytLiH1hGNpHZEeYD7zIuJgxMPHMZmqeTN3Rq9UMvuQkJdrB?=
 =?us-ascii?Q?yEe8pyVbNqo7w4LfQSL5F3qK00BNbBHfD+GcwqRoppyAN5lyt4mcIp6BJ7MR?=
 =?us-ascii?Q?4/As44GGLFHcNz2NZrH8LmDt3QKGBkyeOzqoNnyqYMSUW3oicbSybsPBxF6P?=
 =?us-ascii?Q?eUtBT+mO27ySSDe00IwPUwHZ6kZ4E/qqhZMm1ZpBjZWX18HijOlMeaTsOYrV?=
 =?us-ascii?Q?2K94glosJp2/RcLrTzryDA/odvnyXhEb7fc0MgpLWNFK26tmElUbDAnl2mcf?=
 =?us-ascii?Q?KGPxIi+1fpjJ/g7o9qpaReSEmsLC4np+drpdjcBk5qQK6HRKb65b+881gWQR?=
 =?us-ascii?Q?BPHUa19npM1Q1P3SwNnGlbbbnClyL2nvNt49zr+IKnuSvQXu3h1xhOFFmfgL?=
 =?us-ascii?Q?B1N3z1Iawn5zWnfxP3tWuIZWWOe6NDVC5tEhvCTzLJ+hnkgPDb+ByKMf2Rre?=
 =?us-ascii?Q?9uh28NrsTHD98zioBTDvuxWMmQlWxaY2294XBHC5ohmEEnuqzh+IwpC7cNTp?=
 =?us-ascii?Q?2ZvpeDF6X5am3IJSIswQoKq8RElTug8cC7cMFLCM/VDPUdqupU+AoIBGCMkc?=
 =?us-ascii?Q?ycFeVg/n2pdYRhfG+qBSZRm24zUtx6inQ8Vubt+/d5tcTUo/IryZiVUeiTi0?=
 =?us-ascii?Q?tQu5V6iMRZF41zVEKiOHBa/vhTGx6/wbb6IJPOrA89wvey47/vp5GYoCnVrX?=
 =?us-ascii?Q?BpvGmWkqvcn0adAA307qesw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528215a2-2417-4f93-ef8a-08dde0037d8d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:15.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pN3jj7hcGvOTpCppJducx21WtYMud7P/vuLg18MCtvUjmpkuNVQgW7U3ik9Vo352ZlktFse0h2hj8/zGaS+xSZo79/DPrDvQKzH3y+/fHvX7941on2IqscBjOkDUYgPe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19863

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5f5ed645b31b3e0bbd1a1597cdb41c467f3c7776 upstream.

Pass `max_width` and `max_height` as part of the OF data to facilitate the
addition of support for RZ/G3E and RZ/V2H(P) SoCs. These SoCs have a
maximum resolution of 4096x4096 as compared to 2800x4095 on RZ/G2L SoC.
This change prepares the driver for easier integration of these SoCs by
defining the resolution limits in the `rzg2l_cru_info` structure.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-13-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-core.c   |  2 ++
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h    |  4 ++--
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c | 13 +++++++++----
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c  |  5 +++--
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 3e71e2939dea..f7c9eb040bd8 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -355,6 +355,8 @@ static const u16 rzg2l_cru_regs[] =3D {
 };
=20
 static const struct rzg2l_cru_info rzgl2_cru_info =3D {
+	.max_width =3D 2800,
+	.max_height =3D 4095,
 	.regs =3D rzg2l_cru_regs,
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 497702d350eb..764d109b253c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -27,9 +27,7 @@
 #define RZG2L_CRU_CSI2_VCHANNEL		4
=20
 #define RZG2L_CRU_MIN_INPUT_WIDTH	320
-#define RZG2L_CRU_MAX_INPUT_WIDTH	2800
 #define RZG2L_CRU_MIN_INPUT_HEIGHT	240
-#define RZG2L_CRU_MAX_INPUT_HEIGHT	4095
=20
 enum rzg2l_csi2_pads {
 	RZG2L_CRU_IP_SINK =3D 0,
@@ -81,6 +79,8 @@ struct rzg2l_cru_ip_format {
 };
=20
 struct rzg2l_cru_info {
+	unsigned int max_width;
+	unsigned int max_height;
 	const u16 *regs;
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 4094a480db21..0bbe31245df0 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -148,6 +148,8 @@ static int rzg2l_cru_ip_set_format(struct v4l2_subdev *=
sd,
 				   struct v4l2_subdev_state *state,
 				   struct v4l2_subdev_format *fmt)
 {
+	struct rzg2l_cru_dev *cru =3D v4l2_get_subdevdata(sd);
+	const struct rzg2l_cru_info *info =3D cru->info;
 	struct v4l2_mbus_framefmt *src_format;
 	struct v4l2_mbus_framefmt *sink_format;
=20
@@ -170,9 +172,9 @@ static int rzg2l_cru_ip_set_format(struct v4l2_subdev *=
sd,
 	sink_format->ycbcr_enc =3D fmt->format.ycbcr_enc;
 	sink_format->quantization =3D fmt->format.quantization;
 	sink_format->width =3D clamp_t(u32, fmt->format.width,
-				     RZG2L_CRU_MIN_INPUT_WIDTH, RZG2L_CRU_MAX_INPUT_WIDTH);
+				     RZG2L_CRU_MIN_INPUT_WIDTH, info->max_width);
 	sink_format->height =3D clamp_t(u32, fmt->format.height,
-				      RZG2L_CRU_MIN_INPUT_HEIGHT, RZG2L_CRU_MAX_INPUT_HEIGHT);
+				      RZG2L_CRU_MIN_INPUT_HEIGHT, info->max_height);
=20
 	fmt->format =3D *sink_format;
=20
@@ -197,6 +199,9 @@ static int rzg2l_cru_ip_enum_frame_size(struct v4l2_sub=
dev *sd,
 					struct v4l2_subdev_state *state,
 					struct v4l2_subdev_frame_size_enum *fse)
 {
+	struct rzg2l_cru_dev *cru =3D v4l2_get_subdevdata(sd);
+	const struct rzg2l_cru_info *info =3D cru->info;
+
 	if (fse->index !=3D 0)
 		return -EINVAL;
=20
@@ -205,8 +210,8 @@ static int rzg2l_cru_ip_enum_frame_size(struct v4l2_sub=
dev *sd,
=20
 	fse->min_width =3D RZG2L_CRU_MIN_INPUT_WIDTH;
 	fse->min_height =3D RZG2L_CRU_MIN_INPUT_HEIGHT;
-	fse->max_width =3D RZG2L_CRU_MAX_INPUT_WIDTH;
-	fse->max_height =3D RZG2L_CRU_MAX_INPUT_HEIGHT;
+	fse->max_width =3D info->max_width;
+	fse->max_height =3D info->max_height;
=20
 	return 0;
 }
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index de0a7d984494..5c5b7ca71c19 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -738,6 +738,7 @@ int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru)
 static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
 				   struct v4l2_pix_format *pix)
 {
+	const struct rzg2l_cru_info *info =3D cru->info;
 	const struct rzg2l_cru_ip_format *fmt;
=20
 	fmt =3D rzg2l_cru_ip_format_to_fmt(pix->pixelformat);
@@ -760,8 +761,8 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev=
 *cru,
 	}
=20
 	/* Limit to CRU capabilities */
-	v4l_bound_align_image(&pix->width, 320, RZG2L_CRU_MAX_INPUT_WIDTH, 1,
-			      &pix->height, 240, RZG2L_CRU_MAX_INPUT_HEIGHT, 2, 0);
+	v4l_bound_align_image(&pix->width, 320, info->max_width, 1,
+			      &pix->height, 240, info->max_height, 2, 0);
=20
 	pix->bytesperline =3D pix->width * fmt->bpp;
 	pix->sizeimage =3D pix->bytesperline * pix->height;
--=20
2.43.0



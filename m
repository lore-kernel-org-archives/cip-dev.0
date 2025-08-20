Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06DDCA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:23 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.25])
 by mx.groups.io with SMTP id smtpd.web11.886.1755705913155586959
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=CVkFP5A/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hb4wSRtxsKTDraS8d0CfOPF4Ly478+xMq+1S8FTkTRfuVslX3k8iq0z7jbvJU488U8n1jG/HWxiONUPC44OIsMZbrUYOiwrpqD86cdYA5LryV58DIOFMEK6UUbv7UWFFc7ykRc4Cmp8kjSCaJntGq0NgcuBjHWewwHXM42vTZhQcEWz4npaWC+dnGbCn5eXfIqoh5IYy+WHUad3q0xvtjtRjHZUPERLKJAMpbb+JK5X13+Vp29fp7eAStvoh8NKTPhh9gOnj073MVCxWvvwTR570BjSJOOGXoM9/YJg5q6a1XceJjFdVhlSW1PL51Wg32txH+5H27YljZ5s9jnQvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRoenB3smmDDGsGAEOe+y0ASHsj5G9DQnOCZ01VZcow=;
 b=vqNujKnobnfM+wftFSj4/DW30aCcBdw18I1rsMf4u+ZGsC8fpx1BoUama+rEsWYxrFZ/W0/JcxmVPhAa6y61Kdqr5l2fiHbvrWqv26kZ/u2ZFfKN3pWWIOy1QjrKteltfj9Y13k3yIiaOIcqd9wD91mfaJ/xBuFKcys38NwguP2ThRBJCTnDC64kWw03Wt+FlJBj4GCnqjMRHljDdcB9hkDETpzhB6crE3Q7joBasr3oh75gPLZtlX3QvWyST+aXcMAPkp5hkGybjeI364c+8cZiyFL/BBck3KD1AT53Fur3VDaNx5Xm1S1XJvABMTLPERbCNipkEq4LUIAkzP5A0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRoenB3smmDDGsGAEOe+y0ASHsj5G9DQnOCZ01VZcow=;
 b=CVkFP5A/xVzDphgC0cFGfCFK3OAcgYXU9naypFd7/2E3inkPtW1WizZFqNgG7xpwWPGLuPLQXZYTEEAGf/oXWIi1TPcZwD58dxsUKe3G6JpeIH3OMFGnk27zGRqFTQ7xlEeGWVSnBKwuXUFcxr3YsvG+MIU870MbVDjCXtKZEl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:11 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/55] media: rzg2l-cru: Remove `channel` member from `struct rzg2l_cru_csi`
Date: Wed, 20 Aug 2025 18:03:28 +0200
Message-ID: <20250820160413.801341-13-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e712ccb-23cc-4e1c-def7-08dde0035728
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VZyBcyi64eAtvdQefmTFHfjHaXzcojT38piKwad8lBuTVb0hHVazdMTCxm/n?=
 =?us-ascii?Q?M/wYg+6o/92pld9I9mMrt9ltkKhyXVNz1xdPLPJItcQGUYPufF+H/SHSg0ft?=
 =?us-ascii?Q?luXBSbTw3XYw7+Bve9//VqmpwVNAV80LRheRXo3z70K74sTrizN1+xFT30J8?=
 =?us-ascii?Q?sPDAuwnOKTBdr2mzU4UmsVqkUe5bLNgJoaje1mdrtuPG1FIDD038+P6bbWOw?=
 =?us-ascii?Q?IaCQfEiI+Pw1eKBvAsm9MBc+pbr+y8a64vkIzKLlhE/EoDdFCTLYUjNRb+uj?=
 =?us-ascii?Q?DAAdtfBwO+xpV3Nnt7hEVijBJHBfyUmDnX4qPotwle2+LdbA0F9HUyqx35sX?=
 =?us-ascii?Q?VD7gAc+XQtblT3f9sTgfmciVFhWLJB9iCFCdESbQVH17Za8FFFOrgXMhmANk?=
 =?us-ascii?Q?UX6xLg6iD6b0sEXh309kKMr1pNqinOyOjKUaB8Z4xbh4cE0tFW7FiYUWeesk?=
 =?us-ascii?Q?FY2dH5ghV+5FmkyCfn0C7VJ835kwto3YS7U8QQSgnfd9Ht2pZ9X4ZiPwGpJT?=
 =?us-ascii?Q?bkRbwAF7TsxYumAKLpPD4air+8iteAhDYc1bYUSROgBrzLDVsaFrYMOz/b5c?=
 =?us-ascii?Q?EIhCC8psnwV9AdxCSceuHX0EbXjLEQM2tdkqjok+RL7KiyVqRP3s4ycYqmlh?=
 =?us-ascii?Q?up6vwvIgX4jmcym8GjIMxwZB58euByUC4cAf/kR5mpWqyP38taGM8OyaDHJe?=
 =?us-ascii?Q?LAK2KSYxG6NrAFKvYd4xHvH5tK9f5JFuBKq8wKR4C1PNltZ8oU3mfHUOXET3?=
 =?us-ascii?Q?fQ9bdo9PDW/rbTjspSV3taNRb83qsMzQaUsEYwUyKuArybugICYrpNNAC7DX?=
 =?us-ascii?Q?iZvn54GAFGJBTpdIGKwSlzYOmOWt9sXE1q8orxpYBXNulZwJHa/oCsv93AUK?=
 =?us-ascii?Q?a4jcXGcienOppR3NiDfkB/Wf3k/Ub4olBtVcOOrBgrg4MluBhzseQIiHrxhb?=
 =?us-ascii?Q?FMpymJTSY8easnFdKCf8ow3/1dS9fzNEwp69XXR4oBH5lVTgSDx/Lkd1v+lt?=
 =?us-ascii?Q?t7T6PfmrcHWYTJpdZCNXUBVZRDHs4QVCM774t3IJ6sw9/iXMLQMYWhFnV1bM?=
 =?us-ascii?Q?/Va08RNxor05fY52lM/17TuGRPDq0BHE1gJF/vh8KVkSi+JsXBc/Kj1t52Ub?=
 =?us-ascii?Q?5kRfnDrX//QhOFijQZbwM6Qiiw2zSLbuFsQ+QGek7WuqcUTcFvOxVPqX7SJb?=
 =?us-ascii?Q?8wGLViFJFA5TjDLil690crSpUjc5jIMU0EGECaCCQ8QupEUkRZrCcjiT/Ppt?=
 =?us-ascii?Q?MeZPfszrN/fBKUpJwwVsZyocb8tBchwucT1HOfHuYzGcbx7gbbyRMw/jBbLq?=
 =?us-ascii?Q?v/pbGkWF1gnSc26/q7CkVfNkFHJh0xSzNHpItrhUGAUFRvRzkun4ugnZOq3s?=
 =?us-ascii?Q?UEtvNJnhQJyHv8WWkU96Gio8X0RoqBnkqfzucX+0KV8xLwxW7VM35xVszGGF?=
 =?us-ascii?Q?nrsOM3Xyp7HP3JZ3gzCL6QiCt3K4TlSpeHgVnjMh/RpEnc6/CHjwDZxxXmNZ?=
 =?us-ascii?Q?7Wv9suDE/KR4NWU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6z1x3MLVJVq7N3HfT5jpYTJzLBTVfOPHkKv5XR/ZyvqtScmgIz3S5KVZxHZx?=
 =?us-ascii?Q?2sHYw9xsTmJn0/t/3hSUiz8QFcrCgF36n+xo0K4pTHAXfNauknVURtAwSgqz?=
 =?us-ascii?Q?yBfeVjDh9YV5ClC9GVy5wfKVn1ICiYuHAX2CvLSx7IJ3yJce4x3SYQvwoiPN?=
 =?us-ascii?Q?P/u9Rzr5doW6siHgm8ujv2n3gVlOIoPvwQbsJN+wtijSMEpKOw5LQRGeTSCx?=
 =?us-ascii?Q?R2jEQa1YG2Tz/ZErduP22t3v2TqZgDFjR6haMtuOMpnrdkU5PBzwe4dOdNkw?=
 =?us-ascii?Q?HtXOOlANhHcxovNaZyUlVYANt3Xu9bh6kHuNWiJuB/8ygUycczxDoa2OW/uz?=
 =?us-ascii?Q?eBfBgkw9OYSGt422Zk6O4YOVM6vJVsyj8mnTDr/VZlRzocvlLsOIUej9+zqb?=
 =?us-ascii?Q?TfXI4T4P5+SNi3VgkJ/5mV7GVKZaZKqsaI8xgNygOqTg8O4ThQP0NE5LYqao?=
 =?us-ascii?Q?2oyAB4F+UZLtAprFy6kWxoI5AxhjJwI4Izgx8KoARbuxAruWMwem9UCP4Exk?=
 =?us-ascii?Q?UKwSw5xQiMWJGJvZKNq5/l6ruT3Na06iCon0o7OZagVEnYJxNdoP11Jlgsal?=
 =?us-ascii?Q?o6SAJlsWPoE4homU+0xrdezLNAxPvFWKyNoIe9ja9+y7EJWhtfbf7Sxngl8A?=
 =?us-ascii?Q?T9vBsSdwvbwR36SFoGnZRxAjUCJjUEf194MXAktANN+yiSRHqNvnArImWKzS?=
 =?us-ascii?Q?qVr+qeskoycYOsYizaLXlzaLV17m7hBPvDAT2Y0VPN0ET+QufYxBYsvHdBjz?=
 =?us-ascii?Q?G2shf9sWMK6eZaFjxlMZiPAme6GCuuQdtWN+rC7c/DVhhMxRe0wQAvtw+DQx?=
 =?us-ascii?Q?ZOHiXfQgb2xPqhgxu92C+k8sKVOlOE8uSUxCQCUDIvMk9oYH1dSAgZ2HAGQp?=
 =?us-ascii?Q?GuTrcBUHJAagc5YLw7rKKmAQ7nfiTPkHkQF7wudxGsiVV0N91941vWS0SMvI?=
 =?us-ascii?Q?lPt4KsUo942N67GxcpyPtot6zgROJ48q4e1l/QMLAbg1cZi6L7sxmovrUZHS?=
 =?us-ascii?Q?sKBwfEccCpHrV2RFcJD4r8XmGZjb8ZqimWORIIwM2iVXKS46TLQZmukftfJn?=
 =?us-ascii?Q?XKJKWQ6/SU1eLSaWWWogRrHRP+mbCHIoinXwJEVTCmCJg9toZmmnQiY1DaPy?=
 =?us-ascii?Q?EVXHnfaCVK9/Ys1TI4dyJP5UwPbNJjtEof9Peppjuo6uvpb5geDWUgcgc9Y9?=
 =?us-ascii?Q?6JBi1Pq0ImHB7GkGR9e0r5PHjoH8CqsFd7fwVM9ouVobaevAlEe1EYrQnetj?=
 =?us-ascii?Q?RYvZZAL5vsvkUssywNAza3Fg/Xxo/G7F3N0zym2vFcdQtsCWa621kWrhuIkX?=
 =?us-ascii?Q?qSphqp5yJFYCXYVnq2TLmHganT9gY88F0nPzBzUBRWgJkuTPNfempESXhh5h?=
 =?us-ascii?Q?jbr1p4bbmG+0JTPPojA+uH4DGpPm9SZY84I1bcgjhRGuxuDORT/dSnU2NI8k?=
 =?us-ascii?Q?ZFf/jiY090uIpuZbB1xkZtBDXtkvbcrXUDIaha8Om4gWvTd8WyCMjqN9A/zG?=
 =?us-ascii?Q?1h1eOZ0xhxX4l6tq1N95U2NG2Fl6TNgxfXLl0ju62ljv4ZrUwd3UWdCxhyHR?=
 =?us-ascii?Q?SfJHL1wcl1Q2iAIY9vEAJBEZgX7P4xbvSQautaeJq1CCgm5NYDJDnRw6/IC9?=
 =?us-ascii?Q?ywQ3ITulppiTU0UNYacb7Zc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e712ccb-23cc-4e1c-def7-08dde0035728
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:11.1198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IffKB+A35I8dEMH0Lk4u78qvNqLgzLnXUOAUNgoRVchWGJ0uAvpPRbhkXh3LKcrA0NKnKvlTWPaXEvcgWR42ytwKbLQx4GRzMkI0JKCh5JQ/22PEycz8p2dFGGy+ip/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19837

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c7f3bd38b543255ef0175469ad7e7895857a6934 upstream.

Remove the CSI virtual channel number from `struct rzg2l_cru_csi`.
Instead, pass the CSI virtual channel number as an argument to
`rzg2l_cru_csi2_setup()`.

Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-8-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-core.c  |  1 -
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h   |  1 -
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c | 14 ++++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index b29caffce844..17e651376b2f 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -73,7 +73,6 @@ static int rzg2l_cru_group_notify_complete(struct v4l2_as=
ync_notifier *notifier)
 			source->name, sink->name);
 		return ret;
 	}
-	cru->csi.channel =3D 0;
 	cru->ip.remote =3D cru->csi.subdev;
=20
 	/* Create media device link between CRU IP <-> CRU OUTPUT */
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 786b6a61c44f..24b36097e0ca 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -53,7 +53,6 @@ enum rzg2l_cru_dma_state {
 struct rzg2l_cru_csi {
 	struct v4l2_async_subdev *asd;
 	struct v4l2_subdev *subdev;
-	u32 channel;
 };
=20
 struct rzg2l_cru_ip {
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index fb29c1fc95c8..9e8a14949a57 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -301,7 +301,7 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru_d=
ev *cru)
 }
=20
 static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru, bool *input_is=
_yuv,
-				 struct v4l2_mbus_framefmt *ip_sd_fmt)
+				 struct v4l2_mbus_framefmt *ip_sd_fmt, u8 csi_vc)
 {
 	u32 icnmc;
=20
@@ -319,19 +319,20 @@ static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev=
 *cru, bool *input_is_yuv,
 	icnmc |=3D (rzg2l_cru_read(cru, ICnMC) & ~ICnMC_INF_MASK);
=20
 	/* Set virtual channel CSI2 */
-	icnmc |=3D ICnMC_VCSEL(cru->csi.channel);
+	icnmc |=3D ICnMC_VCSEL(csi_vc);
=20
 	rzg2l_cru_write(cru, ICnMC, icnmc);
 }
=20
 static int rzg2l_cru_initialize_image_conv(struct rzg2l_cru_dev *cru,
-					   struct v4l2_mbus_framefmt *ip_sd_fmt)
+					   struct v4l2_mbus_framefmt *ip_sd_fmt,
+					   u8 csi_vc)
 {
 	bool output_is_yuv =3D false;
 	bool input_is_yuv =3D false;
 	u32 icndmr;
=20
-	rzg2l_cru_csi2_setup(cru, &input_is_yuv, ip_sd_fmt);
+	rzg2l_cru_csi2_setup(cru, &input_is_yuv, ip_sd_fmt, csi_vc);
=20
 	/* Output format */
 	switch (cru->format.pixelformat) {
@@ -466,12 +467,13 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru=
_dev *cru)
 {
 	struct v4l2_mbus_framefmt *fmt =3D rzg2l_cru_ip_get_src_fmt(cru);
 	unsigned long flags;
+	u8 csi_vc;
 	int ret;
=20
 	ret =3D rzg2l_cru_get_virtual_channel(cru);
 	if (ret < 0)
 		return ret;
-	cru->csi.channel =3D ret;
+	csi_vc =3D ret;
=20
 	spin_lock_irqsave(&cru->qlock, flags);
=20
@@ -489,7 +491,7 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_d=
ev *cru)
 	rzg2l_cru_initialize_axi(cru);
=20
 	/* Initialize image convert */
-	ret =3D rzg2l_cru_initialize_image_conv(cru, fmt);
+	ret =3D rzg2l_cru_initialize_image_conv(cru, fmt, csi_vc);
 	if (ret) {
 		spin_unlock_irqrestore(&cru->qlock, flags);
 		return ret;
--=20
2.43.0



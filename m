Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE59CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:04 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.63])
 by mx.groups.io with SMTP id smtpd.web11.1021.1755706135811197221
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=eCs066GP;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.63, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABuaTXbkq59KQyJiLSIRfuwuMUybLwQ6EJyRLjiZ8zrASvnDt5b6MprqCN/zqtR9H6MWrJi9i9j5YgcgdfPOycANhXWFg+XdsA65Lvuk3cXBzwObOG+eUZ97gbtyJDYcz5TyBiqCc4mWg5glses5B3ffQuVLfjbD4aK6GjIca8VLtIxFU2rf2zAMnzzaT4j++sJb5hgBsCwLJ6dhR148jJStfPlmzAS5ZxxnrGY9hgOaQ6bCwczYFvnydcfeC5SYuE255jkrRLBeZ8hqJnFzZD8uSkjreLBUdTCH/6Y+NTQt1Tj2rzIKg66aeXv4SrodgyDScQdxKa2ZkPSfwob0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIfEVJZrhVOjTb/HNwHkYannEPR6umQCyRirVO/XgkE=;
 b=Ujd1sYhTqFnS4rMPFdOngB26IkteJ7nJ7bexypJoZ0QTZN7zhBK6peZIhq+Hh5/exDfV30YCrZoVeOke/UOoomah9GpaM/pV7V1wwR9GQ+znFg8+jD3yWt6fVAwCDK/Ddl7DVc3g7AF/9yBqVUr9pN1ODuq9aQ+3eshTAdl4e6mbkarj2EDkoSLJk/k1rGgAYmN+GKsQy0saWmYOc0xLDbLSTuPygmSS8YK3olkGJkP86nEWq7iPzkhuM84HPM08jxFS7b6MHfXfwaHe5ck9nrhSAm7WL+YHrU9QHh1BYVl3uxzmHM2UaQnwn8JauifViPD9QR3J1LjPTBdChvWJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIfEVJZrhVOjTb/HNwHkYannEPR6umQCyRirVO/XgkE=;
 b=eCs066GPMnHoMUNqO/ZG7sr0U+DiJqpCQ9NfkSpMqFd2CIBR0HijlbgVFWmNv+kryIptlWmvXYs2tPbBufFoH0gFa/4UiWY4BneV1jxL2CD4wCy7bPBKxjfdu26KbQyG3sCMQMK94aYCXnyOmRemMBWSbEl4s+7Yx27c7RnJsvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:54 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 12/55] media: rzg2l-cru: Remove `channel` member from `struct rzg2l_cru_csi`
Date: Wed, 20 Aug 2025 18:07:13 +0200
Message-ID: <20250820160758.801813-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd1fd46-5bb3-4cfb-ef69-08dde003dbe8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0LeoT5P2PMrTqDRbZyujqjNXGO2p8pl/YXPwg4g+w1bHQvhcFSZEcbKP4aRe?=
 =?us-ascii?Q?OZdNzw3o+EqI4yNl5i3L+wFNKFVYZhmd6aObyerDCegkNFRCBZ3g9Jl0Zrel?=
 =?us-ascii?Q?nGtAoQf4gPbK9xVBJzJNuYjcL+j2JRj1l/Eglstoj+mPTvwa5GglvvqxxeP5?=
 =?us-ascii?Q?gqMq+nyLAtVwvCfgmsLOtZGBgCWLifV5DWtNdSEn5tpcqeAWKu00dxLqsuzm?=
 =?us-ascii?Q?tKjOUob55epkgcJFUthTcH79h6TcR8+nunOZgOeONO12AHDGi41nPlmkBgz7?=
 =?us-ascii?Q?2wmwZQ0nxoctozLUBKHyKlgq3+Ovyohs+pIajlagrdYT9HBdGwQzkNCfw0tj?=
 =?us-ascii?Q?voGfJCwkH7cXE9l9hMfku/HyHPZZKgTFxMbfMbuF7/QFMez2Er+UON5odqHR?=
 =?us-ascii?Q?n4qaUN8BRJU+hSa5zrg9tVa/lMG3EcXnCVEBmfqha/qf8VeikAcS7GQVPjC5?=
 =?us-ascii?Q?wxyY1y4aZbQuxYlgwcduo5Ky9NdzAa3wDHKeJe0YFmyUeOqq4heQxNmu6H4r?=
 =?us-ascii?Q?1TSwHd+QkF0PjP8MHPtM1p61Z0j3iay8to4ACvVqVbSDrGAbWRHGUPFLBiNQ?=
 =?us-ascii?Q?pGVyX92vlg7OGcyFKErvtfTpfPwJrFM8/UW5ZBBmgVn+C3ZPw0Y/NCiXEskw?=
 =?us-ascii?Q?EVJgB284a95qWVY7BIRQVw74ezBH2PH9qjNpHWwgnrYYXzBn+DVBsZeHl5e4?=
 =?us-ascii?Q?AfG6j3jWk+TiSCStRs8lX3hHoBKhNZX0A6KXomv+BrR0YcsHX94kbKgbUaIG?=
 =?us-ascii?Q?fMRO0djOVedcSfVj2T3u+nOCfJZKf3rAqzkI5huZ8BQbpaFMfNITmElsoR7z?=
 =?us-ascii?Q?+XgqI+pMPQVudDb1MrYp7wWQL9cOoLT9E+X3t+d6VADyHlN8gimDfM0dZfWO?=
 =?us-ascii?Q?xFTPNKILYItlM7ThxOku8zeyBPK3RAfd21Uzt8+AKTg9Jw5JhoFbMOsu74S0?=
 =?us-ascii?Q?2VjjTvbLIOtgrp25XTiWkhMSDDv+1Sv+4Y06gd34YKBgQpx8SKG2QSlzKmVI?=
 =?us-ascii?Q?nYqIVO11jHC5l5ol3uhNQTk/6v+Vb3F336GPlhpElX5Bt/z/7/nxfO5SmLcq?=
 =?us-ascii?Q?zv1DvvPV3fd0+kxTViQoUXSFAWBCa35Ns/V7aDOFKAa3NNMXd2Sthga9Wd6s?=
 =?us-ascii?Q?o+0ddJGTN2PKdvta6nPh+OrxuUc6hGdhbtr1lcwBwl25kfZNCOx4jdWmm33g?=
 =?us-ascii?Q?AGkH0oupT6dnePxTgRWgXoeByFYDWXudgkzkAphcgqyln8pvmF22u3nlN/NB?=
 =?us-ascii?Q?jldO3ppxY/aWYu3Do4VD9yFjqtnstsxqGCsujhV+bpK4BNNfu5s9I5LbZ5Ja?=
 =?us-ascii?Q?fPFzDkcIujne0iuy2YLeWrIreZbAThL2u8IlMN1EaJMsIa5kyb8+XLUzl4po?=
 =?us-ascii?Q?5k+NrtaooAULlhbAqnaPC7T94+Q4oOxwwaz9qOKZgQheBgijaqTzu5eB1bLh?=
 =?us-ascii?Q?QsQnh4vY6/AkthQuF6demUPZGuHjES9x7DPfS2tBrFj9w1SEb4LpXvP91dtO?=
 =?us-ascii?Q?az4tPUvQ6/a8qro=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?A81JerAzSguctgAbPr88buQw9499u5Qm8lmbaNyiKocLu0n7F3daxk3Mr2Ll?=
 =?us-ascii?Q?gQbGj1LqUTkBFqc/tpnrNW53QTJVHEdej4NxQCfrRKtO42DpA68GTeuG395g?=
 =?us-ascii?Q?hbgVlcS9wAafwVF2B3dUtTA8Q+iYu3z4dH8UE3ezkh0Z7c7DOIrhQdwfLfYf?=
 =?us-ascii?Q?fMNFnqe8F04hA/UieYcMZzegBfcR43vxmCdvKHx5mUEKqrYMu1Bz96vtnpC0?=
 =?us-ascii?Q?yRmpeImMU362kNL4x3UXxns38JKXWWq6ntRgysPD8KyQShC1XeaNxZmNdI97?=
 =?us-ascii?Q?9FynUBCSTaEs7Pg2dOHHDyQN6xO2RhIX13iAJ1t8y1eobkGn3Vs/2SkIp/Lg?=
 =?us-ascii?Q?cpepiLgfL7F3cVTHr+QJVwDnoG7MLAMVO3c75yfiwlAGtroyPyD31NfEVeu0?=
 =?us-ascii?Q?8wSCpObO7sap1zpQTQiK2n7mUB6zpe8/0iUD6UJQ+o7ozawR5gT2LTVDb9EQ?=
 =?us-ascii?Q?2+Cta3hsnz8f3vvq3I7uBowsbZmQA5ydndbYmz9Rr0h7/4D6HFefq04SRZfT?=
 =?us-ascii?Q?HDwl7U+mX/668dwX/xqloG6RQKIFUdwqVim7z8D01UNotzLbPnAUpWDMiPSY?=
 =?us-ascii?Q?iX/KqhEyPd2bBdNjGclPQqVosVkAkkynp+IwYnFTZDvR9i74Uam4y6TStDYR?=
 =?us-ascii?Q?Lo9Jx3ABTRWPcVPf1VejVSX0NwGLSurhdK5DwMO2F6ra8NKNlkb+BW7yYvEX?=
 =?us-ascii?Q?7UruAP6nPPhxzb7VSxzzMgxhnguSIgHjvyToUalgivlsfxry2eresR2qjTC/?=
 =?us-ascii?Q?VAWUJGasCWtur/hNktZGRheo2olw4MSYErMDWocGRQUZdlmVNi3DH1gY4Gbj?=
 =?us-ascii?Q?DYrZqRICxZ0wV8xYlD2lq4BkbCVFOrccSmBBEy6YDUvRoy+2YnbVqTKhA3GO?=
 =?us-ascii?Q?gzKeoXZWD8UMEQ0sxlmhu3lGdL/KEmMXbNZLLot2ty466Gel8UliwpWMMmds?=
 =?us-ascii?Q?akASe/SPk6KM/DkT3bRquzuh2qOZuk3MEvpL1ni/mEzRjXSiVykebscy+hWA?=
 =?us-ascii?Q?Dd/Oom5X00QgDLX57j5dW63SZ4UfPVPhZyC05SwzeL9wXoIf5RmiOL71W/bH?=
 =?us-ascii?Q?Y3aKf8p0OEkthRznVjFyS7b17Qltz/4IZAjj2+evaQ0xaNO+02BM2NwNhRQL?=
 =?us-ascii?Q?VURP/8k5naAZvbG41fTBk9jr7XmBPFMiGUJFu/CBOp0o5ttmgE+x/Pk4mr/Q?=
 =?us-ascii?Q?GLiDSm6mAUBW5LwpnhUyHrH1KG1GIMa11DEZkLA5A4FncpPSD1wIWTdKgdD9?=
 =?us-ascii?Q?UEbtxIEDm21hvSALwzIKw8GWGi8O9BvgudSrkQFix8tq5wYo5z/vRkox3d0x?=
 =?us-ascii?Q?XAPtDC+sVg0llP053BTkU6rpcJMaLU5o8VygHaF3sFhxDxJ1VCZbY0pG1i8y?=
 =?us-ascii?Q?5GV4pQr+rd+EqAmM1EmRgXEvaY3i/3rq3IzC5rTr0s+1tLdl1g9HEPcSNQUB?=
 =?us-ascii?Q?6lfgPYvFrgQ0TPRmTCZtmIdLvTbIvzWCae5QzW4lY1baaRPs2WETiLe7ohmm?=
 =?us-ascii?Q?LUUfac9SdwYBGpWwdwHiLP42UAH84h4fJdu8AlkyZ6SfCmSwKZ6F9ivfrmC6?=
 =?us-ascii?Q?rRKDfd9/BumYWCB0dj2M15bZy8TLfLL++3HZIGzqMJa8imI9ftF1zTxV7D+u?=
 =?us-ascii?Q?i7ZMdWB0xOddykQY4omRtGw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd1fd46-5bb3-4cfb-ef69-08dde003dbe8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:53.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ril5HrEKDD1uUwrScNm9q0N2dmOEyrdea2UMwNjnTKxFYMRnuyr3aaBDfHAU79maSkOfYxbZqkcwm8GqlCn2+hdZzl4NgSp70CE0ScC7mFeNTpBvrzBdIwJvqgsn/8cH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19893

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
index 69cd45b26951..b21a66e2ce5c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -72,7 +72,6 @@ static int rzg2l_cru_group_notify_complete(struct v4l2_as=
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
index 8fbd45c43763..4fe24bdde5b2 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -53,7 +53,6 @@ enum rzg2l_cru_dma_state {
 struct rzg2l_cru_csi {
 	struct v4l2_async_connection *asd;
 	struct v4l2_subdev *subdev;
-	u32 channel;
 };
=20
 struct rzg2l_cru_ip {
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 7cd33eb1939c..9ab7ef33c9da 100644
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



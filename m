Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC712CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:13 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.34])
 by mx.groups.io with SMTP id smtpd.web11.879.1755705908650418673
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=v8A7nGwu;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYbMBaOtH2oSVYRRpdVUaYzwHAEhfuUqgGEcMTadZf24K4yGMVnVchJtQuj7v6rNv/w6a13hiG9bqGSnCI2g90LFZ5W8ldl0jEEvOS6EPX+4//NSFsd/tW79RZ7NjwjtsFsF4VqO8kKhda9X3lQ6qPr0RxmLJaqsBMrM+cBuJyP/MUmABleUP6yhGvpO3pZ9lBauoRQKYRBR4XqxLUczIyg8VCaso8wC1D2FTFUxrAmKHdhzZu+lUnyRo+R/RkV3DC+XtPmsfPWSLHK/haSuVO/A78XaiX0TBQA4LYI8K1ebZTLW9vmxvkKAiPJGjiB69G2Fox3oI00SYaPOYej1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT8r1oOz+5uvbAj8EIe+9H/RqlwUE0mTHfPs/nlDCPo=;
 b=GIOZSJGNEfnAJLY/XEfbA/MSxEJwjJGSv2Jnc0F2VyiAtjdqCa24Ah+EaycmNk8xuBWa8wxqzCCr3+J6xcptKzB4j5q0COjvJeIFB3lFzD95HQsroQZR14xibcT5xg+/wSejNTMEjv4Pi6ka+LwOu80ZJX4xO0eSmzq6DepPtWZRgoQ6mtDaTFCX6GoUplJUOkHhM0FwCdWNw69iIbdvM2AtmUj+6Yl+pYIi3XZjVKhm6Cu4SRjx7l8NVkf0iVpY/uZb8tdPcmAeYapQT2VeL/EeIWREnfp5HkAz4yZbbioEJRDSASCz7iMfOUz8qWSsbEePHWmmVenKYw55Z4270A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT8r1oOz+5uvbAj8EIe+9H/RqlwUE0mTHfPs/nlDCPo=;
 b=v8A7nGwugTDON1FLtHhjqlSQjB4+uxTTwGPuGEEkNLbCSiQLSflT5OEyFzV1w9sySD4cJummC9Nx7M85ldDXGxWWUjLwJvV4ApDL9zlgBXrmKWwTR8SujNu2R9K9zCu7obqykTu6PH0si3nlZJL8PqTEkkN2Y/MJRDKY2WlLL1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:06 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/55] media: rzg2l-cru: csi2: Implement .get_frame_desc()
Date: Wed, 20 Aug 2025 18:03:26 +0200
Message-ID: <20250820160413.801341-11-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1d629150-1a0e-467d-9bb3-08dde0035428
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nefpBsLF/bor1JK5OGN2dutWJvYMw9tREpvvLfDnpJS4Zoy9UbDaPCSdggKk?=
 =?us-ascii?Q?n5tQ7bXv17Xc0vEEX1DTrg40uGcoq0oSQk6AhQIQN7m2i6PtqF1jzvTxYfKJ?=
 =?us-ascii?Q?FZvRygQpHQxETvngLBWjTw3wYFSSGvXqoSkXpR51SOAfYYo5AeEAq6ljpvHg?=
 =?us-ascii?Q?0uZw+nr1INkHTiTpOz/vxYLcBASnmUTzsNt0QI1CJdkdmmZEydZDQOKcJWaP?=
 =?us-ascii?Q?T2e4nJXGeyWonycK+2oaFIiWCPeI5miTjeQr1beSJ1rxmLstxqKgShau1n6t?=
 =?us-ascii?Q?KVwvyud1wwYEOEWtGzEO1/Yl0u3UleW9CCkStTdoNUQ0cxMx2zj4J2dDz6En?=
 =?us-ascii?Q?o7m3t4FemWP5xO4ZolNckZUPMKGeSrvb3cuk7X5/mOes32iAmcYKVfnMAe7p?=
 =?us-ascii?Q?pS09A3/iXHsYNn5Kqju+jeywUS0ssStDKdhu8V7PsChY38yqHad73YF8ldjW?=
 =?us-ascii?Q?E2Gb77qXJVoNZmJ1kFnt7CAZ9YkFm9tOT93omI1tROyaj7eekq3pY8qRsmKv?=
 =?us-ascii?Q?mLWqUdajqEvnuiIWyLLUFZLQZ4OsDEfc8td7QTgalFAwcbt7KvD1gK2a5cTd?=
 =?us-ascii?Q?GNHd0MJDELDJJqkXemaAfikFaHPb3oFMU087Y/Rk16pOnLYEup9fXCglv2i2?=
 =?us-ascii?Q?FGyR6GstzJZRe++E9+E9KNsQFudkvd9E2I0PG6jwB0wGEqi8R81lH2BxybmA?=
 =?us-ascii?Q?h/0jfskTo4UDRUuPcg7MP9+fbJXQ2awQ0i48Sxh19KPYrMz8rsYjXuDCKZK2?=
 =?us-ascii?Q?411/nCxLgp3M6enVZIK6TEbVcuUWq3Pq32lwtYWN90toSIYKXFozIm8MFrd8?=
 =?us-ascii?Q?D5pcMxqOPI5AWnegJu3InClqmLvs3ZU8MlfEvqRq40PXWNrHyP1QwVpiwjao?=
 =?us-ascii?Q?HGRnuB8Eca4ulA6ursKOGPdd79HHn+UlLUHLPQlgB08MCescBdAHhuba4tT7?=
 =?us-ascii?Q?qZCeXje1Q4p6nOqOKRRPDTdGp+KA+2kmD1zw8NDh+fGPES0gaYBsY22lSg3y?=
 =?us-ascii?Q?k/iisJYuK1EFYisJlHBk22SY0VhTxeo11JjpGgxsA7gX7O+u7aKVDJ6a/AiY?=
 =?us-ascii?Q?mrnribXUhPtSFyMoKjGFlTYLkIgvWrSIPpA14azch8A/XIobyI2+dC1EqCAc?=
 =?us-ascii?Q?hkwiksnthE/853P19ZGU/yFj279Pr4ozm4mNGUN3CzF+biRAkHrTjO+LDA0D?=
 =?us-ascii?Q?Ju+2yszgaE5PAI0SPr84z+CnyMpPlsTrv+3+SrTa+XhdmFpq+q4BvhyA4CQR?=
 =?us-ascii?Q?N73n4lg29AHtA+lZWbdPpc15qH9YVlEjC9c3nj2hkkvEqgd0FdscRJyhdFut?=
 =?us-ascii?Q?aYvC3xFc6ZqmIunj7BHhkJ2DMbPNMFEMPGglDBmalpdXpCJqHhwEuYBLwj9h?=
 =?us-ascii?Q?BoGJQpVj1A2wxXEEdlgk7DbAtVMXHNfNx0EGFKf6XvIlz2PP4BqaEEEDIusE?=
 =?us-ascii?Q?z2zPHqOh5x5tn7md9+FT4oWVY+FV9d0YcqhQ5TZCdjTJ05vqRJYjWMo9GSxL?=
 =?us-ascii?Q?QO3PhJk5e7j3hvg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0F0kmk5a4yAQwolU1DGiRs1IHX20gqHNz2kdWexdGJk91s8eRh3rm93HEoWG?=
 =?us-ascii?Q?M0UukLk4pJ9SHzsIBvwS12y7pnnH1YIovBNBnmKD86s3RmsDEYsLjMDSW2q+?=
 =?us-ascii?Q?rH6Fl34KG7YIaR14k/zy3JdzxS5OlXark4KRq/BCoWgKhLk5vY+x9ZAADHyZ?=
 =?us-ascii?Q?mBtgQgnFDjuZyGlRW6XlngHzX06lsaM5xueLluLqiWQb5IFCPmnH98VyWy4y?=
 =?us-ascii?Q?VDzSScapAR2pb8SMg3rKSvi9bpy7SdMfM3TpNwomYNaPuPo0AnHD4naXXzR6?=
 =?us-ascii?Q?VuGOx6/NRvaPKa96H2DWQIL3o5WGhtW668r0PWO1hypNh1x4qf7SGdN/Rym4?=
 =?us-ascii?Q?KV+FW929uV0oUtGHhi4uojXOVITmCGHelR4ZAs+5jxFdP1Lfc975m+atpz52?=
 =?us-ascii?Q?2r7pOmQSRWEIOHuS91ztr+sVIkuny4s61Uq+/U4R/XHhYVxf4jp9YGHM1w+z?=
 =?us-ascii?Q?X0KRVsd8VWNEIyUHFiyrBNMwnGdAtbT76+NvHGRl6IKxTcm6f91w7HqCyo1a?=
 =?us-ascii?Q?8FcCMQowdegWHF7e/hW6KjMdnoP1eoWxKimpI0Z6yB8KPARv/7VifZLzHySJ?=
 =?us-ascii?Q?RV5wtsdLl55mFAkipJwSZXtqZcMf5e2e/flO9tOvugOjLZqmemSl1N2vCfqQ?=
 =?us-ascii?Q?lUMPrCocPz2bEGiDtfoQIXUJo5g1UDh4WDInnaUIQ1BMTpCQrXdINKm0sxQV?=
 =?us-ascii?Q?MyHyskCA01gM6LzbqmhDMz/PIi+Q4mZ1d2OjomfoDv6FLSlt7eRVvRyJnioT?=
 =?us-ascii?Q?cZfT7PIrIX86jnzbP08Rg8DNZAH+1Tx7QhM+S55O8dt70VU2UEbSvzsCUnZx?=
 =?us-ascii?Q?rdMhFr7gtWarQuwJ7lsbXGQjQR86GEHVYHQvVGiQzUJeanizellY+YVse+rR?=
 =?us-ascii?Q?SIcpdY+Uu6ivn+eFHWRhZ+CCgqD/P71q/Eo/x4vfXskUHHAuk/V4RCmePQkg?=
 =?us-ascii?Q?du3IVpPwFCiZIzqSfXVvkG9PBwFlKomJ5sxTvms8ZnC5zKfX8qDfHRDwPWPQ?=
 =?us-ascii?Q?pySSFnZ3jOyOdzpuJowUY5tWhFfW8ixIQ4cFtCZ3IOxikerp/yeVcakatw36?=
 =?us-ascii?Q?uqf5fnX89WkenuuYyJNGzFYBfy3z+wDyxwjerEHZpRzND0YAjuqA47gOmEbC?=
 =?us-ascii?Q?pGnQUto3xIWyxxtUGgGyI56wA7JaULMO8h9qbFZFSoAsUH6gDZ5Uj7J1nPQn?=
 =?us-ascii?Q?dX+W2YPnrnT0Dj28wcgSm+ZBYMktmAu6BHxoot+gS07/Wp4vFJq9qoXOZI1f?=
 =?us-ascii?Q?1AIMSgzJQbsD2jESXkvz09PSXWD78op4yAHYxgERTyNJYDp86+UvWwi4cJ05?=
 =?us-ascii?Q?SgmrzNrbWIkOqX3ByFbpatitv1RLtWq+C6jDWrGEUwyfuy6abR5xvUfHragV?=
 =?us-ascii?Q?VN1Rlbjv0CXd9Akqkph6ceRtuOdrm52x2qAkPaaWFRE2ddkUa3X4C7C309Ev?=
 =?us-ascii?Q?n/V5bvc0b1YGf/gdsLl6D5VO/gWIz1M5OPImo4T0N+Bj8iGM1YCTzNOWzdLp?=
 =?us-ascii?Q?PWk8SFMAB6xtsT8jtOv6s1Z3otMDInE4i/gzG6JGE+ELElgVaWZL7oaiBTCq?=
 =?us-ascii?Q?R7TLf2SNjYHD1itlJEZhwLdpObSL422bPJRLxfQMxQoMv2qAQRSfOoMvhfLk?=
 =?us-ascii?Q?kkcnY8wPlVEg8dWtmUgY510=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d629150-1a0e-467d-9bb3-08dde0035428
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:06.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZVATcDDxa41QKaz0TrxgClAB9r0Sgz0OlYWBfxCPYrOpHGB9UTCX23gqcuUvE1Ww5JYG18DVxYuvC5r4T7pVND6C7jNDVwD7mOeCs651DA0qVywEWp39ueYDNNuVD+m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19835

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9e880cd9e9e8c2e54169e317985b61aafca5e2d8 upstream.

The RZ/G2L CRU requires information about which VCx to process data from,
among the four available VCs. To obtain this information, the
.get_frame_desc() routine is implemented. This routine, in turn, calls
.get_frame_desc() on the remote sensor connected to the CSI2 bridge.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-6-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 53cc4a7c1d83..b0d83e0dd1b5 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -583,6 +583,25 @@ static int rzg2l_csi2_enum_frame_size(struct v4l2_subd=
ev *sd,
 	return 0;
 }
=20
+static int rzg2l_csi2_get_frame_desc(struct v4l2_subdev *sd, unsigned int =
pad,
+				     struct v4l2_mbus_frame_desc *fd)
+{
+	struct rzg2l_csi2 *csi2 =3D sd_to_csi2(sd);
+	struct media_pad *remote_pad;
+
+	if (!csi2->remote_source)
+		return -ENODEV;
+
+	remote_pad =3D media_pad_remote_pad_unique(&csi2->pads[RZG2L_CSI2_SINK]);
+	if (IS_ERR(remote_pad)) {
+		dev_err(csi2->dev, "can't get source pad of %s (%ld)\n",
+			csi2->remote_source->name, PTR_ERR(remote_pad));
+		return PTR_ERR(remote_pad);
+	}
+	return v4l2_subdev_call(csi2->remote_source, pad, get_frame_desc,
+				remote_pad->index, fd);
+}
+
 static const struct v4l2_subdev_video_ops rzg2l_csi2_video_ops =3D {
 	.s_stream =3D rzg2l_csi2_s_stream,
 	.pre_streamon =3D rzg2l_csi2_pre_streamon,
@@ -595,6 +614,7 @@ static const struct v4l2_subdev_pad_ops rzg2l_csi2_pad_=
ops =3D {
 	.enum_frame_size =3D rzg2l_csi2_enum_frame_size,
 	.set_fmt =3D rzg2l_csi2_set_format,
 	.get_fmt =3D v4l2_subdev_get_fmt,
+	.get_frame_desc =3D rzg2l_csi2_get_frame_desc,
 };
=20
 static const struct v4l2_subdev_ops rzg2l_csi2_subdev_ops =3D {
--=20
2.43.0



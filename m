Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4F5CA0FE0
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:13 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.0])
 by mx.groups.io with SMTP id smtpd.web11.926.1755705972703243879
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pEiYykUp;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.0, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhH7B6hDzEUlW26KnIv7m1hV9KqHPPmQj4x7L98ooYQZH5A8mVgWdYf9TJm5vu3GNh2g+ziHjL6zNEiOCzSJ32QDP/9sK3dUOicPrEOIZjKBVOmkYAA85KWzdgi1dv0GrC9bYhnChsGATArnsW63xReSCqBHZUM7rmUVtRVMtSxP7Z0kpdPt3ofCe9L1YyiIvRanGT2jNobhzzOUUKlqOy/Nnfnvo0a2dz2eplHz1qiLI2zc4nbYkcbIISJHtgTYOWaKNksw/On+wja0j/NydkHVoac3mRGoTzQAVA/v5DedS0FbhpXDOO+UkuG4UHmRBzjfLTY/v43XSpJK+WxaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Wg3Z2qs6VnSFMXPmc2haT2RPByXHT3rb9YfyVLT84A=;
 b=o6o2YmsaAbM6MFYr06F0anN6sRFpIuZoCHd8J6ko3tD10quvw8+jahy6BIChv5ldYAipv2IlMs/wxQr4GpEgx7HQN/YpCZjorcQ+zFevwswFe1w/cchdJfmewWHVSM8GPyjOc3rUZVJqx3fLWW/G4awytCS6E2Gr0EYdPFOYn3OZ/6jhV/g88el6oEhysLpx1DraIedIsknxQqz3pyg0uPj6hFZAgO1Z2ofqFVlDOjIIGA+v5cqvGySz++MwYV3QWSyfdeQdkfM15WK170uJbCt080gBhsJE7+6PoQPgmMQYZ8G8yvk6tzfem3WaXgM23oqtDejtW7O2XKqGFpwDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wg3Z2qs6VnSFMXPmc2haT2RPByXHT3rb9YfyVLT84A=;
 b=pEiYykUpa43cmCfI0ZehZpDBL2eBs297NDLhC+GNQdEd4PJktilr1Rth033uaaWbx6oxhVaLkC9R65J3LelfytwX7NY6sTbM9Vrs2/8gtN4k5sWO77KVA8qUXmMsPgTUzWqezaLmjgFrRFZW9PKyJFS6Jd/l+ABE3eDDu+claDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:06:10 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:10 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 36/55] media: rzg2l-cru: csi2: Add support for RZ/V2H(P) SoC
Date: Wed, 20 Aug 2025 18:03:52 +0200
Message-ID: <20250820160413.801341-37-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f431502a-ae04-4988-192c-08dde0037aad
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bQkmky8pteT6Vbx631j02CSHrFBnYutjqcK8KibG352v41W6cn6u0mimJ8l9?=
 =?us-ascii?Q?MXRJeAF3h4/rIaimK5RcnoTU2m/PY2+uuR+E8uilfd1PTkkUJDv2QXYKawNM?=
 =?us-ascii?Q?0sGIi0OhiTloK6okE3VWnNZTL4Wr8oo2vmF7D1+LSm8foXm/MM6RmrBNUWaE?=
 =?us-ascii?Q?M2SfvQLjGefEat6Ig7n4Jp+4ghAQqhHo+4+YqYQBwWaV4SK3lGl6l26ioo1v?=
 =?us-ascii?Q?im7av3XKiZJsag4iqBRGSfmdF2HE1rXPp/v6GIVq4ahK1RCb8LuddWUnpdx3?=
 =?us-ascii?Q?6m4kvZrEK1KG9OxS/fTrV31odiOY2YPnQo2UE2eHUcHgzGese6qz/BIkVXMD?=
 =?us-ascii?Q?BHIlda0342TAe6kyKKQhIkbTfCuwCDaPzDuzdxrmvK6ImaX1Vm2KTHUWq5OF?=
 =?us-ascii?Q?tq4/f/p0nbX8iEDw9Ea2t96/bODRbf87BmkpWNtZYtNhE0lPjwM+TIGimxKN?=
 =?us-ascii?Q?F23LxYMud1VsRbme9lAt9iu5XkPOxs+tPrvZ5fDMTgp9SJrF1R5BUmLWNINU?=
 =?us-ascii?Q?HtX4TJiC2tZgehDu6fPR55csAuyqQkYjzqaq1Rrjs7pWLyv8uxRuk/lwKFZ8?=
 =?us-ascii?Q?Vl/87L8BAcGkjYQ2J4S252ZRErmwGiD0HdhIuKhH99vyptw1seiMKTtFJSAg?=
 =?us-ascii?Q?bNC51IAT7yA7tdPFFUUYPyFmeeXW0STMUWEtWmnigxVmzgtjKJpMGPMsEwHa?=
 =?us-ascii?Q?FhoYwtIZLeo77l5yp12rTCsTLVPzj3e245yNa/XMwT1A5wSQF/RRJdUqgxu6?=
 =?us-ascii?Q?4cqH0XKF8wNuxbW9QyROSgDA09JUQSn6kRXn53KFP7IMm/VQP4N5oc2x2PQw?=
 =?us-ascii?Q?gyDOV3kepcWrw5m4n/3x9qsoNb6X4FLcfNcCL0p5j24E1DgIC4kxCASpxcyD?=
 =?us-ascii?Q?yAFMswg4bA6zhd6gRoikvnsnpkaFxLF9088lcTQO/Wt2YzegVwyYaKXkLuaJ?=
 =?us-ascii?Q?DTVM50yme5bOJHKEpQ1wHEFlqqqgVO3z3oKJCaJhn4woQu+eP8kDGsNPovjf?=
 =?us-ascii?Q?ALSAhzM7prki/xgTWp/uDjw6uSd2JuVweX0VEwFrCLCHdZDKGMpDl0Rh5FXz?=
 =?us-ascii?Q?dO7ChOYvINO26s6u6iKK7EcEGeGzpNAhTw5EKDOliQQmPiu4Arjm0Xq1ziXU?=
 =?us-ascii?Q?SK0gPP+s3hj9cNCQRabmAUjPfHkq85+kE8QobBJ2VIAOioZglXpz9KlYeLYN?=
 =?us-ascii?Q?TCGyxZy7yLJSLK2IpMHaIeiJuxL8WotBAjtsuGPPto+XmJHSZ0k8D4aITTWP?=
 =?us-ascii?Q?GUearsRJzpE9hB7N005Vpcd+Q/eqR62C4kWEklRih0RKlLuiM7ycfu5wOaa6?=
 =?us-ascii?Q?D0SV8S7xtMdIAANdLKO0aS/zzL/ycH4H43BR5LdfO/ZCMxHxAzY9R4ThivHm?=
 =?us-ascii?Q?zbgX/UBdeoB8IyLAD21hwni0DMUr0KySPIKsyNO1YnJAnYXoTfBSsRfrHDrw?=
 =?us-ascii?Q?Wn89QIn2de6tTypuXBq68/CvxXFNt8+a7SCUbrOAxHoyQs/XonH3QJjUaSEG?=
 =?us-ascii?Q?oH1tgka+Z3M8XUA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tVLZdqc897VKee5M4lOJZX7iZd4xfnWMvFgOP+MoPVJHeNZktElegd/1OzMf?=
 =?us-ascii?Q?kGJ/EofEIt9cbpn3hFZCU1MQVccr47VdlSJ/hhHEoPsbjlSkANJmL27Tbm30?=
 =?us-ascii?Q?b/lkIjzWCyrkO3kzWV7sMDGpOqhMrznvHEndMLn3GeFi8fjTKMOGktlQkAna?=
 =?us-ascii?Q?7lg7AjKLLH6N9K+W72o0YXFvf/fSqK6weKWvfxcdv9E4LslzVrdDB3fZoGLZ?=
 =?us-ascii?Q?QAz88T/t8MpEGGON2spWn0SerZuAfukqDC/Kf9RLGgC0D4mOFCkFnLu9xGG4?=
 =?us-ascii?Q?lQzNHNFRRyrYsHVLcLDtgks7UrmZRdiTzWr3XtQLv5jUzcTub+axD6ZmewSP?=
 =?us-ascii?Q?CRHKFufxW7t1Yju9SHfFqmkKRErVJ6kT0I9SS0DLPzDZhmnJwOAGSop8EOsz?=
 =?us-ascii?Q?hHd+seDjaEQNpua/dqIsm/hqusSNOXx4jHz4BqAkYqrkvtme5RJHvhddgA57?=
 =?us-ascii?Q?u+sESvF1uEX68mEbUCh5nRmtcLPTi6SjpAudrUD1cNxhCjwHSy0ebQSAej7W?=
 =?us-ascii?Q?u/uwwShMVm5twcoEjVcj5tYsyWqp9HTBPXJIJPhpxXeBmoxrEo2eCgPhBywN?=
 =?us-ascii?Q?Ph62gEf8QJ89RGwa8GuL+aBSWB+q92rExTEcUH8B6J+CEz4QtZURhY+Wl12+?=
 =?us-ascii?Q?OtqJhrMoYLUMopHbUGP0442BesbLOqWjMCSZXCffR4YqmNSy+g4TqlohiDYp?=
 =?us-ascii?Q?IRymbjCI8b1VjXdiwMGX32JVSmBMgDamSjkho3dGB9VcdqgL5BIWPAjlrayp?=
 =?us-ascii?Q?bS89JvdAj5azxIHxSfbHtc2od6miw+9JQJEW3F3AqkLDx9NumEvZUOplq5H/?=
 =?us-ascii?Q?ofWLQuvS5z121oKpNyLItta5mgBKg/N5TcHRjiA7baCZX2zLwXnv9F5dMn/C?=
 =?us-ascii?Q?wf7txVZvCiSJ/WY1AvxlLuXuVHf8RUHJvJ/B9xHL3UiIuwhT6pcZyicd+2vx?=
 =?us-ascii?Q?pMdbykUHwaG+CYhytju2zBM/cqNt+7cRovv+TJ/CNqh4jHiCyhifVsOaz7QU?=
 =?us-ascii?Q?IKcKzlBQKi+rCYGqPOiRxhvpb5ek9WbyyDsTM0sxk7rb8qemifh+M5wt8HhQ?=
 =?us-ascii?Q?yhTnd2SH7l7gdK1QjvXAMM4P580Y/fSyyGQhlbwbgvDCSEbpQmrFBQHbgmf2?=
 =?us-ascii?Q?WKe3UerJH5bD4s2LYGrssnDrY/mNEk3JxY7ksK4UbBAAJ/yNlW1T7WU46Vmu?=
 =?us-ascii?Q?5eAgTQfRyFhtPc2LlAjfEEPbJnPdZ9PO+xZEbNehk2G7zp5paF0ShgVIny8y?=
 =?us-ascii?Q?K1Vqkv8GNJv6mgmDYgD2qZ+8F+Yi7Az9lVv+RXaewMCVBOj79K1fdT91EvYF?=
 =?us-ascii?Q?zj6pXnAYdGjnsRQlTBYtKzmP81Ij487BeWMvst89bz2l7BgCCDQ3FQG9plbQ?=
 =?us-ascii?Q?ETDzM6AsQ6veBmEzfZOc3rhcvaPQsLKJQdYAQ5n+dut/C0hi3cKFvv+EYCNZ?=
 =?us-ascii?Q?YVDdKPnQ7wNiycP0m2wRbWz7Zh7d8Bw3dMr0R2z9EYIxf5Xh+yx6TT/nNiGz?=
 =?us-ascii?Q?BY3n88fiAMEQRP/cR1AorGX3XI5daCFJbz82LaXQxGAgUYrQAdzAB4H4FhUV?=
 =?us-ascii?Q?9U4InCeIJR72aHwzXYRayMYQNDcYE839WZlFSLepsZ2A1RwG3wfLf2BdD2aZ?=
 =?us-ascii?Q?zfxYwtqSZ+9PttTR8eXyPGI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f431502a-ae04-4988-192c-08dde0037aad
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:10.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +S3JaeojP6f+2NYwUA7obmc/tp2MbL9T5JEG0Lh/GqGkChFiVtAnkssERyMuXC1XZTr4JcOfY6ldjSrpZh5sHs13R7NDhKQbenla5xZSjyMSXPghSeQRqxCP9YVkStuL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19861

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 995cfd09ff8f60f57b3e3d49c809921b59993bae upstream.

The D-PHY on the RZ/V2H(P) SoC is different from the D-PHY on the RZ/G2L
SoC. To handle this difference, function pointers for D-PHY enable/disable
have been added, and the `struct rzg2l_csi2_info` pointer is passed as OF
data.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-11-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 5868966db28a..edd08e08f62a 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -86,6 +86,15 @@
 					 CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(1) | \
 					 CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(1))
=20
+/* DPHY registers on RZ/V2H(P) SoC */
+#define CRUm_S_TIMCTL			0x41c
+#define CRUm_S_TIMCTL_S_HSSETTLECTL(x)	((x) << 8)
+
+#define CRUm_S_DPHYCTL_MSB		0x434
+#define CRUm_S_DPHYCTL_MSB_DESKEW	BIT(1)
+
+#define CRUm_SWAPCTL			0x438
+
 #define VSRSTS_RETRIES			20
=20
 #define RZG2L_CSI2_MIN_WIDTH		320
@@ -141,6 +150,30 @@ struct rzg2l_csi2_timings {
 	u32 max_hsfreq;
 };
=20
+struct rzv2h_csi2_s_hssettlectl {
+	unsigned int hsfreq;
+	u16 s_hssettlectl;
+};
+
+static const struct rzv2h_csi2_s_hssettlectl rzv2h_s_hssettlectl[] =3D {
+	{   90,  1 }, {  130,  2 }, {  180,  3 },
+	{  220,  4 }, {  270,  5 }, {  310,  6 },
+	{  360,  7 }, {  400,  8 }, {  450,  9 },
+	{  490, 10 }, {  540, 11 }, {  580, 12 },
+	{  630, 13 }, {  670, 14 }, {  720, 15 },
+	{  760, 16 }, {  810, 17 }, {  850, 18 },
+	{  900, 19 }, {  940, 20 }, {  990, 21 },
+	{ 1030, 22 }, { 1080, 23 }, { 1120, 24 },
+	{ 1170, 25 }, { 1220, 26 }, { 1260, 27 },
+	{ 1310, 28 }, { 1350, 29 }, { 1400, 30 },
+	{ 1440, 31 }, { 1490, 32 }, { 1530, 33 },
+	{ 1580, 34 }, { 1620, 35 }, { 1670, 36 },
+	{ 1710, 37 }, { 1760, 38 }, { 1800, 39 },
+	{ 1850, 40 }, { 1890, 41 }, { 1940, 42 },
+	{ 1980, 43 }, { 2030, 44 }, { 2070, 45 },
+	{ 2100, 46 },
+};
+
 static const struct rzg2l_csi2_timings rzg2l_csi2_global_timings[] =3D {
 	{
 		.max_hsfreq =3D 80,
@@ -435,6 +468,64 @@ static int rzg2l_csi2_mipi_link_disable(struct rzg2l_c=
si2 *csi2)
 	return 0;
 }
=20
+static int rzv2h_csi2_dphy_disable(struct rzg2l_csi2 *csi2)
+{
+	int ret;
+
+	/* Reset the CRU (D-PHY) */
+	ret =3D reset_control_assert(csi2->cmn_rstb);
+	if (ret)
+		return ret;
+
+	csi2->dphy_enabled =3D false;
+
+	return 0;
+}
+
+static int rzv2h_csi2_dphy_enable(struct rzg2l_csi2 *csi2)
+{
+	unsigned int i;
+	u16 hssettle;
+	int mbps;
+
+	mbps =3D rzg2l_csi2_calc_mbps(csi2);
+	if (mbps < 0)
+		return mbps;
+
+	csi2->hsfreq =3D mbps;
+
+	for (i =3D 0; i < ARRAY_SIZE(rzv2h_s_hssettlectl); i++) {
+		if (csi2->hsfreq <=3D rzv2h_s_hssettlectl[i].hsfreq)
+			break;
+	}
+
+	if (i =3D=3D ARRAY_SIZE(rzv2h_s_hssettlectl))
+		return -EINVAL;
+
+	rzg2l_csi2_write(csi2, CRUm_SWAPCTL, 0);
+
+	hssettle =3D rzv2h_s_hssettlectl[i].s_hssettlectl;
+	rzg2l_csi2_write(csi2, CRUm_S_TIMCTL,
+			 CRUm_S_TIMCTL_S_HSSETTLECTL(hssettle));
+
+	if (csi2->hsfreq > 1500)
+		rzg2l_csi2_set(csi2, CRUm_S_DPHYCTL_MSB,
+			       CRUm_S_DPHYCTL_MSB_DESKEW);
+	else
+		rzg2l_csi2_clr(csi2, CRUm_S_DPHYCTL_MSB,
+			       CRUm_S_DPHYCTL_MSB_DESKEW);
+
+	csi2->dphy_enabled =3D true;
+
+	return 0;
+}
+
+static const struct rzg2l_csi2_info rzv2h_csi2_info =3D {
+	.dphy_enable =3D rzv2h_csi2_dphy_enable,
+	.dphy_disable =3D rzv2h_csi2_dphy_disable,
+	.has_system_clk =3D false,
+};
+
 static int rzg2l_csi2_mipi_link_setting(struct v4l2_subdev *sd, bool on)
 {
 	struct rzg2l_csi2 *csi2 =3D sd_to_csi2(sd);
@@ -909,6 +1000,10 @@ static const struct dev_pm_ops rzg2l_csi2_pm_ops =3D =
{
 };
=20
 static const struct of_device_id rzg2l_csi2_of_table[] =3D {
+	{
+		.compatible =3D "renesas,r9a09g057-csi2",
+		.data =3D &rzv2h_csi2_info,
+	},
 	{
 		.compatible =3D "renesas,rzg2l-csi2",
 		.data =3D &rzg2l_csi2_info,
--=20
2.43.0



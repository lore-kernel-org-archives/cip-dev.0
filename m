Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B03CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:10:04 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.3])
 by mx.groups.io with SMTP id smtpd.web11.1063.1755706196987968649
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=w4TjiC3+;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.3, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWR7zACF9xuwEzqocVVFveH+NHhm3deJeNcSV1eVMmb1DycniKHr3cpzWBoDGCfmtzVrUi9gjE75akp3/t5ndfrRdyq+kYkTFSe3mBLz/kVGLayXD2yh1HdzBFA0+xPw4Rcz+chYnVA5tmOFtTJxhe27Euodms64HOBDqVX52pBfDzjWhaqQERKVhWeSMtlWmKb6gcaJOZ55i5ZmV2eU9ZejR08vxzZRxxYXYjRPcYIJxI7pNUkPWNDr3qMhg25NF+It7nD9Xm/I4Ld9bCn0uuUxEP7MJykXWKKNA4XFeIZ73r5JacUfUX4mZ4FxmNjHoYWIM5eZV8Ao1vW8/5iRwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w929kU591O0AG4X9xQQhsaY0ygZ4UQ+5yHg1VciW15Q=;
 b=fnuQ7ygFm2TclG3nPikb2SgYfnVNloHzZsfb20FeTMV4da/8kl2qK8C/SzXadm4TKuKItHoWGGkWCYLYc78Ra7OFkZJcxzwpHXoEV0N9STLDNlBPPFNewxihUM/0BqSrzdUvyp/OaaewNrFlCfj+4qETPUAdm/FGnvvgDs0aG+qoTPJTkk0sZK2tNx+Qj+qxMz9Y4Row2+ToQvz3HEp2mNSC29//Itxu1OtyIhMLzGzKeXnouxc8tVQJmkmdW0BT+AYDUA6pCcFe6ozQ3as8K4ktTs37E0ZhwMnDDXs0UFRX8s2hyRQfsgCjdx7evDCCKB8CLPNssR+lGp7OVoB1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w929kU591O0AG4X9xQQhsaY0ygZ4UQ+5yHg1VciW15Q=;
 b=w4TjiC3+epjIq4uso259vKawXlkMHGRjpOzb0EafLbodik3pBTgbMrpTLUyZ2q8+4Lurn/paYssTLb8XD6ixP+S4LE2Jko+Ac9ahMhlomm8a2KZQtgPCphob3jC+pu7GoWyWiNnBxuHbPunkSQiHzIn/9pU7J3mQizVO624p2/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:53 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 36/55] media: rzg2l-cru: csi2: Add support for RZ/V2H(P) SoC
Date: Wed, 20 Aug 2025 18:07:37 +0200
Message-ID: <20250820160758.801813-37-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b8b901-e9a1-4586-95cb-08dde003ff90
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?neLZ+9yE74DPcvBDDpOpT+TrXmrzGy/2g5YWcUlwGsjzCBqY79DT/19JfoT6?=
 =?us-ascii?Q?PQn6FpLm4hPEp0xRX7HlVqdfXWmirdCssB8Dw0oAn7uEvdH0mXrKs+FpLN3r?=
 =?us-ascii?Q?DQwQZFtdyCQE/VvjKvf1Fb1fGmj4qeSqkNmkfQt6TlLxXJ46zQzILXoMSmIi?=
 =?us-ascii?Q?vWNUWnUraueWeUqB5baUloWXMRw5ICyVXjR1brmYjzKmVjPhq5IIljbpGX/o?=
 =?us-ascii?Q?qWZwNRZTEJhqJDt9T8KOcYNsbma+fu6RMVMRpbweP5gSc4zbLiPxxm3ckPBk?=
 =?us-ascii?Q?JlV7V0Fc1V2U/vNp8xo9Y9MCG/4YylEyWOTsMG9h/cjCNXbsf2Tehnk/od8g?=
 =?us-ascii?Q?K05ByDY9Qwspiux7Gdcnzl49uARVEJ4cLZkC1YmYRi6z85EUQzmlOIEQj/DF?=
 =?us-ascii?Q?P61UJehS925NKRH2nApBwKtt5lMCKrop3hsy6HADlGDgrmHeKmE/UWLSa+K0?=
 =?us-ascii?Q?tQ6YT0XXof4q+EkMvn/CU7q1cdQKuhEgd/obaBfnTL26II0Jei3ygkOh+25W?=
 =?us-ascii?Q?ypNvfe9FAqP1PFzDTIosjQLpB2000iYzDqKO8NsyyctI8NU3bfIGL6MWk0lO?=
 =?us-ascii?Q?svhZfKIfGZSETXKMt35WTe6qS5zg2JyJUr1BqjUqQm4cEB0BfbDtX1D2/UH1?=
 =?us-ascii?Q?xUWXnTO02RHVw9T203F6SiOG+/vT6WFv2zar+8K4MmKoWESWRvMnjI/4x339?=
 =?us-ascii?Q?vnx+N0VMEemHLuhJ9cRSEAzz/TeJMfOI5ayiuH5OoXamX9LCzyCX0D/9aXyG?=
 =?us-ascii?Q?A7aGFWHeXgz/5bBI2GonLdK5gQtBu8oOkMIilz2rNpy9UZ94S09A2mDI3dGN?=
 =?us-ascii?Q?nI05Sz9ow4PWyPmFbfxJPUqhXFFLLldl3w97X1U1pahPOReXeEG/FNIgKwR5?=
 =?us-ascii?Q?cbi8V7URzFtvyFrLmp+Fo2/a18zKvJlcFs0yNcbkAYqVJtARwducvGqY8RDy?=
 =?us-ascii?Q?cY5Mgy3+eLvAE9W3y56wybAbiGrjb5cxPB3cAGQHqS75pbrjGoc+ywbuMFx7?=
 =?us-ascii?Q?KJIrKTLJL1OLuW85+l19bl+Ufr44619JTPV5UsGjAWC6ep2MWWq51rJuGaOW?=
 =?us-ascii?Q?9EIxtp8AqUkLbRasMrwhoJ7CzWUC/VqfujNctJwVjmagt4123khoe34bPuWl?=
 =?us-ascii?Q?QtYjhie4cu3Qylp5HFpE/zbzqe/w+rWK5gRSOxstZ35QhssND45dM/wh47CK?=
 =?us-ascii?Q?EEGnrwU6MQWVQ1YnlFfAf6F1IzrgAs3xRDXhb+D/vIVQV+eiDu63J1d6BQRg?=
 =?us-ascii?Q?yxl10wvl8z8oq9laQaTJ2S6F0x6cNmZC0WLgMjvPaFmP6YvC1Bt/gC3HtRrN?=
 =?us-ascii?Q?vVu8u33NwkBaZorzioXA8PKU5g+rK622N7tJaN9RaNBsCO0queTi196yv8Ax?=
 =?us-ascii?Q?HEUQORHhCZMC+XsziX5I8W0Aq0ooruOwlJmg0maR7eppkiERAuu0O/tyFUaS?=
 =?us-ascii?Q?89wd5VYQ4j7nXHrmBDBOarU15WMWLdUABQI3wt0o4EF6Bxo042KKzV2ptuUo?=
 =?us-ascii?Q?Opx+SDP4IM86Jzo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+aR3pfSWNwrtNY4ESjDWMQ64JzRMFzNTFvsJTBz0DTnC9PXg2D4Awk66imfU?=
 =?us-ascii?Q?ZB+UZQIJlSdF/MP2vvWxxvt4mcSsNT7LzjXKvhn1Fgrxc0bLXYdVz/zdCWR8?=
 =?us-ascii?Q?HuC6K2humzeY8xvMl+ghR5+bchr6ODCyWCNlLiCncgAxv19ul+uWqc3aUl8Z?=
 =?us-ascii?Q?eJZ18coP627suyWOlmsuIqCv4BlNXGCIT2r7yke+Qi8epiPPvkbM7VlJG47j?=
 =?us-ascii?Q?AxP6+/IEPVWmaKsOJIeM2okaerPjH9B+YNBUhogns60r1MCMj2vQigRAQFNZ?=
 =?us-ascii?Q?tr3mc4kDWZaBGeCsChgZqsUGplzx3gMcizw0jrkUfdqU5W4Cs8GzJ8c5m2aK?=
 =?us-ascii?Q?Shc4h1fO7WgpYx6X9173o31HX1FVG2v/4k41kgbDpfM+wsF1IqFjsLSmvOgF?=
 =?us-ascii?Q?1SKiPMvuqJXc6YqgTlV/tmcKaoAE0Xm197u9OEIw0ZEPxnRffa3R9C3fUjtj?=
 =?us-ascii?Q?XhRtoEiXnlKO3xkheUZ8o8xOmkAgafa82NIBCteKkW8CkKvamViTlQAbBgBm?=
 =?us-ascii?Q?QQa/1tGqmIsejG1AbbtnGuZHiIBbtOzBvYQeFKRTzfI/Gw6WmOnggyRGs0BL?=
 =?us-ascii?Q?per3dgtqi9pHI1UjEqQ1fyPyo5s3Gxqd3TQHrIOTsIwV7Cdu/MX2u1sIV5Ri?=
 =?us-ascii?Q?RqdOHtfVYzk4IZR2USP2fmUFKfuEtCRozjUBUPchgFhVfshe/jjn0O8sq4U4?=
 =?us-ascii?Q?orSeB2lz5NYrEBQCT6iOqgsQXVAPpwzVqmK+VFEchM4hQQ1KM0Mt/JlP3Kwn?=
 =?us-ascii?Q?xGBVMpeY2ytIjqDzQYu4AG/GljNtz2S3hnFNbT/zvHmWqr2WwzVje1gOCLst?=
 =?us-ascii?Q?G2rwSjxX18lojxXbt0uf0/ZoG6hLrPeE7orRD7RBZX55R0aSqLAQQOn1FjM7?=
 =?us-ascii?Q?rnfpLDezT8j0cQQJ++AsfJ4iuO5iBgRpuSTpnOnBpc4X2pMD3OSRw5C5EuSx?=
 =?us-ascii?Q?epYr+eORULd2kyRaX0Wprqpilb3dkZoBQopJxRH3nrQh73MGhvGjWypYQPJ9?=
 =?us-ascii?Q?h8TnF/AaAWfinYj75f51jDsl4XdWHYI9AQKCeuecYVKrjbC989KQqfdCNn10?=
 =?us-ascii?Q?iHgJgXIqmxJHNrXBlHNGyjM6oq/RiFvjMSS/lH/2RJ8f6MzQtD5isAjMeD/p?=
 =?us-ascii?Q?wsle8R6F9+VvQjMntCmttaNwL+1QsZKxgIJa3eMOqGEA20Y1DLllsf23Znf8?=
 =?us-ascii?Q?j5q6PC/uvP7HqlMtNOrfBOtSDb3X5iyvyiwyaPlvBpGknXf/2vP46xwY/pS3?=
 =?us-ascii?Q?sd7fSC6MjOUYWQsfAKijTXa9JTsxLzGqXjQLznZn92bqZk2HKWky6hnR5Gcj?=
 =?us-ascii?Q?xs744K3i1y1NkPC/Typ73ZcXw8bSsEd1ZAdy+rS/BK+AMqLP72xtahaWQ7jA?=
 =?us-ascii?Q?lB6VQqtI7VvEweg8CRfM0eF0f/9Ow+jzPUsImK7vA98Aityuba3FtVF5y0NI?=
 =?us-ascii?Q?0GkJ0rkXtPn9sj/vgXY8XmMLAjI5G38uHOO5EKdd8+Xcbnh1/B4DwHLUEalV?=
 =?us-ascii?Q?vq1vmKeh1GrBEFpFExR5e8GJKD3roVT8miFiAIhB0I6YP1zBVFI80ZR6t/Xv?=
 =?us-ascii?Q?asPB+4oFuN7sQwoT0MtOLzdLU+BZMZ9RJowpXlsC4mYvccbt2ExJYe2zUSxr?=
 =?us-ascii?Q?TPjmlcKIpzkd4uXnRX8RLqg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b8b901-e9a1-4586-95cb-08dde003ff90
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:53.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wF7nNJu0UX3+n9qTAlIaiFxn5CnXFcbNso1peYvf7l79F/LoVy/MPBcZ5kQI91WKnpGfOT5KMz53jwXxPwG4hk/AY5uusLVAgMqNl6apvnbQVoPJ1PiHxVOnnQ1B6E0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:10:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19917

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
index 88f904b2eef2..b2654aaba2a5 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -85,6 +85,15 @@
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
@@ -140,6 +149,30 @@ struct rzg2l_csi2_timings {
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
@@ -434,6 +467,64 @@ static int rzg2l_csi2_mipi_link_disable(struct rzg2l_c=
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
@@ -910,6 +1001,10 @@ static const struct dev_pm_ops rzg2l_csi2_pm_ops =3D =
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



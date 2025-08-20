Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A11CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:03 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.68])
 by mx.groups.io with SMTP id smtpd.web11.911.1755705955210156839
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gMbvPna/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.68, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjFJnxpD8n5ZVf2C9pOO00WXkCv6eEvQgkHAnaEPA8XTv//XqcLeiB+ITQnS139v7U6KuSkvHSaSnOL+s6fAgXEGUXP40kWLykVXCr29k/EzsBT7t17WCpcnGbwvafYOR93uSeOqR2Lx0yrVBaW1GPAIDD4YDeUc/FmOBwEIHrEAETbL5JAcat+l6exTCSNqOTTn7uIfSaCGvIbnO5TMmlmE2LHQhJRLKtzGWXzhRyHsXAkD4MZZKn2IyqBsEuEgTBOjdoFlyKdiAqGlZtA0DRN6aa9sboIT2moQ/hps1m4mfjdUaYw3nDKejuesEfFnyAup5BqZOUfqq+yCpwSFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04JeTdIgotVUDaIbYxYfonccpH64YKEIFIAROtup1dM=;
 b=Rt8CqqaXWM4iVhs9TW2fRNYoP8BzHy4YNqsyg6+OQPxjX+ynUW5aV3jJDIYy29tYMGKb6wnSh6jUFn44/JW//twk3w+7i0LxyRMZDy/Q2WbgnDkSEy7EuWKNttIeDo1le2aAG5uk4/5gAi8luJHh21oA+uFuQ9Q7tIjzN+E6tI7AhHsORHLRuHzfpJck4gUXvLDJLXN2dzU38UmxbYIhwqB1ihLj9Hjjltp3QB7xdvO0KnwpLgE3dgUStH8UP422i8kAkEPTJvziejBoj+N/IxK3rU06j0L+O+/C084bvmmg3QxVZxmjDTqJScwrrvOBj0jwKweh1pHThovP+H/PYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04JeTdIgotVUDaIbYxYfonccpH64YKEIFIAROtup1dM=;
 b=gMbvPna/PH347Ebu+We7bUaJbWd0QAob3tCLqgXzE9fEc52QZCmxv61+LvA/FpKgLUIu5HJkpwAEQYDNrbz5ZsyRlV38lpbkdq5jZ+dxt3xksbcqRdeGlITAkF/N2AhTflPiNqMm7dozqC/VpZ4MOiwXE6uGigenjEYL95IvBBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:53 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 29/55] media: platform: rzg2l-cru: rzg2l-video: Fix the comment in rzg2l_cru_start_streaming_vq()
Date: Wed, 20 Aug 2025 18:03:45 +0200
Message-ID: <20250820160413.801341-30-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1fe9b63b-595d-421a-13a7-08dde003704b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZQg9dZWExc6gbY7YnJzQAQw51XUafls/YFBxXOInITlB9wMTB3fIefilL7ut?=
 =?us-ascii?Q?p2VkDuKQgLAlH3bvD/XO3jo+t8YEC/lxwWccnnEK09NFTbvNYfxSd/dZ/kcr?=
 =?us-ascii?Q?gxuuBkswesqI1/TWK2teVEAaPT665Oy9RlxN35r9LspR7ISnw3Ina7IjSGh2?=
 =?us-ascii?Q?nD8Q22LUFjIT0biilrcUYhJ+fTnDgZzWXxo6BB9gQvEsQDIoRpfmAdIQsm4R?=
 =?us-ascii?Q?9Y5CHf/XhcqM+7XIDZqDvGgoNfbmkqGkx6u/DbovNZT65Ca1mkEivh2B9j3F?=
 =?us-ascii?Q?Opd/vrX47YNFUBy4lbJbvEfzV3YPYpBJ+VzVEfli0e3YrOYkh//nas0IYkX0?=
 =?us-ascii?Q?pfEB8ig7+3Nsw3isvlLLZxqE2/VPEoyXyWX62smQOjqxlfOzwaVf+8wfY0W2?=
 =?us-ascii?Q?hz1cgUGeLjxOOHsOeQ7G3+u9PksEq5sXuZhlwFcssfillOI75ui96t1Gu/rL?=
 =?us-ascii?Q?+5gMcPg6KUFtrQehLM0Nxllc8w4gK2hBCJ6kdhL3iQYnZl8/rgqoqb7ihVXE?=
 =?us-ascii?Q?ncZR8iDR5ETED2wheKicQ523Yk70I1zdm8RGwTSBbo0IirRv2TztxCDPiynT?=
 =?us-ascii?Q?l4whiB9W+oGnMe4QArIg+Wx/mm/R6GAYB+H/+CK5KuNSwugjt11ATlbsMdW6?=
 =?us-ascii?Q?mT5Z9s3z/m2KGar9dIcnvBt9mjQbjJ7e/mMEzluKSbpZjuEy5ccDIDLPr64e?=
 =?us-ascii?Q?6d4nM+tjfpZwH+5OtlDoy+z7HYEh0FrACzFV67/4Mj0mWP0EhRPNv9JK5EWc?=
 =?us-ascii?Q?wzbFI7flj36+yfdvrVKe4DpEMpedQ7SK1+k9Ghtfu8ZwmIipKg8YxaFke9Le?=
 =?us-ascii?Q?dzuUWuzdB/DcoE5gir0/6SOcfMZPvFkt+D2a6P26j9MpYVoWqo9wY0rp30ND?=
 =?us-ascii?Q?VoT4ZNQrFBUzayDYx4ygjsqkkiND9qkrU6qXvrK1N3AO5EmsrCcY8vVtYiyH?=
 =?us-ascii?Q?PSLcM39G6my3tovEaOJv2mrsX8vx76+HKFsv4BgcZghBptKa1rAiHB2NlDAp?=
 =?us-ascii?Q?RG8ic18lgXSG+roXSmIMBTW4h6gWHiXoypjOidofiorQrC5JLJ9Z59fYxb9f?=
 =?us-ascii?Q?uU+P7G220wU3XHPtOvLaWgGqTkdyTMYriVr6btgclZTKbTZZVOLBBEu3rDs3?=
 =?us-ascii?Q?Lv9ux0MpWkwOtx2eNHa2OIVwBvnvjL6kp4Vu/ITMKcTtzymvCumpj4w/kG6Z?=
 =?us-ascii?Q?PTv7Y8WwFiEzPd9aPQH78d56g7QexpywzBKDv2Y6eHNIZCkkqFyBP1wOfwHb?=
 =?us-ascii?Q?21nBlVMZWgJyuHLI46vtWlKcklTXFYSYWCXhu/zRNmWjqeXB2B52+7pz6Rat?=
 =?us-ascii?Q?ttndlOSMX5f27AGq+7Gdiw79euZCV0FX263Yl/hgqc2qOiYciqDBLdXgjemn?=
 =?us-ascii?Q?g3i4Wd1nOgzawmnbUX2Joaw1grwLGCo6YKFnEIp/me7HiDak1sGExTAKIqDf?=
 =?us-ascii?Q?8uTP95Mm+vmDjPLRGrPycrgmasRp7fziEXsBvcZtzOWtrCgQUeKoDuXtcWHu?=
 =?us-ascii?Q?JIOceO1qjdrWdpE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YHy+GLmqjro6EWpfytZyS7YqM1SEUbxJuSNGDqBe3TOjk1FPqy2lcGYM9aCG?=
 =?us-ascii?Q?mOdb/+ligHrw8hzJNXI/fYEq5WEGqXaFyQQcNzr60e5zDAXDeIcEql1KdW+1?=
 =?us-ascii?Q?/KDYq7hn5yoqUUpaZTdrjUme/u0ldXpJfSctqBnf/7nSSMQRXyWUuJs/boiM?=
 =?us-ascii?Q?CdhHyI2EQehUnVtDDpvLDfS2N79Z1pwAz0VOt59cSmq0LH63eO73wlDvYOGd?=
 =?us-ascii?Q?DLrCE/Ei30YEbl+stfn/nzU80djc6BfFUtOD8wDHEk+4LzeYvI0KXTo822so?=
 =?us-ascii?Q?8nZycSXYLmjuNRNUnW9WEzlT3T9S8LJVFX0aYWS77OvbtwY/GqBK75Pj0II7?=
 =?us-ascii?Q?BRIwqInkDAVE0OrKLYwgQZQId6x2r56w9IBabJrV8MY1HtMTapGDVB76/pbH?=
 =?us-ascii?Q?TJpHqrGauPCrgacuUfrLkMhnMmIplgcZOx49HT4dbY60fS/4T5kbiWBvXQM/?=
 =?us-ascii?Q?I6Foc52ZQNm7v/ph+Arpeqyx1Rk4ddDkoY04qYviKWUUyR1xhpvUBEWLQj4I?=
 =?us-ascii?Q?UhE2029uATiC57ZQt+tqVu3avq3e46oQvOoYbQMRZDEsUwRf6cEYFOEiGgIr?=
 =?us-ascii?Q?kECP4W7PUhXIXF6821DptLonKrjK8FsoZeoi5+3f0zH9WPhC/UdAao55TtXd?=
 =?us-ascii?Q?w/LPSa6VHSpXSlOoLX4TxTz4FE8Gg0wRuXdBH4WgzLjx+J+c2Mxg9cxJf3vB?=
 =?us-ascii?Q?SeJYLkNX9PxpE6G/J3U/89ClU7Jx2aYReK27o6rrWpWlGsNVLHd02d+wx+LC?=
 =?us-ascii?Q?Q/wLPgzo0B9za+aT74jWRE1Tab2uAjB5meeuIVKoikVgVLgmtQecIzczGoNf?=
 =?us-ascii?Q?AsCayVdnE4QpmQpftjRe6mcUKbDk+S7rsFp/QOIa6EOkDYJKsW7E9l9GN1Nm?=
 =?us-ascii?Q?J8ZM/7Yzi5TJ/p8VMP9i7WqdrV2wvQFeBzyTnuyfE1B7elTbGenj4VQIyxP4?=
 =?us-ascii?Q?iLmEJgWb71ErnCvuyIK4NsbM3nk5Kum2Bu3pZ+3s/inltrai88sMoRCDY0tw?=
 =?us-ascii?Q?8Bi8npnxLAC1xk57a1sYL+0c3q/6NFGZt+QLPTET3uzA8qGlUT6ovdd4OTi1?=
 =?us-ascii?Q?nBo+IKRKBV4wcLywZx8REl53JtVznB0h+WqopAOvBrqNbmVnSHOhrTNstc6X?=
 =?us-ascii?Q?0mtHcgQ9IujW0x2QTR5vjIE5pCdNzkseKrzf1HsjFOCGk+1SxE3lq2UHXNLT?=
 =?us-ascii?Q?WNOOfpTWvGGAEDzB5DAjzStQ1lyL7pOOf6LqaWW1uaDvnY1E/li0AvxjxxpQ?=
 =?us-ascii?Q?DWpz73SZMy2nxaiqkbw6goIJtZ8UWYrTglxaw9Ssv2hZnf4N7PMLKcDYt5eO?=
 =?us-ascii?Q?L5Drh/QiMCVTcn8iivgzx/e96kSits5rtGLkHhr865vhDHMp4JQx1Ypb4gyV?=
 =?us-ascii?Q?Szimrz4FF8dfRWbZNa8b23WA9Onx2ysR6HUMJqcg1t7vu4oAj8dOcL8W7xlR?=
 =?us-ascii?Q?hchA/I+PrpSLJpXRgV73SRrJ8tv+h8L9QPHiM/Lx7rJOt0DXRI4F3HjJKw/D?=
 =?us-ascii?Q?zMMEGVkO7aMIGPtM7hK0qztta7MVY+05T7KJ+fUNLIqtyOm09QPjFn0mRxPA?=
 =?us-ascii?Q?SSBpgmWuI4cGVsGgAvOiXXSuFGKb/LVKlR21IACxjOxHLJuly4XPEbXH1vTI?=
 =?us-ascii?Q?wLfI9QE113GDfFtfgr3Caiw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe9b63b-595d-421a-13a7-08dde003704b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:53.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFxUm3eWXWC8rz72pCT7dtUWeDoa9OyVO/Ym/I223MRHCTWq4nkNxSSowAVfbC1GjJ+Bd7SN+YZsaYF/91cCtdzXNKGg1k1QzY3+3dfb0eRdG3FuyGyUMZfhhe8XCAkO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19854

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 94794b5ce4d90ab134b0b101a02fddf6e74c437d upstream.

Replace "buffer." -> "buffer", for consistency with rest of the
comment blocks in rzg2l_cru_start_streaming_vq().

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZtWNFuw70nkB37EK@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20240905112508.160560-1-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 5ded0a1f5626..5e1699fe3986 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -558,7 +558,7 @@ static int rzg2l_cru_start_streaming_vq(struct vb2_queu=
e *vq, unsigned int count
 		goto assert_aresetn;
 	}
=20
-	/* Allocate scratch buffer. */
+	/* Allocate scratch buffer */
 	cru->scratch =3D dma_alloc_coherent(cru->dev, cru->format.sizeimage,
 					  &cru->scratch_phys, GFP_KERNEL);
 	if (!cru->scratch) {
--=20
2.43.0



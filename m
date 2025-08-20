Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8714CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:43 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.31])
 by mx.groups.io with SMTP id smtpd.web11.896.1755705934534822841
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Rh8y12Wm;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtIiOAeeNZhhnKD8p4uttOOYy9xws+zR0fDcoCZXQOXy0XDPJxwT69LLymvQchQ8akq0mHJPw6pJI6YaInkCKG0w254hru29HyXYnUddQH6c74VOPmSBsOz9nSJr4QXL9OgdMIv0FdkdcUCuv8lLhvt0tS77WiQOls34TE9dbdUra23xOgMAentlWQqIRaAGm8le1MLtIxrex7iqMri64a1r5RxjJFDRqKp1eKF8/8vFb4omM/jvhkT4u6oQF1AEL6Sl7RsO4/f1O4n+kpjtEDi3bC7Af627fkZBZLDgD23qLNt7GQ0duodGvUj4mOZ+BMJ5B+sv8K56qL+1r/LmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MKnGDL4/XUwCD/SOL5yU6xQYx+WqaNDh+B0KBHiipk=;
 b=lA7+8KW/EcY3VAh0CSDsZZc3sZEdfmxDF97xAXqIi3JF3s7s5iJDNhdO7+z8zFZxASqr67HfIzuPnv57EctnosUb9Uq5W5jTAM6y2aZm5YSqpW6dstl4bK6MAmBUSCcZwfWq8gy5DO4Bj/UlMo7z5nvwunmjAkUclw7MrqomHOfOa1tCdxPC38R8ThgwoW96XbFmHran1jA9Oz7JlGHilKqFwQgf8XqoK5BycYfgF/H+ZWK/vEQ+SZXvvqYs6rgNl2mviTAosDaov8QEWQ1DyAIIFuK6ZTuXD+AAA+kzUXAjEoM34Sp9qeHUy//h5VF2YIWWbuY77G1LGt9dSWj7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MKnGDL4/XUwCD/SOL5yU6xQYx+WqaNDh+B0KBHiipk=;
 b=Rh8y12Wm5GflRVIXSqQ9IisY/Ta+i43xvhFM8ueYsJbqXhW+gnyjkxdFtbJLIUW0IuAjF5CwPaw31YGH0r3NbGQDanE7lYvNc4niqZUZv1oYFkDiOpQ6Ziu4T0GmXls+T9AaQNURXuLZUifz5G4luPQ4v5W8ts7ZGQ+1BDhwfZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:28 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 19/55] media: rzg2l-cru: Inline calculating bytesperline
Date: Wed, 20 Aug 2025 18:03:35 +0200
Message-ID: <20250820160413.801341-20-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 810fa96d-c10d-4cd6-e10f-08dde0036179
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4mehoxNhVHWEl/CiOsfJyHPE40cz9v9G4VU6eodzMFWQWhPlHPlgd+XLreHB?=
 =?us-ascii?Q?OVq2+4wzwmF4efzvsw1Vo5qbAgkvAn3NGLKroKuBfasRrg2jBjocSuB5uqn4?=
 =?us-ascii?Q?egAIDVPocqofJoIZdqIcfznTVY89nW7f1SIxpThh9utXXRHNm5oQ5kPvkDNH?=
 =?us-ascii?Q?jvtVoiFlJu0MpO9vY1EyFrjYjbQ/VMu0BOUDQUqS5SUNBqMap1jHSmhv/mom?=
 =?us-ascii?Q?AUvBJpX52l0BHh+M4xmG0orFbcX16D4HTYB4nvK7+JFwdXZxxNk1rwXu6Z8E?=
 =?us-ascii?Q?rP8XgziOjCN92JXbPH/AoI1G8GM2/e80/VUKO+dIzB6sL3CY6M/hHfSG4Bmr?=
 =?us-ascii?Q?tg8narfS/C/phIiQ+6RBZCtED8IUX4iads9Wt1P103EdG800eXSKirH3VfVL?=
 =?us-ascii?Q?9WzQLYjxgLnTPjP3lK4rfQWdt9xpffNwKCaKIEzSLqoHvVWv9sqWKE9PGgmd?=
 =?us-ascii?Q?jm2NuNJrx3sbUxKIvpYqFE7YXwFxnaXIhd2cqtyiwXdI1qBRt8yQcJ9KbVaw?=
 =?us-ascii?Q?dthxf/bgad8HaS71jBiwtOxrEUiUDDevu857Re5PQ1DzO3078Sr2gocPRRHX?=
 =?us-ascii?Q?UW4YPiZe+RlCT69WRi54UzeVeqNqYDBZJ7JliwyaSChUPp5/UHZUmjj0d3Xv?=
 =?us-ascii?Q?a2pi6q4mYzLPVe9CAajc9wf5qj/9zk4rJjImUe2GS4dIpC54yUjIOtFw4ayy?=
 =?us-ascii?Q?Xf05sbzU7aupQk4lyOACuIhSm7TtatKgR6dTy2Wf9DujxEP5k+KC6WBT4VRU?=
 =?us-ascii?Q?Fhy0o54Ic8oFhDYq8vp9w9x1fu7mN7eOo7lWgM/PZbbF0JEIAldxEIdrHBtH?=
 =?us-ascii?Q?ZNEymDrCn2oKKwmk82mDYbVU11IKEPyzlqUJOR6lzXZtBonDHUZfkCusOghm?=
 =?us-ascii?Q?gIBsOVqadBQtsTgwswQHtKv7mg7CRf5a6THrxAsXmk98u28kJceiaEG/nMTQ?=
 =?us-ascii?Q?SE+tTR9P52VOmnduHuRJ4Um3E83gEn/5JcAddpjltkqlQo4ROesVbpIwac/w?=
 =?us-ascii?Q?7OeFM+6KpMM43Av8OwtUvgUj4zm1KY1REyJKyTg7OhLCH3/3IoRJ2/c5qD55?=
 =?us-ascii?Q?pkIr5t8KBUsVWMGKlQNb5oiDQpABNRFqYb4vCjmCEnCPUgM1gyriZzmGE9vV?=
 =?us-ascii?Q?nzb0VloZGjZsKxx1NY23iQZLNgwZ5/zUM1CRRTs0HzjxMCTYLWxGW3X8RsUu?=
 =?us-ascii?Q?lUy2NXql6I/en/DvMCcHE08sxf9+R08Xcsch6mDNY0PVftE7YhrzCrokmcFl?=
 =?us-ascii?Q?HSqitTdZrcam3rQk0GkzW0zl4C6bvFlvJ95cJJ+8HZZP7g8fj9FAjNGgkA+e?=
 =?us-ascii?Q?6cxYCN+sYuApT0xp9Vlpq/cIn1ctqBckSl24u5XKaPOU/unvjhZ9+VjTIgFG?=
 =?us-ascii?Q?URv4h5jRItK3SNtcfEpOPHusfOj6XUrVDzGhiSDWGTTgc6N9Wn8nh4hBX2lc?=
 =?us-ascii?Q?NaLBDJtBo5ynm6zPmRNXPkXdSc6PhS0PLkC7+Y4fVCurXP11U7W3AA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tFcBP7gOLosU5/jsOlrRrlCAJAxLjgBD4xLXMOoHYwC2dGKEGIdO4Gs7K2IR?=
 =?us-ascii?Q?MoekVejYjFwHJiFxrLPp3O+8JHrleVJMwcWoJIDtejHhj2fP/ywEwwsFaIQG?=
 =?us-ascii?Q?yeLtMy8AeJJh+L86c4FM5/Bjnq1f6ux5YPDcPskyoWZQKmKyrValpKrAwnZ2?=
 =?us-ascii?Q?AdZ04CMLNTIhR6a5cdWEhZ5W/xBWyjxS9tW6YgQHD96wSpGtTYrXMHWLOIys?=
 =?us-ascii?Q?f+7ngVBybMvFZJjzC7nxJ9nfmlVAM78FZzHwfTz1nqwtJ2s/01eknegOzLa7?=
 =?us-ascii?Q?K0N68+/TKmxJKVOLNg4p1d+Vs4UrqShNmpRaEof30bQO88dpDNTRiYO3AnUQ?=
 =?us-ascii?Q?Muga6g+epGFEKEw4+3T8gpYnAnYzug16CmJ68YObr8icg6hmqt8D2nCAdmHj?=
 =?us-ascii?Q?mJqKFda+O03ZYjba3YCPU8Isz3C+KPDP0Td40P934oYNq5gUq+iWaZcR+E6j?=
 =?us-ascii?Q?mIRcOaSCtqQ3tSvIjy6KWCYEVf5wKtpQ8qWornFOXIdFpzguV+ExFFOwcRRw?=
 =?us-ascii?Q?fXR1hRb6I6WqUL3mrbwd7rkZCep1fk/ACtkazr+EcECHPoALVVFUl81HvDEF?=
 =?us-ascii?Q?+QdrzhQG87tWKneS8ZqLALo8YO/XPc03B7rxa5MXaWhbBl7VtRPGv1jMGG1Q?=
 =?us-ascii?Q?2e+0qpPjzHJIx3UbtjIZnBiaAFQoZ+qibQB8kOtGGMoxqgoz8Vu8c2ZvpUdn?=
 =?us-ascii?Q?6E2kibMJ4l8l2xAkFUzCWhZmTiCQki97bGud4nv2ZwcyZzH1fJaIDdi2/8tZ?=
 =?us-ascii?Q?6l2TEFbrwSV7upum7kNvaEDS6Q7wyhGWHbH01DZXPvqlr/VmCFO4ZOy5n59Z?=
 =?us-ascii?Q?+heO88HtsWR6NRi19tcEoJY81p8mbMxCdZZp7ICu1VLLQfdmcmrgNjOm/sf1?=
 =?us-ascii?Q?ivH0ztCu45gvSSIe2bp9A7QJbme6NI0s2rNoZ7m+VO0GRXccWvhNE+4NwGD8?=
 =?us-ascii?Q?Cqxnx3nyOUquhA+ItjomZmnQZVezpaPq81SmRYRul92loauys4d+mErqi7Wo?=
 =?us-ascii?Q?3tKS0vL2bv7VkjEb4j3DAXiU0LWM/lXGwRZp+oFFO29vjvQ8+TH1ZQjUQ38c?=
 =?us-ascii?Q?W4BWkxsnL1SioXkYRVykhivjA+lgykkpk4XyR/SneWy4/cAGKemhj9mxDfRR?=
 =?us-ascii?Q?VliNFppjgSfpa1Q23M/dcZB7GGivvouKkvCAArBLDioEVCb9Qcck/HfcIkW4?=
 =?us-ascii?Q?KrWcaEezY8CXVW5lGCGUgCTZrHpY9NNKMCcufxt08mJfCbxXwuetsn7yjecZ?=
 =?us-ascii?Q?O36DCOrxqC8UCp+sceYLMAZJuCkzwRWix1ucAxY+UF9hPQlHr8iDLCuMVjV9?=
 =?us-ascii?Q?S813IM2BtDJhhflJopcZjWIcrfuGzqNEjD0NTYXDub0Tulxuv3HkUcgvhrz2?=
 =?us-ascii?Q?WLFnYthANFa/DFJWUhcNrFfMyiPECv06MKMSM5jq6X8+jcQr/FnLVik0D1au?=
 =?us-ascii?Q?KOzZ8+RXZENtNilTOPntGK0+EdCOr8GBMzc3HujLCw2gSLzgJkZAYKlyEWgo?=
 =?us-ascii?Q?36eS+2HJDtobyoTX7E0mw0XaHV5z3xlNj6o8z29tQ62m4yDJiK8+OWik+5nT?=
 =?us-ascii?Q?/diF1+55fMk+D2Ovw6Q8P0QSFU/Je0bomSMLskTLIzFLL1HNWyxdgwhxEqxo?=
 =?us-ascii?Q?wwxc92AOsWxjEHYkARKsNQI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810fa96d-c10d-4cd6-e10f-08dde0036179
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:28.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndssDSqE0FpbUPExg+jpm+d279v/D5IgozabWdzBSrbcqMACLX8PgC3PqlssOlzlp61ksB2g7J9r2DyKAtS/DpO/GhUKsTkKAUjqfiy9bN/7EsEvxiI+HRpGE1pn9nl7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19845

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7e58132ca2bca4f46533604877b4fac080274699 upstream.

Remove the `rzg2l_cru_format_bytesperline()` function and inline the
calculation of `bytesperline` directly in `rzg2l_cru_format_align()`.
This simplifies the code by removing an unnecessary function call and
directly multiplying the image width by the `bpp` (bytes per pixel)
from the format structure.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-15-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-video.c     | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index f119171033b0..0b53e035261f 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -812,20 +812,16 @@ int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru)
  * V4L2 stuff
  */
=20
-static u32 rzg2l_cru_format_bytesperline(struct v4l2_pix_format *pix)
+static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
+				   struct v4l2_pix_format *pix)
 {
 	const struct rzg2l_cru_ip_format *fmt;
=20
 	fmt =3D rzg2l_cru_ip_format_to_fmt(pix->pixelformat);
-
-	return pix->width * fmt->bpp;
-}
-
-static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
-				   struct v4l2_pix_format *pix)
-{
-	if (!rzg2l_cru_ip_format_to_fmt(pix->pixelformat))
+	if (!fmt) {
 		pix->pixelformat =3D RZG2L_CRU_DEFAULT_FORMAT;
+		fmt =3D rzg2l_cru_ip_format_to_fmt(pix->pixelformat);
+	}
=20
 	switch (pix->field) {
 	case V4L2_FIELD_TOP:
@@ -844,7 +840,7 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev=
 *cru,
 	v4l_bound_align_image(&pix->width, 320, RZG2L_CRU_MAX_INPUT_WIDTH, 1,
 			      &pix->height, 240, RZG2L_CRU_MAX_INPUT_HEIGHT, 2, 0);
=20
-	pix->bytesperline =3D rzg2l_cru_format_bytesperline(pix);
+	pix->bytesperline =3D pix->width * fmt->bpp;
 	pix->sizeimage =3D pix->bytesperline * pix->height;
=20
 	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
--=20
2.43.0



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8AACA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:14 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.6])
 by mx.groups.io with SMTP id smtpd.web11.1029.1755706148084425268
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XKgpOzWm;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.6, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNuDkKFco6j7/Luf+Ct24/YNd3PsF1dpH5Br4+IpZtjm6jbh/btU65KxTeAmHSmSwaukmoVyLhgpVWAhTlbugPlauZ4MT7tXOPnbp+JY4hnlGluqXYwZ5ajBGhk9LNO2xerVuVU6BHQzrdLma8repOjJwVfdDYrjnWHEBkhnIZfkvIzkbXIV0On5TLhRl9lmUwS+XUYykZWHPONIYtwbfEY13Cygb3QoRckVvMhvV3lWN8K9R/nXNy13pl15aP2ENA/Eufe/rtfUQfggKqojPKcHqiQ9HRPICzZUCcRSaSj+c6IpqO5Y4Ukzjjd4YEErSlDw1doQ6kURC/DNYXKlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNGEVz/jAc8jCOyZKVmjiopjIV6G8ktsMsOh3/O+Bkk=;
 b=vaZ8BLtUDEn2gcIKoIUFagBOhhR7ckDKiyYRIlr7BKsVsBOf2jpfWR58/fw2raVCgzft6q4C2Xkzqn28hify18gcEMyfeHMfCPsvwH1QDOaij0ZSvr5woqlEYasXVSiarmEKi22v/c781qDt8KhDl8cUwKgy8IQJwfAAegDmQCK/SX7+HsV5kTs6DbOp49wAHZT6VRSSZwExF80efYzAaukun0187do8X3m7/kOMZgXbdZkrrHDfNk+4ilruFBYzk9J4jkHVlXseyy0B1Gbib4kxWrWXY0nWIrKZuk9lOQKW9qgNeJtz5fQAnivVln1UNpAeBH8n+IEQ31aH2XBDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNGEVz/jAc8jCOyZKVmjiopjIV6G8ktsMsOh3/O+Bkk=;
 b=XKgpOzWmrFtKKLh/7rSm1LbP82QHGU3jF4lU/9S6cuAbLL/o1c+GQCgAsqSpTTBfPkGhyRcWc79RZkKLr4SXCZ8HXaiAkDpzkt1eztr4XMzwlwvJAwBcLKHunTii3rDLZHwxr+8AZgT1ufFVN9oTony89rCN+kYFro+3kw+MnQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:09:06 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 17/55] media: rzg2l-cru: Inline calculating image size
Date: Wed, 20 Aug 2025 18:07:18 +0200
Message-ID: <20250820160758.801813-18-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f69db72a-621f-4682-48f1-08dde003e33e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qxm98P4zGyBErvbQOmk1kQk7fucy5UmjvPs7yi7/71PxbGmRv//pDBPZa7Jm?=
 =?us-ascii?Q?VpEEcBY8Eq5isPrzi6me3svd4ByvP7/mcLmL8xOVDlqU6Q455QzeUTl8T0EA?=
 =?us-ascii?Q?czvaeIOn9n5hW8+6aDYtTYVMr1tqRdzZs4Uvju2Q5xJixYlS+JeTVb/I1Xjz?=
 =?us-ascii?Q?j65wXwixjwfwHM3/yssozwXC8CX8efhiM4pZd/+B4ihuL/ON3MWuMOFtZFGw?=
 =?us-ascii?Q?szYZ2uhs/rGCKnj9WaWB14+hGouKzHTxhjdulUBMhQ8wnCtnZJodDBNqItPB?=
 =?us-ascii?Q?XZHO1mMBy2bTPgXTa1nZcFJEBQSozxI5bBgOue8yIuqt+EyY6/StPz3oUNeM?=
 =?us-ascii?Q?fJH7dpO8Xx8m26gBZmxO4XmMIns00kW1hK/wBStReSTKBOrLiZc6Bf9dYbmA?=
 =?us-ascii?Q?N/K6OpTSrOyewgB6UjE7YkiHleEQXn2E73TtdPlNzIV6u+MyK3fB1tyMzPhY?=
 =?us-ascii?Q?ih0U/EU4T2Ml9gws2NFN8Y20Pz0uCv73JzzuUEJK5ZOOuImgeY4vfFInUcxO?=
 =?us-ascii?Q?nwyHnJU+UGhWjQqLm+6wPEMKd2gZfxBWB/zpm/tzczddcftXemFNtiKUH5XD?=
 =?us-ascii?Q?KF/6WrlxhFfkBZRnYz7ciQyOon6wRjEMhuFDL0yKOxWidtaN1jmlSZD+F75U?=
 =?us-ascii?Q?uYWNXP2BwL/131E3jsNDR0gT6tnCgzm4vcLfADe7arjQf00PfjUZKGAxs/yw?=
 =?us-ascii?Q?8XfQa8tJKaO+hj0cwe+By0ZTThgEw7rwRDvZIZDk2KM4+/MdW64TXa1nlCDx?=
 =?us-ascii?Q?FclJAng74XFf1h+AJ0yS0Vhd5K+zWY3s/eVJkMg2HC2M/O/9C5EVoJyLNYLA?=
 =?us-ascii?Q?hCmuw7PP9faTzf2ydfBncgEKlMQYyEdKiRIS3UfgFHpZnZgYMr6o5ATdoL1v?=
 =?us-ascii?Q?Nnh0sT+2v2nqqif1Jtv1J9Xf8m+ZYlwztP3AfM40epgISZLTpBw5caOwhgyc?=
 =?us-ascii?Q?rGMu35qkLRQHorcdIWh+qEm6bxNSL1uoZ7F379yiJajH9G2UDHXFOajboMZy?=
 =?us-ascii?Q?tssJQLTPv3/t5exC4KJ1UC/4AOGSCnpgLR9i4tGE+9vg0HtkB5Sg49fpgol/?=
 =?us-ascii?Q?RfOm5jCF+YlxNJ6yLPMpon1O1c32Q3Mmao9cu0hNTBtJbftHO+X0ea+YT0rV?=
 =?us-ascii?Q?hi1JiD/iSY/Kp8FZgrlMOCeFAW+JXuAZIIHGArhhhgq2jxvx26+bdEdhQOKB?=
 =?us-ascii?Q?dt7ZZvL8zt0g8jpnvCNE7iCgk2J6NlcgMMbcHIfwGQ8iZQ+4XFtfd5uRDchy?=
 =?us-ascii?Q?h2IiF+XlRMDO8+VIZ2KJYsd5rN0OXR2u/sA0pGazbsVI0Z9tbAscV3ZyiDx5?=
 =?us-ascii?Q?meuAgcrSUY6pCl5HLGpA3IugcfxWCG3Li5yD8I43itHE5mvS0dwWQLNn0byq?=
 =?us-ascii?Q?PF/gpdSGrFNhzOysx5zpMQ3XsxsWs63Dl9MdmdyTsAq6+UZzDDKUvrE71Yw4?=
 =?us-ascii?Q?XYwi/LgbqKlWLVPfWgM1itE7yDtMhgkHUsFB20qxbcZtABz657lgd95Jpve6?=
 =?us-ascii?Q?i3wjlhEtslULMSQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xc7GSr7Ri/C4/f3zoGojw7Pqky9bKlLKW7/N/3H6NRjjeH3Apo/mhhcd+lEu?=
 =?us-ascii?Q?AjuBRgz4iqbS2heWGGgAM0YBQcMo5N7kRXsJkR8AW1bvf/rFhswI/AsuoK89?=
 =?us-ascii?Q?eMXFTpuE6H3Nchm9s4FKParUnSqfU+mE0AEy99FG/xxdUr58FuUAsAE3icPl?=
 =?us-ascii?Q?ZPvt60tsBSMCVqVfpKQ7ZhBb+C3xXpkjWyv7sAwdiZOOCAg/WISrwOooh+Q3?=
 =?us-ascii?Q?tKSOaeTMBQwP+ZBkxAFywUBRa6pLkMwXNMolQWr44waxkpu2ogvDdG6APk6n?=
 =?us-ascii?Q?ZSjbVTgaoV1JnWWnqbzoP38ubb3hq+A4g+4lhWhI3FhD7+VhkX0So7K/OSDn?=
 =?us-ascii?Q?Fc1468+gnNGKxyjguojqvolR46vTl3g1X2/X7FFUumOuGud5xCkr9m2AsXQV?=
 =?us-ascii?Q?B0xLuLwB8AqZ9HCIf5AMPSUJ9gUlUj/j6kW13uV1WMRS3N+Gl3aBbOLQG2V3?=
 =?us-ascii?Q?7GuvLqoZ0tDR2RJE4zY5Tv8/H3VbfVwRHSkdn1lydU8gfKNyHfQn9vw/6oqb?=
 =?us-ascii?Q?zz24siVTPwK10kMDwsMrkkindRbCY+4GcuYmJUtRxnldE6ucM/aIvgmyYXRO?=
 =?us-ascii?Q?jgxf9PrqBZ7eXNFZXTXnjbykCGt/AkDw1xdsZWkw7o6k5do8px0IRjlCUE38?=
 =?us-ascii?Q?xH7yBwihKbgLdZJTx63Jtb2MREBNDGf9GmpASPgUnnDc0bsXOwKVfVVzL7op?=
 =?us-ascii?Q?ERXYTTfPDfQxA68+1XS8EwK9EZ7PhdHpgUqHGTLPTKLz0vYtel7TuinxGxqa?=
 =?us-ascii?Q?uuAhjr+IQUIH3R8VhWkZbHxkbxfmR8VbrvKAsJhw+b/xHcJR9ZEErei1BZCH?=
 =?us-ascii?Q?4IV6hNQwJ7VA5b1jfd9WBHBnnKcctm4locrHQIRAOBS49d7YEqfBRRXUCsPL?=
 =?us-ascii?Q?BPcogPTpSuVvSpANhMNR0XGxLCJBn7yOxUDBm8TewHxzx+KXSeoDT2Lp480C?=
 =?us-ascii?Q?3YS9hAxI715VmaGFnJVsCpBBdugzvnkg13fIxqa+JTHWH30uehSSDFzP8yWD?=
 =?us-ascii?Q?cZ/QBt+HGqxXjXliL+DSZIzvVK4cQHVgsFGWH6Yd5+FPeTO3FWkj/GL6bUP6?=
 =?us-ascii?Q?Y47O6Dz+ZNEHhAMWGrVWjl/nn6Lis48/hQdEvjZ65xJ524MK2CCPnY8mYiI6?=
 =?us-ascii?Q?ZtVI5lZqx1Gc2Ea9SqaD6WOW/KocOKNxPYpNYrznclrRR015twmXRdvJtMJX?=
 =?us-ascii?Q?IQ/qtUn0n8UF6EdmmqjmgyaFoS6Aa453CGvIVKeUQQwsw4SklR4MQ7LnJ8Cl?=
 =?us-ascii?Q?S0qT8CVbWU9x/8YfQRKMhJs+JnrRyVjJqHH67oqYNbViHbhkxrK1UOMYZ9Db?=
 =?us-ascii?Q?3s31KJ3ren/UJWsaAlDevSljKYaPOCiXtXlnibL0SrYxj56YqjasPX9wrQTt?=
 =?us-ascii?Q?nDBw5SCah88ZzxVZDnoNgJUfGAh9CzVL4TsvIpPm8IFXW9DZjaOoqIaR23fS?=
 =?us-ascii?Q?t6OpONpc7N8S1AV6ODfFAirVDMbhBmD6XYKSfmIlj4csk7UymH1g50ISfFGy?=
 =?us-ascii?Q?eY4ZxLfmmS2Ol19J9mSIwEcIj68Vy5eFRH5V48sxeeiRDqdbttOLAkqQdrbY?=
 =?us-ascii?Q?SWEMybhjYUTTm8w+oFdQuKtKYqjpf77zynLJq4K0W4lNA2E1CQIV856tgfG5?=
 =?us-ascii?Q?gdvU0vwNIdTKWjt5zm75sdM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69db72a-621f-4682-48f1-08dde003e33e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:06.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMMIqRhvzEtGitfkx2I/fOkbIJqUQOGvfVB88Zz9QNC76fi+QsdRi9v3aWiwWyjEfeljRy9haPI6wOdV2H9jCfO4pIvd0O49P5QSFGlHdknqB3jfP3pu6aBIlkBljHMZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19898

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a8af02e8a9dfc962dc24f0f0cc1c3a320208ee7a upstream.

Inline the `rzg2l_cru_format_sizeimage()` function into its single
caller as the function is trivial and is not expected to be called
anywhere else.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-13-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 37fea2bed00f..6a4f0455dc9c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -839,11 +839,6 @@ static u32 rzg2l_cru_format_bytesperline(struct v4l2_p=
ix_format *pix)
 	return pix->width * fmt->bpp[0];
 }
=20
-static u32 rzg2l_cru_format_sizeimage(struct v4l2_pix_format *pix)
-{
-	return pix->bytesperline * pix->height;
-}
-
 static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
 				   struct v4l2_pix_format *pix)
 {
@@ -868,7 +863,7 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev=
 *cru,
 			      &pix->height, 240, RZG2L_CRU_MAX_INPUT_HEIGHT, 2, 0);
=20
 	pix->bytesperline =3D rzg2l_cru_format_bytesperline(pix);
-	pix->sizeimage =3D rzg2l_cru_format_sizeimage(pix);
+	pix->sizeimage =3D pix->bytesperline * pix->height;
=20
 	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
 		pix->width, pix->height, pix->bytesperline, pix->sizeimage);
--=20
2.43.0



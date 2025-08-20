Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2779CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:33 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.44])
 by mx.groups.io with SMTP id smtpd.web11.894.1755705927610990692
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LJKL4+/Q;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQRcT8ImaGFxotGfLPJiI1a9FTRK5PGP/ZVTIcHuf9U4wEng5QA8x4s+0d9PPXbMzw3oaekU3D+9T4xB46IsdMUbIchtnP7KTfVsQDYq1v6F2spEpAWqmZJj5ZKBQT90Osy+jEFqtyQJANsFhPi/zULYip/9d2SpXR2sUJA+F6nwhalhmg+vQf2l4sJ56+WbYzktj97065a/E56rli3XPp+8cSxR2IxRwKlEIS+d/WvInMYZxbdbs+goA07x0mTYPJXcVcRyMVoisji1HbJkV2Z1G1nIVQtIsJ/xZbyJY8jN7qYMgu120kHEz3olB4EssGFRLYMSEhqozoQzenmx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IHuONcMqJtq6iDPb1yxd0LqapC1DDqT10Ap7h+VrQk=;
 b=ZTR8u1WR2c3vYgVkYJiYCbng2P+rURDAIuiWgVxBl8pWHJMQ0SD0XVDlLs7pQYtEiL8niSE0qEPsk8pHO6CReg7MGoz4Q2D5ZIf0siEiYYkJgKe+YJ6OkQnX9O0MPRCGzrg7U+UdvN4DLwOxBo95aavTduDGi+9Cv5uTToTwYcZRuCSL5oIhdbXtKMFlXNy6qjF9ZXYu76fgadyUbXBHlye1Xyb2Rv9AfqbQqwuJ+YsISJad/AK7FqJm3WuVrjqsqEVJ9iJdmTp0ZTrfjzmzBj6LlE2Ji6ZaIc1PBFuW21x47Eae+VaeJ3qwLIkzPrqkrRkiUJu7evAmEG0gMGHRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IHuONcMqJtq6iDPb1yxd0LqapC1DDqT10Ap7h+VrQk=;
 b=LJKL4+/QjBC/AuvdIZlXRDoynERnmuDd8H+WMlN8LC4Sa7lDbgCWQye49kOQ78xhbGE/i+gY6W+MO7zOa5M7Csq0B3QhoE8Tee/uMfOIism3GGl7EoczEgaDwV9Sze3ExsNc1gcdIRfUW/XTKfo++siFTu1tjwkdhYdWZx6JMvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:23 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 17/55] media: rzg2l-cru: Inline calculating image size
Date: Wed, 20 Aug 2025 18:03:33 +0200
Message-ID: <20250820160413.801341-18-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1d8722c-45b9-4317-64e8-08dde0035e73
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mlXcXFxAXS4FjPi9QRR7fDTO9cuxtbYjrro1pd4NnFqFuFuIu5DFunngqyHt?=
 =?us-ascii?Q?/INcqSvljsnafSQwBNrV9hIRNgSh6iX0RHoG6fS2sOUN5GwGgBn1RgLWxgO1?=
 =?us-ascii?Q?fHhaiu/vd8Zf2grooyMxOKbwZZeCr6H/m//qMsGlMUC4SP/50afbiGqLPcAa?=
 =?us-ascii?Q?sm+TqubZa8XngDCGS1HZm/JOcbZwIqsYvsjV1eMRneBB0cZpixMK6C+3gBT6?=
 =?us-ascii?Q?ntQALTxV0YVVZrH2FhmfaX6fFNeIRxGJ1/x9/FbAuwSR18f2Wu0aLynLTadw?=
 =?us-ascii?Q?rvgMwriWmt8MXlTtrMLFMN/+Z6w3I8iAQlHdV2fCzuLT2l/g38QSpazJ4e7s?=
 =?us-ascii?Q?/trEmdVbPTR1J5UEkwYnNK9udVCwXbwVWeQmsQzW53wyKl6HzoXQ7CXe3z+W?=
 =?us-ascii?Q?gWIIk1EnvQNfaWnc7YaAp9GWrximvvy8CpsGKvh45Mnu2wEfMEzQFcCuUp41?=
 =?us-ascii?Q?fiultxx62FLl0k1r3XEy0zd7PsYpaRMu1iL4wULx8fw5w/kaQi6krd2mVwSR?=
 =?us-ascii?Q?pP8LUJKN22TAYGfYn/VRbb2/6U0OHDWQVgHUC/FFky96x/ePaB+MYMHvEm6W?=
 =?us-ascii?Q?832XcVbdUOSg6h3t+/VizmpH6xJQ8udYX5dqlL7PA0eyLwFmTHMAFQwkPnS/?=
 =?us-ascii?Q?AB0ywULqsQgoqHQPUX/f9fW9zkcVxBF84d0/PBgipzMUwhvqg36Maj1b3dFf?=
 =?us-ascii?Q?xCgCn3GbnblilXOxFgrSq3dn+/EKNpquDruRHM7echpPIHwkxd2b6lGmX8JY?=
 =?us-ascii?Q?RwbhezY2YzjTuvInJ6FtQNooBexJbmpGTafhbFCp8OsKNf/RTaleWl1q+ZKI?=
 =?us-ascii?Q?mRekh7OqH/NGJISBQe+hJ+U+Go8Sw3qMo7HSpViN35vBvYdak/X1S4M6EFKl?=
 =?us-ascii?Q?J77tgHtPTj/Khtnlhkq0yzbIrwJwKbBxxbFlVtJa4pIv5w25Zkl4lCEySgkq?=
 =?us-ascii?Q?QNZQSOQD36kVUpf4QvXnn7IiZ+AgAbXVpAqrDblG/Ht1jYKLPTGKD4uqtadu?=
 =?us-ascii?Q?g1PaG3gYZvvLHXFBmpG/+ZotH4ngQhBOX04QEDonfmuZPm19XJ7J+SJGG7Nl?=
 =?us-ascii?Q?TKnc909C8hfLGocdugfBXJNyKuOZiF7ipHLW9Ac3fRyMn5slLYH972pUB3Ro?=
 =?us-ascii?Q?or3UhNoJ3uNbXXyNWjns+LjGRWpq44yBIhKvk2whZftWBIoeGw+EeWHlhUNS?=
 =?us-ascii?Q?4K0ooFR4v4ouU6W7dZZRMzzDVSE6/w/nx0LWMckkRadQrtBxVkDIfmiLjUCl?=
 =?us-ascii?Q?vXlpH8fwmihCy9k2kS4jJiHmRc6llv/SI4bGy+qO6paSzbKheWpCTDtYTycy?=
 =?us-ascii?Q?MP12yP7ZSzLGrLD/d1oweqS2w7/Z91XGX45n9JRzxDHJ4DlbDZxW31l8kiXs?=
 =?us-ascii?Q?vkMRMqSrZD/kw2c7C4VQrfC0HugZjYsE246tlNA1sjNPFfe3XPMydZrsiOVH?=
 =?us-ascii?Q?dyCsThTVfNgr7IitGIQU4NNUIVcEH5VgRtcmLKYf7WTeNJI+dZ5Q6n5nCYi/?=
 =?us-ascii?Q?nmCt6dRUghnBH6w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CV1QutX9fDfvDrgI+vt2E6ftTjjhfWFwGwlLFkWx9XOqEkueCzLUiCF+ZsiG?=
 =?us-ascii?Q?2paTCMohAJ6H6PL6nUMfjc+agYV16OMFiPBfOGJuGP7u7b2Wq5bhIFkD+WyB?=
 =?us-ascii?Q?GecHTx5D6uxm743VH6fJ5m00oggtRP0f3mAdDn9D+o+8i5WrN8iRGhZuYPiy?=
 =?us-ascii?Q?6SH/Y53/3vG9n68MlzlLi8IKyu5YrWyyR9URKiPNJnUazUlkEscL59jhTREo?=
 =?us-ascii?Q?dcdy0KdrBnthulWKLakTQCox2AivVroLWVl/CoU6sU2G+HYSc5wmEqe7/qQG?=
 =?us-ascii?Q?NwU6wzLV1XhEkJKu3YRIgHcimRIUs5xalvjuCPWfztKAowAmcCicYDYrvhg3?=
 =?us-ascii?Q?u+lEATF23c28ZYh42Iu3G1pfW9vli/Hsa8drem1vAnsxGLD8RU4HjRveO+1p?=
 =?us-ascii?Q?m7ioJZhvSsRBffjbULzYHPChO31Fk+3vi1uK64uh+xkgiD2T+wRXNBm92NVm?=
 =?us-ascii?Q?JP62Dc4mhCkXxJrJm5m2ajH39uUq2QgZtX8H3hk/psr3KTmVfWRV+TVuFDhq?=
 =?us-ascii?Q?Af6daH7PDuZ5FQ6BYrXWV5zp79Xvo9XCAlyFjE8eniBJPi6hQs25T5VwJiWz?=
 =?us-ascii?Q?3pc/fGglsQoP4Q2uV2FmvP3oPYssXUoItr6uznH257LNg1lXQyxQoB3pq2pw?=
 =?us-ascii?Q?CtGDHij7sPB5mhR4GArrT62LRcFSgDz1wKRYQoKomET6x6p33nBrUn5QIqIk?=
 =?us-ascii?Q?5fMKtSUNCKMHemBDKO2dzu6Y6pJYy5Tm0MKSRPyhWgsspENnANTW6zuPfNKE?=
 =?us-ascii?Q?qEny3sD/WU5JhQEZc4mB22/KrgeZ53AO78ooDlcyplqKLVKSJMZ/Euz6kF6B?=
 =?us-ascii?Q?DsDdAUcdosHBFQwterR3RkCwEUEISTE/aSBsw4524nFh2CvtkigWjeNh25Cl?=
 =?us-ascii?Q?EwJajcbPFg+7waHzGctpnF8P7Vq+er8Dj1E58v5VcJzqpgQt/WKX32VIDTrI?=
 =?us-ascii?Q?D6ebgs1c12ShSSVqk8ZYWrYaqGGa0VNgouUMGD+Cx9tzRbeLa0W5it3A403t?=
 =?us-ascii?Q?WcOrEaAPKY6d/Fs44lic7IVZcoZ9gP5RjCQwbTG2BRHbzmKmlZ+7mwmdyh5x?=
 =?us-ascii?Q?lCVtL2TWzaM0qRCqKCr70VBK1PLjOMHuOYz8RKuVPqfPYJ9jF8+XZD5QRVye?=
 =?us-ascii?Q?qJcJSC8g2xH1GBT9983SgrGsyuSUXISkHWff+9u6ldt0yfUreimMVUaRsY4S?=
 =?us-ascii?Q?QyQuHsvmxSidIZaHZrDSuqBACLm9YJ4Zklgf/dAQo0d8UaQTMNNABzhO1s2L?=
 =?us-ascii?Q?23ZYR7/0WWA5a4KXDVB4RIPfxTBwgmBFbZELA5e0yh3z0gkpSPfytvVTfzEP?=
 =?us-ascii?Q?mS5mdUKrQ6wFHXYN8nOWxe2xtpvebP7J4p9UfzXWSeg3iBgn6gx3/jlJRbdG?=
 =?us-ascii?Q?/7dZIuhS4mep+c8TqGIzkWPPksRWHf2XyTPBQCqd1YiburM0lY/2OROy7b3b?=
 =?us-ascii?Q?+YMUt4B0kyyKb6z3He27AwWcH9RFIK9iyxllp4RUvL7Le2yZLU+YrJWcwlbX?=
 =?us-ascii?Q?gcNFp3ic36qS8O66tqNkT+/X9w4N+Y1tteXpFDKuX775KchRokA6oXyz2KjZ?=
 =?us-ascii?Q?ZDxg9HHL44lDJN7pUlCvHjNeGRmgPR0j9DWrBH9S0BfXJb3l7u5DVqJJg0fk?=
 =?us-ascii?Q?JL3l/F7qpI59RcfxHO1u588=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d8722c-45b9-4317-64e8-08dde0035e73
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:23.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4qWWEvPrtc+IMszlBBT/+oXETx+Oa8/FWP0VHXhZRPI8MpNgZ0rtkU95CMWHwP51QPX9LQOVcV9c5T+TUxN12lIgWoROPycW+ZO4jepYV//4HMDCIlEsk1+IZiSaUac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19842

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
index 0e19f9223ab5..51d3ea3f9f1c 100644
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



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC651CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:13 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.41])
 by mx.groups.io with SMTP id smtpd.web10.927.1755705903937303756
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VXacahVc;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWbDfxAi53mv9kWyNsQXLzkESVz7j0rlcNrTVWQ3Zw0iyYCX4InCI7cRNhCcEGKXhCo6DgUD61kjJCIt1vy7T/PeyWHZbf67y9JGVQ1+VjV6GqhFLpUqg/RbtIDHVsMF/C6U5mLGXJijDdkC/Fu/kkyGNTqQG+KnBCjh4t3uZj44tfb4lIqYYjy8MllIYxbcIu3IcPxC9V/jsiIIoJ7lSOeiqrRpdkvnah6tUKGXNPzJ4U3jrJN4ShGpRxqtnW0Mf6xKOTVKiWWd1Z7Cb/K8nuaInaj8J2FYzEdNMmMx4jhZ2uNx5/sjRD6xgqJXbL5m2KeOm+GAhW2pkl5PefnDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UuSDb/nkg1NaEqbTHcXazOR+MWJl5wBWm894ZegvaY=;
 b=rIu6SmL37wv/Xy/PVpkXQgrwrY9RWcFPaOeflwFvXS2YdrjS2HAIVzgSJFYxJcM3RJ7ddCJCe9in4qWPczZ2aKb6FcBezYDTp38sUmAivddT9WrkruPhUMO/JIC0E6wR0P+9YW2zvz8ee2j5vy47n2B8qgK3xPl/arBgjCDzNxP9FVAepBbZEimKEzkAXPaFCh7cYwlMaWozcfJDg76BZgg/oFKeX55oFKGxM2Hh+LrldtATfySztN0cdwHpqD5IjBe9Z2Zibx2ji4khnd9r2q/r3HLomp6Oh3MgdVkSbPiy0pHCobm4sIdoqBI8VbziOyo5KKyxkgzQ14r0T+qmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UuSDb/nkg1NaEqbTHcXazOR+MWJl5wBWm894ZegvaY=;
 b=VXacahVcghTI0LKADzQKg1kyfMUA8z5tmyY0+Ln8bGwYTBRJsleCcyHoMq4V6fg0dLBw08JoVpXj6fSTfk/Va+ssFc0AuCdh6EKbOtgHblg3METJArjkXPRF95QdJ6o5nGFmzpyWrSSduImRyfQPLHLCMoQmAJJD83wpd4rPQgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:01 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/55] media: rzg2l-cru: csi2: Mark sink and source pad with MUST_CONNECT flag
Date: Wed, 20 Aug 2025 18:03:24 +0200
Message-ID: <20250820160413.801341-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ab51254-2efb-4bb8-fd3f-08dde0035159
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OvwGhOQkYb//y8WpWiFMCWFO8dP2qccrozANyX76kk0HR6ZkAnY5j/GVSTvU?=
 =?us-ascii?Q?zVH7nDLHiBERpFpyrWYUGTX1jnHqhBLUGws3XtO8GzRnpucNiRH2z8yPXfgS?=
 =?us-ascii?Q?gCUeZtWifO/IzwXTtXChuaWQ/2EJ48WQWgghnXsZwWngaBvTnP+ponJJ0GjD?=
 =?us-ascii?Q?o4ffdW+ebzN09CeVF4t/Ly3+UZ/pmFQb0sC8k1SL5BIpnBdeJg7LMhrl1Pp/?=
 =?us-ascii?Q?q19OLG0YbYK1JYXbVi2Ah2mGZvKVfTY17liHspd7RItryMtrnZDnNDqO9Y2i?=
 =?us-ascii?Q?TO/2aSdlsyZOLICS8+IffpveqRkK6/u3CoeI6vPvxbx0nAM0R1uFgDqv+iou?=
 =?us-ascii?Q?lm8kRoGwCJtD1zmmazsxuAcPdsxmlmIkloaZxY7VCD3Okw0S/23hnmrKKPWd?=
 =?us-ascii?Q?AZTnOv6MN3SpAFor16jaIhHObUO09NPE4fFIrPPWJXRyn3czfuoiYTKdGNVW?=
 =?us-ascii?Q?wkdPWjKVKlNp400EY0jd2S2Q21So+jWFdFIx9XJKcFXIhcaFRcbi73pOQVMV?=
 =?us-ascii?Q?u89tgSDJsovSkNSqjQQqPWutqH1vbSWJ0TUm0gnZd/9ePSEeVkpEojrLNIwp?=
 =?us-ascii?Q?/Ua+QNWXMyILdcTWGVf1X8ouf38BGkhnsMrBi8o8KFSJ1OcDTWVNqGhxcYyR?=
 =?us-ascii?Q?luuYy8TYjFXfjahiPGxTCsSj2CNU20fvKG0yLVIU0yxgOCbvgjFN9sCrjtHj?=
 =?us-ascii?Q?U1CJtVbIP14sukJanVCmmM3tgzFk7PJkvVrEuLVe7EK9e0ke8DouD3PLX/Cb?=
 =?us-ascii?Q?OFZInNJ4/MCc6gWbR+PpS4e03lzQ1QcQvVwsHCtNJDlvePwxpj/DRX3WIZO1?=
 =?us-ascii?Q?MWJtOKkw433hnxOkV9AkoA3clr3ExjBcwO9z4FNQraFu7I5AxK6GCLvmBqx0?=
 =?us-ascii?Q?fWDzJkhTvVvTESpDpZX2kv0+ocLe/rstMxqbwBqYZHpZsvuCp47/Bo/L0DNn?=
 =?us-ascii?Q?ltlJ8sAElFPT84kIIaWUhruXZ3xPmCtZimItDqpHg7RahuUDlED9V5sBxrhZ?=
 =?us-ascii?Q?KaeCIEZAO6PjeqV9I97yphkxGMUY9iE4RgU2nwqF5j5RuhcWwgyj9KhWqQhD?=
 =?us-ascii?Q?lZAPBpghlV32gxfNRtkWZVMyaS0C4IGnrH+jl9lwtzNLeH/XQOi/1DZFndbs?=
 =?us-ascii?Q?VEStZ3w672tTp9Z5xnC4JBqdm6QPeAns0Wsun3ltNODI1Tf7tnWm67Lo4eLe?=
 =?us-ascii?Q?Nv7ncBMXvQAzsZCiuhHygP+p2r37lwFzmAUW1w7g11AbThmTl98LRlhVibMD?=
 =?us-ascii?Q?LJGjtrsRyE4WVfevVVDZLmYp5B4ZiKNVU7QW7CylCldAGPxAdTGIyK8p4rzb?=
 =?us-ascii?Q?H6ADDCsfCuZ+bT9KBufyhRAu1+Q5b1YIJxiNc2dRgkOcMd+K6NtvBswWo9qU?=
 =?us-ascii?Q?vVnJBn7UbpL5XykFMkooKCeuyFJJnWzUbIvYzBT2bQgWmrNT2Ezo+XukLubZ?=
 =?us-ascii?Q?vRg1oGblU86QAXnVGhTuj2cY/HxAkftUrL8zunbV8Gv3WTBF2/vAkSRmHkOk?=
 =?us-ascii?Q?VLg3i4Qdz/GcdW4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jKNZHr9Yl32q2Bq6RmzFRBnF+BYKI4/Rmkb1z9TwlWt1YuAY6gEtq7dsJHrp?=
 =?us-ascii?Q?QCIvCZLnR/JyXpS7/ogSRZP2Hv4ygkRuMjwbUTYDiOUqdTWzeT3L3w9X8Kl3?=
 =?us-ascii?Q?umgQn9QMJSZJ3t2agsa114R4d90yIB8kJzxz2/3fZk8umaG7RfaRfV5ogPfL?=
 =?us-ascii?Q?0TOxddJ6BJ4Tc4u85iWjRDnaeS8Cq+ehhgF+mKxbc+Q0iCZNr0WOvC7eUoj6?=
 =?us-ascii?Q?FS9VfsdE2zlXwMMquH1fkpg1s8ZFFKfRJKf8v9/6/hRhsfG5+hJPNRU4zVpI?=
 =?us-ascii?Q?oM+1eT4ElTBxr1UxL1dKlF9q6bmOQrbGgbmr6/n9RwcfVqaBzPNob7DUEgw1?=
 =?us-ascii?Q?0S7Mlv7IRroDqnik+tJYFLfGZ6ixi7z0xqyudBypodVu+AGA8OdSvEzWb5Xk?=
 =?us-ascii?Q?nlEjlAds5AQL0vF9jjpyhwXAgQKWZ/lFw1snxWl1AQpoBv+Ado7gmqRcsTxr?=
 =?us-ascii?Q?IAp7/WCRoHKn7k0eDHr+JPLR5kUm2qnxJ/ZsUeJAo2AYUqXTdAXbHoa3M+7U?=
 =?us-ascii?Q?zPSdSE4WMIZX1Bgay0n8CLDWopGcictfwkR1zCiQU/+Rc3v1Boo7ZrCno+25?=
 =?us-ascii?Q?Ddm0IQnokMTbCcGl6HzEjf5AFrmcX41S9cO9y2bDVEJmY3B4Pmszuw5efJ53?=
 =?us-ascii?Q?g9OHLI6dBDymfZ93G5sMyCY8K3PkKnWbzWwVGpz/O8mM+U9crHVBnIBOgUZ/?=
 =?us-ascii?Q?Dgw9gz8k+EuZ/BBnwewne2HQF8ZMluPPMaIDC9A9K1hZ3IKyVWZ7tw2C74k7?=
 =?us-ascii?Q?vXq5uMaXfTlCgVi+mEXCOW5UoQn/bf9LF2JqUrQUpo5O+3BP7ANfQpiRxON9?=
 =?us-ascii?Q?br/lCD/+BAEkRhCqNzjORiUJRKZF6Lz6LIjj7JLlwsW5U20WMdfR4l6DpK7C?=
 =?us-ascii?Q?y3wZkETo7Bk0YT3dHZLYRScufundoQLNkmn04raaHsCGMC3uKlac47iRJHAc?=
 =?us-ascii?Q?EDMy3yZdO0VWfh8AuHUR+PsIIR6r9bQyGi6rUkyb0xFXQtsz1PD/aR2A8EiZ?=
 =?us-ascii?Q?eU8K8/vusIBb92fuj3eGzY0w2wwVX2PJ0BuHgM4b+nUq+Dl378Fmgp7JqNRg?=
 =?us-ascii?Q?oyNQjJn7qU03ZV4a/n6j6qzGIWF7ceGygd7CY97TNIUOPbP7CO0ADiBJGjaF?=
 =?us-ascii?Q?lM2EX6CgCvrO78/fB+4+IyVzkUg5nB9CP6YaSSGkFSJrvFHo+YSiYkZlSwW5?=
 =?us-ascii?Q?1Y+LxQEPsMkVFz1tHlF2kr8lfomL9QDxRPXStD5QMhfQ3SecT1YGIQ6LCRss?=
 =?us-ascii?Q?CNfs1sAD2PDjUaD9jxROgq4dsTXMunuAHIeC9haOy5k6D3rqiF8bKC8+BqAS?=
 =?us-ascii?Q?EY58vNtrgharpY829yKIPY5KuCJVLBeVKlEf5qotFlRbcWPnzfQRrD48zeeq?=
 =?us-ascii?Q?AdkNVD+SECjmHM+r1m460/5NRYBQgDQ80Q7GkQwDSZSi52hir0n/s/N1j7rX?=
 =?us-ascii?Q?5M3Pk70jvioPfqnQ71964vovMcLHNciZ5cITzP5t9e59t4xqIO2QUkiiKcAq?=
 =?us-ascii?Q?jssXWyHsrVnDfP13696aTH+7BBw5vMUnXiZs+yODt+kmznKCcO58mhjzr4bX?=
 =?us-ascii?Q?ma5kJJS1Q2HExTXL0xSVCrPcXBPPFw0cT86y2iIFSkEgEyyNJEeEyTXBK3Ax?=
 =?us-ascii?Q?PmlqkOveWXHyRzxi2QlImMs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab51254-2efb-4bb8-fd3f-08dde0035159
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:01.1693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCTc9ARPWmZrc/Mqh/X3//Msr2lxd2JRO37sV72z/b49qhvC1i1RfoGewIPPwFUZt5gQliUFjjNgpj+8l097jmgwHvbx9Kc1QfCN/7az+kwhSRWx41JsH9wiwNzWmeSA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19833

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a4e014bfdaa029223429c02b6fb0aa39c34e06e7 upstream.

Mark the sink and source pad with the MEDIA_PAD_FL_MUST_CONNECT flag to
ensure pipeline validation fails if it is not connected.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 4c0e3679933a..5d4a54b0df85 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -792,13 +792,15 @@ static int rzg2l_csi2_probe(struct platform_device *p=
dev)
 	csi2->subdev.entity.function =3D MEDIA_ENT_F_VID_IF_BRIDGE;
 	csi2->subdev.entity.ops =3D &rzg2l_csi2_entity_ops;
=20
-	csi2->pads[RZG2L_CSI2_SINK].flags =3D MEDIA_PAD_FL_SINK;
+	csi2->pads[RZG2L_CSI2_SINK].flags =3D MEDIA_PAD_FL_SINK |
+					    MEDIA_PAD_FL_MUST_CONNECT;
 	/*
 	 * TODO: RZ/G2L CSI2 supports 4 virtual channels, as virtual
 	 * channels should be implemented by streams API which is under
 	 * development lets hardcode to VC0 for now.
 	 */
-	csi2->pads[RZG2L_CSI2_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE;
+	csi2->pads[RZG2L_CSI2_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE |
+					      MEDIA_PAD_FL_MUST_CONNECT;
 	ret =3D media_entity_pads_init(&csi2->subdev.entity, 2, csi2->pads);
 	if (ret)
 		goto error_pm;
--=20
2.43.0



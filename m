Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43322CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:54 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.38])
 by mx.groups.io with SMTP id smtpd.web11.1058.1755706185774367402
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=MHaNG8RJ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRzVCLVNgWo7C6Yi1c0jnrq44DgeyOOuQiNsfH/Ta+uARZZ7tZ7MgiR00URISfKClTByUK0+pHMvkP6UqSikqhix9XZ1kL1iyb5tJWvW7nzDmmGSOpcc5P7IChzNA41WjCzSKZq5CUiVdH9+qjF9aD3K/PVA8ioABvkTHvbcpHRgemsCJFgDWjjHhHvW1cd7uyurQUb5KcPvNpdmqXWpzud9JFu1xngdwyUNJLLOKd6fac6fpp4QCkgsOeQgylxMyCP0SYuiCg5ExOK7BTx264KDnNhSjf/hGLoZkg2FLCphl9Gvh4ZsbK45gfJfRCALsh4iP87XP8KiI3NpNA/fkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBryl2UZLVqM3PCzSQp58aYp/L+Os2gaBjjNw01QWvw=;
 b=YCFaUR/hFUOjmH6rT1TortSsrSy+X8McuTF7eBHMglNuTwXLwf9oj8hwcFeJvoRYgf0dtuBDCQKsRYneUmUpFNL4yFe/ainJfZEREYDKSXwwmb9odHD4bFJqC6WAn2vQWbRuVzBQTtKaGsM29UUXpPw6pRrK6KXMu2Q4/6laLa8ayCMjC6wvrCFRESGB5WQGhggclTnToApAaWc1k2vJTqCVk3wsXzxkvc3JfOQc2i3/Vgir5YGFSzFVsMsRGr4Vk6Qtl80pYEwmb54tnsteZ7+9OEGiXTgyy9fcwyfFtWTJGCcTmX0hfN4DKMEFmqHpyduIrkdyHs/r2n94PWNqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBryl2UZLVqM3PCzSQp58aYp/L+Os2gaBjjNw01QWvw=;
 b=MHaNG8RJ2qSwWCetcYDNcNiLWrPNQwzMWhJ2dto6cRY+M0dklJVFpqIh0LlnZ/T6024Zi9qttdG8dfnp3N1D+mIAZ9ovM2oqTOoqN+DCJyW7wuIYlUPBBqi/4fug1DMLAByfMMTHk1GsWlnysEAx8FGtELOrS9QUB7zfGVUHMco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:43 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 32/55] media: rzg2l-cru: rzg2l-core: Use local variable for struct device in rzg2l_cru_probe()
Date: Wed, 20 Aug 2025 18:07:33 +0200
Message-ID: <20250820160758.801813-33-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e5c149c-c7ee-4e78-274f-08dde003f9ac
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y6avlMKBXTfhaRop/4xLe2/PeVty1zxdOMKO5TOtlLiAyPOlE4Pm/DR7J3vp?=
 =?us-ascii?Q?hWG4Tyi+s0xHqRNj3C4bhbjhl+QukBWj/ZhTWELd6VBrseOqjPRt5QVVJIp6?=
 =?us-ascii?Q?DkOJmEKeA9E1zPmzeZd01BRO8jhBpfRPLJvMsHssM5eMzsjHqX9FlYFfXuhq?=
 =?us-ascii?Q?/EPVeYipGZ6ZQ+tK3G+BaraVLo7IkxUV8VqrE1F0+xxX7zEihZakIN1Jn3DJ?=
 =?us-ascii?Q?uFC3UmcQUypavoB7U6sgRlsdfDTDwpaTqcXMF30xki8OyBiPnenJgOHbdDuV?=
 =?us-ascii?Q?PuMTfxXgoWc4v25rYODppo/fjh5neyic+C4FbVKiyPI6cSkDP3AO9uwINHGJ?=
 =?us-ascii?Q?gxeo4pxHt1CZOgLK72cpaIj+F0cFJknq3xOd6yuk/QJK/WI1kkT3/errVSvM?=
 =?us-ascii?Q?L+jCNnd0fuW7Kd0RvS3HSrgcBUQht09EzF7kPPc2IXcBlSNRQmO0yGd8hiz4?=
 =?us-ascii?Q?guq4psumrJSHPcWj6pup1alnrYbUVzVJG5HZ1IQ/AMORYtihIhoFA3pxi1+U?=
 =?us-ascii?Q?OTgcqH2zais0V1CuKZUK0MdLezuj+gLh8RkhNNBJW2Z5+zGEeVcesLNA8Nal?=
 =?us-ascii?Q?mnPvA50z6yDh9FOidYPg8Jv8SuPpSt8zopOojRxnNEieBBg6RPRCpUBUzmu9?=
 =?us-ascii?Q?JRHD8OV/D/qHjQPlTvcE4AddAZIX85q/gKjPhhh7jaBDhdYyXrfDBuY3K7F6?=
 =?us-ascii?Q?lvxpyqGKqdtCorNnKriKMBfMv9XkAF+bGUV2PZcVO4Xh1Xm8OmMhrjvvvJyM?=
 =?us-ascii?Q?Sz6QOiOL4W4HYV8QeyOZ78GNnh658XdhugR2ExjPaBIOAx1nEX1V3atlfRMC?=
 =?us-ascii?Q?NKiQrtGYmXm5JZ1ZeOfK3hk+Ts8eDr+QxHn6XJnybPQ3I/Kt16C6tC5tJ9r3?=
 =?us-ascii?Q?TGAI3Dz8fMuLfsROjVsV9LqCvnJ6m5o+ic7pQGf62pkvShDgB+JnU9aCF/7G?=
 =?us-ascii?Q?PSABl296uzPNp/bLR1Q7D+VOT00Ez1DuV7G6MnPaEY8xaG/pqvtvt542TBLk?=
 =?us-ascii?Q?oTvL1Le2J5z68LjM2OpsAz+ogicmwPfWAzDvzGazOo/KMSVaCtlYmFCSIX2C?=
 =?us-ascii?Q?SwndSHJphlFmJd4cuOCehPXHccG4LSnZbRnDSutUJJLmzS1rrze8+SGSeD2q?=
 =?us-ascii?Q?S0CshoYZraS/F5epfXJfXZyOoU8NjttxGWrt3EgCc7+l1S3cmhTnAlXRDE3u?=
 =?us-ascii?Q?1BpyylauiBSubGGg81J5RxSfhiRiXCspVb54hJS+GhUb0facrbg9ErYZuWE+?=
 =?us-ascii?Q?qbOaV6p9ynmk00/PsW9cOGAsj3ab6JC2m/UpvJzYvqKdsPkjcxn//M2OSDVJ?=
 =?us-ascii?Q?TpbmLc2pZSvPbw4dKYDBnhgR85cUxX+Ixn3KzQerRjlWeGzyypBhixcBKrTG?=
 =?us-ascii?Q?Jk2GGms5A8Uqj4IKd+NUusWacxBdcLZUm5VnZ7IlioA5WeiQuWS2bM9OOm0f?=
 =?us-ascii?Q?BLQ2gaUpA2kVPB7RKyx4eXAiifnN9W43C4I2UK66jkPtTcBMS/uLE/nl4Bjh?=
 =?us-ascii?Q?vRKGJu/unXHJvPQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E7VBAsTk8D1iyHxT/eWKIQVmwV482xkWycKZmAj59FJ3iBy9fcB7l9nIcaTU?=
 =?us-ascii?Q?VGNETAbvEVY9YX96kh6fOgX0UiEoGO8NKZ9rFgVIK1pWbZlf48wkP/bfq/n4?=
 =?us-ascii?Q?zsvwUbR4FKepLmx0z0bELXD8fEi6RBFkdDjAHEcXEmpXZacB6f2Pe2K7RwiS?=
 =?us-ascii?Q?RlEFT6LWIRXJbwx63vXNaYRUJwL8iki5w1uNJmZk/6/Qr/p4OFQqLGfUgMu3?=
 =?us-ascii?Q?2ApgJzEuHsWvG4ePcQ8GTNBzF8vcIYk2Q2Ptj/E0PE0FqZ7gs+IMLlNeRKDa?=
 =?us-ascii?Q?grs9tv4TOsEeUV4vW4Ma9TmbODrSHblHPkv6lK5e4RE9k+FVXq7F4KFEWguA?=
 =?us-ascii?Q?t/fn/+14eaDycXAphOWyD5dMtUgCbSr6UYuA2aGr8SIHVehy5MjxuN+iW9LC?=
 =?us-ascii?Q?lIO0uq52xWhR4N8CRW3xjC1cP48E6nbrPJ4c+gPh+ia+vyB1LE4uKAttndEU?=
 =?us-ascii?Q?ZDIzssPYdQq7uYQdYVFAvJZ4n8dMbMTbYE2geAdIP3HNdHCzoN8Y3ggryR2C?=
 =?us-ascii?Q?Fa32hznGUL+fpMtYa46/VSk2JJEG6UkYELViJBvR5KtdNqOWM5S2N7IxdFk3?=
 =?us-ascii?Q?kzN+PnbUWiJdpcy7vETI8L7bUHUYy8mTqwm3lxytQkm5yEJHI0UiGg5idPNK?=
 =?us-ascii?Q?Ss0itcl6lAYSr8kQlFjZ7z5kAcXGbx/SiCOxQv9/pxTxQFv9YJZNToMJjT2k?=
 =?us-ascii?Q?F7w0KPGR2l2gDX40wregogbidnFmsWlo+rv4c7pK0z2EjI/uV4Dt89WMKRp8?=
 =?us-ascii?Q?17gbkowLnt+DkahuKP8LT47jd3Iq4hQxSYMG2KwIthGe68qLkO6FzNwq82tp?=
 =?us-ascii?Q?2qLN/BM//QUR8/BQJ8Pga6oxFAxgtaBDEz9PupzEIn01TVF2z4xuZzgPQ7vw?=
 =?us-ascii?Q?n0l4fmQmSHqKW5fdBxK4+ecFwTZw/UT56C7t7dCwYVAMMfCbifGL2wOEjzil?=
 =?us-ascii?Q?41ARatcc8Nsarmu/x/oUza15Z4ZZ3dVuovk1AVmd7r6dDk/AZv6JAJykbKqS?=
 =?us-ascii?Q?sHRtcHVCXXFFN5Jk1TrKceflab0n5yIigcd9/xMmx7DXviiaPicNfW//Q5ya?=
 =?us-ascii?Q?wzdeJrVWRj8s54e/X9AB/P92glMeUALRCW7wOwTQYEy0dm53w6OSRiNOsdZz?=
 =?us-ascii?Q?mYHi1nFdDVwMjlpBW4QFef7thwO8rrx2QC/vQMVgIoK16kjM1M3G8AUqZijw?=
 =?us-ascii?Q?N13qmI4PhtPLhPYitab7to2SDefX+M+nBvJ3UwWrMgE8wFT2VqbxH9Xg5N4s?=
 =?us-ascii?Q?iVw2sP5D8XDfE56DW2HX6KScIG4kRdN1rrGDpRiPtRKnDKhBUS38oWD7uh9i?=
 =?us-ascii?Q?RWr/TSbS4aJ+DQ2+tsSzrCQ9HV1nkNYtHhuLeZ8HHxTEd7rzAuJTBCK98Pm/?=
 =?us-ascii?Q?UBd2t2lb39knG7/7lShfczfGC3G8d3B8Lo8EmqS6CwCL1NomkNO2jBGQquDM?=
 =?us-ascii?Q?yq3VimdQT6ikf/bZ1FVo840BjNG7iBB4dz4oXdj6lGrjbL26Kb5OZDdkudoN?=
 =?us-ascii?Q?VsvoT+kFY1TTuBKl1hEgaWufmhrbn5+nXKsZakrSX8JtmfkWdLvmu6jND77W?=
 =?us-ascii?Q?kon2m2NewI5E9b/oXAU24m3LsEFDHmM1jpWMS8DmLIsGkl4Qk+CxFJhqBF6p?=
 =?us-ascii?Q?6EsHbeWR7MKqr/oHz1/gnMs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5c149c-c7ee-4e78-274f-08dde003f9ac
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:43.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRfMi0v9uOgf45NEh9AigT0QHVg2G4MsK3i9gQL1yElSQOskwHRW9XqoHt5G1RWXezWdK2NHqkjdhKNHap5/TNXyKvX/+Bxsz1CA0dTkSg2oy8izc82tbt/XCvag+U7d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19913

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit aed5bbaec5346147b8580878a32809fdb1bf46c8 upstream.

Use a local variable for the struct device pointers. This increases code
readability with shortened lines.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-7-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index b21a66e2ce5c..ca8b266e3eb6 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -240,10 +240,11 @@ static int rzg2l_cru_media_init(struct rzg2l_cru_dev =
*cru)
=20
 static int rzg2l_cru_probe(struct platform_device *pdev)
 {
+	struct device *dev =3D &pdev->dev;
 	struct rzg2l_cru_dev *cru;
 	int irq, ret;
=20
-	cru =3D devm_kzalloc(&pdev->dev, sizeof(*cru), GFP_KERNEL);
+	cru =3D devm_kzalloc(dev, sizeof(*cru), GFP_KERNEL);
 	if (!cru)
 		return -ENOMEM;
=20
@@ -251,32 +252,32 @@ static int rzg2l_cru_probe(struct platform_device *pd=
ev)
 	if (IS_ERR(cru->base))
 		return PTR_ERR(cru->base);
=20
-	cru->presetn =3D devm_reset_control_get_shared(&pdev->dev, "presetn");
+	cru->presetn =3D devm_reset_control_get_shared(dev, "presetn");
 	if (IS_ERR(cru->presetn))
-		return dev_err_probe(&pdev->dev, PTR_ERR(cru->presetn),
+		return dev_err_probe(dev, PTR_ERR(cru->presetn),
 				     "Failed to get cpg presetn\n");
=20
-	cru->aresetn =3D devm_reset_control_get_exclusive(&pdev->dev, "aresetn");
+	cru->aresetn =3D devm_reset_control_get_exclusive(dev, "aresetn");
 	if (IS_ERR(cru->aresetn))
-		return dev_err_probe(&pdev->dev, PTR_ERR(cru->aresetn),
+		return dev_err_probe(dev, PTR_ERR(cru->aresetn),
 				     "Failed to get cpg aresetn\n");
=20
-	cru->vclk =3D devm_clk_get(&pdev->dev, "video");
+	cru->vclk =3D devm_clk_get(dev, "video");
 	if (IS_ERR(cru->vclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(cru->vclk),
+		return dev_err_probe(dev, PTR_ERR(cru->vclk),
 				     "Failed to get video clock\n");
=20
-	cru->dev =3D &pdev->dev;
-	cru->info =3D of_device_get_match_data(&pdev->dev);
+	cru->dev =3D dev;
+	cru->info =3D of_device_get_match_data(dev);
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
=20
-	ret =3D devm_request_irq(&pdev->dev, irq, rzg2l_cru_irq, 0,
+	ret =3D devm_request_irq(dev, irq, rzg2l_cru_irq, 0,
 			       KBUILD_MODNAME, cru);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "failed to request irq\n");
+		return dev_err_probe(dev, ret, "failed to request irq\n");
=20
 	platform_set_drvdata(pdev, cru);
=20
@@ -285,8 +286,8 @@ static int rzg2l_cru_probe(struct platform_device *pdev=
)
 		return ret;
=20
 	cru->num_buf =3D RZG2L_CRU_HW_BUFFER_DEFAULT;
-	pm_suspend_ignore_children(&pdev->dev, true);
-	pm_runtime_enable(&pdev->dev);
+	pm_suspend_ignore_children(dev, true);
+	pm_runtime_enable(dev);
=20
 	ret =3D rzg2l_cru_media_init(cru);
 	if (ret)
@@ -296,7 +297,7 @@ static int rzg2l_cru_probe(struct platform_device *pdev=
)
=20
 error_dma_unregister:
 	rzg2l_cru_dma_unregister(cru);
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
=20
 	return ret;
 }
--=20
2.43.0



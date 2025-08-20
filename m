Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B64FCA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:54 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.44])
 by mx.groups.io with SMTP id smtpd.web10.1010.1755706011885282089
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dfNI8Sik;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waug3hfO9Zv6Lgnq63MYgSx+ihFYsw3dUobbAlpJhU4k8f5tPBltLxzxiKOCTx/lrP/5mh8ODsnif5Vo5krtD44FYE5GvV5dvif3YZjuJ19tBFpYzW0WAkYztXceuzUIPf2lGHrp040U1+D/FCLrYAwoEDpnvRTDInZKW+FUpvWV852/Kps2GT8Hsvjaxj7ez+DI4epyieoSL05O2J6ko9MqIcZDOxR48LvIFlg8KLqfXtVSvmytp1X3AeOzSkEw6/8N3/1dURppoN0GQXX4zJf31wRtzHUPLqEpThewsNIS5ipqxzOg6ta36JZeeFL60I52VgD4Dz5DbVMVRqyMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpRx+CFlL4Pn6A2f6DdN2KSMLKC43twCSKYHg8D4nZA=;
 b=aMDeqBa8+iQCF5awJKxsFAd6TxkW0I2opgxQsYZlhm0aHNNbYSczykz3Kw8DvpL5dTXG4AOoLpTJ0RfrS6qDNcqvBB6LARmuxq/wITwTQBkOT27H+0ap7ccrAmPUaCx807vQvsP+Ivg3IKRgUjY25+rNOTiqSCg9UXjfNfQCRaG8yhlZrqyxcNeDnEjkU8BfBDkd1SVLVEuzt+EZYO+X1cFCUMpmsAP8m3obCqOttYrsDNfbGz1GbWxyanyXOvw0ElQhSqahzvDZHFBYRnEbqvqliccNJV6hm4FxCce23eYfyiICbeh+zRMwgVtO/qRQXtwT4L1m6JCNQCVEMbzxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpRx+CFlL4Pn6A2f6DdN2KSMLKC43twCSKYHg8D4nZA=;
 b=dfNI8Sikbg7/iDuXkZK8TzgnTiXHBA4kpaNIlN4WELGAzLfiIZUwj5EAypkmEnjqXO0pPrsIPFQo31ekicvZESAEeE+E7/7x1PvN8gEUqZ70CQ5wcnOE7zgV+d0pGEVSPrlY6058cyWkMIY9lghUZoWVACjAqaCXMLjxLTZNCTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:50 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 52/55] media: i2c: ov5645: Replace dev_err with dev_err_probe in probe function
Date: Wed, 20 Aug 2025 18:04:08 +0200
Message-ID: <20250820160413.801341-53-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c6865e-0ede-478e-c39d-08dde0039236
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IWU5U2asFesamjxxOlHfDtJgkVav+c6yk2uxHsKZc3KLrudMIvjrco0iO2UL?=
 =?us-ascii?Q?bqMymnGuIz+FFG4EptVwx8mQPRDLKjaUPoxRYpIc9gILC5BmZmbleaaO0y1j?=
 =?us-ascii?Q?uhBsp0sODNgsIrOMnsQdSG89XQL4MlGgcQKNoT/ulfehXUCuLGe/8yOUqN0F?=
 =?us-ascii?Q?ddmuzf1tC4ijym4usOQqITsXRrN4OeNVhTssCXdmhf5t+RD/eUminS0hfPtZ?=
 =?us-ascii?Q?3PlS8+bNZRoW9u724b6Bv+kC7YA+N88rJErX4QkJ9axdX52/u7tmjdnQv+fi?=
 =?us-ascii?Q?M5ia4QgKQE4NGl+z/n/eIKR5zEmTVk/dgXEzMKZmoLAsNI1sbVcFzyhrrQ3u?=
 =?us-ascii?Q?+GWVWwci5TPNbkxlfooA5ZcYkeDzJ+m9dUrVdvzSIiaVJX5j/VChilUcIFEh?=
 =?us-ascii?Q?lpNwhPhoFAw7tXe1dzujTbdD90XNVtOL1dS59ONdEZjUoUZK8qTmt2ix72Ru?=
 =?us-ascii?Q?76qLJbtTSvhJL91xOjP9+nBZDC7sowjnS24yMr1dWbvVd7EuibTy3di71TkO?=
 =?us-ascii?Q?f2VRtCvEY1Me/y6OLo4ClfCE5tuj7dXYGYIZMEDyVxVxRN4/X7nVhCx5nStV?=
 =?us-ascii?Q?g86P/QRwXpjr58g1Fu4P31MDL6wp7GVG9zI6EIyvNycYjIAF4CMtoRrvuhbG?=
 =?us-ascii?Q?ks/EBSv9nQ4zqTpoWVH4Xq2saoymoTqx7QOqJ9Zi2RrdMXFlbp/J3RBfs6aQ?=
 =?us-ascii?Q?yOUdcfqKSetj6ivsjDvs00ftoJdNNQwH8rEAUcK3pxOWOVwBsOIRVd3ElWus?=
 =?us-ascii?Q?ox2Y0Iz1VxMpTt32mSHRfCKUjx6UiNQrQGTENIE1G+w8Zqyl48ANrVrUGL7J?=
 =?us-ascii?Q?OtTIpnbWkgcA/KfwjRCG805ifeXKaCEoW1rjy3TgSb4GE0sjhaySLVbV5y3N?=
 =?us-ascii?Q?adXkd5otO1ByI5uj8J2o2UkP8CgXfZJOw5KvO0IHN/m4bX0zfMhZM8SxJGh2?=
 =?us-ascii?Q?fJHU1qCgZKcaxKw1cqaJ4QqNPoAeByylqd1IF3H8Ptysb539XFBYpETrY3vq?=
 =?us-ascii?Q?Zno+vPW2N7NW3TUKfOC1LrDSld5Ywz/OZwOvRJtDR6giTIDLKdh0uGKun14X?=
 =?us-ascii?Q?IXx4JhnRD/l69z+MPcUajblR/jAmyEhMra7WDl1gZ3w0O8qreYhmx0s/gJ/J?=
 =?us-ascii?Q?G2Gx3aLlvX6ngkGUttXsLzPaCaiXdOMJw/aM+KRlkgEjQe67fwjjxIlCM6T2?=
 =?us-ascii?Q?mNMmkjFCvcga1I8W0UtLqeQD1ZurVfhgIvK2hfLK+KhcTLVS/VEvB8gA40hZ?=
 =?us-ascii?Q?4IRFvFuQisq/B+WHAFScbCo5so2sn5CENpMdZfApvBPIgbakWfuHs4xWnFT9?=
 =?us-ascii?Q?ZrSQ6YD1MziNEMXlFXFlXO2gK3ZRZBs6r20qNVD4N6odUqPtTNvzc7BC4e4J?=
 =?us-ascii?Q?f0qdUgjDCFhzvbYQmYHeRGLQIg84mY7mvAUas5DUs/4xnRdeEjpqcgqTECop?=
 =?us-ascii?Q?zQ3rcKP0pDGVRd2vitG7x1seET7sCcTSBTNrvd5PtmkyDPrpfYQK0A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FEqxLlq+I2JXV7uONROeGC9M/DNHRwu/FlgW3CwpQtFPChMHrx/2Fyoa3wSN?=
 =?us-ascii?Q?60O6fiwxB+h/+Wwn8MoQdB7CVgPZcEBtQiXDYKdOyU8OoENFkTltyxSG9gCM?=
 =?us-ascii?Q?360tquDFgtyCZbj6Z/HEOvPSjW/Mlv8fWCIkw1CtjMECihINS42LW1R4IsVp?=
 =?us-ascii?Q?LWCBwsfAPd7V5W3wRl2ln2Fw++KmNv7mrrPt12PznAZBOVVXwg7sk6Vns/Yw?=
 =?us-ascii?Q?JKZSZYgtft9lEOwiEx8BwZ29nzui0BluvPRFqGTcwegTaVCgbIOtbpYseCd/?=
 =?us-ascii?Q?zdmTYJlAvfU6FOFWkEW1WFp1S3i9HmuXc18i0e8MGMallLTTUm7NxUs6JANK?=
 =?us-ascii?Q?BwxDt+PuYUoYqZycBQCNh0ZWDD3QXaNWbp+er0+GJraf2/ziPeedsu3ZNuUD?=
 =?us-ascii?Q?6JG0PFGt4lr+w/ngvdjuqwWnSF/U9kSgKxUB/TxUdJ4t+jMYG6I3lFUUc1i7?=
 =?us-ascii?Q?fTdkbHd/xo8yLbiHBvcSfsonUdRpLtRJBb4IbJrjvwYeOF80Rh9w6z0tkQaD?=
 =?us-ascii?Q?CnwK/Uzbme4PSSQYNetY7r8pv69prm3qI7jijzsBKzukAzT75ZM6Ont0aO2N?=
 =?us-ascii?Q?Wc1MY78YWg7IkrCoTCwaRj+Qq6NndbsWwubvrVWqe85+SR2gDquMw7lSHSyC?=
 =?us-ascii?Q?FMjPI/9M1Sf6GbIvGQTN9CGBKsNv6uidVQH/UOCkJpTpK551DMWr6PLa3uMj?=
 =?us-ascii?Q?Wmfc76aObF+DsOSuheOvWH1AvBDiv9WC+tp7Za5f/Mzy+kviAHDmpcgjGRW0?=
 =?us-ascii?Q?EWn4Q3lMzk0n36zwAXU9KNnJu9qtg7yLrhU1VN1Q2nJC85AA0bg2k9PH4R6U?=
 =?us-ascii?Q?TmO9AdopyBQL7cnrCqenWDkq4YbqV6b3bek+PZ9oU/7ANt3tKXVjShSWYK+O?=
 =?us-ascii?Q?gC3BnxzJeUxUr2nsDIDdQdqQsMbPXv821pDWrdUTc7BYmPemN3aKXR9CEAlp?=
 =?us-ascii?Q?cEhUcYb9eKNEbx05cXzbgohF/ZR4rCrzG2Uge4Xg2xRAKec7b/mgOGrN5SJx?=
 =?us-ascii?Q?TmhUYOjftDgcFWFjjOOi9Lpe6E5E2CSmt/oZLQIr3poWKubc3Gfoy8p0WyTZ?=
 =?us-ascii?Q?ylZ32lFVsMnQyS8KU37zs5YOtMP1ICGKQPHMfrK/dRhRqhaC+peA2Rwz+WiH?=
 =?us-ascii?Q?ZVJ/O8HqfuyMg3PSSlHm4aqPpTYxoLkgAL7YFhRGgPIrnLpeZJhOo7qTaytC?=
 =?us-ascii?Q?74o0GU/BJZiZ1h9jc0iUJf2/kJfuaAFhRDI/DxEaAcx3ZTVU6bOIbfm/j8d7?=
 =?us-ascii?Q?dNclcIB8spVubKwPIRCijXbJujN1Go05P2mO03ZRIqwx3SLcgg+RjNZGRkBj?=
 =?us-ascii?Q?X4E8YJ8yZfaDmfPikULY2yB/bmq1gYnExKz/pYoEsh1ephEsFqm3nU/8bljx?=
 =?us-ascii?Q?kKyvSrZtlakvA4z9ZORnfFr6rm42ZUJ6yIZ4nPFeQtk7/k0CzVCaFiVGMRHF?=
 =?us-ascii?Q?lVIu7C4b9Vef8G2FAYvpgWVRBiawsYD0TXkieeRZDpGkqslvrlJ11xjOheeM?=
 =?us-ascii?Q?uYxYG+kqr6TabrKbuoxyr2k76aVl+c8SzjwEDg4a0CQQoUDLPSKAxayIFnIG?=
 =?us-ascii?Q?BKE7fOD6YRTVo92NAoYcaWS6mgOEAkgSdBqJQEaxng4w69E1W0BZaf2DNbL5?=
 =?us-ascii?Q?4JOoCr4+eW0gQw4PaTLHew0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c6865e-0ede-478e-c39d-08dde0039236
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:49.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZXnp1DyuUjsJmXeNN4Uo14eU1oUjxeYSGwOBbOMRdAWl/kuqiY4Ndbm6fWSENt2W5D0dWbonWMhoL7Wc4j0Y6PrBRSc097hyt/97zFkybmkhQrf4vjN0TgWch2S3GVB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19877

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 82e092fe36761bd3f9883a9411837eb764a6e866 upstream.

Refactor error handling in the ov5645_probe() function by replacing
multiple dev_err() calls with dev_err_probe().

- Note that during this process, the error string "external clock
  frequency %u is not supported" was replaced with "unsupported xclk
  frequency %u" to ensure it wraps at 80 columns.
- Additionally, the error string for control initialization failure was
  changed from "%s: control initialization error %d\n" to "failed to add
  controls\n" as there is no need to print the function name and error code
  in the string, since dev_err_probe() already provides this information.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 82 +++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 46 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 013e162dde95..33330712faf4 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1066,51 +1066,44 @@ static int ov5645_probe(struct i2c_client *client)
 	ov5645->dev =3D dev;
=20
 	endpoint =3D of_graph_get_next_endpoint(dev->of_node, NULL);
-	if (!endpoint) {
-		dev_err(dev, "endpoint node not found\n");
-		return -EINVAL;
-	}
+	if (!endpoint)
+		return dev_err_probe(dev, -EINVAL,
+				     "endpoint node not found\n");
=20
 	ret =3D v4l2_fwnode_endpoint_parse(of_fwnode_handle(endpoint),
 					 &ov5645->ep);
=20
 	of_node_put(endpoint);
=20
-	if (ret < 0) {
-		dev_err(dev, "parsing endpoint node failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "parsing endpoint node failed\n");
=20
-	if (ov5645->ep.bus_type !=3D V4L2_MBUS_CSI2_DPHY) {
-		dev_err(dev, "invalid bus type, must be CSI2\n");
-		return -EINVAL;
-	}
+	if (ov5645->ep.bus_type !=3D V4L2_MBUS_CSI2_DPHY)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid bus type, must be CSI2\n");
=20
 	/* get system clock (xclk) */
 	ov5645->xclk =3D devm_clk_get(dev, NULL);
-	if (IS_ERR(ov5645->xclk)) {
-		dev_err(dev, "could not get xclk");
-		return PTR_ERR(ov5645->xclk);
-	}
+	if (IS_ERR(ov5645->xclk))
+		return dev_err_probe(dev, PTR_ERR(ov5645->xclk),
+				     "could not get xclk");
=20
 	ret =3D of_property_read_u32(dev->of_node, "clock-frequency", &xclk_freq)=
;
-	if (ret) {
-		dev_err(dev, "could not get xclk frequency\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "could not get xclk frequency\n");
=20
 	/* external clock must be 24MHz, allow 1% tolerance */
-	if (xclk_freq < 23760000 || xclk_freq > 24240000) {
-		dev_err(dev, "external clock frequency %u is not supported\n",
-			xclk_freq);
-		return -EINVAL;
-	}
+	if (xclk_freq < 23760000 || xclk_freq > 24240000)
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported xclk frequency %u\n",
+				     xclk_freq);
=20
 	ret =3D clk_set_rate(ov5645->xclk, xclk_freq);
-	if (ret) {
-		dev_err(dev, "could not set xclk frequency\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "could not set xclk frequency\n");
=20
 	for (i =3D 0; i < OV5645_NUM_SUPPLIES; i++)
 		ov5645->supplies[i].supply =3D ov5645_supply_name[i];
@@ -1121,16 +1114,14 @@ static int ov5645_probe(struct i2c_client *client)
 		return ret;
=20
 	ov5645->enable_gpio =3D devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
-	if (IS_ERR(ov5645->enable_gpio)) {
-		dev_err(dev, "cannot get enable gpio\n");
-		return PTR_ERR(ov5645->enable_gpio);
-	}
+	if (IS_ERR(ov5645->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(ov5645->enable_gpio),
+				     "cannot get enable gpio\n");
=20
 	ov5645->rst_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(ov5645->rst_gpio)) {
-		dev_err(dev, "cannot get reset gpio\n");
-		return PTR_ERR(ov5645->rst_gpio);
-	}
+	if (IS_ERR(ov5645->rst_gpio))
+		return dev_err_probe(dev, PTR_ERR(ov5645->rst_gpio),
+				     "cannot get reset gpio\n");
=20
 	mutex_init(&ov5645->power_lock);
=20
@@ -1167,9 +1158,8 @@ static int ov5645_probe(struct i2c_client *client)
 	ov5645->sd.ctrl_handler =3D &ov5645->ctrls;
=20
 	if (ov5645->ctrls.error) {
-		dev_err(dev, "%s: control initialization error %d\n",
-		       __func__, ov5645->ctrls.error);
 		ret =3D ov5645->ctrls.error;
+		dev_err_probe(dev, ret, "failed to add controls\n");
 		goto free_ctrl;
 	}
=20
@@ -1181,7 +1171,7 @@ static int ov5645_probe(struct i2c_client *client)
=20
 	ret =3D media_entity_pads_init(&ov5645->sd.entity, 1, &ov5645->pad);
 	if (ret < 0) {
-		dev_err(dev, "could not register media entity\n");
+		dev_err_probe(dev, ret, "could not register media entity\n");
 		goto free_ctrl;
 	}
=20
@@ -1191,14 +1181,14 @@ static int ov5645_probe(struct i2c_client *client)
=20
 	ret =3D ov5645_read_reg(ov5645, OV5645_CHIP_ID_HIGH, &chip_id_high);
 	if (ret < 0 || chip_id_high !=3D OV5645_CHIP_ID_HIGH_BYTE) {
-		dev_err(dev, "could not read ID high\n");
 		ret =3D -ENODEV;
+		dev_err_probe(dev, ret, "could not read ID high\n");
 		goto power_down;
 	}
 	ret =3D ov5645_read_reg(ov5645, OV5645_CHIP_ID_LOW, &chip_id_low);
 	if (ret < 0 || chip_id_low !=3D OV5645_CHIP_ID_LOW_BYTE) {
-		dev_err(dev, "could not read ID low\n");
 		ret =3D -ENODEV;
+		dev_err_probe(dev, ret, "could not read ID low\n");
 		goto power_down;
 	}
=20
@@ -1207,24 +1197,24 @@ static int ov5645_probe(struct i2c_client *client)
 	ret =3D ov5645_read_reg(ov5645, OV5645_AEC_PK_MANUAL,
 			      &ov5645->aec_pk_manual);
 	if (ret < 0) {
-		dev_err(dev, "could not read AEC/AGC mode\n");
 		ret =3D -ENODEV;
+		dev_err_probe(dev, ret, "could not read AEC/AGC mode\n");
 		goto power_down;
 	}
=20
 	ret =3D ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG20,
 			      &ov5645->timing_tc_reg20);
 	if (ret < 0) {
-		dev_err(dev, "could not read vflip value\n");
 		ret =3D -ENODEV;
+		dev_err_probe(dev, ret, "could not read vflip value\n");
 		goto power_down;
 	}
=20
 	ret =3D ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG21,
 			      &ov5645->timing_tc_reg21);
 	if (ret < 0) {
-		dev_err(dev, "could not read hflip value\n");
 		ret =3D -ENODEV;
+		dev_err_probe(dev, ret, "could not read hflip value\n");
 		goto power_down;
 	}
=20
@@ -1236,7 +1226,7 @@ static int ov5645_probe(struct i2c_client *client)
=20
 	ret =3D v4l2_async_register_subdev(&ov5645->sd);
 	if (ret < 0) {
-		dev_err(dev, "could not register v4l2 device\n");
+		dev_err_probe(dev, ret, "could not register v4l2 device\n");
 		goto err_pm_runtime;
 	}
=20
--=20
2.43.0



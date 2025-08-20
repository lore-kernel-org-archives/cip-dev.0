Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EC1CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:07:04 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.3])
 by mx.groups.io with SMTP id smtpd.web11.954.1755706014505114874
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=A3d3hk1e;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.3, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7KMttk35asYD+M25P/Ody5lWxMpmMjUPoCjiNjMiwbW5zIM3Sv4Qdpo/vF63FVA/W6t9/758Cf+YTRZrceMyJuQLy/rPMlG8ATEoJmevhhQVBwkyHncTzTqVHFE40e5mETSR2i4YR6uNP2kJb0de5rrA9wx1kgADESJZBIb7iValV5rzJ6gumOUNqnWaGNmmF54kFdS/1Ph/Z49ZZYb4QR3gKGSC6txVLD7EYtgAKVry+r1A2SgV68NSWGWQhXz2mzdNrIf3UTpxi7Kl8tEsuWXSSJl+zqdZWK3O9E13HgBI0SaMUkARq7mS94HwoDkcgMm67YjiQLkVRru36zO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQaGPt9j9SbEy00geXr1HEA7iYbcfod3YdnQY2/5vHA=;
 b=BR5CEivPjUU3ZI7EvwJe+mU+/85Nv6LYSKiqUebXLQuQ3BFCDgOrabPwDX5UZXeqSkWrM42r294UHLAgPxBQAUByb6ulFOoFy1NBymOolt8HDwF8hPV7SwJaXLdVOHiR+FAnsE/up8I/Qty1n4pw6XZ32wHHNMg0JlHFecG7x8ZHlDhijmi4X6opDtWttAwaM40fV40cew3Pu734aoRT7d/UgzKvNwOwzscHAjoHvxuyKR6Vh8sV6HEaekkb/qn8HFe3g6c6k9yHWcjYng9wubh8yN4kvymSt4WIbuikrEhptRrwiyhq2H+Lm3P4XmZdplZ+ZcBEJm3LWX2GkXfsYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQaGPt9j9SbEy00geXr1HEA7iYbcfod3YdnQY2/5vHA=;
 b=A3d3hk1ewm1NvpfkicUX/EebjbnD7IBMQICcxA+bh4Ktou/kiNmQe0B9+tbkHUmIKf2lNS20K2H/GyOvy3GR4yIWZo9dbzERkz7unqKwCDii7hd3A73OPJIMkPmlY7MEV6sQgZDQMopEc789hQMtGtS9bHOYsNMnnX0YJtb91l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:52 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 53/55] media: i2c: ov5645: Use v4l2_async_register_subdev_sensor()
Date: Wed, 20 Aug 2025 18:04:09 +0200
Message-ID: <20250820160413.801341-54-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 556ae70d-6638-4a33-a34b-08dde0039395
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DlljdT19jOKk9rR163Ly6NVt6StnxrPW6cacs7850heyegzaqkta3iqi5vPs?=
 =?us-ascii?Q?MEhnK4MsSQu4Ds++Ih6KifcM5TYi8H9VBiCEF9YBnSA1rTGdCybu2EGi9hbz?=
 =?us-ascii?Q?M6nZCtpNYYOcp5niNNFS6tpRsPEDeoH0Uz0ENQujO+bGPe59xaGbmOnaWCIA?=
 =?us-ascii?Q?Es7AWhFmnLvhMmuZ0+lr5VMrNCudBGKe+o8nS9S+wxcjcPqERkk4/vYROu+t?=
 =?us-ascii?Q?mL9oe8egRoMd2W1UhVsover2qQeXgb3crvwhpfKrzPUGGtSXHPu25BQ0nkTe?=
 =?us-ascii?Q?Fd6nIisW8MK/wbjzLKSHrNl+BYiFcrmsMo27zm2OWqSSCePXOphPF1/Hb63C?=
 =?us-ascii?Q?CFze5WNmEkribTVwMDrfdYSV18uqreUStuw+RPlWPU8B6pc4FP8PHOwa5L/C?=
 =?us-ascii?Q?LWyTK5/8SpB9NQNWK6bczgJDXRXAGWE1dnQZLIa8b5QgGNtxH64VmYrYLzcb?=
 =?us-ascii?Q?M34uhdVlOQTqkLNGpBI63n35DTVHLXp73c+enrXi1/R7wJUbKw1ZgCC09RnE?=
 =?us-ascii?Q?i6EQoMez6MyvkCPnwNawogqWnsBakjji4jJUCW0mpywsKmOz75FCCbArIq7A?=
 =?us-ascii?Q?eitLzjbSd3nbltMdQuS7bKx9uGVEb9PChiWCZ3B+QkPkRZ2JNFg3lmw5P4oM?=
 =?us-ascii?Q?25oTv/GyU+zWaubWRFNNu2FNvTkMH8jxly6pAFfN07vZsVLQGcXDOKFo4ekt?=
 =?us-ascii?Q?xaY2Vv0v90uZ4KtvMnRYHtdIBRxvrQ25W8Urz9gnBWt3GE9ADq5q2e6659x2?=
 =?us-ascii?Q?slvjiiX6QDaUUFUp55idw1Swyzf+udhUBgioy9dkwfqGwYySWNL2xyYcaIqY?=
 =?us-ascii?Q?6G+LmwYoLr1MepsXqDY9abxd5ag18TPVcvApalwX1RKilVfqDBuhenpjS6rU?=
 =?us-ascii?Q?SntorryolMzBfaBGpW6i64e5KrekHQC1ZPSa8yUcoo3YyTX25i4EDqDp0rXf?=
 =?us-ascii?Q?E2SmFQNyLyB2yB8Nw+q70bphj6FLRdw7uFSKHiwL47XzvdSMnIr1LLzZEVa+?=
 =?us-ascii?Q?DI6WlFU6Godayt5MHtgZfvR6tPmOd3QGqKp5raFUH36BHCnFLfMxu6h0un0Q?=
 =?us-ascii?Q?tEaiqHscx1cj996FZHHgh7ARaLAOmTArHrdk6r7/XDE5r8eXGMushXbc2btG?=
 =?us-ascii?Q?w+0KUtx3ry4paCfFJ9xVYdKnO9314w5wqhoHmGhBgj/ArtdzVqJ3okCMNoyi?=
 =?us-ascii?Q?ZXuaFkreVYgJ3Hpgj3lEeB3qNVyVQJoDivwQXktC38yVOMm1ust8cpaga1ed?=
 =?us-ascii?Q?BUt4K0F5ixq7Rd5Ew11oSlYbJQgjUcGstzHjz3S4fR0cZaBZ7ilw7vGc1MKX?=
 =?us-ascii?Q?9vA2IfMJZ4s7SetV6jTO24D+WFZvcfQ+8cgZtMi7CilxiTewlpDrxUovWcFI?=
 =?us-ascii?Q?IZXNUz8RYJsGkKZL1UFJjOksStweq6qbjloYD4VhoFo3CCHxhwl5cXPJl5mC?=
 =?us-ascii?Q?uzJ5GrrtXGPhwN6wh+xjeT0oMPLvDSVQNJZt4Ffis71M3QPOKs8GsA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g6aMXVyDoOpq7J6mJzz4plWHvr+pu2fo/AGcgH81nIgBaaHXV4/AReTWC7FQ?=
 =?us-ascii?Q?LjbnIcI411zZOLRtRRwc2knj+44D4JlHUZgM+ZIz61dYsLAi7sVZVLEsxA2I?=
 =?us-ascii?Q?184j0le1gSJCPzhny9JxHQ/LEv23u50/ODkPCv3oQAMluYCRH8TPS7KE+zLp?=
 =?us-ascii?Q?ZFGMjK6uykjAEumHI2ndMqVtd5ikyytKGjkkWqDdxdyJx7WrEy3/nb3bFVRp?=
 =?us-ascii?Q?fnAVJIBkloFg4YWqDDGCcwuJ+Y86C1dE+gK0tF4L+Wx5X0JiaHVkFUyqbxGm?=
 =?us-ascii?Q?Zd2oJOy/TRIbzPMNkHiblrX/zv17MfaUu5+Q5AOc/6Z2ed6Dygjtrx7ToRj9?=
 =?us-ascii?Q?94MoKlLL0zDtR/ggyvxp6/Cwlr1RxqdeRMHu4pH2FBtln3b0w8vchitzEZBw?=
 =?us-ascii?Q?dpH3XI5oLGQ9watD7dOKk5xgL80Zuy6GR1axgs8pQmocrYjGMIlWQJMU0z9g?=
 =?us-ascii?Q?Q0vr9chbkcSYi1NdZQfiLf9slDNdS5+fwB7gRxH0TU8B/eQk26uUfExhXvv6?=
 =?us-ascii?Q?ASA6cBp/NX+EaiIGDIb5jPHBIZSrwFP0GclnyKMbgsaETcpfKWyxfX2LWseR?=
 =?us-ascii?Q?hglbRI6g1PYAwy2MWLgbuFafjVnb1Tevo8R0zwX+QPt8nfStuP8RzWLfynjK?=
 =?us-ascii?Q?fdiYiqW8qOVhhyd9Sgx5ii81+CeRklE8auMCC4H8BOWcBjzIo9OYohk/PfI5?=
 =?us-ascii?Q?WcRZ5GDkgAwafRVXEWc3OsaDHAObZBxerewKd5DGUX2ivUHRugZW3fC8WFPh?=
 =?us-ascii?Q?wqQqN5Tl3uWDAJv089eFPJVAT+NwKf4++/Xrv7GSn4jD4u0pbRUOo7LQ18qB?=
 =?us-ascii?Q?Nd6xQfmqqYj+lRk4SSRJKlj1GaA+tRetc29zd5fxeQN63JphcDkCdDcc1Pxj?=
 =?us-ascii?Q?z8Cg4HpyvfdqXuRUWDZ9I+vt0Z805WonM9Ayy27jFiiW5bvVPMxRnmP+upfp?=
 =?us-ascii?Q?KcRNKA0XS6K1tLflBdJ9OdQbSoWwXDXWvrtyQ72LJnhVkqqubbf6nPTWB6M3?=
 =?us-ascii?Q?R1pK8pWCrTPR279KBLekvXudsb4prHtKUEXh5KMKjA3vFUW6NNRn/oIuejMh?=
 =?us-ascii?Q?wG9DKfRUyUoDP8hJDeDvViq3OQELxeWWlmWe56cs4SG0JPAXcugWFiadZe52?=
 =?us-ascii?Q?7anpU5PxUOAKqT4Wu1NJjqmrACowohyCpAZDztRR7Oocau234M5On4qfWhi5?=
 =?us-ascii?Q?toTnFR7INsWItDJ9pcCNn24T+lT1WuoPC2yJZACHdlLz+8rS0pSS1nbHUnKH?=
 =?us-ascii?Q?lxJCiQlRb4aQ2LRdXqDKep6WB7iw5t8PpgNO4Yp17D3qwbKmq1Hod8f7kGyk?=
 =?us-ascii?Q?S+OKrKwaajvvUh1YZ3kT6vWmWKyrJ6x53z8mR3GePtGYi/5gwlzFDJatFZXm?=
 =?us-ascii?Q?6lDkO4InUV0fND3EwjtlEZhBMGznzBesllcLdIG+RRJqXCqKxbCIi8LsmsSC?=
 =?us-ascii?Q?Vlo2SVzgyoQyWpL1PgNQ5WVMXTebEZAuFc+b9QkyWRR0+P8Ef03vCgfeLzUb?=
 =?us-ascii?Q?F+Jnxt5mKYS7benjCZ+v/vGiQBzCUUoDpwck41lPP4r673JFQomnGkW6T9B6?=
 =?us-ascii?Q?e8AJFvDl9ZQ1sXphKCpZNb0hJwIy3QIbYms5NL5h1o/MfGMp/nOrDolJvo7U?=
 =?us-ascii?Q?IUVukv7z5z6FABD3AzcCuio=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556ae70d-6638-4a33-a34b-08dde0039395
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:52.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ji03oqvGnG0KIjdaGlDB1Z/7bCz90G9teaHeLGZSBpePxLqt6NMqKVkH5y8qPi5n5FNt/A4RRYhyFdyna7JutIAdWjJ8Du41fQwN8vHFctDmdg2ySG5THPJu5PNdtRg2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:07:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19878

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 885ac98717242596a315886fce5087be6598c23c upstream.

Utilize the v4l2_async_register_subdev_sensor() helper to register the
sub-device, as this facilitates parsing of firmware interfaces for remote
references.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 33330712faf4..8f395a74ccaa 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1224,7 +1224,7 @@ static int ov5645_probe(struct i2c_client *client)
=20
 	ov5645_entity_init_cfg(&ov5645->sd, NULL);
=20
-	ret =3D v4l2_async_register_subdev(&ov5645->sd);
+	ret =3D v4l2_async_register_subdev_sensor(&ov5645->sd);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "could not register v4l2 device\n");
 		goto err_pm_runtime;
--=20
2.43.0



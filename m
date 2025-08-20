Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4335ECA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:54 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.66])
 by mx.groups.io with SMTP id smtpd.web10.1110.1755706190611074279
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Gi689XmD;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.66, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xk5VQUPNR7rMAtcnafvy/YR8yp12HJWcVLQHVTv17Mkcy0H9tUeWStyYFZKiFUITy3HGUb7b7HW61xg1JAahWYQsSiNG+v2VCOx3WOx5mtmGy3MZ/T4x5H4aE2OM2a8LH+IRYjmDj97m03gZiZe2Xrt+NItF6oLqEZ+pAAvs+yURHmyqq7SlN5hUBB9p7ez+IJaLGKuL2ZqRhxqas/vhXi0jBWVQbF3UgnegTNmQxgmuMuKK56TwCyLGbTQSb6wa5dg0v0tvK4wh2IUlLCQWun1l9MZpDUZ/KdoD/RR7A3kfnnP+F9YDnBU0VY72L3F+oAs/cKY2uYA6pq4Sc0dbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpyIZLHJdYGrdAgRQ++1hBcYfxFYl7GCH8AYXcTRlxA=;
 b=aSDXpVxDv9snm/wxm4I836TYoYOAdWhw7jIOzv3lxzTaunE6GLeyXwgoE7uA9lsGinn6OzIjH2qczIq4Vj7jSHqk9v/ZvROs4/n7pmASIR+BnaRsOUpS6IjGUN/e1u+VI40qpzw5/Vq4kGsrRJnEyaS2Vk8zs0NJrbUxtGYpM+JbaE1aHIVs8RyH7oQZlZLLqZQXZTm1F07L8c7zpc84QO6IDLoQAi7D9Q7d4aKdUOoBqOddxQiYKLzHh93MZq7EsDxmAOPjTWQY6V0hl5PrUj4n8wQVIKcr7jNFVS+X8wHL/4CycJAMLlNA6Ki/OCw06wExrbUtFP7ar8pAX8pNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpyIZLHJdYGrdAgRQ++1hBcYfxFYl7GCH8AYXcTRlxA=;
 b=Gi689XmDEVvnlXH/lkptdGpYCbx+/S7rsFOVXy0AkS/ZqmVZRL/y3wTrz//A+kKykO1WZMReO23eSu1qMT4IYTu88zCVCT6YZRT9q+HoWsroonprVW8PGhXxhbCwVfA04s9BT2r8zzTOlkfILyOGAnPGZjTD8heXT3Nm1SN3/iM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:48 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 34/55] media: rzg2l-cru: csi2: Introduce SoC-specific D-PHY handling
Date: Wed, 20 Aug 2025 18:07:35 +0200
Message-ID: <20250820160758.801813-35-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 23e6c88a-b1e7-47ba-2332-08dde003fca8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3KQJ6eJ8bXYIlXbfUTNlJATZHO1QLat+re+VAzB7MWoG9j4DK5FhGytvYjaG?=
 =?us-ascii?Q?IQcSbGwzlvf99q5rOLRCVsoqaDgfLwp6qTFdbKX4E+ex8Z2+5ss0qk1QCfCZ?=
 =?us-ascii?Q?3VAzVQUm90OMDzLAaU87S1hXPaKN9vShmF+UEPix+r4GX18T95AqW/8Q03Qc?=
 =?us-ascii?Q?5JVEq7WCFWWr2mzumUy1HVTpVDPlkEwyElzPCIWTw7u3G78vhv3j8yUvbHBa?=
 =?us-ascii?Q?HZB1j6aiAt90VqyP3VXfhRdYHqtfyiMqkeABuvYBi5TR94iIgx1cyzXnxXbi?=
 =?us-ascii?Q?mKXh9Fjg+MfAHjljUdTQUgcrOIjxWLgiXNZ/DfLcMf+aB3tRI88gdypLrEBz?=
 =?us-ascii?Q?wxxMFtGIGQFR84Yi4PsNt8LLdOqUdcw3ljkR/VcLv6qsCmVrD5E+weril0Xe?=
 =?us-ascii?Q?lI7QBvrkuGdTIcjRxJ6f4ak25LVAhV/PUM0sv4ig1bAfvCiws1tyRyVIj2XG?=
 =?us-ascii?Q?qYnDTCRU1yHL3u97KFArwzQ/VsKJjdrwMqflnucMNfKlh7ACcgN3/8CHCbk8?=
 =?us-ascii?Q?K8Et1rdxS0GTk9MOYCUwxIfIl/TlDuM4P6JhwL/dbngFUdpmAcKGRuLwnj/C?=
 =?us-ascii?Q?n19MTQ1U1UptInYzFxgR7ZNpzi6T13rrvHNQw1ZcxoybwCLAxWcExnww2/W3?=
 =?us-ascii?Q?DVOzXwrbl+jlVfUfw7rp6IvXTU3RCIFUg8gO0o6gMhHKTFniJ/+dM+7bo5z3?=
 =?us-ascii?Q?kMVOZ2lRLANtxp9mDRwXSfdRUh/DJBHSDgDD4+M29Hm4c1HaF5fu2UwPa0Tu?=
 =?us-ascii?Q?32hbaaIEt3rp4r2ThB6FT+NHGJms6oiam2JpFDjXS2Ts3qeXrV67LgkE9ptn?=
 =?us-ascii?Q?nICdYHS3GinNJhteILk8zXHwunuX4pl7+FTYgynomi6o3SAK4ML7ejjCS9uf?=
 =?us-ascii?Q?Nfn7qZ/JFVQgk1NIONRA+OceKqEjk44ef/jOtgQpDZiYcB+Uo0eNXVPR2ni3?=
 =?us-ascii?Q?Ik2C5t/1ld7+G6qfqB1uSeUNXkVFUxCs0Fy2Nn4xYZ3k/L/+7BwZcjzBaj2y?=
 =?us-ascii?Q?NGfup48+AiEi5+t8LR96tfMjT3mXUS2FV33Lb/j9J+N5mZL/KG90Rmm/QsC/?=
 =?us-ascii?Q?Kfb//HZ5xzbZ/FMRO3h4a88XEKfZS5rkVrSx59qoHalAnVBfRMCCluGtglsp?=
 =?us-ascii?Q?9Efph8OxpFDjUrbT/JchYnEd6Si7apzKWbwbmI3LxLXa5JGNB9GUS6V5xTKi?=
 =?us-ascii?Q?QjW5+LboabMROCvEEOQ4bKdcGXjil1igWaH22fXzaZLs5TMPN/ZTJC9dbOTU?=
 =?us-ascii?Q?e08NyqP3/O1a82EcUTFcZnGIMTh5iEjp8GiMkHLijSWaF6iBoi1A7rrRwC0D?=
 =?us-ascii?Q?0+ri99KnbWgq7j/5R2N9Rg4WbCYibqnky8oA23wYojIKU3Mlf2Ak/rhNpOQl?=
 =?us-ascii?Q?Eauv76xR1U1ln+y4eYyDec8BnRF96l1/bBDp+aGg1vlBAY3jozjxuqw4tooS?=
 =?us-ascii?Q?9vVkLmUtWixvqv08ovpko/Dy+B2Z3XQtBp6eyzFV95i/Nem3CxYad5H18oi0?=
 =?us-ascii?Q?La3C6bBg6VTXLlk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QrHCMCsRP8Creodwr2O581g4N9GnF1EkO0fa0wxsyXvnk4x3ssVcFgqvUxzM?=
 =?us-ascii?Q?xtaUNRokzpyom7Lwn66hUxpF1giIjczTbfmEjT8kl2KDeOwK2X3MTye2LnmR?=
 =?us-ascii?Q?9sIrblncV54Pbi9tIvKji7NW0rbk5Fb56phmwxFcJcUCD7ChY1p6Jfd8Kuu/?=
 =?us-ascii?Q?5Bgz2l6hfsJ/XabNIsshfW8K37HyME6oNmLpypubq2fIKNYZmZy4mJ9LSTk8?=
 =?us-ascii?Q?ya8BP09niH+K9G1G5Ywv1sH2IxmK9CmsDenX2G0GsK810VcyIK48IxWNSzbz?=
 =?us-ascii?Q?ay629k2qfgNkvSk9LBgLXTaWJtazSgiuMIn8KVfg9xNuCVDvqdvCFTjqKblv?=
 =?us-ascii?Q?8kqW5jaa6iT1xrpmEP1u/lmxnuNSR1zW2BEFpYd12cTSVhm/ptmVnS+m1sM7?=
 =?us-ascii?Q?awKw497HrH5tKGgBg06ZNfRBopfX+mt4ziikJIxg1/pgjAPyTpE0+6HHALc0?=
 =?us-ascii?Q?rPUio4h7kS8m0l/IbYPUPAlM9b1RdEPBRbYzhrHJawUMzHNZ5Oy5z4RMikRN?=
 =?us-ascii?Q?ePl3ekS4i2fShInvJT3Erjk9uZVStdAxE+QPzdtNcEdSlkB16PlBbpteUa8V?=
 =?us-ascii?Q?G8Z03JM40M6xciXmouEeYtNdp6/xgDJ4QFsAkbU2JF55/Rwf/4XyBahhIQ/Y?=
 =?us-ascii?Q?2CvlQekYg64EGPcIs9WtwZrG6O61v4vvBh3bLoJpOmFDCSl7MIYc0Gx2ThJU?=
 =?us-ascii?Q?GRHnpMauWBIMXQdY4CspO/I/Ek9MZHo/Rwoeed4o5FizfKXB3x0svYQWDt//?=
 =?us-ascii?Q?CbnsSGO2I78R9Jfxr3Vr8pGcK84PRgmyIrYiQ7RawK6q/333K6GTJaiRtQJj?=
 =?us-ascii?Q?tmHuYs/G9/zq7EQaEO45ui5LhhVQgAMtu//HW17K3qQVZjSCJ8RkJSDFuO+A?=
 =?us-ascii?Q?JciEbujNg/9QONXls5WK7EnJJqq2LjHhdYLdhDz2sEHo5bf2sFl95Wge4ECY?=
 =?us-ascii?Q?6Af0ZHXkTYy55vtRvxyTTA1qiRvVH+5nxrAPg6eToHtolTlR41wLhm7gZr0E?=
 =?us-ascii?Q?Jb2jQJ9TjLOa/e/qhR3GqDBoRA7YHAnY2RrBddaqg7kYPRYp9DN/dg0x8O2/?=
 =?us-ascii?Q?56Xz7y6qyP3zytZZGGfNeMsPKRW8G3aRjaCCjZIWVNaQFU8bUu7s7JMnnL8I?=
 =?us-ascii?Q?ggDooVkCSMX8N0DuPdVe2qGbZzgq4CZGgeeBdm3AEf072C8X+XPPP5xq19HF?=
 =?us-ascii?Q?4zBDep6fHYJiFgb8Xw1Mz0EtMlFB0+n8l9XCyr2UeD2bT75YBXy4QwbGvn14?=
 =?us-ascii?Q?oF19GIJddshKe2gPpSGGGppDXuoqnMpozyqNgE++3wKrQZlgquc1Y4tkodYf?=
 =?us-ascii?Q?dXIUyliGMP+IfZCBPKTdoheibHNgmUTtiIcGjHVX0tKFDbP4hoU6bmcLogsW?=
 =?us-ascii?Q?Rwp2hfM3usCZZl7z8eV7xldO0SBCdXAEhRWsiG/L4OtHNvqtE7UhNtVu+PEt?=
 =?us-ascii?Q?8StaE7oDqNJGr8EohiwYDmPHlW36/ZQ5SQJ8YuzNGsxjd/YK65ldRKPILZtF?=
 =?us-ascii?Q?3MOCUUvAadupbWAP1AJBPKFZQVJRG5QJ+03Lzc0NX5DUTERd6e8bXqLMPuP9?=
 =?us-ascii?Q?0kPkkwbnUj+6G+lZ1/kHjAUpQfKcH1vJMvR4U6oGmq3m5MdZ5nGogofuFhep?=
 =?us-ascii?Q?U0QIpIVfKkza35rLFOQA/4s=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e6c88a-b1e7-47ba-2332-08dde003fca8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:48.5732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04SJzUKaaLIhexd/H7mmaTBH8NV1+xZouBfaFtEWx2XGLCOkY7YMR6piPzZZ6SRyyI8B7/zw3uU9xjnRffQ1LY3qOOrovOy+ryWF+ERyPow5FFJ6xkyIpWqJuhLj4mWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19915

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 15cef2dc7d688d5fc4919aa3c5c272931a8cd087 upstream.

In preparation for adding support for the RZ/V2H(P) SoC, where the D-PHY
differs from the existing RZ/G2L implementation, introduce a new
rzg2l_csi2_info structure. This structure provides function pointers for
SoC-specific D-PHY enable and disable operations.

Modify rzg2l_csi2_dphy_setting() to use these function pointers instead of
calling rzg2l_csi2_dphy_enable() and rzg2l_csi2_dphy_disable() directly.
Update the device match table to store the appropriate function pointers
for each compatible SoC.

This change prepares the driver for future extensions without affecting
the current functionality for RZ/G2L.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-9-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index d7c8022fc9b7..e02e8107a33a 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -107,6 +107,7 @@ struct rzg2l_csi2 {
 	void __iomem *base;
 	struct reset_control *presetn;
 	struct reset_control *cmn_rstb;
+	const struct rzg2l_csi2_info *info;
 	struct clk *sysclk;
 	struct clk *vclk;
 	unsigned long vclk_rate;
@@ -123,6 +124,11 @@ struct rzg2l_csi2 {
 	bool dphy_enabled;
 };
=20
+struct rzg2l_csi2_info {
+	int (*dphy_enable)(struct rzg2l_csi2 *csi2);
+	int (*dphy_disable)(struct rzg2l_csi2 *csi2);
+};
+
 struct rzg2l_csi2_timings {
 	u32 t_init;
 	u32 tclk_miss;
@@ -355,14 +361,19 @@ static int rzg2l_csi2_dphy_enable(struct rzg2l_csi2 *=
csi2)
 	return ret;
 }
=20
+static const struct rzg2l_csi2_info rzg2l_csi2_info =3D {
+	.dphy_enable =3D rzg2l_csi2_dphy_enable,
+	.dphy_disable =3D rzg2l_csi2_dphy_disable,
+};
+
 static int rzg2l_csi2_dphy_setting(struct v4l2_subdev *sd, bool on)
 {
 	struct rzg2l_csi2 *csi2 =3D sd_to_csi2(sd);
=20
 	if (on)
-		return rzg2l_csi2_dphy_enable(csi2);
+		return csi2->info->dphy_enable(csi2);
=20
-	return rzg2l_csi2_dphy_disable(csi2);
+	return csi2->info->dphy_disable(csi2);
 }
=20
 static int rzg2l_csi2_mipi_link_enable(struct rzg2l_csi2 *csi2)
@@ -772,6 +783,10 @@ static int rzg2l_csi2_probe(struct platform_device *pd=
ev)
 	if (!csi2)
 		return -ENOMEM;
=20
+	csi2->info =3D of_device_get_match_data(dev);
+	if (!csi2->info)
+		return dev_err_probe(dev, -EINVAL, "Failed to get OF match data\n");
+
 	csi2->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(csi2->base))
 		return PTR_ERR(csi2->base);
@@ -891,7 +906,10 @@ static const struct dev_pm_ops rzg2l_csi2_pm_ops =3D {
 };
=20
 static const struct of_device_id rzg2l_csi2_of_table[] =3D {
-	{ .compatible =3D "renesas,rzg2l-csi2", },
+	{
+		.compatible =3D "renesas,rzg2l-csi2",
+		.data =3D &rzg2l_csi2_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_csi2_of_table);
--=20
2.43.0



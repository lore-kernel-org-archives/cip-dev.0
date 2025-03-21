Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C803EC35FFF
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:29 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.50])
 by mx.groups.io with SMTP id smtpd.web11.18708.1742554886872899739
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=AF5fzBuJ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2uIJgw8ooZoUJ9RSDL5oeOWZci9xPfCCOYPxfJGoee00Azx+Eq9V7gDe9p5QI+mcfs6l7S2vfRfpbl6zvr7ZhG+ROVpYWRMnnrjfk2mlsJFivwthr1paLPlZYreQ5Xy4zK6NXoO4R1IsEX7wHtDf+v/cSxCt8y4UBxso9yu8jeasoY1xOqFAX+Bz8Hv8LN2JdMxgflx0lsWn0Oc4n6nkesv6GS2va7D1jxPbuTBnl+xfCSLFLVDPuTH7QWIo6cEYvVxyw3Vxh3pw35RbwPRGy/QkAedbmnQaOYkSY2KVAJROjNTHvI5D3xr+nVKeo6Lv/BRljeg+P7Kk1Vca4F+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FdzhrUez+9OzyWWw2ubmmd/3FVDiQOwaGd08GIUKQM=;
 b=NK1SLPJcI9sDHreZDuUSa4CGmRIEGkpkT5awB6yIPlmEhyKTVaj0iGV5OOa6uuSGv8h/D5erjjaXg7bDmEhBjJyz99bA14GJ1Kkn0TwGVxsxqLqHo5RHm5Z7ZjJGptNvYl4YhZgV5T6a2qT4KpJl9cBzEf4Pr+a+2UkV41pZMLWGoMp0ot5hCpp390LtA5T05xvwOHKg/LEoCVBoQKHx7bffUDFhI1n902zp9TBXOSgWlIoEDdXL355bKWpZwkFwdu3XmF+WE4enIJv8TL8uA1f/1OmXC9gF/+OaTAbCWL54mc3W2D+QG8lBnP8etZSIliYYFpmeV02wuywFRrHgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FdzhrUez+9OzyWWw2ubmmd/3FVDiQOwaGd08GIUKQM=;
 b=AF5fzBuJf9I32pxEvudRnDD8wl0fX3fpwd2isIfb3ENxdh4JppfgLGiCJpdqKuY6gSLoSkrjdPHs764nZ9Npdrz34geXRCg0T2bQaYc8csuwuoDHVLb4u+yEn0Zc4Yjha+GyK5v3XyHB0nA7I7T/uVjzLm+ci2jrkDrnHtGY/Kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:25 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 15/21] clk: renesas: r9a09g047: Add CA55 core clocks
Date: Fri, 21 Mar 2025 12:00:15 +0100
Message-ID: <20250321110021.3612805-16-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bb2804-c107-4c20-8abe-08dd6867b8b9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qRkIXNn+V7DgJmb2ycu6nJRp+MaoPGhFZXm7IPOuTzygE2IaUAV8jdaMlBjX?=
 =?us-ascii?Q?Iil8zxoq8L3sX2qqsWBwa7iNrNo+RASp1n9oOYs4IMgCkprbNMN2BU8uSCzy?=
 =?us-ascii?Q?/BJHTR+jlAMR7tRBSRhotLJ3R9/2FFd8nUAa503AsuXU2BENM10B5M4z/oat?=
 =?us-ascii?Q?wbS68ZN/WDk4GMMaZkzXyUFtCfhVcPgLSjCd1EhtUGTpXTrXrsQQK+Dt+P0J?=
 =?us-ascii?Q?eV0yeN54GuIfrpqkSFKxSsrXZOlPJHKqLEueK+M9Mn3hXtMwIcVynFGCqqf6?=
 =?us-ascii?Q?wK//3VOVrWyQXAdQ2Gm7phg76+JJjOTLev4Z7Kh+rOQRdlM4HLbdbIt4WAs2?=
 =?us-ascii?Q?9PIEVIwWPkMhv+T/SspVdB+T4p6i6hN+DkfRfovCuFXMWmHC7fMN+21FLws8?=
 =?us-ascii?Q?/D1XhuZQ+D0+L+6PO4t7O/6e7PNcqysCJdvYLTvcAqggOyNswWEJGG+rfbI1?=
 =?us-ascii?Q?RposPD3kP9Wzwu9M+8x5LX/vBqd6xF50v7Hvhm/26DxK1Rl/XjQS505B4DhM?=
 =?us-ascii?Q?2OQFWtpR62EKZpsE67wWYpXo7S5MkDrAplsVWzGakGVdYjC/kFKFZ1nVitj1?=
 =?us-ascii?Q?zGYPOG/yV6A6rvZKQlyBFOxkyTDUr7fH0QB4u0aPFDcTRn5trmxY35Qwbwqi?=
 =?us-ascii?Q?hACWpDhTiNe9K4IQPMKsKtRyOTBJa39RJdYg628RW0PqJKCTNkm28yLsKwhw?=
 =?us-ascii?Q?HV9MsUc6IMWhZEPdIGKE3Qr/mTJrRtQfxP2HW+uIqLIwxX2IovLjcR9EnNdY?=
 =?us-ascii?Q?CIrvETO+yUsDru/Z6FATnzVLamZSMvSyNVE3DXA5gUyTTTKrh4h07b4H6avj?=
 =?us-ascii?Q?LvSOay0g3vrGxeAJdKFGdHkvqro1FsFaLwOg3s3VJ7aTD7DSXaT3dlJGZD2o?=
 =?us-ascii?Q?KIBKVSj1ut17S1ipfOPiK8sECn+Sgrp4zdx67x8zfs2lIviedwPi0rLNhkYs?=
 =?us-ascii?Q?kZF+9DZa9IV8tJuxTyip5gsPQ1Vp9v/CXF8Ez01+Jpc9pkbn9xEYjW+7zj3p?=
 =?us-ascii?Q?0Oqe7+7yXggxb2WsJcOiz4mnvgdWFI1h8diqMmLPQ7ERYtlnoAsJYpbR6Yqi?=
 =?us-ascii?Q?pIp8ZAAVGs+s81uzzSx8In2sBtUp3j62OWFftSTWQlQapVS6o8Z6G1Wfz5FH?=
 =?us-ascii?Q?QKD/ZqoCbnIFe60czg53RXIkynzWbXV1icYu72cM/Y2t7j3lTEB8XJAVZsOB?=
 =?us-ascii?Q?qohcFS07gmUJQmiatJJXRXUbAszFS+PplQEvnqOxrrV4ceehtxub5RfhDxOq?=
 =?us-ascii?Q?6ESzGv3P+soG0cAh3yVCnrSLo9vSgL0DVs9ld7OnSO5qi6BBeGqVy4ZSdGpe?=
 =?us-ascii?Q?nGUe8sGMfoEGyEJ7KpfEtMzOaoEybDbU3hPp8aBY/g0QxvFWZVIkytlIXbER?=
 =?us-ascii?Q?rIFnQXhszX1zofb3FN3QOWMOQ7YPyKuE1ipxHvLgarPi0S/6sjwPKTCvo21V?=
 =?us-ascii?Q?YkOW3rWUOPqCKWn/e5JfwGCMDK1FxHGo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hLejkU0C5alNT1Wpn4FOYwa6xhOuErJxALi4QK6HBhTy/eYBDyLmNv7P+Ofp?=
 =?us-ascii?Q?kghCO+E6zWvqimQ0K/4m5uK94qyVRPW5IwQP8hddVmCyUiJeOGuQ6GaMJcEP?=
 =?us-ascii?Q?VAb0PQx/u1msdfUDJR3YQFRS2aCCsJ14uCeohUL7UCA0zHbBKTBv96ZaGUgd?=
 =?us-ascii?Q?SShNYndPkAXEa+ConKhMgAOQsxb2Eaio720/Jjr87+SqC2RwT+Cl/vhoKavs?=
 =?us-ascii?Q?83yahHSE/Lisd/I0WRgeTO0hkCcuNvWfTkrr5AYLGTaTm2ukWeggSN5pqFjk?=
 =?us-ascii?Q?Z3NUhwuIlvFq9sTSkfOa78+O0N/LsJzG95soXrDuSWOVXsiqmDWTlHK0cSlh?=
 =?us-ascii?Q?mu3Ay141DSmo49a91GvGxQfpJ5m9QGmO/z4u5tAUDUS8ivmeu2W7VKLCVH6H?=
 =?us-ascii?Q?5CQw1zMM7pkLKqWpWLE9yOptph3jhfRToUrKV4S+JxQvflrXfhPDzDWn2iLW?=
 =?us-ascii?Q?rZKsmcn8dzOsgQikb/mM9FB+hwFV0d+XYvMqwyMMtlsaSE/lt+1sBgnduLzk?=
 =?us-ascii?Q?XHh3bXG8J3xD5wXSaeIbOSlJd3mZAUFZHvwecxPj0egbLuFlg0ShMXwmZl7Z?=
 =?us-ascii?Q?CXm30xJyQQAbBqY52qZGVp9PXY3h8KaVjCrYdotMWoCBX+esv0DgMlDmHscg?=
 =?us-ascii?Q?GHV4cHIJDdEvnkSEmFAdkaafZmNCadv/dB9Se4AKwi2hyw0AFoHo8VVPPyCa?=
 =?us-ascii?Q?fkKh/TBWP1/K2nhcgCO+u5DhIfd3PoYmt8xRhInQq4HVNfEEkTwCJ0sPz0S3?=
 =?us-ascii?Q?cNSgrd5sFfrXGfZU0V7SQVYfku9xjQRMwG/KG0JsJAMii6ZygNcW6mjP5qob?=
 =?us-ascii?Q?g8wzixKmtvHPPNRJU3zSz9O9N/X/vIeot8G4wJBdagqafvXJaV8lwdH1a4t4?=
 =?us-ascii?Q?/ogNbiUKSkKpVTZVBwKs6CrKsHnC+r/KjrD0sxgf7umVWcA7byGsaznq+MYc?=
 =?us-ascii?Q?9SyIgFtKmL+LW/mASjmx+56LT1nMweWLw17kZeELnvHiw47v2RDsvmYPDK4p?=
 =?us-ascii?Q?aSGMCmkZv3+4uwXttakWv+RCXtr278MLrfhecmreFIpSJEFoJr+lHxKN5g0S?=
 =?us-ascii?Q?r6BRNcgvLTfXUD2po5cNPHWP5NL2ZWSocdTvaPxmk159lPkZwCjeObGQgMfK?=
 =?us-ascii?Q?CRey7le04ekMXoiLtGRo4pJ3Flfg/UjgOSsF2ee7jt6BvPFw6j0Caq9eB6ju?=
 =?us-ascii?Q?phnV0HNEPCBncmp0YIx5lwHc0sJhIxfUD200Wy3QyK/ls10j8uh3RlVdtncg?=
 =?us-ascii?Q?jvoOHDnGs8o7Sj2zQLHMGXdfGPPn6kBFL9KsbEneX0U+8fVEMoKnEJ+RVM2Z?=
 =?us-ascii?Q?/Kal7sT4E/Dx7QLcXPXcwQD6YDozZFAlZ4xM0yo1ZKWHwdCmjQV13gBsqAee?=
 =?us-ascii?Q?oG/7qxLvK7bbpnP8NtD8HzHlcHtXoSxPkvSn2Xfl7mmKz1qUSGBOCgm3m4vd?=
 =?us-ascii?Q?ddm7amACVv+EsdF13kRZQG/3TMeRTsjoK0S7bupc7VayqZvg11Fr/VEA3dQl?=
 =?us-ascii?Q?/fC65PGEEYELwaKHLcq+0VCNb3RfIruKWgP9/5Vx/a+1wStD8KWyC6Z7Q5nI?=
 =?us-ascii?Q?DTHqqTIJqreG9CDOKUiIpcX/qjEjwvjorCXXFV+71p2ulzm0Az4W8+WdTCTY?=
 =?us-ascii?Q?EH/hGzLB8c0a/80ClxuJICU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bb2804-c107-4c20-8abe-08dd6867b8b9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:24.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEDV6a3lbA3rM9mmLyVTlH70raixumwrWHNBj77sxWCZakMqP1loeNL2oJOQffzKdW0w5i+b0MchkRzf6lX+BqGU0Knf3UEFowBlLEFXoQJBjblwafDKzUKSAURX3eaz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18322

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3baf0273c0627b7e6029304166df17e07c6796fb upstream.

Add CA55 core clocks which are derived from PLLCA55.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241213123550.289193-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 1178335dbed3..f5966c08de41 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -37,6 +37,14 @@ enum clk_ids {
 	MOD_CLK_BASE,
 };
=20
+static const struct clk_div_table dtable_1_8[] =3D {
+	{0, 1},
+	{1, 2},
+	{2, 4},
+	{3, 8},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_2_64[] =3D {
 	{0, 2},
 	{1, 4},
@@ -65,6 +73,14 @@ static const struct cpg_core_clk r9a09g047_core_clks[] _=
_initconst =3D {
=20
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
+	DEF_DDIV("ca55_0_coreclk0", R9A09G047_CA55_0_CORECLK0, CLK_PLLCA55,
+		 CDDIV1_DIVCTL0, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk1", R9A09G047_CA55_0_CORECLK1, CLK_PLLCA55,
+		 CDDIV1_DIVCTL1, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk2", R9A09G047_CA55_0_CORECLK2, CLK_PLLCA55,
+		 CDDIV1_DIVCTL2, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk3", R9A09G047_CA55_0_CORECLK3, CLK_PLLCA55,
+		 CDDIV1_DIVCTL3, dtable_1_8),
 	DEF_FIXED("iotop_0_shclk", R9A09G047_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1,=
 1),
 };
=20
--=20
2.43.0



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B1BCA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:13 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.7])
 by mx.groups.io with SMTP id smtpd.web11.922.1755705967735240949
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kXInTPNI;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgumPBl/LjgirWe01rpvqVn0FX2m1idOIyaOM9RqNWEw4R2f0ZvoUXEQPpavp86bdK1Pux23QDYaAKdzQFUAC72VR4e7AfUqI03alfXRFGRDmG7HLBtKPvZtMLHicm6KS9pR64/p7cp7vThbb075LeBYjPCQ8r+RU3boUWyNQTujOQttUNnNSY3tUE+5J3mliOT5C9tNc6r3eC2L+j8Ip0E7yQNsGQN+7wX5+7ab5fd8lB7L6dIXviRFp917MuThLNy9SOHUDs/PVibRUvXLiyOJLxRfxc1DmToE56kIYJAZ0eIKAHzebbOdHnYqgrW91obaB1+R7iLxI1zRJW+74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZdCWresjJcZo0LdtqoSSTPVrfxeWGORxHKwqkGw1s8=;
 b=x1y8eDYWe1lgadyHW/O4y2HBmjMkTbIEvx7Ql/MCTW4/8o7eXXFPUmEsWQcZOEg93vp6YPN9ZKDLwKPSWsmzNY12V5wNCllCiE/rE9XcDaKZNJ9l8ubc5W8H6mucj+MfEO3lFAX/Do78p2foF9/tSdAj7Brk9Li9qfVGFS6udnou5xAeL8Z3WTH5x3X0rHEdQFZZiDu8WRCbuj/giksKj3FsQcs3R/kO6JaAG5DQy6NWedTeBgMfVpYKiwUycigZBz4bYSPRiuh75OsoXgB4kRa9MLY0RDc4Cj86u2EBjTMbqWZvfN4gYLKPym5E4RjyjvErHbZ6a9X+lcvwpijrLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZdCWresjJcZo0LdtqoSSTPVrfxeWGORxHKwqkGw1s8=;
 b=kXInTPNIgK6K9tU9lxNZhM8FN7mps5Kb0sEG8+qRGFwEKclOMhzZonluZvW/S5JmHytsCZ04kqrA5hvGjQvjvu6Knb1LnRz4fMB4OphdfF+SFIfegm/Yb3xOUrnT8Q6iRBAXs9WhPcDlmeIi4GHROJHqriBDFZsgPOSsQI/R1UM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:06:05 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:05 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 34/55] media: rzg2l-cru: csi2: Introduce SoC-specific D-PHY handling
Date: Wed, 20 Aug 2025 18:03:50 +0200
Message-ID: <20250820160413.801341-35-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f3043c9-fab3-4bff-5a37-08dde00377d1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vz/hTE6ibfXUxKvEzjGtz08sjchzXg1GVMUDHs2Q/k1YNS3Nt5bRB+VJ0TjF?=
 =?us-ascii?Q?d+IGHAP1J4k6I02/FSSRqHw8gA/0X7reaw5mem4ynwEeBQkwqxbNFnrY2Ua6?=
 =?us-ascii?Q?7UdYxZhe2ROuq8IjrJ+zVc2kzcMW40KfDHCxjl+37fqwj9WBWhe+dglAR1aW?=
 =?us-ascii?Q?LRgBk3Z9moAP1y5d7YhCJtQptbkbw6jm0kU2L75lsh3btn/lE2aGTYIPDbG4?=
 =?us-ascii?Q?oloRi0NDM5Kl2xwGeedjMY61aei/YFG6gt1CnRKRR3aYRZu4xyZNkijzVLHO?=
 =?us-ascii?Q?y6mZM0GjEtQGEsTPASjv26iOmsQCg62d9400U3W4Inp37VVHP05mhanMEoY2?=
 =?us-ascii?Q?FOLxtgzmUvQll2QB41q8O7C4i8wlRGrHqJU5jkOb00msgopLkgSBqgS5OAQs?=
 =?us-ascii?Q?9xWHP9Kbsq1Dm83sM712ggApzKp67ZTApCWdFogLmB6hnREpxAM5eakxbFW/?=
 =?us-ascii?Q?RdqxbuAzipf0Kw7jaEx7IPHxdeKGANWfW8BbiBtW9vy3q3knEfIbrv0bAyuR?=
 =?us-ascii?Q?aeyJQ7CyDWfpbkQkzWXrp1kBvd2S9NeyKvuUkMO/Dy7db1S8bD9pfZOMcBuA?=
 =?us-ascii?Q?xOYCsiQMw4V/hRPBbID5zaFEVXmxFix4rnmUlN+rs6u1uP2gLryjix9TKaIJ?=
 =?us-ascii?Q?ggMlHz92xGvvH/swPnA48K3jKL8AQiBnMCcLIt6zuldYJGV3XvUak+ZS7ru/?=
 =?us-ascii?Q?GYCpkwdLQXeFPoaqb6NcydhLpY5+IBBiVS/U4nvjsXv4bXm3il+eApeFsBli?=
 =?us-ascii?Q?5k+y9VeqElZ7vGsolgOWNth0Vw0g4z3bRLBkFo2edPzTAuy9mmjh/xaCRxcA?=
 =?us-ascii?Q?UmctaEEHWt0+gGRFYWtM0BJuOp8NDW05nNIhknMqcxpGIA0FPRzYH5W5VjuO?=
 =?us-ascii?Q?1KAH6O8W2ifBlsKbQxtqJIu08LzjjM0YLGq/iZ1Lh50mX9lgPyuhuzt0tcum?=
 =?us-ascii?Q?eCI3WqvsWAg4Fz+08QYCcWp2R+Clmy2L6u78ewYY2yFeQnV0AANfnrC+Q3N5?=
 =?us-ascii?Q?RuXQ1UPoFu3wuisw7VnndBKZyKAJEIzpBUFoRJ+gBo5ZX77dpAWHLCCh8Flz?=
 =?us-ascii?Q?rSG3JWBbuDIy1y+QibNds+9NQY3rH/jmtIcfRBwV6RujgF7l61Y1U9pds1N0?=
 =?us-ascii?Q?Ocg/bPLv2lgFd8m4O7XzagT0owbO9PimPE00C2ZY8nzz1YnL27eDkru3AH38?=
 =?us-ascii?Q?/rBuRyDyzvZSfhrgIlg79vo87ODHgJ0HTq3nGyYzfL6h2n0+86t4NyHO82MW?=
 =?us-ascii?Q?7clZzfPzHYw+iDeJqII3AlJfttPgu+In6c24cTV9oWpSzBOpB9Ct5Mtmk8gJ?=
 =?us-ascii?Q?blnxUvXQywbOpTKzGiZAOZX08hR4lWudEbQDL2S77C2mbptfdmbKdhP1Q5dh?=
 =?us-ascii?Q?+mDcy23ODIZgWg/G6I+EL8rC0951MTcKAUcBPQgkVM9+0uMhXR/tCCKaPnsS?=
 =?us-ascii?Q?pAD6BRqkfe3dnCRkz+eIsRcUot6GBjT74d1cgSLPnqOAuTp2lMufv/3onWL3?=
 =?us-ascii?Q?aNbt4oIDWMRnnrY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TcKMQgOQVhU0B2RKd3viTjpnaQd1yCJ4a2z1r4vihoRibv65GIuTFR0f0XNd?=
 =?us-ascii?Q?+So74agZ2E9iW4RlX6WegL8tT5M9jezAX0qnhlpO8uFxy06D+VjsW3XjE+mE?=
 =?us-ascii?Q?gWkWWXjkCs9/soKewfI5CAd7RSnEV4OmQKn249nw3P7xeo54brCS9y9n6uyR?=
 =?us-ascii?Q?xCpTb/hAur1M5lt8IGxgPJWRi8ZjMW2cP5DR8PXqLAGcQKadB1FmDYnJ723l?=
 =?us-ascii?Q?1kKt7h6DC6rLlfjqATCmMV+TWtNYFDI9PGJHMzE00npMgTCrutTSFmO4Eqjo?=
 =?us-ascii?Q?fWNq4d/X9a2JzdAOtNyG7w1XfLld5ZGy0QLhTzw+q0h1fcef/bz/lah18baE?=
 =?us-ascii?Q?4qIIDl4lf6RZeB5RnLwHHoIbXho3NUYNVgy3DW3x7vEkUNZVUG3vZ2bbxrir?=
 =?us-ascii?Q?R+HJqE9946wfyddy/01Zu6m43etraycp1PpefQb96kG+a64OTCurCMJMu2tw?=
 =?us-ascii?Q?LVOA9D2PiR5gRNiOLu61L9/0xVdB7u17UaSCFEFiDVwBcstod7j3D+fEz2ZJ?=
 =?us-ascii?Q?oVnmbyqzFLKwqLfv1OP20UoHrZgw8RMgpZ4DAJJvTBn/vxyHxTclr8RLt3Xe?=
 =?us-ascii?Q?f/J6iEJOnGwdWA5/JCDCX4EU1jIol8HYIhYgaT5M69hF3PWMfbG/i2F4LrLc?=
 =?us-ascii?Q?0we1I4CHPyW6ymjkKFx90fHqunVlU/WEHR1ImUmwAGKiaQntf8/Nh1zvVVId?=
 =?us-ascii?Q?3bFlpmq4ct488CqdkV3tG26f4Lahi0kIltxdjayxAM9jHNp98JZN5hIhExL9?=
 =?us-ascii?Q?5MEt+fDNIs4JB7rTkrJDQmMqyVhTjJvMSPnS9B9AVMnEsR3W/nzNScCL+AIP?=
 =?us-ascii?Q?yqD3BvIBDd5/k4oAdUk1uWvEnbDS3W1jbz9jJeOhhyIyvUB7IYvXrDOotZIz?=
 =?us-ascii?Q?/evh2HiM3nBzLuhpfFLRuTZSCXGl5l32RinTQ30O++m8VWWsoaMmEEumOPEK?=
 =?us-ascii?Q?6xzqW1leu0KnMqbLSa9QWTeVUuUus+uots2Y+sMwrPIzlM/t3biTNMLdUHvx?=
 =?us-ascii?Q?z2ES3WR+xACogvKcQgZzQTy0vOL2R46jgqnsbdZ9EWBuCF/VOaoK8BocA+HM?=
 =?us-ascii?Q?sJdXjw1EsJHPaw8zYCP0xRCsYidzt9nPioreV9GH/Mc8/6/U3e+EW8gG9Hk4?=
 =?us-ascii?Q?NMNm9Sv/L+6rBQx+oauvmrggRJaIWpDfe4WdaXgslOwdTaIi629KsSkC50Bc?=
 =?us-ascii?Q?dC20HLq5Jdmjoipe+AU7olj4FlR+Uw/N0Tsew8gyBHtYTxPlKD4+Z5qQKIJ7?=
 =?us-ascii?Q?ksKJ3ZPo5yAUAuBs+0S5eQLu6bB6fSRk3gFJLHCNSKOYLxp2rDdD2+yTL0Gh?=
 =?us-ascii?Q?GdRIQc4EhztIL52QvWtFQkqrZOhep0T+j8+/l4xZ7VIuk5UCNUeRq8pbd8Os?=
 =?us-ascii?Q?Khu8aaSQiTNtj5i2Qf4FGt1C75dOTenvYm7voyQ1DF/nztprxHAGA1lONKIi?=
 =?us-ascii?Q?4Z0qV6o7Xm8IKeOa1haO/+sbJHcI4UUswYyIXhPysiuZRSk1UjxG5WbxLi1b?=
 =?us-ascii?Q?mvUewgHEkgT1gmamWWt6Z5k4i8AHHzoYXC32eiUrJblp8xF75u6fBv7NQelx?=
 =?us-ascii?Q?bFsCKYeqZKjtcQpCBDkUh6QytLLet2ZHH6uNhHYDGLYUQ/Zen2j2GNREjVxc?=
 =?us-ascii?Q?FvtDE7W55wQJmYv0cD0CCEU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3043c9-fab3-4bff-5a37-08dde00377d1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:05.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KsZ/NtB1npGu2xulcYNUv1yiRAVMxYMfAl4rg88D3C0vaSL8tbU9Ei3gwL6+DN3o5UPVFiT9RXYVxVi8i8OVCzIHyxDYNnKdW+hbsSj17yt2s+W5f4MykrECrfufxJ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19859

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
index eacd7941ac39..0cde0c6d7234 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -108,6 +108,7 @@ struct rzg2l_csi2 {
 	void __iomem *base;
 	struct reset_control *presetn;
 	struct reset_control *cmn_rstb;
+	const struct rzg2l_csi2_info *info;
 	struct clk *sysclk;
 	struct clk *vclk;
 	unsigned long vclk_rate;
@@ -124,6 +125,11 @@ struct rzg2l_csi2 {
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
@@ -356,14 +362,19 @@ static int rzg2l_csi2_dphy_enable(struct rzg2l_csi2 *=
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
@@ -770,6 +781,10 @@ static int rzg2l_csi2_probe(struct platform_device *pd=
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
@@ -890,7 +905,10 @@ static const struct dev_pm_ops rzg2l_csi2_pm_ops =3D {
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



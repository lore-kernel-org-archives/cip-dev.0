Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1525CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:53 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.1])
 by mx.groups.io with SMTP id smtpd.web10.1007.1755706007218560633
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Lmez1Fmo;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnXRCjTL5X5z6sApgXk5ru3GD8m9xbBzOyOwxzgO69dzL8JOOM+HsHSdsj/2IeXUPZx3Rggis9jjbSj6FRS+kzdxFxYGs4fJR1pJ/qL103h/TT7AE0P7OKCekkBh3YCy7tLPuAlzid9/5j3s4OJpzu6dTv43UkNn4al0uCrVZRJRLtYUGvjpxkVHJWOA2eMU8n4LIWNbOVyqZ9e1yPEdHfoRvRzqi1KcpiDZhJKRF0jas20jfuwPAAHdtrG+ahSPkiaEIqE2RRtCQXLGUfZPjZvx4tw63wM0wjMARxUEZo5xIzszNfPp/JWroAvpKYu4IHsuEv83HVfGYuDN6w1W+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNCRZZKrNT0sePNaJ/3UsydWozi3060cINNTgPKly3I=;
 b=veFOs8g6kuvxt0bMmcvfuVT2qcBrE26eDoYatahqqDE3HgRqwsj56jAWwHQKlzRpCPGsNZpAFucj4q0SmOpF2p5dou6Yn4lZuYf3a45qWdIeUV636/LJznLmj/MJY4hCZOUUaACWbUO2EVQ8yR2ry3ZuAnijlWC6MAf1Nd89Hfu+MXCvLhmvRauZ192MDJw9RrHAIrAxA0gLO+3d3amhUtTu8a/saZqGHPf1UlyFSRXm48VHXyyToMJqR65GybL0M1XhO1x8yrcpKkR5HQcVU79uw0lPYs/kJMvN/bI6ra9Mb2oXzvartPgxSq84fuum/OFthyHtWmkdgGNtITOVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNCRZZKrNT0sePNaJ/3UsydWozi3060cINNTgPKly3I=;
 b=Lmez1FmoIDIUPtkYqTio0F0Q2AW1xFVEjsb90bBLo7g5DwFJBlAeN4cno76bzIvy2BQPF6bu/azlh0DlEuTJH51I1XNq31alU1ICRNVgbQQYCF86EOdxnf2rO4/CUW2QmKcXYLc8ePeZ8dMNtNGJok2xqPTv08Rd767yfikH1OQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:45 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 50/55] media: i2c: ov5645: Refactor ov5645_set_power_off()
Date: Wed, 20 Aug 2025 18:04:06 +0200
Message-ID: <20250820160413.801341-51-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 883f1c19-278d-4486-c6af-08dde0038f53
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?I+vsjpOt4I9Omq9SdQV+i7ez0ZJ2phyWGOjbS1Up4vboi7DXMNMyJ6OYBXqi?=
 =?us-ascii?Q?2XqLNiXnMwrb3C4nyqgLgA8GZVmPzl6KEh9NDDXs9+rmaVMfzlqq7+urW3RD?=
 =?us-ascii?Q?vtVZcC3I0Fo3vxK9/ClpuEq2DgLdKeOYGtnQ9l/0ZxIFwSWpzNarreNnkLXI?=
 =?us-ascii?Q?Ic3qmuBf8MnuiIN+SYAOC1l2LfkQ7HhG7V5dzfNkZW+s71ONoTwK+t3jy3B4?=
 =?us-ascii?Q?nykSgNU2eN9Hj9UVHDaHYAfncRgrs37eZqZJxKeVmP9Cni1TV+1sQ/wpTTuC?=
 =?us-ascii?Q?XBxwvz8Vo2Oj3jndsrlXGfMKp9hbnFSx8qflLK9bPg50EtrRafWF+102giwY?=
 =?us-ascii?Q?78VzCnq3bfd8xV00X6SU04a2GdXM5XzU67VBirrW8/vvQJpjycacw2mPQhTN?=
 =?us-ascii?Q?Lsk84w/wium6g3Rq7v4R4JriPwYvf9T5NRn0HxGMaWwUoz0xxYgsaFSOrqLk?=
 =?us-ascii?Q?nQCMSD2PLNLwLOPzyxctQV3LB1Kszjptsmg/S21sJK6KwE1/ywKNIgM77xdr?=
 =?us-ascii?Q?pmXOBX0HN01WShq3d8xnVnXL08YxeiQcigNyagHnO9A/uqiTLjoq8MHrbeBv?=
 =?us-ascii?Q?YKArTMbmqe0FobnoFkOST7FthruAvfi3dp/4OjRL6U8jBNWR4JhNYkc3czbI?=
 =?us-ascii?Q?IK9yJkGR1YZTeR6zKDJDWzDBBCW1BKgoZRPb/ElxZbR4jKKtmJMWR2t2XI2c?=
 =?us-ascii?Q?23RYhHhv2//6K2zfuyxKsG16vzPN+3r5B90GceYPeZGKxqUNkfH97dPGmEUx?=
 =?us-ascii?Q?JwXcq2XGx54k0VFsF34ia7xU4YWv7CACUM3XI3XvPcoHlKxtWZh5sTlzle4g?=
 =?us-ascii?Q?G27MCzAv+++zkhdh99dcZConn9tlIdl8LgGp8Aj0PuGrJdnxSIhqB+jh0HNG?=
 =?us-ascii?Q?/bfbGja2y7m9Y4aT6oXjnabImva3KVFNb2ZEvXk+Bb9wOQWIu3d7iC8HGkX4?=
 =?us-ascii?Q?N9bRyQor+9ki10lTxakXV8eyi2D4SB/iAXVvQWn+UjxFu80qa0oBlBc64es/?=
 =?us-ascii?Q?z8a/zVic7oVzSTMC175IaJJfqcl3v/cX0+N7ajS1uPjLdwuZRqOe0nPfIg4A?=
 =?us-ascii?Q?MCPakuHdRzmt9BQlOba93Y5XyhFRzB/7+5c5rNZh4OTa/XDwrmSwa2lANrpS?=
 =?us-ascii?Q?V5vYTP1xuxHvMtxfGaUm/lyOpxVj9uOH1sa6rm8njD/aWH6golkRsHWxgDF2?=
 =?us-ascii?Q?VN+DArC5QW0zXTBdEsDcNCVymreXSd9zaSQt3A8D3EViSXGl5ODpk6O7BHrF?=
 =?us-ascii?Q?qAgsSGFoHdkAKVTq5+7hOmpYI6rwe8SEKJCHgwKe83h2aPyp/41iLDP68OVq?=
 =?us-ascii?Q?WG6B3H/WCU3FzRf8LsWQHOhHIpG1EmxZzwTfAMkWdbZswlnndS1F0qVj2E5h?=
 =?us-ascii?Q?WULLulwxwrdnI+RpNCCR9gbz0+kZG1UQLXqOmhtCxuDmanG+YUhNt7R60HD/?=
 =?us-ascii?Q?7AY4LzSbYNWIz26ggkt+FCGPaatBq16fvSItoj6SdUR/bMnpa0dZ2A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tMygl0ZSddL0HOjo5ttpRQaA0FudcuDyZ63FPYyP2xWftrU8KDTOG0D90ARW?=
 =?us-ascii?Q?d4ArIFX/xKh0gtE7j3Xd9Lc9Px5a/Nxtlg9+FuFBbqH6VHjX+lvucgiRu0P3?=
 =?us-ascii?Q?1lejudr06pda9DCWarpMeDi54E7Oorblcr6s6N5zcG/SdN5EOkrPONwiAuD+?=
 =?us-ascii?Q?DGlWLYNeUG3gr4uxdNJiTJmbZiLOxbYpP5NF3kyrNQGjwqOzGYdMANwOxoj6?=
 =?us-ascii?Q?T7KjM0sK3C6h2Ak1iqi+y7TuUSiyQgA+wmikDz+v3abMBdGZL/zKG85wnPzQ?=
 =?us-ascii?Q?tk8m9kA3vO+xwmm1zo3jsmtFZzspp1khuj0k2PosidbQWwQ1Dt3zStE7JdPo?=
 =?us-ascii?Q?iGUTHiaFxfUklXuEOubWB85ygpKhSsjikuRKmZJ/EY70syOx9XIde9McEKNh?=
 =?us-ascii?Q?TbjeaJmfOLmh1X1uV1lLnapEV9Wobq5/T0uy9sxV/6FpC5JcLFzb7Bm9QFdi?=
 =?us-ascii?Q?7Jhoc9UmGzBolqKw9K7Ug2WLJJFPpLuUX32VHDpO+p4xk4I+OdGIyaAiuveJ?=
 =?us-ascii?Q?5fKyeHet/8BJzmk1NTY00Wf2BinJmiw4gGUEY/HLJanzaql+s8nO2qMuv534?=
 =?us-ascii?Q?eRVttGUDJKkU6NF3xe9lz1N6EU8XCM5N96uqQ6Rnlhp+YXKn73Fj7iEdvTS7?=
 =?us-ascii?Q?P+RP+OELA05sRo+Ac5Pi0LjqP9ZVp/3NjvA9+zvebI5vlHEENfxvobKi95Jb?=
 =?us-ascii?Q?Gb1+/POQzzjWmhg2bIjssR5l7CSaUssgc1phC7APIQOABhmxf7bu5NqKhflm?=
 =?us-ascii?Q?fZ3meRC1gnG/592DiqLWxSQ6QSe+Xbd7F6z/3nLMUtTk8Dsk2bjfMQ6y56nv?=
 =?us-ascii?Q?8oY7ryvZRtj9pUprUX+N+AWDPjtCRQlFlcBJwbOPcjmuR9BfBlcC0mFdCWR0?=
 =?us-ascii?Q?CmjRcNWFKb2ohDPLAd5evQpb2D6hn+4Am/vSUOa7/TsblRQCpvInuXu6yLPq?=
 =?us-ascii?Q?ffSwaOo2qaF8kUH4vrZZfF4xiBtP9tbl3efw3+17A3MdaAeWVoPNgeQZvfkJ?=
 =?us-ascii?Q?96boldPySNOhqrGRWbR/qOGPFIlddFaqW2WRjnExpxNzcWp/9RS+liq/LtJh?=
 =?us-ascii?Q?DLgqwL2VOPo8HCAYGZNsQsu/zjVvaoVkl8B/DFE9h1T5yBGuq4z2OWYc4MEm?=
 =?us-ascii?Q?gBzGRA4gAdpZfn3bo4G6x4k1HP7ClXyTX7d9Ku1S1RLZRWdD3bp/0E49H4QQ?=
 =?us-ascii?Q?SEFGKspZS7zoiSb7AJ73pCC7qhmtgjAmOE83MFwno5lElzKjHRQSAWRGVyo3?=
 =?us-ascii?Q?PmzRgA2n6KZcF+e9Ib+VmvbX4biosrqjQAaksQFKTMYgW9W/o76Md+i+JEJz?=
 =?us-ascii?Q?naGIpqOtyzpDgp8g3CFh74QTzv/tl02Kd6HFsIGoV0AX0WPfFt77J4f5afVD?=
 =?us-ascii?Q?BTc4e99RPmij9Sp42G25kRAzyyRU4hPKaMQUgnAe9oXjUczHxX54RQUqF/1c?=
 =?us-ascii?Q?1EuZkAWLqljgolPdlBzOmakK0UrFDmbvBeVvk1jDAqNSGnetkxv8BNe+8cp6?=
 =?us-ascii?Q?M90W1HJerkXmZL0h6WdJmZ3VR1HA/eNZCELK0sdwOf3HePRtiI3zjGVC38Nc?=
 =?us-ascii?Q?zVhUmrrJ2BWvSxH1yEKyH1WHO4yCXkYpqPalEtXr+o13QwoAQgw32j0gxP//?=
 =?us-ascii?Q?FJfPNlb7hAyRyTl8xnoOqW0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883f1c19-278d-4486-c6af-08dde0038f53
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:45.3501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5knKUrOZexhyIz/84iQo+rrGRLhshv+Bt0s1s0b8zVX/IxOB3NCzHAiP4JrdZK00SHgAFcNcIOo59r+OAgAjPCskDosxI2Sq6otuec/pVuMDsYtGnLRKq6l9heYkNZEh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19875

From: Ricardo Ribalda <ribalda@chromium.org>

commit 820d81a167d422027ca4af7f0511e101f21aa214 upstream.

Factor out all the power off logic, except clk_disable_unprepare(), to a
new function __ov5645_set_power_off().

This allows ov5645_set_power_on() to excplicitly clean-out the clock
during the error-path.

The following smatch warning is fixed:
drivers/media/i2c/ov5645.c:690 ov5645_set_power_on() warn: 'ov5645->xclk' f=
rom clk_prepare_enable() not released on lines: 690.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 8e1ce1741cbe..7652136b0dda 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -635,7 +635,7 @@ static int ov5645_set_register_array(struct ov5645 *ov5=
645,
 	return 0;
 }
=20
-static int ov5645_set_power_off(struct device *dev)
+static void __ov5645_set_power_off(struct device *dev)
 {
 	struct v4l2_subdev *sd =3D dev_get_drvdata(dev);
 	struct ov5645 *ov5645 =3D to_ov5645(sd);
@@ -643,8 +643,16 @@ static int ov5645_set_power_off(struct device *dev)
 	ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
 	gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
 	gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
-	clk_disable_unprepare(ov5645->xclk);
 	regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
+}
+
+static int ov5645_set_power_off(struct device *dev)
+{
+	struct v4l2_subdev *sd =3D dev_get_drvdata(dev);
+	struct ov5645 *ov5645 =3D to_ov5645(sd);
+
+	__ov5645_set_power_off(dev);
+	clk_disable_unprepare(ov5645->xclk);
=20
 	return 0;
 }
@@ -686,7 +694,8 @@ static int ov5645_set_power_on(struct device *dev)
 	return 0;
=20
 exit:
-	ov5645_set_power_off(dev);
+	__ov5645_set_power_off(dev);
+	clk_disable_unprepare(ov5645->xclk);
 	return ret;
 }
=20
--=20
2.43.0



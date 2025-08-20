Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38275CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:44 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.23])
 by mx.groups.io with SMTP id smtpd.web11.1049.1755706178297486680
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VWfT7Ftr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.23, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPXqfL5mfCfkiOUsnFnjpCk8pHCKDdaeMj9LXIO8QfSNaSohPq+16SlUuPMxVwZ/l8lVwYDACq1z1nbP6Q57667tLascxpqg1ii1MOCirdyijkaXFi3aVA0FpqrOXSKDxHBhZ76udFzKD1eT+r7MeiPDX82S3flxJmwKMt45NRRm42Dw+r471Tnww2HtnZY6KuQ2USoTWQBzfFwYmwTDG3/io6dqdhDGDO8Z12rbqZSXEUq9BV4D+jnPXJ2UhQAmNgdb+mX20YH0X4YhTgB3xoXsVmTUG3zH3MubZAGEc+nEK5tDyZQMQEkkWepX94e0rcu2ych3wdkU82uZJNEEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmp8M9SdkGN0PvQW/Ou2cFw38IZJLyHdYH7SjALTb0Y=;
 b=Te2FB7ZGCf+ppQQFUCI9R/wD6ACXG1c/AGkzwuWLuAFpiPik/iSmjR4FfDXej4EwhLd6iuhSVof2008r8GRmPWt3xsw7scsaFw6p+V/dovI9cEiMcRMamxwymAWJNnEMy0v5b/MW10GshURJIC1SxMAkLHbyOsTYtN3USl1n+/kM+Qy96kTsEia8dbuzFbe2/fO5ZC4brHXavPX8HddlvccoJQYcw+Ozp8v4LVpoj4hmYiHkuAxCPGxLB3WcNr4w60cMUaoqEmOthW/GJaITDVUzz6ytar5RBlkEZxEYFMY8uKtzCVpr2CSaYvxcsFzI/irSCNPeb/KwNcxfBdpYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmp8M9SdkGN0PvQW/Ou2cFw38IZJLyHdYH7SjALTb0Y=;
 b=VWfT7Ftr9CCaZ7+quZ5OyGo0Wcp3AGoafsLN1dJgaL4maZPzrNj24z7FBNTvTNSeRnRR3s2vNUsD2sBrOlnCUEyjqv5MhgvqaZ5wOYF6ZlpgdHHK6ZUk/tZcoijUOcF2SBonj9nvvJswfTM7NcH+PKk4wxhdv6KeObXoT2fA8oQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:36 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 29/55] media: platform: rzg2l-cru: rzg2l-video: Fix the comment in rzg2l_cru_start_streaming_vq()
Date: Wed, 20 Aug 2025 18:07:30 +0200
Message-ID: <20250820160758.801813-30-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: be6ddc49-274a-4dda-4928-08dde003f52e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Dejn306NR/HLOfK79MK2+vGVNHsxVtulkqxXsmhJWPJpcupVKWjod2aA8TEj?=
 =?us-ascii?Q?y6jcyBgG+XJArGiWcyJYRuY3SEm9UjaxDhuEuNalXVArnZqrJuYW4fKRpnWE?=
 =?us-ascii?Q?7+8im7ojKALlmjmh5okPcDhK0vM/VL0dQgLn7CLmLr6dtKHguYU8g03iTial?=
 =?us-ascii?Q?mC4TC59jSsBU24i660pD8jO72hfWkaFYUaIuJER/CUN7H9UJ1J20lSTKmlKe?=
 =?us-ascii?Q?BLUwP2xNI/bmlcguj6bQPKup12kYEFCcjF1oo00952ueLwy0DcxiV/B20w6U?=
 =?us-ascii?Q?9VSTOKxTN5x8g9XxyHB0Sg5VoQ44gW27l/n4PyGtpzi7TnLTjdg4H/eCtoh1?=
 =?us-ascii?Q?c16KatWxFHeeIKHrT6JRyUnFpMhIbH51cqVlGh2DQn7qFHmF1e4FnFgxedqF?=
 =?us-ascii?Q?T1mDhXbyouyf6Myku4/sbHn/nIuSi2uxxQI24WisVjXPaAP8ixyee8izYIeK?=
 =?us-ascii?Q?QW7BwDDl3NbdoewE/IhNPL6SiWvqxFLu0ufGghe5nahD3ZQ0cN/m8SQXEdoA?=
 =?us-ascii?Q?rl6wKDUxP/9zk6iC73kKrwnrJObauo0wHykWZzI40EkdRUpnqxrQPj5SH/ZU?=
 =?us-ascii?Q?wxN3HUqlCg3n5S7z8FKhO5ctrW9yxze3WO2p3bWA+MDR8v0Br0AtZHZLhAX4?=
 =?us-ascii?Q?qZ0HnjVmsqfHyZr9B3yWCBlZUO/sFEo2ZrhimCwODIqC2lEWabyOtbs2IiYk?=
 =?us-ascii?Q?MCJ7phkJflt0gDpHsXtWXPxv118sPX8emv6vMJAIo2d6YKGDENOlUJsi1j4L?=
 =?us-ascii?Q?qWgn4QZfoGndUN5uLhZRa2pjHOFKziS0qHlDobs+yq3D/CUlaQbCzoKuT1vi?=
 =?us-ascii?Q?dpoVf6sApvVKdUPGUBavTXG7kVtuPqV2w2CpiLJ2F2s6iKJQfXAGmWpzxoED?=
 =?us-ascii?Q?GtD1yLBjpnjJ/W/IkwvDDf/Y8T5kJpIrUAxMnAcHAd/rH9K6XtQLj1CuPV1a?=
 =?us-ascii?Q?vj4e8ukXqIY3Sr0ZQCdiqKeqozFruUB5mzumxutiQ/1iaA9LyFnoc2WG5DB1?=
 =?us-ascii?Q?7kcGucvlCVeFTEFXhnkx11QkgCw4w29JDD83iApPaahWh6tof+RqM0AOpu8P?=
 =?us-ascii?Q?9NZo5lI41ib3OGJFDfmWzlBccTnfi2ircv2KB/sdVXVvaFweM/ny8+DLLq/y?=
 =?us-ascii?Q?i3EJuCViy5pZ3bAG9g7WkqcmQnXExuYMvAf/1KNc8ipar1MYZlxlbnWERsaB?=
 =?us-ascii?Q?bXfVQihrDzCbo96Zc75xYEPPqriTxXCp7XdvjTYJMccevJ8iAcTrDW9OU7Sg?=
 =?us-ascii?Q?2yVd6WVEfgcs/AcLvSVFoQ4r783C+Od4+sUGtnq8VoX6XkpA665W2Y4HgeZ+?=
 =?us-ascii?Q?88+KZkCVXUgQ+G4lpVtEh1Hjehsv3I4TAV0gm6S+7WNTrPWBsOYMgGnDj+qh?=
 =?us-ascii?Q?mdpPwig/+m81NJFHOdRFBVUvK9+KWQRcYPsam+ENo/RCIBwmF8SoJSKJWWL/?=
 =?us-ascii?Q?qxTbdtvHKS+lnvpD14g7yJM89880J0KKiRLTxtoYGMj6vo91JJZo80DAB/bU?=
 =?us-ascii?Q?7IsypvEF5LIvgw4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cm+b2UNvtcLxko5eUfDY5QscD+wa37HXTEJXXe8QihevdR/hwg8iGQ5Pxm8N?=
 =?us-ascii?Q?1AWkexovMVdBe/l+l0za7d6BYvuC4TAumud9Bx1grio5fJuyw9ngAMcGdE/Y?=
 =?us-ascii?Q?ytAc0K8ejweBkdqxCV/bcfb7JyI6AiZZta56G2VmSsTi1ng5SaAXG+mQc/l8?=
 =?us-ascii?Q?2eqZL+5PQYiYk1idXNuuCLXSMVt5U9swAk1+KBDalI/nn2/nuV0DHfmduzK7?=
 =?us-ascii?Q?rQbJRUg76Qk9xYcc8RYaoh+zWVRpqjUhCKs51ucZQooWSXr/KV+VBv7/++55?=
 =?us-ascii?Q?aETpxutWwZftvvWX4JH08bD2/Fi3y8QWrvTLc4GIKrIQq4E6vTQ4lMO3jxRI?=
 =?us-ascii?Q?MmPPwLlitNgqIU5F4zz3v4OYr154EekFTCTeaerHwygblLBBRJ12jwXzlEds?=
 =?us-ascii?Q?2WYWO/1IdXmCXVW2T+0oKOUCShUVqh5RuDubB4kfj5P3jSJFzBkh3wuMz5e2?=
 =?us-ascii?Q?tXHbALwUn3/XLmphx/FUsww7S2cRzslJC4I5GKz3qnhlZ7QbzmiAx76QT+UF?=
 =?us-ascii?Q?bDxUmnO7N4F1y+7xQw8RAlsK7ZVlvKHk81tL3P7bTH1Ucf0rYeJ/xA4DHC4T?=
 =?us-ascii?Q?pmA6i6lS0lPKD9Pbsbkg4+inEJ1RBmRY848W3Lo/OVYSTZfbEs5g23dDqPBR?=
 =?us-ascii?Q?owwngXb01OoSy2mReTINy0MVcLnFVmt+cyruPP9NiQ4ixbgR5fmlgpIEyxGO?=
 =?us-ascii?Q?ug21gFi60AD2LOXf6p0wTuoTUVJQtiwh2YIyHroZNdZLlE+QiPc292xh/0Hh?=
 =?us-ascii?Q?wazUusIouL1EuAqNwhCxJJ8Mm0+RnKTwkbyAm1ijm245ildkLjix8szIQdsp?=
 =?us-ascii?Q?34kVRMspba5CjoHJFV0ASIF4hK9vqydjhROoXow6sKX4Wkh8WBgd+LZ2vogz?=
 =?us-ascii?Q?aB3/yRgqDnlo5CnfsQ5lBNXmS/l07L5MyYYhjPElpXw23j7G1MrFLiw84xOs?=
 =?us-ascii?Q?qDpLnhLvZZiuBPNjxPc2BZiPFLqLngKcLkR1IHZ8aSnKIls75IGxgmx6jlqk?=
 =?us-ascii?Q?d6jauSLxZJfiY3pmFz0IFM2msjXzRBGUu67/tZ3PlqnFL8GFskWeoOWohk5r?=
 =?us-ascii?Q?kb5H0N8I+fZVvLxDkKcFOMn9ot3G8YEQeKcw5yMfHPL3MyVW5Nk0X04Jel3Y?=
 =?us-ascii?Q?4mtzfoFP2Mxqipyk4zizzBaImCCmUCjuSIPEJhjuRo6u8nVMu3xOgHrPlTWh?=
 =?us-ascii?Q?6s59EsALGhvovwiFQ/wG7TVJPXaPTrayMa0/Vrty8EcgiwqZiZ6BUQWhOYZa?=
 =?us-ascii?Q?Z/b0XApQeMl4nE24ZnixGTMhDBYbpAp3GbI2f0hIHKgO0JVRQJgA4OuUJxup?=
 =?us-ascii?Q?knxrRZFPioDakK2FuW5pZ5mx9CiDz1rqlP6YiBwVHqnlkgK/ldL9Zlay88NM?=
 =?us-ascii?Q?sTx6zAjYHHXDQyx8po6ky/8gLEzMBvYruROkKXSXjDFXZJo71xtXByQn1eXQ?=
 =?us-ascii?Q?BqXoeLzquRqo/wlPXSr83guwBJtw7wV6ckURmL6jeo4Mt3c0hU4GEAafG6OI?=
 =?us-ascii?Q?ci5cRke5Cgtkf8X93hA8pWhnj4nWK4NoU529ikX/+LjTGSeYhrAKX2Cv15nq?=
 =?us-ascii?Q?4aOegSwSDdECf3Gfhht++zlXOlfG5087d/AhtQ4SSchVwQeW31+/dqxy7auv?=
 =?us-ascii?Q?taK7vVMOUQ5Oyo+zDH0kxac=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6ddc49-274a-4dda-4928-08dde003f52e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:36.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e15i+RWboUhOL8mEM3KeW4pSDs68w0BRqcIFs2EkxqQct2LTRZdxBZxC4Hzs5gIegPO74+flWZ1xJRzIp5Dybv9ZyL/5+164Re7GpR5r9l2AIffFqV0fhAohDaaJx3x1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19910

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 94794b5ce4d90ab134b0b101a02fddf6e74c437d upstream.

Replace "buffer." -> "buffer", for consistency with rest of the
comment blocks in rzg2l_cru_start_streaming_vq().

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZtWNFuw70nkB37EK@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20240905112508.160560-1-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index e980afc32504..9f699f95cf8e 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -558,7 +558,7 @@ static int rzg2l_cru_start_streaming_vq(struct vb2_queu=
e *vq, unsigned int count
 		goto assert_aresetn;
 	}
=20
-	/* Allocate scratch buffer. */
+	/* Allocate scratch buffer */
 	cru->scratch =3D dma_alloc_coherent(cru->dev, cru->format.sizeimage,
 					  &cru->scratch_phys, GFP_KERNEL);
 	if (!cru->scratch) {
--=20
2.43.0



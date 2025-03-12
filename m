Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17DCC36003
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.26])
 by mx.groups.io with SMTP id smtpd.web11.34838.1741778765288757486
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=oid1zZKi;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGY6O44XjCI0I+IwimhoIlok5Beea6rDwfH6C4V5mc6+h7dvthTvw5PL3oIpdcp0WUo+6DcWHytHwB5vwEg8hq8g7bJvdwpZrkqAvCtqDsvs72NgeXNX59AlT1Ibvtip4muWUnPn/CYhrfBrlPsj6htzpU/7ms0KC/iqpAFCsKFeTgrs95112VnorknvZrA3HN6b8+6dYfxz23DMSUGr6lMpL1UI+wGCwRudxxyeKjX+hs/eEqjNbnkxrXgUp0Wlfcu0wMFP5WlDxh7WXYUZD4OAX7aC8vrcVK4qaSWLjILnUqKZWUrEgZhxPS3mkF8yCazAlZOxiNNv8ARLZYcdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRP5MLCSjNd8tGQSYsKAR5BrRXSPUAWZMb3ITIan0bA=;
 b=ZwEZOsHhLR0BNcUBk/gajkXEDqAdrVGPMxIONDatRbVBfNkWjs3wMkCN6fK0lYUQXgrTATqFNI+tCwzpRHY1c0z+W3kxL66jVkMUzv4ppbBT78UVxiz0SAMDhA5/ek1+/tMOGe4L9QhUf9hdNPq21Aw3fEo4doGkJVn6P08QY5v3+caoK2wMtUbaDPVJsXmuoG6XDVhGbcJb/ZWuY2TMnjoyR0RsVIJBxHb+j45ZLGOb933OVts9Hi7CJ4fcD6z5THJ2kyvOw08SdtS10Ggtd7xSFRuxyUnyjfOJXOqJxPVeVhcGDk0CHPGzfINzd/1LaLvNVVWIhq9G8EsVnMFk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRP5MLCSjNd8tGQSYsKAR5BrRXSPUAWZMb3ITIan0bA=;
 b=oid1zZKi8ZAwZ6F/vg5NRlzOHKkPhOjXzvWIvDpGTB2QXxJW80XUUwnzmCd09SsajmB778P14tJakTEQxNTqa+/nZuKUsbqRFuZ65+B/uLnnX+MiHs2KyZ2BpBCcvvuogCxyvyhLON4n4apsJA21+B2fWs150xojNfoeSBUvtjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:03 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 50/85] pinctrl: renesas: rzg2l: Use dev_err_probe()
Date: Wed, 12 Mar 2025 12:22:27 +0100
Message-ID: <20250312112302.1605750-51-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df0bbf4-5e5a-4c57-ee85-08dd6158ac41
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mCuW0mq8ZRK7i7BrWLVi/Ft+r3Tqvu8uOrfPDcVkAdEyz7Q7vQoTnwXMTHiu?=
 =?us-ascii?Q?0DNVzugi/yzUMTwhRObMRERiZVy2irF8sjJSm73H35WORGsYU6GKxhCCDnr4?=
 =?us-ascii?Q?8FazvjDTUfxetoU6AYL3tiNuByNkD7m+swmNOn/lN+f9pSR6nY0+n5A73ZAe?=
 =?us-ascii?Q?VngndYNHeOpX8/0iHR3p31pGMdxjY8eiATxPfu36M15ikT1K95WC0lftJeKQ?=
 =?us-ascii?Q?76FA3ClJWVupIqQ+9hd0zQ8zWjdaMou16J7F70jpVxP1z2aDZf8xo0QW2F/h?=
 =?us-ascii?Q?5g1a55ghgw2RjxKC6Aacb+8+7xQ8tq0mzG08/J5mydOMkjD36s+VTUuJHb09?=
 =?us-ascii?Q?HF9Uxv0YFakr9KpRakc1mUy1EWqEI8f77W/dkIXZfVsbToPnbz5o4scStLMz?=
 =?us-ascii?Q?olkZpTdOr/IhsnbEU4aLmoT7TuyUU/0/kTcl1jKJb1p8Y9AaKK++ewcGUb1J?=
 =?us-ascii?Q?bstE4fgzSoIMSSyV8Z7umGttGIfyPwHcTh4y7ZTHiuK0IwoKw8FRaern0SkY?=
 =?us-ascii?Q?0q4XygtSfVoMbiD6sa0e/ZmncWnK/KOfKQB1U7wwHhtndvs4BEswIf3Dmfka?=
 =?us-ascii?Q?Xn3GejOiw9EEi9B+kuyb6Qarkc4UUPC8xax1t+5Khu8OCQM/N1aY0VVDLKeF?=
 =?us-ascii?Q?wU7eqVlc7+rIgmBTeoCX8nFpRkrW0PlPOZZNwpA0JCQYbQiTsF3b5SHwO2WT?=
 =?us-ascii?Q?tP1tN++UNop+NpBzzX+tbYcrNW5Vr2QPFJmFYHXusc4p0F4z5CW+x+rbFoxT?=
 =?us-ascii?Q?QqEnmYaPVKQKee8xpwQ5C+jRQYUGnhLFVaDlk58tQKXiR/DQBInE/iGCnxYY?=
 =?us-ascii?Q?lqgHeO/NG+jLLv2NG4b1j0C/x9eZW+p9UbcsBGCfobGk9vbom+uDmrhTyIaq?=
 =?us-ascii?Q?hJYR6HOaky4VuuCpzoxx2LzjnI1+r4WetmivDQTjPHcANMP2hJa9AFC5VebP?=
 =?us-ascii?Q?z+j6neqdM9de8iyqUpe2g3plFUiTKLyjujgbEK/7Xex9f4uEFcRnZMUWIGUq?=
 =?us-ascii?Q?sZZmnsovLSiyk9NBcxGJ8jMGvYGlGiyLKt4qV3lN4TFbwFRSirdPXe4sXzcE?=
 =?us-ascii?Q?l7szd5bxEZPDFZkXfO9z7TEwmDI4M/3Boxra40aKH69RBsSTSVYaqWsae2Qi?=
 =?us-ascii?Q?BkbaIwQpp4Mh9JSqhG4TOpVn5aiCWJkFA5oQPYJuBWDMl+9xQGONqbSq462R?=
 =?us-ascii?Q?cfB9T6EKJ8ZYa98eo6qO1fagEnsHmeM6/Y4mYbOri4I20rj1RXepyoQdHmD4?=
 =?us-ascii?Q?0ltrZVS1+uxEYD7UboZQiBpqrKDt1N7torgABAZjc8lNzlh3vxjPa3tdpA2T?=
 =?us-ascii?Q?y0h4ceWOY72G5H8Wp5kLSmfUjxZNuW5/v375tPWk7YPaczUdzIRZxqIY4W0M?=
 =?us-ascii?Q?GsDyCda9aqMO6eq4zTulLd17XnKk8LHMkeSfmE3apqaRjxhh1Ar4zJl8LVje?=
 =?us-ascii?Q?U8DtxPNfe7Rnj4eN0fGm/3v5kLkb0U50?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JjhTKuekeOkN5ZOrcDQYNOPlHfkdvjxaq24S66cc4A8s3jYfSaYo/JeCLFs7?=
 =?us-ascii?Q?o/LzDCp4BuuSkSwFtzXHNLFZln9UrMYwBoqitpqgErwpgy3iI4R17mEbPtUb?=
 =?us-ascii?Q?SAhg7zFx3gkeZTT2x5REbcirhyNC2hxWNqnLVwNNc8+LIiaIzW7QHHq+deAJ?=
 =?us-ascii?Q?4V5bVc+RC1yrU40FD6fB3fkpuespfjRVllFqUKk1dbsQ+l1mkoxWSekl2cgW?=
 =?us-ascii?Q?yK5mhyiHBd2ztffxBunG0U0cgplHdJm2oWb5AW/lg4Bi7b/1f8iXbbQZuxsA?=
 =?us-ascii?Q?YqB5xo3qfxNY1xbPvlCxYZrnO+Oi+FBcAQn9GKsrKBS+YQrx8Zg0NIt+PhHI?=
 =?us-ascii?Q?GpXCnYTATaXHFp03MmeJdGYvgS2d/U+lyylsAUBLsDhGg5hSaaU6OZIgjt6u?=
 =?us-ascii?Q?MQTDWCzqunUUrO0a3vFxrUCEONZm6z6GfLXub0V82VQS9gCfJAjzKUixs/kY?=
 =?us-ascii?Q?B+ZFvXHfK+vizeZHjqCswF9DCoZixe27JiqOJMwO1AYpJ/6kMo6GeiKhdeSY?=
 =?us-ascii?Q?f4Lg5IS6wqnt7CdEpVSwbfS4N1/BU0CyJlcNe3WVIDcXyvu6zIEgNTUISSWc?=
 =?us-ascii?Q?bWfai/IJeuC+7UcJ3D9AcN6oKJ9GR/VcHLAYCUL/tPkk8c1d8GEcLAmAzJCT?=
 =?us-ascii?Q?rQ8g7cDWOiKt9IsrnJZGsDDrc5RhY1Aowy4dAcj0KKLLN1xCwNQHw/HVXMmu?=
 =?us-ascii?Q?m1KXTdJ5XlRhhmVTC2AJq9+cWh7hyA1vrOtdVAWeaGXza2icAJTMg8rKgPvM?=
 =?us-ascii?Q?PsxcfNPx23lSzDRkqn/YPlBcGoV4JCej4uW0kRxFdL6TvKNLf6fGK/6rA2Qj?=
 =?us-ascii?Q?qI/n842dPdqhwYOZ5qsOQE6/Zb3Td2YdeKJcmlUjugf4ruTT+zXv2zzAU6cH?=
 =?us-ascii?Q?cYAqbSSMGw/WKTRJq0jbizfS7NHVikg2wkjg2xFQMDm83xpEVyE2Ue5i4aHP?=
 =?us-ascii?Q?UW8UYD6GgHfVqwLm7vsVEEwFrOVbpQ+evflnZlYLCeRMJOmeECbWKfyhG4CN?=
 =?us-ascii?Q?r07Yh/gaLSO1nrLbSGnnjsEYsDN3rKFH1D8/oqN2KW0zOAZrNinO/xmlIB4P?=
 =?us-ascii?Q?t8aLf8xajaxE/lAhVV0XDKk9ju2PhOYV5EDxxX5AqlQ2tLNoEnX+aWAr14N0?=
 =?us-ascii?Q?05F6+LinPEhUAMLHfHR2DERjF7ftAjZQXRTLhvxWP69rnF3ksHROG/jzwX38?=
 =?us-ascii?Q?6uF009U02nFhM61NDKcLNWv7kRdf+2co4ZVZrdGGbvtFY3ZogSOaqbvGPgMU?=
 =?us-ascii?Q?v89tLnrGHZVTMCymMYdp8J6D2pSNwHWNcBHyr8rH4pCKLplziV4r9ISApxJd?=
 =?us-ascii?Q?ToQHp6q0BTrt5mSYZ99b4FCMsm4DRrxhDv/Ihd5LwOW17F4U+20sivmsiXGv?=
 =?us-ascii?Q?HPK5AgSFMenxlCeEvWL84vh/YgybVqHPcOvOBQoNNG8hRFOh7lF6+Jp4jQ8Z?=
 =?us-ascii?Q?FYTLVcJ51tewcsAs4z8fX3DdAhq1xOJ67q6/mFBmeaXFVTHtnnh1gr5d5aSP?=
 =?us-ascii?Q?nlYZS4+vvmSNyZwDs1/fDEmUE9mkEDX1TWdKHCvbIabY3q8UEvVuCYpAcGy+?=
 =?us-ascii?Q?/Q5Ep2VFMYYLSyCWtl1bd1eZPQq7tlszmI9HC/lhQddoYzBua7X8P2Z5z2VU?=
 =?us-ascii?Q?anMtEwixTvs4CX4kS32He3Y=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df0bbf4-5e5a-4c57-ee85-08dd6158ac41
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:03.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kslPnGOVcH7Ad8WmcpuRzDbXP8DHpnmiNrNjn49fhjdca7/eYeVoZfsxD5Y9hmgyeO2bgzuZzBm2NNZ+ycqcVfouLSN6shiZvGNUYQUWpGS5+DBGw4weE4GVNznqgG2o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18142

From: Biju Das <biju.das.jz@bp.renesas.com>

commit f73f63b24491fa43641daf3b6162d2a451bd8481 upstream.

Replace dev_err()->dev_err_probe() to simpilfy probe
helper functions.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240728090421.7136-1-biju.das.jz@bp.renesas.=
com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 37 +++++++++----------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 7168495da565..bc671807bad5 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2600,16 +2600,13 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl=
 *pctrl)
 		return -EPROBE_DEFER;
=20
 	ret =3D of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_arg=
s);
-	if (ret) {
-		dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(pctrl->dev, ret, "Unable to parse gpio-ranges\n");
=20
 	if (of_args.args[0] !=3D 0 || of_args.args[1] !=3D 0 ||
-	    of_args.args[2] !=3D pctrl->data->n_port_pins) {
-		dev_err(pctrl->dev, "gpio-ranges does not match selected SOC\n");
-		return -EINVAL;
-	}
+	    of_args.args[2] !=3D pctrl->data->n_port_pins)
+		return dev_err_probe(pctrl->dev, -EINVAL,
+				     "gpio-ranges does not match selected SOC\n");
=20
 	chip->names =3D pctrl->data->port_pins;
 	chip->request =3D rzg2l_gpio_request;
@@ -2641,10 +2638,8 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl =
*pctrl)
 	pctrl->gpio_range.name =3D chip->label;
 	pctrl->gpio_range.gc =3D chip;
 	ret =3D devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
-	if (ret) {
-		dev_err(pctrl->dev, "failed to add GPIO controller\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(pctrl->dev, ret, "failed to add GPIO controller\n")=
;
=20
 	dev_dbg(pctrl->dev, "Registered gpio controller\n");
=20
@@ -2730,22 +2725,16 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinc=
trl *pctrl)
=20
 	ret =3D devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctrl,
 					     &pctrl->pctl);
-	if (ret) {
-		dev_err(pctrl->dev, "pinctrl registration failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(pctrl->dev, ret, "pinctrl registration failed\n");
=20
 	ret =3D pinctrl_enable(pctrl->pctl);
-	if (ret) {
-		dev_err(pctrl->dev, "pinctrl enable failed\n");
-		return ret;
-	}
+	if (ret)
+		dev_err_probe(pctrl->dev, ret, "pinctrl enable failed\n");
=20
 	ret =3D rzg2l_gpio_register(pctrl);
-	if (ret) {
-		dev_err(pctrl->dev, "failed to add GPIO chip: %i\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(pctrl->dev, ret, "failed to add GPIO chip\n");
=20
 	return 0;
 }
--=20
2.43.0



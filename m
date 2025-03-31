Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F18FC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:01 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.8])
 by mx.groups.io with SMTP id smtpd.web10.49080.1743418017310566600
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aJNkFuWm;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.8, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgWQOCfF6kiBt4tXSpCrkzV7QTesVLS9Fzcr9TcDvXv8I+6VsFppt07JEw1XJVkflxGhZhC1GWB1ecR4W8DcFmALUi6wKbJcM1y02pZ8lfVqdLNu2hUvMM4Zu7W+l2823Z41LBG9WUgLw42qGQr1CpK8D4jtq6ttmiTKkSYFolZvg3Rao6CdvpZN8F81z/9FvzaeQgfPh1ZZrs+WhmLwh0OidVZls2TNqgAzVQM1+rz+uvGSLJ1L0p1VAABoz582iN1NzcMqSr5nsk0K52dLd0xpMAvcKeVpazzbKa+SvXfbJ77wlX4jEYTe0PpeclW/WAl163MKUpdxGPjDb6uGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxSMWt8kl69JggGtPNxvnnWe57xBRR+lQvRI2pyQ4bE=;
 b=CF7rdHO2m/r5vBSHPdpB9jegOx4TVvbHrwaBtLQ049pvlwTVpqozjEnb+fg6GA1CuweFzVyKkzobr8Jg3Nnqs6K23v5TLCBFVNOowNU82nPLk1QbdsYSV60SsEhag7gR5nBe0jGIucps+gxHMZlO4Q5MH/Cgn9wAQ51HPE21fKntJ4L0btnheaxWDBU0s0ukUilfhnJFhSfcalDqXgImv5iY7OvE1NBwN9phDrv1yIs0cLPEUYi/IWxnrimzwHAJD+g0pY10Qpaw1mDGTqveUJnczdSxJl0AMWcHk5s/+AKioYCGFAxbaARzbreEP863G9iG3TA+VBuZenG/P7QWDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxSMWt8kl69JggGtPNxvnnWe57xBRR+lQvRI2pyQ4bE=;
 b=aJNkFuWmT3gsgglrmePI/BD03VZILX4QkS+D5I+SjHeKTZO+kvylIIVbQcSm9iHvKPqmsPBG7+iDTozWcLgXWZCZNehGIyOodTa13atp9Nyv/t6JUtwy3w5a9tpHYXrRHuvNHJFRq8r8qrOlf/lNNwelKnp5/H/tWP564n2+jik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:46:55 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 28/43] pinctrl: renesas: rzg2l: Use dev_err_probe()
Date: Mon, 31 Mar 2025 12:44:59 +0200
Message-ID: <20250331104514.79090-29-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY7PR01MB13744:EE_
X-MS-Office365-Filtering-Correlation-Id: 5183caef-3e08-4a04-b8be-08dd70415a51
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?s80KYzqo9PQzX/V94Zo3RcihDvxBsyIam0R985jhKQTGYPhZXU2+qwtKV3hH?=
 =?us-ascii?Q?YdFNVvkUsirbuzX2/jUzrO93tOvaR0Xnwks1rhpdDxvpd7fhFrgreh9yT2hh?=
 =?us-ascii?Q?IgiSJcRLdvruouTvb8ZmyK6Q2FsDrZT3nN9WC/A9jT1fwtimI8hdQMcdTiUy?=
 =?us-ascii?Q?ROaDTTvley/IYIoFtXfLbH+YphnMJo0pJUoM/hNVzz5+zEQoU96SsukaL0zb?=
 =?us-ascii?Q?GybncU2BM+g/20CHu3x9wozCTn0AtePYx+jgyyctuhGeZ8gstZVKm8iVy6wt?=
 =?us-ascii?Q?tj2aJgtUSf5HuImqJvwZThKE5esf9aB2OGgEgrgeTErbK/A7gDQgS1lZRHwU?=
 =?us-ascii?Q?3XiQsp3mv45pfJq4KJHwp+a/SS/xPkJKp7L+TmJvbRmKXuHwsmX4REFm2Cft?=
 =?us-ascii?Q?B+dv6JntEKpxTMy9uii78AZyZHQKThcRh46bV1DMJC1oUbLEk/v+Dx9hULzy?=
 =?us-ascii?Q?TgJtmQIKsCB1hmBxjL9w8JtlMNRoh5gMXilOuGRGoY9OOJw3d96Q4Gzl7k8p?=
 =?us-ascii?Q?SFWhWYbTE7dR/SLC0JcYEi8IT8y8BTHc3xxfZTcZDW25pY1egjU94V9hjGXx?=
 =?us-ascii?Q?iaJySmDtxc2rG3kjOoIh+RnAO2bLUmtvCKfOuaRG6BKKLET4wMYDsVPhQndd?=
 =?us-ascii?Q?iUSvyaNJqwQ4c2ea/PV4WAPj10dAJiJZX1E0dM9L0kD42ftXzuDS2BpKfRIy?=
 =?us-ascii?Q?r68O92CEQQyefxGnn3xYn/AigrVN+KaB6y1T2zZXT8q94SmsAWX56dx1XBxq?=
 =?us-ascii?Q?e1kAHree1MZ7z75XXOD+vvhuv/jVM0Z8y9JZxqBBlX1HrWRhbWJ8zvzKnH1o?=
 =?us-ascii?Q?PN64btdayRxIebQZsICatzaTkYlijiZ/GqGVgrdudfx66VELmRGkJER0tWG4?=
 =?us-ascii?Q?b9vKSsEv+xJNoBvq64lYnTJB5Xvhjc1hQPs7GDzw8ZgNydh1588WUwWeLpdL?=
 =?us-ascii?Q?lQA5wiJbFhvsXaePAFJvtp/e2NKBqUQ1NpKfGPAgbcQ/QObb+QIvFXX/WbXE?=
 =?us-ascii?Q?gBSbXPty1w/EpWHStEkFtgMwfevx+S7H6cZyhAtolSExIBzRRmQp82t/+jKO?=
 =?us-ascii?Q?KShlCju5HWjetGa4j0MSi2nYs95Gq0HOslIvqTztK2+VecCV+ywRt/15F3RH?=
 =?us-ascii?Q?myoVl01Xc3FmZoIH4ZZF/qEOFL+jTVGIDacKz3/fwYlcccV0BMZJyvfHq32A?=
 =?us-ascii?Q?lBJuKNrLEb7i4vlm9jCu0FzF5BLpZlqb8q9w1m8/gFBiF4K1v7DutUBY/dWq?=
 =?us-ascii?Q?lAt7OVbCTejnDJkdiImYhMXaNg5dd1zWbGpPFB02QOMUs94cgj+EXRWwS9gk?=
 =?us-ascii?Q?IB3YvNutcKDdoQvJ8lUH2RiLTHySvYy8YQ1k2TqFty18/BoDe8/Pit4VECR0?=
 =?us-ascii?Q?JStQVc0ovWXueV+G+tyR5QZXN90hVw6ycorP4fU4dIhhVcBV89rmWKowg0C2?=
 =?us-ascii?Q?jx+d2jqAT0kL8tN+YF3IxFL6+hpX27GY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vv4wuv5f52g5jf8pvxGmdKBSvZ5Rhf1WYYvxzmcDZ8F9TlBf0OeUeh17rPRb?=
 =?us-ascii?Q?quJvwFNpK+5J14ZMHBLm4mdBR6PHgPYhgOgotwof50A4Hy0um8CHiTyYiZ5D?=
 =?us-ascii?Q?QqkTp5SKOjhA2E3WrvhXmBysTPMheYNphVZDdSTUddXJxuvcROOts9HARZZX?=
 =?us-ascii?Q?ZLabrrU84Wkl3WDk9wyrMiW5Bp04FomfWEdljt3OTfHTjFWcLq6iBJZ8HCP+?=
 =?us-ascii?Q?zm0Q1c6sogF8WJdRbn/B66kgxdAVlMskVQzj40fbFE7kpFOuH/hMqayH5NIh?=
 =?us-ascii?Q?8qinUlpOwaA/QSRab7e9P3ytk1V8Cqma3RVmMds+jnDiaM19IjRLmOPXJIWA?=
 =?us-ascii?Q?QYPqt7R70Y9X1cKhwm70RN3wrQm/aC0+Utc7wLLjRY0KUaHpPx83MgbiaEyD?=
 =?us-ascii?Q?cMfPwqz3wcIh2i0t9CYH2o1LgyHZwl4vKG1a/xmsdLiarZGluUBFO/nPM54f?=
 =?us-ascii?Q?RV/OWSntsnYYo0btVOpzIQzfGPrAUPckxZkxQTnMzYLtOBfV08nZ0kUzDEHz?=
 =?us-ascii?Q?rp6uBEU264HwIC5IVFyTkdkDbqfjJm1w//iPTNl97HKbp3GHrhJLWolro64K?=
 =?us-ascii?Q?yqW4CF1+/RImmPFG4uIYtZkPMNFSuxYI64s5n2EzzQWR7CFFSGK03UzC7Fwk?=
 =?us-ascii?Q?vFuEZapb3Hko0h/FGiCEJQr0PVa4FEPBdsWw1NpBudLXq9uRSLrZ++U3QczJ?=
 =?us-ascii?Q?tgX7MPMdo2RkO1O+Ncl535UMsbT5cZUaGmCiwffa9J3lkYd9Ih75UAFl7y+U?=
 =?us-ascii?Q?xr4X/n1d9fCOlYKW6xzi6coLs2HKED1zuf8B/XScvGyP1/nTsezDjQyZsM7V?=
 =?us-ascii?Q?i5cY0fIHI4plE+SZDDSda7ceWCILB30RscL8nrjclzMzQT+P01i31ym09izX?=
 =?us-ascii?Q?q8xX1ZG1/iZHD7f0RthZA0lIiAB9T3XyP8SIMYcLATo9ik+uMMteabh3FyPj?=
 =?us-ascii?Q?xLHmJhFKvqo6HRBjEB2gvrM72hEh7wGG2xDTdrWTOh62WdD4jgrC/gqJM5OA?=
 =?us-ascii?Q?yH2zoc0Rzr8E98CPGVyk0Tl5IaUrJLltqC/2EMR4vWjeSqG/5ZTrUF290W05?=
 =?us-ascii?Q?ZaAJiZ3Ub9W5LcirAljIpBHKko+mnCCCFoaQ6LeekG7uB6od3yml1Qy4Ll69?=
 =?us-ascii?Q?eupGcHd9ayvZTqarAdy1zkwHopMZ8a5bEM66OP2LoZklYAAIoJ8dp4nEROqV?=
 =?us-ascii?Q?VdRLkJYhADo4voCHPvxxmTXJ5aEGJjY5QbXRnS+qsKp/wrb8t4N9geUmE2Tf?=
 =?us-ascii?Q?MmoWLlKIGb4dZT9MZSOeFcK6qxJqrqJF0zcyTjGPZnViLLTJnOq6tySo37P7?=
 =?us-ascii?Q?25lQZ79ZvL+VOyYyzRMzCQFGNPfDZgMma2EzjA+LnCUP4Acf/xHpKwbMLOUN?=
 =?us-ascii?Q?l99WQU18bh03ldJWvVZMPiK8J4v28/1Bufobk3zcXKBCz4F9POfvZZ2WOBki?=
 =?us-ascii?Q?+lRVfMRvXefirYcdxQObKJ2Kgk9RJxZ+yW3MM7GavcUU1zGJSrAfoU4fZGlL?=
 =?us-ascii?Q?ftmDis0ouuUtM59+6WXARW8YQ7Y4J1YUumknNF4bEgv64+SVwwO+TFV5F2gW?=
 =?us-ascii?Q?02ro2fblUmbASNSONZRCUfh7oLu8UQvKYXEzcu8sG259jTWcqHJeudICOCXx?=
 =?us-ascii?Q?r2GbnJCPBCWxbap3+7p4ybQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5183caef-3e08-4a04-b8be-08dd70415a51
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:55.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7JR6XBlPM/2oWiyjsPU9UPkpST2wdjvY09xS6Udc29eKAhj/RXSWm6fxeSY0SaEK4eSWz8OBEZCeWE9LZbZv3hlPHdbB5ZUKmVGxne3a3cbstJSw6LhSu/9uB/oPXm1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18416

From: Biju Das <biju.das.jz@bp.renesas.com>

commit f73f63b24491fa43641daf3b6162d2a451bd8481 upstream.

Replace dev_err()->dev_err_probe() to simpilfy probe
helper functions.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240728090421.7136-1-biju.das.jz@bp.renesas.=
com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 37 +++++++++----------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 7168495da5659..bc671807bad54 100644
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



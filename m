Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2746FC3600A
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:16 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.0])
 by mx.groups.io with SMTP id smtpd.web10.34481.1741778779970814426
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UA8BBlVA;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.0, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzGEz1G/Ije0LqGMTfKEhjNeLLOScjgdSKiYbt2vEBkxDCMy08QlPeDcYjDFktnVm7S9FDMhtKVbuFXp46+iSVIKUe2Hazf0K2hE8IUNz3Z7JwsJvTrgWIDvi2Pq2UwQb4hzi6XOfhU2n8pEQjR9S6ZEEZNZTfPqfiEL2Y1YujnzS3Jo1PDBx7ZDFgPQa2g6LHkUqnwk/YCsu0LO/IJRAstAt0MIjwRklEIfoqHOMdfeNApofEt3tBaia5+S1gu7x+afqy7mQIU8N1cfN3G7DWP0vGQh6mg6su+RO4EmHF5pR/LfT2frsdbY2aGfiZC1oToQWdcueMydhzaEOC4fqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvh3jTlVRlvHD+9WZVH71Ex4opMAp0QEob7sJalMlJE=;
 b=Ev45StkHL/LeM7OI/dYsg865f8nPEIJYtY8gREWy2UVvzgQtfbE7EiSTsW9mYlpi89dIHJdKOe42JYzTOPH81Q974/9K+4HRO49JFsjsOieauGC7uvCPhMHKSK8IhEdepsYScjQ3Rn2y7CixVi0ZbZYwe7Qhzcos8hcW0p0qjcmSL/NJaLFYSpu7Y2zrX8q/9XcUchhgA+hUmj8hjaQfI/Vk1FMXOsku1RTgsGpd7WAF2EXl5eewXVwKLg3itY0n6o5iXc4crSPxKOhLxHp6xqCZHodRpdZ6YtATqUksi5ZpaO/9/Gmoau8XNcth6Nsp+n6KHIc9STVgggUMnxgvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvh3jTlVRlvHD+9WZVH71Ex4opMAp0QEob7sJalMlJE=;
 b=UA8BBlVAcabODXUUmFUIFD6/eD2j5AIM4GAxXTNOOVZkOSSVXFSGC9bI2bKILOOG1VMJVDHiImE3OMDJkWqfx8EnuW+83G8FcgGef0fWxpT6p2pBazbGYQlz8Dbiz8HfLMWMYAwyhSkF+VpuZe4gZoS9fTVP3xxpy2q9OrdEUns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:18 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 55/85] pinctrl: renesas: rzg2l: Move pinconf_to_config_argument() call outside of switch cases
Date: Wed, 12 Mar 2025 12:22:32 +0100
Message-ID: <20250312112302.1605750-56-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c18f8fa-ee25-4dc2-c4b7-08dd6158b4f7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zlPERaUvxubVxcl8gNMR3ffokNlyMssDx27VGuvwPQ17HjYD1IDjZtT75Lj/?=
 =?us-ascii?Q?gBsEinoKTrhBzo6IbeGgNO+LimrKlldqDx6RPEDfyoP+58s8wnBNMq9khh6n?=
 =?us-ascii?Q?g6qsC4e6AdUkvAUMqysPCEc/VmVj0KijdF/5G0jOiSneBH3uUW5DIg3Jnv1w?=
 =?us-ascii?Q?NBKJNyayNYm3HdVyRU+fg928f5F8Tff4qlbfCql0Iz6u9SAohFLd1/qvaR9f?=
 =?us-ascii?Q?ton9TxxnRKQ1gwhZGx8arH0lSBnaeuBPj9OMUYuqgsgvaC2ZqiIgOSCgU8p+?=
 =?us-ascii?Q?aBkL2HMcdNtEuJ1KFU9bqfhrtZ9GRTO7vOlj1sUhE/IVq6bdXLrrU43l1dBz?=
 =?us-ascii?Q?8tQyioYppWyQ2Gf1tVYdX34l4pH+8JnpnvH/kT188hjMQ74OtjpyedKXhaGo?=
 =?us-ascii?Q?9tqeby7zOzc4QETEaTQc/eK6vGr1vALUJkJwQLzJF7ePIP5tAKOjw8AW4Abx?=
 =?us-ascii?Q?F1d+8h7eSAATh3Yp4JNbcOFBs7afADh4XCmQH1zgxJNEhhVQJCOVu7l3gr4t?=
 =?us-ascii?Q?uqedpeji3W398WfHmrhaTlNN+Fv9XajUwkmSO5EIzu//DzjrVXEC70tZi1Fh?=
 =?us-ascii?Q?RnhGPoFQoEkoQjEH5HbNcu8f8KaHPl+n5TZVa5tRTMpfBUJj6n4zExPR/Rjx?=
 =?us-ascii?Q?3rtDLYVk6CHdDmHt2J46Z5iZF3BcfHHMXssfkgy3yqLjtbOT1iaW9rgXgnQV?=
 =?us-ascii?Q?5OF0VjE7soX/2IyLXIK4IPPbtI/Xq8LMlr3VpuT1uJMnTer9zpsO2+/zrvdG?=
 =?us-ascii?Q?fmog0vXnlLFlKtcL8lvthQChRlIcJI68/pgIxQmAHoUybPKV0VUGbDu8FuQl?=
 =?us-ascii?Q?9N6+rJHy6j/wIyrsxKU1aUOl/ZYN6jmqtJ7Lcu+qjPqEgPdJxzuGu61FtocD?=
 =?us-ascii?Q?wLPc5eznmeHPcdgqJehHmiLNEUeTx5nZ3rNDQ6H9OaGF9diC3uctkaIbXIvu?=
 =?us-ascii?Q?eACrxMb4zXpngc7tfwnM/cBsO1qzES+1lfvVYOkqDw4YmfPwNAmJl+iQLn+Q?=
 =?us-ascii?Q?Jv24kR1ITHVvOWr3xHGXlu296fOPcRo5Qdmqp9pRm9eT04hsJ9yCgTR1ECSs?=
 =?us-ascii?Q?2ROZP/VDKAub25IidYgkhxVY5W2WdI0HPEyiqFP6jTu2XsOj5gZqAY4JrlnB?=
 =?us-ascii?Q?qM8Oavdgf+uXdFLMOj7ZGhhfOp+oUKCZQ03migUXdxLyH0JLtaN4x1GcsqdI?=
 =?us-ascii?Q?vMzB0Ucp0VzHixBAbfKZcaV0VAgVgeP4p3EWSe4GaMCb7NtCgpm9TZRttcVS?=
 =?us-ascii?Q?kiBA46IeZ/yzsMeU1SynbJm8JnrrIU/tRf8x/UQygk0dxhO6IMg+d29iAlIL?=
 =?us-ascii?Q?ST6ZvaEsYA3QylaTCpkNncfBz3k9vl71JFJyldSt4k73BPYKC658zkI/bYm/?=
 =?us-ascii?Q?SnvbIItPdYFNg5aS4sfqliQqv6H4hEX0bET0lqBcTZ1VqhLscKLL6QEf9LUJ?=
 =?us-ascii?Q?fMicOGpejoZmWiFTS321FB64wM4OBGOj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Xoh31kl3Gji5cnEFsBP41o0bNdfgNmol3XsgM2Xxl4Ku3xqHJ00wxkEynq6k?=
 =?us-ascii?Q?cM3jZYAGgzPrX+GSBPjKp2gEewhME+GaJgAh2LVc0voJgX26wc3LU1MzmAFl?=
 =?us-ascii?Q?400rYAXmWrULfF+2K8U6r3pjduZwVKeF+YQeHlWDNnCC4tyzxSfeXWEYlhvv?=
 =?us-ascii?Q?kr8RaUIvnV7Yelgco9vc7Pr0OKHr2dGRxGxJAdJmbiQE5Hi6b58pz/9ZHEVK?=
 =?us-ascii?Q?sPmtInS/gS/9/3F8srVKroGj1FLHa6XrHUcxpzj7ihk2calJZYdxYGcwjvwY?=
 =?us-ascii?Q?d54PTkKVmumxksEKGBo/SdA6BcGEW34w8ANTu2Id38qUmZucfUEfvJHCqHkA?=
 =?us-ascii?Q?Gj1iVLEJNbcRpeE5ju/EPh+ZMZFAblBEvMVS2czyGdMxCMjLJC0b+vqW214I?=
 =?us-ascii?Q?fc5oMk3klNfdafHa2T3XLwgaYRkuLFet3f+eZHoTe/2WeUhFyfF+FHjTfQL6?=
 =?us-ascii?Q?Tb1fZv5cnwFyEz+tKSflMNnLEYMI2lOpzI7GilJeSViZ6lw8qU2NYSfu2ep6?=
 =?us-ascii?Q?KyB7XcpC3c+TJl4Z4ptoJDii30/Q+6SmWEhf+7dbjfqkwYMs/uvhLP+XIuUc?=
 =?us-ascii?Q?5TPGg1Nm15T9FF18Abc7YwYmvFJkYvMRBKI0mq29VXEDGlMt286VM+xbLA2S?=
 =?us-ascii?Q?XGsyclLjUiDw8xJh8w40sxvy3bgMzkUy7Np6je5XeGd2A6zMJD0H76VCLHMI?=
 =?us-ascii?Q?Z05Rc151ZymwHpVT2jkViw5wPw7+ICbFzvM5YSd6YaUq6FdkNCADGWT7njDb?=
 =?us-ascii?Q?EsmpkA7Acn4RT7d+tdIUb6oJB+FfqFJ9v+jk9JMtEO/R74/U7UBaNhrGxpbF?=
 =?us-ascii?Q?pW0oLBjVIvXIxyi5kj1U4sousGdElN2KKnvOISPszhDHS7OqaPjzye7/NG6O?=
 =?us-ascii?Q?De4kEU4+cxUNJbB6U43kKdiBkrhvPty26a7Z0gVL/8KDClhbOZK1cs5TBOLi?=
 =?us-ascii?Q?Nc3+aAo4plnggsnByTpNWIwFOcEtmA5aSGP9T990oVs2xoobm6kYwyyzBpuh?=
 =?us-ascii?Q?Sx9qbFDYak7AGCmFYHZ30gITsU0JTWxBQw00FhtJu93Qj44AO/rcXTb5XHZ2?=
 =?us-ascii?Q?gx/8DvOSVHcR8SBE6xTpc6Il0Kq9KBWdws1bbbNS6zKLH9mLDHzelSWBuJEE?=
 =?us-ascii?Q?okAfb0wiY5ZoRuqi9+CKXucGtiyDw1bbbS/+UnEFT9bLZEW34/GqJWz1ICZE?=
 =?us-ascii?Q?F/CCzFB1dHP8slLA6y0kangmLyLBfft4RMGbLNX/fW/pS2IngPLdYxkULml6?=
 =?us-ascii?Q?KuBxB36jl3duBhdHZ9nnMpgBttJYsD/etdnxwRyQYiUXRdPhMolW+htlxDBH?=
 =?us-ascii?Q?Nfdq+j3W1ohxLBYYqdPadVsgxFujtNC7LSWrQb+SUdks3K62iMFDfgVL6g+r?=
 =?us-ascii?Q?rkrh3tfvWFlA70f3tf2uBxUb3MXgbpkV88jDHqKetwFaNsGC5ww/llpi/Px9?=
 =?us-ascii?Q?K4urQVqbVWfdFRvZXKYUzMJ6eDhlgYz6PPFRnLvndEfB4yvzqhyoTLnd5+5O?=
 =?us-ascii?Q?M9MxtoazZkgNVGgFhucTmiEDfpfeV8WWT+mpaXrHHViw5/qHbj5of1c6nNb5?=
 =?us-ascii?Q?9FX1VxF2wMMv8kteGi4AZrdUj488BGBU4HNo5fOlcSz3oqRR39M9ccsFwlWK?=
 =?us-ascii?Q?sqwYUY2XtsYzGhQKqq/sdZ8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c18f8fa-ee25-4dc2-c4b7-08dd6158b4f7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:18.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYMF1U6EQ1jMMJTiCltGzEt33//HoxGMJIn5ipXU+j0lcMT5jJ7YAYghIKSJjGWeabCY98g2kwnTbo2Wa8SSAaG+rhMWnBbFsYtpP3Lvvr+3aOv33nI2l6RzaYUkAJV/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18147

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 1325820dd085809645bdd89a2fd408a05b4a5492 upstream.

Refactor the `rzg2l_pinctrl_pinconf_set()` function by moving the call to
`arg =3D pinconf_to_config_argument(_configs[i])` to the beginning of the
loop. Previously, this call was redundantly made in most cases within the
switch statement.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240829194841.84398-3-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index d5249955c9a4..5919a9c441be 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1385,9 +1385,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
=20
 	for (i =3D 0; i < num_configs; i++) {
 		param =3D pinconf_to_config_param(_configs[i]);
+		arg =3D pinconf_to_config_argument(_configs[i]);
 		switch (param) {
 		case PIN_CONFIG_INPUT_ENABLE:
-			arg =3D pinconf_to_config_argument(_configs[i]);
=20
 			if (!(cfg & PIN_CFG_IEN))
 				return -EINVAL;
@@ -1396,7 +1396,6 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 			break;
=20
 		case PIN_CONFIG_OUTPUT_ENABLE:
-			arg =3D pinconf_to_config_argument(_configs[i]);
 			if (!(cfg & PIN_CFG_OEN))
 				return -EINVAL;
 			if (!pctrl->data->oen_write)
@@ -1407,12 +1406,10 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl=
_dev *pctldev,
 			break;
=20
 		case PIN_CONFIG_POWER_SOURCE:
-			settings.power_source =3D pinconf_to_config_argument(_configs[i]);
+			settings.power_source =3D arg;
 			break;
=20
 		case PIN_CONFIG_SLEW_RATE:
-			arg =3D pinconf_to_config_argument(_configs[i]);
-
 			if (!(cfg & PIN_CFG_SR) || arg > 1)
 				return -EINVAL;
=20
@@ -1433,8 +1430,6 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 			break;
=20
 		case PIN_CONFIG_DRIVE_STRENGTH:
-			arg =3D pinconf_to_config_argument(_configs[i]);
-
 			if (!(cfg & PIN_CFG_IOLH_A) || hwcfg->drive_strength_ua)
 				return -EINVAL;
=20
@@ -1454,12 +1449,10 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl=
_dev *pctldev,
 			    !hwcfg->drive_strength_ua)
 				return -EINVAL;
=20
-			settings.drive_strength_ua =3D pinconf_to_config_argument(_configs[i]);
+			settings.drive_strength_ua =3D arg;
 			break;
=20
 		case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
-			arg =3D pinconf_to_config_argument(_configs[i]);
-
 			if (!(cfg & PIN_CFG_IOLH_B) || !hwcfg->iolh_groupb_oi[0])
 				return -EINVAL;
=20
@@ -1477,7 +1470,6 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 			if (!(cfg & PIN_CFG_IOLH_RZV2H))
 				return -EINVAL;
=20
-			arg =3D pinconf_to_config_argument(_configs[i]);
 			if (arg > 3)
 				return -EINVAL;
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, arg);
--=20
2.43.0



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87234C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:31 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.13])
 by mx.groups.io with SMTP id smtpd.web10.49098.1743418048927644782
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=De+kGcrf;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.13, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVNGD/9puWl9skgxLteamEZ3wMqxVh/jaeHnHcjjBotOh7CUJVY6LN+yz1V+c6eWVNtnkGhw+IvApAQS04rYH14V394VhfdY6vbkFNgOGX3056MsSiZ4qVjuyQ7pBKteeZdciGkFPbiHHRy32D8lrzHjknLHZcS0NAI4bl/w5A4NObKjdaoagFRaoC7VWGl4rjdvqRftPF8mm6B63VwJ2hezTVMlO+LU2QTnJK6a2Lu6qBSG3r9OFVq3epTkyHSq3hUPSsAJm+86dLlLodcBpNmvurA4ibQJ5rGXJ0xfympPNHFc5jyYGcUyol0Zellrqy9TpeLj26MKdPfzwq7Xpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcuB5z5Nvph5bTro2t0FWX/aIexMnjOOUcaIhyiWQeo=;
 b=qAdNkDlhob01D5mnqoxsyeDMAjU3JO3xFH9BbD03JqtGdQ2EvAx/sDGQakSx6I8Q5RGdpx9hf/+kXE+0/r5OO3c6zJA9debV06lYOy1xMbkaW4HX5aN7ZrsTWyH/9tBv/hbp1PFfV9LgiVtdXCNJvjRVvPBvoDdHNApTkhZ2tUp9xBdfucWs3WStqG3gwquuTEORO0Xhul9t0qRmph8kHrVieEtiDLzo3GmHpdUnfm9xBo7QCOiAdCDlkuAleN6LLKHtPqlkoqRI5dG5FRSddUYC+GEnJqxVq/Q/XcwjVdPWOJ9mdqSF8Pq7JQVjYubeF9pGOAZ+nC5pWY44DA4NtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcuB5z5Nvph5bTro2t0FWX/aIexMnjOOUcaIhyiWQeo=;
 b=De+kGcrfRULAqH7+EAXALmPo/Lvmsht0det6qgePdWExtRfTDav5MUnVOtYv8+uJXBDeq4dq5ic0PyPyA9mSUWXQcNThyk1fnls6rH+XxhRL4XSkKsv4s77rrxWD6z3Uh4pZneMpV9Ffg1EOkAX2DRXd26FxZzwH3g4/ymOPcI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:25 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 38/43] pinctrl: renesas: rzg2l: Use gpiochip_populate_parent_fwspec_twocell helper
Date: Mon, 31 Mar 2025 12:45:09 +0200
Message-ID: <20250331104514.79090-39-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 039ae4f0-f7cb-4cfb-eece-08dd70416c8f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HOAvsMmGcc496ux5zWVYXx5Gwh4OeOBSdqj6mGlSqSmEn5o2s2KbsW4+R5Eh?=
 =?us-ascii?Q?wd3ef9QBpkqIhNHk5of8qUxQtNtA5uSRJZ7f6yUwEvw2lLN6Xgc4tXGXdnE9?=
 =?us-ascii?Q?5S0/uCiLqaKNLpPSdF2I5cOXkk/y+k+45Tv0QOSrjiWkPTXCR7yR91seR8J6?=
 =?us-ascii?Q?QrhpQcBklRiVlhOzxpWZXRgE1t2nuOPp40a9/7vANyo8PKN5NGABYRqLi8Me?=
 =?us-ascii?Q?nF9zNtVO2gt/DmY8rxUNYgi/t0ApqjL9aLTgmDQ4qd6z3nqXY869HMBCWF6h?=
 =?us-ascii?Q?3JSR8ZJkcdWjC/mzNhiOOtFrtPZW+KDwTUnG9WJwakEy7I6320+4fCXiNu+b?=
 =?us-ascii?Q?XJP2/2P1jwNth3p70JaRMA6kkA/dUzphZ2YAirDPP3ZHlqFKXd5iHJKamdiM?=
 =?us-ascii?Q?cHUC6BxfEM23oEvlnI0uryYC3AaeCm9YQ2gpLHelUSndWKdqT1JH/MSModj3?=
 =?us-ascii?Q?TREqxUVlDBnyPyH8U8j+7kxqaYSJrPhAIJXKw5M6MGdnvigInseIXhOam0Ah?=
 =?us-ascii?Q?unlszgWO9VeJsQGu7YJprDRehKcJEFzAsH6BpukrFIUvH8oSBC2vB0h9xOOv?=
 =?us-ascii?Q?hUyoiUoqjjFnXdl8KJNfNWmNiX1/g1ZEZs6QCPCc/zuITZxhArZoeqHG5qqo?=
 =?us-ascii?Q?BRSFvqXxsSV+PYZ5KGO2oyiXwvzbupvaMB5J4lwq780FO71smAoYeLXbm6eE?=
 =?us-ascii?Q?eV0CZQYGarcyyo2NUjEDDdMJlPwFMzVjySdd1yj5WWzLnDNcYixazOdJQN3n?=
 =?us-ascii?Q?e5GpISHm+UH031i2dxuMhHLSCILK9bNgPcHzgt33lvjShYv1PVx5LGxG9duM?=
 =?us-ascii?Q?jiL7Y2FvWWiwdgZVCgvRE/w/zzExt83SbPZQ6fF0nWG7angiK26nxpTS0C+J?=
 =?us-ascii?Q?LfrmGNNb3CO7h2ei0FgnI3tD81bYpirZZ7ZcUjrAM0ixV+M6q/T85/y+2SZh?=
 =?us-ascii?Q?PUeJTnFWdiucbnGb/2O2B8chcIRHXjE+8IuZHGb52d7yzkWHTk45iQmCO85e?=
 =?us-ascii?Q?ZpOtyWXm+HYgjpI29ILHSbOK2Fl+DmuqQWIuIDIYn3QQCsugoeVvVPCMa8Kl?=
 =?us-ascii?Q?4ujh5ZGA+BivvMowYUkj8WzuyLOfEUZY2bnEhKrAllCok9a5/6vFN2DUHnUl?=
 =?us-ascii?Q?jKglTuEn3RZHrJ6fptfECvIvOPQv2dNIcZfVHVzFufLWtjFGI7Mr+KmZJvN/?=
 =?us-ascii?Q?iiP8jzO5/hhuMWNW6uGoYaG5IpoUC9D4WNTA8xCX4WHPvNQXQ8n2/ySiaHBX?=
 =?us-ascii?Q?zDEaAa7PJggaepO24M7TYRgiI3UydE33qmD7mZZmojv11iDpBXISm0hUXana?=
 =?us-ascii?Q?QBS3V2mGfak42wX2SeI/zQlufAfwwOzikmc1daQonYIrLkZFLCeaXESpNZmi?=
 =?us-ascii?Q?p1leSA6qcT+E1tokMtbbOkUMzfscneD+evJ7FjNzE38BcoDkCUyPsng3aIII?=
 =?us-ascii?Q?uC00AOCX6woD3UhgOVX9fUQS7KzFwTmU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p2EZp1T28NCW8vg3AL2qCq+vj2UgOs3VjrJJMSHHbhay/g4twQGXJGxSxiVi?=
 =?us-ascii?Q?+U5fBruNoqesbfsO8/cTJ8gHJZFlhSafC2u81xwNHrYBr9DLcCwAI9ysfKEl?=
 =?us-ascii?Q?aHCJ56HgIyPTKH92zd6oLwWMbxbO4fxTjKb6iIZMkINZp5UAbS5WSso0loqX?=
 =?us-ascii?Q?RTHafKZd4ff0t8tWMYcPOXaXfGQyvyI0kToHc3auxvDY0fAKSER63uCDv2hC?=
 =?us-ascii?Q?NBMA0SzFUKwexUSyBkNagLtdAwCpjg3fCCOjM/W7qgGMLV3yiviQOF78yZu8?=
 =?us-ascii?Q?ans74Vv9XT7i+IucDoza587x0GhiFEYfP0ndB+mxYI9jvOx9v5eUUV1VdFdW?=
 =?us-ascii?Q?/GgJ1zQI2YsRfT7EhRrbmero7H4vLu/zpm2vhO5Xr/DgftZ2w7p+W+rzTSZC?=
 =?us-ascii?Q?jS+wqwEo9xqbKlZfULa8ETIOThnW45gsOsl/oEyrEXQje+HTJPqXCp/kOxSR?=
 =?us-ascii?Q?mS5lipld8QUDQkydERtI3u9mMlvUfg/UcRnkP9/mvPtk5aUkmy92uyZNIy6e?=
 =?us-ascii?Q?PNClq3LxQwrDiCpB3i1/hkgzNFmnmj6vYKGWKEWFOlZKwUFd/SnediI4s80J?=
 =?us-ascii?Q?Y4Q8Hs1rd9JAi0ndazqba7LiH5eCtsUh9CVf5ce5guZ4V7oVWZEXPhjv/jXU?=
 =?us-ascii?Q?LlOIdu0Y5IqFAw2ORptCmY4e3zfHO/FYA99PpDQfPssld2B9Is6f5+uBsaT1?=
 =?us-ascii?Q?La6OPC4jc3Ezq8Y9J4bddHkp3fxxkQ2vcnrS33wObF/S0C7AVTxDcWjj5Zfl?=
 =?us-ascii?Q?OlSfu2tdWBnNBlDVO8Yi3dNnV45QrsRRMa0BhbJfUN6j15oWaJ4rNTDoLu8z?=
 =?us-ascii?Q?VNEJcAXxgZBHD3hmky3Lr+TTRXi04Zka4ZSGqSiTJnQtjc9DJDFTzbhHRwjG?=
 =?us-ascii?Q?toN6iq0H65DTAFH71PkAHRADV89zLdkbaHKcGmvub8gsd3cyOIU0muwX6c5N?=
 =?us-ascii?Q?Z1XXLkeN76aivAdnA8mCRvbRYZuL98L1Vue70O8yI34KbAlO/cqq6KtCgqX9?=
 =?us-ascii?Q?fqeE5um0+LDDf72Z2yHEJnUJT2WJqfxP8aRKB+YMn4TUSVsj7MPXO+pr9SH1?=
 =?us-ascii?Q?Ju9RZpoKPzX7yAWF2mbfI0lmsj+FO2wUxu1AltKcGQc8H0tJNUUShiqog5vH?=
 =?us-ascii?Q?dorNVisXyLhwRxObW9xgD7g3I6kTCP9wPQW8KlIP2EgzmNK2oEaDEvLTKrAZ?=
 =?us-ascii?Q?E2aZan++6L6Imaz1WT2Ksojtnw3lOWcZXBbWLUJ7jGTZZBkroddpn6j/cZAN?=
 =?us-ascii?Q?PFiVSWLjayaNwBeFQJ0gpxXEwvKAW2A5ZRMvl6WfjHIe1SzxqvdZ/A/YyKw4?=
 =?us-ascii?Q?vnYR3Kq+s+GMKiuaMeU3T52E6Gih8GqBcM2epxdnITPw+j4sLY/VvjPUvLHk?=
 =?us-ascii?Q?YoQ6Q5blztmhaTYTkFNRk4SHUCN5Ul9btUydMQz1xoGw+kKpcDBhMyUdE5T1?=
 =?us-ascii?Q?DFfqRc2RjpxwbjF1ttfIjclBpon+TG+Ta6KYDhNKOHezyDjDDnmflFHFR7DD?=
 =?us-ascii?Q?ydY+AuyqhayhpTLGMGcSUaD3fNj2/RTvoHiYrkv1yyrtsT+FD9Nf62g+EoKb?=
 =?us-ascii?Q?3ks3R1l9rWNQyQoB+i+rF0O84WBAQfM1VYaiufXfgR4ZeM7j3WOAX49uDhTg?=
 =?us-ascii?Q?94alnyidfK9PJS80Rpqo9qU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039ae4f0-f7cb-4cfb-eece-08dd70416c8f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:25.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3hEMingC6jxsXM02d+kyos38yFtUjHmnkhAC39bPlR69soaEEcmZmrIWTg6sILw54rAcy82gqDXXDGPCM2MgdsE3brp7AqbmlfrXbRUrGdwYMyBNBvR4fHMTYi+znPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18426

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f407af78c8d3b6035f81152b15ad67063f42514e upstream.

Because rzg2l_gpio_populate_parent_fwspec() and
gpiochip_populate_parent_fwspec_twocell() are identical.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241017113942.139712-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 36f1a82352fbb..353f9b139413c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2433,21 +2433,6 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct g=
pio_chip *gc,
 	return ret;
 }
=20
-static int rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
-					     union gpio_irq_fwspec *gfwspec,
-					     unsigned int parent_hwirq,
-					     unsigned int parent_type)
-{
-	struct irq_fwspec *fwspec =3D &gfwspec->fwspec;
-
-	fwspec->fwnode =3D chip->irq.parent_domain->fwnode;
-	fwspec->param_count =3D 2;
-	fwspec->param[0] =3D parent_hwirq;
-	fwspec->param[1] =3D parent_type;
-
-	return 0;
-}
-
 static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 {
 	struct irq_domain *domain =3D pctrl->gpio_chip.irq.domain;
@@ -2649,7 +2634,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *=
pctrl)
 	girq->fwnode =3D dev_fwnode(pctrl->dev);
 	girq->parent_domain =3D parent_domain;
 	girq->child_to_parent_hwirq =3D rzg2l_gpio_child_to_parent_hwirq;
-	girq->populate_parent_alloc_arg =3D rzg2l_gpio_populate_parent_fwspec;
+	girq->populate_parent_alloc_arg =3D gpiochip_populate_parent_fwspec_twoce=
ll;
 	girq->child_irq_domain_ops.free =3D rzg2l_gpio_irq_domain_free;
 	girq->init_valid_mask =3D rzg2l_init_irq_valid_mask;
=20
--=20
2.43.0



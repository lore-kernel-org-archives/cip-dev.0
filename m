Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38E6C35FF4
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.59])
 by mx.groups.io with SMTP id smtpd.web11.34853.1741778794146823872
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lmmS9DlQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMH0sk5rrqZRU32XGvdaA1n0CGh1B/E0LxzHSGFwmV7YrMUKkbvtedN3etwweWM3144sGg7GblbkulLxzuAnOfzdtpTeHgm/MLiosp6TxCOnDfNLKEQlKJUQHaLNlyNWBovCIdIb9WKfN/YLzpa1R5RQkwXDacVAmJam7L+K8J+G49LJdSKbMry384JgVnxeRjWzIvPRj6jOfYLc72Ry+Z5yC+ykXa6EZXOK97JA4ligTCcDfnVFaL90fvo0IW2GAI9pZdx4HQShr8SvVxCw03U62Np3da5e+kduvFEgG9md2a0ihLLWcSf0yqes5h7tc3+w4fAQ2yBgD+S7wcATCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSEbP/D9y7+QQNujBEq8eO5mgcif/OC58iCA9sW3EUI=;
 b=qA65isOL9ce4Zk6GsZ1SD/nyMSEdUu9uBac1QxXE3nKdaoMW+ih7tH3fE2K4WSheQ4W7s8NtULHvVUdJflJxCWTnbr0s8F8pbV/vvVZQaSn3xUcyaHu0IP4BrmE/FVeYrILxPo4W1ytcsPYXLMmgYlq02XldslhzNIyAOc9euMmvK35OKegyGwvqvTaIzsvhLdV6IvpgKwCbh9S7ssxOs1/IsbALd+SDAZyNeKU+OCL2ZfNINT2XIDGoYXbeX1jfU76IqG4pzQz8z8orc3CN8gt7k5DowmdVh6Oh8zUSaNdH3lZDouiGyjkTE9YJtbhf7jWipGIVH5mMZL1qVWLyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSEbP/D9y7+QQNujBEq8eO5mgcif/OC58iCA9sW3EUI=;
 b=lmmS9DlQxDy3L0ISqFqV3zqyFpDEdAs3+0CPQf0ZddG+nFuhGc4bZnDsXdxEiNPb0tEOt3uCOFosEj335uiISbEmgf83nFiGYsG6VDOuotbYysj5p+qvRL4u4aXvTxXOtlftHlhDIhCxwLyj0GEolK2giJRZIix2rMrF/ughp4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:32 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 60/85] pinctrl: renesas: rzg2l: Use gpiochip_populate_parent_fwspec_twocell helper
Date: Wed, 12 Mar 2025 12:22:37 +0100
Message-ID: <20250312112302.1605750-61-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 9229f946-dbb0-437e-5bdb-08dd6158bd78
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BM8fxNykSv/91IQSedyL6ud+GdKO4w8F47o4bSUErpPsJYjIHyo+xsk4H8HI?=
 =?us-ascii?Q?GWK4x2VI87Z0MM963E1bt00lpEmoEJX+qaaQ43V1Ys37TEuNCfFJTEi2Hx4N?=
 =?us-ascii?Q?WwpM8c5SOuao8c9OjnNv4h3/xzNH2p4UH+hWQvQtqF2GdBW1JSiVfgZk2ugV?=
 =?us-ascii?Q?V+yk83ndMIIkBiLxQYLzbR6hvY/US41Tvt6JcKeZ8wFcqE8aQTQeF+YJyy71?=
 =?us-ascii?Q?VCneAIDj4lzW1UEq5OKJEL+BFR1vHTbxwiB6bpTYIpU3ecMOfBWjWKgrQDbs?=
 =?us-ascii?Q?hpopfrd+DymU8r4B3Ee+PGCcZc91zK/o6SDxAVfqHrxm4Cy4eUQNoV2TBiKF?=
 =?us-ascii?Q?goren7Zdvvz6MUkSrRgLtRcue8VD5wZNMvP6BRdomq43V1ZEaTJdyjMZ3amZ?=
 =?us-ascii?Q?RJy09DK1diJBGrNCnCFoiU0e3OCon6s5vQhQlNqwtjU4pRVuyhB8H5JSLKRH?=
 =?us-ascii?Q?MYgRUPHiU6W+gUuzwEjUYT9Qcu8HdmLGeJWQ+Oo7w0T41M9+42NieIttSQ9r?=
 =?us-ascii?Q?DE1N9JtVlUQlcWuw+mrA8Sngtq4Ob+0RJ4uv4DCZaxYzCH5eHyMHykVnv+yR?=
 =?us-ascii?Q?B1j+K1iReRoexu+osdiOler34Jv66lj/oblrBs3enrTYEJuJXaGAO1SPa6aw?=
 =?us-ascii?Q?A6Mqm0PtP526Dzv6fO9g4uLa8imHU2KHhI8e+vbmiSai7O0LdCfysdQMFwfb?=
 =?us-ascii?Q?KUaInzM582RGH+ALtprc5G6bW1xqoHh7rDwuFRVgdPt2JrxBXp7Fz0i1I6W6?=
 =?us-ascii?Q?TrgMYYyvFeOVmYYITdNfUQJSKQsr2Xnen4JUWEd02VgR6NIgrdQxB6WvDJP4?=
 =?us-ascii?Q?mcb9p0G7HtZK8ZTPUfJF7vE7k9IOGc/5e0QoAgqlHrfgcCvhyovevtn/cIZz?=
 =?us-ascii?Q?wr2aQpUgAXQkuo6rdKsiPnqq4vYTHJcs1FQ5er7gLsU2pWrBPTjp/Iz904+5?=
 =?us-ascii?Q?vj8iF98y6DnH1w0jjEYQLKVN7bDZjyb3TwVC2+ArbFOj2DcOxx/LHID4EPnM?=
 =?us-ascii?Q?wsUHKbL71pvBG8BToqRx2BbTRNG54fnuAviVv+sALkglbR2ZcSBdlS/L3Zh1?=
 =?us-ascii?Q?OKdQwvGLUimtWu5LIzCZG8GvXPCaXceoL/nTxUbggN9wTRnwvVXyJSmY0Xvl?=
 =?us-ascii?Q?SyaqXKbUVSb1KcPCSX9LL657qwqDZ9ihXQJrd8LqaYsi9ogbIcpYPKrPUsqk?=
 =?us-ascii?Q?UeLaJKYan4/uwS3V9IQbLziiFcLCiFBGcZjQ43FFvwOxKxc4zI9+karnJYqM?=
 =?us-ascii?Q?JYcc5ZbeRQhIKxxGqt6SIEjvsTGxFxoCDBAubJp6Llwgag0ST/82y1kyn4Vm?=
 =?us-ascii?Q?IKuol+p/UmHm9XMEvR6/UwV515GohRsBCoP7dQ4QtXHSb6z7sFiadT/Tlz4f?=
 =?us-ascii?Q?lMa7qFCWoqEfcZrcaj9v4mTxG0g89BwZsiNY8osByvRnLyAT0g6gcZ/3Akms?=
 =?us-ascii?Q?yS/Uz0hsPDoyrzyiJv98WST1NJeOQNbr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hD2P26NBofzjqebqdm7LJ9HfyKlzQZ08zulUzSLxfWa2KU4Mm4nM6VtC+/uZ?=
 =?us-ascii?Q?KcULVuvFBML+hF6DQ5iw535i9v/3n02XGxcjV5Dwxc/7vMgCpcAnJDZjI8ZT?=
 =?us-ascii?Q?wsTZG/yG8brbT4EKnz2AzGwkKYeaPAuDTbqTR4+h2z/O4L32u9xBwx1hNTzJ?=
 =?us-ascii?Q?PJlDsXErhXR2BKWrK2k7VOSxxuD6IwyUUxQDN4ZGGsMcgtdi7FaeaKTkRnuK?=
 =?us-ascii?Q?rIl2kyazLWI6xNU5KlMv5XsDSfiEJ4Tl5r9h2tfDmQ9X+flXDFb28HVaUHo2?=
 =?us-ascii?Q?ivOMMsQ0Xd5ikiLmx+xCcSbhRRCRHQH6aS2y6y+xmnmEvEF49aESAkE6P3Hq?=
 =?us-ascii?Q?+3jtTApr7HmJQmIUC9NI2VS5bkmRJhE65oR8ygpyvxZkPMsjw0MV+exTzWVy?=
 =?us-ascii?Q?663eDFR8iYJ3hLQYQZdwPTAj8l2foK4UZ4ZMWKmsx9oGK2NnQqW43TGQ0yWL?=
 =?us-ascii?Q?mJYu4Zcg6tc1vl4BCMVsRP3G3yzzOYWQxKw6Gb2lXPJ1I2PnSMoPt14RMHtk?=
 =?us-ascii?Q?VRf9XFrfnehnTcmRco0PzSl2uVWketnCipNqqmmtUrXTEfYm5gGsw9WMBpjc?=
 =?us-ascii?Q?bmEW7rmLKyAwFEvqIyATkBUbf1rFPwup13opTj3Z6cjC1wq0KzkaJv5Ibw9Z?=
 =?us-ascii?Q?mMGy33UqLap7R+22zIe0e09ww52WPZmGtXj/+smCMYj/gsbc5/55ErmKBETG?=
 =?us-ascii?Q?h7xaIMoX4zLmm33gJAICQtM5L3IQnJX7859A0RbLGGN/pSuQe7mv4D0M6xsf?=
 =?us-ascii?Q?5qfX59o+tSjH7aPbqbWdJRQuq0Ghcg54a8wY6zhFjTi71r7RKp7AiEhMQXVa?=
 =?us-ascii?Q?CfiuchNL7sNxPiHjmDHFZYYxuVlyq6pi30y60b4frdmbvW/Smm5AGBl47rtm?=
 =?us-ascii?Q?uEJsQY5nYkeeOy/IJq7BuiMYYO/XXCK1wiIdP83UUPTiogg9Ru+ZGZcFc0f+?=
 =?us-ascii?Q?5NoEx1EUwCX5KcQHLxSTx8pOXEcaTUFLWK9vbBkOjEeV5FmVkcjVJtXE/0Ql?=
 =?us-ascii?Q?8M4wE+enNDc9X7MA9qcV1qh9k89y0FZt3pSHN3T9BBkRy8tWQ5l3CmR5QMut?=
 =?us-ascii?Q?b6piOuR1z+XjfCtudgPYgmdVKikbeDfxAKptvX1fEmMO42/Oy0hYY/zCQGgS?=
 =?us-ascii?Q?ZRmdAINepKW3Cgh5bDYJmGVuyuxUj2Q8eBdAsFl1uz2co1uxG+yHh7xs5V5u?=
 =?us-ascii?Q?er1f0WUB7mvWG9u7Yu2Q6rVkowAE/m48q5RrC5pAsX7E6XtnjqxKTmXssXoR?=
 =?us-ascii?Q?/lYQmHq64RHoY7L8RbzhsHbJPpZlYFaVz3pUT7KV9SurZd15DsfDLvn1+sAk?=
 =?us-ascii?Q?6VT33dDWP9VEABSM7esuLwy/Lwh49YiNt74aNM3Sd6+VxZNfnYw/ZrGdFmZo?=
 =?us-ascii?Q?3UNGgK9vmytmcHvInLo1SxaAhPuYqWofvwmiPFkv/3v7dlWRxlHVUtEbVMkF?=
 =?us-ascii?Q?VBcWjXoaxL9BdIned2yWvge2aWsy+LTTOTATsNLS9InAApgi59dcISccjWYS?=
 =?us-ascii?Q?VNL5/0ietxfsSTvMca2dMOOp1tOra2C9bIqd/rxjtqqnWgwW7fiJ26EGFyNY?=
 =?us-ascii?Q?oqXsmy9Spke54jTjU7us69QtGBWf9CS2yGiSNfUa2C8kFd+kpGLRDRFufbes?=
 =?us-ascii?Q?SQNsgZ0zZzrDAj8lLN5EAAA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9229f946-dbb0-437e-5bdb-08dd6158bd78
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:32.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THv2l2UXM2jSxywJJCJlqFVo0Hh5OZppSMuyoYs83vCCAApQy71Bjb6Sd0YAaX5kpFTOHLnWLyaFaT+X1E5mvDR4s30NfnnMLaZqFtjrTfTTJCwx3/+JLQN7PxXGP8Np
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18152

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f407af78c8d3b6035f81152b15ad67063f42514e upstream.

Because rzg2l_gpio_populate_parent_fwspec() and
gpiochip_populate_parent_fwspec_twocell() are identical.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241017113942.139712-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 36f1a82352fb..353f9b139413 100644
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



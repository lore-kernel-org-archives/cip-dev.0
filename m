Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E170C3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:11 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.35])
 by mx.groups.io with SMTP id smtpd.web11.48834.1743418026199439781
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZR0Iykmd;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrDuQEavcYAg44S5gxjQrm6vDKjpxqmtchl8oPxn/+dkioJk5HwlnVLv9naD3T6klmT3rlIcD+4vk4o0SpcJ7QMcZVr7oQr+r8b4voJfW1q6Ipi28jNVT/t2N7PW4yXIWPwSVEGu1nO8KNq9QOqI0auZXUlxnsh2+qlK1JnToLsxYXs5u6RG6fm8zxXGiIXxmeIl7q1aZgPgpteOu/otRBZfZzKKsqYSd2CxTgfaxLjWydy1Os/u8Vsr9Z1QlgutQoCIPsJwwOzayHW9O/637FwGGTjIQKOq7ctuG+2+apAUQIgLpp20OLaNHJAxi5FHU79QsU0lNwbEFgKr/JwRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vCbIkSPsmoLUXD1013TQ7PvfHEbj1UhhJ3Pf5W6a5o=;
 b=Ok7My5WHshnVvLpVMXXUGQ8ZgJJXi+Wt2Vt1PXgLYMlJObyWBcYrgqf6Z2LSEuijjFpyraJHq9tV00lnPA/Ow9OvYAwQ9uUoqLaetypf5kipecvwMpFYSAm2MqQrVEJ6i138MZ8gq1gGQGhcx3PkWG7rnSpLClY6MWnqqcWSE7AUTfk7h2/Pizck9WZVVPcrEF79i+mnv6RgfHAvWBFn921WP6mkNfOA6edEl7NHXid66pgVya+JjDJLfNzB+z1NCC2+E35Glx9FDmZEETT5Q3XRMjKe/nkweOIo/4e1FJ+J5KYWZq2nvHqAVw/JcUfFu43LRnFpxb6/XRQN5Duwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vCbIkSPsmoLUXD1013TQ7PvfHEbj1UhhJ3Pf5W6a5o=;
 b=ZR0Iykmd24kx16nCb+s7vwH5vkCVSTdMCOsc2KXtYiQmmu/j7LfK3KAsZ3BsicTuePlVjRkOzTnrPxn7T+R+g0OBr8aFwcrzwDsXMe5H4cJt7Zi+tsYk8YwcT5/HN+lP6Le5sz2+SwKZxF3QOmSp/5Hzw/o6SkBKWIbpACsOlec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:04 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:04 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 31/43] pinctrl: renesas: rzg2l: Replace of_node_to_fwnode() with more suitable API
Date: Mon, 31 Mar 2025 12:45:02 +0200
Message-ID: <20250331104514.79090-32-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98c3a648-f242-41e2-c169-08dd70416018
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kYgYdzYvueA9oBtKCrwIgYYZY6bAyqXyC9QMixBcUWelWry05rBCujLMovb2?=
 =?us-ascii?Q?6ID8kRCVxP4ccTS0wV+TAmmj6dKMEImYJjpVrlSJaFiHcbXBfpbCV/7CliuQ?=
 =?us-ascii?Q?09XiEPEpPdC+aaJ+nFFW8iz9nEkH5uhT2zYGhiOk5HC9BTQJx8xiG6MGjVBs?=
 =?us-ascii?Q?iV4g7gYeZmS1KWm9960warv6hbf/efwn/IdoYAAzIm3GLakG1/2a5O4rX1qP?=
 =?us-ascii?Q?cXJlM09Z7J7p/m076ygzfG85Kj78dAkEhqN7QfeuwTw9IzE/9hEA04YsXRpG?=
 =?us-ascii?Q?UwoB2G+KYk/Z3dHc/QwY/4ml3K09t51HzIzIdZOstcy2OA6XkuVhehoR1zwm?=
 =?us-ascii?Q?uS7YNTkE1gYq9xUsisPi0mnFAdG+QbbpLSZqfYffCOjFlGesgX5d01kpU2OM?=
 =?us-ascii?Q?hgnNUdW/DPYymVfStdak+tUu6cfmFqP2LnHdnuaWGsyglE0Y4DyL4fqGAhAs?=
 =?us-ascii?Q?GGz3q1kO5PwyFQhnv6oaiaPhGlrpltQz/seMVXeSzjJhkTLhKAiMWoPu8fJQ?=
 =?us-ascii?Q?IeWBfKmzfbvJckdi7P6O+HFEM+SqXku3cmjEVWNoYEG6yDC9JMdxOV6Cgn0y?=
 =?us-ascii?Q?e/Jl/7fnCTAnsZlc9z23/3PPfHqL5DzE5lq6oD/aeusEIsas3L4n9c9MaiCa?=
 =?us-ascii?Q?EXqp6P/F0IrXOsd0ypBh35cd7JMLJbPBgiUP4vifTaw6CKamGPIF+Qy1ZvdM?=
 =?us-ascii?Q?vQ4ndoHSSPykyrIaQKqC2HkAb6qnyrnVCnGhdO7Kz3j+aAetAhE/0EiWiWxa?=
 =?us-ascii?Q?ANbREx7C346yU0lyq05g5Dh+r8bHE2JJzdsInjBJzBNnGxqmugM8T/BSYETw?=
 =?us-ascii?Q?avAMMWt5YSZMWk0aDs0fSm0IWie3tIZszqjZFlcfxhH6LjSC0dDY0v1f3/jG?=
 =?us-ascii?Q?XIN6BuU7Jjld9MXf41rYIcK19VHENLM/pINYDTK6tDyqOpnVrfCwD5kuBjT4?=
 =?us-ascii?Q?GVwvDT2vR2S1Dzu8+b8fGJpGRbv35Dp++9SUwV5COPTwbT1oo+82h6LL1mbU?=
 =?us-ascii?Q?TUELTEieGijNWDR5BCcXq9RLWOV3iaf3gxRahqiGHJ2LZDHEoEY1hczzO/6P?=
 =?us-ascii?Q?xmio4jrJ2LYEKKzokN6+h5l3pp7iGGYU4mY8if2ou4bHBHRr2HI6N4hOSOW2?=
 =?us-ascii?Q?DN8gBUgORMYba4Ac0/d2m30hB+29L2W9ilpK6RzpHxS94lQnPUYtXsFe1wMj?=
 =?us-ascii?Q?6ZTENe9O/I5F5CmPcJJ++p+GgqwbQSSMqEwtnDIKIYDYzSkAD3CeQ0WNeses?=
 =?us-ascii?Q?1KnAMiYV3FdwdEKiQvHEDOC3EqU7P8jLegn6le5mU5HwRYmlBxyQaolXnXDW?=
 =?us-ascii?Q?RisyEV2Wlj0ea3qlZjRbs8Fu5LdPwDy8kC3BIr/ROdF376F5IzerKntzHJCA?=
 =?us-ascii?Q?sEDU8yZbbbT02mXve8hJo8A81WNLqv/FYaAeuUir03dzDL4EAT35CY8Fn9Bk?=
 =?us-ascii?Q?58dGHzFZYIDUFe04OuG6OFmyk9zAuwo7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wIHBEsHhL11AGT8eVr8YVRzfBqYjcHVG49K1wOmuXwr2UkHxfvAcOf9ZlqOZ?=
 =?us-ascii?Q?ySDaiePC9ed8OoVKpaXUWkxzCUrARgmWrzLPtLsPKgo8h8BZ0wqMIbIPqVgb?=
 =?us-ascii?Q?Q7aL0D4iNjPyF5duK1lcUXzNu+7dX5epKfH8A0Org3IO1lXs/Yx4ezq6owMz?=
 =?us-ascii?Q?jT/TJ9joH1t1oXjfvexv21vVKrWnhWlFXzIA7p2Eu7aUgyA76QVc4MkX5Imm?=
 =?us-ascii?Q?fPSeJszgegTUwJt4qev27dU2wycwUcI3+7i414VE2kGOvPWdBhSOYu8JnALv?=
 =?us-ascii?Q?JDigaGi/JXD+fVCmKzAMq7Y6sLKfPPIP85bsYNUDWsH1glCeHTAsBz870Ygp?=
 =?us-ascii?Q?LmgkkGTWbKSlEbUOYSrsCmTqgyEYWqmvO/Gjp4yX8FFw9X0lNbt+1lEZ3mxU?=
 =?us-ascii?Q?ziGfeZukS49d4eVlIW/vOZiAv//a0FzHAIOI+Su8NWvK7SFvJv+Vk8iFjFMd?=
 =?us-ascii?Q?AxfgcTrXBGT/61lzPApcZLlz7r9ZdmoTanpvBpsjSXoJkXSiz35LgQngf8+Y?=
 =?us-ascii?Q?sh2OknABN8CzVNIkhpxl42gn6BrA7VJXwhMMqIRoDPX1bokUecOe+zfapm2J?=
 =?us-ascii?Q?yQ3WGKXmZMwpmCMDyC9qRaIBEuk+1BOGFtKBu2gv4SwJLg2XCsmJ6geicJ4q?=
 =?us-ascii?Q?ldrfUDdS7222r7ZxKXYu6isEj5pbkz8rU+R1f0iQR6YHEtoMAba0LmKb59dI?=
 =?us-ascii?Q?NWnyuWHeHycux7ypHDmUW6jpf3l842Kn0q23osnzqv5sJyfKwPHCXanH+bvG?=
 =?us-ascii?Q?Y1NvPOl4N0uzOobWFyME6H2h+dkPb+IbepecHUowp7GewBTIp3oAReJRBF5+?=
 =?us-ascii?Q?UKvTCc17BIsXVSDG3DPbEkMYvwCnG4IaqMKbmFiC5p8BwQ1QFU3sWjrSfVCJ?=
 =?us-ascii?Q?9fyO8oqFOUwffY4dpx/+xh8j6AXdLbalrqqJLKRHvIb6rQmOAej9qi/UqaCp?=
 =?us-ascii?Q?Y5zBD6ORz9HhkrUpW0Q3xuauf0CYxDaqpY6nlB5myRCVy34FgAEBzVrwbZkq?=
 =?us-ascii?Q?e5uymXjomtNELFfxJ0B2tGHagZTnSLUgI6zp4nMhAI96w3Z5SD+1NTgUSb/H?=
 =?us-ascii?Q?wlq0lZt45Nk9/1uNqzwn8ZnI0bmpHin297KowcF0BhpQfuszhKuJH7oFGaeb?=
 =?us-ascii?Q?8ffsMIIlITzEi47xlIZ0UwucvsSXr4sIOyChPj/UZZzJyqYpAiBjLHzYE18F?=
 =?us-ascii?Q?vHQE2lqHOrInnQ5zFEZo3+DY1ziWjof7f1IBTNAKuKjWnHrZBGzlk55SAQjN?=
 =?us-ascii?Q?iJg4QyjPkrpo54fGK7wiEdH+GIZXBU+MYjgtUpnqmNmoFr4m84xiQi5IDsLm?=
 =?us-ascii?Q?SeH7mJYFdRE+zQ2s/4PsDxfe3LftRe5SbxZTVDsfdOgADjIyyUfDA9itYV1a?=
 =?us-ascii?Q?6+MMjcGfLxz7TfOjZ0zebsvVESO5IKPlVbcK2sguwKzppFoNp/+wPptsiQ1M?=
 =?us-ascii?Q?W7Ub5rMufvtL8U5lI37jbxqaN05w31FnBuaB7RaH9B+1lnAyzNr5Ppl9oR/c?=
 =?us-ascii?Q?M9U11LQOZ93sB8XbObXftw7dpM8BKgFCGjPllNe1C+zSchXvyZTRWcKkCmkj?=
 =?us-ascii?Q?qV5Mfu/n1uyIrP3X0Ac1yGXmWymD+ht2DFUhxRXhxJ4j4mBxgAiFz/VPxaus?=
 =?us-ascii?Q?ejhatWikWlLjSGZLjZbhEv0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c3a648-f242-41e2-c169-08dd70416018
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:04.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMh3BzIxlPLpSE89O/UQ4KWTB0pfmLP3Wlf7dXzXVIOwR8GSH3LnIyGCRl6/JwzPXlA0H10DoPxL5O3EBZUh0r4m19a40Y+k3BMGcszdn84rTb7+buUQvd4JUdBlb62e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18419

From: Andy Shevchenko <andy.shevchenko@gmail.com>

commit dad83b9527030e29cc3148f7274910cf40fe7f1a upstream.

of_node_to_fwnode() is a IRQ domain specific implementation of
of_fwnode_handle(). Replace the former with more suitable API.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240822230104.707812-1-andy.shevchenko@gmail=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 4c111fb27845c..bd739879055ac 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
=20
@@ -2623,7 +2624,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *=
pctrl)
=20
 	girq =3D &chip->irq;
 	gpio_irq_chip_set_chip(girq, &rzg2l_gpio_irqchip);
-	girq->fwnode =3D of_node_to_fwnode(np);
+	girq->fwnode =3D dev_fwnode(pctrl->dev);
 	girq->parent_domain =3D parent_domain;
 	girq->child_to_parent_hwirq =3D rzg2l_gpio_child_to_parent_hwirq;
 	girq->populate_parent_alloc_arg =3D rzg2l_gpio_populate_parent_fwspec;
--=20
2.43.0



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E295C7EE30
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:28:09 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.38])
 by mx.groups.io with SMTP id smtpd.web11.16542.1750674479269778632
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:28:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=NgCKuEHf;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ5MHVK2OniXkb5v1D970appYIJXkuAyw2nL3S7oQzFjkX0Qv824s/Sp/lm3uQvsOlchkbl/9aBJLsfByP3vOgQlATdwCeLiDhjwY2RGvnjsaU0CHpAnchOvBjTB1zqP4h+74ZKgHTkD4j3wNCnWuH/Fny4DK/zv48FLsnIDrdw7tIN4nf0MSKP9DAg83bKiH67r590M5mONpitV4azxibEWG9gTcDOCTL2IQNuN3/G+4vIun7bljkAlEb/DN8QicyaktYNmhx9JTdGooigeAZo9JkyW9rfdVmQ3ihkEMHtGMHD1Jb88IE+cBi9qNJlbb0tmbw4fWzJXnWnhSkJndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/FrI4xOF00YDQeSEvlQFW+7ll3qjiyN5avkiMXCAMY=;
 b=g4ZFEv7FTjkC4GDdBY3hPzX0SerWmk/QDh4VcCqDEw2vg2TgEl7lDNboX/i0NyHQnEe8cmSaBYmSStVfSy5z4d7pm5y5qCQiC9yPc0c81DrwPr50ClO7rAMZLWTVnNmAuQcXEMk4ogvfTeZrVQIf4p+ZC5xGA3hHF9RjAGo5U2YdYVL0Ubvr8g6T4CbW1/8pzLt1uYZnw6OTRqopDOWuKpQWk+qqat3n6cgmhrx14xlQlZ/PDIAuBqeqPVjMLKxRa2j2k+k6oVgO7/lUsz2h0MDe4WXG6LhYZOcfNp/uWwSeaGQUJ/uF7weG1L4iGzlOdiy6DwbHFeEazoRtZsywMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/FrI4xOF00YDQeSEvlQFW+7ll3qjiyN5avkiMXCAMY=;
 b=NgCKuEHfPUmy1fqbNC2JecevkSPeuiimkMSMy85t2UT2cnAP7uovEJIjpcjSbj2gJ0/SaML0292m6fTDs1vQdyTcHm4mU/10nMs2WfG3LqC32E+SnCiAl/3xPz3jNhU0/fizr/sVmRpbfde3tOSsTDvjdWzCb6XyK2hVKbJuJDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:27:58 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:27:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 2/8] watchdog: Add Watchdog Timer driver for RZ/V2H(P)
Date: Mon, 23 Jun 2025 12:27:24 +0200
Message-ID: <20250623102730.1493286-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS0PR01MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa1d4dd-9bad-4478-58a4-08ddb2409fad
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AxRHaYknKuIt4txIwrDDjL32+rd6PLAUc31ADnQ4AOBuDwzCTOSjOEBdhpml?=
 =?us-ascii?Q?H6Af/zs/I7AS79Ol0lvxHCJGkLYdGyjDD69RDEzTeWhSlJMypKuegL6ScXUl?=
 =?us-ascii?Q?SOpEr+ZVJxY5VXq/DF75+Yjtp0BoMsAbrnmR9MZQ0jNYrdmj2eE/zZJe2fXp?=
 =?us-ascii?Q?PCmUSYLaIuKVJIsbCAR8E6tC2DkQ3ItWDMPRqgn1RR+vkw2lRqmOdxBUxIcA?=
 =?us-ascii?Q?TMF1aA6E5Ft6HJiexqNlZLSCsMli6UKrwlJR1KvEeJeax/inSfAnNqJ2B9Fj?=
 =?us-ascii?Q?Kcw/wMh/YsV8eFAplgBc2obQnyh51QVYrfWQOUcA58NnVMJ8oV4G8F65tMGa?=
 =?us-ascii?Q?YCmzzD2g9PumptAsXzEnUkHUAzHDAukz/6Z7pnQsTXT4+de9SSnOHYo1F9Nl?=
 =?us-ascii?Q?B0g5D7W8rBA8JMR80cU2OZD29Q45MCz4DZ1kAIFRuxIIrU0MmfykI7eDNrhl?=
 =?us-ascii?Q?orAD6aQHFu4qI4i7c2UjlYezAwemJsM8r4e6Pn7aEl1O86aM3jtmzkNkLeyz?=
 =?us-ascii?Q?R/sXObYXRLbPmO5Yt4AuoV+hMTaiscxCbL/kBP4VZ/21tXk/4EH72L/zBVs6?=
 =?us-ascii?Q?iU3WloeBMLMtrsi2VBnBNNMEjSF9B8r+UHYFGjCKgOCdmaAeiCUPRS7KVBCr?=
 =?us-ascii?Q?UT4t8cQBKp97iRisFx7PwhngS5wYM8TLmnjEkNpVE/84jX6Cpeoue6WShRxV?=
 =?us-ascii?Q?MFZAmeTo+10FACiT51yOss1EWyUOpL80yE5RyCXen18uTjKiAUwP2MqL+ijr?=
 =?us-ascii?Q?z/w6pmD8/cEm1201Xav3eoF7qRcdkXzi1M1X9hUXFgJMrCnIfmukQnAbhRek?=
 =?us-ascii?Q?CYUsFTQ4kx3+jtYk4SFn6Qzl8K81NURBZ8eEcj1PDITzux7CB2dlHOca7mxL?=
 =?us-ascii?Q?iXUxVL/gdh/Qi14/FabX3mQJ9lnUGIbi0D3cEmrwlDVSuL2HSqniPkaVz7fD?=
 =?us-ascii?Q?JnVaOpp2Py2fLaCjdE1cu8DRVThfgAj0tmL3m3I+66k6AWiDpDkvSBIbfegl?=
 =?us-ascii?Q?UaXCFoCgk7kBgdy6PDo1oRhGBNN8Rdttznn2HNUBtwUZui/9HLeXSYb0FNp0?=
 =?us-ascii?Q?WwQXVyXQJbnP2xvyOoDagcOzNqvOTv97aAAeH34PCVYyReTq2j+2YfIA8Ynx?=
 =?us-ascii?Q?haRwd9vzm4AnIZ5U2vY28kjE4jV1RfPbrZ0TfzjKJPn3hI/I+QyEEMOwrO64?=
 =?us-ascii?Q?dzfIbBdqLIqeTE0HvGUtXqqhy3vhrv40XpJdBFyQekXvv3lQkRQ83dCpb6qR?=
 =?us-ascii?Q?sW4STRQP1SuS5jy3zFMGVJkf0iYUgoZL3NqIhWsQM4Q2ugL5cqz/mK7gVKa3?=
 =?us-ascii?Q?2elOCg+IONUFVn9wl2uhTEGbKtCrpciyTi4SvpH+tZVIrypnSQboDydoUYjw?=
 =?us-ascii?Q?2Jr5Nv8VHLEO2Pgdjpl089dTMTQcwUo5RveAgBIhclTvbOlwQRvphEVhOQpK?=
 =?us-ascii?Q?YHTYLPAAJQ/W3s0JfUnlEoMAW8vIjWLrF9Q4DSL1vpMnpn5dH1r1BCUc6v6k?=
 =?us-ascii?Q?nTLp7smU53xYMQA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zb/k1N+qBsWCgAuhliEIiqalzDmYMOr5tJKHc3CSb6RUIiVeeWwvPspwKBn2?=
 =?us-ascii?Q?u7gdkj3WejVCED9tgEqrDhNViixCFJ5CsYI73OeTWUudC9mOXrihddJS5goy?=
 =?us-ascii?Q?YeNWjcIiNVqHLNX9mUuGobqLhdztK2Hr5/Db4bojhwk8EoonV1I2zWkY9vsV?=
 =?us-ascii?Q?F/yZDlmpTW0rPCREsluLrbGSQ6dTXoAd6fFWlT4QLkksTEscDcqta5Yb4geL?=
 =?us-ascii?Q?+7e2odUF0N0Ool5HyoaNGKvqYxTQddaluXCNHAZnfY66+b4+RDo3dNrZsCF5?=
 =?us-ascii?Q?feZN6f7Y12i5EijvxkozQxXmI/Boa781Duhfi/mmsFmZNNj0gJ+/Gct/3SEY?=
 =?us-ascii?Q?G96qRg1VsqyRDsmR9t794sxs87K+5/ylpDSCSOmaZI8i4OIrcozRKBgWr5aG?=
 =?us-ascii?Q?Ni8jFbiF232uWyi4EoQ60W8IsEG/IRTbyIFulfkmJB4Ow6gI102rMP6FYqtJ?=
 =?us-ascii?Q?drP5+GedLgbZC7elmZwaUasATSP6OexjiaMupxjVjzBzPwDt+3GX5iQAES2w?=
 =?us-ascii?Q?ePBqhTL7jZ/h03w/Dsok8K+AESu3ltbERHC+l3YGHwJP8RagCBYGkv9L9vwN?=
 =?us-ascii?Q?aDJtbf2Tbs3V0wGAbaOVEucCchBeEJeUENJhvNzRDL4ROMiBUT5MpAH6g/I/?=
 =?us-ascii?Q?YugVREwiKGyTwSIXCHQok5RqfzNJIFignlYyKTnVBrQ9iVIKsIepu6VCnReX?=
 =?us-ascii?Q?s4Qy7MwJPUTp+HaP7ACWKX9uKNADkWEcMU372swmSr6EQwXLRtJlMN3ipatN?=
 =?us-ascii?Q?H6vlVEg6REj7ISv/a2Q7+Dhpq8u98VKdXr3PSXKx3Sik8VEQcIDme+5RklP0?=
 =?us-ascii?Q?YTbVQnUYgDSmDbNTX7OfOPwVdndMutRmRV2qv+s5+h5xd2FpFMOQyyYI+eVL?=
 =?us-ascii?Q?Lo6f3TTBgKeaGzfHWwGAczF+l9soF0t3UM6iSKmluoKjkfThfu0jLpCn17Tw?=
 =?us-ascii?Q?UUGBxgMz1OJiFJikpM6jMCLA3Rnk89mDp759mqOu2AKVHW8oXRWyaI6/uI4G?=
 =?us-ascii?Q?uUYSAvFWr5rBj/0p2jNKh8F1aCUowD+jJUw6oVgJoNZg2ns1vb1Y9JbP/Rvt?=
 =?us-ascii?Q?8CDPYZ7CZEr7I1PWnKmKtH8TOJw/80WblumKCsyPp2urtGJRMZqh/QknQEoE?=
 =?us-ascii?Q?KhKfNqO7YMQn8Gt/t0wiDnRnNBxkr04dk+3mgaxpCmKCgC9cSTdqeW7UecBP?=
 =?us-ascii?Q?XQx+f3av1eC1MO4pDtnNa640oZ6ebs4jcEy+ZqykHnyz7QTXtI72KpxI0n2b?=
 =?us-ascii?Q?f7l6WFCrDDBvYynr6yH697aqx4fOs7Kp7vuICyUuoDl4J9R7a9y5gAzJCnPR?=
 =?us-ascii?Q?smMhXP8juhGeIcWvBLhfxRe3O3n1oc2eXFy5o6E6w8FC1EDoGcyvxZcUuncR?=
 =?us-ascii?Q?pzAN3TMQYUPx6m8kOadlwifYPG2/ChdX5zOH6XdFOSudxerf0e2yQTTI4OAQ?=
 =?us-ascii?Q?tR/FbaHflz0N9rXblE12jGMurcLNAO+yToHlnhOZ34oIpzts5LNmZQz07Ilv?=
 =?us-ascii?Q?4cZe3vnzwzAuhgdUtfC2a67KD++NvvMJu7FcMwpKBtDeZ6YR3/zIJGHPU8TZ?=
 =?us-ascii?Q?3IrZFlV8lCZZSoMm8DYYLO5j/ipi7hr3kTh1WHNKsIwd6jd0udHN7vNrXiOn?=
 =?us-ascii?Q?yhHg26ntscOdR3JhXAOpQIc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa1d4dd-9bad-4478-58a4-08ddb2409fad
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:27:58.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxpMktUKcE9zZcxpN5RgsfUWRfeWi8r0/elMcniM/dc8e3Mx3QnSJdAKNfBPfoTpP7m6LEOah2wwwQmAAoHhdyeI0WDTui9qFC0GTP9CvFmPj5RbMt2tAy2G2rje9Amr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:28:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19167

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f6febd0a30b6e299a08076116256e3b36c24eada upstream.

Add Watchdog Timer driver for RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240829193831.80768-3-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
[tommaso: Squashed the commits 95c588f69ee5("watchdog: rzv2h_wdt: Add
	  missing MODULE_LICENSE tag to fix modpost error") and
	  1f2b24a524fc("watchdog: rzv2h_wdt: Use local `dev` pointer
	  in probe")]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/watchdog/Kconfig     |   9 ++
 drivers/watchdog/Makefile    |   1 +
 drivers/watchdog/rzv2h_wdt.c | 273 +++++++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 drivers/watchdog/rzv2h_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b64bc49c7f30..a98a4078e51a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -899,6 +899,15 @@ config RENESAS_RZG2LWDT
 	  This driver adds watchdog support for the integrated watchdogs in the
 	  Renesas RZ/G2L SoCs. These watchdogs can be used to reset a system.
=20
+config RENESAS_RZV2HWDT
+	tristate "Renesas RZ/V2H(P) WDT Watchdog"
+	depends on ARCH_R9A09G057 || COMPILE_TEST
+	depends on PM || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  This driver adds watchdog support for the integrated watchdogs in the
+	  Renesas RZ/V2H(P) SoCs. These watchdogs can be used to reset a system.
+
 config ASPEED_WATCHDOG
 	tristate "Aspeed BMC watchdog support"
 	depends on ARCH_ASPEED || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index d41e5f830ae7..93bebbe4cf2d 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_RENESAS_WDT) +=3D renesas_wdt.o
 obj-$(CONFIG_RENESAS_RZAWDT) +=3D rza_wdt.o
 obj-$(CONFIG_RENESAS_RZN1WDT) +=3D rzn1_wdt.o
 obj-$(CONFIG_RENESAS_RZG2LWDT) +=3D rzg2l_wdt.o
+obj-$(CONFIG_RENESAS_RZV2HWDT) +=3D rzv2h_wdt.o
 obj-$(CONFIG_ASPEED_WATCHDOG) +=3D aspeed_wdt.o
 obj-$(CONFIG_STM32_WATCHDOG) +=3D stm32_iwdg.o
 obj-$(CONFIG_UNIPHIER_WATCHDOG) +=3D uniphier_wdt.o
diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
new file mode 100644
index 000000000000..8defd0241213
--- /dev/null
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/V2H(P) WDT Watchdog Driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corporation.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/units.h>
+#include <linux/watchdog.h>
+
+#define WDTRR			0x00	/* WDT Refresh Register RW, 8  */
+#define WDTCR			0x02	/* WDT Control Register RW, 16 */
+#define WDTSR			0x04	/* WDT Status Register RW, 16 */
+#define WDTRCR			0x06	/* WDT Reset Control Register RW, 8  */
+
+#define WDTCR_TOPS_1024		0x00
+#define WDTCR_TOPS_16384	0x03
+
+#define WDTCR_CKS_CLK_1		0x00
+#define WDTCR_CKS_CLK_256	0x50
+
+#define WDTCR_RPES_0		0x300
+#define WDTCR_RPES_75		0x000
+
+#define WDTCR_RPSS_25		0x00
+#define WDTCR_RPSS_100		0x3000
+
+#define WDTRCR_RSTIRQS		BIT(7)
+
+#define MAX_TIMEOUT_CYCLES	16384
+#define CLOCK_DIV_BY_256	256
+
+#define WDT_DEFAULT_TIMEOUT	60U
+
+static bool nowayout =3D WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (defau=
lt=3D"
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct rzv2h_wdt_priv {
+	void __iomem *base;
+	struct clk *pclk;
+	struct clk *oscclk;
+	struct reset_control *rstc;
+	struct watchdog_device wdev;
+};
+
+static int rzv2h_wdt_ping(struct watchdog_device *wdev)
+{
+	struct rzv2h_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
+
+	/*
+	 * The down-counter is refreshed and starts counting operation on
+	 * a write of the values 00h and FFh to the WDTRR register.
+	 */
+	writeb(0x0, priv->base + WDTRR);
+	writeb(0xFF, priv->base + WDTRR);
+
+	return 0;
+}
+
+static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
+{
+	struct rzv2h_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
+
+	/* Configure the timeout, clock division ratio, and window start and end =
positions. */
+	writew(wdtcr, priv->base + WDTCR);
+
+	/* Enable interrupt output to the ICU. */
+	writeb(0, priv->base + WDTRCR);
+
+	/* Clear underflow flag and refresh error flag. */
+	writew(0, priv->base + WDTSR);
+}
+
+static int rzv2h_wdt_start(struct watchdog_device *wdev)
+{
+	struct rzv2h_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(wdev->parent);
+	if (ret)
+		return ret;
+
+	ret =3D reset_control_deassert(priv->rstc);
+	if (ret) {
+		pm_runtime_put(wdev->parent);
+		return ret;
+	}
+
+	/* delay to handle clock halt after de-assert operation */
+	udelay(3);
+
+	/*
+	 * WDTCR
+	 * - CKS[7:4] - Clock Division Ratio Select - 0101b: oscclk/256
+	 * - RPSS[13:12] - Window Start Position Select - 11b: 100%
+	 * - RPES[9:8] - Window End Position Select - 11b: 0%
+	 * - TOPS[1:0] - Timeout Period Select - 11b: 16384 cycles (3FFFh)
+	 */
+	rzv2h_wdt_setup(wdev, WDTCR_CKS_CLK_256 | WDTCR_RPSS_100 |
+			WDTCR_RPES_0 | WDTCR_TOPS_16384);
+
+	/*
+	 * Down counting starts after writing the sequence 00h -> FFh to the
+	 * WDTRR register. Hence, call the ping operation after loading the count=
er.
+	 */
+	rzv2h_wdt_ping(wdev);
+
+	return 0;
+}
+
+static int rzv2h_wdt_stop(struct watchdog_device *wdev)
+{
+	struct rzv2h_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
+	int ret;
+
+	ret =3D reset_control_assert(priv->rstc);
+	if (ret)
+		return ret;
+
+	ret =3D pm_runtime_put(wdev->parent);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct watchdog_info rzv2h_wdt_ident =3D {
+	.options =3D WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.identity =3D "Renesas RZ/V2H WDT Watchdog",
+};
+
+static int rzv2h_wdt_restart(struct watchdog_device *wdev,
+			     unsigned long action, void *data)
+{
+	struct rzv2h_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
+	int ret;
+
+	if (!watchdog_active(wdev)) {
+		ret =3D clk_enable(priv->pclk);
+		if (ret)
+			return ret;
+
+		ret =3D clk_enable(priv->oscclk);
+		if (ret) {
+			clk_disable(priv->pclk);
+			return ret;
+		}
+
+		ret =3D reset_control_deassert(priv->rstc);
+		if (ret) {
+			clk_disable(priv->oscclk);
+			clk_disable(priv->pclk);
+			return ret;
+		}
+	} else {
+		/*
+		 * Writing to the WDT Control Register (WDTCR) or WDT Reset
+		 * Control Register (WDTRCR) is possible once between the
+		 * release from the reset state and the first refresh operation.
+		 * Therefore, issue a reset if the watchdog is active.
+		 */
+		ret =3D reset_control_reset(priv->rstc);
+		if (ret)
+			return ret;
+	}
+
+	/* delay to handle clock halt after de-assert operation */
+	udelay(3);
+
+	/*
+	 * WDTCR
+	 * - CKS[7:4] - Clock Division Ratio Select - 0000b: oscclk/1
+	 * - RPSS[13:12] - Window Start Position Select - 00b: 25%
+	 * - RPES[9:8] - Window End Position Select - 00b: 75%
+	 * - TOPS[1:0] - Timeout Period Select - 00b: 1024 cycles (03FFh)
+	 */
+	rzv2h_wdt_setup(wdev, WDTCR_CKS_CLK_1 | WDTCR_RPSS_25 |
+			WDTCR_RPES_75 | WDTCR_TOPS_1024);
+
+	rzv2h_wdt_ping(wdev);
+
+	/* wait for underflow to trigger... */
+	udelay(5);
+
+	return 0;
+}
+
+static const struct watchdog_ops rzv2h_wdt_ops =3D {
+	.owner =3D THIS_MODULE,
+	.start =3D rzv2h_wdt_start,
+	.stop =3D rzv2h_wdt_stop,
+	.ping =3D rzv2h_wdt_ping,
+	.restart =3D rzv2h_wdt_restart,
+};
+
+static int rzv2h_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct rzv2h_wdt_priv *priv;
+	int ret;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->pclk =3D devm_clk_get_prepared(dev, "pclk");
+	if (IS_ERR(priv->pclk))
+		return dev_err_probe(dev, PTR_ERR(priv->pclk), "no pclk");
+
+	priv->oscclk =3D devm_clk_get_prepared(dev, "oscclk");
+	if (IS_ERR(priv->oscclk))
+		return dev_err_probe(dev, PTR_ERR(priv->oscclk), "no oscclk");
+
+	priv->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(priv->rstc))
+		return dev_err_probe(dev, PTR_ERR(priv->rstc),
+				     "failed to get cpg reset");
+
+	priv->wdev.max_hw_heartbeat_ms =3D (MILLI * MAX_TIMEOUT_CYCLES * CLOCK_DI=
V_BY_256) /
+					 clk_get_rate(priv->oscclk);
+	dev_dbg(dev, "max hw timeout of %dms\n", priv->wdev.max_hw_heartbeat_ms);
+
+	ret =3D devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	priv->wdev.min_timeout =3D 1;
+	priv->wdev.timeout =3D WDT_DEFAULT_TIMEOUT;
+	priv->wdev.info =3D &rzv2h_wdt_ident;
+	priv->wdev.ops =3D &rzv2h_wdt_ops;
+	priv->wdev.parent =3D dev;
+	watchdog_set_drvdata(&priv->wdev, priv);
+	watchdog_set_nowayout(&priv->wdev, nowayout);
+	watchdog_stop_on_unregister(&priv->wdev);
+
+	ret =3D watchdog_init_timeout(&priv->wdev, 0, dev);
+	if (ret)
+		dev_warn(dev, "Specified timeout invalid, using default");
+
+	return devm_watchdog_register_device(dev, &priv->wdev);
+}
+
+static const struct of_device_id rzv2h_wdt_ids[] =3D {
+	{ .compatible =3D "renesas,r9a09g057-wdt", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzv2h_wdt_ids);
+
+static struct platform_driver rzv2h_wdt_driver =3D {
+	.driver =3D {
+		.name =3D "rzv2h_wdt",
+		.of_match_table =3D rzv2h_wdt_ids,
+	},
+	.probe =3D rzv2h_wdt_probe,
+};
+module_platform_driver(rzv2h_wdt_driver);
+MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2H(P) WDT Watchdog Driver");
+MODULE_LICENSE("GPL");
--=20
2.43.0



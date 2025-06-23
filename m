Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1527BC77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:29:19 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.35])
 by mx.groups.io with SMTP id smtpd.web11.16575.1750674558515572310
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:29:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=W1xgXOdg;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6qZi7cmDmYZDITBJeYGM+5SDfhbcJlQN8wp1chV4TBFR8vqtnRPMWiseNtWruD0p0zpweivtF4rs9m+895x8mNV2vxylftfUAvXggThHFQmhyoN13UsFIzrBDl0wsmuR9J8XNxRHnwLrVas/VMLk6Zws+3rGDvhtyRnF7YIw3zAepXRWCceKBP4ynQXj4eZgaAnnlsaSexhkxTciGUrUAwluy79LLWBrstOEi2VWXZZ32ANHNt8Ro5/jCbZQ23LP6lBkDy1mHWjJkFlSEhEzIEEvePEjkw9vrz+Vxtdq0I/qr0jnLwsna0mFQUQpqYU7dZ3APpSEZTjKr90HJzN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw8m0uos8q80xbbNvoyNFl1sGukpGgy3h0/VTjQ2uO8=;
 b=m7BPoU4xtkYg5ne1Llw8bv2KWECHBUyVp6/tWVMjlPmZ4QDyqYtrecbBDkCsxR43B41i9IBlP8dDg8N/fq4s7dSm7auOKKxN/Jq3fSBDNe/9Q1rHPX9wHfV2gaZz8RnJdBE8VGteF60bdo/RAzUzUTLUP3NMsDH6OgCzWQvYD5XqmkF4pL0MpjToP0kpa9T1grxlmxn8r5itetUTJiayoxSL3U8C/oinFv/ilsMlo0SzWEr7RxI1m4hf4rGPPLJhvU5+qYMJiXxBfGPy9Bn69OUigJW1p7xwo2erSVru4Y8D+BeBJ/zLOLzMpO3Exz2+zogcyAtOGOJDCB+DX0hsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw8m0uos8q80xbbNvoyNFl1sGukpGgy3h0/VTjQ2uO8=;
 b=W1xgXOdgKdvP+9gYmLpIIp1s4ZGNi/G8uiXXeEdHYHZpXLzoQOK8jgGCKmeOgslKsaf4NwpfpcwetQdJiQzAGw4vL3KVvfgCqHgn0ueOcu4jQQwDOmvYe7PVtOCVes2e5eQGKUApRkowszl/tnNKwXGl77NclNMfSydeMHWI61U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:29:15 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:29:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 0/7] Add support for RZ/G3E WDT
Date: Mon, 23 Jun 2025 12:28:49 +0200
Message-ID: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS0PR01MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 892adbf3-2f17-4038-c266-08ddb240cd93
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wUKPZfzwWjdUHIaGhlErGKEh1QEsEonCeun1YgeX2hTjT1d3vQ78KiL2VvfT?=
 =?us-ascii?Q?taRMKMa+dGnuioGZe4FNRErDtwmWQv+fezNKlIahToI5NcjwAxiqABYZc1j5?=
 =?us-ascii?Q?d1ENFhqwuMoyjsO4ix7LabRIqbm3rxVSY4Ca+SG+Evxv5Fj22/m/ToBFQ5j5?=
 =?us-ascii?Q?eUDGYuSKU51jXQbABlnPs/bXj409sGO3iypH0EKajr1DP9FFXDUkzljSpOYW?=
 =?us-ascii?Q?PDRi0Ai4SIqwkjwqFGj6dzHecXub5Knjway0oxzLVgA7PhYLJ6FB/1qKQR2L?=
 =?us-ascii?Q?nuYx8UP9KB1po4l4uKnm8XF7LPHD73FKZblLNHwwrWeAHVpX3DoLFRMQ3UFQ?=
 =?us-ascii?Q?f3D75wP8PwHA/+LK8yCTvrYTOOw/FN0fXxsgAmZw7+B02vWlMlb5/vUdNWzX?=
 =?us-ascii?Q?x6Q6u3gGpFowQ0rbY5WO8lyxEigbgA5hB0g8a2VBuCZ274+QLkZeuOmPExS/?=
 =?us-ascii?Q?2zA8OMM6VnXEX/uj04SUg6H/IFNjDeX7WdCPzN7zCo5RTKolCvnVYQVjhYBy?=
 =?us-ascii?Q?jX1XxjlZULNHyhAk97c1E9cf/W3A9FD1LikPT5MQVsTHUtSrtaSBASHJrwZf?=
 =?us-ascii?Q?0R+lmQ/biA/FPdXi5lNaBMh+PGRZVcl3wtdR7poKIf64y6tPi2oGmgeMXNCb?=
 =?us-ascii?Q?PbLSxE1GQ4vjOQ0cNX2ZvcyiMdRWcHjZIVjnhquROxX5SX6E8Di6RO+s8mkL?=
 =?us-ascii?Q?7cjMV7x6FwKvkwMcghTWmECt4Cku0Q/ZYWTu8m0zq7dgu0hJLfaEyI2TRc8M?=
 =?us-ascii?Q?qGKwrw/ROSpbgkcg4gCaooaLNL6g9sOc47Ox4rBTwL1zosvTu3C4WZ2OtoFq?=
 =?us-ascii?Q?Fp2IWyNmTlYvCyQH3Anw6uYAZKjR0/dFejsJVtRkzk4Aw2UQShVxTbMbXevt?=
 =?us-ascii?Q?A9pQ1SiKGjtbMHNRo4CjZpNuYltoTFr3pgm+KqD8rt9hRMPYZ1Qrv0zWWj8V?=
 =?us-ascii?Q?d5HoCbe8n6c58fiXBFhZSvd31BcRqURG+Y9KJip4vU9TTEo0lGDl1xaa3WRf?=
 =?us-ascii?Q?Lv4LpESXQNYYmnDJnVBuI/GNkguKpiUnOwq7Hu5degZMjryfAriTqunfotab?=
 =?us-ascii?Q?2W0YJFyO0HI4anxZ+bArc7rnDg3gwdX2LijUHz/lXb1kGq1VsUn7lsX8ta7d?=
 =?us-ascii?Q?XxkKfujsMaIM5yiuHT+Gx/HWlcpmjuwZnAmQ0tBEdzF1tWP/4fxMI6ZoZ7Mr?=
 =?us-ascii?Q?k5jfBpqIPQfbrmHeZ5klGiihJFkeFTjhh7eK4sK6oSEsoJox9rxc2aZuS86o?=
 =?us-ascii?Q?a25egCuhtEGYFgNbp7kuvqi3jf/40pQA6pAIXVHAxVKVoS88TnK3ylb63vZO?=
 =?us-ascii?Q?S523e1nNgSLE9IsP/gDe6neVHtxMN6SfG6O0cLdwWACtJQJ446YTM2ozRB3y?=
 =?us-ascii?Q?ASKYX+BMvaQxMikwr9St/lPUXTs3rVBarCRTBHPeAPGlhCBWo3pSU6wPQ3vd?=
 =?us-ascii?Q?wbl3J1mucRPtw9Q8YWrOFDuzWH8W21hCmb73iOfLk8j6apkWmi3n+A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L6whRquTKz7/XCPtNExr1SI3hhZBLUbg+5xtDvwKOJp6HKcQU5W8zcIgf8xf?=
 =?us-ascii?Q?kfM/LrIK8+6IHwnw9yw/TFdRbwss8OHGU1405Jqs1yu6kWxyZvhGhBzaMxLt?=
 =?us-ascii?Q?wr8JVm6UKwLxXuuOWHOu0JrzQ8FFmuhizvLPnyACgjXAYwuVUYOjxrVSdzX6?=
 =?us-ascii?Q?Wf73Sd+1HJcInwFGiNBqyiScOP7T2BZPvvaTAoB3t5E7z8fyGrHbd6P8o6+f?=
 =?us-ascii?Q?Rmey32tEhTpkoInsDKoMT8uTJMG93UiXZugrgXxipKzLJtg7dL1301fWXpQN?=
 =?us-ascii?Q?zcrToMYM97jVpYKH1D1X1ExTmON+lcX6gJT+U/QDbPLTGzQaGD/5h2DeTNb3?=
 =?us-ascii?Q?YICgriMQacVZ82kJDsQ7u67zjyJoc+PQzmGb52Z2nNMmyAR9BOhs+PMZiSnf?=
 =?us-ascii?Q?23myr9WJTv0/jItO96dAEGK3bgDvLOF3CEkDEOTCsAoYHhbRzp4pvipXYl/Z?=
 =?us-ascii?Q?0/nrQK5GLLoTUWT8r3hgjG1qlg1m6M7SFYfrAtqISB4O3xoPUXuI/fdTuG4b?=
 =?us-ascii?Q?qoWO6atJQC3pqofxmIc5zPD3INW56jpEF4AGEap83yqcRdycWWMo95X7k0Vz?=
 =?us-ascii?Q?EkPpOJGbU8OzNjh9Y7xF5iL1T1TYqlC0UcrdA6Slc4gjFtu5BoqXxH2ARto9?=
 =?us-ascii?Q?NmoDFuQ7j5Qg0A6u+gkgJTrFdMefG/s1pPONpehLrt517jrz4Y/lAUHZu+FK?=
 =?us-ascii?Q?H1+YoDc6U0qU/pw+3IP1JMvkpNbhhtqpK74e4ry0wpJC/uCr/zhlVKQb46J1?=
 =?us-ascii?Q?asV/YotEwjhAHAyA9sH+uJjHgy94Q/c3iH4F0EjjK7iI/usxclfuWi4zq8MP?=
 =?us-ascii?Q?TK5nVapuBRYjFgkqNyORnzCWgeYc8etNQHWjKC0Ry9oAkqPC3pD6fqFqB6Ju?=
 =?us-ascii?Q?AYjP7H0pJ9BcKhClgg8xboq2rdQMW7A6P0UJLi6mIlEBQzv/FTd+d1kmpeUu?=
 =?us-ascii?Q?MUKmbadZSpuOETg2Bh5/v1dfRV6dYN27W4rSQStag03lHtzXXhusertXXGTx?=
 =?us-ascii?Q?qU9FPpojsZg53D8bBwIka62W/yeLWNK0wAfPshoD5K8c5dGkuj8VxV3DKF5Y?=
 =?us-ascii?Q?cE2KvdoyRuCO4raVjJOu26aeJigdk8Zf/DM7URKCr2zfTgYSeo8OMfcEdCEY?=
 =?us-ascii?Q?iVUm9hLEdf//fUVDCYlqxtnKypKNwrW55m6NheI8X67F4BBX77morcZGkzZU?=
 =?us-ascii?Q?AFm6I9ISGXUyhG7wpK4pBKO2BYJ93DDbQQNcFj+OkqwGqEnz6IBIhIxeA260?=
 =?us-ascii?Q?akJzhqZbZ2N5GEZDyx/Ne3jB/76TPzKq6HUPVkQvkIMfYkNVib5Dekuvg+QL?=
 =?us-ascii?Q?AaVjC+kJCdXbAXCpc50g3cDQHla+Z3WOB8hQUPswrvs0XFyOvU02fizBAKPT?=
 =?us-ascii?Q?JWloKJzSs2o4g2w2J5g7zp/qnbBxjWdCT7/ef35qkxCnIgaHWPzA2d2NFjq2?=
 =?us-ascii?Q?myDukbgZ8mZtjQ3hM0OjodNFGRqatGYfLJg5vxeGYbHiS5dyPVZULQxy+THH?=
 =?us-ascii?Q?46V8TuyWga+A3n1XziCMK5Y6FQSLTpnv8otK6yHEBekLTKQ4chlz+tMsRS8a?=
 =?us-ascii?Q?SbKYW8ZUkhtFvzsYPQl239CZL85Ty4/6ZDjMznumO4UnqNzyADJ1CmWX8KGX?=
 =?us-ascii?Q?M8RqzgYWQt7eVczd/L/BAmg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892adbf3-2f17-4038-c266-08ddb240cd93
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:29:15.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sg6F+f8Kq0q1OCczq1UfPH2tTRRZrId1AyD6tHptJ49ifBorZ90927dgGUKbCd9TBbmrnJiGWznaZR5gV3Rmb4KwUJE6pkFBh9oNncng7QxKMH6Ef6kBzmTkr4/ZbtRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:29:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19174

Hi All,

This patch series aims to add Watchdog Timer (WDT) support for the
Renesas RZ/G3E SoCs.

The RZ/G3E WDT IP is similar to RZ/V2H WDT. WDT0 can be used for CM33 cold
reset, system reset and asserting WDTUDFCM pin where as WDT1 can be used
for CA55 cold reset, system reset and asserting WDTUDFCA pin. Other 2
watchdogs can be used for system reset. So define WDT{1..3} in SoC dtsi.

Thanks & Regards,
Tommaso

Biju Das (5):
  clk: renesas: r9a09g047: Add WDT clocks and resets
  dt-bindings: watchdog: renesas,wdt: Document RZ/G3E support
  watchdog: Enable RZV2HWDT driver depend on ARCH_RENESAS
  arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
  arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog

Lad Prabhakar (2):
  watchdog: rzv2h_wdt: Use local `dev` pointer in probe
  arm64: defconfig: Enable Renesas RZ/V2H(P) Watchdog driver

 .../bindings/watchdog/renesas,wdt.yaml        |  4 +++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 30 +++++++++++++++++++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  4 +++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/clk/renesas/r9a09g047-cpg.c           | 15 ++++++++++
 drivers/watchdog/Kconfig                      |  7 +++--
 drivers/watchdog/rzv2h_wdt.c                  | 16 +++++-----
 7 files changed, 66 insertions(+), 11 deletions(-)

--=20
2.43.0



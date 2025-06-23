Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78685C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:22 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.42])
 by mx.groups.io with SMTP id smtpd.web10.362.1750690038621153973
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=wmTUrhPV;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.42, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9lc5OiUCMAmouwf4aHRzBSWuKVkf1+sU7gbgUVSgSjkcNgUdwMXW5KrRMpiODgsMpMUbCT2YTk4ZzQvGsrWacM/PvOeoNrdmMvbp0gY7hoORAopt5kMAPEvJSRaT+Ad4Ji/ovSjHPWRl7oqJHF0aDqKUq1Bq732yKMwpnxm0la3n9/Gkl6xOlwxBEdf75E4yqO3GJ583qrbx+BA2pzbllIW2WOIown0s2cgAXQMMyw/TPYf1b8CUcvkpVxtJvdO/mZ9ZZM9jx9gsQpfXz45rAJK2tIYeRfoIEecyvJKyfiKhC9x0lKY1EhncZDEb7nU++9QrKqE4SZBJfqbgGYgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RXZYT9q3NdpR/K7p6eCwKRytg++bllbuuaE1Whkwlk=;
 b=vd5tPy7/btUlgMrwPMqS0wSg2gYaZwUZZRGeY8bGUxtC9IyFOqzv+S29I8uq96VnrHOsxxlSfNlBG70opWqWI2+CrsEs9s+XESn9UpmqsQOpiLRjaY7jaw5jNRWoV/ZtMRTBwt1f17jha9ViGNc2Hi+xMZLVwATdWxM9m3jX1S/cfk7hZWxpKrXHaI+h97mjZt2SdFRKvakSVBpaK39dsSvLAxPUDX7D0wXooU0oH9ebJKWW9lgOg0sOrVcBC6Je3shEAeWfp/adlsj7hp7xlXsNw29aJiER1LO5d/LIRNFZpOtBvHBdcffRNALuLgcjCJY2QV/wXeHwqXhRVg+Pmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RXZYT9q3NdpR/K7p6eCwKRytg++bllbuuaE1Whkwlk=;
 b=wmTUrhPV/6klBNulKvVsXeR1ezpW129fq+84QeGZlVqdAWMKgt4EW9l1yxmJhhYCm8eRDy4eWpB+67vt/SFhIIf9LAOhG1ACTXC2mAxHmoyYEa70wu3IPyUoj5lEdna22LimggqZnv7EwNhXjJcMFaE0t0INDnwL1euOrglUywg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:15 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/17] of: base: Add of_get_available_child_by_name()
Date: Mon, 23 Jun 2025 16:46:25 +0200
Message-ID: <20250623144639.2119707-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: db14eec2-6d51-45c7-7f22-08ddb264d807
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Cv0RN8VSa34IXNabyy4SBwy0/jJBKAxRnn3gKhoYTkfImfXTbwyuDPX5xinN?=
 =?us-ascii?Q?w0P64vvCMzA1iOBbDH403St1sFYGE0Imt+ikruXBff4Bh26Mtall+HaXqZXW?=
 =?us-ascii?Q?8W50+kQUdJ1kK4j5HKY866M/5xPtrL2HM604QUnDWlpyhOV9pK6JSJIWeO4c?=
 =?us-ascii?Q?SCSAvuSUyvkiiow5IA/ITjG1AHxQVkBzpuSPeUdV3u4bWEzm4QXnyb1UX5+v?=
 =?us-ascii?Q?fbklyeaSWL6PFA+Fz/Nvc4D4EPruOcPW5SXux7tiy85Ckcb0WgtrHyjyKDT4?=
 =?us-ascii?Q?rG3MaY8/PYIu9RnkJkAkN8jzxHV5y5lZCt31q9JTbqZxrYITByF7XzNDDiAn?=
 =?us-ascii?Q?CsBeenmEvZ2D+Ow1pLYavH4vLXrVDzclgId1cjKuFWQgqBz12pBMMgJMiWNk?=
 =?us-ascii?Q?prccyui8cb7MM93pVR58M1oMBIHGDemDSzV6k+HOEnvillC6CmaiMcll2xn/?=
 =?us-ascii?Q?ohONmJR7C/lxidroZFjL1J+0VxESEN3jcUdeaUak3U0O97GAKOToyqjFON1Q?=
 =?us-ascii?Q?7lp4BeDjs3qpsoqNKWvI2atr/NFFBElSLS2VihHejZU7ArEWPBbci+V+CiRD?=
 =?us-ascii?Q?mjhqt4ytkgQJm7lib14ZSPwHHRaNrOEeJhPmibn+OCNYnvRf6pCNO+oznxsS?=
 =?us-ascii?Q?gl5ihjL5rGAgzbkLZvJTZWpVLpuByOfn0vaQGQfpRfxUamvV0On/MQVfWSaR?=
 =?us-ascii?Q?QTHOwXBmTE8lm0BioAVdarw3WWzHnQ+Sv8yzSc6zQMLDmuSqGDPclMT5EaUS?=
 =?us-ascii?Q?4AyvTzgOpsfhiU8Bzwm/05kUGB0kU+DR8x6At1qUAjYwNVMoO1w5hwsgo9TS?=
 =?us-ascii?Q?pxHVjuFn2JzdFv/2DDDFap9GhDntJkuz1IJ6RK7KWLqztjwYQmPy3PSKUu3p?=
 =?us-ascii?Q?XsyuXhg6GX1wOGxbhv4Iz1oHKzUvOFfqnsFC07b2W+lnqgb6EZ1CCFi87Zdk?=
 =?us-ascii?Q?XSumml9WxtlQ4N4ncfNqECxswDq2EVtg4nKWDTIsNoCpPQyNC653E9VYAox1?=
 =?us-ascii?Q?yBrxo/hOeJ+c1wydAiMTb4Xw5mf9h7RLineCLiG32du5izkXWSgXC4Lrmbdw?=
 =?us-ascii?Q?bxrwMGywOTZ54yYJXop4a8yYh3ore4B/8ZGOHlCu6NBv2L4cZbOTxU62sXMv?=
 =?us-ascii?Q?DrBtXQREeVZGge3m0UqUJmhgo3eeLo3ZF9rpoYFY3ydSJfdDH8hKiLtY5crl?=
 =?us-ascii?Q?2Gpfq+RG0ATgYsfVvkd7ohPuN6wTL55xYVHD3UjUOZfekemYvDuOjXVw/w+R?=
 =?us-ascii?Q?hW+k5RRmyZ/Pp0eEhkUS8dBS4tT7cQXC2fvq0ZuXoxNBjCJAlXw0EBsdycK6?=
 =?us-ascii?Q?QMKEcJkpAX+rPC4GaBlKHY66Et6vcwWde+jj9Sna4f26fL6QCCtg/FA1gqg6?=
 =?us-ascii?Q?lIwQ4XveEFK09N6kxmsRbzWQGSH9jaGz1cD/BcmeVWuVT/yM9qDLo4w7DIVK?=
 =?us-ascii?Q?j1ZgpwetC28zekGXhHgjoKeDrt3+i5D0NtU21QtCNWlvTnABHKESaQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?itnKbo8XGSUXHWG6KMlKONhyFO3NstkDB8kVT8sq7GwDg4k2FLsmX3C5MJTJ?=
 =?us-ascii?Q?TJtSvW/GvcvJ+euKwbDZe+sPOxLuMvOIAAhKboIbPfQ4juwtrDdig43n/pBN?=
 =?us-ascii?Q?/RUgT9UFnZI/dpDxmc9Myxra0onQJ/LlEGlCSYT2LpgF8SQIwk5tD8SDFiSB?=
 =?us-ascii?Q?vUJfutMmNC0X3efnkYUevJgaCBCP/d+s6voylsxwJNFnk7vyuKyeT6oShioE?=
 =?us-ascii?Q?M+zUHkDaWZHEHkIh22V6t64Sh3zFv7cL3VnKEZCa2nKKB2kQUrJ0s1ef1/b+?=
 =?us-ascii?Q?i2+q6MoVusZaOvwBE31zn1AM1TGjrb1LSY8u5W2VOw8BlSNmkXoJckkR2Rgr?=
 =?us-ascii?Q?qiMeKe79kB6cS/lEegN5Ci52hDjgPZCxVf+uGs1otSCXZ+jREeFuxMC0QFbX?=
 =?us-ascii?Q?DTRDHIAlKuD8vkD+VVu5nsOtl0/oSmnjVLA0zCHk564ftBB0FU5f7A2o5P2i?=
 =?us-ascii?Q?KZUmltxGpjgipkDucXDAFitCdHqlCbPPYJ2LU0UzCCahy2CWwOHhFoWnQudt?=
 =?us-ascii?Q?XxKs5G/6UL3AE52PFLl4QeFUO//bEsCbRe9fVxFsLcJ2HLlDcf6FaD7jiTtL?=
 =?us-ascii?Q?kylmQSTBPNQ9ltrmAf0tbCdWYHwbDU+H7Xa2KimX6w4cxW3D4Krr2P5HtOzg?=
 =?us-ascii?Q?v3jHTvNB6CStcAKRxezUTfFa3r8bAuoccisvqQyWJyDEV62vomHc7oc3COzO?=
 =?us-ascii?Q?pKMgaQo6WNVe7wA0QXb0PAL82gyELUpv4cR07DG5Wpsn7MQKQNZGr2yxsprC?=
 =?us-ascii?Q?Xsrwj2d0oz0fOXMF6KLVHWS6vHt80JH7NuoD1YjvMk4I+NV3zFZIcHd3EPdN?=
 =?us-ascii?Q?r9bMdWLVwwEgDPy36QVL2MUuaq+0Zgr1NB4ok6m4DKTzD/pq0Etedcq/IqZk?=
 =?us-ascii?Q?MHugxGXkkHmHfWkQ1wTw7N0KNDS/lHDcl05VdCJnmxzujVE5BWwSSqV4YzqB?=
 =?us-ascii?Q?ZukAHC9F0BGvhZ3GSuFb/Lzkvd4ps+NP9lnUlTaTou+lBO4EH5C34h6YdUkx?=
 =?us-ascii?Q?X+nrzlzRLoTQLhv3MOtuF5zU2TWHUUTCrlW7ttl3AEDxJF68eTMBcnGqVW6T?=
 =?us-ascii?Q?XumpYdskGBkDbCVdBjw5V9lpZdBRrLTmEvIac+mhw66yQkD8eNNQkg1vo7rw?=
 =?us-ascii?Q?KOsLbUrOSr9qYudbx4h4Mua602Zh8Pzw8Qjyg6/QkZIu2/4Qb9HYEH0bZH5J?=
 =?us-ascii?Q?IoWURriTtJdyBmi6SSqHrqdNU7rAwPrvVW0KuWIlnGqGnnaCRh8tVgBangAW?=
 =?us-ascii?Q?EUDLLyW3tVGTeFXWSYW2pWjV6Gm53inu+3jvRpwi6cqK9YKNvabxWGwyGqT3?=
 =?us-ascii?Q?QwOe9G5il78pCqg+5yuGN/G9tDjp8hVyJA1ShFU7EabubxwOEhe/52dA2okq?=
 =?us-ascii?Q?8WAqr4kyblnoFc2Kglcz+qfJAUqa6oAYTmn+1xmGfRkJ7chEShCk9PgAqGh/?=
 =?us-ascii?Q?rvt+r48qF6vDLxfxovBC9Dfwhf5f1wITRSzq59mzqsoVFcsI18/C+hdp8tGq?=
 =?us-ascii?Q?jcromUn2WXEAyakSfRPrI6wz8RfxF0cGQ261v0ZvkZnaYKYrtsoQBNLO5ABo?=
 =?us-ascii?Q?BdatA/W3K/ZxjTdWy7nMuKeR7jeCZ4r78lIWyaEIdfOGUm4WuXgU0lWu+jVL?=
 =?us-ascii?Q?Mc9N9y6tbfAmuH/zFJOlI2g=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db14eec2-6d51-45c7-7f22-08ddb264d807
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:15.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VWyUzLjXj1upPKhAazDhk5nL6gB8LpZrhMOEGYx7nI6gu3a2RlJxFen4t+7u7QYTDy/qY+/Jcwa0tr9ZTdADOwxSYOWNjrdtRED1iBoAMi2nhsheprvWSJyGF0oiXfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19190

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 8d3bbe4355aded32961b9009b31de6d41b7352e9 upstream.

There are lot of drivers using of_get_child_by_name() followed by
of_device_is_available() to find the available child node by name for a
given parent. Provide a helper for these users to simplify the code.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/of/base.c  | 27 +++++++++++++++++++++++++++
 include/linux/of.h |  9 +++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 90c934bb91da..788706579419 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -904,6 +904,33 @@ struct device_node *of_get_child_by_name(const struct =
device_node *node,
 }
 EXPORT_SYMBOL(of_get_child_by_name);
=20
+/**
+ * of_get_available_child_by_name - Find the available child node by name =
for a given parent
+ * @node:	parent node
+ * @name:	child name to look for.
+ *
+ * This function looks for child node for given matching name and checks t=
he
+ * device's availability for use.
+ *
+ * Return: A node pointer if found, with refcount incremented, use
+ * of_node_put() on it when done.
+ * Returns NULL if node is not found.
+ */
+struct device_node *of_get_available_child_by_name(const struct device_nod=
e *node,
+						   const char *name)
+{
+	struct device_node *child;
+
+	child =3D of_get_child_by_name(node, name);
+	if (child && !of_device_is_available(child)) {
+		of_node_put(child);
+		return NULL;
+	}
+
+	return child;
+}
+EXPORT_SYMBOL(of_get_available_child_by_name);
+
 struct device_node *__of_find_node_by_path(struct device_node *parent,
 						const char *path)
 {
diff --git a/include/linux/of.h b/include/linux/of.h
index 2960e609ca05..44e432dbf67f 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -296,6 +296,8 @@ extern struct device_node *of_get_compatible_child(cons=
t struct device_node *par
 					const char *compatible);
 extern struct device_node *of_get_child_by_name(const struct device_node *=
node,
 					const char *name);
+extern struct device_node *of_get_available_child_by_name(const struct dev=
ice_node *node,
+							  const char *name);
=20
 /* cache lookup */
 extern struct device_node *of_find_next_cache_node(const struct device_nod=
e *);
@@ -558,6 +560,13 @@ static inline struct device_node *of_get_child_by_name=
(
 	return NULL;
 }
=20
+static inline struct device_node *of_get_available_child_by_name(
+					const struct device_node *node,
+					const char *name)
+{
+	return NULL;
+}
+
 static inline int of_device_is_compatible(const struct device_node *device=
,
 					  const char *name)
 {
--=20
2.43.0



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C2C7EE33
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:48:52 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.7])
 by mx.groups.io with SMTP id smtpd.web10.419.1750690126843463648
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:48:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pqM1zwTx;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iH2Y7X4bIpZSIODAbbWq8pVy3ah+MjlvpNYNhhiEYzdrIMmKFCgzcfsc+kqdUe0lL2/DTTJzBktLAs2ng/qh/D0TlaXNy77vfnNxsLB6Wuf4J3IYeFYumsHFBZVQQh5dBph1pLoDYJPqUOUOsLjbTHn3COwLSSaHgmpzUaJHNeBYIE6su55ZuRXtfJoLHfhnwRT8CXNgibNJqj1ghq0jcBDR/j1rXLcIExugB7SfSLYLD4J/qwoKszKzAbCXY5qjb1yIM3e2vmL3NmjlNod6GChvKvK83ELRdPoGrO4qrqfan0gQVCK8FM8GRCRixpU0IEKDF0Oq2/TcsklS/IcfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyyp90Dcos1ktK+Scf2Mu1xot9bzf7Iiy30R/5vdJpY=;
 b=t0vvYJ+5FiDkOLo/hWf6mnFn2e68/m4CryMEVJkjqyTvDT7aQ0V4cAeewi/tRfc/m3nCmygWtLS01O4921T/pqv7B/wvHAIFAhzTruYU3mzcNM359zU0MVcsq8rB5p6EuhpCIcFQTNXhaANPBpqZWaX+JbdLO6u+cu6pWEuq0hTbVMY7FCJ/v7nrhB7t7mqXtT77Db/wle5z37iTe4PBdlJCDNYlnT1ETv0EyQtFDcDC64X/+jmx+wnkBt/FRxa3RVQASU2kSKFLqOecgCQFvxU+GnLOLZEgD5Tf3GJFLM6a5kqvm7hJ18woh2aGH4Pun4kpEKuwylRauYNkpKkC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyyp90Dcos1ktK+Scf2Mu1xot9bzf7Iiy30R/5vdJpY=;
 b=pqM1zwTx75k4nCVjpmsI3N6yJ5dDKmhe8AFhosZWUx0gBypiK0BT6xN4E+TcrFxrFh55/B5DVwLBED3LCfy0zwDc1N6ObASl3t2MrM7gu85ZKSNW0kef4QwHDQWxZjODASVqHj1RogbUXs9WIsTFVZusA8h95LshZoM9L/d4sW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:48:44 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:48:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 03/10] of: base: Add of_get_available_child_by_name()
Date: Mon, 23 Jun 2025 16:48:10 +0200
Message-ID: <20250623144817.2119838-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYAPR01MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 7451e434-8b9b-403a-38ae-08ddb2650d97
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Nee4qMwDJh6MmZvDg8EGLXXiGrfB7+V2xeZAOSI+9pvUqMiYEmuk3Z2SWoQ7?=
 =?us-ascii?Q?7LRduKxUjvcOnCBYqvU4SnDplC8QnOO46yDc3UUxd08KFM9V+dN+pMKuv5pl?=
 =?us-ascii?Q?hEOOEsr/i+qwXjFv8uLklG41aABD1LT3SHxMJC7yU1gkZbevhmWn9zWHXwTf?=
 =?us-ascii?Q?mvSjuodUnXJq1xsTkwu0axB7ELJty9bejHKYlxSQI9gJvgwcydJVSZGYYvyc?=
 =?us-ascii?Q?j+z10nt+5DsCuzY8mXP4KQKwa1vpQrWNhBlWQFTtHm96ljqdp1jaGuMz/6Hg?=
 =?us-ascii?Q?8AB12neMOKavhy3SCM+t2OQp79NKSqeoEX8SevN+YPa9FfubNL2CK5y7Qq6F?=
 =?us-ascii?Q?ekGBqgFv9SeX0Fr6jfO/5BA8uaj39z/i79ObML0P1NSXxZfSmhN/6BeGrf+b?=
 =?us-ascii?Q?qvN2CwJf7Oz75ZdEkILl+w85o+SBnIzZaxBx+kpSUEAGhSSHNcdYinvUwl2Y?=
 =?us-ascii?Q?/k//Q9CCPn74UmgCYbMJCAUj6Sz7mUaV9p4hGTr5P5e8SA9SbNHLm57aeAkq?=
 =?us-ascii?Q?KursylXrc+COu3AMW8HhxjiaHe6zIWCgh7fWDxiLJHls2bfkm+EbwFDfRTGa?=
 =?us-ascii?Q?8XBrahvLgh1sCuiVV3OLbRvPZt/05mzTKLTW+px4Zpvt2kIboPAZwRRuhz9Y?=
 =?us-ascii?Q?Oe7u/lATNXB0KwCDW2t30CwHCopaXff7Sp/U8d23wT66l0TS8j+S/V/v8170?=
 =?us-ascii?Q?se9uy0FGOIrb5jLXV1n4AAvjRbNUddrQuAC9wRtAULBdo0h6lLjToCNhsFfS?=
 =?us-ascii?Q?FqsMsqeWYfU71tp0TKVLB+qvofHhYUgCsz0SBhfVEwT5qW/Tgua2AN76U++z?=
 =?us-ascii?Q?DGf/bKj1EimAhJgbyq5rv9R8H2ZhOtMBnDp0iyBwpOZKA6j2lzqbJiEu3Jih?=
 =?us-ascii?Q?rckQJBN3jzpOVR1gWYF2wFTzixWThKmdbiQdqu8jpNMD+M2zPX+mX4ikF6NP?=
 =?us-ascii?Q?51N4jTZwfrc/8rQOVQaNS9QcMpdcNLhXpGsz9FJK1L4tUdY/d9SB0WKAFzhU?=
 =?us-ascii?Q?N1BsIQsEy8Av0xs/NanHoyh8O2xumuljElwPUH20a7K5H71q2RsXG2FHRA4p?=
 =?us-ascii?Q?dzEj8sfX83jhsSbnW9RSzw1jHc9Naca/a6AkMlXqmuZwyHyz8dZUs1LzEtM5?=
 =?us-ascii?Q?Xq/SKsDtTRjQVIftOGsGdWwJE98sVsfmpZs/SozH1hPREqQly4v12r8nibYO?=
 =?us-ascii?Q?RVB2fPrDWQ65ilPTpbEbxY/ERPkC9VjJqxFqFJfAbIgYflg/MAMZdTwoXSNK?=
 =?us-ascii?Q?ZSriJVuDw7nG0aZyUxmxcKx8pultEk37i9TESbAObHUCX291bKEwt3nKTviJ?=
 =?us-ascii?Q?p7KJ94BWJA6cQ8mfr8vPzW9oTJoAmobghpC7XOiCtVGvuHjNWdTQ7xoBVHvK?=
 =?us-ascii?Q?Rsh21POl+GZ4XRqlMBWDVQba7ux4w+GFjrsZK3wnORFz1MRitLtpWwbIWc0/?=
 =?us-ascii?Q?OlSP6oUyxQQLWSUrTBnCesLunYUKGsvvu5BC2xybGPwH6qBI2rOClQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kV8d0ZaW+5O+2HpHbGy06wRWTOFdBBzB/p7Mtoygt0TL+9WZbPAAm37Dx3qt?=
 =?us-ascii?Q?lKAADLpVtpxbFBbBeqz/H98YNvqz1KZDQOmjaixdnuzfvdT8IdB2JixWjHaN?=
 =?us-ascii?Q?xo29bBQMrXr9VsVVjx5p4FGxfZ8/ac2ZrQoBjdqP63G+XNKENgr01+8gmgCo?=
 =?us-ascii?Q?RqHRBPFoa28fz9TKv8bM2TzUm/bKUA9kjJONNHHXLvu60L+01PEPXe843/mv?=
 =?us-ascii?Q?IJlVkmGmAVUgwF0xXxNeW+KDHIlV8VspjIAZGxeBT72r1b4R+dNULOh+TI1Q?=
 =?us-ascii?Q?K30kjtRcTfLNve8H8/intmqqkXCLv+JtAcGouS5Wg6EPjZNUBSoHDxOxBcvp?=
 =?us-ascii?Q?iuqB5/ut3ijyd6RcF1ISJoFxFkA9qmKma5SgSlo+f7AGZliLdU6JPxaFL2O/?=
 =?us-ascii?Q?GVAI5H0GZpvu7PxcQmuTz4GATv92mXkLEAY3PyEZ/e5eyvPPP3IL6BLoHyur?=
 =?us-ascii?Q?jC22nUiRR5rgHKBPcy6iri1pGn5NpM6BCaqGaWrqnhBTtPxQ8cIcunoj13oE?=
 =?us-ascii?Q?ldQx9nBdXgQ1LWrQ8RSs/kJLw7bY+7fzBX2W8Sc+8BVogE6J/CULg9+pbWmJ?=
 =?us-ascii?Q?5Or/Lyy8r13ESZkE0Ge+MPUvCWpnehFNH4s+ePHfC577kJak708GJSlCOqGv?=
 =?us-ascii?Q?2Cib+Vd4buq+MQTmhrTomqkvE1O1MhWsFjvrFZPx8xJW/Y5VlRPr5pZ+ekzq?=
 =?us-ascii?Q?J0b49535lBG73xpbOuHDYQuJXkA081+0B6DIB7cehxg8WUxOx4Rq121jdgP+?=
 =?us-ascii?Q?+AHxTOKWgzpkwOMqzdV4eNkJ7plbLBkPmkhMh4r7iwwAcq1Ok0E7adFl/ZF8?=
 =?us-ascii?Q?mufv/ZRMGHY0Hg/DFZbBSdQqdddkUlVYa7x+BkSXTHFzvuQR4ZyIEPJIU6yo?=
 =?us-ascii?Q?69L5WYUIi2iborBNVOrHj8YlOsJqNCVM1dtU3ciW+LotI6rPf0l2d7/wiA09?=
 =?us-ascii?Q?xsWngo5Ju+mD34O4k1HQJb+odXldUdZsJKZz6gZmee30buCyynBPTWHmQp/7?=
 =?us-ascii?Q?TedUAUCfqQRHbaKOr8sPbTBB6DHr1OjBwdFVb7tq/yNZoJmVxTJpUPa7aSCK?=
 =?us-ascii?Q?1YZlMtEGHsZA2/yc3EDUaaI7tSKgeqaqpDFy5JPJAbbexH0we6zbEYy350+A?=
 =?us-ascii?Q?3qnpga1X4eQhns4wHB7xL2ncdMAu+j4qFjH2ryaPhylioMfVo4/+wivcLMWO?=
 =?us-ascii?Q?g0q8FEHVp+FJomUnMAhH7Xvrk2m+x0VxBjRGHRUxYDRIpREVZHf9mX+jKVSX?=
 =?us-ascii?Q?+WD4OcLMkSelow6ZfgavWLGQQ/euuzpseVr0Otk/XleovDWPHjuGy/hJmK6h?=
 =?us-ascii?Q?+Rzqjh69CzyWQ8SyOP8DNwLSkVAhYivZw9JKfULb4hPbpKuaTkPF1U2vnH/R?=
 =?us-ascii?Q?LPe95/i/tjrb1kk6pub7b54HHmR7AoL6YWtL6WYHMCBMWUfGD1dsUoJziHCX?=
 =?us-ascii?Q?/U77xozAbTEPXeiXCSHjKXpIvU/kTiKxCa1h7q96e54OMhiiIm46PAjVF8Bh?=
 =?us-ascii?Q?6FsAa4LjZabavAEHWAJBiTKMK3zOxPtTGk63A64iK1I1dlU1QUyPoXAnkdrO?=
 =?us-ascii?Q?A1JOtI5uIPJzYASff7lrX3y4BI3thPTZdfvCm0BNSkzuJ0cE6KRo7JLZXzk4?=
 =?us-ascii?Q?lD4MiD4oL4k77wb57iFkZ4Q=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7451e434-8b9b-403a-38ae-08ddb2650d97
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:48:44.8765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVbPEGXs8voRlP+/dCoHNMTKZEjEEz5eZOSjgp1QmVAXKifOm67scLywb8j2nEGzU0IbP3H6XstQ8pWQRj/XI7G/b6hnTRnNutKTxkS8NcJwa3p97Ari7PbD57mYAixC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:48:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19208

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
index 4bb87e0cbaf1..c2ecd77325a3 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -771,6 +771,33 @@ struct device_node *of_get_child_by_name(const struct =
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
index 85b60ac9eec5..4232d1c43929 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -298,6 +298,8 @@ extern struct device_node *of_get_compatible_child(cons=
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
@@ -575,6 +577,13 @@ static inline struct device_node *of_get_child_by_name=
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



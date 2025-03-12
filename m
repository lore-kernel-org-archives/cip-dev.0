Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3FC36005
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:16 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.19])
 by mx.groups.io with SMTP id smtpd.web11.34839.1741778768213849637
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Q2llkKDJ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.19, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxIR1sE/BQoyWb0ONONVurayCZEUl0YgYK9Z7ehWLTPKI5khRYHQes3hxzFJcMJpGN0L3a+gWVdrkhFguctqty5Bhh1d4dnffBNrV3MW3nRB3AIO/JGA/w3bmPHs3tJkBLvITbbjC7TG+CUjpMRF03egOm2DGiHhwnAgXzzy3zXHwn2OGYuwLtgSg6TjNLv5Uu8zaCnCqBM2nRF+UHr7rPpgyLudd/S3nvJJSkT7TVMIwTNVl75vOoSxgZu6qH994FEIDWb63jkp+4dukc/t3ty5cODEN6G/xkfMy6eObj9YPKRQTzKyZcg/0FN3yTjyRnv9JzxeFEfrcmXrfUmmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8+BR6D3PusjuevDT7M5/e82aeSKagozfeSYZxqut4s=;
 b=pPDcY/yMzURh6/e9rBAuQ6ZnKJvfq4MROunzSoyyAe3Gt1YojicW3l2stRgK75Im4ClKrDQx6f/7h8wR9x8Jt7O3ZpzwzNgGboOWtYRSBkWOAZUe2kDydvNBCFBh1Xq1xDdTispdBpVDLKKBBNeskNgl5mi9Hph/KGLoXc2ens7+kYG/aj5K7ehGg/s+NzIz49p+pUE5+LB/YRKHsn3YZfiFkej0Y/cor73ZT3p/k+NmIaLPUr7JyCWY9OdZ0YO8JYwcuJMBFFQR8CTA8e3lAX1obQZ5LbeOGR0/HbiuRs4D0EvypGR+FE6RN/XYOLdAo+jvOZ0f1dT9FhbJexcU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8+BR6D3PusjuevDT7M5/e82aeSKagozfeSYZxqut4s=;
 b=Q2llkKDJQoL10WIBIYGpOkEPhHvBJQn1INxjFwcSPqCQJX1vGOWIi5otUnwQ+LnqQh6R5eqsF8NES6h7dsUtAyiSOQUF1dB/M44TqITkV491aHS2gXMLfYY11EYZSphdrhmGgpf5FVt7fDSR4Zq0uaqgL2lvJCr14nlV0XWXhIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:06 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 51/85] mm/util: Introduce kmemdup_array()
Date: Wed, 12 Mar 2025 12:22:28 +0100
Message-ID: <20250312112302.1605750-52-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: afc44066-e062-41f3-50cc-08dd6158ae08
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6WUnelkdURo3KEgb7d2Tb+eRYz6i5nPK1/KyjibVTvyegC6U8cp0SeotEKG3?=
 =?us-ascii?Q?hmPL0mo+Zud1JR6pqPnmxWQbNQ15MusHrMj9zS5zcecieXuDMpevIKzNVz9x?=
 =?us-ascii?Q?X3isNnG8+nh9A9KDcYvt4bNBhc9LY8cRftCJD3UOaQ8+oWQnLtmQppAtVSP8?=
 =?us-ascii?Q?muVpozjuA6sapYBoQLejEXDuUdCZdpR27NqL2rFE8ApHPA66kGFPOTmVucvk?=
 =?us-ascii?Q?FMZeFcLKDLIIO22q8JtB6Nc7zbuh+sqXs2ahYrgrkpQJ2dTkCaTXxn4xHE9t?=
 =?us-ascii?Q?l4vnnUFh6FltqI6WJLHWHg5+lu1mcyY6LnZfPPbqPfaHMCGbNW+CstCm9oB8?=
 =?us-ascii?Q?PaDw53p469pKoEYZ+diYsMSuc7H0WIzH7x1VX61wDpXx08S8ot/8nYcVucj/?=
 =?us-ascii?Q?8p97g/Q4UIftvAJBWds5mY96KtvNIjCTI/X1HSO6QwZU0cqCZGU+tJelivl9?=
 =?us-ascii?Q?IfZPV3yjyzxuG9jDXbMTXvrz6BUiZkTyV4r3LK5Wc0jou7NsP7mPTEevbyk+?=
 =?us-ascii?Q?Vq58SC79VfZPD0Q2rD9g1vjDtwOQSew2wRj6Vlm/Dgi0sjcGhfLRX7L3jVO5?=
 =?us-ascii?Q?hodPMYGAZEajPJEK6WrVs//LFqpgLclrzj6C6V5xDDyyC588juggAkur8xTt?=
 =?us-ascii?Q?B4E+BDS4i2SC6SbPQ3Tbe9/wT9eR/jOAFB7Y7Vekid7GDTR8RETcCNBvnvcn?=
 =?us-ascii?Q?OIwzZHykEKXFHBpJOOVrhxhmtEuKTSjqRL4+zWc8Ey1x0w6BkLdu8B8jyqqP?=
 =?us-ascii?Q?uxecmof6B5aHQt5+Brjp83900Jui3dAqY1TjFHybrG0+zmxZxZB8RS6/iv6H?=
 =?us-ascii?Q?GLtZMZxfFDBV3BZqpKsCWSLaaKpRAk7LOnziAuvDj8BVrMo2m3ci6keYTzMN?=
 =?us-ascii?Q?VFyz2vXMSfD0+oMRG1+T8G54IPiQW5WKZe71WuTtylCHUmOecBA4iOyJnPtp?=
 =?us-ascii?Q?xCK6DzP/Ha6oGeHQSoUIf37QWSBtVsTifaImhWFB6Z7G7gV2tr04QK4rXP8F?=
 =?us-ascii?Q?BKxs3qWxvopPVzW9K/C6Wv7k3nCYQA5QlBVcfmfTHJyQ5sGWwMk3D6Lg0cyP?=
 =?us-ascii?Q?5acYR9l2vLMvpjjBMUsB61wriy8z7Gr4Vc6IyWMnAROZ1B3roCG3UVh4n6Io?=
 =?us-ascii?Q?EAPcOYZhjRR1N6bQDOEp0AzxQQk59LwzRX/cMPQ5Xb7r+ox+eOTehnsbyl9/?=
 =?us-ascii?Q?pf4gem47cfIMdGViGlSGTVCuRFY5TI0aWuPA6YUTGlEhlFgR3r7EHSnqKfF4?=
 =?us-ascii?Q?GwVb9JRcVQE55dnPvNLsyuYgd8/J/i6AQuTNJMNbEYgtssbFcsCrEdCgzqGb?=
 =?us-ascii?Q?HnWk+SDnMyVZS+jDHlKobuCJwqQYJcLjzcQXpDkCFSyAmz5tKwZ843vxoUBm?=
 =?us-ascii?Q?GJgU1gs5KUyr8n88o7k/5jSfxzbIE7UJn8bH5lzVVrJiQOijMjg490sngDZP?=
 =?us-ascii?Q?Dh0/8pt1paWHjomupfhpm9xw2iyO9HTE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4R26vjNEHiIZZZHNJC22Z0T5/hSUZQCqb7jYhcwn9Q6kuEHnduGUYLWzvbu7?=
 =?us-ascii?Q?7IH95J2OmDBeajj5pG26LwieNOyu8nPXYxubv7ircxyRj0E+AbfimSp+Ck5w?=
 =?us-ascii?Q?lfGuL5xbxPJDbLkcVxgYgHxcKZ60phscnA87FU6O4atYmnNa5W3TbdJkZsqO?=
 =?us-ascii?Q?WQsM4x/PimPgHZSIYz/ev8N5hyCbgcSVUHZI0/14xtM7F4dmdK2zWskuq10E?=
 =?us-ascii?Q?jEhHanzZ9ZEwwtFRvtnFdhXsP72g+/VnDsLdTeCtxiot8dGphnkgnFCRzUZm?=
 =?us-ascii?Q?tczeOrxnclU/sEUzY306VY/Tcb03fr2X5Y3OwDNLS5tCteSQJATpdOtxODcR?=
 =?us-ascii?Q?iv8aNH7l1fENDneQq3ai371vlQSs67TzGINCnP9WGjDViKUWSGgkhRObTce6?=
 =?us-ascii?Q?dvXhwJKGlJzx00fo5FsACcVslNGoQTd79ETYj5mvCFHbjwKhKXYfR3HLNsKj?=
 =?us-ascii?Q?qykrD20iXP8uqOHvf7oTDzw8jrN4LSlm+nMFX/iVz00w5WaKpIwI2FIJx4l7?=
 =?us-ascii?Q?UsCOOB82PoTvFb66YgQKxMNH4lUtMDEVbwY82Qmdxv3gkB+8WDa4XtkrKQmG?=
 =?us-ascii?Q?Umw7c1pvjeDuVb5EWngX0q1+/hbHpKjlkIghHHbb1c4kV/PQjECvfVXx6Jbf?=
 =?us-ascii?Q?faGcUjqltuqdvxW045iyegCxv2ePkZzVzr5fluHULgvdzebGCn0YBW5PG4eP?=
 =?us-ascii?Q?+D/V4vqg8c5c8PjWhIMT5/fZ1K1XdArwUxNaKE2in6eBZHrEaMfR/MeARCg7?=
 =?us-ascii?Q?rGlvXXlEXeL+2xaiO8hctAZqc5rBuiSq6N3n4VSFvfStC0KdD/RKHd9INkVv?=
 =?us-ascii?Q?LxlGzI4rLMbdnERVkze9fkFIZptq+AjECKRRyYxgDo8xcj2AG2fQhPQOD++9?=
 =?us-ascii?Q?7ErH3lhMTGW+Vd0gq/RZpQ8OK2Ol4+GDDCJyDyDG8VWM5h5tgGwoAzvgJmJW?=
 =?us-ascii?Q?lOl1o4Qf7nIXoAPc2wmexwajOcH+5aUnDyqw+Z15XjR2z9mmir9SN9aoArOR?=
 =?us-ascii?Q?Tprnrc4npDMpe8jf62F8E+nsNW7S8+yg1IFtgMjsIq4twJd3Q8wexl9JspEB?=
 =?us-ascii?Q?CqYiYWOAZNuMlQhRBCIi59DLrPaHRLaIM0pFgavriYUWE319cYRV5/isBFRY?=
 =?us-ascii?Q?KFmnyse0DyhlSPQmFQZtyiNCCI5VMad4NWABBUE50REjeOZN35M+TApW7tRU?=
 =?us-ascii?Q?MQafdWh10i6uF9tQCN6sUQGF6saXH3YklZmHdf250vb85BiStgz0DpjDADdV?=
 =?us-ascii?Q?5w8ae2xszZnTfjHRyCjT5+rQurnJ/J/W+SuKnKhjF0bY/G71JPy5jGtjkNY9?=
 =?us-ascii?Q?BNt0Y8eclaiHizvgV6Xs8P0fx0yDGWhr9HPDfRuQTnDOpNQvja6wybTRkKRj?=
 =?us-ascii?Q?wTU7gQDWA2Q2itLlbKgYX9sUriv5k1x/sFDN+Iqj38OduyX2Syq7dEXVBelZ?=
 =?us-ascii?Q?Mfe+aff7pNBbCBJbqSa8mSusRKgp9QfzHX9T1yidfbFmj94pvR5ign2wHdBQ?=
 =?us-ascii?Q?3ezugi+qbeTmUvk7N0k8IC+hZzSBoJPurcz/j5+XJL/ttZSAtoCYDZTXdZoE?=
 =?us-ascii?Q?X7osL7ohVzlcC4fC7S0NTGfAjvPtYNkdQesw2lmr9dG1B2AOVUBuLmKZmAhA?=
 =?us-ascii?Q?VLuwK3TDzFpCtqDRLjQM4Mg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc44066-e062-41f3-50cc-08dd6158ae08
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:06.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFPaGvySqu9jTd39W9ic09EORUNj3GC519A0+Gw8bohhKWVnaE16e3+qMsVTJSi+bCib8/FzkCRyBLLIeV9wnu6ZrtilyC5OIIi4qUcR2yO3f4SyP2XcFWpnjXzofmZX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18143

From: Kartik <kkartik@nvidia.com>

commit 7092e9b3bed1252c7d3f5812b9fb9d82375b73a6 upstream.

Introduce kmemdup_array() API to duplicate `n` number of elements
from a given array. This internally uses kmemdup to allocate and duplicate
the `src` array.

Signed-off-by: Kartik <kkartik@nvidia.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/string.h |  1 +
 mm/util.c              | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 422606e98cc4..066203187c8d 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -218,6 +218,7 @@ extern const char *kstrdup_const(const char *s, gfp_t g=
fp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
+extern void *kmemdup_array(const void *src, size_t element_size, size_t co=
unt, gfp_t gfp);
=20
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
diff --git a/mm/util.c b/mm/util.c
index d3a2877c176f..770803ece795 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -133,6 +133,23 @@ void *kmemdup(const void *src, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup);
=20
+/**
+ * kmemdup_array - duplicate a given array.
+ *
+ * @src: array to duplicate.
+ * @element_size: size of each element of array.
+ * @count: number of elements to duplicate from array.
+ * @gfp: GFP mask to use.
+ *
+ * Return: duplicated array of @src or %NULL in case of error,
+ * result is physically contiguous. Use kfree() to free.
+ */
+void *kmemdup_array(const void *src, size_t element_size, size_t count, gf=
p_t gfp)
+{
+	return kmemdup(src, size_mul(element_size, count), gfp);
+}
+EXPORT_SYMBOL(kmemdup_array);
+
 /**
  * kmemdup_nul - Create a NUL-terminated string from unterminated data
  * @s: The data to stringify
--=20
2.43.0



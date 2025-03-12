Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B423C35FF1
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.54])
 by mx.groups.io with SMTP id smtpd.web11.34783.1741778641190208736
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lTpGQBkp;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv73Hb7xsJZS4Serk2iDO/t2NQ7efOLlJHRbCxz8gHOAyuAHAAmTatjtdWnKj9t0Fc0YxqYntl0rZjuCFj/LE//7PHpA3xXPUSAXexS6ZSMFtrDlBmOjOB3/62YYMUFI+11jH+daEG3yWgyM9D/4GTRrSMjHXerz2+yrJn0yzYwcymKBn3jmLZN5CXVh6njH6af901BVvhnnmHfVUVzkne+xKj3jLfZ7JS7ZXOd2CLBdq3/emmfnlubAuN8ROaudWgdwpW77tRHWOdfve8YwEt1smSn+YatjzR8xu3L08ixp7THqUPqNoTG40hGQqLve2wxWArxey88fZPDFYZt34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbXfSAVyWuar7ER5PGbBpOAJn0ElbtloYu5C4OAoIDE=;
 b=Hz++/GN9RD0g04PudKfvge0NBTIK19AyLeHYVzID47shSVbooEgDa+S4Gg+3/EM+JNY1bVMYcD39ZMrmx4EgF2YXvpcBayHg1KaYD0VevzNpPv5s8PFeW234NeZVfKMnF5MpfTqEbMEkeBg32nPuoxCcBSfBXLPasVqarSNDuHEJC0LulDNZ2zKb3GdZ3dkOO6If3rO61Yh+DSzBat2Jpb6Wt6DLvTUFVavrbGg/N/CBLnbF7/NOsZ00gAhDsJ9jrXXiGl2QNnzWm8xEWeqZqyN2kJVSIayVKYAMJOmjsNz/JY6JmJblBX7/0NGtzZV/T5uroDTPe3v/o5mg3896Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbXfSAVyWuar7ER5PGbBpOAJn0ElbtloYu5C4OAoIDE=;
 b=lTpGQBkpff4ORV/SzVl6mB8xnrm2CeVhJIDq37RQZxcmQpNbhrMyhdp+tqQOFY51PEP/5aCwLjURuNN9v3J98NBHJiRam3cKmyNmAhF7BVtn1z2i56UKkiGJ1hum2UG6TvMzSLNKZj9hn792b4+5BK+zAmDbpcRV7DTMHhHlkVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:00 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/85] clk: renesas: rzv2h: Add selective Runtime PM support for clocks
Date: Wed, 12 Mar 2025 12:21:45 +0100
Message-ID: <20250312112302.1605750-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 222c71d8-39fe-4d56-333e-08dd6158631b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?a1CvzRhgKwehXM0/uyzo+Vo2S6EYgoMhLfXIMA7X5+tpyPsSofGo+jy/e/X8?=
 =?us-ascii?Q?n7BmUmvEqnx7RaK9uXerOf15HBu95lkQTlAN2HAVXxJ6Ar9npMbxmBj7FGf3?=
 =?us-ascii?Q?hv7e9K/tUd5i6n17EcGTftD5JtH6A0pzRR6upimEXNc0pl1a4iaDs0nltv6t?=
 =?us-ascii?Q?G/qpqmUBr/t0mu3zZS6xT3Lav1YczTX5nwWkeJb7AIHW7xUXs+ez0Htm/W1q?=
 =?us-ascii?Q?BhuXEE6lhZVtxxvg0rbzZqEfQGeCIc99Hnlazun4uoqibrNuph13cYxkSsB2?=
 =?us-ascii?Q?u1KsTMfr80XmTSVaMMg/YNnKtxoeQjeuf1DP4FRjPb7XSJW8IiY22cWkial9?=
 =?us-ascii?Q?uWhZHM0+0OiKpP0xJXdnVHQgjt7j7qMUdQcus501kWHtFwTtSgXscq5UXrTo?=
 =?us-ascii?Q?t1XJVsYACy4RyNsV/htC6PC4GJy1rayMjN7pXAlG9EBpQV4DiPkAzK8TkqcJ?=
 =?us-ascii?Q?9Wjd2b+1hxzr65+z7/2357sAnN1tYCm/XWzYp4CVHQSd6PH/LE9BAsXuTJtV?=
 =?us-ascii?Q?6n8yCuUkwp2lcyBd2sPf4P87kLc5m+THkiZ2BZG3xlyGgDM5G0GUySXxj9Dj?=
 =?us-ascii?Q?h3/NlywatkY4nIf+0ytzCAgdVfbhjfUkiQ86hc5T5/7cXxU37KhRElD/Je97?=
 =?us-ascii?Q?9tHtL6sd3YNuTGhB+saqHD82l3cLOoMpRYcfpsHR/sKqV2dnW1b8YgS77rwP?=
 =?us-ascii?Q?Irio/65QY1g6IfKm1BKFAMqrj323UhOgtQKKQXkBAHq2zNW3oPHerDQzg9Oh?=
 =?us-ascii?Q?k2a1G2u58odGqSTiWMHBVg1zqZsEa8pbbc8CJpxJ3pkdkpS+NHGWlHh7Uczd?=
 =?us-ascii?Q?I+nPUneGrcF0iPHS6BCPlpca5AtaKvn9XCnpJ17YXxYhFjVxCfDo1yKZL7Vm?=
 =?us-ascii?Q?+0BUwKkw5faBpoowpq1M7iwXJTVAmT//DYanFbDx4I9yUj/YY3eC5l5EYZCe?=
 =?us-ascii?Q?+xAUCkeAMHvAs0GnOIJAMJtPaTtwMQ3I7fjI3oxTvvgPv8f0Pn2jG9QOwRck?=
 =?us-ascii?Q?GuCJOuZoDXoJqOEEob9KjPUIH/D/Oe41l2TxoUBBK+RUfB0fl+iZrq18mMav?=
 =?us-ascii?Q?zmxmDE8E1PmvWem4JgpUVqOcnEsEYxwQn1xjHMYMrZnl+kPXnJlFd0orWcr/?=
 =?us-ascii?Q?Sng4QUoLZud2z/PQy8ufRp6/ipUqihztKn8LGtuQGPF//m9xHbfzOkCvMy6s?=
 =?us-ascii?Q?jEgynN1I0RdW1S7q7cB8cGDE5lhoVuUf3Dpz7LsoheM6c6PwgRcPAg+aL4RT?=
 =?us-ascii?Q?+sND3ZQCcqoHq7y4S9aEI2gEc7EYYc6/uWodlbno/zFRmrvARm5MuUnSnF5D?=
 =?us-ascii?Q?ex3Uf6COnD62fUpbZ14Gt+RndEEsGtggyhqgcuNhr/M9vrkwIFkN2I7oAG71?=
 =?us-ascii?Q?MTDJf1RdD9yOF7hE4qwiIuVdGoAx8q2f8CybxYCX4HNvWrq4A8bHO7kfwLwZ?=
 =?us-ascii?Q?0RD/j6CB37u1lBJfdttZSwTHnoYfnAfS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QPGF62Owy2SODNOeLNgp0UIOf3N7o8g/mV2s9ZNtwgJCbVOYHiGLelOUD3xp?=
 =?us-ascii?Q?BsscBXxWVF7WvpL3c32IACMJiub29OSEZTRVzkI9xT3qlZzCA74NG67/aIUS?=
 =?us-ascii?Q?zqf5tqCE8tY12hh+NhXZX0DEPzjuIulpQj56ipAXYJ1caGqz1+1BTdmzqnLY?=
 =?us-ascii?Q?4Xgnh6KnOwN0RhRGApOWteHci2lUxKwqNyTtxutNYuMf+TLfPh1XpQDVuTWh?=
 =?us-ascii?Q?3xwBP7BWrklzM4462BGIRxn7uUGM7TEpvBKy7k8qgPEsdm6yWwtF1hqSpgAQ?=
 =?us-ascii?Q?JAqMtJc7ig9gpiq1cC59CJiBlQ4QHxoSgvht5XrZwyrLX5z33McyPcmlpG43?=
 =?us-ascii?Q?+4vjaMrnRq5weLD8ylQycVpcztyudQGvX/SUV6dlD3bWDVGnce4p9bT9aP6t?=
 =?us-ascii?Q?xW9NWwqu/sKmf8eEpIJ22Ov714jgEYLpg4+fOobQILZAaEcBCGcDkUQSiKi7?=
 =?us-ascii?Q?jmOmLtd4EIFTjJDB3AKizh4xLNpWPkXpDAeuNHZLZOiq1D+/l1kS8Zey9wwa?=
 =?us-ascii?Q?sQMzk68AciJEdJqiFl7DlEjKaufVlZMuU30r9BIJMoI67G0DvF908vrxpqnI?=
 =?us-ascii?Q?hYI1yGqPG2tDnghWWlyImYHgPFambRZv6Naov7ClwiWewgfZybKf2DgkIWoH?=
 =?us-ascii?Q?BZUxBx20joPLsJ7ZpBcsMgJxZk55+HyexyIXGay6WluqEEN11FfLQzkSkUfm?=
 =?us-ascii?Q?H5xrN/CIbCbLfM7NGwtfT5WjlLXqXL6SWABiv0EtoEcnWxN4jo1i4brusaJD?=
 =?us-ascii?Q?J++OJFEm8ge2Qf0uVS6l49VAGmLOrqfJCZG7yJCSwd9Qnj38FjZrYuYJO2qj?=
 =?us-ascii?Q?kpUgs3thTImdJBDM1a9noGZPEHi7GcvCf7A8Hwt4aOQ3vJiPQfjGQTbN+tBf?=
 =?us-ascii?Q?MKhCdQvFxR7aXL1KWQcvZqd9ApcAc0xarm7bLmr4Ps8ea2agA66xeAZxZvYZ?=
 =?us-ascii?Q?vuqn/0h5ieKCKiiK6/0H8cHpu8FS1rmLWabRO+mTr9aNTQXuIEMtlYaUdeda?=
 =?us-ascii?Q?lWAjJlkUGAOrCSnoPKFijrxtmeUf12kq2MM8Ji0nLKiK3S/+VeNyVH93WGDF?=
 =?us-ascii?Q?MiWImq7ccsqko/+4jmNDCp2afrmU41Y3HuMRIczpK6rk7SAoqFOiXUeTVBj+?=
 =?us-ascii?Q?RPv/UPEEgvhch31t8EU8/5CNIML/o3cDHRNFJ8J/H6zjflGclCmORjKefKdk?=
 =?us-ascii?Q?kVLGlbglBp7IcmvL/iGyIuloN+fklEc42oO1M/PKBTfrWCiGcygAU8H30Bcq?=
 =?us-ascii?Q?x5QuoaPaDp/NJjPnb4wEAjky6/R2ZheeU7v0UAVdILqBfswXHmnsYQW5xTqX?=
 =?us-ascii?Q?ao0N0ux3sehd/LN++Fhb2UplSDHLW7DoiZZGDLs9lvTgSMjdPGFcd8aNVS12?=
 =?us-ascii?Q?I2M4BpBj54tufQDR4YzquyfYriaaOIfCyjBh74FJCLE6cL8I/eB6LWXIvXNF?=
 =?us-ascii?Q?/cZU+ZNABbCKuxCnTmtSr2qFyRdhh71kNJnsq+hjq1xcTg0bz+11TvUxqSQ/?=
 =?us-ascii?Q?3oliVVrZiyIDES5Ywaf2S3AFvcJffX4WMUGgw0FnMzXq4KQA8fG33wOz/cpc?=
 =?us-ascii?Q?DOnhsaOIdtl1hcydZnTbmBDIFx172GFNEWhAq8RfmnqLVoCwwOtZph/EiKVN?=
 =?us-ascii?Q?/KNSLN3aLPeeAeQMwV3TiPk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222c71d8-39fe-4d56-333e-08dd6158631b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:00.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/tk48AKw0K6SZueUUmYtqcZFWetbVE5CpWhfrv9SxPceQeuDFZeCEtp8E16y+WzJ8CqWwbn1c1iMIQE9j1fvRDHphuiB9xGmMoyjRcrh1u3FZ5FF6ak3PwGIeBC6fw1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18100

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 03108a2614ecab46af6e0d66f9fd61c0d80587f2 upstream.

Update `rzv2h_cpg_attach_dev` to prevent external and core clocks not tied
to the power domain from being managed by Runtime PM. This ensures that
only clocks originating from the domain are controlled, thereby avoiding
unintended handling of external and core clocks.

Additionally, introduce a `no_pm` flag in `mod_clock` and `rzv2h_mod_clk`
structures to exclude specific clocks from Runtime PM when needed. Some
clocks, such as those in the CRU block, require unique enable/disable
sequences that are incompatible with standard Runtime PM. For example,
the CSI-2 D-PHY clock initialization requires toggling individual clocks,
making Runtime PM unsuitable.

The helper function `rzv2h_cpg_is_pm_clk()` checks whether a clock should
be managed by Runtime PM based on this `no_pm` flag. New macros, such as
`DEF_MOD_NO_PM`, allow straightforward declaration of clocks that bypass
PM.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241202203916.48668-2-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/rzv2h-cpg.c | 44 ++++++++++++++++++++++++++++++---
 drivers/clk/renesas/rzv2h-cpg.h | 12 ++++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index 9fa00f5c1237..bbf0b4ee7b26 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -98,6 +98,7 @@ struct pll_clk {
  *
  * @priv: CPG private data
  * @hw: handle between common and hardware-specific interfaces
+ * @no_pm: flag to indicate PM is not supported
  * @on_index: register offset
  * @on_bit: ON/MON bit
  * @mon_index: monitor register offset
@@ -106,6 +107,7 @@ struct pll_clk {
 struct mod_clock {
 	struct rzv2h_cpg_priv *priv;
 	struct clk_hw hw;
+	bool no_pm;
 	u8 on_index;
 	u8 on_bit;
 	s8 mon_index;
@@ -541,6 +543,7 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *=
mod,
 	clock->on_bit =3D mod->on_bit;
 	clock->mon_index =3D mod->mon_index;
 	clock->mon_bit =3D mod->mon_bit;
+	clock->no_pm =3D mod->no_pm;
 	clock->priv =3D priv;
 	clock->hw.init =3D &init;
=20
@@ -668,17 +671,51 @@ struct rzv2h_cpg_pd {
 	struct generic_pm_domain genpd;
 };
=20
+static bool rzv2h_cpg_is_pm_clk(struct rzv2h_cpg_pd *pd,
+				const struct of_phandle_args *clkspec)
+{
+	if (clkspec->np !=3D pd->genpd.dev.of_node || clkspec->args_count !=3D 2)
+		return false;
+
+	switch (clkspec->args[0]) {
+	case CPG_MOD: {
+		struct rzv2h_cpg_priv *priv =3D pd->priv;
+		unsigned int id =3D clkspec->args[1];
+		struct mod_clock *clock;
+
+		if (id >=3D priv->num_mod_clks)
+			return false;
+
+		if (priv->clks[priv->num_core_clks + id] =3D=3D ERR_PTR(-ENOENT))
+			return false;
+
+		clock =3D to_mod_clock(__clk_get_hw(priv->clks[priv->num_core_clks + id]=
));
+
+		return !clock->no_pm;
+	}
+
+	case CPG_CORE:
+	default:
+		return false;
+	}
+}
+
 static int rzv2h_cpg_attach_dev(struct generic_pm_domain *domain, struct d=
evice *dev)
 {
+	struct rzv2h_cpg_pd *pd =3D container_of(domain, struct rzv2h_cpg_pd, gen=
pd);
 	struct device_node *np =3D dev->of_node;
 	struct of_phandle_args clkspec;
 	bool once =3D true;
 	struct clk *clk;
+	unsigned int i;
 	int error;
-	int i =3D 0;
=20
-	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
-					   &clkspec)) {
+	for (i =3D 0; !of_parse_phandle_with_args(np, "clocks", "#clock-cells", i=
, &clkspec); i++) {
+		if (!rzv2h_cpg_is_pm_clk(pd, &clkspec)) {
+			of_node_put(clkspec.np);
+			continue;
+		}
+
 		if (once) {
 			once =3D false;
 			error =3D pm_clk_create(dev);
@@ -700,7 +737,6 @@ static int rzv2h_cpg_attach_dev(struct generic_pm_domai=
n *domain, struct device
 				error);
 			goto fail_put;
 		}
-		i++;
 	}
=20
 	return 0;
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 1c7a979ab790..99bc08bd7cc1 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -91,6 +91,7 @@ enum clk_types {
  * @name: handle between common and hardware-specific interfaces
  * @parent: id of parent clock
  * @critical: flag to indicate the clock is critical
+ * @no_pm: flag to indicate PM is not supported
  * @on_index: control register index
  * @on_bit: ON bit
  * @mon_index: monitor register index
@@ -100,17 +101,19 @@ struct rzv2h_mod_clk {
 	const char *name;
 	u16 parent;
 	bool critical;
+	bool no_pm;
 	u8 on_index;
 	u8 on_bit;
 	s8 mon_index;
 	u8 mon_bit;
 };
=20
-#define DEF_MOD_BASE(_name, _parent, _critical, _onindex, _onbit, _moninde=
x, _monbit) \
+#define DEF_MOD_BASE(_name, _parent, _critical, _no_pm, _onindex, _onbit, =
_monindex, _monbit) \
 	{ \
 		.name =3D (_name), \
 		.parent =3D (_parent), \
 		.critical =3D (_critical), \
+		.no_pm =3D (_no_pm), \
 		.on_index =3D (_onindex), \
 		.on_bit =3D (_onbit), \
 		.mon_index =3D (_monindex), \
@@ -118,10 +121,13 @@ struct rzv2h_mod_clk {
 	}
=20
 #define DEF_MOD(_name, _parent, _onindex, _onbit, _monindex, _monbit)		\
-	DEF_MOD_BASE(_name, _parent, false, _onindex, _onbit, _monindex, _monbit)
+	DEF_MOD_BASE(_name, _parent, false, false, _onindex, _onbit, _monindex, _=
monbit)
=20
 #define DEF_MOD_CRITICAL(_name, _parent, _onindex, _onbit, _monindex, _mon=
bit)	\
-	DEF_MOD_BASE(_name, _parent, true, _onindex, _onbit, _monindex, _monbit)
+	DEF_MOD_BASE(_name, _parent, true, false, _onindex, _onbit, _monindex, _m=
onbit)
+
+#define DEF_MOD_NO_PM(_name, _parent, _onindex, _onbit, _monindex, _monbit=
)		\
+	DEF_MOD_BASE(_name, _parent, false, true, _onindex, _onbit, _monindex, _m=
onbit)
=20
 /**
  * struct rzv2h_reset - Reset definitions
--=20
2.43.0



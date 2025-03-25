Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FC6C3600C
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:56:52 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.52])
 by mx.groups.io with SMTP id smtpd.web10.67869.1742914608786372085
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:56:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=t2a+sE9s;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrnVblGgooRVFEDx3pDanTw8ndg+p/Ht1+343aa/sbP9SzJK43KTP8Uq7bX5YHE3tvx2sbRJQbwd/cu1DLnIFlvwjPaiBOBr+v9bH8WKCt4OBU6I3YpA0yvYsNWfBV0SXZU2ut4GBXEpOVA7B8/S/Tnmabg7uJ5Z9iISgUQWx1xYVu0+MeVR5ePypyzDXv5M88yIv2mkcrgY5zE4+YDZ+1Ngsqm8QSrkgDTJ8Ai+nmEYyP7XHYP1cHRU5h4h4IJ6KYEqSxGIrWbKV9ncb3vqKCNxtrAckfVGTGI59Nzv1OGeBOGkQyyvrBLzfojgF2RTNeTIsrLDPUeyaG3gdI1wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heN/uMITF3QJbL0JIbrdubpXTXdkqvXTW2qwTkN+em8=;
 b=p55COLzePDe0GatEwG0uMUyU+52aQJBoNvXs6i41+IOKhJSYqDP25dcmRo1GLfplyLlMFrVpn6fN3zIPJ9NI0szizItPWc7T3RgEtDlXCTlXP1BueBsdiOVXt37NuVNEti/Zq8rf6/ZNy71wIb6bAmsNySo/rfgKPkI+Je2Q8uJmVJx/pVLfT+Fq2eQObohKXeMjC1ZQKHgpyjcCYzSeDZCgejBgup+O66TF/kyIpVcOssmX94sc2nsM8IoP6IOquQYiREGhohPBraA40AOkIfes1jSHkNtLHpa5cm/lnPLiU4S9VLsb9OcMrK2Z4hsdi+t89jYG7QodPZkEz/HAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heN/uMITF3QJbL0JIbrdubpXTXdkqvXTW2qwTkN+em8=;
 b=t2a+sE9sYCjZ6RWvLhygtD4d/kBNm16R2/atNooYpOebv/o/9vWSWAgNlGXrgd+ie+3CinJTfWQAaaHdlW1+7i4H/o6mqnrljTakdcQjxs49SN9QLrqcaQLSRGYHY8fmu/+Vt1BG/6yDPG8SsMqKYmDU0yq+JBn2+uLl77m5Uhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:56:44 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:56:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 04/16] clk: renesas: rzv2h: Add selective Runtime PM support for clocks
Date: Tue, 25 Mar 2025 15:55:58 +0100
Message-ID: <20250325145611.3595454-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: 30aa95d4-db5e-494a-0af2-08dd6bad4267
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?s5rasOUmflG+/2drT+hm9vOJgmwvkpnqXj3qB6O+TEO4bkmoOMFsqBKbLwjy?=
 =?us-ascii?Q?V56M7Xovh5Af7z+C2Zu74UIC5SvWaK5h/egGMZESOTtux1EcNWtZvesh2XdM?=
 =?us-ascii?Q?2QuQtnwz3ODhQqXIKU/xmQViPKovn1W7wAEahH7JliDR82TMeSzxgIIQ8zTX?=
 =?us-ascii?Q?Zz76hp7IauBS6TJfTSjpUIJB5jTX8PK6QviTLD3SRsidvOcNKPvO7gvMrq/H?=
 =?us-ascii?Q?LqVv9Km7XYqsRJgPqfmfkL+74a1UnTii5GdZ1jIW4HxkKezNqRWq4kMHcAOd?=
 =?us-ascii?Q?+CrufeZB5sGaEGf7pWfHdVgfAGPz2pBzx5Cbv2AgM1OdX9kzFJSSZ53JMir3?=
 =?us-ascii?Q?HSDyXnW6ZQnFLYevIJEHgTAc3DB/eP2xVJYQKeWAd/delTivFCkyMFEDVTbr?=
 =?us-ascii?Q?dZwrp4cCFnVYLZOV3YD6Zg8ARXdXHc3fneWIpYPruh+n+7ksbAhA5TKqulQA?=
 =?us-ascii?Q?NtvM4Jqgy5K1YkTpcMBCRgn7kh88s9YRhtKIWoSTbn0BJwr4cXiv4yoSy2kw?=
 =?us-ascii?Q?oH8Ku4LAA94IywPd1Rotuc/cOP2qpWOpb2Eb/VElzY0mEK4qrlXtH0zaGEQ8?=
 =?us-ascii?Q?yx2owJdCVI3ksXG/5JHwCGMlgi1YJ7vuKsFzlOFY4hI/hozOvmirxlc8lTns?=
 =?us-ascii?Q?bBXU8GaLA9IZOBixmxuV9aQr3w9ndaKot0jKgxTnTpfL2lxarojwN8W5NgX5?=
 =?us-ascii?Q?IB87OWrV7T8ZHaGAVN1gWMC6Na5cGEh0FAkFmvVT++VgcFj7s1gMUZvhUjNt?=
 =?us-ascii?Q?8qbWt9sPqGwRpuhN6is1cdYeZSeREZtwKttJS6/3T1vQW3YW00oYkhzC/I3p?=
 =?us-ascii?Q?goTNpZRv/8Fnu8c4sIDT+xUcaLHO7kmyG5UQZWr24a+/lpSSGDbS4xYMjIw9?=
 =?us-ascii?Q?pJnIzrrQN9dvc5jEEEv330ezlasdBrVlv/vqWIx3gMHCeIqaxYGNTG/D1SCd?=
 =?us-ascii?Q?Rkl5hPLgafbnDeL3lzQf0ceX1Yg95D8SR6C1/75FwOWBMy9sd2CRs59XHC4o?=
 =?us-ascii?Q?pyJwYFVVkLSh4lTnLq2xhI4GOqO3idtx9NIgmOucMkKz6wAvDEgOal5KsP2c?=
 =?us-ascii?Q?vJhigN8qsEEaOpA72uprkO7UB6Sond0kcIGRJ2y4/K26WiTOn8CstDJQ7r9b?=
 =?us-ascii?Q?zZMNFTBDBs+3ma3FWgpucxpS9EKX3ohZyqw7ykidZpVLiWTOaTvGJlU3kxol?=
 =?us-ascii?Q?wBt+O3M3pa8RGFtRqDetyw5B85B8X11xCGWXpXC6F6oGDQmpCOScrJbApxUv?=
 =?us-ascii?Q?2RFWJarSOREJjEtAy84Z0Xjt2hJSgNxQNExbE81TC4lSVrIGVbEyXuUVLZRt?=
 =?us-ascii?Q?6Av3Qos8RndbNrOJSEfYvaeCWbinxxJAQd3a2rFpbeQtqVF3vjiHdaYfEjQ6?=
 =?us-ascii?Q?iiqf5TCGwr5mKn5qVNQCm/R5CHy2U3HQ3H0nnPeBl2HHlp3Oye6mq6MpElYw?=
 =?us-ascii?Q?vggwQhJSHiu2ufkODVfrEqrQC6jKLK9M?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YcapRLSf7f00CLNv3GxV/Qej3720pMIUJcLMk7tz6sZbU+uzTF6BWBSeRSXb?=
 =?us-ascii?Q?meIwau12W3sBkXCLggojNLHm0x3iFgnD0/0lS7rq6Z2vSkFUYAJOEIvtBYly?=
 =?us-ascii?Q?Ku+uzkiQnwYoPlBTByQbRk3Rta677557y3y7hOQdsD8XSD/zNlp6qK5If1hQ?=
 =?us-ascii?Q?CzEsTyBIAYemYLWpBxbvzpd1w7kc0AspsrXMeWA62fLMR8UCnlwmgBmKyaZF?=
 =?us-ascii?Q?LTWTwHMesxTswGQbKcWaRrQwsqeuujz2vfp6/oD70dpWyuns2/Mz1LDYsUDa?=
 =?us-ascii?Q?oj+gatIRD4kycXhEjAlzWBrL9Y1kunHHR0cazYalJEHZPnhB4QpsnLdfTviA?=
 =?us-ascii?Q?9dnTSMlfGh3STq3zs5U5Bi1W8zNIQLqKZ2uxBruP8+Bxd4FIBpSLnMQ5EPXU?=
 =?us-ascii?Q?y0rPubaID23eVKg3yndhnaFuuGu5SkqiV9GQwgbS3G7YtIgfSn7Cq5+z3Ls6?=
 =?us-ascii?Q?fTXaAZbRo0BWBuGXkqcLgIJITS2L79Y3kBalU1t0yoP1igKdAOsmSEXL7LZC?=
 =?us-ascii?Q?70kdn/pzuq6gqNZF2hb4KRpOAf50k00mw/A5JAWdAzpMET9KlE+vj10vPgIO?=
 =?us-ascii?Q?S1X9L9FbyRsck8+ld6eSbTSQX8wzW0KcN+zUHt9tsdYmabgqU9kPA31ouy0S?=
 =?us-ascii?Q?phePwil2RP92Y+mtt8HtrBgtGs89+iZjU/HS1hz3ERoLueYROMnEVAMsKsqt?=
 =?us-ascii?Q?0TJLEdXSg/MSbNHHczBO+Ki6TMD/IQKCCtzi+EiC0QeFYcdqqv+RJbM0NVYi?=
 =?us-ascii?Q?rDmI6UnokQb+ejwfrcMeXZarDgR9pvYQtTbX9ZrDeJtjLumqxujysTsjiFDJ?=
 =?us-ascii?Q?i4nx6Ja/uAXeNLVt8NpXlmSL803LiCWhT2rUk6AiIAqA/4bGIwS+3fiTkeid?=
 =?us-ascii?Q?lfAEYlebII6Fte38bavnnrvpULpc2JJlNMez96bKUQ2PV1JVjM2rtUV4NBOE?=
 =?us-ascii?Q?jTJbZSJ5osS1r0pGPCrYEZVYLQXWrDPTDyafzYMTTVD8VIHOKVZ+OSIomTg3?=
 =?us-ascii?Q?ASTI1Q8QM62/vVwrbyJHkjqOAUZJqWvmzsnQtO4Z2yjd1LrQjB01RDtj1ppt?=
 =?us-ascii?Q?8t7sQ/5RY79FHrgCDDHLV9yYqveD69cT2QrGLs3bKs+sMQ5ii04uIrlFX3Ja?=
 =?us-ascii?Q?xD9w/pPUvE0R5wbnGslkBHKsT6HkjkMhQwUsy4xDV+xeqlIzSTGx1l+g9Gaz?=
 =?us-ascii?Q?0civ/Z6ikSd2Ies4fWQOVEyUJ21kErwVv7PfliOtjHHnQXKTAdw5Bpa8vXcX?=
 =?us-ascii?Q?i3ItCvypKC4iyP6U6skwr9dFaAXO4iy69qdkM3WJaEgyqTzqjpcwtPXYsDJH?=
 =?us-ascii?Q?jCgCokovffP11R242pCZSWt+g7p6oKnMcjQMNvhkHHC4oK1RDV2JjOKrDYwl?=
 =?us-ascii?Q?BNz4IdW2iSBu++kFLv02hPcmDryLVKvpTJmR5mbeg4KB8rZ5vzck+8M/7ssZ?=
 =?us-ascii?Q?RwKjTFrDn4+2NaK+3I0kU7eoYt/2dzkulPpBuSdqmPGjMv0zfPSqdqGnwptw?=
 =?us-ascii?Q?BDX7hEjdDbeOroMz/sAguHGjLu4FpylkuwhO4ldGC8lIqlEHdG0CjgkNGkYG?=
 =?us-ascii?Q?z3C2XZWmR4VvCv7XgE7cC2b3RpRW/x86D5InDxVvOGYqu5mXTaYqWzYyZTH9?=
 =?us-ascii?Q?X9gm+fA0nhykSbadjeo/TEY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aa95d4-db5e-494a-0af2-08dd6bad4267
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:56:44.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktLWRgPu/HBBpYQd8pg3gq7cFTx409/SFZU2ltuq/M61d2mzzRSp61reNOuTls4n3xF/kz7IKlhrbfK9ODR3/WbLDl8JZE3I7rgoplsqh4RcgsykF6uVqmENTdlP2/U8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:56:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18354

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 44 ++++++++++++++++++++++++++++++---
 drivers/clk/renesas/rzv2h-cpg.h | 12 ++++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index b524a9d33610f..1154493583a70 100644
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
index 1bd406c69015b..60016b6122a9b 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -95,6 +95,7 @@ enum clk_types {
  * @name: handle between common and hardware-specific interfaces
  * @parent: id of parent clock
  * @critical: flag to indicate the clock is critical
+ * @no_pm: flag to indicate PM is not supported
  * @on_index: control register index
  * @on_bit: ON bit
  * @mon_index: monitor register index
@@ -104,17 +105,19 @@ struct rzv2h_mod_clk {
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
@@ -122,10 +125,13 @@ struct rzv2h_mod_clk {
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



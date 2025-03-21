Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3982C35FFF
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:09 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.10])
 by mx.groups.io with SMTP id smtpd.web11.18696.1742554867685240602
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pS64S+lj;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdbuFSc2CBGmizG7Kc0ePXrAkf86mArelvluWgSZmI6ZYWDnZ48MrHXVTZUWfIHyrGgjff26+y2OwrqXoP19Mf3fmWpEXrh+HFd0Ufc9ROKG3qZSuf8Hyne8BSsEqoJoA3BOeh60MSFFaJJttKfxxbyrCBXH+r4OynJFaH6gernP3zkW/XFMjKfi2av7CCzAzsMGOQAhTrK/94kQfdDoUpoMhE3uliXfxlN+rikkOVHvZ5SD1ETavNTOWM8+z6L2aIPZBP9ZPQ33to+6nPdwq1eAWY+cFVk/mTBM1jk41x1Pt8n2sP+xgDhC4x58uRU4ao2V+g+jlBS3c4x5ITa19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geOIyPCd1YJP9JDkYFAjGZRw8kj27W5M4DZBrQPSqy4=;
 b=ygd697cQmxtUOVGxahCs6ZtxtOEaNXOWdXpUdNHNbGqHLC55DEOvKSA9VY/00JqvyqfaCBq3Qau6+DibU0huGbUQUap2yNwdakWRa4YA+vlEPKpeiw7WadR6yWpZHh+1uZ0vEgGkVm2NWoePAy74i5KmluKf7wO+o29AU1oRxWru59x5NfbuVyGIcdFbICagle7P07OXf8NuDew3YAnIRIfBZ2erBcAilunsotVoFZ1mIQ834oW+MOn7W0yaxStlq236X9EahjrKqg6hAqq5P1+vmLjHWcpL2SBpqadlmZwt+YfrRjvJto7WRj56ICi5AYSJIt8OLxX9hQi29IGmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geOIyPCd1YJP9JDkYFAjGZRw8kj27W5M4DZBrQPSqy4=;
 b=pS64S+ljrCv1ukV/v706z/fcAahuT8hO3341gOWYnBXXKHJij7HmIlHJlYo++FoX729ygwC6fFevMmvni6sY9GlhzOEVZKghJko982esr3te6amEJFAiXAUZXAi/bxVmKPnieFm86om7NUaFBaXhGnTiTWE2FCzFRmH2LrQudVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB12437.jpnprd01.prod.outlook.com (2603:1096:604:2e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:01:04 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:04 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/21] clk: renesas: rzv2h: Add selective Runtime PM support for clocks
Date: Fri, 21 Mar 2025 12:00:08 +0100
Message-ID: <20250321110021.3612805-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB12437:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bb9119-3ebd-4380-6b8a-08dd6867acb9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5BBjvrZUotplPm2IEpxBYifxg9vX3gQJwwulx6np9ZRmqtizYQGcSaUajmtY?=
 =?us-ascii?Q?c0yQXqphhh4gHA8K8GHzT5i1o+ujsxmyW00a5zVnUSQVKyKhkcXoFSVl0fB8?=
 =?us-ascii?Q?NPkCf263NWmJ4Gujjd537yvQTAJ6oaqdUqWi/0XMKwECiSkviEE/OrWa5Ozi?=
 =?us-ascii?Q?9V5Bjt2CUTwAXyQmAzhhPcx92HKSHLJBxZRreya1z0cYR0X84hMWSHKYbsMG?=
 =?us-ascii?Q?xx3SpSl/pRk5VIYsbKiYzrgjfH/7cm3KFbRpeTCoe3/HbjNszeVTXJEY85G+?=
 =?us-ascii?Q?c8+lPSyCJwMyViXlLXVHMJMCatmh1bL9yfH8y87b2TvxLMDcft6bBLxMR519?=
 =?us-ascii?Q?LX2o9SRXF/+S5fujECQIX1hUJfZ8/nM52PU3G3nc53ZO5ZRWbRzn+6rze3qz?=
 =?us-ascii?Q?PLJxOsSRDELrMuSD4L9ruCa/nLqiepXVrW4EEI8kiCqDlq3c6zBidmxIKMBF?=
 =?us-ascii?Q?A2oAtZgfiEh5/+Bm6kM6K/4Xm1lOp6qasPAKNH7MHUEA8r1akmEaqZfTWdCt?=
 =?us-ascii?Q?Jzw5pdeS/vdvpXZ9842gorbEBNC/CTNe9023gn/0YXEkDxoLMmuTRapCIMnb?=
 =?us-ascii?Q?c7ySKJAWyRa3UGnTabVHT8bgUX/W0ITc4c+hM5GmB7KO1ZwWDslUnnnnhCGG?=
 =?us-ascii?Q?aYu8mVhF2DcHFwEu3cHmj9tfxaCpy6CqaMzN7yIvSjkvrZUbGvLH40XQ1txE?=
 =?us-ascii?Q?FdYtBJLVo4uwPDjr5esMXKrUjzbHZnaV6FdwM9ZSNhB/jTlmR3S5WT4i34Iz?=
 =?us-ascii?Q?6Gu7N+qe7gG6v8O2hpqwPQNvOy1AdD7en34uPMKr+PrsE3vYPqTUJDO8mRsq?=
 =?us-ascii?Q?VEfIqH6RJddj532Hb6fECzl/9Sct0wyTp+QQvfcHXhqECkdH2MDVdPD5FUVD?=
 =?us-ascii?Q?hkUplkiM3tlt/aiv/SJ1zI+jA3wpn/2k2zxxN0r2So0EoMoscXZveqR2lPQk?=
 =?us-ascii?Q?yfLYZt/asWmb8dK/d1YgFx5b6sVFhqfaQRHVcIpfKOZ5ayFWf/2q54XZijT8?=
 =?us-ascii?Q?lUAaJvcytTfTUaUjk6COu+a/Sq2SeSu/NTtNjI9MsMvsvYV/WPZqVMY/040s?=
 =?us-ascii?Q?ZkEFyZr1mgX6UdS/iHzd2sQJyYlCtvIH+EuHJA+ZXCJWQsQOi/x7nkcT4Nl0?=
 =?us-ascii?Q?wd+aPaqhJnH4FL3eKN7IqwfQQndL+Z0gzMHYQaFxyJZ8Z2qIvIvtrKKaHKox?=
 =?us-ascii?Q?vSnWUyE0fUbZbJPA03OwPdb92AnAkEX628fbvzLtjaVtMkyzLltwe/u65L6/?=
 =?us-ascii?Q?hJsmb+Q3+YXKdolu5qtw2KsnCKAvUDifhOteRuj7yqzfnIa+6lc3PUd7CmHt?=
 =?us-ascii?Q?62FBMPLUJlGCs3oYdaUkVYyvNY/x/XbhDyziT33zq3JQ16lcfX9P7IY3FYIB?=
 =?us-ascii?Q?5Cqk0An9GBb6KNr1RhMZeTNnKJXWTxtxGiPBvLkxaes1dqthvUYrX99zJypR?=
 =?us-ascii?Q?Ep2Y2eiwym8giGdp7+udyYBsA/gVOsTC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uo3BytkX6xgfwubW2pcrk1+NV0K+D2nK8nzxVTFBlYTBefJQ6OmnT3OqnnJi?=
 =?us-ascii?Q?uS9SDUtfWIFs7D0G9uGK46x/ynMwYdaVqiFAZc3MuNGmoqflRc18f4Ip29+f?=
 =?us-ascii?Q?Td8Qve5XArmWuNt1Vg0InoT6sksleqGFl6y3hIEfIiFQrp9xYWN1r086ULuh?=
 =?us-ascii?Q?TgEI/Wg36szsnoWlJwbsDAXWUR2chjapIPkHqIZ6cTs41e4Uokk05XVnGZf2?=
 =?us-ascii?Q?wLIySJYsVW+DZEyvUEo6nuzKQPMGJIn3boQ1wX7WrgmVZgqdBBYNppHAq8CO?=
 =?us-ascii?Q?EvknoXr0AFgQj6R+qpb/Rg69kI8z8kxB7FvnkNJglZ2fQuBovJqESik7bxL9?=
 =?us-ascii?Q?29upwI/A6nZuBAuxVxqCXpmjf1BnogdRScao/rPqQ35XNuUScdW0YkgJNSlh?=
 =?us-ascii?Q?KVLFxouxLhZPSSAiHvdY9AglFAwECO3SatfXK/qpujVwSrh2wE8xUjt5Hadg?=
 =?us-ascii?Q?Hzi/Ygw3ajSt2phEFlKCLXJr7vD3waLSOFigPakg1niO5mm8JxmpObE/u3x7?=
 =?us-ascii?Q?bnby47f2q+Jl3TZ7gk0rENJj2tteL/Uv7FafZ9VWoJ7NMbSB1AoGfYPV9QBJ?=
 =?us-ascii?Q?bWXPoVA1VLSjkYahl+spLltUHnrOGW88Lwja6nibqpn7hKlA5XB8JktRhFAo?=
 =?us-ascii?Q?aS9+QGCh47CFPwoc/hnbGT1N+3iPRLg3sSjglRghMoWKvizi1HqlwCu60AcP?=
 =?us-ascii?Q?nbTTPUbnRn/L0+vBImbmc1eoTIrADMSUa8zUtxtExFDyGf/bEsuOP9uQe2tH?=
 =?us-ascii?Q?2oXMuay6ogPC2RMC3yPU6EZIq0lt4EXo82y52Kj0UtUloaLt8Ps2adNvB9Vk?=
 =?us-ascii?Q?Lz4SyoHWN05iBpee72lNkwSMNwgWxi/UXNxkKDHiYGvU7uWqwsfgtlzyfxkX?=
 =?us-ascii?Q?qjpq1gRiM6K0RsQznJM35A72S98spAJDRKz/ZUnudM5sKQrxo4lVpcQcWdGy?=
 =?us-ascii?Q?BNbgMKKm3hwo0yVlNFLEiEhFs/N4VoQI3ZXlq3aFIyxXbnBKgOdu5vku+P0o?=
 =?us-ascii?Q?8Js70YI+8aTKfY7/uPb2REHZIbjOdv6EaqdKlWlD9mNAo4brpjhSWeUuPQQp?=
 =?us-ascii?Q?ovFKm5karClBBJ9syA+zQgVJCyuqmIDX73wqS/QRZ+3fXsIXribq/hWY2JGY?=
 =?us-ascii?Q?AGm+Mm4psZ2rZh48rq3Ww0bQS02c1pDs4SdVrbWnZ9FeoVtExqDColOe2nCZ?=
 =?us-ascii?Q?7NjkLxEKe2VMEojSUF9zz9mYiN6ovdazgAiAA3LiZ1hB0xP3Bexho7s7lYZm?=
 =?us-ascii?Q?AT1l/YF01wTgyhTKqiDttPnH23BB9Zb/8MwpsQy0+MNSXcmP8AIo5n1DeGQK?=
 =?us-ascii?Q?FV7Ys4JIz1P37bYQkuq3OFVJPnQxbjlrWGRXWrLehtFie+4cvV2fPqKi1F8F?=
 =?us-ascii?Q?AGjGGbIrH71NSyOiIT73SVGgEXfsXmLaGCzC9a6KiDd6pQzFkJo/YWdwdhfS?=
 =?us-ascii?Q?abzmis+hP2eLOfdo7AdBE2W1Om3gbAzhzfb84yQN7J9WMrAQXDjfFA6/eZEE?=
 =?us-ascii?Q?NCzkKrF3PFC+M/TvV6or4DklnJWZUiRVLtypiPKLrE6n1KLHNL3BOtthQABj?=
 =?us-ascii?Q?uJMHWlhM332B6VzsZFsUVAOz4BUcpPDkiIFIbFwI30nevEMkuOGJgYaFQMmT?=
 =?us-ascii?Q?iF1iZpa1ktEeKdrgBIYVWOg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bb9119-3ebd-4380-6b8a-08dd6867acb9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:04.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2v9mF8Q346nE71QQs5KGeIL110K1iXMYH5stu3CGrnyjFKqFtDPF/qMPzjEZzl5IkB+SF2SpxA+T8XWCKAa3r1h9n6Vi9YgVLTPzRM9orSL3B5i9QEYD0cvf+KfmAaE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18315

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



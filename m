Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5AEC36016
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:31 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.9])
 by mx.groups.io with SMTP id smtpd.web11.48807.1743417983379384922
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vYze2Xbz;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.9, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAB1pD4PUSYEFapGGKohZHgihNE4NrYoryalgR7NsFWivDK88ji+6T3fTalp5hlYGgBcu7oF/arPeCsq3j0D3p+Qk1gLGH4xL+mKqGnm/nG9UoT2g5yCxJlVWWqQhkLKwPL+BQYLDwk7aZC28aRPswlQ5L0sZwD8aaXgdQK7zH8L5Hiof9edcd306Z8XwtdtvS1geGwWyWT23bivL7BVV3bSFwgs0u6+9N9QpcL585x9NH1lBMVcWV1gVTcbcrnPNAesqSms8CFptpw6kGbB8UWjuQl6PhqFbTomhDcKyL+k36siBLsYP85a40UR5r4Kb/y8fh25uIZaDURboExwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdBuqtxR46TdoZLdXtf74k9pDsqpBCCESB3d2wsAUHk=;
 b=yaWLiCpf8v+jw1NI/KA1fYWAzqiRC0SbCly2wJzFqODTQDG9E0bu9NGbH0tKkqKkNe0oqQTiVQfqNb50rB858eOo5tR0gRF2G3dAMVHbm9NTLJsh1qWnXncF0Q90Kw5PRMuYGDN82rRs17j0ocb45D8u64l30fq7VI+lzzBeTgMhMyCtp6k5jv8Q506xn5Ye5ZYi1fxBWO+RaszWY1CV/eRNS8gX1v7IoZE8Ggu21sOzl/X1SS7S/hp//DParlvSnF6Aho9VZXuj3SN7B2DpMoqOF2k3wKhJ89KJRTRAgDIfZyqx5PGm+O/P0cwQT5X2UMjZXunFN9hXuKUC3Qd+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdBuqtxR46TdoZLdXtf74k9pDsqpBCCESB3d2wsAUHk=;
 b=vYze2XbzxQyQ/BD6OoozalwT61ClmrWKKM/8kO2UXDVnrl8GU/75tdUVmkbeSbUCk3E1B5x+B2VbWaNL/oTzv83MXgdgE+PwJIuobvGz6B8QsCHMETeSkWqKroUGrGCHTELw7j3P+0uq4zYrn9dVNnVNQp0ZtkyYYIneMhTCYzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:46:22 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 17/43] pinctrl: renesas: rzg2l: Add support for custom parameters
Date: Mon, 31 Mar 2025 12:44:48 +0200
Message-ID: <20250331104514.79090-18-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: a3aebdd7-9890-4321-3ee9-08dd704146fe
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YOOD4II+1j46nRQSfJmUI8pT1myA+ocHB7ExT+5zIN8Ll8YTIalX62AFcXX5?=
 =?us-ascii?Q?NooRwIMmnSTRkC/3AlaTTeUuB6my6FLOuOxPcYalxUnQYT0FUaQOQo81LVQ1?=
 =?us-ascii?Q?gSQwvtLPoN4Flwy4K/Y7e5vYgyjiY2+EZOgGI/Hi68IlevXxHwuK6h8Q0JjM?=
 =?us-ascii?Q?V0+7kQuUu3kCGcZwCd6jaYNOsSHkw45ElPbxJo2VfyMUN27KnopGqLkJaktd?=
 =?us-ascii?Q?vXG/keuXOm4AfaM9ZDgp7g2CgN1BFaLNFMuICgWWdYco/rtMNFaS0lAjiRDQ?=
 =?us-ascii?Q?k2+dO9TI4eutubWW4t/2LlXcK+zki0gudAq0/beZwLhUvtAb+aONjdh0Q7DO?=
 =?us-ascii?Q?lHO1YQggKObuSSLMcxICcO9V1zrJdjaAB5oMVWXl5oYAQfLjtdTomGzJcHtS?=
 =?us-ascii?Q?RBCfRNcyxh/4J2DlmzYM1kpgKXChmRHDQ2/OZLkg1kyLhw32CxPWoC/K/rfO?=
 =?us-ascii?Q?eGhtyXrVS5KNEogCSWrDAe8c6MUbjPFaenerT63nPqmPVXPz0Z9Yla8Kcsmz?=
 =?us-ascii?Q?u2V9hyYYmttadlsrPLp9DlDbQ4v4Up9MGt41fG3bd1HgT0YZn0TelMdgzUPX?=
 =?us-ascii?Q?NDpKgXmInfkGWnxHuxEIpuJaM4LKsS/BazrGlbyUJ9cg9Yk/8yIoEFzoKyE3?=
 =?us-ascii?Q?R0Y6BdL8V2YtuGgHaJDjyD7TK3nv0hzmVicFT2p0WTvws8YauIbRlYUyqp0S?=
 =?us-ascii?Q?0Va/F2+WUuBgsEh/6kA3gYNWar2mGc/ncNLFUcf5W+2H+VC9C5GApTYUb+Uc?=
 =?us-ascii?Q?8oVCDfT8KyNNmvw1fgcmp0RoANRPUd1nFzoJNo5CLiWkcRd94smZbE/wRgc+?=
 =?us-ascii?Q?ShllP77qIVSechbwTkDa4SVKYJ6yMvjAh+6lkYXvJkOi6vdZl7/zLS0wbcIe?=
 =?us-ascii?Q?cxT1j33azRJ7/hhNOZPILXps0IlGvBm+IXnT3Wps0QZn5zW4VDaiHfFyASen?=
 =?us-ascii?Q?MQZFMJRbGh/BQXyhh8KuDIDWNszOURn1iZVvLFloUpw/T8dOdsqb/sbOiGrr?=
 =?us-ascii?Q?YincRjIGSF4aXWTBOZnGZqyeHhyGeUf5ZCbCBluUUXciykqOqFTfU6sZbPQr?=
 =?us-ascii?Q?oW4mZggDPOcwnLnc39+JokSmzUHH0HI45YknoEtSPb6LNbRf6RD9ibLlIN1h?=
 =?us-ascii?Q?SxePT8pMlmY29MplNg6w8LF5UC+t6HAGQbusOwd8NE+un7F+aSyZNhCYV/dV?=
 =?us-ascii?Q?oinxkEeR24rlLjioEhkZj60AD4VoE3wiWuRhZaDm2sim8YZMEJ+cXHfkeVXL?=
 =?us-ascii?Q?WDd53MKo03N26vSIRBoSQkr8zD2oXCEsOkgh0lB0AKDR0yu8WZNtrgXFd/ip?=
 =?us-ascii?Q?/o92TyIY/1CgOgNRXz5Degvbwpv2iSxeQRqhHlQD24jQqVTQnEPz57hzrrGm?=
 =?us-ascii?Q?EcV6k6e1RvwMeAyb27xwkuV2gALA5zYkCVp+9xW1pBRxFIUxklFbFzu1rgGq?=
 =?us-ascii?Q?RqETQ3sWgyzERUlsi6QXc2/kRscOelZu?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9dr/pGvHNQfda+S4Eol/ovBKbar/xHLonCrInN4hF3FfWh8DYEDOUTuRsqs1?=
 =?us-ascii?Q?1W6TOzm/BJsoFcU1eb4zBBLsZ7XRoY//JW/T/XWIuINfvXrJ+Rq2+6LDWgnY?=
 =?us-ascii?Q?n4fMz0maO4xB8Rc6Ja98KgGkzp2D7DoTioFsDlm/Nc+gLrx1L1gQxOrLUsTA?=
 =?us-ascii?Q?9l2zo1Uea16f+dxsGNzSQJFv7qr2xiw1d1jq2e18RR0N8rHVfVAA31llZPXk?=
 =?us-ascii?Q?lBk0k1+xv0IY0+FHWPOkubXiKivVN4Ujg+QTdb6EM4//yBXwXO6jkLucn+8I?=
 =?us-ascii?Q?CSlgXRUW0OZytaa6JxE4pvsSRdJ3rB26g8RsBZ+FyZpwwCFv7Ccu0T3OiBND?=
 =?us-ascii?Q?ISm6jV1PHhb1wKwVKSDuS6u2RwIf9b6xA8szLNL1fgQgkHrFnO+kgFguNtzQ?=
 =?us-ascii?Q?ubxxQphBeIqk9a8mElNi6ZgxwTjNwzo17aCGgCSRWlzxUYq5w+qYQOLfJm/p?=
 =?us-ascii?Q?rBMS+VXg3nzlNuWAYWXSEkeDXrmIvr34TNnSgxjkawLpIzvqGD8fU0b98lVG?=
 =?us-ascii?Q?kRsp+XCwqrEnt78KQKXK1JutbI8/gNwqCvtUvdzA7IggfB9pl7a/+3iFp/lE?=
 =?us-ascii?Q?iEMpJTFQ1K4AT9MfHUjszBFz1/WXodBG07ob/LH1N3MZdqR7r4uGpPUEK2F3?=
 =?us-ascii?Q?t5eY+ZxnXMPG1cDpzlwVzo2AJzca7QlLyfUvBME1X2xslK9hiL9ew8bA3IQD?=
 =?us-ascii?Q?rK4HgpGRIPaxiFZeDMDuqEy6qdsXCpHw9R88NNd0n589zXA/7Mi+rKXK2fzp?=
 =?us-ascii?Q?0TOuTPg87GiU0YB3YvvBUIkaSjrpORJ1VyEC1xL2CxDEatGZQUo2Ty6H+/Cu?=
 =?us-ascii?Q?T1t8BG9Dz3yy9Jw1RC1Ke/rqwE9EvuKvvFFx6Gu8cBOEJ5fnu7f0PayEu2tI?=
 =?us-ascii?Q?dGdT87R1gJBdwRULx+xuHudx7HBIwFw3GaUwJ32zT2aUvwEXVtkB69xQJyGT?=
 =?us-ascii?Q?a1rGfwbCXpZmRHuW5Q+SvKLS3063L7l17VTWAhauTSy6HCf/5PbEGe7m3ZkR?=
 =?us-ascii?Q?Rd6Iu1vLuq/BhLnsxlEg7vkzG/jN0jdUEkOt7xp/v6xL1aoplbpDyINn4xsu?=
 =?us-ascii?Q?/1tHnETpDRKmPhif625svqRhJjSD3O9KBMVA0dS5qjhqNPMApZk6+XHyv7Ct?=
 =?us-ascii?Q?aeMVdB5Ht1ttyg+eVI9x4rnGgX6vFbQP6uN6NnNkyvNoxNqaQbCyOqWups0b?=
 =?us-ascii?Q?cRVjy4n+bOBl/cxsCXDo0akDQcuxcuFhySbZjzGZYvc7W8dNhg7N+HPIXZ+k?=
 =?us-ascii?Q?7HKRXe4A0TzIqASuxN54U+TLWFhXnU9HZXZwmg2htfp4hSde0mWsDD9kalcc?=
 =?us-ascii?Q?+6etxW0BB7ruKivXt04nM/r2x1dSOjL8HiBNXlNMPXu09hDc70lhOLhS0Avp?=
 =?us-ascii?Q?RyWWjyrEEShd2FxmrR3xYtxDiSLmhLytB0HQtLb/DZAGX9PXlzIHLOu2JPg+?=
 =?us-ascii?Q?5k4BcOsHPyXJReT4YzujEq6oA8zn9B+Q9rBLnBgzEEies0YaPIVOG2thuqhv?=
 =?us-ascii?Q?Hwyn2wpfkK2qz7LY0r74dT7DZvL4mlqDX5W75cMpyMJoBfqLoDqcbRO5H7kT?=
 =?us-ascii?Q?SS8BsZ9BCOp0reA9Pq2Qqyz5qKNmnz9NsGHF8IoG70Pf3M5qDQnPepXaVS0C?=
 =?us-ascii?Q?GiTakFrC9EqGcx3k/oc5kRE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3aebdd7-9890-4321-3ee9-08dd704146fe
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:22.6130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp+buGPzhwgNKaZC4ifs6pnsi185C50kAyNM0ZvVkUIOFf+6SRWSWZcXMoGnArGdXPuucIRLHS4+0br/CCstLQ0R+COK1qzq3rR/sWiXxJNjxYCM85lV/UuboE6RsS/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18405

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d930e8f783daef890980c0ca209a0f4f9ae73160 upstream.

In preparation for passing custom params for RZ/V2H(P) SoC assign the
custom params that are being passed via struct rzg2l_pinctrl_data.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240530173857.164073-14-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 9c1f32f6e1e46..538959643cde7 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -256,6 +256,11 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 	const u64 *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
+	unsigned int num_custom_params;
+	const struct pinconf_generic_params *custom_params;
+#ifdef CONFIG_DEBUG_FS
+	const struct pin_config_item *custom_conf_items;
+#endif
 	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset);
 	u32 (*oen_read)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin=
);
@@ -2290,6 +2295,13 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinct=
rl *pctrl)
 	pctrl->desc.pmxops =3D &rzg2l_pinctrl_pmxops;
 	pctrl->desc.confops =3D &rzg2l_pinctrl_confops;
 	pctrl->desc.owner =3D THIS_MODULE;
+	if (pctrl->data->num_custom_params) {
+		pctrl->desc.num_custom_params =3D pctrl->data->num_custom_params;
+		pctrl->desc.custom_params =3D pctrl->data->custom_params;
+#ifdef CONFIG_DEBUG_FS
+		pctrl->desc.custom_conf_items =3D pctrl->data->custom_conf_items;
+#endif
+	}
=20
 	pins =3D devm_kcalloc(pctrl->dev, pctrl->desc.npins, sizeof(*pins), GFP_K=
ERNEL);
 	if (!pins)
--=20
2.43.0



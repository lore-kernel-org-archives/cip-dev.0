Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC72CD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:43 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6978.1778751634469304810
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=D9kQ7APa;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.32, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eONYwpNENTcDSnPqJNkA/RdMBWt9VzmeX98IN8xzCrJfgEJ0mCpCozLgzpU4NcKSkWwctMCMDP9EMUL4vhMWYlh+TsUUhHgwS+WdKgHk4KBY06b+k/jLl//BX50L5TKuy3gYnr/PcmHcX3UxbwtbvmlCd3JhSayewW4SRiczlKqpsu9ocY/sxqo0JkiKOUt+evFeVIuRfsNu4PUfBNgZFdIsxExodyKmWFOFNGUXmAfuQKhXiI8Z884ejRrdksPaIkQxVeTmkwioD/fQ8ToUgxLFl1aN4xgVZQtIw7RInanCyhYgpXe0YV+jdloWJyly4gU5ia0JMCyeQHtGkoM03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0CyDnPaEnaARqj2h9XQYdTSzDu9xYsZrkNkG+kl1m4=;
 b=W92JEwlCeBnZFZqZDqcP2DjIpbaKzAvXFWuCAxTSGDVw7anKU/ahXvs9SkgliAQfKZU8PawEYMb5/713XpbeDj7YLSBFFUJ83aRQS5ZP+7//9wGsSw+xoVHe7zUq+sCBRjKElqxl6/Hg4lO8ZDDOs22QRIgEkqfygOkU/J55dcFWrevk+8Byryx53unlMBdNcnq4/gO4QyjfgLxS6KHnj9UKVSKz+szEiy99PWeEl9amTXFY7KsIoItpraja47YUNMSwWY3JKWk9IAYyirEswZDkZlm8JL/iqqomz7j/8pB0HGmF0oH04JokJfnm2u9gcCi9HIFTbH9LWTAcm6IT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0CyDnPaEnaARqj2h9XQYdTSzDu9xYsZrkNkG+kl1m4=;
 b=D9kQ7APaKuvZBY5YhAP1hBenlEdjke88jT5dp2exIODVQVLsUHLUmPo/RRsmOm7NcLOlV9lIKSanq2hhAIq0Ar9niNRbD+6EUIUEaEDd8ehEwPkQNZTVF1N5dxMzlp4r4v4/oO9lOox1ookwu0y8feFXSd8cN/aDfjexhzI/DTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:30 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:30 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 09/17] PCI: rzg3s-host: Make SYSC register offsets SoC-specific
Date: Thu, 14 May 2026 09:39:27 +0000
Message-ID: <20260514093935.2212718-10-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYRPR01MB13674:EE_
X-MS-Office365-Filtering-Correlation-Id: 687ef2c8-a54d-4188-27d2-08deb19cd657
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	SzTWvUfPTigrFoKy8Sk2DZrl1Zo2f3RJpAJS4rTiFom9uD+aqqoKa6SQIp55WYt23kzOz0n+AfDAHgMV+DlAxHKXIj0LwcXgpffABnuDiDLIwTxF12Vt+hp0PlBPi+erQmaDjz6MO1QGGsm2W1UAp857yyX8GgyJq6FzVXsESouZ4t8cIzpckHEF+sD5NeTLGpmXfp7GhbHpTuMGuUCOmb+T8bZcG0Dwiz0EV7lYNRre7wY5bDXzDgzXaVmoYz1EmG73cgLXrH6+hRfwxNXRhdhIkK/khJt9CJKc2wvIb1S/dA3Eb03Uuj2kGHxpkhnLZWC0b7pRbaeEXi7NEVfk6JJl5st+MS4iI6LlGDR0heeAfLWQarvVFoZemOsucmu9idk6YXbdf8oagDfJkk805NTM/5sk+BLNddUw7XsMcVwanqlmjbwdYbCuBC26BIkYVQW/X0WfDJWFg4OWux9/3b1X//HHx+NU4gUoeSDinJUtlivufvkLmjPuXWAVE8aSLokRVssnXErrymrYSTwdRERv7J3JVYFfq4kBh9ypGFlAKCpHULmcoJ3NDB8kpsfqRvMzJZ11dHR7/u8JBzBVgkPYylzFGSIr2+7uNNHvLQgD0WHfPVZ5PQlaWapu5CCZUCmVt/IjPI1234XE+Ri5HmOGdWkoXNsyjXBg6Io9ptpW+ysi3VKvEdWY86Fz3dutSKI04jDhJtQMOJLws4mr5g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?F8JSsQYwmvy3eOiBDxFEg/qKyW8100m7bitEiu4S2OzyMu5N9ujsY1MrF1aL?=
 =?us-ascii?Q?7Uwq6feW43parHqi5PYwHxZhoM57egeaO7AINIUdxeI80JLoHFn6EiNQEH33?=
 =?us-ascii?Q?yMXbGBWEXCIhexPrmaFRlxF6lAvyjPalDz47nM9VrUSBH9khAd3cl5HTLyPX?=
 =?us-ascii?Q?Fm3LJU75mQLU0m2YWsqOoa1PXSXPU7ydtAoi2cpA+5GgC+nHSqI9Qznz1txT?=
 =?us-ascii?Q?ZFfSYKES/Eo7iPVuKqFzJHEFltf/g6zOFfKvZFnCzhpLFx6LQtXLYjfAJbw7?=
 =?us-ascii?Q?3awJrzkoha+4sQrV7a28C2gBTIW7oHmGPGiJjdGsf6l79S1mRhfs+Snk6Plx?=
 =?us-ascii?Q?xwZX46FIFxKY/cMNJhvt1RksmG6X8Zk6NDjrWnwmHEUsZcrZesoFb1RzsmRb?=
 =?us-ascii?Q?e9lDbNupK/FSePZ9PC6zP7fTSBcT/iAnT8GSzc+qiS4JBWoBllTwBn8pikEl?=
 =?us-ascii?Q?9sSZw+9pwdRLW25+xMT1Cl4aqJpfGcfess+3JT08uzhMZ7HCw2aXBqCZsjK2?=
 =?us-ascii?Q?r6hdJxW4OnrCPYN8ftDVjT3z6KYZy/LHFjyU888eNPA91SEA5/TOOdzRE/0q?=
 =?us-ascii?Q?sws+g7rrDKfHTQo82O7M8qHQPwa7NFBHP/KvwQITgM/OAb3tJcAaqs7CFtB8?=
 =?us-ascii?Q?P8frril0CbC6TqEhf0WDUEoREP/3oF9JtyenfDj727EvQHF7jBVoA5zynR6x?=
 =?us-ascii?Q?xYfNApIGAydd5pzD+sLhkXHPS9AsAhP6qOgRGGbRKNiCH5M/IdDbBChFHEhn?=
 =?us-ascii?Q?3SH/BJVxQJC0wKB06M/olKs2928VJ2nqnhJ6Ibj4ACYdTK9Fx+K93d6jtux5?=
 =?us-ascii?Q?OkpiiZBOibcBf3L4EwRGsHQazek281CcY6IEn6RLWLdi0QNmWDJJzqcPG5Uh?=
 =?us-ascii?Q?/T6oNvuuH4eRjSjuaUeNN5kOVSE8Lj6Gzt9qWFBlhKoI94XS8T/kL3YRxqKj?=
 =?us-ascii?Q?ia7vgHb9zUtOj2E9v9vwTvNmFK7F9wcG1oMzijxDB+bkburUcqcDFc2TPg76?=
 =?us-ascii?Q?v3fUknbaAlDpGmW8+iD6SEn6I2f6QZu4/vB5eW815aXbNSJqct5VhXotTBzT?=
 =?us-ascii?Q?lq1nH/cb6W1y/O07zFvcXNURzkC7Vn0BqN1Hc4Eqi12KJ7DaOQoP2FmRse24?=
 =?us-ascii?Q?js5y0XzgkmpL/iqRmpBIYHYXrapWHxHvP8cQsUmw//FGvVm8r3lEBOJGcosH?=
 =?us-ascii?Q?4x8nkSO+wEhyx1t+y//1kLQRdAb7NhS9cj44Kyv1J/NPRIPiVkLjzWzxtAWj?=
 =?us-ascii?Q?KN4W4wAM7z+5U5K3pK1NTbJszaasLGUqHeFM086P1gs5OLE9T41WMiJgcann?=
 =?us-ascii?Q?cgIhCJFzZiFjV81b6oV9/TjhNrk/UztRhdsA8qSmY2ChHt3CihR9zhyuJiYj?=
 =?us-ascii?Q?2YCRXJ2Fs0OB2xpCRJwhYR3YV87DhWG7ecvv26hd+DAlUmosyD1ujMvuqcfl?=
 =?us-ascii?Q?sF3FG/56PhqJW8MPStAvn1d5EYghqrCMHQOQfnM6LyZrXOJZGnUnYMtH6p+g?=
 =?us-ascii?Q?DpRAYgFs/NhPESCjtWARBQo8kL2mzA54n9bB/B5tcfzSaNuA7apo8Kgtinyz?=
 =?us-ascii?Q?7GLyFr+VgsJSCUdVhy4h3YTxva1qNVGB3MHTHOiS4zpxnSHD3+28UylEkCg5?=
 =?us-ascii?Q?dXuAPUKnVqzKZV6WXnzMyl42L8j7nu8x6joREt4imQTq/V18GryHMLAeRsw/?=
 =?us-ascii?Q?BhuwiBLi3HGFbcGNMxuAt0/4tihXqdodHQKPnNbv24g/k98nWT5acZjODaji?=
 =?us-ascii?Q?Zi84rwJ6BA5CPsG/juG+vq8bijojoD0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687ef2c8-a54d-4188-27d2-08deb19cd657
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:30.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p93ZHPsX+/1eksLVNGQwxYnoXIxzjD5f550v3S8l6LUWuFgs1Evg3ppYCM5KAUc2qVsiJPdUl15+utqDPm1kcpmJ8vdNcyTNH/q0GFU+MCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22943

[ Upstream commit 346dd3422ed9ff56f033726a50fad2da5677eb12 ]

In preparation for adding RZ/G3E support, move the RST_RSM_B register
offset and mask into a SoC-specific data structure. Compared with RZ/G3S,
the RZ/G3E SYSC controls different functionalities for the PCIe controller.

Make SYSC operations conditional on the presence of register offset
information, allowing the driver to handle SoCs that don't use the
RST_RSM_B signal.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-8-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 111 +++++++++++++++++------
 1 file changed, 85 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index f47a9a9427b4..e4102744aab4 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -158,10 +158,6 @@
=20
 #define RZG3S_PCI_CFG_PCIEC			0x60
=20
-/* System controller registers */
-#define RZG3S_SYS_PCIE_RST_RSM_B		0xd74
-#define RZG3S_SYS_PCIE_RST_RSM_B_MASK		BIT(0)
-
 /* Maximum number of windows */
 #define RZG3S_MAX_WINDOWS			8
=20
@@ -173,6 +169,44 @@
 /* Timeouts experimentally determined */
 #define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
=20
+/**
+ * struct rzg3s_sysc_function - System Controller function descriptor
+ * @offset: Register offset from the System Controller base address
+ * @mask: Bit mask for the function within the register
+ */
+struct rzg3s_sysc_function {
+	u32 offset;
+	u32 mask;
+};
+
+/**
+ * enum rzg3s_sysc_func_id - System controller function IDs
+ * @RZG3S_SYSC_FUNC_ID_RST_RSM_B: RST_RSM_B SYSC function ID
+ * @RZG3S_SYSC_FUNC_ID_MAX: Max SYSC function ID
+ */
+enum rzg3s_sysc_func_id {
+	RZG3S_SYSC_FUNC_ID_RST_RSM_B,
+	RZG3S_SYSC_FUNC_ID_MAX,
+};
+
+/**
+ * struct rzg3s_sysc_info - RZ/G3S System Controller info
+ * @functions: SYSC function descriptors array
+ */
+struct rzg3s_sysc_info {
+	const struct rzg3s_sysc_function functions[RZG3S_SYSC_FUNC_ID_MAX];
+};
+
+/**
+ * struct rzg3s_sysc - RZ/G3S System Controller descriptor
+ * @regmap: System controller regmap
+ * @info: System controller info
+ */
+struct rzg3s_sysc {
+	struct regmap *regmap;
+	const struct rzg3s_sysc_info *info;
+};
+
 /**
  * struct rzg3s_pcie_msi - RZ/G3S PCIe MSI data structure
  * @domain: IRQ domain
@@ -202,6 +236,7 @@ struct rzg3s_pcie_host;
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
  *              configuration
+ * @sysc_info: SYSC info
  * @num_power_resets: number of power resets
  * @num_cfg_resets: number of configuration resets
  */
@@ -209,6 +244,7 @@ struct rzg3s_pcie_soc_data {
 	int (*init_phy)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
+	struct rzg3s_sysc_info sysc_info;
 	u8 num_power_resets;
 	u8 num_cfg_resets;
 };
@@ -232,7 +268,7 @@ struct rzg3s_pcie_port {
  * @dev: struct device
  * @power_resets: reset control signals that should be set after power up
  * @cfg_resets: reset control signals that should be set after configurati=
on
- * @sysc: SYSC regmap
+ * @sysc: SYSC descriptor
  * @intx_domain: INTx IRQ domain
  * @data: SoC specific data
  * @msi: MSI data structure
@@ -247,7 +283,7 @@ struct rzg3s_pcie_host {
 	struct device *dev;
 	struct reset_control_bulk_data *power_resets;
 	struct reset_control_bulk_data *cfg_resets;
-	struct regmap *sysc;
+	struct rzg3s_sysc *sysc;
 	struct irq_domain *intx_domain;
 	const struct rzg3s_pcie_soc_data *data;
 	struct rzg3s_pcie_msi msi;
@@ -259,6 +295,23 @@ struct rzg3s_pcie_host {
=20
 #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host,=
 msi)
=20
+static int rzg3s_sysc_config_func(struct rzg3s_sysc *sysc,
+				  enum rzg3s_sysc_func_id fid, u32 val)
+{
+	const struct rzg3s_sysc_info *info =3D sysc->info;
+	const struct rzg3s_sysc_function *functions =3D info->functions;
+
+	if (fid >=3D RZG3S_SYSC_FUNC_ID_MAX)
+		return -EINVAL;
+
+	if (!functions[fid].mask)
+		return 0;
+
+	return regmap_update_bits(sysc->regmap, functions[fid].offset,
+				  functions[fid].mask,
+				  field_prep(functions[fid].mask, val));
+}
+
 static void rzg3s_pcie_update_bits(void __iomem *base, u32 offset, u32 mas=
k,
 				   u32 val)
 {
@@ -1544,6 +1597,7 @@ static int rzg3s_pcie_probe(struct platform_device *p=
dev)
 	struct device_node *sysc_np __free(device_node) =3D
 		of_parse_phandle(np, "renesas,sysc", 0);
 	struct rzg3s_pcie_host *host;
+	struct rzg3s_sysc *sysc;
 	int ret;
=20
 	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*host));
@@ -1555,6 +1609,13 @@ static int rzg3s_pcie_probe(struct platform_device *=
pdev)
 	host->data =3D device_get_match_data(dev);
 	platform_set_drvdata(pdev, host);
=20
+	host->sysc =3D devm_kzalloc(dev, sizeof(*host->sysc), GFP_KERNEL);
+	if (!host->sysc)
+		return -ENOMEM;
+
+	sysc =3D host->sysc;
+	sysc->info =3D &host->data->sysc_info;
+
 	host->axi =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->axi))
 		return PTR_ERR(host->axi);
@@ -1568,15 +1629,13 @@ static int rzg3s_pcie_probe(struct platform_device =
*pdev)
 	if (ret)
 		return ret;
=20
-	host->sysc =3D syscon_node_to_regmap(sysc_np);
-	if (IS_ERR(host->sysc)) {
-		ret =3D PTR_ERR(host->sysc);
+	sysc->regmap =3D syscon_node_to_regmap(sysc_np);
+	if (IS_ERR(sysc->regmap)) {
+		ret =3D PTR_ERR(sysc->regmap);
 		goto port_refclk_put;
 	}
=20
-	ret =3D regmap_update_bits(host->sysc, RZG3S_SYS_PCIE_RST_RSM_B,
-				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
-				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
+	ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);
 	if (ret)
 		goto port_refclk_put;
=20
@@ -1628,9 +1687,7 @@ static int rzg3s_pcie_probe(struct platform_device *p=
dev)
 	 * SYSC RST_RSM_B signal need to be asserted before turning off the
 	 * power to the PHY.
 	 */
-	regmap_update_bits(host->sysc, RZG3S_SYS_PCIE_RST_RSM_B,
-			   RZG3S_SYS_PCIE_RST_RSM_B_MASK,
-			   FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
+	rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
 port_refclk_put:
 	clk_put(host->port.refclk);
=20
@@ -1642,7 +1699,7 @@ static int rzg3s_pcie_suspend_noirq(struct device *de=
v)
 	struct rzg3s_pcie_host *host =3D dev_get_drvdata(dev);
 	const struct rzg3s_pcie_soc_data *data =3D host->data;
 	struct rzg3s_pcie_port *port =3D &host->port;
-	struct regmap *sysc =3D host->sysc;
+	struct rzg3s_sysc *sysc =3D host->sysc;
 	int ret;
=20
 	ret =3D pm_runtime_put_sync(dev);
@@ -1661,9 +1718,7 @@ static int rzg3s_pcie_suspend_noirq(struct device *de=
v)
 	if (ret)
 		goto cfg_resets_restore;
=20
-	ret =3D regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
-				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
-				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
+	ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
 	if (ret)
 		goto power_resets_restore;
=20
@@ -1686,12 +1741,10 @@ static int rzg3s_pcie_resume_noirq(struct device *d=
ev)
 {
 	struct rzg3s_pcie_host *host =3D dev_get_drvdata(dev);
 	const struct rzg3s_pcie_soc_data *data =3D host->data;
-	struct regmap *sysc =3D host->sysc;
+	struct rzg3s_sysc *sysc =3D host->sysc;
 	int ret;
=20
-	ret =3D regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
-				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
-				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
+	ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);
 	if (ret)
 		return ret;
=20
@@ -1720,9 +1773,7 @@ static int rzg3s_pcie_resume_noirq(struct device *dev=
)
 	reset_control_bulk_assert(data->num_power_resets,
 				  host->power_resets);
 assert_rst_rsm_b:
-	regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
-			   RZG3S_SYS_PCIE_RST_RSM_B_MASK,
-			   FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
+	rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
 	return ret;
 }
=20
@@ -1745,6 +1796,14 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_da=
ta =3D {
 	.cfg_resets =3D rzg3s_soc_cfg_resets,
 	.num_cfg_resets =3D ARRAY_SIZE(rzg3s_soc_cfg_resets),
 	.init_phy =3D rzg3s_soc_pcie_init_phy,
+	.sysc_info =3D {
+		.functions =3D {
+			[RZG3S_SYSC_FUNC_ID_RST_RSM_B] =3D {
+				.offset =3D 0xd74,
+				.mask =3D BIT(0),
+			},
+		},
+	},
 };
=20
 static const struct of_device_id rzg3s_pcie_of_match[] =3D {
--=20
2.25.1



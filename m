Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCE1CD4F3E
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:54 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7016.1778751770360672340
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Z/YiT5Ud;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.52, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diR0p5PDIgcDOdur/GIoxlcNvxgG+0jkL9mXdmVED0K/xxPx6Q+xHzX8x4LN6zZJQmq4EQtUUAZIk0kB96N5qrmRcmrAikPzIFnMsvFvXIwY7wyCjagCAA/xuLnVTp4h1PlnbE+koMzz6Gl0E+cGdE8wT7gaOFbzrEO1cc+6n0SAjr0jYCLNR88IIRTqbHXZt+zaPqFbQ4otWs6E7H/LGal8Tbd/oMkh1OYtbW+8sJf5QeKX+moDe/MsW6jw8QNgSMgcPURlSTt04HCAmV7fXQnzOU0+NkvX4rUEFHsMBC3c1JWB8SRYC//0+hWTufJavy38fzGe5DR/ekO+EJpriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0CyDnPaEnaARqj2h9XQYdTSzDu9xYsZrkNkG+kl1m4=;
 b=e7/+/Q0hWLqiHLtVNhAzJaVtqB4N8wctBTJM14q9qIVYc4j44gwH7T/PASWt27rNsacNEFBxo9OVRXzbvAlmP9Kqo6y/yaqWtc4D68PIC4zkHuJ3ni5bnMx5cb83fFua7njh1RUoNV5CS9x+eqbboOfJsdalcSuAuXFI86AiRDZCWYLE4BV4wNi6iI9VHQf1+i+3h7DuyPsV5viDmQQEjvDLScYUqO6g2VtaBgVyRJGZKiPF6s+XmXrv7EHDin9F7aJxWNTzy/CitvndlQur09d57iFT68MqCb4xRw7eAMF2x29hpRla4wy1rerve46jEN72w73gef9aQNOMbFu7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0CyDnPaEnaARqj2h9XQYdTSzDu9xYsZrkNkG+kl1m4=;
 b=Z/YiT5Udqr/dl9FMTce0AgPEMYKZUia2h7MNFS9UVjHkDqeJLDWTrmWKqzMU6bbbS+vgEdwwRYza+TMWOBCwD15SYwhV6F/v4XYCewYpgGNlP1uuVt/QPa35TF9qaBaxFazoi/h5JsQjzcBBP/RknZy+zxWN/7XkR/J3k3tukek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:47 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:47 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 09/17] PCI: rzg3s-host: Make SYSC register offsets SoC-specific
Date: Thu, 14 May 2026 09:41:44 +0000
Message-ID: <20260514094152.2215176-10-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB13906:EE_
X-MS-Office365-Filtering-Correlation-Id: 695609ac-2f8b-4886-c3db-08deb19d280a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	sCgdryhBqPWVRsKX9P8EDjaTIJ7EB0ah9GGPaSiKX21XE2yMqfrGctxRsZMneRyIQKWPQDwPXI0tF9B62B9K2EGfA2fLOUOa6277E+AZUuYzeq8cN0ZW74hozSpJtjLlijCJmIwBAoUC6M1Wpgday82sWaYREfWJf93PbWIQX+wKdT8vblg4T9oWkVqwZ7JktmuKR86maRs8M7aOdRPRmLw5OvElMOeZhM7e7sFWWufLHAASfsOvRE9H3iLRXj7YSZt18ai5P3pVoRsWIiVDX9ykigjbYbY/2uvTJNaqhfyG61PnqWyhaPfH4I8u6XosTt9Tee9rNJlIk8DQ0qs3IPq8ksX7OGoJgh1btxEYMMGSLVFua3prJRs8bzSDh5O3mLtn1gpUPEnTyUtcwM1hUafmrq/4LLZm3J6fFFXHXhm9Aaem0Ot8jFOjF2l9+zEvuxaqdwQgC9a4J/YpdCcZvRarn+Mt9jSAsej2BgQ2p/BYSYeckhw8hH0Pw5Cdyym5lpOGqDl68cshmOlq1yLoE4Y/r5Zu4+PNHyKgHNM+hP8sE7oeJSG/VkM2FxVdr2GAn6x3KMGgQXjTaKq0PFAR7JcA6fhVuAUkl94ki3TmNcdXlI7i0PgGpwtPXhHD6PB2UWtBdwzrWyH82ZZQLWGxdvp2M8SOD4OyImF95HNOMmdF+Va2NuL0voZojlgg6m/2Wls5PDef+aF3IUaKSICxcg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oWkOkkx7RUR0k2KqpyiZVcuQa/JMES06fRYVc7hNQfapkI7NBz6n5DhyGSgD?=
 =?us-ascii?Q?8f03LfK+t93W0pHQTPyVhkEuIfMwQx9gdKv9N29afXI6mzFubwKdsVZrBuls?=
 =?us-ascii?Q?tO942MsWVZALufTxsL43fSY1gsDI2a79huyEm3Rj84T7NqXwgIBHcZUmSp5U?=
 =?us-ascii?Q?qaC5CymdWR1PAdN1LQ7XBxx6wL5zOu+bs1AXAmZXLomxu0hvyn/idmbyIWM2?=
 =?us-ascii?Q?yPFCJkfEm1aNlwmPXrkR2U+kLsEcxOu5mu0rRpmAnb54m7NKPMJ0XSfi3DTO?=
 =?us-ascii?Q?JUcfGjnC0o51eLOwuz0Os2ZMKyrJf1giBSnci9+wtig1QEnOPcCsflLo7uv6?=
 =?us-ascii?Q?6ATw2CtrQgD7m+VlO+Yi6MuqC57b8AEe2H4dcnMv2K+FZ5tzOxOf19jPqAoX?=
 =?us-ascii?Q?U1/V3aGmYntNCsgDQ38bed2tea6XkTxGOBITiwS7dydaq2zIAwChG/rgoz4b?=
 =?us-ascii?Q?2hptXfvbhk3C65Nq0Az6AnvuVpllh9b8/lTIRgsRdqKWLexEDxqjJXILW5xk?=
 =?us-ascii?Q?1O0BAeHMZ9tyz1KFsUKd3G+2mcsqCTMsltuKxHCpt96lqiWstXJ2cN7k7ESX?=
 =?us-ascii?Q?JcHlHFGA4SRAKF+uhjwIKy/OoS2dZRhExWc/A/77Z/dXvnfO0UGco1UnnEOJ?=
 =?us-ascii?Q?pUywRL7+HC89agh1Bc8X6xV/iixRCa5Rs0DJL6YNQWqTrYMXrgkb2HBNyoiw?=
 =?us-ascii?Q?K7r6q84vf+a7eb4zsE3i/s04U9gn2cNul6QbTHfrVlnSyIb3dwJgRUaohgu+?=
 =?us-ascii?Q?S/fIPGQ7HbuE8H/AlnuQ8EWsA3+p2FVgFDmqqLoH82VZgOoviumxrIDW1N4K?=
 =?us-ascii?Q?ixjw8dyr4ipY1EA0sIbu6Qy3W9eUc0WOT8dNxY7Plyiyx7rsrSyh46ugd8Vi?=
 =?us-ascii?Q?sLS7/xFGukweVFlly6addDZ1szdZPNF4rHaRcwD9sg88xDOfSVgXirQIIoli?=
 =?us-ascii?Q?jekRmLPGgsi9nkHZzfXn8P/lh72gnxTYB+nsmZsP2Qx9VeoTgcjr9OJkkbgj?=
 =?us-ascii?Q?xh0517hEvxyPQCMl/lyiVXukJ0vvC04mkr2eVoolcpn5UYsW1yj5gLZMw+ma?=
 =?us-ascii?Q?FPt8Bn9tMHt9V0ay1XebLz0bfTEVds8YUTF0DlLUYh9F87P//Hy2DjZ5umP9?=
 =?us-ascii?Q?+B9+4+/npqCeIxOCZ0+Oo5m5BAQ5nTP5kwu3caMMofOd/brRzDXPbe+nrEkq?=
 =?us-ascii?Q?r8c1Po2a6PWvIFbkmyz9MazQdgAOfwnXyax7qOAgS44I7E3ldfNnX7h3lyML?=
 =?us-ascii?Q?/U8BWY1/JmGELJD5Xv23Az9ZE9G+eQQFHsLLvv6tncBNkJZes6NTa1zODC9D?=
 =?us-ascii?Q?x15whU+qYxT0bDw0njPjCEgoFBhcDSwCqsQLOxrlNbmw35HR4Dh5R+mZiklD?=
 =?us-ascii?Q?3gI87WxeKOkWsBkgcpwbH4pRJkBzZTHVMj0ktbOoiaxfpWY6F+sq9D3RwKxR?=
 =?us-ascii?Q?P3nByjaFqyiq3u25vGNmajZbKn50C0Jxej5AyYH/EfvZt2t6V3dmutTUsOzP?=
 =?us-ascii?Q?MmQzYC2p6pFJCLxPDknDdsHsaoDCngXWxQQNbv8WmhyAq21DikyEwlWzALb7?=
 =?us-ascii?Q?ubtg0qCpxSnt84e4hVwfufFnAoWix2BQs+vunmi5bJuXUD8Eo8QBzNJ1ijp2?=
 =?us-ascii?Q?yftQ4RyJFHTPFBODRMuES9yMZa78Wyl0QHtP2nmfZfM3VwMpn5xQdjmjruNz?=
 =?us-ascii?Q?1EwT9z6RHYhqQ9TcabaMkib0RNO1HgXxaD3299dot/85x8//O9/oe1z+ACOg?=
 =?us-ascii?Q?GDBgfMinvyOmB/wKScA2F5QanFD4uqs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695609ac-2f8b-4886-c3db-08deb19d280a
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:47.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJSYkazOFdyxwITXMsjY7qkuznJnvMok/TGcp+PxeNxcNzqGo1uO6yecVo2vzkcLeLU8rE/uOibbgicaT2LWYZJeqiu8V/G5Fv4UezhIfec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22961

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



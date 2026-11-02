Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11644.1793624006994360997
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 04:53:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=A8E+zPJQ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.3, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb80jSy8wjkSQ4OcLyuJ96z4Bi2JkpzmyVEN9jNbT6A8mMewKwKWSvfxJv2rzJgK9MsIZ9PEpznaNTHXgKw0pL5rDrA7ugJ15RgC+p2U8yWM+F0VJqS8QKO+8MLJhwWomrFduB/K0bbuddb6kiVXPkVUOVn3tlMzvORQcWJZ06z5nqleI7kfdwYjfk0uAQUcyoNPboYbhEqPmkpmj9XlBJIcRusRVNcwC8Msd3qFh1clujSvddbFFwNVB5+ioGE/fqoXbvnREAm9OMVWFVaDzbgK5XCJXYhKPyc4UVtJTqCJOL1blisFTMjbx7K15df5N0hNoLU+lgdswOY/Xbq84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm0loX6P6cypiP7LD91UEoJAnKBvwMdKb0FKi2hvnaE=;
 b=pNsyLB1lInvIVnKI/ZZCfzhshcVY9p1Avpcvzppb2ehYS5rTH6WPWgnGKqwXEp8FKIswOo3Qs4PLcEA3x5sUgB/QpCtHoi+mC3EfYo1iTPvyL67FP48dd928k8ZEqaoq9knogUaCCD3Qz5EHBRrzaZpwlr6qPAFMFq4RB9w3h0vYShev9wfH4dj3GzNMgO/p4dFWKzvKMofk2kMg1559YDQOwoXMpLcJC5279iv2Byfx17DB9J55ydOVXH0HZ7lt1Ssy+Z3rkLV0sZiurE3l9eqFaipnXHhusZHp3GmQ4LDixcveH4R56Nz6/GKznALti2pm+jIcwV2VX1FKU7Yu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm0loX6P6cypiP7LD91UEoJAnKBvwMdKb0FKi2hvnaE=;
 b=A8E+zPJQiP6HLUDZL9ZOlX0iU/bCREX8Khmxkxq9nTEfHS3sEOmv5MyJ8l/aHt85Ohp6kTcqrXcwviHDoCdVzbdJYHKqr+KgtKDUG0DxPyIGNGJnYL45c53o9/LTfahfFGRRGAz2elPD2Z91TTVXo5gw0adCVmGFbSpVc2diScE=
Received: from TYCP286CA0299.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c8::19)
 by OS9PR01MB12198.jpnprd01.prod.outlook.com (2603:1096:604:2e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:53:20 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8:cafe::e) by TYCP286CA0299.outlook.office365.com
 (2603:1096:400:3c8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:53:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 12:53:20 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 2E1B43000230;
	Mon,  2 Nov 2026 21:53:18 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 4/7] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
Date: Mon,  2 Nov 2026 12:53:06 +0000
Message-ID: <20261102125309.7743-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|OS9PR01MB12198:EE_
X-MS-Office365-Filtering-Correlation-Id: 352e7abd-e757-41bf-7872-08df38e04617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|13003099007|56012099006|11063799006|261021121427099003|261022075727099003|261022105027099003|261026140227099003|261009221227099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: zqUBHLMgGTNB+82CTCcdOx6SB1kjQ+N0e0n5AFRf9EqqZMqcUPuS/9tCMgeKN8iGNtXlq8QM4UpCuNAb1dBKvK4d3EJCdQl/uTIJCDePs8Y+LoX4+yA2MhmnIEY1FMVocX91O6FZeP5HG7gyd5x3VTnq8OjwHMUlpwWm6cfBhq3/9b6cjLnSd9AleqNartXEwll32q4Qk/eGlAVWJ/tRSG7hVJ8cOhbnsJCes3JT4NlM3aJ32cawshv833AAF6/S3nV3Ogj+HIh/tuLUGp5QrBAoBkj+arYNbbJGhJWYsirSssG3I6FvqE6UnDAH6x0dFzCqqe8Jkb+ssnLmR3/5TMcWD+MiunGQ/o8d7z3svHL8vogWiN8eQ0dk5qGzmPgxD6BroJKQb31Aq5o7bJRn/FsZdkNOixKgXPcOLPtzsJwqve+u5iuXZ4W+D6NFWNd7I1/roMa/L+962duGOJFapCiLKNEkFl6GqSwic5xSJPQSeoOQxuUpeKMJhIX7lz3MSKmFgkJZjVsXOfuTlkSAGv5fXgVV186aGiqBDiQzt+oHeyw1A0auItJTBBCtXnYZsnBUmCjL6nPMpRaIx0sr4wP79MOzHS+IQ4qiwdwLpDS44+GVb83Q4+nMdzT2rTqC3XiWr3woWnadTZ+pMAMmZEr8ua+8aIV1UTsHWawqjKM=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(13003099007)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(261009221227099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ASYYWC78E0vChE9OEQxMx2a1hxI0uWLrMQVs4skO8KoMHfdi8C0hdd9cOZ0hoJttwn2SHXisJnLpmX2NeFaPEAMvyYcfR8/0ysI6tHDtEXc3TyuSgnVh2J8GHjMxMd4G9q+1ke+eVT/FAiXeDXa5uoTp+xoHXYqWR/4VfQ7osD7pBAkA1qVmeY/B0grAcHeRHnu49Om++u6HwZ1ZmptIyDC/Ao+f9KNW1nosR+jb7nwk0Itw3xCPl0p6faQZWyqW7Inlqv8zy6cdn0YPw5XSmLdICJOuna7TtwQpUfATFhDWAMw9UHOUKP/aUOFE1slxFpGe4w0M17W043MJ7BFPiIsgtSVS787vZ9wcdGQ+2CVKc0VZFH0w3Ojs8MVYxue+4bUFQFkmnOud/f0FbAwIve8b4VP6YQmA6le7+TRIGG9V5puFDWN0CLbja2nR5BDJ
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:53:20.9167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352e7abd-e757-41bf-7872-08df38e04617
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12198
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 12:53:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24606
Content-Type: text/plain; charset="utf-8"

commit 007c7304d80f1462b98a36284f45adcc1eb8adec upstream.

Add support for the RZ/V2H(P) SoC PCIe controllers to the rzg3s-host
driver.

The RZ/V2H(P) SoC features two independent PCIe controllers that share
four physical lanes. The hardware supports two configuration modes:
single x4 mode where the first controller uses all four lanes, or dual
x2 mode where both controllers use two lanes each.

Introduce a setup_lanes() function pointer to configure the PCIe lanes
based on the hardware instance. Implement rzv2h_pcie_setup_lanes() to
detect the configuration at boot time and program the lane mode via the
system controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260629220932.861445-5-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 181 +++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 01818f3b5421f..218fc97812000 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -178,6 +178,16 @@
 /* Timeouts experimentally determined */
 #define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
=20
+/**
+ * enum rzg3s_sysc_link_mode - PCIe link configuration modes
+ * @RZG3S_SYSC_LINK_MODE_SINGLE_X4: Single port with x4 lanes
+ * @RZG3S_SYSC_LINK_MODE_DUAL_X2: Dual ports with x2 lanes each
+ */
+enum rzg3s_sysc_link_mode {
+	RZG3S_SYSC_LINK_MODE_SINGLE_X4 =3D 1,
+	RZG3S_SYSC_LINK_MODE_DUAL_X2 =3D 3,
+};
+
 /**
  * struct rzg3s_sysc_function - System Controller function descriptor
  * @offset: Register offset from the System Controller base address
@@ -193,12 +203,14 @@ struct rzg3s_sysc_function {
  * @RZG3S_SYSC_FUNC_ID_RST_RSM_B: RST_RSM_B SYSC function ID
  * @RZG3S_SYSC_FUNC_ID_L1_ALLOW: L1 allow SYSC function ID
  * @RZG3S_SYSC_FUNC_ID_MODE: Mode SYSC function ID
+ * @RZG3S_SYSC_FUNC_ID_LINK_MASTER: Link master SYSC function ID
  * @RZG3S_SYSC_FUNC_ID_MAX: Max SYSC function ID
  */
 enum rzg3s_sysc_func_id {
 	RZG3S_SYSC_FUNC_ID_RST_RSM_B,
 	RZG3S_SYSC_FUNC_ID_L1_ALLOW,
 	RZG3S_SYSC_FUNC_ID_MODE,
+	RZG3S_SYSC_FUNC_ID_LINK_MASTER,
 	RZG3S_SYSC_FUNC_ID_MAX,
 };
=20
@@ -260,6 +272,7 @@ struct rzg3s_pcie_host;
  * @config_pre_init: Optional callback for SoC-specific pre-configuration
  * @config_post_init: Callback for SoC-specific post-configuration
  * @config_deinit: Callback for SoC-specific de-initialization
+ * @setup_lanes: Callback for setting up the number of lanes
  * @power_resets: array with the resets that need to be de-asserted after
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
@@ -267,17 +280,20 @@ struct rzg3s_pcie_host;
  * @sysc_info: System Controller info for each controller
  * @num_power_resets: number of power resets
  * @num_cfg_resets: number of configuration resets
+ * @num_pcie_controllers: number of PCIe controllers
  */
 struct rzg3s_pcie_soc_data {
 	int (*init_phy)(struct rzg3s_pcie_host *host);
 	void (*config_pre_init)(struct rzg3s_pcie_host *host);
 	int (*config_post_init)(struct rzg3s_pcie_host *host);
 	int (*config_deinit)(struct rzg3s_pcie_host *host);
+	int (*setup_lanes)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
 	struct rzg3s_sysc_info sysc_info[RZG3S_PCIE_CONTROLLER_ID_MAX];
 	u8 num_power_resets;
 	u8 num_cfg_resets;
+	u8 num_pcie_controllers;
 };
=20
 /**
@@ -308,6 +324,7 @@ struct rzg3s_pcie_port {
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
  * @controller_id: PCIe controller identifier, used for System Controller =
access
+ * @num_lanes: The number of lanes
  */
 struct rzg3s_pcie_host {
 	void __iomem *axi;
@@ -324,10 +341,23 @@ struct rzg3s_pcie_host {
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
 	enum rzg3s_pcie_controller_id controller_id;
+	u8 num_lanes;
 };
=20
 #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host,=
 msi)
=20
+/*
+ * RZ/V2H(P) supports a total of 4 lanes shared across two controllers.
+ * rzv2h_lane_lock serialises both the counter update and the SYSC
+ * register write so that concurrent async probes cannot race on the
+ * shared LINK_MASTER register (offset 0x1060).
+ * rzv2h_num_total_lanes tracks global lane usage to prevent
+ * over-allocation or invalid bifurcation modes.
+ */
+#define RZV2H_PCIE_MAX_LANES		4
+static DEFINE_SPINLOCK(rzv2h_lane_lock);
+static u8 rzv2h_num_total_lanes;
+
 static int rzg3s_sysc_config_func(struct rzg3s_sysc *sysc,
 				  enum rzg3s_sysc_func_id fid, u32 val)
 {
@@ -1177,6 +1207,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_=
host *host)
 	rzg3s_pcie_update_bits(host->pcie, PCI_CLASS_REVISION, mask,
 			       field_prep(mask, PCI_CLASS_BRIDGE_PCI_NORMAL));
=20
+	if (host->num_lanes) {
+		rzg3s_pcie_update_bits(host->pcie + RZG3S_PCI_CFG_PCIEC,
+				       PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_MLW,
+				       FIELD_PREP(PCI_EXP_LNKCAP_MLW,
+						  host->num_lanes));
+	}
+
 	/* Disable access control to the CFGU */
 	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
=20
@@ -1709,6 +1746,76 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 	return ret;
 }
=20
+static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
+{
+	struct device_node *np =3D host->dev->of_node;
+	struct of_phandle_args sysc_args;
+	int ret;
+
+	if (host->data->num_pcie_controllers =3D=3D 1)
+		return 0;
+
+	ret =3D of_parse_phandle_with_fixed_args(np, "renesas,sysc", 1, 0, &sysc_=
args);
+	if (ret)
+		return ret;
+
+	of_node_put(sysc_args.np);
+
+	if (sysc_args.args[0] >=3D host->data->num_pcie_controllers ||
+	    sysc_args.args[0] >=3D RZG3S_PCIE_CONTROLLER_ID_MAX)
+		return -EINVAL;
+
+	host->controller_id =3D sysc_args.args[0];
+
+	return 0;
+}
+
+static int rzv2h_pcie_setup_lanes(struct rzg3s_pcie_host *host)
+{
+	struct device_node *np =3D host->dev->of_node;
+	u32 num_lanes;
+	int ret;
+
+	ret =3D of_property_read_u32(np, "num-lanes", &num_lanes);
+	if (ret)
+		return ret;
+
+	/*
+	 * RZ/V2H(P) supports up to 4 lanes, but only in single x4 mode
+	 * for the first controller. Dual x2 mode is supported with 2
+	 * lanes for both controllers.
+	 */
+	if (num_lanes !=3D 4 && num_lanes !=3D 2)
+		return -EINVAL;
+
+	if (host->controller_id =3D=3D RZG3S_PCIE_CONTROLLER_ID_1 && num_lanes > =
2)
+		return -EINVAL;
+
+	guard(spinlock)(&rzv2h_lane_lock);
+	if (rzv2h_num_total_lanes + num_lanes > RZV2H_PCIE_MAX_LANES)
+		return -EINVAL;
+
+	ret =3D rzg3s_sysc_config_func(host->sysc, RZG3S_SYSC_FUNC_ID_LINK_MASTER=
,
+				     num_lanes =3D=3D 2 ?
+				     RZG3S_SYSC_LINK_MODE_DUAL_X2 :
+				     RZG3S_SYSC_LINK_MODE_SINGLE_X4);
+	if (ret)
+		return ret;
+
+	rzv2h_num_total_lanes +=3D num_lanes;
+	host->num_lanes =3D num_lanes;
+
+	return 0;
+}
+
+static void rzv2h_pcie_release_lanes(void *data)
+{
+	struct rzg3s_pcie_host *host =3D data;
+
+	guard(spinlock)(&rzv2h_lane_lock);
+	rzv2h_num_total_lanes -=3D host->num_lanes;
+}
+
 static int rzg3s_pcie_probe(struct platform_device *pdev)
 {
 	struct pci_host_bridge *bridge;
@@ -1733,6 +1840,10 @@ static int rzg3s_pcie_probe(struct platform_device *=
pdev)
 	if (!host->sysc)
 		return -ENOMEM;
=20
+	ret =3D rzg3s_pcie_get_controller_id(host);
+	if (ret)
+		return ret;
+
 	sysc =3D host->sysc;
 	sysc->info =3D &host->data->sysc_info[host->controller_id];
=20
@@ -1762,6 +1873,16 @@ static int rzg3s_pcie_probe(struct platform_device *=
pdev)
 	if (ret)
 		goto port_refclk_put;
=20
+	if (host->data->setup_lanes) {
+		ret =3D host->data->setup_lanes(host);
+		if (ret)
+			goto sysc_signal_restore;
+
+		ret =3D devm_add_action_or_reset(dev, rzv2h_pcie_release_lanes, host);
+		if (ret)
+			goto sysc_signal_restore;
+	}
+
 	ret =3D rzg3s_pcie_resets_prepare_and_get(host);
 	if (ret)
 		goto sysc_signal_restore;
@@ -1876,6 +1997,16 @@ static int rzg3s_pcie_resume_noirq(struct device *de=
v)
 	if (ret)
 		return ret;
=20
+	if (host->num_lanes) {
+		ret =3D rzg3s_sysc_config_func(host->sysc,
+					     RZG3S_SYSC_FUNC_ID_LINK_MASTER,
+					     host->num_lanes =3D=3D 2  ?
+					     RZG3S_SYSC_LINK_MODE_DUAL_X2 :
+					     RZG3S_SYSC_LINK_MODE_SINGLE_X4);
+		if (ret)
+			goto assert_rst_rsm_b;
+	}
+
 	ret =3D rzg3s_pcie_power_resets_deassert(host);
 	if (ret)
 		goto assert_rst_rsm_b;
@@ -1923,6 +2054,7 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_dat=
a =3D {
 	.num_power_resets =3D ARRAY_SIZE(rzg3s_soc_power_resets),
 	.cfg_resets =3D rzg3s_soc_cfg_resets,
 	.num_cfg_resets =3D ARRAY_SIZE(rzg3s_soc_cfg_resets),
+	.num_pcie_controllers =3D 1,
 	.config_post_init =3D rzg3s_pcie_config_post_init,
 	.config_deinit =3D rzg3s_pcie_config_deinit,
 	.init_phy =3D rzg3s_soc_pcie_init_phy,
@@ -1943,6 +2075,7 @@ static const char * const rzg3e_soc_power_resets[] =
=3D { "aresetn" };
 static const struct rzg3s_pcie_soc_data rzg3e_soc_data =3D {
 	.power_resets =3D rzg3e_soc_power_resets,
 	.num_power_resets =3D ARRAY_SIZE(rzg3e_soc_power_resets),
+	.num_pcie_controllers =3D 1,
 	.config_pre_init =3D rzg3e_pcie_config_pre_init,
 	.config_post_init =3D rzg3e_pcie_config_post_init,
 	.config_deinit =3D rzg3e_pcie_config_deinit,
@@ -1962,6 +2095,50 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_da=
ta =3D {
 	},
 };
=20
+static const struct rzg3s_pcie_soc_data rzv2h_soc_data =3D {
+	.power_resets =3D rzg3e_soc_power_resets,
+	.num_power_resets =3D ARRAY_SIZE(rzg3e_soc_power_resets),
+	.num_pcie_controllers =3D 2,
+	.config_pre_init =3D rzg3e_pcie_config_pre_init,
+	.config_post_init =3D rzg3e_pcie_config_post_init,
+	.config_deinit =3D rzg3e_pcie_config_deinit,
+	.setup_lanes =3D rzv2h_pcie_setup_lanes,
+	.sysc_info =3D {
+		[RZG3S_PCIE_CONTROLLER_ID_0] =3D {
+			.functions =3D {
+				[RZG3S_SYSC_FUNC_ID_L1_ALLOW] =3D {
+					.offset =3D 0x1020,
+					.mask =3D BIT(0),
+				},
+				[RZG3S_SYSC_FUNC_ID_MODE] =3D {
+					.offset =3D 0x1024,
+					.mask =3D BIT(0),
+				},
+				[RZG3S_SYSC_FUNC_ID_LINK_MASTER] =3D {
+					.offset =3D 0x1060,
+					.mask =3D GENMASK(9, 8),
+				},
+			},
+		},
+		[RZG3S_PCIE_CONTROLLER_ID_1] =3D {
+			.functions =3D {
+				[RZG3S_SYSC_FUNC_ID_L1_ALLOW] =3D {
+					.offset =3D 0x1050,
+					.mask =3D BIT(0),
+				},
+				[RZG3S_SYSC_FUNC_ID_MODE] =3D {
+					.offset =3D 0x1054,
+					.mask =3D BIT(0),
+				},
+				[RZG3S_SYSC_FUNC_ID_LINK_MASTER] =3D {
+					.offset =3D 0x1060,
+					.mask =3D GENMASK(9, 8),
+				},
+			},
+		},
+	},
+};
+
 static const struct of_device_id rzg3s_pcie_of_match[] =3D {
 	{
 		.compatible =3D "renesas,r9a08g045-pcie",
@@ -1971,6 +2148,10 @@ static const struct of_device_id rzg3s_pcie_of_match=
[] =3D {
 		.compatible =3D "renesas,r9a09g047-pcie",
 		.data =3D &rzg3e_soc_data,
 	},
+	{
+		.compatible =3D "renesas,r9a09g057-pcie",
+		.data =3D &rzv2h_soc_data,
+	},
 	{}
 };
=20
--=20
2.43.0


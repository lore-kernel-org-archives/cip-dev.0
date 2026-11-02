Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12031.1793624549217361241
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 05:02:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=n9vbZLy1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.12, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQkbKNT6WZiZqb+7ZodozU+ny96YdrVK5PqhCLlJZ9AvSQa1KuhFw3sUheEKZ6eaITFbM5wBhZYkKpd0eXX0Dv1u/GPYoCOSzH/4RGNWVxgSQARa/2KOkn8EQRI27MORH0YHOUu1vx5JjFMue2AgTKPKRbqCGxL/y24xNeT4wxSer7t6YwwVJK6IInfccwspEKNefqLJh8K+WUy42YBTJY7LxNcRE8jLvGBEeghkRCOGSjy2u9mbGeNd1GT/2/c+tDEuHGUis5P+wGBNeikhJgFp+RQGi9Cgq9rflEQGajW1HMi+elqfKE2Iw1WX1zggMFZcLBoP36IMXSybS8zNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7upFcy08JdSXDM9WLMAlWzL69lPeq8lqqonJb21FqA=;
 b=An/X1A6yPNlF2/s8NVkB9PocwlxsI1IsPPmx4FaoQ6R73sww47vOg5yUr4WTugmNdG6rffur6UTnS9nQD6/U5mz7StinDOjgDKwW2cpIFiLKwV2d1gUYcB2AOE5jwuR+8Qqmq16A4bdAVKsOTwX3Ez2oGk9WD+PgpHjVgj0ICerNejwts0sZdThDHSCmlIRdkIJMG2EEA1ERnumqmGiUGjMUJ5oV0YPNLqDt1CD8nCVSifW4KdKHUrad0lfRdX/jinX66BowcxDSMwJf7iZPH6mrFwjpfoLrG/QEfOSbIsBuCmdvBBDxFFGeB3QcbiwUg/tF0HWY5cIyQLWXiCTtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7upFcy08JdSXDM9WLMAlWzL69lPeq8lqqonJb21FqA=;
 b=n9vbZLy1mNMd7zTNJvqO1TsaLNFpmsQeClj1SS1L0T1vghW5Ui9Oi5WRR4iqsPyDTggBcBEUy+4/1hR3k8UKVTvYpoxKppA9Fdi08RSQ/lm+fOjAPZgfY9vSH78OegGLBSiGrQYIB+BR2SNzBUekKSspPMzu3NMS7COGSxp9bxU=
Received: from TY4P301CA0103.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:37b::18)
 by TY7PR01MB096914.jpnprd01.prod.outlook.com (2603:1096:403:409::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:02:23 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37b:cafe::22) by TY4P301CA0103.outlook.office365.com
 (2603:1096:405:37b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 13:02:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 13:02:23 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0D1723000230;
	Mon,  2 Nov 2026 22:02:21 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 4/7] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
Date: Mon,  2 Nov 2026 13:02:09 +0000
Message-ID: <20261102130212.8115-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TY7PR01MB096914:EE_
X-MS-Office365-Filtering-Correlation-Id: c06b28ee-183a-4a56-1d57-08df38e18967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|10067099003|18002099003|22082099003|13003099007|56012099006|11063799006|261026140227099003|261022105027099003|261022075727099003|261009223027099003|261009221227099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: VOGP/JmwIAOrVlTHCW+K4ydhDs08Qpfl8anr/ffGXGax0N3M8KD7LJKpHzJAsN9UY/8K0m9l3uaA/ybfAZKnIcilM/kgnk2VNt/+VuhnLAxvjnBAKeEZ10owQVgRMx1owCF35AmNMhu1nOOWER2fru0JxCab5RyxtPD0BDceeSiWK83+yFvsW3GVGoxDm8v8kgfHgMgpctJxuoN83oDOETsA2PNh74B/Imj1B6GadfIweQ4a1UUqVR+FJBji/ZqxX2zzD7xaCV3Kd4wIow7IJCfkf/6e3JJ8XPQ83Tp8yUdZ5I+nzBJn2MCKztiIYlXdSjJXXSunv+9C7JInfWfmXAsFpNrrQLzGmWFRtSTFPtlYcMyYdsrRTnnQ3p02joASf8wVakZ8zcvKjTGqODBHM+3QYFu2oNn1gfIPKwdZGia4wYayjgNx0vojJ79LbnrZXlDyZg57q8V18+8raxObBSyKu7uTh1F5eB0pMNz18NOmaINKQ6vzb31Sp0gEo7fzwSEW+nc7mAdswONDAl0vSUUB5Fi4EK9c6aRsoVaJdtVu1Q7YCOYE635vjprnxSPDzm7VIccFaW4A96MjrFP1bir2RGJBLu1PoKySYpie8CtgC74iYj6PgpURDa2GrUqZN8hPYL7rfXtQzEG2U6+uMRENzZeMZol0SPEA3FY1Bv8=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(13003099007)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261022075727099003)(261009223027099003)(261009221227099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VmezVWdffevffOQxefHBBVzvJ5JdWTgQlkFT/2t6WQ9+3ENWz0aaZrDO9WJU4dmcy5Jy7R3VC3WATnyD4UlhWyiYF1R7TGOoDkS4pOWye0GIa4MTQOG+7ercdCgiF7NqU40gfH8AfdUL4clvoNzobvR4RuQDAskLHBzIfZmhaCAkHMcvDcC3PGDebnQ7CsvCKezV52Sse3xD37mqi+QPcFfY/b6H//dwjhgeeMNsSwG4PU7uC6qslmf96rHPnxmAoRDB+nd9s7yLTWAggHCY0d+QF3TMQ11i7woz8aXUpx/Fv7V5u0p4MinaonnBZqoEpXABdrRnDrn4zyw8LkqspMQHL7UeRUBuOOUaa3CX0zLRcpH72UmMz8LC6mWbzP5+2Jnyd2BF/TC73MGRb4LxJ7dx8VDPIOYMZ0oIRoaA3ra34BrryTeNQABWpUOthJsB
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:02:23.3423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c06b28ee-183a-4a56-1d57-08df38e18967
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB096914
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 13:02:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24615
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
index 9b24da8da23c1..6c64217b89111 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -180,6 +180,16 @@
=20
 #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
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
@@ -195,12 +205,14 @@ struct rzg3s_sysc_function {
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
@@ -262,6 +274,7 @@ struct rzg3s_pcie_host;
  * @config_pre_init: Optional callback for SoC-specific pre-configuration
  * @config_post_init: Callback for SoC-specific post-configuration
  * @config_deinit: Callback for SoC-specific de-initialization
+ * @setup_lanes: Callback for setting up the number of lanes
  * @power_resets: array with the resets that need to be de-asserted after
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
@@ -269,17 +282,20 @@ struct rzg3s_pcie_host;
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
@@ -310,6 +326,7 @@ struct rzg3s_pcie_port {
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
  * @controller_id: PCIe controller identifier, used for System Controller =
access
+ * @num_lanes: The number of lanes
  */
 struct rzg3s_pcie_host {
 	void __iomem *axi;
@@ -326,10 +343,23 @@ struct rzg3s_pcie_host {
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
@@ -1179,6 +1209,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_=
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
@@ -1711,6 +1748,76 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
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
@@ -1735,6 +1842,10 @@ static int rzg3s_pcie_probe(struct platform_device *=
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
@@ -1764,6 +1875,16 @@ static int rzg3s_pcie_probe(struct platform_device *=
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
@@ -1878,6 +1999,16 @@ static int rzg3s_pcie_resume_noirq(struct device *de=
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
@@ -1925,6 +2056,7 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_dat=
a =3D {
 	.num_power_resets =3D ARRAY_SIZE(rzg3s_soc_power_resets),
 	.cfg_resets =3D rzg3s_soc_cfg_resets,
 	.num_cfg_resets =3D ARRAY_SIZE(rzg3s_soc_cfg_resets),
+	.num_pcie_controllers =3D 1,
 	.config_post_init =3D rzg3s_pcie_config_post_init,
 	.config_deinit =3D rzg3s_pcie_config_deinit,
 	.init_phy =3D rzg3s_soc_pcie_init_phy,
@@ -1945,6 +2077,7 @@ static const char * const rzg3e_soc_power_resets[] =
=3D { "aresetn" };
 static const struct rzg3s_pcie_soc_data rzg3e_soc_data =3D {
 	.power_resets =3D rzg3e_soc_power_resets,
 	.num_power_resets =3D ARRAY_SIZE(rzg3e_soc_power_resets),
+	.num_pcie_controllers =3D 1,
 	.config_pre_init =3D rzg3e_pcie_config_pre_init,
 	.config_post_init =3D rzg3e_pcie_config_post_init,
 	.config_deinit =3D rzg3e_pcie_config_deinit,
@@ -1964,6 +2097,50 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_da=
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
@@ -1973,6 +2150,10 @@ static const struct of_device_id rzg3s_pcie_of_match=
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


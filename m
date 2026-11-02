Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11866.1793624002188031157
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 04:53:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bwOf2AVi;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.53, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhB2iuF0pqgNf7rbZWZd+Y5/tYdmHLdjZzlpmT5dBz2u24D0K57Hvj2hAu33lhYSDVnjuzKjXyZyXWJEMG3CWIeGOqOZ7EBnuW9nqa+hj/xSZnSTXn/fJDkjLIoYJvwaJAkBCvvLlCKWM39zw8FRBXUbiynquJ5Ffx9Hvo+LIIQ6LK6X5uBEBXnRvlXqgbv875vrO5+pEYYP4mVn4B1FUXzCIJlUjDelz03k/mhW+wQnKxjUrNZvveizpLjXOuMcJT1AbU5iG5U3tPtqJVU/QsjHhrYGvk/+kzjK06pwK5DylmOSZjR+oaBfjfnaQCMygZQcCBb8tIRGbKZPEJ1Lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL/0Q49YzCz66jkElQm6EeI9DdMEUF9/bGPGouR/kCM=;
 b=iAde4IXHXJLj+xt6JLSzZtyTzLzl5+kyrdME4dghwnnK9vOJYCUk3qF6mOqk8nQWN5MXF0ZJio6TIJRpVJaLQ7QZaeGs9076rrhThLSYHKoXbD7Ln+4u4fwGrdLHK3v8xoxvsSvDPvi9RWpkEhg7JhpTFaWCYNj6EFf7N2sI2Z3UuXmpAINlOrXMdP/P9jISJJ42nZhNB+PVqN6XezF6LWPlVbFQdwYTzY8b6ninN5CudYV/gCPMqDKMwYrIxsBU84U5JtOlUwwp9WNG/jUIVVFFDHN7yPWzM5Rtn1ycgHXwVxuDVx2moMHPR8zwK3NmqWUD7wC6SbO9sqEv+FYV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL/0Q49YzCz66jkElQm6EeI9DdMEUF9/bGPGouR/kCM=;
 b=bwOf2AViNQvUaZNy0+dneGnObpA9hMc1azsT2AORVL0wbW3U7Vkfmz8uONJMZarYG48hgOyiwfRl2iGAd6o4tG80Nortt6Hh8MHa4MD2HzxFm240cu/YroRzYtVDAvwchgJYJZOz4IDVTjkorC6n/65kqmMNp2NPrVAtsAsxjB4=
Received: from TY4PR01CA0104.jpnprd01.prod.outlook.com (2603:1096:405:378::9)
 by OS7PR01MB18247.jpnprd01.prod.outlook.com (2603:1096:604:4bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Mon, 2 Nov
 2026 12:53:18 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:378:cafe::74) by TY4PR01CA0104.outlook.office365.com
 (2603:1096:405:378::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:53:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 12:53:18 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D3F833000230;
	Mon,  2 Nov 2026 21:53:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 3/7] PCI: rzg3s-host: Prepare System Controller handling for multiple controllers
Date: Mon,  2 Nov 2026 12:53:05 +0000
Message-ID: <20261102125309.7743-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|OS7PR01MB18247:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa41c36-bbc6-44fd-0647-08df38e044c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|261021121427099003|11063799006|56012099006|261009223027099003|261009221227099003|261028144727099003|261026140227099003|261021123027099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: GQIUfBCAGb0Nf0d/H2OtOO28bjOOSWnzuuuh7oo7vUc5vUuGclrKBO4dz6903nD7F+GpRjU/vbZPbhfgXI6sY5kcobAyBLLMhxVFfVoc/RD7KfkbC87o7qOKZbnNnwJddOTkPiOBmcTGLPk0L4sE2vThS08PvTYB6Z08AZ+1uw8ahhaPc5x+ru43ateTNceOVgLtFeHLOGAlqHdpIgBt/Z9sPjRWgzpcOBUJsKYLwEIPhjZtTu8SuWghGaBXgr3gVRcvTofQjXlnYc1ft+DI2dIrwgGuVG1UC9K57g9v2Z7Rmni2TkYoNvKZkaCCEswS+tsbOQ1QM4F9/g7sRjCUGJoFxb3zGCB/f4UeWYnE3JK+XIe14tDinT3i83jBWjs0ke9Zxg6vF67ZlUvBwtLgMLFdcgjvS/87zCDuNDbbIQm1Ulu9MWl1CSZNJ5ojmBPjW3rs5FQdzWBC0uTTfLFEr9mPpDVFMUCE20YLCfqR/y6lBvdrCOcG5bq5OkNplIoMSClPN4+5/jD04hKyoD5eskJnK8jlEW9YePPf/kexcenmSTfb5zuSGFqeaLMjlR1GR9cM4gtwRpQQZTr6jH/1+LDO3pxWs7kLmZWUm2p2FTKoaFYmkaACRP1IBk1q4wBQQBM6CeOoLDcUCg7O9FwW7EfeVbOCnoOF17/ESa2gLj4=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nq1NuE9S2uTM2LjdJhp/HVKBWvUj1hHPp9o+yII+4jAkYvDt8NWOsOgJuZccK65hWVKA9raJ5eB/chfvOsFR9r5YADh+fjmYsrm2OVq3deB6u85gw6KWmD5POEDXeqxAHuWqvKyVp0/S8IsE2X8H4g9AvPlZfTqhdbezEf2wJsMQ4MWyrzsNy9kHmtuqKq+msqEZMJoDNCrJn/YgnzAWf85DC/DLBNRjzaLuEwlYtlqO23uZbMqCgaZ9n7/JnbX7VpyyfaQ10pnPkxfGkSb7GZHB6+bMhAJ+QaAn5oPYI+/l6JmvrMy7iivMHdieH7f3iDzQODPfQMVfjOX/qx8M+lFBVOFM7qN/MsM4qLhmOYjrmsF0GiPxgvumyfBTDivX5B1fYcr9L9alX3tG2ANHZ5T7Niq105+9EYZPfW0J7+ntYu3Z5w8IlVaM7CzOEMrM
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:53:18.7086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa41c36-bbc6-44fd-0647-08df38e044c7
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18247
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 12:53:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24604
Content-Type: text/plain; charset="utf-8"

commit 9f2ed7c3de5dc4ccd223784d8ad80909a7bae884 upstream.

Prepare the driver to handle multiple PCIe controllers with distinct
System Controller (SYSC) register sets, as required by RZ/V2H(P). The
current design stores a single sysc_info structure per SoC, which is
insufficient for multi-controller configurations.

Introduce controller identifiers and extend struct rzg3s_pcie_soc_data
to hold a sysc_info array indexed per PCIe controller. Add a
controller_id field to struct rzg3s_pcie_host and select the appropriate
System Controller information during probe based on the hardware
instance.

Keep existing single-controller SoCs functionally unchanged while
preparing the driver for RZ/V2H(P) multi-controller support.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260629220932.861445-4-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 48 ++++++++++++++++--------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index f1f97e9a9336f..01818f3b5421f 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -240,6 +240,18 @@ struct rzg3s_pcie_msi {
 	int irq;
 };
=20
+/**
+ * enum rzg3s_pcie_controller_id - RZ/G3S PCIe controller IDs
+ * @RZG3S_PCIE_CONTROLLER_ID_0: PCIe controller 0
+ * @RZG3S_PCIE_CONTROLLER_ID_1: PCIe controller 1
+ * @RZG3S_PCIE_CONTROLLER_ID_MAX: Max PCIe controllers
+ */
+enum rzg3s_pcie_controller_id {
+	RZG3S_PCIE_CONTROLLER_ID_0,
+	RZG3S_PCIE_CONTROLLER_ID_1,
+	RZG3S_PCIE_CONTROLLER_ID_MAX,
+};
+
 struct rzg3s_pcie_host;
=20
 /**
@@ -252,7 +264,7 @@ struct rzg3s_pcie_host;
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
  *              configuration
- * @sysc_info: SYSC info
+ * @sysc_info: System Controller info for each controller
  * @num_power_resets: number of power resets
  * @num_cfg_resets: number of configuration resets
  */
@@ -263,7 +275,7 @@ struct rzg3s_pcie_soc_data {
 	int (*config_deinit)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
-	struct rzg3s_sysc_info sysc_info;
+	struct rzg3s_sysc_info sysc_info[RZG3S_PCIE_CONTROLLER_ID_MAX];
 	u8 num_power_resets;
 	u8 num_cfg_resets;
 };
@@ -295,6 +307,7 @@ struct rzg3s_pcie_port {
  * @hw_lock: lock for access to the HW resources
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
+ * @controller_id: PCIe controller identifier, used for System Controller =
access
  */
 struct rzg3s_pcie_host {
 	void __iomem *axi;
@@ -310,6 +323,7 @@ struct rzg3s_pcie_host {
 	raw_spinlock_t hw_lock;
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
+	enum rzg3s_pcie_controller_id controller_id;
 };
=20
 #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host,=
 msi)
@@ -1720,7 +1734,7 @@ static int rzg3s_pcie_probe(struct platform_device *p=
dev)
 		return -ENOMEM;
=20
 	sysc =3D host->sysc;
-	sysc->info =3D &host->data->sysc_info;
+	sysc->info =3D &host->data->sysc_info[host->controller_id];
=20
 	host->axi =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->axi))
@@ -1913,10 +1927,12 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_d=
ata =3D {
 	.config_deinit =3D rzg3s_pcie_config_deinit,
 	.init_phy =3D rzg3s_soc_pcie_init_phy,
 	.sysc_info =3D {
-		.functions =3D {
-			[RZG3S_SYSC_FUNC_ID_RST_RSM_B] =3D {
-				.offset =3D 0xd74,
-				.mask =3D BIT(0),
+		[RZG3S_PCIE_CONTROLLER_ID_0] =3D {
+			.functions =3D {
+				[RZG3S_SYSC_FUNC_ID_RST_RSM_B] =3D {
+					.offset =3D 0xd74,
+					.mask =3D BIT(0),
+				},
 			},
 		},
 	},
@@ -1931,14 +1947,16 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_d=
ata =3D {
 	.config_post_init =3D rzg3e_pcie_config_post_init,
 	.config_deinit =3D rzg3e_pcie_config_deinit,
 	.sysc_info =3D {
-		.functions =3D {
-			[RZG3S_SYSC_FUNC_ID_L1_ALLOW] =3D {
-				.offset =3D 0x1020,
-				.mask =3D BIT(0),
-			},
-			[RZG3S_SYSC_FUNC_ID_MODE] =3D {
-				.offset =3D 0x1024,
-				.mask =3D BIT(0),
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
 			},
 		},
 	},
--=20
2.43.0


Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12030.1793624548320008876
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 05:02:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=SNmPYPcH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.45, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5ABGyXj5T9EIo3CgYOay9EDzXmqaL6BSFXNu82GQL1AJDPHA88X3jc80pxmOyfQJlLE2cmNjXqPb4FKjzhgzxyqsGn+pEVZ93vj1yi8voIYEaJ7VFkyAzZI2jVFm6J78Sl0pG5idtr7LRR8KV/KVZFRXj/E9MoFvPoGTqqTpWbhNjzuop26axib6KtmDUUuOUSTqjwqRerXUurgm3QzQpE7yCb8/TNbkk46Nt+PGg5S4RDRFMXdl5XGsR3ymeuGeQbP+HZu7IuMk7iKHTq4qBTledWJtWIOg9z4stvq8+pLAOOOoE++hrtgwxc+glUD9lc26aFZAmLdRKo9m7fXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDFv+g9xUVdbI6crHjT90pesJBeactCm/rXjfP6ePTs=;
 b=WmsYZM+VsMTUaUv5tMKd5miQm/BNcyMEzPCnVLmRrv29eaJbP1DH8AFsGvakOPGdDXPDvGXywbQksecnORvgF87oPA7ekwtKd3iqp9NrdOfKJVPgydJYOA8uGWuKSXHKrZnaLDv1sHfvOIvaa+3qTjsUWDnbtETnlts8sln7ZZQJ4L4oDPGCry1PEOad7IiL85YvbV9QVKFQSE/lN6RGqQSHNwhPLfZqX4MqvCH776cfV0VIyUheLJZAWf5oUvqapTrw5O1pL0l0vgGgZlQHBxGCzApA4lL9AZKusd3IKzX0/8wvzUupaHW5u9Q5SspSiaKvb0P4K1BKKI+pphQUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDFv+g9xUVdbI6crHjT90pesJBeactCm/rXjfP6ePTs=;
 b=SNmPYPcHY3yDxHJusGqz5QWMRx+iv3p1ZOLsPl6OBMvOVxzEJiftD0hdUlricnMFqS9gnTHNgYRpZ3A+uyjCoPAigkme7qeYBP+R8vgmxuOJIPF0hDroMeNBAKraCIsE7ks2dlhtcK4AFphQLHYxsU7QTNHC/6eh7bVvwUGDLds=
Received: from TYCP301CA0048.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:384::17)
 by TYYPR01MB12708.jpnprd01.prod.outlook.com (2603:1096:405:15f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:02:21 +0000
Received: from TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:384:cafe::d) by TYCP301CA0048.outlook.office365.com
 (2603:1096:400:384::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 13:02:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4D.mail.protection.outlook.com (10.167.253.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 13:02:21 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D895B3000230;
	Mon,  2 Nov 2026 22:02:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/7] PCI: rzg3s-host: Prepare System Controller handling for multiple controllers
Date: Mon,  2 Nov 2026 13:02:08 +0000
Message-ID: <20261102130212.8115-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4D:EE_|TYYPR01MB12708:EE_
X-MS-Office365-Filtering-Correlation-Id: 2054d045-92fd-4faa-1a47-08df38e1884b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|13003099007|56012099006|11063799006|261021121427099003|261022075727099003|261022105027099003|261026140227099003|261009221227099003|261009223027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 4h+rpVovxsCCG1vLvw+Ea1GIqxEpK/P5Pa8eyujrq5XanCslxEjah5w1Gwo3BuEygQRha54RfQAmWfCqPY3PFLofdbjhd+aCXg2lzjDlj4GirnJVvRD95KLJertICH05PUqrmC2S2CdhVLgOvkwW/5yqQV7SYduXm0Fjr2NrT8SNKfXXH3yz5IO8oM+bBnPfy62VeJckyzPE10tiy/lozjYAkSoGUXYOYzXsDHq6jTsmcF1cTu1qyl1nbVf0ZP8BIVUNIv+6vEKeMPIUOr83U0nYiYa7wqhsp2C26atMhtBiw0SdtFvZnWeAJYjJ0BhA5MhRUrd+lIrUALfxVx6+jV3W30SfAUkD7jgmWUEm2vcpV6VaMbVtdtRiL/k8a4p/6P2zYXxNo0jb+JQT7jBbVKjthiOnHcaI3xzyelLeOgyC8HBfTrNxsdP2xjLa7g6iwgYJ2frtt2kQlEOagm5xr1Auv1YBUrxgH6swv9TbRfc8psH0dt4GwYja/TLrm18fq/LEf5JKUwR5eNweebU4VIyMeZ5srNraMSH7v28wIwGJuaGdlMv47aJTJhaTe3VfC9O6Argfjzbnp2iHhejwTssMjhWgif9Q2wQZusn6Efw4m5OpNc5EJxeAtsAJGT1kF90nkwYgt5bfupKlXm4t0MIuEETtDq0e2i1QX0uTkRc=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(13003099007)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(261009221227099003)(261009223027099003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ULsw9vCNWmvhCJPKc3UkhH9lWltBbss79TGliYHHtTlwcoK0Xs2lNu9KgiXts+UDIbdXPT/jhQxOTiGcoLXotjy7xYURIQ9XxvwZ+Jw4xN9E343IAroxERi+kncIH6u+ACFhKZA6RK133IpUW1obG2MH93q5XB42r+1PV3nU08lTaQAxXSfzQC5vmyGq9gG7BQkdoieNVo+kGJHeIq7sY+KtyzlZkdUFy9kmvW2t/Uhrc9J/xJeYEj2To2NykUIOQkHmdk8xGqxS8ZjHTm7CizL82/zTO+xPZ9bzYQDnJSRR99W6cySXU/n3v/usa39qJK7LvXhiuFklNeV2cx5KM/LQ6RvzdUWgymXGhfL/CqgMQiv9CmaYAsdAyuvvF6wGpE5Gh+5D/4NlEIiF6qZfPKyuyeAuWMQPt30fMO9Wq/WyAGXCRsaFf7xr782PMWnK
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:02:21.4782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2054d045-92fd-4faa-1a47-08df38e1884b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12708
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 13:02:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24613
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
index d6fe72e11f4cc..9b24da8da23c1 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -242,6 +242,18 @@ struct rzg3s_pcie_msi {
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
@@ -254,7 +266,7 @@ struct rzg3s_pcie_host;
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
  *              configuration
- * @sysc_info: SYSC info
+ * @sysc_info: System Controller info for each controller
  * @num_power_resets: number of power resets
  * @num_cfg_resets: number of configuration resets
  */
@@ -265,7 +277,7 @@ struct rzg3s_pcie_soc_data {
 	int (*config_deinit)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
-	struct rzg3s_sysc_info sysc_info;
+	struct rzg3s_sysc_info sysc_info[RZG3S_PCIE_CONTROLLER_ID_MAX];
 	u8 num_power_resets;
 	u8 num_cfg_resets;
 };
@@ -297,6 +309,7 @@ struct rzg3s_pcie_port {
  * @hw_lock: lock for access to the HW resources
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
+ * @controller_id: PCIe controller identifier, used for System Controller =
access
  */
 struct rzg3s_pcie_host {
 	void __iomem *axi;
@@ -312,6 +325,7 @@ struct rzg3s_pcie_host {
 	raw_spinlock_t hw_lock;
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
+	enum rzg3s_pcie_controller_id controller_id;
 };
=20
 #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host,=
 msi)
@@ -1722,7 +1736,7 @@ static int rzg3s_pcie_probe(struct platform_device *p=
dev)
 		return -ENOMEM;
=20
 	sysc =3D host->sysc;
-	sysc->info =3D &host->data->sysc_info;
+	sysc->info =3D &host->data->sysc_info[host->controller_id];
=20
 	host->axi =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->axi))
@@ -1915,10 +1929,12 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_d=
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
@@ -1933,14 +1949,16 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_d=
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


Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06192CD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:54 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6978.1778751648257272335
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gOJ0L6Db;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.4, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQh7vrZmyirnGc7JCP4eiNEAsPoikWp/lxiHEeXepdSolfCvi/C+ZpH/34MSRBLkbGjM8ZW88Y0GbX+s6W+WknZP47Cy8dGAlLJi+oTldquXVYNYmdnxfpvXrzoIJRJWSSQUIEXnGi7iHuCRkbOv3prGXqC5LyHyU+8dygyfo0TGjCqvluw8RUj2jbfWgOtwT5my4tT2ePH4kCLNUko1MwpnQ7ujJ9+TXp28+5rSNNBmIVi0Avdtdc6BWVRc+JxY++2XfC/BSO4+tW34a6JlryvjRnn2xJlk6TEe5VDeY6e20W0U1zzartiaTavIw+REHpgx86lgYLlMyjeiZiR6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P/9z0WxaAlunxGvwRYussqVgZEEONOu8U31mlylhPc=;
 b=AMPlHM0JkxixLaJ3MPma78BV55BM0AbZD+q8pDpo4JzAwbbz43wQ5D1aYUmGIAf7p7mRt/8JtrvfU8dvGT+reFpqSAhFIesRoWNyCG9mtSWaB5gyYqP516rV1smh0NwdWjpyGbJJ1mZNtHZwmPgoMGM3ap9HEuyH7qeltudK5FUu2HsjmtAQzrnexTi+VROrpQwZ1pT2qKdkYL3ZJnziEzo3WVyoi2iWR2JFyr+r4zn+U/C1IgQg7nR3M8IuLNiTw/+5duqdyCgLPCBZaCwmx2I9CPVWeWKQkpi5c8mf0VFD9XWMDjOxrdqPrDEhIhZwNsRhIPIGga5U79iNF0rf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P/9z0WxaAlunxGvwRYussqVgZEEONOu8U31mlylhPc=;
 b=gOJ0L6DbvtLgmhFrO8Bshc49hfl8TFJpKKprjNcwOlgS+Pdsv+gmwLFSvRfpvdhPvsBj9aLpqlWsAyEPnnU8C6+wZ/tKpUaR3hcqdJguIh/NybmC7bJiiqOXp28vQlgj+h6KOAEl1hZJmDY5VVmQLceX5Sj21tZjZtOdyWdNnzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:45 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:45 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 14/17] PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
Date: Thu, 14 May 2026 09:39:32 +0000
Message-ID: <20260514093935.2212718-15-john.madieu.xa@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: a806739d-866a-47dd-fe0c-08deb19cdf3e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	CP9dE0pUNZOpSMjanLbOz3LDHxS6ueD8Blh0fc6iyqgZwARE0F1g+dnJIR2f1ClcL50UjLQo7RZsunEJVCuDuQjVB80q+TW4yxvqkcycAqq6BrZ2otDjA6T2oUyhOK8G9Hp4a1s0WskeKKeMch03lVh4eQI2utWGYe6xx4CEt2qhAsGaHFhOLGTF+TWMo1cqBXZ0BtfshjaTdGkWz+u1QbIFEn5dlmhkE+q7G9s7zcH65TgC/en9ogUtN2dsjSI4jOE8ncqOsxZt/llRsQ7u+GSrpjcR4PuY0btm5TV8rugWvZSHJv/UprKiPlm+EZu+lLyemvoCPDaowZBP1rIErBcubJfwnLXHK7q9iODm9W+Qtoxny9aaAcwqah2yWorHorxjQsG17hwwJwIaJek1WT+StHgEmnrMiXer8UIlY5WnUWGSIuvAUcPai961ekkCw/NwsD826GMdoctRVQxQGRtNrC+xr+op82oEWovkJo2DvX/Wd6+F/BCCE2RbiXl2tulRrNM9QSjXSiA7+Nz+MUgmIlpTtJAeBnC80msG8I87czsIok2RbLe3WJz1YZcJxcLEsW4CQihROXuHUBliUcMd9DaGC7BZhig4eQX8QuBSIMvcT0tWiWWQ4AARJqMzojkLIKgtqz9yggNMIqMUwK2bP5uWuXwtwzqHWjqiw0pyREFtR9KR3pDfGyzFqOcLgUqlGcLbARm86G9L+yN3pQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+T2e8t6ASdMXoFs5/kVkop8f+oUDLO0JqD06NavOG51xirFt6HmdpKv6ZjrD?=
 =?us-ascii?Q?4d5zEWVf9wMRSo97P/WekCu8xOHiG8Tg6nbWxIU1NWmXjuA2HojxR1RNSlFS?=
 =?us-ascii?Q?JNuEoDqU9sQHbK/zS+nPMsLCBQrF+wo34isrs+fyDyWpt43yx7bk3q0ZXE0p?=
 =?us-ascii?Q?fRjL7JK3zFpnCSqGf9tUGy/3n+d+v/sJoQjyPEjbboz5qqeFh3MTWu3E7+Ab?=
 =?us-ascii?Q?WWs3lXxXcz5MQ1Qm+i8OhGB7FKiLYdU/uBJTgWQTMU6rqWytoyjEuXgZXxXK?=
 =?us-ascii?Q?C8uTqAUfJNXvXSKNkXK/snyTlE9+f/IjvtOYzjdjFwE1uUSbULKpuUh/bIgS?=
 =?us-ascii?Q?kd5UI78W3X7t+q3uXDWAOKSgOJ7fp8FTbjBwrkg2wR/+3ADd+0VbM3e3kvdE?=
 =?us-ascii?Q?e4A5S3io8XqzEAnIv0TzTWuPcQ9BIHUwhm7+0kGylNxXcWnsx4d5FV8QynhU?=
 =?us-ascii?Q?+VR5T7CFyIWZFP0oA548anXAuW5ZmwymI1jIeCDV/Ae3tk7qjs9fvj7gsDVL?=
 =?us-ascii?Q?nuZM+U6SFSyyCMtJBUtAi8JafbpPsTRBgDxXBwPK0lEPeU0wAHZfNaeHVnSI?=
 =?us-ascii?Q?zw8mEQeG24/Wr2RL0jfjPptBCRLKg1CdSuKdYYg5GrLHwQmRlWUz8ksfvdKp?=
 =?us-ascii?Q?5WZI/U85EExfQ9PM0P2M3WtMPtY9SwMNFk7U5YXFr7b9tqm8Pr0uyRafl2Yk?=
 =?us-ascii?Q?ZQA+XrLxcvDiqnWRMtam/41aikjpFDPzuOHz3l6HNx20oYa191BFuKjxx3Rz?=
 =?us-ascii?Q?M09hR9JKSa6Mvhltt9PFZ26DMWzA62LSF42j/7jtUPWm7wDRNR4nMAWRqir5?=
 =?us-ascii?Q?KlyW3bmD3PsHnOLYh84bXCqDaiTHhXZmvUA8Dw0hFK8aGzSWkzmoYCRdYeHd?=
 =?us-ascii?Q?wb1cO2QF7ibl7A9aNbKuWFqaS/GoREwuZtdep2tV3y29AQhWGJYcbWayVXmu?=
 =?us-ascii?Q?m0YRw7I5ssdtqmSl7prUSJBdcs3i/beyJM/EcdBIvfvbg7hgVnNjkvIcmdc4?=
 =?us-ascii?Q?DQhWqKwoEkr7w91NxTdmKSSrAIdg0yn5C/bgVgLcXLazob6HBN8Pz1Bi8vfz?=
 =?us-ascii?Q?V12ih3BmSs2n6MAGuB6rfcSvovj+Jm2Xe/go2EiWo6irdS2tk0/FqGkjLEYL?=
 =?us-ascii?Q?xshkmDSbriUxAHLQshG7JZYxp+FjDGxSxnbpy4GxCwdfFwRM/hkmOei91OkE?=
 =?us-ascii?Q?+MsRFaAIPqHOiUbWDVnpAga/Po2QaJZCrMDIOPNjFLLmjO+D/+HMWk5XUi2D?=
 =?us-ascii?Q?Jv9Q2rpFuSqaZCxNUrbXmhCk3nk3PRLaHyxiHENn/ozZpvepPnRT1j/+XndA?=
 =?us-ascii?Q?L/7TXYa5TQ5tmyDxuFmQEAi4fimuEuG1B6EBF0sqdZT5nNXOQtd0uuxqqmVf?=
 =?us-ascii?Q?5P6g8HRxkAKUwyvGAEFruhGjA+rWkF055IiUC+SAHSfV/jSZcmr5hUEZYeqY?=
 =?us-ascii?Q?939pWduyAq/cnwxt4kD/w94EyZkpxTM02OZNRz4flpnBEesNqj4twkLbcP+w?=
 =?us-ascii?Q?wGXgjWfHKuBlecbqzOKXWzihdmvboI+ZOFMh45B0x6w+JMDqE3eRUmzhAU8P?=
 =?us-ascii?Q?ob7I2ddMVunherIc4M1IDOio317lzeD6ASd9XIjuj2RxQugHVl88VJEKaoXM?=
 =?us-ascii?Q?nTKRSvK3H7BCL5KaE1HJrsFdPZebRCeTYlhDI4Hg748YETaMSKJW7Ta0330+?=
 =?us-ascii?Q?MWF4D34VE038nnOAgWhThuksM8Skq5MQRjYftcB6LIjZNJ6j5p2IRotpRDQv?=
 =?us-ascii?Q?0BKp7FPGwc8FTIQSgAKy2cVqDrztKS0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a806739d-866a-47dd-fe0c-08deb19cdf3e
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:45.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPQnkFbZxNZdXB8x7eUp9ac2XS59QYSKPWvMCB2GKxCa0omMDoSwfbPAGmh1VkzbSgEFW1OaqUWT4YQjD0I1MeZy1USTb+o2QGbUbaz8Z1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22948

[ Upstream commit 8197ec49a2062185f6bd432a19969ce0b3752e94 ]

Add support for the PCIe controller found in RZ/G3E SoCs to the existing
RZ/G3S PCIe host controller driver. The RZ/G3E PCIe controller is similar
to the RZ/G3S, with the following key differences:

 - Supports PCIe Gen3 (8.0 GT/s) link speeds alongside Gen2 (5.0 GT/s)
 - Uses a different reset control mechanism via AXI registers instead
   of the Linux reset framework
 - Requires specific SYSC configuration for link state control and
   Root Complex mode selection

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
[mani: added a readl_relaxed() before fsleep() to flush previous write]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-13-john.madieu.xa@bp.re=
nesas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 93 ++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 39828d8f4e0c..1b92371292dd 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -110,6 +110,15 @@
 #define RZG3S_PCI_PERM_CFG_HWINIT_EN		BIT(2)
 #define RZG3S_PCI_PERM_PIPE_PHY_REG_EN		BIT(1)
=20
+#define RZG3S_PCI_RESET				0x310
+#define RZG3S_PCI_RESET_RST_OUT_B		BIT(6)
+#define RZG3S_PCI_RESET_RST_PS_B		BIT(5)
+#define RZG3S_PCI_RESET_RST_LOAD_B		BIT(4)
+#define RZG3S_PCI_RESET_RST_CFG_B		BIT(3)
+#define RZG3S_PCI_RESET_RST_RSM_B		BIT(2)
+#define RZG3S_PCI_RESET_RST_GP_B		BIT(1)
+#define RZG3S_PCI_RESET_RST_B			BIT(0)
+
 #define RZG3S_PCI_MSIRE(id)			(0x600 + (id) * 0x10)
 #define RZG3S_PCI_MSIRE_ENA			BIT(0)
=20
@@ -182,10 +191,14 @@ struct rzg3s_sysc_function {
 /**
  * enum rzg3s_sysc_func_id - System controller function IDs
  * @RZG3S_SYSC_FUNC_ID_RST_RSM_B: RST_RSM_B SYSC function ID
+ * @RZG3S_SYSC_FUNC_ID_L1_ALLOW: L1 allow SYSC function ID
+ * @RZG3S_SYSC_FUNC_ID_MODE: Mode SYSC function ID
  * @RZG3S_SYSC_FUNC_ID_MAX: Max SYSC function ID
  */
 enum rzg3s_sysc_func_id {
 	RZG3S_SYSC_FUNC_ID_RST_RSM_B,
+	RZG3S_SYSC_FUNC_ID_L1_ALLOW,
+	RZG3S_SYSC_FUNC_ID_MODE,
 	RZG3S_SYSC_FUNC_ID_MAX,
 };
=20
@@ -1173,6 +1186,45 @@ static int rzg3s_pcie_config_deinit(struct rzg3s_pci=
e_host *host)
 					 host->cfg_resets);
 }
=20
+static void rzg3e_pcie_config_pre_init(struct rzg3s_pcie_host *host)
+{
+	u32 mask =3D RZG3S_PCI_RESET_RST_LOAD_B | RZG3S_PCI_RESET_RST_CFG_B;
+
+	/* De-assert LOAD_B and CFG_B */
+	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_RESET, mask, mask);
+}
+
+static int rzg3e_pcie_config_deinit(struct rzg3s_pcie_host *host)
+{
+	writel_relaxed(0, host->axi + RZG3S_PCI_RESET);
+	return 0;
+}
+
+static int rzg3e_pcie_config_post_init(struct rzg3s_pcie_host *host)
+{
+	u32 mask =3D RZG3S_PCI_RESET_RST_PS_B | RZG3S_PCI_RESET_RST_GP_B |
+		   RZG3S_PCI_RESET_RST_B;
+
+	/* De-assert PS_B, GP_B, RST_B */
+	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_RESET, mask, mask);
+
+	/* Flush deassert */
+	readl_relaxed(host->axi + RZG3S_PCI_RESET);
+
+	/*
+	 * According to the RZ/G3E HW manual (Rev.1.15, Table 6.6-130
+	 * Initialization Procedure (RC)), hardware requires >=3D 500us delay
+	 * before final reset deassert.
+	 */
+	fsleep(500);
+
+	/* De-assert OUT_B and RSM_B */
+	mask =3D RZG3S_PCI_RESET_RST_OUT_B | RZG3S_PCI_RESET_RST_RSM_B;
+	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_RESET, mask, mask);
+
+	return 0;
+}
+
 static void rzg3s_pcie_irq_init(struct rzg3s_pcie_host *host)
 {
 	/*
@@ -1334,6 +1386,12 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_ho=
st *host)
 	if (ret)
 		goto config_deinit;
=20
+	/* Enable ASPM L1 transition for SoCs that use it */
+	ret =3D rzg3s_sysc_config_func(host->sysc,
+				     RZG3S_SYSC_FUNC_ID_L1_ALLOW, 1);
+	if (ret)
+		goto config_deinit_and_refclk;
+
 	/* Initialize the interrupts */
 	rzg3s_pcie_irq_init(host);
=20
@@ -1681,6 +1739,11 @@ static int rzg3s_pcie_probe(struct platform_device *=
pdev)
 		goto port_refclk_put;
 	}
=20
+	/* Put controller in RC mode */
+	ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
+	if (ret)
+		goto port_refclk_put;
+
 	ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);
 	if (ret)
 		goto port_refclk_put;
@@ -1791,6 +1854,10 @@ static int rzg3s_pcie_resume_noirq(struct device *de=
v)
 	struct rzg3s_sysc *sysc =3D host->sysc;
 	int ret;
=20
+	ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
+	if (ret)
+		return ret;
+
 	ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);
 	if (ret)
 		return ret;
@@ -1855,11 +1922,37 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_d=
ata =3D {
 	},
 };
=20
+static const char * const rzg3e_soc_power_resets[] =3D { "aresetn" };
+
+static const struct rzg3s_pcie_soc_data rzg3e_soc_data =3D {
+	.power_resets =3D rzg3e_soc_power_resets,
+	.num_power_resets =3D ARRAY_SIZE(rzg3e_soc_power_resets),
+	.config_pre_init =3D rzg3e_pcie_config_pre_init,
+	.config_post_init =3D rzg3e_pcie_config_post_init,
+	.config_deinit =3D rzg3e_pcie_config_deinit,
+	.sysc_info =3D {
+		.functions =3D {
+			[RZG3S_SYSC_FUNC_ID_L1_ALLOW] =3D {
+				.offset =3D 0x1020,
+				.mask =3D BIT(0),
+			},
+			[RZG3S_SYSC_FUNC_ID_MODE] =3D {
+				.offset =3D 0x1024,
+				.mask =3D BIT(0),
+			},
+		},
+	},
+};
+
 static const struct of_device_id rzg3s_pcie_of_match[] =3D {
 	{
 		.compatible =3D "renesas,r9a08g045-pcie",
 		.data =3D &rzg3s_soc_data,
 	},
+	{
+		.compatible =3D "renesas,r9a09g047-pcie",
+		.data =3D &rzg3e_soc_data,
+	},
 	{}
 };
=20
--=20
2.25.1



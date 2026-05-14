Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD95DCD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:43:04 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7021.1778751775888408077
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ncIymKGX;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.17, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=to5/pAhBuSQJVhh7dm5iL5yavkv0/vlIj6OhAooWr68GamiJ2VZQGEU6jxhzyKPt0KqEUhQMTe0zVwb8WdCAkyzARgH588AOSczV9hcx5sUNbvSBV8VvUwaI0rds3UKiCjEXrJTuSfvrovaH8hk05PAlMJnoBbJid98J36+SBE54oWD3GRfGgonfLVHNtFLfa89nUfPi2LLrmWg/FrElVt9V7lBLMPt47Ys0ptFz/addcRfZU5oY8PxUedHmkFTKwCRemqxU7k9oK2d9t0ztsl0vSpuf2hc1T2XqVbsh/pp95Img+wvfY6DUsflUKQCPzVjGOfcdPYTRvRqWIPssgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7mihzS7cohSGxbOB57kaxL6xDceyukcSZZGy2txNTk=;
 b=yN5x9RoSVYpwjS2BxYtZtMCeefCg84ROINWxwCh6pjUh3RcMgsemOQp7pbIXUvHab62tcI1Qah7S5FXLvF7h57ILC+nvYoZIw71MnDGppxJKNY82VFx2u+BHkHorllPAZ7SQSrsnllzxnqjkssYjah0yhkmAmSPGNbVTqSeBd2FxH2VsMqU51jdr2MjEztUCVmDDcHhaJAwt2Ga5QRXC8beiUOCILabmQx5IYl4PcS5F07HLeDFBjzb1zztE7/z8b2JnEM59zl9fYPULrDm/QRmxwrdkUo/vWM25/64wCyuD+KexV1TB8D7RnPjFoPCOqps57b/ZjvxiNwowMe2Hdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7mihzS7cohSGxbOB57kaxL6xDceyukcSZZGy2txNTk=;
 b=ncIymKGXyK7dFzggXpfFC30AdqdMFfudGVEzH8zWC51o6St+SoJJRjgWJJ711Gtx39QZa417L74Z6rnSutDI76t6ZeNKRqggTnrGyH7dJTehrgrEhVZhplNnh74ipW67+u6Iugouc3n1odrcmKvYOszCNEBvgSq216PU6iESXbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:53 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:53 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 11/17] PCI: rzg3s-host: Add SoC-specific configuration and initialization callbacks
Date: Thu, 14 May 2026 09:41:46 +0000
Message-ID: <20260514094152.2215176-12-john.madieu.xa@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5b8101c-9745-4f8e-7060-08deb19d2b75
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	8QvZt8PJLgKIximTuNKOlx5MN28R848HXfwSk/X/QJY2ej48KVVTTF4WiEVJq4M2c2EbokokWFXhQnr1rDqdOuCsi0s+p5XWaYWrcQ2W9syvWwZmG2r8eejQmsrCNG+ZfT8g8uIJ9tH7xxl12z2AVPBvKXpYajwz8/8ODBHODnpN8tW/olEetp/JvimqpS2vR0IixHvptFg6EgqEcBQlpRUYFm0zucHzt/Z2Tm3uVyFeWUlR4p0pbtB6hBEGljD+OIQVZUnY/MkCJgs4l64oMI5NPS0vB6HyA1/R3CIwyW4DtIkp+EY+pWAPLKGIa2+xuCAiWirdZwpNTozOrwPzU3qgutLUdPt6PKshY5+0ozFlKhidWjkZ63+2xaqMpmCcqH2GvmDwj1vdhjGzFEMLbKnTtGbFEnoR+jdGEnYhWAxN+5BqP/D2YTm6AeNwI9KTRhWULo3iV8+v8ZP5f4joWhr/gsYifKdvSHrbaOQ3jLVmpHlhMztm4qZ5gLMzJmdLOEU8GLSX4GE+ZlGO9MTQJzqoWikuZ8VCioNBxz3huYDCUPpNZHWIkZRdD3KAwmRDceGk0Kvwc39D+Sub9CPNEkTmwyQG1xBiBYiPFHsi+NJF7grLEml3cGdaPR3INa3UAEfx+BifeRFpWobRo53lu074T6Yip8luYNvJuxqOG9/dNbsuXdqqABBClQKz6X383C5HO3qxgcfY9JxA5xO8Ng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rXwtVR+w39cg2c0QVsxqk3HiSlX/hF6opk01NXPvXfzBgRaFiBIK0dDLe7S/?=
 =?us-ascii?Q?VUXW6xvcgKNU+Hnv56GZEuMGHUrNqy/0LwI91tLaGAEbdFDDPd1bBCMMZQqp?=
 =?us-ascii?Q?okmzj90vYnGSOVht4r8LzJwDtsB2eOLDzwDTQ+NQP0+eDCbjHR0VDS4DomRe?=
 =?us-ascii?Q?POQH7NkCKcSekjh1w+FhS6lxJZ0d9b+lkFOGv8V/2x3ZKwe/YCDpHOgOHliX?=
 =?us-ascii?Q?+2AAWOEZ7RmFc1BNMYPLxFx9DSeRdVjC99P18rpWHdXingH4zeWdF9EcYrIQ?=
 =?us-ascii?Q?ngr7xf4Ttvaq+TV3zFX0WjxHk1NDvHc1ZFQfnNu6USxkpE+6FBgaHUV4lQKG?=
 =?us-ascii?Q?/636/g5Jt7NvoNpSRTmIjsWA2FFRAG7Gzz8Tn692ysQXOgIIue6Bb57PBqGh?=
 =?us-ascii?Q?8RbKSMdsu42FE0rXm5m1iTvK48NzFdrD+COsEfG3bMLQ8zSCPnsXkX7Ji9bx?=
 =?us-ascii?Q?fp3w5qJQ78ih0jy7NYUomFC1uj9aB1ik/OEqmjJkLPGOSZH3OFilJGvD3Gyv?=
 =?us-ascii?Q?rWztveusdu3KWFg671faUpA09cSmZ0r4aiuwCGsTPpCjO+y9GtNWRbJEZbdq?=
 =?us-ascii?Q?NOC2hr9/ieE36ymsKjkuu3SBcly03WSH0irJqrN2ltiHxyNOXbLONW4IuN7k?=
 =?us-ascii?Q?yYgWkxzS0UJCc6Og8Ui/WZ8WX5UgPSKnddiDRMGbQF70oXjjkZrW57WaHIN0?=
 =?us-ascii?Q?0PTx0M56LaRWdq2m6EshAvtPhs5mG8cEBj9QwdJz4bUdCrSy7aC9Q1yVycwu?=
 =?us-ascii?Q?yBpVoCyDtGjsG++7nUoGpb8dMDrUxRGyDbYY/x/RmNbX64YcuJx3whvhN3ed?=
 =?us-ascii?Q?6ooq+2JcNO6+8UH0AL20gmM91sy71oN1oIir3T+QYXPJdmWICX4zjY7PYYSm?=
 =?us-ascii?Q?dW0VRFqD/+Rq0Ai0Q4fMwvqNjmXffQbyP338IxmxOpCW2CfjuehBlqV6YCDB?=
 =?us-ascii?Q?+Nl6NuPBkC7yAVGPn+hc2dA1/LBCVE01xl2K+iQmkBQFtLTiDW+uhmZkRT0I?=
 =?us-ascii?Q?d6BvYAFXPGEp8av4zHdfhrQmZMS5h5DKSf2WUOTWlEfAOc+3LfVEzZoNxTiN?=
 =?us-ascii?Q?c2WgMd1V26G3tm4JUtS3ECfniNRcVPtVcQPx04CoQcMeceWeYxE8Cz25XLvy?=
 =?us-ascii?Q?XLBrUJq0bglBNKzvF5jV8FV1kYPo6tiN2/tnwcoAQpT6woLqH01V1dUOfdyu?=
 =?us-ascii?Q?dnPSf4KajNZ0hgG1wLpmgeG1koSRsVDOhc99Hgy7DwDy3rH8xJQoXE9/36Qr?=
 =?us-ascii?Q?gfzD8JjGCLmazP6ffA1BgV9YByB8/1Di6BALSTl5S+ZBgyLBkVOcWyBY25VE?=
 =?us-ascii?Q?Hgpbp+nd67LFOLut354I22ZJP/Zsq+59ZzgGSYrTt8oZOwFO4KcYH7Iy4Kyj?=
 =?us-ascii?Q?/RYEClWLp8iHvGjQgqD6vWpL4E9+zgl3eYYTErj2SCc7lKN65LJByTotqAsw?=
 =?us-ascii?Q?0rTWhBXKUh0nU0HF3OXDrm8zcfmltbxxTlIPICJb/hjykqyENU3cXuwasxd2?=
 =?us-ascii?Q?FraeZo0BE0TqdXiYKQZicuMu3v3crah/2yczVecS1Fpc7I9SuxtqyRmmuw+F?=
 =?us-ascii?Q?YyFuIswb5JfS+oJLbXsk4vrrUXLs3/SMXWT5iXysLPcJI1wLOgy6rtPot76Q?=
 =?us-ascii?Q?DuWEDINd6vetO2P9gekXwnHO1JJ8J1Y6BcLlSpY0VgZJicy+5piWusQe4CG/?=
 =?us-ascii?Q?doZR0UvWRNfLladXKIgnTChEN0V846VZq28ogDSMTXVI9TlgUbp6VzuG8AkK?=
 =?us-ascii?Q?TJN5UiINrX51lxJcOukrLL69C3xGkrU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b8101c-9745-4f8e-7060-08deb19d2b75
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:53.3465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Y9sgt4Ops89jWXK4o7XeHvHVlog8eE8+oarA3Jq1V8ujSc52CZ1BG5zt7DnCnm5FP2cWhFsxiIL5P1PXSvXhZQv1koT8djVWcMd+RLGAM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:43:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22963

[ Upstream commit 5f2c4de717786150f8d6cdbdbffb986cd3c59edb ]

Add optional cfg_pre_init, cfg_post_init, and cfg_deinit callbacks
to handle SoC-specific configuration methods. While RZ/G3S uses the Linux
reset framework with dedicated reset lines, other SoC variants like RZ/G3E
control configuration resets through PCIe AXI registers.

As Linux reset bulk API gracefully handles optional NULL reset lines
(num_cfg_resets =3D 0 for RZ/G3E), the driver continues to use the standard
reset framework when reset lines are available, while custom callbacks
are only invoked when provided.

This provides a balanced pattern where:
- RZ/G3S: Uses callbacks that fall back to the reset framework
- RZ/G3E: Sets num_cfg_resets=3D0, provides
  cfg_pre_init/cfg_post_init/cfg_deinit

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-10-john.madieu.xa@bp.re=
nesas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 61 +++++++++++++++++-------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 8620d8d31137..1de91ac54069 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -232,6 +232,9 @@ struct rzg3s_pcie_host;
 /**
  * struct rzg3s_pcie_soc_data - SoC specific data
  * @init_phy: PHY initialization function
+ * @config_pre_init: Optional callback for SoC-specific pre-configuration
+ * @config_post_init: Callback for SoC-specific post-configuration
+ * @config_deinit: Callback for SoC-specific de-initialization
  * @power_resets: array with the resets that need to be de-asserted after
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
@@ -242,6 +245,9 @@ struct rzg3s_pcie_host;
  */
 struct rzg3s_pcie_soc_data {
 	int (*init_phy)(struct rzg3s_pcie_host *host);
+	void (*config_pre_init)(struct rzg3s_pcie_host *host);
+	int (*config_post_init)(struct rzg3s_pcie_host *host);
+	int (*config_deinit)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
 	struct rzg3s_sysc_info sysc_info;
@@ -1131,6 +1137,18 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_=
host *host)
 	return 0;
 }
=20
+static int rzg3s_pcie_config_post_init(struct rzg3s_pcie_host *host)
+{
+	return reset_control_bulk_deassert(host->data->num_cfg_resets,
+					   host->cfg_resets);
+}
+
+static int rzg3s_pcie_config_deinit(struct rzg3s_pcie_host *host)
+{
+	return reset_control_bulk_assert(host->data->num_cfg_resets,
+					 host->cfg_resets);
+}
+
 static void rzg3s_pcie_irq_init(struct rzg3s_pcie_host *host)
 {
 	/*
@@ -1279,22 +1297,26 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_h=
ost *host)
 	u32 val;
 	int ret;
=20
+	/* SoC-specific pre-configuration */
+	if (host->data->config_pre_init)
+		host->data->config_pre_init(host);
+
 	/* Initialize the PCIe related registers */
 	ret =3D rzg3s_pcie_config_init(host);
 	if (ret)
-		return ret;
+		goto config_deinit;
=20
 	ret =3D rzg3s_pcie_host_init_port(host);
 	if (ret)
-		return ret;
+		goto config_deinit;
=20
 	/* Initialize the interrupts */
 	rzg3s_pcie_irq_init(host);
=20
-	ret =3D reset_control_bulk_deassert(host->data->num_cfg_resets,
-					  host->cfg_resets);
+	/* SoC-specific post-configuration */
+	ret =3D host->data->config_post_init(host);
 	if (ret)
-		goto disable_port_refclk;
+		goto config_deinit_and_refclk;
=20
 	/* Wait for link up */
 	ret =3D readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
@@ -1303,18 +1325,20 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_h=
ost *host)
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
 				 PCIE_LINK_WAIT_MAX_RETRIES);
 	if (ret)
-		goto cfg_resets_deassert;
+		goto config_deinit_post;
=20
 	val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
 	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
=20
 	return 0;
=20
-cfg_resets_deassert:
-	reset_control_bulk_assert(host->data->num_cfg_resets,
-				  host->cfg_resets);
-disable_port_refclk:
+config_deinit_post:
+	host->data->config_deinit(host);
+config_deinit_and_refclk:
 	clk_disable_unprepare(host->port.refclk);
+config_deinit:
+	if (host->data->config_pre_init)
+		host->data->config_deinit(host);
 	return ret;
 }
=20
@@ -1675,7 +1699,7 @@ static int rzg3s_pcie_probe(struct platform_device *p=
dev)
=20
 host_probe_teardown:
 	rzg3s_pcie_teardown_irqdomain(host);
-	reset_control_bulk_assert(host->data->num_cfg_resets, host->cfg_resets);
+	host->data->config_deinit(host);
 rpm_put:
 	pm_runtime_put_sync(dev);
 rpm_disable:
@@ -1708,15 +1732,15 @@ static int rzg3s_pcie_suspend_noirq(struct device *=
dev)
=20
 	clk_disable_unprepare(port->refclk);
=20
-	ret =3D reset_control_bulk_assert(data->num_cfg_resets,
-					host->cfg_resets);
+	/* SoC-specific de-initialization */
+	ret =3D data->config_deinit(host);
 	if (ret)
 		goto refclk_restore;
=20
 	ret =3D reset_control_bulk_assert(data->num_power_resets,
 					host->power_resets);
 	if (ret)
-		goto cfg_resets_restore;
+		goto config_reinit;
=20
 	ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
 	if (ret)
@@ -1728,9 +1752,10 @@ static int rzg3s_pcie_suspend_noirq(struct device *d=
ev)
 power_resets_restore:
 	reset_control_bulk_deassert(data->num_power_resets,
 				    host->power_resets);
-cfg_resets_restore:
-	reset_control_bulk_deassert(data->num_cfg_resets,
-				    host->cfg_resets);
+config_reinit:
+	if (data->config_pre_init)
+		data->config_pre_init(host);
+	data->config_post_init(host);
 refclk_restore:
 	clk_prepare_enable(port->refclk);
 	pm_runtime_resume_and_get(dev);
@@ -1795,6 +1820,8 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_dat=
a =3D {
 	.num_power_resets =3D ARRAY_SIZE(rzg3s_soc_power_resets),
 	.cfg_resets =3D rzg3s_soc_cfg_resets,
 	.num_cfg_resets =3D ARRAY_SIZE(rzg3s_soc_cfg_resets),
+	.config_post_init =3D rzg3s_pcie_config_post_init,
+	.config_deinit =3D rzg3s_pcie_config_deinit,
 	.init_phy =3D rzg3s_soc_pcie_init_phy,
 	.sysc_info =3D {
 		.functions =3D {
--=20
2.25.1



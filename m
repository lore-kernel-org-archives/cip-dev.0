Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78CDCD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:43:14 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7025.1778751784453143823
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:43:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XEJBAbiP;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.57, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uETEqab2IW9oloWHJDNYSfTP5GwD9/qz21jy8Psm16NqVeJTPL0N04/F8UO5gwHtEAipZQZJ+LutNKpNdu9j4blaoSiV2kk0/cjZczTeuuJFjuiVlnjMko1gcjIEzENuweE8SADk22mYRQtbcl7BUTf8yCuZVYNmDkxwIN3GGsBMviaLBZ7zzeWNBNKsMhVLTrFMoDnrgExgpH2YubqyBn9fhOKxFSvfqixK7TxofQpNJGqETI5mhyzD/GMvbO1/r1KQEIXd4qurjhuBdMPrFrdmAtB+UhhxBRi7Tx7fGXTKzveYrbqfz+WID58m20Srng6q6aQFVgejif3FhjAEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P/9z0WxaAlunxGvwRYussqVgZEEONOu8U31mlylhPc=;
 b=gnHDJWO5EJ5N5xCoNzGsCCO65QeOfcJSZa91RPMO8gZJxRFROwuc05CRRngC1pblh80vm06M+xbR+wQ+fyQnfUVc52Q8YbjrzWiuEVAyI2aTpd0C0M88O1TNvIfRFLqpZxq3PawB/BMjYmMVga96LC4IlkcnqI83BsOkPlC8VIlcnGhJd54WRxuoIODHAseczE1dgw2LHZtXzQHemH6/PR1cb91idZS6rYdgoStv68O1sD/7i+0TUrkQZlINU6lQUNAjqQfqYK75M3Mr5f/ASQatlpI458CSb4pCdIzNopmRfnSJzn8dZsNLYKcLSUAlSka8tNnQFKguHwDKQMgAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P/9z0WxaAlunxGvwRYussqVgZEEONOu8U31mlylhPc=;
 b=XEJBAbiPuVkp2zgTgY80e766g3AEs6g/NX7xh7mXLsb5cHMiX7bk4QnRBW+0FOcIhp4+s2VMz6QUdzgZf9tDC00F17DqxheCgbaG0WZLp5HykZDH8W46RJq5Y4bfJYyJQ+EAR8HAORizs3vKWDdn//gSPemHitUmi1501H5rWKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:43:02 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:43:01 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 14/17] PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
Date: Thu, 14 May 2026 09:41:49 +0000
Message-ID: <20260514094152.2215176-15-john.madieu.xa@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: cdb5cabb-5788-4860-62d3-08deb19d3093
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	IClmYlRkuYMNrJc/FLMy98n4Q98bxqrS5L7s+chFqkwwk7MMfszk8BuEk+sDamXmN9l6T9ql2Vh7iQOXNejkVYpFE0zIyDdm5OiBSkdPqG+qPQUNhY+FrJsw4D06eP2GNWJQpNSQdoXrj6qIvlPxKU2j/u6JINAFOVoWpME+lXIU82yjjv1qg6jkTMlyl/uqvnIz1zaNPdsADnR1DjPaGDgTOKvRmjLHQu83A6HZd7Pw+wPpY0oo2AENO6YfJ9w+m5jYqNzJ3dCyykVGOCB5dSm6W0wrdtf0YRsfzYcYorKXFLgKnt4s/2mMZcvfPCkWAivZMBxpH1Fgmo6nRWbp6aDdTI+0bTFtZ4gOYYS9gs4drRNGF9qNC9ObuxLoCPxLS5lzVbluIFb5oM/4kDvc2uQKjNPQ8hgmtKnbQM9sQm0lqUnyH3qv/tns1QDQ5BgWdC3SMISamxZ7D98hiSVp+lU4GSj/9bbTw2giA+S1JJwXKBsBgfL78wdV6uRtlU0uQ0mGZxa3Omzt4uQlptgHKAAh0/pxndqJwcFft6PK90ywZIRHM8+ZPxbXMfEKY8kZSea+zO4D2nxT9zHMr8rr9dWcDuEbDoUzSlth71+oD3EdShpt6A6WKwT1VhsPrfPyPBF3F0LbB3KBAO1350A5k9DaXDT06Jh2PcIWczmKu9zRZKXWg5GhgWPpSSw/1Pp4t2qk4FJq+obS22U6Dpm9Rw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Mu+/J4bdpulFCRdJ9HdLP7zwTdZzg7LjuxHGBcLDqbuATfL0saLA402vhFcL?=
 =?us-ascii?Q?TCppvSR3irQWL1CDcm+2eiVLZdLO4VypXQvD+xeVqhg+JfUWugNvtVVd+7X1?=
 =?us-ascii?Q?6XchEUM8rw9TxkjFrvt5Y8CnoDhQI2E/0mpyla/3va42Or3HAqxrjJD5tjbz?=
 =?us-ascii?Q?KI0iwIXU4HMR6uYI+dTI9yi58pDHWqdYkkHU3r6Oz9NLGA0DAoyqROL+dpkx?=
 =?us-ascii?Q?zLBQmd43u/77rMRWlLmEd0eueQedxjSSHMs0J+ga/GPQ2In3oR7A+8mLrb5Y?=
 =?us-ascii?Q?8Y2SM+OxyFn6LdiKpbVEsNzT3L+F3e+z4YF472C3D6OISRhfcPEfX4AOpNaX?=
 =?us-ascii?Q?2WX+IGYX3f03CxQPpHurdZ7taxToskC9xNrGGsXfz6eFTBVtzOwNptrdVgEc?=
 =?us-ascii?Q?jlMXwLLhyeg/91WbRCWHDFdrHX6Cn0MG0lnAUBqtHicOLnWAb+agzG0omju8?=
 =?us-ascii?Q?PEraTqnjlihKr3+iADq1mvc8hU4753Y4nofocQJLnGHLjOOP5UNIETJg5z5d?=
 =?us-ascii?Q?hnXANz8oJ7BYC4lGgG9QR6P/ZwxMoiYMWDl8CI8sOVvXPU3vscExw6JamFOx?=
 =?us-ascii?Q?pOyaTzBbOfYp06nrRfoVnfrEUyTmEAXz7k1FQ8aJIctDYlfVGQfdrspconaU?=
 =?us-ascii?Q?Mhe5eUWmfPIvuf4kVqYnBt2kn8SEQRvQUVEgqnTh6LItGtwqkHPSgd0AKa1M?=
 =?us-ascii?Q?nOGfKNue2w9k5rjwEi/jNfMZcVOL90UNUDkQEWl90Ws0dx/5JUEBA13Hjehx?=
 =?us-ascii?Q?fs/4XxS9aMFaJQhEBaIbkVDRoTAYZgs3qkpnNHZr1YiiQKnhnym427o2DHT7?=
 =?us-ascii?Q?vncjeKQtlnwahqDEL12znlb5AfBjZVifFUrDC7J7am4eQhCW3q81/DsuW3kJ?=
 =?us-ascii?Q?jxpZzVUeBUhu/RkbCf1DsA9FgZlchoEPKX+1VtRubhvvu0L09LlZ8bnoTsnm?=
 =?us-ascii?Q?bL7qjMAOn4EuJBWsb0YpO5VEqqRkt+6kd+Am9GJXTN4tgWldTk3fZU+aKUzr?=
 =?us-ascii?Q?58lngYExTUFslysfnYS1Wl/tVTSdNnCyx9ww9p/gmfjOLKE9SE+E/aRkg3GI?=
 =?us-ascii?Q?RgmdLgoWh3KyvAmtpBpP/2nloR63SnZQxKlFxfHhYQlkzDnkIZECRD3P6cJv?=
 =?us-ascii?Q?ObRsZioZ966Jc93aoUdKiGRGLrHFHPJdnf4ZgqaVzySOTieSfF7mHOmcOeqr?=
 =?us-ascii?Q?HZRVnlwlQpRxjRzEohnqvPFtlq5PU38RfrDDTwB/ypxTlnNiBFJ7KEUHbyBV?=
 =?us-ascii?Q?1e2EkPAlsvADLxzcfCFO93tSWBT1qiRT12tq4Pz3AIW3G5NOOAQefDSyB5Hc?=
 =?us-ascii?Q?nmV3yG6eBi2pNB3VrAyLTxFu5nh6d+nSrm+5Lv0hBzftQNKkaodnpronHolR?=
 =?us-ascii?Q?D34XTyhhA9Hv9R7S4NQyFz3tLSgFoN78n/ZxbrDUtW/4/PcdX2WMBu3zemY1?=
 =?us-ascii?Q?SDlyR3IS1eskLT7U6/rxTqclQrG8ITIoOtxGXrvqSKC+qFYtRgvYglS1N3sL?=
 =?us-ascii?Q?cYWd9SmamURWyNhO8U6uWZuTsWIb3y/O6BMB8soEIETE3c8NGz9BGkyoENga?=
 =?us-ascii?Q?fSxpXjPhWqzMHyXOR0q6VAWLk4A4xUoD3XEU5Zkpxw9XdFo7weg/ASjW0G9M?=
 =?us-ascii?Q?PU/AzwDstrHKrt+SqgZNbS6N3e8JPX5z9iTUlwk6Qht13QaXCYIUCNC6tI3y?=
 =?us-ascii?Q?W78Gnx7wfqxGA+gjIT0ZgagqHfQ8fKgszLjA6at51RpwlUYmG0mHI0B0pob9?=
 =?us-ascii?Q?YczAa4CnZ1Xq5kNQ6R0795hf8iQze08=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb5cabb-5788-4860-62d3-08deb19d3093
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:43:01.9359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3RB0xMc+rrKp8tGvWMMoaW6X722sw/9U6ckvZDJllc23s7yS0LPMgPMU2yJQIiTms565YYOdNCLu8xH7baBzXGWAj5mMjrJRISlp6kLnsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:43:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22966

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



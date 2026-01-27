Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786AED2595B
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 07:57:25 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5529.1769500634723428990
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 23:57:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=F9hwFRRj;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.93.196.44, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9BXS4McSV7UHYE52OYEQv+vnqJqhiF4aEaDVXeHrtPa/qyF8Dd3PPnFAZCyXlHdpkQE20iq+GAgsdmLS2AizuKA+jICKN/iJ/KY5ribSlnRDWo9fbtho/sR3PiLxQprRItGTPUY7ZvgLEpUbCav4MjGq2bK5jVQh7y1MucJ7sOhuamhYMYk6i+CjdJilj0S5Hprfc/gZ/V1sCEhk04ux0QIwD943Sh9aGiohujfau8jYYGkMJn8yh9vwXE3gfbukEYiEQpUzfVIUNhH6Kdj5U0NVCspyUYquknJQPboyhP3mcbSURQaPPxDHx5feLFT1/EaZBtAFPIXp7KtzbdYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksSzgyBJr3/Cnhk5+w3BdmpSzS5f+aTHvtEcYLMXMz4=;
 b=BHtmIv1WRTG44JmqOSfNjg+RldOa01368fOskq6SWyO6fIwySwb6lhbS6AC5CMw5gUA1knelP7Oe1q2YsaFniw3wLzvhvmCMBvAJth73L5kbWYGH3e8/cWLs2ud0lPiILJUVTiiEoiMQhN7KUgJ3yoa7022rkNpBargOJ8e0p1YJypnzvuQuKCYA91/RmchYs8QzSsQ33TtrwkTvk5zh++eHGl4hu9Q4w+8g47TjM/7RW36WrQmQzXA5XFDxy647qQVyF8Pk9LVfymU/+Zi8dN0QCxun4EETIxi8n1BGJaUGNm9DE6d8IxHd78+phP8JQoHMrcFepKxvbpMJaOnCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=renesas.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksSzgyBJr3/Cnhk5+w3BdmpSzS5f+aTHvtEcYLMXMz4=;
 b=F9hwFRRjL79KF3GhmSywmxtMhdzfHETjrZ/FNEphP2R0nxT56oVjB6w73sB8SoaQFgjKrgrJ75m30725sHETBAfHD6+ioyZ8WXYKGElBRtBYYHuCsNLSYCyh50qtpO8vh/gSIzli/D9vIrfq2V9nKXZrnz5Tntzp87Pd+8f3wpQ=
Received: from BYAPR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:e0::27)
 by BLAPR10MB5012.namprd10.prod.outlook.com (2603:10b6:208:334::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Tue, 27 Jan
 2026 07:57:12 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::d5) by BYAPR05CA0086.outlook.office365.com
 (2603:10b6:a03:e0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 07:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 07:57:10 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 01:56:59 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 01:56:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 01:56:59 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R7uvl73998265;
	Tue, 27 Jan 2026 01:56:58 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <nobuhiro.iwamatsu.x90@mail.toshiba>,
	<pavel@nabladev.com>, <chris.paterson2@renesas.com>, <vigneshr@ti.com>
Subject: [PATCH 6.12.y-cip] dmaengine: ti: k3-udma: Enable second resource range for BCDMA and PKTDMA
Date: Tue, 27 Jan 2026 13:26:39 +0530
Message-ID: <20260127075639.1259440-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BLAPR10MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 680ec886-1235-4279-fc1a-08de5d79ad00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XTkpXjA9X46tjXjBD4vAgF19cAThuLuMiSJHj//On3JItc3lm6ply0a+96xv?=
 =?us-ascii?Q?z9YIB7Y9WF07np1t37sD1n081chN8XYTqgYON8wZyTMsik1f/MIU5tYGybSg?=
 =?us-ascii?Q?sWJp6N1V7355oUUk8zz1rPdeihW08SlO0gyKKshu1mqihlrvBBw38ZyDrdMA?=
 =?us-ascii?Q?rKongDPy0UDTOc6t29wTGFTCsv/W5cUOLa8uDCwO95opBvm3IXd2OIRdIHSo?=
 =?us-ascii?Q?LniDWxoFgkUwHhHC266Udl8lNxxk467U2/vDnuxMbeRfETAt7MpPHnqwaZe2?=
 =?us-ascii?Q?jGQHofWwweMt5NZPY4zxk3FtWMDTJcYQ9pzloYKInQASBq9keg31y2mQW/Y1?=
 =?us-ascii?Q?iJGaRzmKjfTnFWXpGxD1kQAuBPp2ZxHJJaiDpHIn8yuoWq77CGoyY2ojmOct?=
 =?us-ascii?Q?qlL3zlgPP/dpSnRQSw08rJAIeAfwuqbGEpzlNuw1KwtTMjh1gDq5KszjoWiK?=
 =?us-ascii?Q?A++xK793DnqHky5FksX7P1NyX9Z9nA1nu0K91BgGJVBSQr7CNQ18N6jM8OAd?=
 =?us-ascii?Q?Trfc9ahAgIR93ssN/lpAJye9N7Sto0OH9Cq9ef6Pyt/4hqrF0nymVyAFJe25?=
 =?us-ascii?Q?gnG2mNc2jBKi4cV6qRXBN+zndpgSFXB+YSIvUIZMhuogglrCCrAuhKQZpD3n?=
 =?us-ascii?Q?DCmFsb/OUn5NkcVj3ifJKiXpDQ662kAKG5QhI8A1kCZOavoJwUMQY/vXjMba?=
 =?us-ascii?Q?NFiO08NhwqKU4RnCRUWt0zpEqwNpylyhWSXkyxmegg2IqCXwjkni+kbB+/lS?=
 =?us-ascii?Q?8v6442wKI0/MNprV9EHaAzJNs+dn6nF8pRQbT44Y7xI6t9wrJSiZz+kRq74X?=
 =?us-ascii?Q?wBzhlFEowaXuu1k67jXJNFcma+VZrJfHyHN/wnSEmDkvJxDoeSNne1tPtssj?=
 =?us-ascii?Q?RABO2G0PcW5hzXRsmTp145k839iswLoQjWoRODhAi5sKXxJy5VhHpf99fy0z?=
 =?us-ascii?Q?aYx3rC221yp3yi37zQY22qH3ws3lgaFSnnKdnVlBvzMmCg+U+mYaZaOBPpgn?=
 =?us-ascii?Q?+wDLx2ocqrJNab2EsJCb7iDvXN5H7Ecmr0QQuSrGYjuts3amRpQID1aAAm2j?=
 =?us-ascii?Q?AWqhOH04+jnc+4DCI/l3EaLIdU2UYkGcJPbp+h/YLUCqL0g6rNvxKy2onNTG?=
 =?us-ascii?Q?TuE0Pxe/VkOiq3xsZU4KBlMggHDLs2NwLF3vY8YafqeFWacLEjoREualb+bv?=
 =?us-ascii?Q?9xj/SrZbxvlKa9UsPHUI9vjqmhIQVdpghy/ZS1B0MWUm2PUAfx0hZmBHm4GL?=
 =?us-ascii?Q?CH+lYa1RDzE013uIv5YdHE/AuMfBJl+CG2m2TDd3kK3B/QpHwrpcmrk4aBYH?=
 =?us-ascii?Q?gXDecNu5ETya2287d23Y/o7IPuj2EnC3T7Ax1S8GjbX257cDFib4OpyTANRt?=
 =?us-ascii?Q?3tOeeXX8OzdlFzV/uIZA5Yxo0S51GYFGyJ+KOaVCQdqKmD0Un7HkmZEC6u05?=
 =?us-ascii?Q?1lGc2DpZWmTw3ySbKGHd8gwoonOhdmlfqJ3G9tfaRKGmdvPoyhFUhFDXm1Md?=
 =?us-ascii?Q?Di+HJkpTOq96PQN/+K9VLX5kAIrUvSKSeMsJILxGsH22ye5KwI7rTpMhL5Xq?=
 =?us-ascii?Q?azJOJW989i8X3T/xQyY7+9cIqOQULMq+CwlrY5tssMEhRGZhXkj3bonO5yZ0?=
 =?us-ascii?Q?qSOZyMiraftlK9tv8CqjiexoWvAMB25e0JOk1CaNoGf5bu4TGlT3/3PGZd+0?=
 =?us-ascii?Q?ahMupVfTAS2zmDcCBwLnQLC27ag=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:57:10.6823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 680ec886-1235-4279-fc1a-08de5d79ad00
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5012
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 07:57:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21720

From: Siddharth Vadapalli <s-vadapalli@ti.com>

The SoC DMA resources for UDMA, BCDMA and PKTDMA can be described via a
combination of up to two resource ranges. The first resource range handles
the default partitioning wherein all resources belonging to that range are
allocated to a single entity and form a continuous range. For use-cases
where the resources are shared across multiple entities and require to be
described via discontinuous ranges, a second resource range is required.

Currently, udma_setup_resources() supports handling resources that belong
to the second range. Extend bcdma_setup_resources() and
pktdma_setup_resources() to support the same.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/20250205121805.316792-1-s-vadapalli@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

Hi,

This patch is upstreamed at [1]. This is required for ethernet to be
functional on TI AM62P SoC.

Thanks,
Kartheek

[1] v6.14-rc1-24-g566beb347ede
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dri=
vers/dma/ti/k3-udma.c?id=3D566beb347eded7a860511164a7a163bc882dc4d0

 drivers/dma/ti/k3-udma.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 38b54719587c..e877cd50898b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4876,6 +4876,12 @@ static int bcdma_setup_resources(struct udma_dev *ud=
)
 				irq_res.desc[i].start =3D rm_res->desc[i].start +
 							oes->bcdma_bchan_ring;
 				irq_res.desc[i].num =3D rm_res->desc[i].num;
+
+				if (rm_res->desc[i].num_sec) {
+					irq_res.desc[i].start_sec =3D rm_res->desc[i].start_sec +
+									oes->bcdma_bchan_ring;
+					irq_res.desc[i].num_sec =3D rm_res->desc[i].num_sec;
+				}
 			}
 		}
 	} else {
@@ -4899,6 +4905,15 @@ static int bcdma_setup_resources(struct udma_dev *ud=
)
 				irq_res.desc[i + 1].start =3D rm_res->desc[j].start +
 							oes->bcdma_tchan_ring;
 				irq_res.desc[i + 1].num =3D rm_res->desc[j].num;
+
+				if (rm_res->desc[j].num_sec) {
+					irq_res.desc[i].start_sec =3D rm_res->desc[j].start_sec +
+									oes->bcdma_tchan_data;
+					irq_res.desc[i].num_sec =3D rm_res->desc[j].num_sec;
+					irq_res.desc[i + 1].start_sec =3D rm_res->desc[j].start_sec +
+									oes->bcdma_tchan_ring;
+					irq_res.desc[i + 1].num_sec =3D rm_res->desc[j].num_sec;
+				}
 			}
 		}
 	}
@@ -4919,6 +4934,15 @@ static int bcdma_setup_resources(struct udma_dev *ud=
)
 				irq_res.desc[i + 1].start =3D rm_res->desc[j].start +
 							oes->bcdma_rchan_ring;
 				irq_res.desc[i + 1].num =3D rm_res->desc[j].num;
+
+				if (rm_res->desc[j].num_sec) {
+					irq_res.desc[i].start_sec =3D rm_res->desc[j].start_sec +
+									oes->bcdma_rchan_data;
+					irq_res.desc[i].num_sec =3D rm_res->desc[j].num_sec;
+					irq_res.desc[i + 1].start_sec =3D rm_res->desc[j].start_sec +
+									oes->bcdma_rchan_ring;
+					irq_res.desc[i + 1].num_sec =3D rm_res->desc[j].num_sec;
+				}
 			}
 		}
 	}
@@ -5053,6 +5077,12 @@ static int pktdma_setup_resources(struct udma_dev *u=
d)
 			irq_res.desc[i].start =3D rm_res->desc[i].start +
 						oes->pktdma_tchan_flow;
 			irq_res.desc[i].num =3D rm_res->desc[i].num;
+
+			if (rm_res->desc[i].num_sec) {
+				irq_res.desc[i].start_sec =3D rm_res->desc[i].start_sec +
+								oes->pktdma_tchan_flow;
+				irq_res.desc[i].num_sec =3D rm_res->desc[i].num_sec;
+			}
 		}
 	}
 	rm_res =3D tisci_rm->rm_ranges[RM_RANGE_RFLOW];
@@ -5064,6 +5094,12 @@ static int pktdma_setup_resources(struct udma_dev *u=
d)
 			irq_res.desc[i].start =3D rm_res->desc[j].start +
 						oes->pktdma_rchan_flow;
 			irq_res.desc[i].num =3D rm_res->desc[j].num;
+
+			if (rm_res->desc[j].num_sec) {
+				irq_res.desc[i].start_sec =3D rm_res->desc[j].start_sec +
+								oes->pktdma_rchan_flow;
+				irq_res.desc[i].num_sec =3D rm_res->desc[j].num_sec;
+			}
 		}
 	}
 	ret =3D ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
--=20
2.34.1



Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11801.1793624544239358609
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 05:02:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=SxjQFHlv;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.70, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAQLCIp9bo+Amd6e0AOSlmWOsE+1ReyrHVStGkGHEspvcSqnsShBluN01n1cP+NsEGfpO0YrGU3wBdqUfOVmF8XW4rPyCrNHlO5MyIH0BuVTMOD29L1tarSjtmL8U41W0O4qXqCBTuLw2Pcap0Aj+yUIXsaOo/UDPO3QKC2RJXJE69NMz29IrEspcnlyznT9O7+7SYuLUICvp4Ni+DXP+Ce7C0p0YY5NWI3+BgMpLRU5epXus35R6EfZd/0WcTk3TLic19NipotI87+Pcd+ZreIR0+ikw6dKKSqoCZfQID8N9AdOoEObzTU6p3Hfl2hmRfxVkXamRnAd9xtEGSPU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsxbVW4Lx7XmlLL2ZEeZgEXUBRKoyPMFMAPt3ZA//vo=;
 b=JcpPIKmz0hyxt5ac+vK7QMrDNROSgtOS0VRGMl4hdCePLsrqx7z+9nwfGMhAVpq3jZ6cgL4m1iwcdqpCPeJqh7XzdOnZr5+ChqPIB7dGLEfsOVd8J4vogX00d2SNJH36DGgqJuBW8Dqk+OhtbuxELMLyqPLVveRdfcXYbVwH07DDwNusyG5ANMx5mP1pcN3SLguwzshiOxDCIbFPJLKgaNknLKKNs4WRxJt9IC4zxJpByakkAhyEQzXCMKBqKSJ/tJqJkZSO/AJMTay+ZVQmOsIr1icTDFlbnKiWBYv1BQ74XFOX/w7jC1kcII3gpkvapS+inmBCK8ok1cCsBzoLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsxbVW4Lx7XmlLL2ZEeZgEXUBRKoyPMFMAPt3ZA//vo=;
 b=SxjQFHlv+gF8XE9M/96e+N05181j2QaAfP0An2k0KKTVHeUbczBaC1S3epS4kzvOTj0659zXDzcKOliNgX9YhWLm/GirruaKGOo9cybgb+IRUASR49/MicY//M6qCCNqh99Aac78qeSaT43CCJdaR7OqI3IjF/nweoeeJm8XWOM=
Received: from OSTPR01CA0083.jpnprd01.prod.outlook.com (2603:1096:604:218::12)
 by TYYPR01MB12760.jpnprd01.prod.outlook.com (2603:1096:405:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:02:19 +0000
Received: from OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:218:cafe::40) by OSTPR01CA0083.outlook.office365.com
 (2603:1096:604:218::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Mon, 2
 Nov 2026 13:02:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D214.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 13:02:19 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id DDD593001283;
	Mon,  2 Nov 2026 22:02:17 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/7] PCI: rzg3s-host: Use shared reset controls for power domain resets
Date: Mon,  2 Nov 2026 13:02:07 +0000
Message-ID: <20261102130212.8115-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D214:EE_|TYYPR01MB12760:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c918dd-3bc5-48d0-a533-08df38e1872b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261021123027099003|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261009223027099003|261009221227099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lO/wjr6JSbdOKwJ1y/6nlMhv2cVvDRoTyHmDrxE5qpSqrABn/xdqEjnq4CGxRpUnC6HIuHhNgYcD7sAny9xZb4kEhAtr3h1IrAZHja1E1SnV4PHXHL/60x5QH/BXv0GvvNAvDYCoVmKaq9P9KaP0QrZD468dn7F3QWmTZV8VafSSvxFP++uArrEn1JLFEE5mOiT5aOqXeopyOblU3aIVFE4dx4LpMYaccAdOaHIN42ZPXI+8C/Cu6ULE9/24nLRkhtn3/JYaIp9lG3rf212wtVxptYdDRfHKxqumNqi8wEa01+CmMQyfAmJkxuVdxNy0PefT1c3YYlJ/ui2OWDAKVfQCW2Flob8agkZ16FwR36p/pcAGhnIQOE2KTNZm8IbG/UeAXZmqgE69r/n4CECXwlofAx8810tdgYsJfQXCdEL9AB6T/8IyEgqF20NYTEZrKLUwfGk1kAMonTEG7RNDjCPz9QfEOE0K4/PqQkSlhyjpr3b7EtYyMTiOZOstWgSr9Depi6Yx6JSzg3s4sHIE/BokH3W/in/Yjhggot61tUfOHOs7e7xPj8Cwtep1zSQMgAiLMCXZHMSMsFqG1JyZ1SsfCyE2emFSbGdR7T+EtlgCVauhnC8iIUMGhoqy4cDzvZM9sg6wnG+cJx9ERJlZ212l5wVOcJEKU0tyjYNcris=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261021123027099003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TfclF1g0F/wt/upU79ys4sqPosUgTX16ia0dt0m9V5jyDZFplJ0IUqBoiE1jyCzf0sk+LQCIC8bfETJ9xa3nUe2ediTLbPjD7Y3IsEThGe4/XrTt96XhcLtJzXb7GMf/KhH4O5gwRoQ6j4wpaZ9Z+lE20aUcLoOn4Z1A8YPpiW8WWRUXsjAIQxUKTbc5Xs960v4EkA32MjwzC86vuzYkMxam+h07gy6dbPgcv2VLrer8YxlYQnl6J1KZWGcQhJIpTMgusNcmvCEttmy4LA6umw8ZYdRIZTTmOSOtLJ6/9v+2o/Jb3fFeDy+76Epqi1FqDoouQVVmaAA4ps0spn+RwdhIiRvXjY71Bf3ThT+drO/WaqJfDFy0tHXO3DYj1cOiFlcEXJUqrPni+oa79i3Q7FBmWAY+FhZm6mlou2TtJIo6T8+Dfy7UEBHj4lj8vA3J
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:02:19.5800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c918dd-3bc5-48d0-a533-08df38e1872b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12760
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 13:02:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24612
Content-Type: text/plain; charset="utf-8"

commit e2260454946d4624d4e0f8b55378398c7c6ebf55 upstream.

Switch to shared reset controls for PCIe power resets to prepare for
RZ/V2H(P) support. On this platform, multiple PCIe controllers share
the same reset line, requiring shared ownership of the reset control.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260629220932.861445-3-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 45cc2f3782aba..d6fe72e11f4cc 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1300,9 +1300,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct r=
zg3s_pcie_host *host)
 	for (i =3D 0; i < data->num_cfg_resets; i++)
 		host->cfg_resets[i].id =3D data->cfg_resets[i];
=20
-	ret =3D devm_reset_control_bulk_get_exclusive(host->dev,
-						    data->num_power_resets,
-						    host->power_resets);
+	ret =3D devm_reset_control_bulk_get_shared(host->dev,
+						 data->num_power_resets,
+						 host->power_resets);
 	if (ret)
 		return ret;
=20
--=20
2.43.0


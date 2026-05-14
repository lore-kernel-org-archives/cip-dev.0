Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA6ECD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:44 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7018.1778751757136873542
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YSxDIH6T;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.43, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtCLru2zJfiBRgQCeITki9OIeyLiq6TXfl0EFYmYzjOlk8x4G6uwPPDzHzHfcxWwmzbMHazZLr3/KxVsS0Z4Y7QPMUoBHquCtGGqtvPlSc+vVYE7mWbqgpZPQKb35LZSinAcH6nvbXnSIUxGJ/bFITMYjrLlvWkxx9HJBj4JVh+YqT/JGGc8AdDumBg6xpZlYwsCoCEApewQOyr8CHG4CPOSZzVmTZBrOy9PdRzFuXjHKeNj9SGn9GHzrtKTo8k/84A+X5PboSbSmP1jyAEnBptLdPbLnJn730sKytPsKLbFkOvSKR6Oqj9RUWYYRTbJ3DG4Iqt8SZXW0RgsUqWreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4ffOBbqcybkOISVTsrJfP9SMoKWzaqZyIdwOMq+0RU=;
 b=yNn6VaTFnCkQKSwBcSZszN5y0kj1GD4rBzBx9KPePpkyyY7+esmuKhUG6O4uX0fXAooEWUGBVGhnKGOVSlyZAWjJZuHDD9XFOCbpVKTj/pi26GyErKEUWY1LrLv4RyZAUuIc9FRH0KPgzcmLtOzeWFjbi8ohMst4+hGZHnmBI9hbRWNDrpx2CM8lRgdldblTYflSjF4xITSXl1Of6brdpB/ofc71NMw/TIcHrfTBEfuoF8NzQjA+3XqO93YXzOfeBTmxhExjshIzCDVF4VlRaD1y33F1WaHOjcepI0YjJhrWLnCtCam/xwgC3T1aSHjBNGqs8tAx8sUr17jioYSF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4ffOBbqcybkOISVTsrJfP9SMoKWzaqZyIdwOMq+0RU=;
 b=YSxDIH6TcN3UTQg5XxJHDy63zkB8dwK8d2pE+dmlycP2d6chqAnkV2wINRDYmoTe0AJOvaEoLoZMZ2m1hHVE1RngDWRUgorUVyZprwf4dxSOKOPFWUeTPWn5WW1GXtPGYBYGcz7tJZcGynUkXEcIIAfXZUAFQzQbYGkbz5IrO4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:35 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:35 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 05/17] PCI: rzg3s-host: Reorder reset assertion during suspend
Date: Thu, 14 May 2026 09:41:40 +0000
Message-ID: <20260514094152.2215176-6-john.madieu.xa@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9653ae2f-a4a2-4a57-389d-08deb19d2127
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	5PJJgngGc++VHfQy55M+0KPZMfaRiLUI1fFssOmdu3dNK4hVsAGOTMsK7J3qsuQqDI/OTBBKgX7jri6gwEiDtya89mIa9vk/+De2JqXos2lXZQBMMJhTFHMCvNapnpz0/VX0Jt7IQC7FW4DGLRe8XvmQH+2mMJzaeVoX3TfD5AeYIW5HIc0KLT8EomcN27O+FHdAGoNHqCtlgODT0wQyppIiVH4DzihcwqauE9xu/Z3tFjuyrx8WT50VT79PjZsA8Sb82tXud5k0dq7wfOKRLKxoHlp0iBOwYAo2rhJa6T2kdXv28zwS8vKPqTXajuKrUC6SbImhmKoZHScMZ2srsar9Omv0R9IIYAUFOhIzdyiU7NIzzwR+o12+UAW3GAuLKTs3a/0nlxiE0tf7+DIVFSsNvHg0TdP3BwQTh7avcKkeKAncakEwyMQA1mKSXX8vbZAa2+petR0HXIWaWQDetNmH/k+CbWmuGvGJ+YBIwpA9qliapURT35mWEYRpN3EHjf+uQVdHPorUXnd3hR8xLFFBQOs7sP/PQhrd40zMTliISnDYvQlmiQcjzEPAiE5CMBP48EbH67gn1Eioo4wEOMQCB9Pmwrnnjn7kOQuwLLWzs/5ZYKJuPJR7CKrfY8wfo/HEYcqncMTGHqnjqplDAiLyTp664lVn3V5bdz3MgjVzEvcV3TkG1feobJzB5GC4Y1fmBqPC1aP5BBIvA0gRSw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fh04H0ccTDsd0n5ygtS1lF61QDyQUu9ZdjQGnp+IRUHJiknpqJCJ/mYPyf8a?=
 =?us-ascii?Q?dhSczJQ+xtGItC0Aed7BXyjCuMEyEE5Q2iP+pcy7ocTaP4zsJlV5mM1F/GQh?=
 =?us-ascii?Q?bfwwH4DtrVHqN5pHBLXjsXethmHmonTxNV24FdI1212k7kJVfvOwux6ew4mL?=
 =?us-ascii?Q?rnCVHPrjkjtqOT+/P0bylSnQ1Eb0V+lLeDmA13Ac4NZ8iwiKeqtFruAkcwT/?=
 =?us-ascii?Q?TsGgpMqfNVff/EZACTQsjF4tmR1YwSbYF+pWm9m+xgtbPnnI7Mqq42+/3O9q?=
 =?us-ascii?Q?VXpSnHXbJfySM5PU+t9N5aST3qJsSUWAQq2wyuXq0lDbrG9BewE6Z3vbCef3?=
 =?us-ascii?Q?b5DZ0ULZb/ARfnrQLid54aIdlypTZpRsQi/K/lgIFdjyiTO/uNqJ5SQLgBio?=
 =?us-ascii?Q?7+7k/G8qoRhfpMT86b/mvKW9iH68uQ3Np36HvpI33pGufyPt1jJOE/U6vyt6?=
 =?us-ascii?Q?c87ZcE12KW6Tcbkg+MG9vF8KMR9Fsu4tCUhFmlGiyiPIzr0flK/2jPTuAS2T?=
 =?us-ascii?Q?C0eevFmbmEEqPjUqH5ZebA8T79s7EZkSUy6JBRl9seQKArIZnB7FydHQHRms?=
 =?us-ascii?Q?a3zThmFUqrm7yulvKeRmZfYTTWYU83WgqJTLH5kk02oACrTyGdfICOURLFb1?=
 =?us-ascii?Q?4IQzjU+dTSD4V139ZhqtK9Kap69uIqBs0YaR2qPvO8Jqxah1unh/anwP+aIH?=
 =?us-ascii?Q?sPqsS32q9PsgUhf6GAiipodLsUMZZj5OOGvoYpZ77BAUNpyvv4k+FhYdavFT?=
 =?us-ascii?Q?IN0kSQ1PwLzp2tb6ocUVzclZa/+LohuOWML+q8ERwmSkKwuSuCprxFGO63+P?=
 =?us-ascii?Q?LukFzebzxrjFPnIGWH42bqAxA0ue5w/v8nzkLXANr75W4mP7X6c86KEcfJIJ?=
 =?us-ascii?Q?4voUGtTBxjTg19c28yCT2QbTYmwT5SFf7hiFB+TqxU1ApRH/o6tTsPqt3bAD?=
 =?us-ascii?Q?dOFtZqKUS+LE28x1L4dNveX3xuS16Qv7YskoQPy6Cetd9KEvigtqX6kKXQPd?=
 =?us-ascii?Q?oaFVd9tWSF+aPBtIJ5Th7S4URvZJdQHOwNFUMq486UrTv53RyPg/IP8jbM9n?=
 =?us-ascii?Q?+VjaGTPLsSC92MWSUwRGOwGTxw+VvJbZsscHjsqwMel/V1mdbMl+bosjuBT8?=
 =?us-ascii?Q?tEu6wvGwGoydMZO1Qof/1qQoopQy13CD4jtJp4a9u/ORtaRHFINRWlAbZIN6?=
 =?us-ascii?Q?xveiFIXp32mccIJP7+Ed7Xndbvs7t7mSFzEbmaRg6hZhElOJSwdVbmwpngMH?=
 =?us-ascii?Q?POi16c5OsUIOyV6eCz08XTsGncl/Us5d6ZgZlJNw0dfgzUQWK/QC5nX4+1bK?=
 =?us-ascii?Q?OvGrvR6hpWGySQOB7Ws0j39p5n6vtz+P/Hvynd/r0usFBKFPpIzDjIrFGPxC?=
 =?us-ascii?Q?w5ljT5zKOiLk2JhdoQJOR/q8SysPOc18gtsfXzTKHBapBT6FCQ/V/YdGB/SI?=
 =?us-ascii?Q?RpS5PsViuYpJQxCvHoVHrvQF2dzUn7TKBI2M3N1seDIgT2TADp1DSKP3TtCc?=
 =?us-ascii?Q?xrUsmHlz5tjFQn7MRr7EqWpYJUX3PJ9JPu8x5lwRxpvCbK/UnJEMDtybmmZj?=
 =?us-ascii?Q?Kk3Xxy5/jMovU8icKn7H7CZQLN9YoEM+cW34OqW478RwlMhYfNSHbusyFCD5?=
 =?us-ascii?Q?rWO/rSlL0cV6GgkRzDi30XOEllAq/fQNxZdO9uR2nsebRenPj80bHA7C0W+H?=
 =?us-ascii?Q?FyjAFtO93SS+x+Vy1WEus1I/BkdY2yKme0jYChaUev7jsUMqrTn4OTEz4Rxn?=
 =?us-ascii?Q?4bdyeR5lfz2SEL6wmDC7mkzCdfu4ZheKKwiHpeFYAeYpTZ9DOlh7?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9653ae2f-a4a2-4a57-389d-08deb19d2127
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:35.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynyj+wGZcY7rGCXEUfgIefdnOq2izVwcs3fRPypUIc2xbqDSnYjUMshwJ45wj7ZgAO3/gJxru4Xdd9Sm8pSSADW5vOx78415CJDogCd0oj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22957

[ Upstream commit 34735f63748daa2ea27544259c3042b4948376bf ]

Reorder the reset assertion sequence during suspend from
power_resets -> cfg_resets to cfg_resets -> power_resets.
This change ensures the suspend sequence follows the reverse order
of the probe/init sequence, where power_resets are deasserted first
followed by cfg_resets.

Additionally, this ordering is required for RZ/G3E support where
cfg resets are controlled through PCIe AXI registers (offset 0x310h).
According to the RZ/G3E hardware manual (Rev.1.15, section 6.6.6.1.1
"Changing the Initial Values of the Registers"), AXI register access
requires ARESETn to be de-asserted and the clock to be supplied.
Since ARESETn is part of power_resets, cfg_resets must be asserted
before power_resets, otherwise the AXI registers become inaccessible.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-3-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 5d524af316e4..1afccfb6d3ee 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1646,31 +1646,31 @@ static int rzg3s_pcie_suspend_noirq(struct device *=
dev)
=20
 	clk_disable_unprepare(port->refclk);
=20
-	ret =3D reset_control_bulk_assert(data->num_power_resets,
-					host->power_resets);
+	ret =3D reset_control_bulk_assert(data->num_cfg_resets,
+					host->cfg_resets);
 	if (ret)
 		goto refclk_restore;
=20
-	ret =3D reset_control_bulk_assert(data->num_cfg_resets,
-					host->cfg_resets);
+	ret =3D reset_control_bulk_assert(data->num_power_resets,
+					host->power_resets);
 	if (ret)
-		goto power_resets_restore;
+		goto cfg_resets_restore;
=20
 	ret =3D regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
 				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
 				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
 	if (ret)
-		goto cfg_resets_restore;
+		goto power_resets_restore;
=20
 	return 0;
=20
 	/* Restore the previous state if any error happens */
-cfg_resets_restore:
-	reset_control_bulk_deassert(data->num_cfg_resets,
-				    host->cfg_resets);
 power_resets_restore:
 	reset_control_bulk_deassert(data->num_power_resets,
 				    host->power_resets);
+cfg_resets_restore:
+	reset_control_bulk_deassert(data->num_cfg_resets,
+				    host->cfg_resets);
 refclk_restore:
 	clk_prepare_enable(port->refclk);
 	pm_runtime_resume_and_get(dev);
--=20
2.25.1



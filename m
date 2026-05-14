Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88ECD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:43:04 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7028.1778751778832685854
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kshZOf4X;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.67, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDC9Hi/Vp7foipGqa2axeTd95M0MFDAYO+vetalQhPWjyMuw4fYVv2dBwsMUztc3jw97nBqi/8kvh2wTQ3aJBIwggUh0SX+v273W19QTU4W1v/hsCJG+E89D7ee74G4RdB6oYBljSHWVuPgrD8X72Sn8XZY5/VPY376CWhYoSrMN5W056cbuhY87q2tZ6kEn95I+yiXzfD+5BGLHYn5orWHlaVHeRKVyn8k2HJYnsMxMhi1fbLTzKC9Xgorcpbn8ovYJtW3J5W6yPUAQusBQWnANnqD9Ksyf6g+7cNNvJ2vtCuo0TQH1lduyrDYS6Dx0Sy3hnQoOgRSuKXaCJHQ/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tffLVAN6r7hWsTwx0kAn42umjXD1f1DgwZgfg4h99FE=;
 b=tmesylHLZ+FqeifvVRZw5dOdjnRmQpxYucpBEYwFewGHPXjXTZSaRpqWaPOpe6dqt/CBOzFew4dnORFuzpEO6jSK16n0cdxgGna2Ph7lXirAXBeVqWIMO3JpA1qvOBjrfmExd2VWPaRwZUN9k7EWy/UNg1ZfYLw7QNKzTSkcyOOQtic/vkJtFeFWK0dZV9vXMA/CYbjWEE2pe7C/OBHNaLwG6flkMXjP0q/uQhpdP9ZHmCqJSapWo81GBM2YCrsKHWOyNdvJyz9g3daZq63dqpQjNQpUWoINcStU87976D2qEQ8xO99KiUaOoblfmSIJlhhwoEYXP22T/8f7PQYAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tffLVAN6r7hWsTwx0kAn42umjXD1f1DgwZgfg4h99FE=;
 b=kshZOf4Xi2zuWXNstEldxCvYG88d7bXFYZVZRBHH+eoE+KXWCUvGw/DnbD9H33AvZXzB+olJOZHKW/1yXvvU1Cc65IQnsL02drignQsldqeqvjNNvDx8VyfDSI2JobOBo1iERX5/MfqU/I74d9K4oqAmAPZHPTJPiCsjSbASQKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:56 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:56 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 12/17] PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
Date: Thu, 14 May 2026 09:41:47 +0000
Message-ID: <20260514094152.2215176-13-john.madieu.xa@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4af73913-4c98-4340-079f-08deb19d2d2b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	obg176XER8UtUxLSh8ikhMCfIz/hi91t2uAYD3/K0POfHgz7oM9mh7jhikkYUGj9PNPGz4Rvf4LK2q2BSw0PRnqpCb3qeg/pWj5v6BHM0+YUAODpqt28igOPGd3BuTiRox21rVUi237G10lVXgn2VTuHFxKVjjvlVd+PInID5Vz2MRiJ7lT5ipbmoWzntf1LlwVohF9sfgxnF0d9FfPK8L6Yb7Oiug5XubUAx9gtobJJYTJ1tj4XAzq11RkfMLUnzIey+ex1nxN/CPeYR/7BxNpiQiNawrAPimkn0CX9M0olwxLTG+s48WKVFbXfXTkgO9krNdsEiacGow0YHhxctel9M58vCpndip80D+THONz1Q5fnlTeYajf6QeCQaZFG9uDVFnJVxfW5r8hIIUfzerOQ+TIwlYkW8xj0cMow1D+sbsVgq/MK/mnJ9FHXfBmvjPl1yPhRq1NSj+46NSIjIoSpCGr5pr+x5D4IkZZh3b/5HsVZuJRbX+mDr1Up9HT1V1LEDM34VvuXmjZo6HmdhqDoZZekJBsfNC4jDNvWMD3RHXpdWimBsTl1vNNkfSAvB0bLQaDP054qNkaEue5ckDJ3fvneAJIrb9ZLadam2oi39yhv9Kk8gHdB+Ls6b1EcRj/EAE8F/stdPUjKDHtxFP28f5+KpDEzOCe0Ok8NJf92dZSR9ilAWfnC7U7EPQ1tfKMxeIg79jSw8PWYwzPKDA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LJuB3cHVJQnGLzd+P0ojzTP9TAiuGzYILQftWK0r/xFdv2Sd++t7l43/nFIA?=
 =?us-ascii?Q?SlSkz6QXZeW/VM74ZrKNwICMexeE2rtec9DoOUgs/RGwWRBH9rWlDlSUUhaq?=
 =?us-ascii?Q?yyg/KsiTmfb5L6oAoWNfUUDAB+QquU0Ayz8VVBPC9Dhsc5cSKgPGQJ0EZOpm?=
 =?us-ascii?Q?NNHmeaT305jKKZFkrPjkKxmj5kA3OsFdiFuKvM0qNFwt8ZplNxU0R2x0pj7Z?=
 =?us-ascii?Q?B5u5QfnOmxP8AcXgOc8jz17H65FSMa39M7+rvxNFr5A1M+jkmh06YDOzGjLP?=
 =?us-ascii?Q?QkljBI1R6LbPqnAto7fg0LxzHPxxbBCzKcTXdb262yGirEZdRc1dMMkQGnTZ?=
 =?us-ascii?Q?rcd2Eu5dbCYNzmawwQy74vbiYlhY8jsaWj+tcKsh8SaJtKEcBcPnQYhwI4+/?=
 =?us-ascii?Q?lEDv629h9c1fZknaLJs9N8vQKwWEiGT6dF1bLuHxGrx/eAu6dS2OADWVp3b9?=
 =?us-ascii?Q?NWZbZgxEmhckOE7ALR8aYmQwy0eMBNGNBAU5ERAdiaubMpnahkrIuolH+U7l?=
 =?us-ascii?Q?B5r0mtAfUdS+AT33Tg2Ax80Y8KXOuykr5wCIh7lg89ZrAh2ROOJAdPxlfnU4?=
 =?us-ascii?Q?XUqJQGb7NILJrmTR0zfiXMpvxE4UQvQ2Z7a6M7dTPdgjeuyOMfP4MYGTB+cj?=
 =?us-ascii?Q?+i/XqOi2Ux4VQlYKZ/DOi5ankcbhhID139rKjndN18AEv7kCXXW5WgsqIn4F?=
 =?us-ascii?Q?RBY7mjFdZgSSSw9f5uvDqm1PcuD+BXc8QIrNAHhYKzr47TKs31i/Wo7AAmmO?=
 =?us-ascii?Q?fWDBqETJQhkDNFCsUS+EbgTVXNZexIIEB0L+ydOkjF4NKfks5syFyyonFJNZ?=
 =?us-ascii?Q?LcinwwCGbKBZPwGtqd54+h0sNjutn9lszZITCXnTK8hXHbZ9+VNNOgARZtWK?=
 =?us-ascii?Q?QzX4u5jV5tOPRN1y0c2U+f7AuKmnOUehKeP2Q6LgA4D8CdQePzSs02171s3J?=
 =?us-ascii?Q?dslcCTVmSWRPxqTdm4u8/RsMUZ0AbRX33pCtGzG9mFILZMx1smtEQ+IOkzSx?=
 =?us-ascii?Q?Wl/F19zgFzxE1NhCrvI8nsE5Lxwpfa0NM9FyLbX6dUeEjdIK/eZaeh2Shv9V?=
 =?us-ascii?Q?TjM6APjbBPhgI5CziswjcxVaR2r9/2ntQomGFj7wY7CrI+0pMV7JrLmmvPSU?=
 =?us-ascii?Q?iuG366YdX8PYz4gTK0ZxlpEHMy4laz6R7acM14ayo6PXCqqrwOkJO7RuRLph?=
 =?us-ascii?Q?ilfyxMFH1pkYz/ZyNw86HMc5id5y1jgrQykeuuuTZnj51ONDoKWrXAeycJda?=
 =?us-ascii?Q?qka6e1nyiEfrtbdLKOs1ua9tmV/pJhrZIy0NYqXoeLfdvlILr22bRrOO2gQ4?=
 =?us-ascii?Q?IqZtrvUslLJk0xNAA6iccrVlEhZciSTduKFWtLtxLR5SLxxzbh9cehjPF0a9?=
 =?us-ascii?Q?uV+HHF/tMJKoiaNDb2UQ+s0XZJJ3lr8sNNpQbdO1S7z6hw4ebrTzvUef8cqO?=
 =?us-ascii?Q?p4yN9dyMgNgQ1pajsZQOrNO2D7pmpf7TO39sUQJH47KMNz0JKXzLReLGsSgx?=
 =?us-ascii?Q?ErgbHS3WfiTa8sp0VQcAp96nSIP1cSa+6hIRBq2DnIkK7nYVisfwugxDxQ5T?=
 =?us-ascii?Q?KPu/AzscJpg+2klO1aNcIignFUADEP1MdFNLNPGjIU3OGu438l5WxIaGQPVy?=
 =?us-ascii?Q?nFjxl6NQFenymBjcE6Vj1YC7KfjHASMFEhZOAH36BEk2f7sGewRXZM1WzHYs?=
 =?us-ascii?Q?cV5oULrfqOGFFY+00FV7+Jl9R8yEbHdN6wjGf8PVnp8xVMooD4vApkLyKTER?=
 =?us-ascii?Q?7vNFWpZNC3zHSh7u47vxy9dj1kTOl9s=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af73913-4c98-4340-079f-08deb19d2d2b
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:56.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzfF69OkFyD9dAGQ4z6NHMmnAzmrinZRepBQXkSh1RxBPYoJvw0lSUYCLjOrscmi5i9HIqAGmiQHTXdL55INWKvRFQqxd/NnsQtb//Qrjg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:43:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22964

[ Upstream commit 1e75d2e9a0e018b53f06dcc2e9345ac10f1aa174 ]

Program the class code register explicitly during PCIe configuration
initialization. RZ/G3E requires this register to be set, while RZ/G3S
has these values as hardware defaults.

This configuration is harmless for RZ/G3S where these match the hardware
defaults, and necessary for RZ/G3E to properly identify the device as a
PCI bridge.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-11-john.madieu.xa@bp.re=
nesas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 1de91ac54069..b3fade8443db 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1103,6 +1103,7 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s=
_pcie_host *host)
 static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 {
 	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(host);
+	u32 mask =3D GENMASK(31, 8);
 	struct resource_entry *ft;
 	struct resource *bus;
 	u8 subordinate_bus;
@@ -1126,6 +1127,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_=
host *host)
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
=20
+	/*
+	 * Explicitly program class code. RZ/G3E requires this configuration.
+	 * Harmless for RZ/G3S where this matches the hardware default.
+	 */
+	rzg3s_pcie_update_bits(host->pcie, PCI_CLASS_REVISION, mask,
+			       field_prep(mask, PCI_CLASS_BRIDGE_PCI_NORMAL));
+
 	/* Disable access control to the CFGU */
 	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
=20
--=20
2.25.1



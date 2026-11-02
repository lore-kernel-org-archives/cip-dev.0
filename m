Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11864.1793624001427664146
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 04:53:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pcZTnahO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.66, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9OnmuzJ1sLW1N+gk9WRZoPRsbtM7xqHNl8z3YRmkHxpWCs0FYcpYeBuxnWHizVZ7aMR0LxdLfdGeBsi89fhMXywru2hHwun4Cjwb+PV102FztC0T8CbkZtVxJcjPFCmvonGcdDWzMw8pjVRn1vd5O3VbYaa4bI4BHvrGw2tJYDEyjvT6RHP6f3a7ETqxv/r4qQULXjbbN41CJCtE3GK4N37hM8YEiSG1Bx/g8dhlNHtk8Vpg/dLyoPuRF2qzGOmFxHtNd9qzsiO7rZFcli/wpcN6NcgbwMMii04FK3JURlR8N0tXCx2GHW8zUo6hzMZIqoPHuzQM7SmgVu2NVtQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfUmn2dpMYNnmOLEYfsyzBm4vhsx2/RUKljCnQgJ+Tk=;
 b=hY3o9CvRxd3wfGFWFa3y1rSM84QDka40knZ/xRO576jO8n+i5TD/ISQc4FBWO/DlZ3s5km2VciPBOOv3nA40zwhNwb8sP9f6nm/UtpQuTrF+5I2VsBrd1FGsaO4T/KSNe050bIwdNZl0HauWO7aZGgaTn30dwZAfyhMlhv690KQ/9f2s9SNhQZC9lHAQRj1WpBuolIRN10vv+svhmmQa15mRijwRxu4CSEF9GVokDN/2nkqkoYTc76iODdgMmA8ahexPyYEXlkkHjVT0WQJU8dkmGz95UjSugQE0RWoOiPMREteuqYFpLpjQtchjKI2O7QeK24FAJ3N0BSUQ2crTwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfUmn2dpMYNnmOLEYfsyzBm4vhsx2/RUKljCnQgJ+Tk=;
 b=pcZTnahO0V9/KLa+YMJnFtVa9soOqZql8ee6Vi+6B4R9CIdQuqaRkTJo/cpYgc1Ous+hrQt7LECs91tq/UCVxKkFvtUqIXXyZ9zKfH2f9GrtMEXj9BytiXhYFn3SeyYTTbxqaakqJ2gl809nFTIgrghc7/8ZKW4mc8wtVHp9vNg=
Received: from TY4PR01CA0109.jpnprd01.prod.outlook.com (2603:1096:405:378::10)
 by OS7PR01MB14761.jpnprd01.prod.outlook.com (2603:1096:604:394::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:53:16 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:378:cafe::43) by TY4PR01CA0109.outlook.office365.com
 (2603:1096:405:378::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:53:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 12:53:16 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D7E9E3000230;
	Mon,  2 Nov 2026 21:53:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 2/7] PCI: rzg3s-host: Use shared reset controls for power domain resets
Date: Mon,  2 Nov 2026 12:53:04 +0000
Message-ID: <20261102125309.7743-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|OS7PR01MB14761:EE_
X-MS-Office365-Filtering-Correlation-Id: dd54682a-0ec5-45a8-ddde-08df38e04368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|18002099003|22082099003|56012099006|11063799006|261021123027099003|261009223027099003|261009221227099003|261021121427099003|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: ZeDfs3XYAC2XO257v/4dWXlRKjM2bjrNzL7WtTR/Hxi2b+e0LyKDM/62YhEUaL94Kq4AS1zFBZ7/krCN9UKNCCLuvnrKUPoHCxNv4i4tlGbEUYUA2u9IJj/YEwj1gQVF+VmAyfgg6nZhICcEiUbowog17/XL0oAA+vyLyU+tkhZ7opGoQLAWDJaNIOHlzwoJ3K7cC/+VhEsrOhrzimP4Xa6EH3KuATHf4XDodi+462TNFhZWaPbfVa0jcELyDbkSWfqKxnBwyfsoCN8RFdlRa1VtIrH/ZXQBq25MO0ewvdi1pQZ6yI1HLBbsNkisroUpI4nBUW2MV9S9M2kcvv5ddo4v1pbdjQY9nRIrlmUR3P3Ef94WeAkRp64abZO75unF2dJK7zCe0SrVmLc9kK23sVGt8rJfQ0h/cVzJS5Y0bMsPk3Kumd+/7qvWA1pxLSKO9aiozrhsz/BrdU/PVeFVG1CJYEDeH1YS3T7A10C9gsVHjEXu+fSFeoSJ+J7FFC23H1RvMN0sd5h9XXHn9MLFNzHPku5ofuwQ5G2o60V5M5dDMSgkF7erPwYQ8H2+j0wHdsmcHSmGrrWouyyWkxa8F3wctpewEznfCvsyEnnZM6oHEvCh/hFi+KZp8PkJ1iUg9CsmYFgjEOGu6i3QEt6E+0Y8W7t+wrf0W/2I0qa3qf8=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(261009223027099003)(261009221227099003)(261021121427099003)(260925022911599003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qz5AQJ4Wv+wMrdkCxf8uxDXkWdxgV+eUWzMlsKBaYe00yQPqV63JFOH40FFLHKl5qqxqB+R52ShxAi+29qOkC4cU3xIK/x7J+9tdzqVXdj51dXQXCMSQEdthrO4rhMFE3u/8vA1kzVphM3ZJC89DNjt72iFWbxIT4p7lNpkcgaUo2XhayGfFRZUmsePvktRmomJBfebzubCkMgjvCBj08FlPRnRubh0cDl0phY4aIszOaF28FzHnuPGhlO3KqX/OJZLccDnoigORKDdfWUNmNbV5WGJJSTMi0t2zMVzOXzfHhz9j2Pab7ZTYCDfgdGJnxisIem99pfwgqW4OYG6vc+RMEahewE1o70LuHKtO0M0Nw2EVK7o64HrSRP7jOSUx3yax0E1YNcSaPOUOFHIqm0ITDY58iHBpYhHEzpGOD7qlz1onkDMTQUgfaqiJEzoI
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:53:16.4132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd54682a-0ec5-45a8-ddde-08df38e04368
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14761
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 12:53:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24603
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
index 1b92371292dde..f1f97e9a9336f 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1298,9 +1298,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct r=
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


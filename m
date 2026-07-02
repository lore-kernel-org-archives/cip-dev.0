Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D6C43327
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66276.1782987861116300802
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:24:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gn8Fmjzs;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.48, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfcUwK+lZWk+ezx7RF/lJdX03Wj65Y+Co/0FBTVlm+RKvsphNFbsJgLNIf9yvwEVfA0YH9gpyHjuOQLhk8TmNDx+AXiEbqMuQAukk5JNN2BXA/LSSoHYgzLFVMaHh2Zb3o5DJeNlx2Lqd4a+rRTjAO4AqX6MyiqBt0P/sR9ZFAz3/t72ex4XHSqD80XgBOSTTMgSh+WQ780Itkp3if5k/8bSbw+83Ma7tGBnj6gtqEwx4nOgdmNhr5XdFff91viR2eid3dfJFcKWr68sziHcGq+qXfj8OkxNFHokpN1qOuYvgowoGpkutemLuYPkBFJgQWoRjXGQ8PAMPhosgqfSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYnUl8AGQ4uACNTYGg+Yl6XEH3wR4Y+0plVKPHz5D+o=;
 b=rHTzclsLMseezfqIUaLLUKKko8R2yamUHL+rvX/WzFtPfFMSXuc2tmVqECECuFVU9ohmcq7g3/WPoQQmcKz9lMFqW84264dy4RjqScDJX//3gm1VfcsFuqqxKj0GNa4bF5syIsI7Wz7agauqltBJDOFm8GaIaCBRd/PLc33kQOl68xAv4/Jpq5Mqegg3nGdMo7yTSIYhPcxp3g+nHL71XNjyTIOkK6MmUjsvDFa65O25DTCeFjePDO00IljXaTAGJQY53azhsOVFwfQ63Lu+Dz/4C1uL322p7x+QqHkqzZKHobKKHOQRHMu8YuVmfTnGW8yhXzrn2Juabp/4nbac0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYnUl8AGQ4uACNTYGg+Yl6XEH3wR4Y+0plVKPHz5D+o=;
 b=gn8Fmjzsk8l4yIDnVwVvEihbzr49PBfASvppBvjN7ZO17XQfp7Rz8icIbCbwcOG8ZlAeCesc2si1SzUf5j6JhsT9YwKptyzsy90su2utv18E3PBXg7kxxcv5XGjPpywQSKE1ttxwyRVc6u40Y6XKVFYFm1qgwCLZO76oVq/Fx5w=
Received: from TY4PR01CA0123.jpnprd01.prod.outlook.com (2603:1096:405:379::8)
 by TYYPR01MB12745.jpnprd01.prod.outlook.com (2603:1096:405:157::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:24:15 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:379:cafe::5e) by TY4PR01CA0123.outlook.office365.com
 (2603:1096:405:379::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 2 Jul 2026 10:24:15 +0000
Received: from Ubuntu-22.. (gbr-5cg2250zyy.diasemi.com [10.24.0.18])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C3DAD3000408;
	Thu,  2 Jul 2026 19:24:13 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 09/10] pinctrl: renesas: rzt2h: Remove unused variable in rzt2h_pinctrl_register()
Date: Thu,  2 Jul 2026 11:23:48 +0100
Message-ID: <20260702102349.23431-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TYYPR01MB12745:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 89e2e268-85a3-4d91-d155-08ded824117a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|13003099007|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	/Ff9mkXYpqxfypKornJahzBUaVS+PQBhtZy+AfNndPffYRYL/sMlPMn+/5waIDPHN8M2VFA9EYlzXKrajQu8z4VDm4hQ2egfj2w7cLx/cCCbsIekbLanAF6PtTjlZMGBmhR1sM2fso/ixVUVLEkIj0T3tLCRi2fHCwlyYOmG+c4w7id6FTGWJIxfuZ+VTbcIHl/p15l8WQ+Rs6/6QTbnKrZZX7+j/YiVUUrB2JRetaQQssO9Wz4my6uU2QY1CyS8a9cQLdmuw30bUnaTrcH32KjIfG4XDxLI2OOa4i1ccYHtGfY+wd2WaVFu64clY5KA2ZuvehpsEbCg/wxAzO7FuI1hw/hqJX8u6GjcKrlS4MDOWCOm3gsAVixoWMt4lypv+3RjgSs8sU+QyoapNSIb7cZit9pc8yriOpBqPSPquVqOSu0IsorBswsOTaxFNdbIR1ouUh1iYmFB90iuA3v0B09SbtGNAoKQQgDt7R+JbHzApCONAoRS3Z8hpbcaATAIoBst0PRaBKPqBB7Tm0VLxuk3TvWUEKJJV4SvwJ2yKDlTdDw4MSphE4/KROBHweEYVRp1OwPC3iGIJxIVXTuwO26hpwwfhMTACg8tYFUmzcWWXkaDGWPz+50ke+I6r36s+PWMjJ89S/+/3pE5JC7h0L/ar1PhKuKbc8BYx9yAqw4=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(13003099007)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	+GgoWOTBNpqiuiSR18R8ym/gNOR95OnYGuWY2BsfdGNQeZ+xEZgRIYjfDibz65B8KThV38os0kP05D2r1Ocq7FLHUJGQa4Cr70W102noYt30ZL1lJNzAVqofQe9fpbWGRVuwsF3muADUdCUd9dBp+hHiv2gjACgjZ4Al5XY2CkYvUrLWcwAeQxYzfiFAs1iM86YX6fMyN+m58+bhTgwywYsMUUCjGle437FT6Tt+pySMLTOCG7lu2uXJ7iL0AxPlKbIjLJ++iEmyrR3ad0ibabbbBZUe7XdSrVHArQw895/Mu32amf6nLkLoUxjS6IyzAuZMXOa7SLVg4gD3WiCRMBG9p6qSfe1uGA09s8OfZbrrEvk7lwkCQbCAA4/zcxd5GNHlB5N8a5YRX9XgL2Ro78kuEP3yD6+AmLTPNxG6We0TlqlRSh5zpfdLKeKrXYKr
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:24:15.6373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e2e268-85a3-4d91-d155-08ded824117a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12745
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23390

commit ccf707ca74cbb1d7ad0f99877518d2e3fe58611a upstream.

Variable 'j' in rzt2h_pinctrl_register() is incremented during pin
descriptor initialization but never used afterwards.

Remove the unused variable and the associated dead code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260513115312.1574367-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- No change
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index b754d4d725e86..5cf67649b8555 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -1156,7 +1156,7 @@ static int rzt2h_pinctrl_register(struct rzt2h_pinctr=
l *pctrl)
 	struct pinctrl_desc *desc =3D &pctrl->desc;
 	struct device *dev =3D pctrl->dev;
 	struct pinctrl_pin_desc *pins;
-	unsigned int i, j;
+	unsigned int i;
 	int ret;
=20
 	desc->name =3D DRV_NAME;
@@ -1173,11 +1173,9 @@ static int rzt2h_pinctrl_register(struct rzt2h_pinct=
rl *pctrl)
 	pctrl->pins =3D pins;
 	desc->pins =3D pins;
=20
-	for (i =3D 0, j =3D 0; i < pctrl->data->n_port_pins; i++) {
+	for (i =3D 0; i < pctrl->data->n_port_pins; i++) {
 		pins[i].number =3D i;
 		pins[i].name =3D rzt2h_gpio_names[i];
-		if (i && !(i % RZT2H_PINS_PER_PORT))
-			j++;
 	}
=20
 	ret =3D devm_pinctrl_register_and_init(dev, desc, pctrl, &pctrl->pctl);
--=20
2.43.0



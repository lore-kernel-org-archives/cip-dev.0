Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4684.1794226514708582459
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YaxQKiEW;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.1, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQChxcgPjE1Le2yMZzAtE3FfygMEFirGR3ConZ8u+z48ugxlseWxjGPOlG14ACMWkR255s7RX2rA4qbv0rnk11q1i5Pz8iJcJEcLNZb7ur2C3LG5cKJKWBgGlN33WHexKs0xclslr3WqAqc+Rwo2PJmsHLIHR7DOW33uvU9Q4b/3r6VAPd4wUSus4FFNAnK7PJeTt4LmsiZ8FoMaHE4ULrp1cQiGj93mnGouMNwWe4ww+3Rh6hJ3BbNJlLoR/jN4DtReD2+09ScnbUr8WojgjMYu43wREgKbsnS8bGQ2MLJrwguueODnicEidTIy/aCwO0VWvlBcrc2/ON1AxZ+CGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBttXPvvzsVIISbHjXvDgbUAelokzWvX3nd9v78uFYc=;
 b=koapq9ExnU60WhufB2zH37PCdMtDTW+v475JwxNEDS8AAHECf9hziCIcY6ahBZ4M72CCAxGclG+enkWS5GXlXA5+T4wmPCDKJnxb369ltv0cynsObLvqZRbN8nWsd11lG2+c9mJCrvPzc7x1YAqLplo8HsaGvVb6WSd0r+7IkoIWjrKeyUStNN4w47KzTO6NV3OeKYP98zMy5cn+GH7BYLet66YWDlLumCwi/W0vOa6qtBJPLVLZFgDUxbGLhqsaFg7JnnXfm0hxng8oN8iO2QcFDnp9mNrlYKFqYCQyzr7BzxH1hLjMNsGn+fWj+YB50PttqFvbljcKWK1Qm6aEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBttXPvvzsVIISbHjXvDgbUAelokzWvX3nd9v78uFYc=;
 b=YaxQKiEWugohTsJI0OuFSvRQ/EImvRUISngODZvYFBV6x8E4CT3vjfsskY6N9JAttrA5lV4q4Y+TENXUA4eyfdposD/XMpXAFPyoqlltxOFAU+9ECqjkQJy5xmYi4OGSyKK6iykCZvS6nA2kDSBdqUsuPT7Ljhv83AmEEdl+Tc4=
Received: from TY4PR01CA0041.jpnprd01.prod.outlook.com (2603:1096:405:2bd::8)
 by TY3PR01MB10188.jpnprd01.prod.outlook.com (2603:1096:400:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:04 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2bd:cafe::a4) by TY4PR01CA0041.outlook.office365.com
 (2603:1096:405:2bd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:03 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A354730002A8;
	Mon,  9 Nov 2026 21:15:02 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/24] media: renesas: vsp1: Make reset control optional to support platforms without a reset line
Date: Mon,  9 Nov 2026 12:14:33 +0000
Message-ID: <20261109121451.6042-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|TY3PR01MB10188:EE_
X-MS-Office365-Filtering-Correlation-Id: 1353f1db-6717-4901-c8da-08df3e5b15e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 6dnnNEGlvi4LoajAJFfQqwPO3aRya7ta8+ZMgnmjCbqJeu2agFRR8tcJJ1LUcg8CmI2v38W6tpbtE6FCbaoncM1yn+DlGnahudy+loSQcGkJlmXjnFw2w9DR+f3IdetM+5iCggNVjxSPoZoav/wuDQ7zSn/XIHJC/Q8ryLcPOzMLGna9SKi2ToXPNuv4uyfTWmEr37UdF0lRqXeCYxTfFxvniKPY+We/CSpioQHRFbMX5ulNuSqqkrIFRITQ4IOX8G32q9l0SQSS39kHmIf4O89Blgt6UB0JEuJEyA22xrV8L9MTUyCgvPM3jPxjMVoi/LirWZlPEFimOT4BfVJZ9eHGR0rl7jBuhjsVCQbrlUIxN4M7y3qb8J/RUrQ1UAjMO4iMgqUs5oN9OVARtlIlGj81LYKgdQH6XjySMw9BS5k/u6Fg9vnK1CjnJAscixE++9+Ff60SA9hjS4Xf7aq4wbz91eV+WA84LLiyLB7zsQ9gAhXF8bCgAl6lJHB7NiZwDZK5A5ldnOQEGwKWFavqIspVwM56RMNIVbo98m9Gt/eyYmGV2G1vkJqbvKklBcf+PbatuuEB3/efR+DsHOhFZea+/98qsAUecStdudvoTzjgVXdvxOkYeblZJwkSX6MX0Tgl6DfJXWIEYjoqUYd46vetOshgAbjK3DIGiNBx5I4=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rRfKCoV6CdpECfisbeuEJ5FK1IF7wzPC0zJexUXiGA53QzCzBygn4RWHci0Mr8bo9E3Vqxw+Ry4nw8Bpf1Jng1Lc7h7NdeqRD+ITgv8YXSso8v26eJxv6bWuY09WBcieuMHkgUcgH+gi2OQpwSNuexsCMGcZGP1od4+QE74aodLX1yX49Qtb2g+P/3A+e7ijY2Vvn193WeWcKXTkQiVweGH5sG2hrN4jAPUwJg429s20zaT48428CHyItW+ICxUR9mv4MwkQGDUiMw7gWikrVm+pgSx5jfBeHLJGgyuqPFn7htEyGEZL3nKvo2GEK5+fJJmNpjbOjyw4DoEkffHnPtbsR656ocsv3PFyiKIj3rdyjMDQRKeTiM3UhzaI3Ev3SiwOJZmO/rQhfFOeXVe+TULCQpIvyCxtzvS1nKl7MHfdBkObkb/Eg6aT0mCQ6hkJ
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:03.9520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1353f1db-6717-4901-c8da-08df3e5b15e2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10188
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24712
Content-Type: text/plain; charset="utf-8"

commit 284a6530a4e9dd19edaaafdd0398945fc54b0601 upstream.

Switch the VSP1 driver to use devm_reset_control_get_optional_shared()
when requesting its reset control. Some newer Renesas SoCs integrating
VSP1 such as RZ/T2H do not provide a reset line for the VSP IP block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://patch.msgid.link/20260430100929.1088281-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/renesas/vsp1/vsp1_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media=
/platform/renesas/vsp1/vsp1_drv.c
index 1aac44d687316..629939f70167f 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
@@ -909,7 +909,7 @@ static int vsp1_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
=20
-	vsp1->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
+	vsp1->rstc =3D devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(vsp1->rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(vsp1->rstc),
 				     "failed to get reset control\n");
--=20
2.43.0


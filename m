Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B76C624D7
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:32 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8563.1788341242503116269
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=ogSGtv/H;
 spf=pass (domain: renesas.com, ip: 52.101.228.16, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9xe7m8FnkUXw+1EY0e3Ng4Vre+OJotnt/acur6DMv1TQ34TaF5Ju+7bpraDPd0BQi5gcOpxvqgyujiRYeKO9lh585P+Fjtl2hCsPzZSBJeZxjUgprqgp+MhurNxyy82GIx8Dhs/7hiwF5gne6jZkQQ9R1HEUbV5CGtpN2tG7Ai6Z+i4pvgwBTeqgyq+2mWnT1VxQnM9dq4gIpPVdn4iypGYaRjzODhAS3o3CnEeSztslAGUi3jtsMat0+PMKKRlBDfzJwtrNjkXbu9WY9Q4iRVO+7Rg2Chl2yDe86SRVmAQd1AoS/0kltScL9GuGbQq9oNYFG4PfrHlzRzaaXW0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfNX9TBKQvR/7gLTG0JtfWMQffrRTiO1GsXk+G53scc=;
 b=gyjkijSFjflbf6xDPDWLEN44PBNLoroaP0KJ6uhVAXNgRi92TmAKq4MhjGZ7wGSJW52X2gJDEqks1PqLfa+rZvPh0pdXIirHwXJLTqNeaKdDDVTfUd4/Qr35n8KIfABjh4ERH1yrRskfAGj1xE+xHep4j4GzQoXjTNcnuionssspj+eH1TWHo3RDWqkdaIlt6GjU+uGw9yz4D6wa/vKdowEUcuZeQMQjPpuhLFUY0LX6IVd7vAIpr98lM+Y7qCTI/ypHD9h3pxaYE3zdKD6/6AEmbxNx4JtKQmxL7134eIGFbxQe3MI1cEDeRMa3zQ+oGhDbdq6rudQEfyR7Rf9Ecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfNX9TBKQvR/7gLTG0JtfWMQffrRTiO1GsXk+G53scc=;
 b=ogSGtv/HLzMY6MUI99VBqYYEMzJMfwcGGYNq3TjVKfFwUARc1jPUiRf2j8MUtUD0YvnIy7OqdhnqbLAkFWLRD96Y3l8VP7kdcifjr5wDlUGA/WMyVduvx2ApQqQVC5KrNXWJNGvM6xqT3sJ0KDP85Q+oAC1455ShFBaPeZdJjqA=
Received: from OS7PR01CA0060.jpnprd01.prod.outlook.com (2603:1096:604:254::19)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:27:19 +0000
Received: from OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:254:cafe::87) by OS7PR01CA0060.outlook.office365.com
 (2603:1096:604:254::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20F.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:19 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 077F13000376;
	Wed,  2 Sep 2026 18:27:17 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 02/11] irqchip/renesas-rzv2h: Use local node pointer
Date: Wed,  2 Sep 2026 09:26:53 +0000
Message-ID: <20260902092702.24746-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20F:EE_|TY7PR01MB14326:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c26431ad-c9f4-4fe4-0f08-08df08d462c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|56012099006|11063799006|10067099003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	QuU0Fp0GPzFDStsVkhwpCuluD7kjG6rrqEIKThPWERwc6bipUXNruSq07+rWSySO3zKZ7dpb8s15vQexD1Z4bIXC4MOkqeDwAKTK0AbvSw0lGvp5U3/xn7AlQDxvPfikc17Qm1rRxWi6rjQx6U2vBbWUf05CAx+jCTereLA3tJWwm/1VjSkaMVx9TLHIoW4beejMZ7XyqLZvSbTtvgU0FJ29AHKCae8TybR3IQyfZVt0ynSWLSXgv7v9Y5JIitbBpH3TeX7tIcWg1gQ8lEehebZE23juASXJXlO178ppTaKo7nNcp/5g0A+ezKFA6MJWRVKlp5vL0oLlq4sKd4Ree4sjAJgiT2++qk97+/+8d3hoYVTCEO0DcFm14KlBV1CBxzDoNzWhmUhRDr/tEd9ZJme+Crddl09AVI5BkDYTQZmRYfUKWhHyVAXXglBeJhwuPYKSj3mLVPlBnp2DzAVwyfY244Ahi40lenb/EKffTGgH4ZvawIdMMHE/XUTWGcGBcuL1m2IN+qoQYeS813dEd1cJ8vbl0J9BPOitzyqwcmj4iLvfNBMRJIiL+buMQ5X/inVtT5Gk0ss3OoPtxi51QFPp3bdc5EpiY2eVKKUnhn6T6rkBPdO5VFNRjHkSFG4ey5MS6yUaYqWEh1ZsjPRYKXT1W+r9BEm+gr98Sk8DNFA=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Uw5WvetXQVOL7zbgDp2qfUUiCMG2NStn8pgcs69ad36vrxsnd0Gem2JV5iWIFkxHzPDIf1JCh/KNzkjX0cIYAUuj2WSordaqIH6YddeKFIeavnBoj73iuFWhs9HK9f+DImGdlwBJYzK2vEgiUK3ki7RSNoF1b/yi28+W03Iq/1DO6CgsX1RZB4tNssVltGv1syPZ8Jl1TNu64vdXoC6RG5Be2JOCVjafCN7Mwm9fWDfGeIf5fGIzZf3N5HX2FuuB6yOD2CfoFd9giAhBZPVnDHl2HcNi0wB868lwqTdovM3fbIsPzHrb8RgdzvRdshbK17B++JGXni1cWMOrzkLN+HEdbGvKJj8g3phV+JkpiAmu3fL7LUggPaGyYHBjk76y6z2+p1wgITDzpfKdZ8Mgl0afMcSLewfp7D5Hze5noXcmr21KLQ16lpF67Z97d9kt
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:19.2615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c26431ad-c9f4-4fe4-0f08-08df08d462c8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24068

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9fcd9ffe94da4a34a451e4cc0e3e007b4ed7f114 upstream.

Avoid dereferencing pdev->dev.of_node again in rzv2h_icu_probe_common().
Reuse the already available local node pointer when mapping the ICU
register space.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260304113317.129339-2-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 684e03fd5b6e..ba40cb51afb5 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -582,7 +582,7 @@ static int rzv2h_icu_init_common(struct device_node *no=
de, struct device_node *p
=20
 	platform_set_drvdata(pdev, rzv2h_icu_data);
=20
-	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, =
NULL);
+	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, node, 0, NULL);
 	if (IS_ERR(rzv2h_icu_data->base))
 		return PTR_ERR(rzv2h_icu_data->base);
=20
--=20
2.34.1



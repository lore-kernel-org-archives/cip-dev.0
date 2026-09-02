Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BDEC624D6
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:21 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8272.1788341054767230636
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=J4FHYBhY;
 spf=pass (domain: renesas.com, ip: 40.107.74.40, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNs/SEf7BoUSCG58UYGy/wSJIalfAfI4ZOXTfeAjHaAvGX23zIPRS7gmv3+n14lSatZy2ueb8VZnKqaPOCo5e4ngeIHNq0BQ5EVWs7Q1TPBQiAiRQTYLejTHtPRWXBgYo7AHAEpEarj/md3hejjQMJlFEaVwcT1VduCJSNJ6RZlhGPa3go/d6zh7iei3EBAi6jpwY9/L/yHlWq4QRS7AQH3Yr79XJBhtFOuQUitp9XlXzLW/BD9TT9XFoSTcS7/oMh0bblaUUuf5vjYNKCMuGI9DesgyVWhJgJDGshLqANlI1WnUk/OTNYqMkyHvHh0VPGWGkCYSvA6puKDVWD/Xsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAgSJgXPLv8nW6ckDYKxOYq87YkMZGXXJu7nCq5+htg=;
 b=qlLX5GnY4ZBPg2bka5F4Etj4dRWDKvhm8fk5yql9UxOhpND852ONhBU48kIXGluzL69eL5aAqj/5juO5doQCV6lasDEHk20v9IZkWpdhLlmz+3uM2aDkZf5O8vddPkEeL85Z4VMqb19RZxfNjYZpgvPY3tQtWFbI8oxEnmdphWQmSFKixCSa5G1EQMyq0/Tzsg5a3vNM8KP1NL56W6OEj2zYq1IRyyQtUNWLdmKJ7KnYVHUwRnRURWvjJJbOD8ktCXnnagrbALEBOVL/ASECQndlpmkJO+glFaNaVhAKykCE3hTpDw+DSuwkl9rR7bghQLRQmqF8rRGthGOx0kookg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAgSJgXPLv8nW6ckDYKxOYq87YkMZGXXJu7nCq5+htg=;
 b=J4FHYBhYparFjRMHdFYlsQoHXRjClJd8HGGxohQbIb6trgW9GPSnIo9YhqwcYFGbMyxP8ubT1ibQEsjLo0MHxj14NfKXPRRVu3IiEqTHXEL+eNwmp5IKqkFIAqSRQLh/Jn8QIdqN4MF4uxRU4isOsIYqjCwaVMK9EybzVCpastA=
Received: from TYCP286CA0226.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c7::20)
 by TYCPR01MB9419.jpnprd01.prod.outlook.com (2603:1096:400:198::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:24:09 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7:cafe::44) by TYCP286CA0226.outlook.office365.com
 (2603:1096:400:3c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:08 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 2CABA300036C;
	Wed,  2 Sep 2026 18:24:06 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 01/11] irqchip/renesas-rzv2h: Fix error path in rzv2h_icu_probe_common()
Date: Wed,  2 Sep 2026 09:23:42 +0000
Message-ID: <20260902092353.24648-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TYCPR01MB9419:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b6c6f481-5e5b-4c93-b58a-08df08d3f0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|22082099003|13003099007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	OMyXCnqhHM7CvERceXUisoeZ89+Pwc657qXNJTMbqdyZ7XyIGELmFiqRnfY5/nStplKw5R/8ia5JxUGCsNnyj0BRybNa7eqKy16+zs1cE00azcd7Fdg4XJL7UOCewUsN9C/XZ2pl2/0EI/JW5Mz1dutYWBYcabs8mGQtJJamEcGmr9WMT1DTEwJCwkjU/1IR7jlDIAIzzSpc48jLgSWqm8rII7JJGqWmpMd9FlONuq8alLYpmLnolVAdCH3JVUx2gbzq7hSu7g1y3EvlmS9SeEuH0AaNsMJ4sHrlFkhh09DT/R4sVLOd+1Hiu1EMpiDfq9cUi+uTX2NzFcjwl5IFITwt81CPnSTbKqOw2Q6JuBeC7Tjp7A6Hh+yjLoovPG7znxe1axrWQxeJs71eJvG9xwh37Sf2ho0+kL6RFyiRJ01wLj17EELpBL5ekeq5ebM6yBGIQ/gBjWRcmiZ6/c319XgUXXYVu/881+9pwB0vKAcHSE7Zk1W0BFsgdd74rM6gcYuXu+rtKSNsmiE6hkGr2TOt2U3jCVde/sUEUrA+IKjK9KYvkYiN8SfWAgzqEK+tbpNez7wfD9bVUbGXwMK5sESpcgxcnP/ugDIVz/Lc/Hj8C3tAnBZhEofHKCfxcRhqrgvk7VNxYQ9KZVPGEIKbIimwWK1Y1n0tsVSutHoCzOs=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(13003099007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qEwywhVinrb7wECLCQ1cdN8XAzJrgbdKp3JAp7E11InDuYEz3C6G/et3AetRvhd7rVNwszzuJOVD926pP8vWeaSJGgQwPJDA4LEWMBaN4ZXhY9BxXYNEwAGSepMhNY3cKK839rOkDTPJ2BWQIdXFTkG1GRJR3NJzZWMRfdQQjdSx7ODu0Jeecj8qxM7UK7P/LLef8/pRVksMG/6Ju9aiGnd2WWe2tfCRkamhbz2hYbPw9sGwe9Pmv/iidUY7xUh9TuIE28hmttNtpuOKiA6TWxEoI7rLFDXeRcDSkITt+YGE8UajvWjvsnBxqgRNEno0DQ6fN9qaXoMUV5VyQbjqOZiAJVpYCulKLcUksMaOA52OpdZqJDKZcxTxwRQlpOXtiTbOgx4QWPweoLrwkq/BXPOZzgxjj2P0A3ntoqex/cYrkFkfe9DVgYiTlT00rhPl
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:08.3808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c6f481-5e5b-4c93-b58a-08df08d3f0ff
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9419
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24055

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 897cf98926429c8671a9009442883c2f62deae96 upstream.

Replace pm_runtime_put() with pm_runtime_put_sync() when
irq_domain_create_hierarchy() fails to ensure the device suspends
synchronously before devres cleanup disables runtime PM via
pm_runtime_disable().

Fixes: 5ec8cabc3b86 ("irqchip/renesas-rzv2h: Use devm_pm_runtime_enable()")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260323124917.41602-1-biju.das.jz@bp.renesa=
s.com
[OP: fixed minor context difference]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index dfbe563a3b25..0a852b6c3f44 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -630,7 +630,7 @@ static int rzv2h_icu_init_common(struct device_node *no=
de, struct device_node *p
 	return 0;
=20
 pm_put:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(resetn);
--=20
2.34.1



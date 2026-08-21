Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A109FC5DF93
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:12 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7167.1787318229729204126
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=eMmiMLEo;
 spf=pass (domain: renesas.com, ip: 52.101.228.27, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYtM15Uru9dlBw06sepOslo3b/cgXdg7HbnmSRCYxDHyB/Vre8XCKB58grQj/EuSAqHzIJT0vDwmLlkKCXQkZsKGA9Wml/y5hrnj2J5OazOsvR5zkJeG6fNIGH0qg/FH5+UKxwotJhwlaQFRRg9jii4BI0WEIqv5LC3lq3vlxGCWiXowJr8UFXnzeeI6R8dkZ6lSqy12whL4/RlOQbbjwh15xnhcplfMoSlFJUuOfxhku38jGm2vW3Y7usegu28Lm1XEdCSfpfjoj9t2iPr7PXMApcbmvpMGFg95DVhbbbXpHRqb9Ter39CUX6fDAmMb0JcF6mLYJonU/A75jaGCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ml/Pr0sceMuXzA26bKyWKWzj1BkjH5JUZas/3qsnKA=;
 b=Pn67crTwfv7/y2mobc8lqRgz9UqL3EVlGJvWBLW3S1MRsm8XgD4ozCL7DsbzKvB+TgFyjFV2ykH8uxWkYu7yHfc3fYs4NJaRS0LEbctGO3yqre1g5GZ3uZ3IBWEBaWjMOehXcKyHp9ymvkEn6QikVHaQor8MH3hSRM9m/NVVAiqYhlEeXaPJ9rXoFJNlZslr6D4eT1VCrJHhYnuCLFRYTpJd6bwUUJM6ax8nn/EecrLvqhzAEgga7d4gejnXozxT1fOQj8Lgm0d46MX1T6mibJlwu5xKYONra7jWwJfruEJVwOdANamu4RN7Yc9yqUcgOijW1VuXvzlw/kVwBuv0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ml/Pr0sceMuXzA26bKyWKWzj1BkjH5JUZas/3qsnKA=;
 b=eMmiMLEo7lpacWgKhiIYdiTxFnnIVZ+3cTSIS6m3+gFDT8ZKtKVFAYqspdVv8LSAk3yaqSHhpqmYUmVHEa5Ks0UJWgSbr1CAcZ8kxtsuSNDUxZ8lWyNjoSCI4xEaJDATPKTwd367VMWgFNnciWuALRONKf2jRcraEiDL09zWOWA=
Received: from OS7PR01CA0307.jpnprd01.prod.outlook.com (2603:1096:604:26f::7)
 by TYWPR01MB10971.jpnprd01.prod.outlook.com (2603:1096:400:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 13:17:04 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26f:cafe::99) by OS7PR01CA0307.outlook.office365.com
 (2603:1096:604:26f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 13:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:17:04 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 2472F300037D;
	Fri, 21 Aug 2026 22:17:02 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 10/18] irqchip/renesas-rzt2h: Use pm_runtime_put_sync() in probe error path
Date: Fri, 21 Aug 2026 16:15:46 +0300
Message-ID: <20260821131554.638741-11-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TYWPR01MB10971:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: efc6cceb-5572-4d4b-516f-08deff867e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|10067099003|6133799003|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	DnWWQSgotGCWrdQUV9VceVzeOWeqSTSUvoV170nPKwVFDtvq6SdvbJHlF5qWlOIxZ6p4h1IBgT9/CMVU+MEmgS/x8AkSVJN2/ZkCZqDQvs7b3V1AMBSUvuMqSG/xY95R9dLVyr5h3uTthDAsztuBmAj4/yatUepEpnMxbJXo/SCPCc/bIq3ki4upYW9ekmDzv46CyfdqwfErm6bF396D2z/rQHzK0TcVsPVNqOKpehZC+vLMp1J/R18GPAKW6ivPtCLwvKi5SpQwn5uHqAwwiEXzHG2dlfd9k9JYtlSwtD8v6w3A0FuxwkzobCkQ9S+aPp8um+gjrDj5ERyi8fpbC/oCkb4mObS3jQtpl2/Hx811TYdz5cAkig0wjQIXZ8DaHjKcZT7Jj9/K8AfCIMDWvXDCN+7oBWDoweemr9EgAqCnQFboAneFIMlb9b3YpGfPkw0r92BRx6INWKeKgCAezBsCdXGgDpVg7Fo/DNR1jVD5xwZXg5DQtmsbyHPMnlEkOj17wtNPLojydif/fNVYQ4VmbqUykLpAzfBr8SArlZgt/twLWohGH4yTQxFqkBcFXWbb5L6L+nd/PuEF6CstAhensbKM6H8Efv/l9j693cU2X2skyH/W8KrYn0Eu2hXmxP1dMfGVdllxOUooiT3GDw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	uAgMCBCbmjY3ILOfCu+nSmu7fHSqSc04npZxL6NEl1bEmld6Si3+phX3iXqvg6pKr48//VDF+JeGwTnoXmULTqMBlGd/a8zLbygrvJIpykRaIZRABzg2g0Ddxdkphq5zfjQ7+Q6OzIVRM0rtyHqswqq2+Z/u//8gCAYBMmFf0LKaC/GDwtQh5RcrwQ9VNyvuPCwxPiHpuAInchhxWIzNVpi83EdG0oPQ4luCDAOh0iwldG/0z8/fXUVO13RN6ozLLZcRC/Ma0S/W9hFxkkI7qFuOKl5yuVn2oFutgo+bhxh0znEKhC6tXXvNqI3prEox+f5YrChAngPiK9vgPlSDDsp7PaOTjViID2SzA3ta9YIKaJIpFj9XxLPGOn3ve37OGL9spVl3kEzcDUh1fZtcIWIjS8Wb9rJxy/U8qgNUENeinlUakzpyjGMSE9XJOnls
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:17:04.4548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc6cceb-5572-4d4b-516f-08deff867e70
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10971
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23966

commit c9b7598eb013c6dbf2526dc050364bd8dc24f0d3 upstream.

pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

Use pm_runtime_put_sync() to ensure the idle check runs synchronously.

Fixes: 13e7b3305b64 ("irqchip: Add RZ/{T2H,N2H} Interrupt Controller (ICU) =
driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260520203117.1516442-2-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/irqchip/irq-renesas-rzt2h.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzt2h.c b/drivers/irqchip/irq-rene=
sas-rzt2h.c
index 4b0cd5f66c34..e03eb9f86ef4 100644
--- a/drivers/irqchip/irq-renesas-rzt2h.c
+++ b/drivers/irqchip/irq-renesas-rzt2h.c
@@ -269,7 +269,7 @@ static int rzt2h_icu_init(struct device_node *node, str=
uct device_node *parent)
 	irq_domain =3D irq_domain_create_hierarchy(parent_domain, 0, RZT2H_ICU_NU=
M_IRQ,
 						 dev_fwnode(dev), &rzt2h_icu_domain_ops, priv);
 	if (!irq_domain) {
-		pm_runtime_put(dev);
+		pm_runtime_put_sync(dev);
 		return -ENOMEM;
 	}
=20
--=20
2.55.0



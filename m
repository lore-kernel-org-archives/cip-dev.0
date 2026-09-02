Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB18C624D5
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:32 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8324.1788341245075236272
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=c2PqCd8k;
 spf=pass (domain: renesas.com, ip: 52.101.125.13, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryiRtTReOdJ7WWvysnBguth/vIAQu+ln7fZmy+xW10EnVcXF4YqrdPWjuLBjIuYjsYtx0fYsSmU6UxrgwR6xe+R8oTggI/OD1veu6gaw+2N5fd9CBLykYWg2FL7l0ZhPRClzazqh0FM/6j7oW34dSZlpZURPAfERGsXmQGgaFc0rQFe6FgJgHT0YijFz/NSUBwV84ub9Dbv0Z78XhQb5KRd/EU5kbVttbRwrxHRG5eajWmIAy9JP0S0u2j3pdfHfgWvzWwiP24WhPrpgEA5KHPwDDFaSz3iMEIBxDTzXRnXJue+gkqM3/4Prh3BxPtPBqiNbHPcwrc/aCNvVnUQ4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TUoDH2if8Fv+GJmRSB0BRl0wbngwf4G+/A+16YlLSQ=;
 b=y4Z47RSdnfHGS5fhhN22QCeY/0MSD8rvUR+H9o1qY9UxQR26apeefQKAKdFP6UvtlZ/PX9MfZ74XAif96+Qn5E+i+woflrAkzqPXJpxz7E4Ic/8OYMdBx2SFeviPR2dNZrSabhUPBvry0/0OkkqPouajnotlzHF4+DBZ4ftJ2c4US/Qjs7FRoE5dD58cOP0TC0yyF3DWwFsnUAyIdEPuhsgFWRb+YcgCg0C0zBVgUiSdOZqJdP0DK8uAqVSuNP5AzFt2J572n9XMnU21nH9FCJTiluxi+F6VlE7qGGR5lFQvnPLRhsDXoplNqbzX504A6yH0JvlJ6DiNJE/beWLxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TUoDH2if8Fv+GJmRSB0BRl0wbngwf4G+/A+16YlLSQ=;
 b=c2PqCd8ky6mqg70ZhORDDuWKZLwalKm4JjERyYgKQjhP5IW22R5BPFLhc0kZ97trn6VevZPzIerlSyrDeZxX76VPRXjCmywFrBil7o3dBPtQe8ObG0wjSR9jCc8pKkQJa6oVwJz71dumVpVMmqxO5c1CgGab0r8gcG9q6XM2xME=
Received: from OS7PR01CA0057.jpnprd01.prod.outlook.com (2603:1096:604:254::11)
 by TYRPR01MB12334.jpnprd01.prod.outlook.com (2603:1096:405:104::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 09:27:17 +0000
Received: from OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:254:cafe::7) by OS7PR01CA0057.outlook.office365.com
 (2603:1096:604:254::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20F.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:17 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 636D5300034C;
	Wed,  2 Sep 2026 18:27:16 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 01/11] irqchip/renesas-rzv2h: Fix error path in rzv2h_icu_probe_common()
Date: Wed,  2 Sep 2026 09:26:52 +0000
Message-ID: <20260902092702.24746-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20F:EE_|TYRPR01MB12334:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4def8421-90a0-42ac-e184-08df08d461ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|56012099006|11063799006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	Z3a45Te9RvVfaqQJNDo8UzRdhTrXGhoaj5/R0wOEOb8jdfkq8MtmfvUVBXid8uEAMGJQChrH1zix1mDDabFqUd47ujLBSrX+mq42cxVfjTUQca/c5p39U/gKL8/IezYfKwWjwi9jh7oluFKWR/QF/lzrVcARaIWk5DWWfXPIQy5D+rybZmUoeQ7/ExQIhKDlXpLzUrxdtReAkHjJ18D7KqXYE57V1TUigQVrA1kTijCKGj1k1tLjdAMVtPeyGcIh8P9MZ3rT3eulS9vaooG5phYips0kOKOJlLCfD6KPjlSHevF8As2fW+q9n2qR5QpVa6aLAX7g9rnSBVUcX9KjQr+Y78BE8cfkAbfewwT0rC50zieMSH1c6O27NH6L1Js20iZj5dOQZ7SBaEEM2QFLmajIoYw/3iYnCrdGHMqXTeRslru0zJKIENfvY4jKLH/RfOfcfZa8olq4yG5iJ5Or+5qCnuo4rESjO+wgfFLnL8ZeSFabyTd5fxN6fYRcfjpWdfsWcl0T+Dq4+hmgoqwb0YGVXlt1Nn2ux8F8m8fgGKoyA4++4lyLVNMpuqjf59xjmJ4tK+xTO+bEcxuL9qRqQ+CCpqX/+En1zc3r2gtHkedEaSivSs1+eAHLZ8FhoAl26uBdovFnsm3ZgkUaCaGwN2mteZwFNPHrmbsDYTn++h4=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	G0aFb/VgL7LG9lzoqh8PNxjp8U/GgAWasMHhaS4dvK30rrKNBIP+BkGbmHnzt1cctcqMfjRwe+oxKfav6nUb1IXtFkIo/uhDroDVb2rneyTIUFUXg/0F7UXulKvvzlrvzfJSeW6GNGRC49niPnAhTIpGwZxAMn/Oni27yqtnCS8UUNMar9xGh1MPbQIdW/nMC6UBu6B9Ray9oHdQnPrlkrYlIJA+VIrRoRXzl7sRKaqFF1R+7liNspdis9wO/yT+yKkCQUNJK3+cqysLBUczAtrgLFLBxwWX6hNcU2BykjZbLyx5Nv8S1yPiNdZsLqIPdnYwPG7KWtnJV9sG+nXNp/B0ui9RQpG+LTbeuvEhUYvySV0jvSDhkFluaPErnbL0u1Ad2jFhf/YCHErTdyvi2TFphU+j+vXJ3lTKKKFpT0BZ/uCUWZRTP8LcAjnqPZHj
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:17.6035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4def8421-90a0-42ac-e184-08df08d461ca
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12334
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24069

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
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 41ee73c3dde6..684e03fd5b6e 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -632,7 +632,7 @@ static int rzv2h_icu_init_common(struct device_node *no=
de, struct device_node *p
 	return 0;
=20
 pm_put:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
=20
 	return ret;
 }
--=20
2.34.1



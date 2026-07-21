Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A290C4452F
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 11:48:40 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20762.1784634517105836811
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 04:48:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=M7U05idR;
 spf=pass (domain: renesas.com, ip: 52.101.228.47, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npGwZetLJAp+p4DgYMxXlJEw7NvTeSrhr7FD1kECLkIZtXZUwQnCgwuZucG1DmF9CpkvUGzYmzVZ0ifhTsEwi+aFqXlJBsz8+aJ6IQw+dhWpS64Qi5kxgkh87F9AVrWfhbUArTKDSvmRi28AQcK2QBcF/y4stRLdaa00ZXPcs5SPieGrCJn/yoPn7ru3znyWuCOpJvK+1mVdjBd9SXpTyvQ4LbAqxdULWVOTKF11wRmDI2FgJFCGBb2dRVdRq1WHBI5rCaIfM+c4wVPo8MSoUVd/5eU6l4/nk7zt+o55PedS7Wa3b71H26YMMWfcMttYcgyqa1TBWBvCM35refb8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miJpIVp70dfnyEg3LguObNPxba8feg2dgwAhnUMU6gM=;
 b=Qg3u1NU2BJJQRQNQSvlY7/teNaIVD/UX0eRLdyaPGqPYdgnEtXwxdlHdhcaj+OXfMG138zKJjKO24zsPEDH6kMq91U2o+Ap3i8I358CtUvQrdc+fUChd3yo6B+L7MvwuV7CB7zssubfX0dzFMyIjXguiMUYDZVG180H7x+tb/tPr69N8QBB44Vl5VdJFaswyvJUN93we81SEJLEa3oE67QsvBJZM8j0K3mItOUrxhSFq6yObIK1o31bA1EXhzfdV85BeOT5Kp90IMt0C8INSqF37OXjh703jzwzXaeGY0fIsS0zjnCCP4mnBBDKzHbjNE4TB0wq51dcQ9hFI5h0zQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miJpIVp70dfnyEg3LguObNPxba8feg2dgwAhnUMU6gM=;
 b=M7U05idRR/NT2oq8K7jDmN2PzergiYlCkov37arG+UNzLwIRDZevrsaieQqdS2ntHC8n3bgm78wYxUEaSBIQ9xeKzrsouwt837Iyvv9rx+3/3E5SIMjwcib1bM7FTcAVQgZzbnjiGHtd6S7o3oOryVb6Za2nTqutvPxVt/47YS4=
Received: from TYCPR01CA0143.jpnprd01.prod.outlook.com (2603:1096:400:2b7::15)
 by OS3PR01MB9576.jpnprd01.prod.outlook.com (2603:1096:604:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 11:48:32 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b7:cafe::73) by TYCPR01CA0143.outlook.office365.com
 (2603:1096:400:2b7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 11:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Tue, 21 Jul 2026 11:48:30 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (unknown [10.231.33.39])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 740143000256
	for <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 20:48:30 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v3 2/2] ci: Add rzt2h-evk build target
Date: Tue, 21 Jul 2026 18:48:28 +0700
Message-ID: <20260721114828.1390-3-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260721114828.1390-1-hung.tran.jy@renesas.com>
References: <20260721114828.1390-1-hung.tran.jy@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|OS3PR01MB9576:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 662bd4bf-bb4e-477f-c0b4-08dee71dfc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|36860700016|34070700014|82310400026|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	XD9rxArxsCMeKnQLeRb7Hrh+cFDSO9hmnBAHzDago9yXvJ+70nPHuiZtBl5QhBl8O5YOKB6560PFWYf1UmjlfE4cbySeC7t04fPiQbxvV7wx3R2XPgVADNhNozlSwtAwtPLlK+CZ8lveciQcYwTzHr8JdHrCtCAp1uqeRVXyOQO3B8uB4PnQhAGQzgpg+hZD3M9xjgNUPCjlgQw/DdV1ls32QcUs/tXvI/zSCpblRsfobNxH62Fowxaxa30guex/UbhneoGDUzNCN03sA60/aYU+/ruSKa4Ol2om3kYb+56ErjzoLx/kRmg42o5KO+ye6pykY+ZsmGL1N2tuoM9ef6mFL/uLl2mg6NGjCwKwMc17D2LIBsi8UiUqwSvOf2i4+MuHnADYv4sZSOnhGBtfhijbkTTCaR/N/K/K8I1nKtH+4myxyto3ySVQP+Xvxgr1wcHn0bVYVBAmZrqxBAkqUo3YqaFsdJ9n3Feu5cZYaJJm4GxLofyaMj5KEJ3imSuTSte6/ORIdQAzHHS7apvwCBwomOPxP6TUckoDrCX+oDmUoSQCgwh2Lj3xHft/TivJtbP9Z2YWepborcmgSPoGVxnSiCasH1ARMzghsopi6//qAhRfQzOXEIqvjCEWG2i9GiqlgG2Cwf+HrQA/SCm65m8IcKhB8RkhIW7kiHZEwzwrWZgK3b0DdIbVydcpnqHcpc6pDhKZUwhkkq1dB+HGUg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(34070700014)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	1XyauP4skFNtgX+iHr3YoaxI7gSgOq21pl0NJTDH1sfpQfIbzM/tHvO/tqf8c4jlGPNtVyn+5p7cDcURaXYtfXdhhPatkY60whoLrDx+ezXqXIGdHG2f6X+fkG4ifQicWhjw6KEtp+0SA/ft//rCRm3/ylWak9D3WJU5Of1JWwy2EBGc/saNrpmV6fYmbVgBiPvGRbwGq1bowOCFkfMGQTHv+blEJ+ABqaVynsJ5/bob/lkJ7XlAnjytHg/Qu4Et9qRaQ+P9SNRz6j8OhlF384It7vJjZ6Bs9d4GEnFYcpWDZ163uWOzYX7qH/ioFJNP9Mq1HOEIUKG2KLfkVeUmGyRPUNoC5/XhsqjQoLWDlL7BPdibeT/rxRSE6nehaOP4Ck4hzNl3z/ie+v5ZKGOKhpU2cAsE4qQ80QoJAsfJIH2CWJXsMwQrXwx5Ky/WA26i
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:48:30.8983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 662bd4bf-bb4e-477f-c0b4-08dee71dfc7f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9576
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 11:48:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23698

Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
---
 .gitlab-ci.yml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5a20ad6..57fd01e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -122,6 +122,13 @@ build:hihope-rzg2m-base:
     target: hihope-rzg2m
     dtb: r8a774a1-hihope-rzg2m-ex.dtb
=20
+build:rzt2h-evk-base:
+  extends:
+    - .build_base
+  variables:
+    target: rzt2h-evk
+    dtb: r9a09g077m44-rzt2h-evk.dtb
+
 build:qemu-amd64-base:
   extends:
     - .build_base
@@ -196,6 +203,14 @@ build:hihope-rzg2m-test:
     extension: test
     dtb: r8a774a1-hihope-rzg2m-ex.dtb
=20
+build:rzt2h-evk-test:
+  extends:
+    - .build_base
+  variables:
+    target: rzt2h-evk
+    extension: test
+    dtb: r9a09g077m44-rzt2h-evk.dtb
+
 build:qemu-amd64-test-nokernel:
   extends:
     - .build_base
--=20
2.37.1



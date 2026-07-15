Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E98C44508
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 15:50:47 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9536.1784130644440956035
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 08:50:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=ZP7Hjfdx;
 spf=pass (domain: renesas.com, ip: 52.101.229.48, mailfrom: hung.tran.jy@renesas.com)
Received: from OS3PR01MB8523.jpnprd01.prod.outlook.com (2603:1096:604:19f::11)
 by TY3PR01MB11788.jpnprd01.prod.outlook.com (2603:1096:400:407::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 15:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk8EnEcv9k1PJhBJc64OKaI5YxM8DAYvZcu0TQRVN6ImTOJoWVF2+OClwydaFKMMlaopu7Fgw82hVUFFlG6q+JyCCVarhRYcOtpzZOvJinoGXlxqnvMK4cX6B09SfBdgjbLwW4NFdHDx36x9OMh6HUKhyfz8GOfG8dWwd9fJGagl9AKU4uhv8PWtMnfoi8qG2ZxcVi2izhXRQAi4wP8CLUYq4AiV/9D4aOA/BEvPRb6BPsFItMHNZU1Zdb9BaZYhj+hP+rqBupVF8t++qnyGEIzD02ac28rjH6aVt440wNloDfLMdh9T6vleoDdj87Z6ExTCM55uA6R9BVrEiZHFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKW4UHA/HJ3Kg5lEqYeQMllgQHq32rplbEPALeM4DRE=;
 b=hwxaeYCN0BTzZxHkHOw7ZBqUoewEPdVrVUVpo87UXHljSVgPADlzAl5KzQHN5qPRhKMrDbrp0lXXN6JOcG8bg1em7ZodKMZ2jb96rFnytA9POaKKemQTk43TaZzWgGQLqDJnV2ISs5eh+Yvv68LwcPPA3MlvSG0xO0ePkCCyu+4dfvhUbELo63KP4tQm2w1J+E3XvSXXdgEdprrU7CpPvxvC3HhvrQp1uEulzrKz9TN9dR8bDLQsn+NcLG+ytBYdZE7RnFbnvSECFrynW2jiSpzVxjNmVdvQr6VUJVqixyw8gGsmvws2RlkSKurwfI83XEpKRlLtnWWoYnYSCEq9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKW4UHA/HJ3Kg5lEqYeQMllgQHq32rplbEPALeM4DRE=;
 b=ZP7Hjfdxz7bu2v4/pUiKvedj+7KbL+iZ8NfXHVz1wjyOSttv6Zaqd1uENnYc8oiQOlOu9mQm4Gp337bfzE6QBj/63XPXmLXbmcjbzYtV/v7KgENSXiyCckRqvBK1svNc90jCBWQGRx5fNnUOfM0ijPOp4btz4HgOPAReLKxLdxA=
Received: from TYCPR01CA0127.jpnprd01.prod.outlook.com (2603:1096:400:26d::12)
 by OS3PR01MB8523.jpnprd01.prod.outlook.com (2603:1096:604:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 11:58:32 +0000
Received: from TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:26d::4)
 by TYCPR01CA0127.outlook.office365.com (2603:1096:400:26d::12) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11
 via Frontend Transport; Wed, 15 Jul 2026 11:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BADA.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Wed, 15 Jul 2026 11:58:31 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (unknown [10.231.33.39])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 209573000171;
	Wed, 15 Jul 2026 20:58:31 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
CC: Hung Tran <hung.tran.jy@renesas.com>
Subject: [isar-cip-core][PATCH v2 2/2] ci: Add rzt2h-evk build target
Date: Wed, 15 Jul 2026 18:58:10 +0700
Message-ID: <20260715115810.2379-3-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260715115810.2379-1-hung.tran.jy@renesas.com>
References: <20260715115810.2379-1-hung.tran.jy@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: 
	TY1PEPF0000BADA:EE_|OS3PR01MB8523:EE_|TY3PR01MB11788:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e1d9151a-925b-4850-58eb-08dee268640e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: u8plFsb0VmgEbWqzECF9A6n5Wv4K6tvSM/Jf0HHKbFaDugYb/4WZDZavz7LDPaZIm6TTcYW00CRHMlgah+fSdwcJzxjanbrriz3L+Q/UCe4EdM0dsEtDpzlHLb5lxi3O3Y79vdAS2mapj/0NczJ6/JVDBhdka1qPs69AIcQQoNBV+sdLgicVxX9FVlMKIGuy/m8dtKogZ/95Fo1XK/o3id/L5Wc1N+d+izEIl9lpo7lyWqz/9g5P+nDMUfll2N+hqIUcYPYr1Y8A9phvQ/iY3q4mgalb7tDFCZwtHZZ15A6BW4wm5VD7t1Rz1wNP+X+aDQhpvBt4TYvQseAD0VbrCQcuJmUddeXlF6y/aGWSrAaasih2wH6g8HSX8Zwy4IQAzwFjZOJf26yWiHcC3gtK7+EJ863C6tiHuJ9ymvcrF3xP0TwbOVT/oUAwJSc3XY61L9YnNkkEHfPWf1DBkxMfRRBGk+MT9nvpLLqXPuGbe4k/ytFHnODggqhQa9NQC6whq5d2/K8Cc1hLxUWYe/ICSE9NwelGnj3cpFKUUnBvwOGp54BbUGqWbHmQ5LG3CybZy9KLK64G5ZTssz5hJasL/2YzCF0/tuCklz4ykLRKDb0rPblxx27qII5mH0tqd3fuAP4a3znjRK0iNkrUo+ns2pKPOZr/mSWBTVKC3ChWxTXYiBC/XxJRRkRKGNZWGIe+fLGXls7K/8e27ktKGEZOaw==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PT+qR8WqKXeu2ZqnM/4adFULS7UayuNAxAPPL6cRTb+SUxHk0Wf95g1Iz7lpHxVdxhd3nHTqjUXhBp6z635vThX2qQOZv2Fs6DvlewQGKPqznvnOIDTT2ie/feSGcL874FKUAhWJnwNwo2MKj8Hmu6/CsFG+q4odBzkf9P68vkQVQofOPVP8wJkaLjcwzfF+q+4e4/O7xQ+6TcLgU9kjUYaHOYW6LAc8/xRVxpQs8YZDqlr2IOG4iHfU5oB7wnFkltXjPUWcznL9cpWcTBeLAK2U9zZKKmh+hhmXOalwwmWk7uPhksd0GeW9d49IbNPhaQMHU7X8CuYzqIm+74slGm3I0fYb7l9C4Bpu6dUfmlKE7ct9IFQh+SjlR/NP1iEejZjPDGUBMyaDOxjVhuD6yU71NgPBBTPrwd4tr330Dd8UAV5XUKDIjleKynEAKiRn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 11:58:31.5818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d9151a-925b-4850-58eb-08dee268640e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8523
X-OriginatorOrg: renesas.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 15:50:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23598

Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
---
 .gitlab-ci.yml | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5a20ad6..f33184b 100644
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
@@ -292,6 +307,14 @@ build:hihope-rzg2m-bookworm:
     dtb: r8a774a1-hihope-rzg2m-ex.dtb
     release: bookworm
=20
+build:rzt2h-evk-bookworm:
+  extends:
+    - .build_base
+  variables:
+    target: rzt2h-evk
+    dtb: r9a09g077m44-rzt2h-evk.dtb
+    release: bookworm
+
 # bullseye images
 build:iwg20m-bullseye:
   extends:
@@ -309,6 +332,14 @@ build:hihope-rzg2m-bullseye:
     dtb: r8a774a1-hihope-rzg2m-ex.dtb
     release: bullseye
=20
+build:rzt2h-evk-bullseye:
+  extends:
+    - .build_base
+  variables:
+    target: rzt2h-evk
+    dtb: r9a09g077m44-rzt2h-evk.dtb
+    release: bullseye
+
 build:qemu-amd64-secure-boot-bullseye:
   extends:
     - .build_base
@@ -337,6 +368,14 @@ build:hihope-rzg2m-buster:
     dtb: r8a774a1-hihope-rzg2m-ex.dtb
     release: buster
=20
+build:rzt2h-evk-buster:
+  extends:
+    - .build_base
+  variables:
+    target: rzt2h-evk
+    dtb: r9a09g077m44-rzt2h-evk.dtb
+    release: buster
+
 build:qemu-amd64-secure-boot-buster:
   extends:
     - .build_base
--=20
2.37.1



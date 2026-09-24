Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52044C9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:45:44 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5962.1790250337706625988
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:45:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=gh8nXrt+;
 spf=pass (domain: renesas.com, ip: 52.101.228.65, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HScjFPo0Wb7PCMErUtbf5JMaRmoBAj40WnAP06g7OtaD6HL0rHJIN6lKl3LdMJdjIDyVnehrlhJbKNHQzfcf7rDmqHXZOT4GhurdIeLbyD//G7CGRrP417UpuWAvAD8sjPnYygHqgRu9OVkz8JSXO+cGee4Xnv+IeU2OarliwwzxAmWHCl5Ktbq6b15eqI8z8rd6mbDfDLKi0gjlmHlYOj/oahlUuVMn/BomYJq/T+jDAguhwGEnk1/BQcGZYNhOVl+Y9v9EGPKh1c9rjNs4SfivaT7HbUC6nPS9Z5NsMOUR6Ja50qcFzSXXqYRAGLhGlOnxMhwcDLnyQf6p6gZQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvciBfbLRParow2eY/7zPyaucHQOq1JznSQ1XXBUsb4=;
 b=sRCpiy/d4gBkrmHrFodgWXMTtCEmNpeyVhgSFEY7QHz4Jirj6+RtjOf3HT7mHS575kEIshfm7sufWln1hMCiHwcjjRdruj0lyw7cQ/ESN/6lEuytN51EfbCw/Yvp3pbzaL2iFYqZoCxUBXPpRjpOLnhoGxFeEClWjsZMH9D2xt9EVcWFCgeWVqbknRv9lYrH3jwlx7EMXSMTv5ff6q8jmcyYlRZ7UK+qEX17sY+JxYqvC28o0NTM3kErc8v2o1cqsrcZPAe578L1eElWC2Rk9TWKl9jpJ8u5ZTbZqIOdz/v/EuNfA0yau89mABf77lutUR3nOH22We9HDvPmcVNhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvciBfbLRParow2eY/7zPyaucHQOq1JznSQ1XXBUsb4=;
 b=gh8nXrt+zXe+w1xIVmzXn/Ir1OQ3UaFawV6rNrwM3MCvOMaxpI7D4pQTf+EX60tBQORNDCtAF03BjHVNzv+/U0qZEfd3Uco60MraP7k560hp9oII0PwIErpeZFfkcNW7ceNwHSVdber9rkxE6Ze0OM5xCsTTXXN7vkhwNpxpmG0=
Received: from TYCP301CA0060.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:384::9)
 by OS3PR01MB7048.jpnprd01.prod.outlook.com (2603:1096:604:121::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:45:32 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:384:cafe::8e) by TYCP301CA0060.outlook.office365.com
 (2603:1096:400:384::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Thu,
 24 Sep 2026 11:45:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 11:45:32 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (VNM-5CG30610QM.adwin.renesas.com [10.231.33.39])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 33BAE30001E7;
	Thu, 24 Sep 2026 20:45:31 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com
Subject: [isar-cip-core][PATCH v4 0/2] Add support for Renesas rzt2h-evk platform
Date: Thu, 24 Sep 2026 18:45:27 +0700
Message-ID: <20260924114529.962-1-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|OS3PR01MB7048:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 82af0e74-3b44-42f8-d462-08df1a3156ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	zBNaeqjMbzsiB9SPlXSJduf4+y1xIu7kc2uXgJbJxNLHwbxDoyoWKMcb0/mWESNSL4Iy+SfmOJ3NbjbL98oYKSA0YO+5mAmI0bPDg8HcOp8vqtTxukQb04IfNjwldb/ONHRePuxgk40HHFngDrgycAclRilSGl8/ym4RYAsy2Em+IfAMOj6gPK3Ux88JqLnv/wnJ3ezAn0SI1gVs1wYO+u8dPcvbpM6YuDJHuRGcGrXUjp+ojat7EQLBGpSTBbNSHYP3IcOP8qMVpvoSbAqIU/T92WqIAwFOgk2bLdUxs35qtMvxXj4uiT/BwDInJbjJEA8A+jvwlNulvv6XCD6qqh8AaR2L7mQYM1borDW9BdPW+GECxOX7Ra2qGmInO+7YgjuCyC+ZF1kMfk5z3WWKE/rbppjmYH9tJobNZhY4pahKsF8SdzGVtErJhIIP2wc8PrzFKLLwU9KTdk0QIR6IB0hu7utrMViOjcyWsMk8VtQOMSf0mpGDdUO/4Hg3Ehh9VL/ixqJPbU6SkbEW9ZJsAiq9XoYSVAcJG7nIEN19XKXXdZJIi9C9LjsnVo6XhgXr1Njk3zcf0vb+gmkn2z5g40em0Yw5lIGlh3yZmvGJ428o763P0zbz7D8yp6DBnAqaUSrJks3JlqR9b9d/Ww574QVu7swDviVq9B/ARv978o9VJu5sxkYsgLJaxX3adiiiiBU1yH8opMQnnEs0MXsqzw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	VJhEzWbvk28wTDdTGYFIDgjw2ac950M+FZQGbtx8zIBIJHhmc3QL3Wx+KTNfHxPmdLp5bBxz3HUJYucOgOb8y0Cauouv0DUUMdMJgyXOXBAEAC2/72upIkNWTc8RT3T5iqgss7BYaM8NIHg6WnLRYK9g6RxBcjn6aqhsqqV6QgzOaFEjRGim6vQ7mgQ3LfYA0bInCvXDcKFAJRo5kX5Eg1kfe00u9f0RBRI42gJniMfBIrstVwcT6RnzAEpFwr0Cb6KX60wWA9GnlYFIpQmFDzJIeyi61J9liPohKjhV9zPhd8sSkbVttAvpOc5+Icc5uUYCfCXivVNSKEbI7oJddWHJCm7qj+XVB+0m3B9562r/eIXFgG328lI8xrqh2yj6CFnnXkIMbokMTEEb5yasJ59pPK/EYEcNiI6srE/OOPHRAaqJRzm2fJVHMB8zz3ua
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:45:32.1261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82af0e74-3b44-42f8-d462-08df1a3156ca
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7048
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:45:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24333

From: Hung Tran <hung.tran.jy@renesas.com>

Add support for Renesas RZ/T2H EVK, which is the new reference platform for=
 CIP project.

Changes v2:
- Remove unnecessary exclusion with 4.4 kernel
- Add CI

Change v3:
- Remove CI build for older releases, only keep the latest (trixie)

Change v4:
- Update commit description

Hung Tran (2):
  Add support for Renesas rzt2h-evk platform
  ci: Add rzt2h-evk build target

 .gitlab-ci.yml                    | 15 +++++++++++++++
 Kconfig                           | 12 +++++++++---
 conf/machine/rzt2h-evk.conf       | 18 ++++++++++++++++++
 kas/board/rzt2h-evk.yml           | 15 +++++++++++++++
 wic/rzt2h-evk-efibootguard.wks.in | 14 ++++++++++++++
 wic/rzt2h-evk.wks                 | 17 +++++++++++++++++
 6 files changed, 88 insertions(+), 3 deletions(-)
 create mode 100644 conf/machine/rzt2h-evk.conf
 create mode 100644 kas/board/rzt2h-evk.yml
 create mode 100644 wic/rzt2h-evk-efibootguard.wks.in
 create mode 100644 wic/rzt2h-evk.wks

--=20
2.37.1



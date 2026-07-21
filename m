Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B76DC4451C
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 11:48:40 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20761.1784634516382817179
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 04:48:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=jbWzDJA/;
 spf=pass (domain: renesas.com, ip: 40.107.74.35, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSbI33YmP5j4jMYLiWelGP7tKmYzF0xP4SWd/5DI2qe+5NKjsJBf3vV/4wzxrNl1m+0oQ2bsmXIfLepyniusBwbtqysxaOCcsh2EAIasdSuTQuut29kOQMY2seNkAF8BLOGV42H4ZfM1Sy/rpsW1rx3R7xMOaM90nICZyKDLStKLHxVmwHi10QArd4CgRHjUNfK3RBx/326P+YQiDxL5MKL894M3KurMIUWHFh9IntzK8Qpyj6JCsUh3tkEA6fn1IWYtmu1QqDhf16XSd7MF5e3GZy7PaSH0Az+0DHkpHKhDmqYqBZru9huDacRD5cLfQMpvqpfaSzM3V8MYBhrY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT10flvgFBnP4880P92296j5g6WVbAnw4943IF720w0=;
 b=ri4gKy1YL7hoYfX+gzJziVORv6ZFKVAVw63rCytlbLnd2suB9ihiErSPHCXhPyBy3jWkb1Ri5Ckd9QGm5MauJl/TsJ4owu8eIEKlJgTNWRBcngNU1j41EXagrlKjslGkH1XXw/o+GgecGUAfnRPsRnsEa3PUvFwrbWSxSjbEd4jPaiW8Uqs5W5vIR/4kvNk67qRRVhU4AlnPbJxaJtUUjZe/7GCcZlVLkUMWM+9JIBDpaoFSS0pCN/gnD4HRxNGqwVgWmCKhJOl+9L2PTsPIa61nrNZLfTP1bPd+6T0zEwCTsxa43bpol44I/EMt8MtlhXAgt+0sHC9ypLKZxF1tiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT10flvgFBnP4880P92296j5g6WVbAnw4943IF720w0=;
 b=jbWzDJA/dFkfixCYjZaRlMaTrWRAG4fpYEJgIMQZr0vU4a62/kwvS4ULnPccWIK7gseOXR3Jsrxsi9Phmte5ATxgLoX4FUZ65HnrD+DaDRSjsip5UtOmExTTf/Z8sNwKrcn+Cdm7VQBV3RfitwS5o8mZFxM0Tk8zTGm8OikUmKE=
Received: from TY4P301CA0090.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:37a::12)
 by TYYPR01MB12660.jpnprd01.prod.outlook.com (2603:1096:405:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:48:30 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37a:cafe::34) by TY4P301CA0090.outlook.office365.com
 (2603:1096:405:37a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 11:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Tue, 21 Jul 2026 11:48:29 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (unknown [10.231.33.39])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 73DF53000203
	for <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 20:48:29 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v3 0/2] Add support for Renesas rzt2h-evk platform
Date: Tue, 21 Jul 2026 18:48:26 +0700
Message-ID: <20260721114828.1390-1-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TYYPR01MB12660:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d48acc7-2224-4cbd-4da6-08dee71dfbe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|34070700014|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	72Dka/iSNDXESlvkt9+/8EOG3TtrV19CmW0/Rfm2irUzMaS1mMwbSWM8lvLShZueeUseHdeoXfjdMbgJuod4bB48MNBglp3/pZP9P9vaeCK3CgSCfv2y1G5qdtr+v+kaoUoxUDjgi0jX4XYoKAGM5Gxjat2NzjfFQBVLIErtjrNbptF21mwr50f6kwndC8btUNcvs0dBY2vPXhlkzUJ5K3FVAvZTN44b/YaViD+Lq3O4jf39L6AvHgXvCJw9k6mD9p4/j36bo0Eze4YiVCUu2fyr4voZCsXuSRZQu44i/oWy16ab8gPCxi3+n+ZUzs5pGe30j5cDSD9vZWZx9+oEKrAYsTfWEGz2Mfx4tcn4gjrE1pF6UgeCA/8RkT+OiCqJtsxTPJ4FbPefCjwilH4BWFz89zS4pwWnnVzupVkX7yd4HsJjfp5WSa+iNniBIDyqr97k3WQc8GXiZjW9f6NB36mZpEdphVCNSHTJM2/ErNbA4b80yfNnlASCi69ZKTdyvafX31y5oUurKP8SJ3M5EwfvRTtZiwZyEEvviq1oURlQyAVYBzI5iOPpiohT8pLtCzSlyAF9fiPtX1iAnDOufFKlAccDwR8hb6A57ds+TZ2D31MM/9SH8/1B5TnnyCI2DDO9aIEPOtcPRKkBBXDlbDHhqtwwIJUn4JCg8RcBKRQiJrEKVoreAJFiNKjGwM1K
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(34070700014)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	MRuqJtwTLK8/SynvpfJunXJL8EWPUGlOW+X51uGfEGHZWdceJ/XgM9YB53r1ODYQyie+rBMB7nF88kcbB7V7YqQbi0xGe4LzlI/n2ReMMFpJqOXqqbWeReau57a9pYW4SJcYP1Fyu7HCvqrAUabgWLsUMrYr7hCHiVT5A/AxHDfQBPR/9ncSzgTMc2itgGGc3sN8Ee2ais6iZ0KmCc69lQw0pLKOE45z8PZbyHcON56n3aUn0VkD+sxw93ypwiC8LxehBDQeF8jdPSqHkI6KasNfv57qKzJb5kLmX2q8M53PtK9NJ1FuJJRfY0vG0HpZZuLGOm/ziofRcowTuyOYenWRi1r/Is3gPIqWuByBm7LMAUz/nj0RdxsIgXntcT7I0jzvc/SxSsvSt4XW6CdqWqt2BnYXht1HIYhFs/Sg7bdCctUODMC2J93fSGFb9qTb
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:48:29.9054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d48acc7-2224-4cbd-4da6-08dee71dfbe8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12660
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 11:48:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23697

From: Hung Tran <hung.tran.jy@renesas.com>

Add support for Renesas RZ/T2H EVK, which is the new reference platform for=
 CIP project.

Changes v2:
- Remove unnecessary exclusion with 4.4 kernel
- Add CI

Change v3:
- Remove CI build for older releases, only keep the latest (trixie)


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



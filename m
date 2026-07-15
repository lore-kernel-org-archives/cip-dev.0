Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EC2C44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 15:51:18 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9654.1784130672883567351
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 08:51:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=lIOs1ym6;
 spf=pass (domain: renesas.com, ip: 52.101.125.71, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vec8ZcOeohA+4kZA8GhjMx/jY208XzGWbbT3wSrIX+/r5pYGVWUThojHoV7IPj2UcDQCdUexDxkn84w7mMYF53ukG/rsPCvXo7gncMbq6qfVn9xOqmaDS/U1U+pYbxndSXYTivILTcISPkeDg6+pBT8Hze0UVhUsq14r8WAjh7PX6eKMhRB0ppOhIDmEPB6FCM8UaxHyNmFFSd9qvn4GL9voJ3lfUtKeI90ID58uh/Lurd7S00YTX+CMbEHnwilCdSZwAQ6zcCJ60NGHq8ADLrZbUgM9wZO+v9t9SgNgR77oZ5QFmgLJBBuO0OVS0MMorWEYOPHJ+uTzxfX7pLZpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOQ8AL5iJGkaIVNDXFB2gAqjCpC8nPARyZaqCaoNzWE=;
 b=nsM1rXr6eejAlO7z4jMEcfuA57YdkQ0JRkRnP8rjJlRfBLZm0/r+iITkuIjVFdL/I3+SZhUtZiAAkmgklOcmR1SFsB3RM1dvtvgr+Z07rIioWlqH7ymayi3h7usmD+w8QglJcIPf2CiyIAvA4JD4dUDnU1LEzX+NgjFl44dNxS9Nr78qw/A4yUPI/SLL3nokMAyTSJyozg5e+FkD7IIwDnB1GGyNZk6g9vDrvbF1s1JENs1DqSMspgbKfaxttct+ZyU4vTFq+48KhsJOMBf8LNPW+Hcf98xiFf+/kgUxOjM6nHTrbYwRo81ALfoKjRJP5spOvERSeeHz98m/nXfEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOQ8AL5iJGkaIVNDXFB2gAqjCpC8nPARyZaqCaoNzWE=;
 b=lIOs1ym64assKnHrO3ygzFwGkVxfn2Wo1zlEsTBnmNZ0zRMBSHUoR0NPlGgfX88LoPD+wp0wwa6Gz9P6/ox6RJsiAcRXq73hX6k5iSixkNhrMjCBBJCzGvg2e5FlHgZyV/dQdmBjA/WSvRj/+fnOfoBRmSmL3qsAa33cwjjKL/A=
Received: from TYCPR01CA0130.jpnprd01.prod.outlook.com (2603:1096:400:26d::18)
 by TY4PR01MB14798.jpnprd01.prod.outlook.com (2603:1096:405:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 11:58:22 +0000
Received: from TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26d:cafe::83) by TYCPR01CA0130.outlook.office365.com
 (2603:1096:400:26d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 11:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BADA.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Wed, 15 Jul 2026 11:58:21 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (unknown [10.231.33.39])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id DB67F3000171;
	Wed, 15 Jul 2026 20:58:20 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
CC: Hung Tran <hung.tran.jy@renesas.com>
Subject: [isar-cip-core][PATCH v2 0/2] Add support for Renesas rzt2h-evk platform
Date: Wed, 15 Jul 2026 18:58:08 +0700
Message-ID: <20260715115810.2379-1-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BADA:EE_|TY4PR01MB14798:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 28aac4b0-abfc-4e21-70c5-08dee2685df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	RCP7k1gw0OOHiyvUVkP/EvhzAaoWDTqG2bJ0Qfo60uOItH5l3hlLv2/wO18TK13XHT5DsmXDdpCuLQql66t+xz8LjxXKclvKjQ00oprvRuMhlmWA3e2373qUP+0Fs2MO4dn3VCtFeNdgjsQVZE9pLC0phNMgqvxNBmkolhuQ+bqkFzJye89skEcvdqTxoAE3F/nHH10g460Y3GU8uGJQC3FmsUE6klH5mZhS7S1GK67kh3YeTRHDntK21MYu8JMP+W0FWWREst4EptE1UsBzmQH/nKQ9yW5QKnxaTWvvEKmnpN+w7MS/wFaLngW8sxKsQJsg9rvuKdGM6E0n0H+SfKw4/ATovD0gL1l2IWeQd0chhj5l0qpzWY3GIsTc3vtaQzLaVvkB9nBUOnH06q5JgOiOUVtNEUoDdjO250pAbg3maJ0VVN9nLe8lTGLdqCfmgOezaoNqCT8Mxf8TjEubqAQzHgVfjElEYfUnNNJQjqENfPv97MFyrEklAlihjCfYTxIW/+POoR7uce45JCTODQhhxA6ESLTToSBKJlJM5Vt6W8tGmoSEvp78QK5kVGKH+N36DtHmQY9omLQy71pAn4mdB93Pz5PVcvMBEElaYjJvbkP4gscigtxgdFRKk7PWS+/Y/IGpRESUVFSuDLMJLGMW+Ie3QItKMH1xsokq3EoZHE1uXWmGi1wrhide7kM2
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	l3QAMiKqFJi/pKym7BumaZz3fA+kKWqREmbOauhwbAsYI6x8b1hBt6Hy//E/9u3cjsbEqZzrApWY5/atFr5ZnMTjUm3Rk2MfUsQq5xa1xgh+H16CaazSHMfIW7taExDKeSpG/EcuWes4UEN26Mh4M6Q8ACu+KiFWxcErbISAQDTwmJsMu+c1/zUlYBTk27+aD/gPuMSBOgxrjJ0zaYoyKEER2bRwtxcUjwAk9/db3ts0T53NNS/i2cbIT28386lyEJyiwD0Zh/lzu+rAZJH6fqLhOLP6f0YzfFUzG0Gy53G+Rg1oHE7K0SG+U6KA/024GY7NbvLqL8e1tQ094fe7tDgH162qg3yDf4AJwsWV4W8SYYPMo9IdgIFyTo9zT3bzXFMzpdyvku9GY6X8VzxIvI/CckUV9iZ63VKjJQz0OXSShvHCawSs9lxz/4QN721f
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 11:58:21.3787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aac4b0-abfc-4e21-70c5-08dee2685df9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14798
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 15:51:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23599

From: Hung Tran <hung.tran.jy@renesas.com>

Add support for Renesas RZ/T2H EVK, which is the new reference platform
for CIP project.

Changes v2:
- Remove unnecessary exclusion with 4.4 kernel
- Add CI

Hung Tran (2):
  Add support for Renesas rzt2h-evk platform
  ci: Add rzt2h-evk build target

 .gitlab-ci.yml                    | 39 +++++++++++++++++++++++++++++++
 Kconfig                           | 12 +++++++---
 conf/machine/rzt2h-evk.conf       | 18 ++++++++++++++
 kas/board/rzt2h-evk.yml           | 15 ++++++++++++
 wic/rzt2h-evk-efibootguard.wks.in | 14 +++++++++++
 wic/rzt2h-evk.wks                 | 17 ++++++++++++++
 6 files changed, 112 insertions(+), 3 deletions(-)
 create mode 100644 conf/machine/rzt2h-evk.conf
 create mode 100644 kas/board/rzt2h-evk.yml
 create mode 100644 wic/rzt2h-evk-efibootguard.wks.in
 create mode 100644 wic/rzt2h-evk.wks

--=20
2.37.1



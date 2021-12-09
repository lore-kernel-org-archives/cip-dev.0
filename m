Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFCBC433EF
	for <webhook@archiver.kernel.org>; Thu,  9 Dec 2021 11:11:26 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.80])
 by mx.groups.io with SMTP id smtpd.web11.10267.1639048285477713984
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Dec 2021 03:11:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Yv1iWAkp;
 spf=pass (domain: siemens.com, ip: 40.107.22.80,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJj2LcS4dhTeXvLAxVNMD8shCygUAFktFEJ1NqOu7spFr4gIOITigs3WE2wYwGa2PCEcVh4lobqoupRiQBdOPkW3/y8iRoA2tV6r1JflhGeeJmLnLkwxM0EnkyKpyU7RQwKuiTxJuUrqJqay6nqtbbymCqZRxt8uTZaXDYbi8iVVJ9fm+vyCisjaEoQiGbiinEG69xUyW8PRVout9sxfFTsiIwHKrtTnASWSyOaxlSZ6Ial8DXhjPrRepn8gaeQNZMRxA6clJAvN39DPo3YwrBCAzVGwzD/pFOJp2s+dgUXrQTB45n+NBMsBSTi/8msbmC70vAUNZyOheF9MqVj3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suW/efVtsB3UNY7W+HVeKWHh1n5SbQMFPJM197yInJ0=;
 b=VHcscdZ7YhkhNtNS5uiakOpV47AmFdI49q9SJLSh/qyD5YNsaE7Ag7uZunOCx7orUo9XVwwhrU8Bks2AOEbqf4SuhZjoLx9J7bTZwa0Re2HZxUMFdnjuq+5HyADeW47UgP87tAlDzmGer+2ftCfhpT9HA7R0HGrPUndzQiqyNqMl30S7/7VrxxCiUhKw8i4YooG56iSwwnLGQNPbuqw3ZcZg1qHa1zQZKwzwaGNozrJHxt5NlN5rlxoWBW8zZJzorF/QAwULRAmWzDtADxyXw1OIAwRdfdjyx4jOcd90NTde0faIzlCk5WGY57pkN5GnVo3gzeOPCQ+cKy6Jfa8KcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suW/efVtsB3UNY7W+HVeKWHh1n5SbQMFPJM197yInJ0=;
 b=Yv1iWAkpjoXeee2k0d25ZuNRbtvEwIAnQq2rr/w8DaQQ9qMn5227LCeVaN14VMX5K7dlg1Z5jl4qgmSCw2E0SNdUGpDzZ57Hca1ZchEACD9MhcowJpcE/ilAQvbWPaz7UugZbiA3wRz94q6pvaiXTfqfu5Wm3SDmoxJbHEtxm6K51Ds+tFSiaqM/3mkQ7Nxc3+8N2KdmnKO0llNzTBpmLLMcjgRTaWW7QpFr+W8uwn8mwuG7qGpVt53jDIbVdNbvPpzmQbZUZhYTzT7bi/FU3dmD3TbUaPL1WclB9L13xWw2VMkq0qfaWmD9roXj2cjNkatSkzg1ARFDbX6xTYV/Mg==
Received: from DB8PR03CA0005.eurprd03.prod.outlook.com (2603:10a6:10:be::18)
 by DB7PR10MB1913.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 11:11:22 +0000
Received: from DB5EUR01FT008.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::c) by DB8PR03CA0005.outlook.office365.com
 (2603:10a6:10:be::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Thu, 9 Dec 2021 11:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT008.mail.protection.outlook.com (10.152.4.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Thu, 9 Dec 2021 11:11:22 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 12:11:22 +0100
Received: from [167.87.72.174] (167.87.72.174) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 12:11:21 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip-rt: Add 5.10.83-cip1-rt1 recipe
To: cip-dev <cip-dev@lists.cip-project.org>
CC: Pavel Machek <pavel@denx.de>, "A, Srinuvasan" <Srinuvasan_A@mentor.com>
Message-ID: <c434a1e4-5298-ec95-1b8b-b4fdcba52ffb@siemens.com>
Date: Thu, 9 Dec 2021 12:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.174]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 578d0dc1-7804-4374-2795-08d9bb04a250
X-MS-TrafficTypeDiagnostic: DB7PR10MB1913:EE_
X-Microsoft-Antispam-PRVS: 
	<DB7PR10MB19134501B79A4885B6E306EC95709@DB7PR10MB1913.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JytFjyJbw9UQ1x8pe5upLwEjqXkc+82mLdsLEMPCWZiZuOXGVXtDurXiiB4DyRUPpjlGsjKbewcBzzeiau0vBEfWRZzXQqqZn2ia148uv+tRJgHvEROFMKhdrT8U82eyYJZLT6XnZnOm8dtCHCPvjH9JWQ982z5Nno8Qmb6H4PNSEondr6wxUPNS4JOYsfpPiIcDDeUWmsQf8YWGLMV3ZaxCrd7KYo/dzSAEObKZTwP8ulHjNeNhOOoDco3bdeasS7wUtaRhMrxfAtGT5dNUIoywILbdkWsxyBUJ+W5foAPr61W66J7r+WnPNOpxhq0umjki5R8XOLIoAop5DYKapVCb7zzkf2dqjoZ++wHIKiXlLq8dHX0ttS9FKRlLxk6Z6A6TqeM1kiJlAGm+biOEY64pFfZxD5sDnMmtvyXbGUeajg3JbuRAK9aF7EQm7/Q5zIV+I8y+pJQpKH0/2MPYjDLtpyRhzgpPkJQi2jtKdQce8c50Alpe62YkV1m7k6b0FvoA91rtcLzxt49IVoXuaEMvDHFaVBogYEbXBGEhfBkgZhNOdjuFaSj/+q4x5hn1XDv7pv4yBSM+n+HD8KiV1PgErtkojdKTgND2SANuZtpnU33i+wx1ozOPZghF4RX33Ioq1McjOLmp6Aiqi7UgYx2cCTWR6zKIf2hi8vZcgJV82GEXYHH3cOVE3uutQcZoF76e+DvoR6SB2OErGWMi4os40wu31I95hnNVaXLLrfq4OBSWzpo8XkQ9mikpEHjbi/m53FpPFICT1x/Kk3Hc9OXnS7i+s5RGLJoexzIFP7QMFfSoMCH4udAE9cs/KvrdnEfLwpWBV1FySnwkNbnIUwwqE+L2MEPTHER8/ab92DloIQCNJO25npU/jTZmdjai
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(508600001)(81166007)(44832011)(966005)(186003)(36756003)(16526019)(82960400001)(47076005)(82310400004)(16576012)(31686004)(70206006)(70586007)(316002)(36860700001)(26005)(4326008)(6706004)(5660300002)(6916009)(2906002)(956004)(8676002)(2616005)(54906003)(83380400001)(336012)(31696002)(8936002)(356005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 11:11:22.5967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 578d0dc1-7804-4374-2795-08d9bb04a250
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB1913
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Dec 2021 11:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7080

From: Jan Kiszka <jan.kiszka@siemens.com>

With 5.10, we slightly need to tune the config fragment in order to
enable RT. Rather than carrying both, simply merge all switches needed
for 4.4 up to 5.10 into one - the kernel will pick what it knows.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Pavel, does the resulting preempt-rt.cfg (still) make sense?
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/next/recipes-kernel/linux/files/preempt-rt.cfg

Srinu, please also check. If things are fine, we could re-use
preempt-rt.cfg downstream as is.

 Kconfig                                            |  1 -
 recipes-kernel/linux/files/preempt-rt.cfg          |  4 ++++
 .../linux/linux-cip-rt_5.10.83-cip1-rt1.bb         | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb

diff --git a/Kconfig b/Kconfig
index e03ab50..e69293f 100644
--- a/Kconfig
+++ b/Kconfig
@@ -70,7 +70,6 @@ config KAS_INCLUDE_KERNEL
 
 config KERNEL_RT
 	bool "Real-time CIP kernel"
-	depends on !KERNEL_5_10
 
 config KAS_INCLUDE_KERNEL_RT
 	string
diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
index 6b52f32..4afe1bf 100644
--- a/recipes-kernel/linux/files/preempt-rt.cfg
+++ b/recipes-kernel/linux/files/preempt-rt.cfg
@@ -1,3 +1,7 @@
+# >= 5.10
+CONFIG_EXPERT=y
+CONFIG_PREEMPT_RT=y
+# <= 4.19
 CONFIG_PREEMPT_RT_FULL=y
 
 CONFIG_DEBUG_ATOMIC_SLEEP=y
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb b/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
new file mode 100644
index 0000000..7b38c1e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
@@ -0,0 +1,14 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require linux-cip-rt-common.inc
+
+SRC_URI[sha256sum] = "e10b3ab1ad09ed7650883c5357b68660ac1c56f6d71b3b82feb0d69ed182ea54"
-- 
2.31.1


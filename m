Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D9C433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 06:41:57 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.78])
 by mx.groups.io with SMTP id smtpd.web08.48106.1638772915910295432
 for <cip-dev@lists.cip-project.org>;
 Sun, 05 Dec 2021 22:41:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=fi2yonXk;
 spf=pass (domain: siemens.com, ip: 40.107.20.78,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0y4fEzjJinj/cH75UTsW71wIoOH3jaJWILK440gspNZHaSzkJi/DJu3kxyi3QvQFIEXwnqv9bMMrteCJ9IfAf94uT4E/JyH1nDqLt7Acx7I9MnuiWNDaNHqWqN5fnlJm62WesgNOt7Bm3544zUbbTCEErdEZx6QP9SSxM3DREAm+pLh0/7F4tiWf3xjGG0PnxAGEuivZx3boJUe4Gas4LWn/Yeom+29kR1cLaNyIjEY1JhfklQOk8yXuUYRG4R38uWSL9tfNPrpU1X8vNCsVu/wJ+KeJ+AY+TtRTwAQhaGJqc1hzK7yA5gfC3sliZEew577gzRRUJinI0A/UL5W5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjafL7vANG+rEVrHCNllgzVwnCVqqLXXbWBY1Poh3AA=;
 b=QTC8rkEvQwTVTgzdlfDgXULTkgIgiU8neHYEdNi1El/wQ1y6ECTzGO1xZLSZnJVSvp2il8apvX3a5aTNPPvrLznA1FfxnTvfcd6bNyWiFIORhXPJycQhu9kDUgRogA/pSJpK8r6U8FQBs7VZKoGcyK/13uAQ0jtmzW+J52jkZeII4CjguBKlVicR+5/ocJ6UsRR/SAb2B6lsk90XYoGcw0oh1NcmMAFc/smgZhsJB1JvmTF6FRGa8/0eU3Fw7VbWAqIhLMI5y2dr3PW4Ckx6H9i95zjoYQPRhVDdlyH31GnJwgGNUBrY8GEKbLQ1z0Sw6e2jZP00uhreJcknLKrv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjafL7vANG+rEVrHCNllgzVwnCVqqLXXbWBY1Poh3AA=;
 b=fi2yonXkUSriGNfJ+gQ30OoH7Z9ycq9njNCKzm6Ud0wJ/KDYUODtLETl3NQ/BW46ENzrJ+8L74Y6I8wVAkg5NbXB0DC8/hUSn6jXo8OZKUjUh7XRzj9FKRoj0qtqFG6/iVoyg28hjUUjgn+Smpts1/Y2DI+bctaWxrmxD4im7hyyWWFgA7ra2BszQIOGvF6AD5J7ENYIKrEVyq1NZr5RphC67Lmf4SM+/jN9E1GRbwfR/FDWidxLGLfr2ALnYoyQUtf7jPptwqDn38/pwMtiUpk91NhPjqXX8aGXzmI98trRXZR/IE56p1XVCakLZzfql92zdvFWdBc18EGtQn7T1A==
Received: from DB8PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:10:110::25)
 by AM6PR10MB2357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:45::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 6 Dec
 2021 06:41:53 +0000
Received: from DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::4d) by DB8PR04CA0015.outlook.office365.com
 (2603:10a6:10:110::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Mon, 6 Dec 2021 06:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT009.mail.protection.outlook.com (10.152.4.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 06:41:52 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Dec 2021 07:41:46 +0100
Received: from md1f2u6c.ad001.siemens.net (139.22.134.173) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Dec 2021 07:41:46 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 2/2] linux-cip: Add recipe,
 option file and menu entry for 5.10.83-cip1
Date: Mon, 6 Dec 2021 07:41:37 +0100
Message-ID: 
 <d35cc40f97138a3c3cd6182794d6f8d4e5260869.1638772896.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638772896.git.jan.kiszka@siemens.com>
References: <cover.1638772896.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [139.22.134.173]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84af0572-fc45-4783-2f66-08d9b8837d1a
X-MS-TrafficTypeDiagnostic: AM6PR10MB2357:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB235708667CB8DE46488B4934956D9@AM6PR10MB2357.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2EEXD5xKcG0whSmLxDUGb6zQ3Mdn8KHrJR7f8UkRHQ9qQmEKF8CxUUqoNuVfZNzwLWR51Q3xzstelq1T87Czgq21UUwcVGk5JBN8/f0iLQr+xl8sUs5/5FRl8AVyXyPAQWOLLDR/J1vyIYliQS2YxNpJ7XC7AT1mu5tKK8cP8HemZB/Vfq8L+2oc+Yk2ywvo0b5KC95sT1csYYnl1TeAjlT+hpMnkgiscs9mh/+4F3d8u3G3doKHByRo+L8gWw7DF5bK/jOHwivJ4IBBnW2G1kBQ5n/EVcnUkIq/C7wSQi2+reWx1JXHh5bRfW9SZMEXRmedDDIoZJteh+uny/d9dC7O5jV6quOD8gGmBdUjiID9S1Nd6sqXb1uS6u62dKwkuDga9etYKxTpnHB6cQYyk4IqyJh8BbKGId4XT4iLpnzniMGmBbS9/N1Ul74ny55x1nPZlJ43/+i9kWAunRXyGPqSuWL6dakaNsLEdA6z3JCh7ICSKJq6sZKAN9P26Po1Z2Gt/8e4nBv6a/1FNpCsF7DBq8LVNok880c+CR6T0ZVQc6MRO9JxkD/4vFeNEA9baOcK5qvUmaZA5lAwX+7JV7Q6dFVaR2neBYL49l2fodN2uqUItani0eA4xSQBUsENKSMgITl6wq+wDq9gp9dbTrTkuML/rVBeolmMf3R409w2J10BMcSoAb2MBzx1QWZFlmb4fhc+nn3HsmMW3KXz/Ri4Ps1a4SOCC82pqfjllqPf22DKAm2rAF8uTDk/8S6RbzNbCM7hoDzvZSDN8oUqmw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(6916009)(316002)(82310400004)(86362001)(82960400001)(2906002)(508600001)(36860700001)(5660300002)(6666004)(186003)(83380400001)(16526019)(70206006)(7636003)(70586007)(47076005)(356005)(2616005)(8676002)(336012)(26005)(40460700001)(36756003)(8936002)(7596003)(44832011)(956004);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 06:41:52.7949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 84af0572-fc45-4783-2f66-08d9b8837d1a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2357
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Dec 2021 06:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7065

From: Jan Kiszka <jan.kiszka@siemens.com>

No -rt kernel released so far, thus we need to confine the choice when
5.10 is selected.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                                |  7 ++++++-
 conf/distro/cip-core-bullseye.conf                     |  2 +-
 conf/distro/cip-core-bullseye.conf =3D> kas/opt/5.10.yml | 10 ++++++----
 .../linux/linux-cip_5.10.83-cip1.bb                    |  6 ++----
 4 files changed, 15 insertions(+), 10 deletions(-)
 copy conf/distro/cip-core-bullseye.conf =3D> kas/opt/5.10.yml (50%)
 copy conf/distro/cip-core-bullseye.conf =3D> recipes-kernel/linux/linux-ci=
p_5.10.83-cip1.bb (50%)

diff --git a/Kconfig b/Kconfig
index ca67f30..e03ab50 100644
--- a/Kconfig
+++ b/Kconfig
@@ -49,7 +49,7 @@ comment "Kernel options"
=20
 choice
 	prompt "CIP kernel version"
-	default KERNEL_4_19
+	default KERNEL_5_10
=20
 config KERNEL_4_4
 	bool "Kernel 4.4.x-cip"
@@ -57,15 +57,20 @@ config KERNEL_4_4
 config KERNEL_4_19
 	bool "Kernel 4.19.x-cip"
=20
+config KERNEL_5_10
+	bool "Kernel 5.10.x-cip"
+
 endchoice
=20
 config KAS_INCLUDE_KERNEL
 	string
 	default "kas/opt/4.4.yml" if KERNEL_4_4
 	default "kas/opt/4.19.yml" if KERNEL_4_19
+	default "kas/opt/5.10.yml" if KERNEL_5_10
=20
 config KERNEL_RT
 	bool "Real-time CIP kernel"
+	depends on !KERNEL_5_10
=20
 config KAS_INCLUDE_KERNEL_RT
 	string
diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bull=
seye.conf
index 38014b4..a0790d5 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/conf/distro/cip-core-bullseye.conf
@@ -12,5 +12,5 @@
 require conf/distro/debian-bullseye.conf
 require cip-core-common.inc
=20
-PREFERRED_VERSION_linux-cip ?=3D "4.19.%"
+PREFERRED_VERSION_linux-cip ?=3D "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?=3D "4.19.%"
diff --git a/conf/distro/cip-core-bullseye.conf b/kas/opt/5.10.yml
similarity index 50%
copy from conf/distro/cip-core-bullseye.conf
copy to kas/opt/5.10.yml
index 38014b4..612b7f9 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/kas/opt/5.10.yml
@@ -9,8 +9,10 @@
 # SPDX-License-Identifier: MIT
 #
=20
-require conf/distro/debian-bullseye.conf
-require cip-core-common.inc
+header:
+  version: 10
=20
-PREFERRED_VERSION_linux-cip ?=3D "4.19.%"
-PREFERRED_VERSION_linux-cip-rt ?=3D "4.19.%"
+local_conf_header:
+  kernel-version: |
+    PREFERRED_VERSION_linux-cip =3D "5.10.%"
+    PREFERRED_VERSION_linux-cip-rt =3D "5.10.%"
diff --git a/conf/distro/cip-core-bullseye.conf b/recipes-kernel/linux/linu=
x-cip_5.10.83-cip1.bb
similarity index 50%
copy from conf/distro/cip-core-bullseye.conf
copy to recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
index 38014b4..a89f568 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
@@ -9,8 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
=20
-require conf/distro/debian-bullseye.conf
-require cip-core-common.inc
+require linux-cip-common.inc
=20
-PREFERRED_VERSION_linux-cip ?=3D "4.19.%"
-PREFERRED_VERSION_linux-cip-rt ?=3D "4.19.%"
+SRC_URI[sha256sum] =3D "85af8f809b2505c6434266d6658d977d62d383889b3a4f9968=
b2764794108d4f"
--=20
2.31.1



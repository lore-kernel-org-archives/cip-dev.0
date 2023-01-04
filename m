Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E69EC4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:41:23 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web11.12173.1672839654616948445
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:40:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Juqaeb9Y;
 spf=pass (domain: siemens.com, ip: 40.107.7.51, mailfrom: henning.schild@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdXLWVwTtQVi11j5yXpdsLHIJpW3uMrbQgOV3LZDuYvk1rVjWRwkyqwoaJVB1m5obGhwzEHqe4Exvfju7auFQ9jQTNPsTRUKxdfh+IttJQPV3A7V9YBphKswiuh2uLBEuZcujLvwnJ1WbvbBNOnN6wyRD+EKDDd5l8VktFfyzpDMycbRJHrq2Mvc0AnoxU2yuLJQyy0qbCUZoyBFMtd374bxpCrTIDIxE65LWH8sMVAD2Q9ccv2wcC7TV3SucKVbX95zfJeS46NabVTt1DNRb9wMhmhS93k5ksJACxuxGiF0CVyFbINOL82rM2WAj/3VQMgX/7jtfb7oDpEV0VPkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNLAdFGWtGkEYKNWcwRxHf1rNExF+KhyMgoP0k6rIG4=;
 b=gNpj8LlaDW8D2bfQi4Lw2t5j4YOeMgn0SOSVpqgDLaLDroVxnCrp3uBMmd+X98PvBlqssKkdWhq2sc6+LozfnrQnBTffSTlL0OrIF2ueNC0nBQza9sYsupMYgcLuys5W1TCok8KhnLUdBQgJ6zybIQ1dGy1AyO5NIc/mLZp40C+Uu2LjgQXBjqgY+1H+4eWKuMqZYkSJAoiQwHWfWaf5p9EsO4hdawfqa7gaMIYzWuKO4PnmXlg0gSilyBB5XR/B9IrfQ2cVT1kdEocgz2vW/6vTqGhSB1Y6Xguwd6MCQcnzUaThM494QkgTUEOLcjjEBAbmwDjUy4h1jzZrV8paJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNLAdFGWtGkEYKNWcwRxHf1rNExF+KhyMgoP0k6rIG4=;
 b=Juqaeb9YMYfxy4b5ewC/9SsKjSBokUrKwcGdbBq+DIUwNkbOYzd6MYxclXJjBiiqzgMTCIz1H9LXze69gEnLSrqp+dM9Hi3LXVUxWLqxUxhzLzQ30kyTzqAhj4+fVI+DrMGI6nBFeER9kSaEMKlPi9mGlYUq1lSJg4VmdfNVnTGPgS1WHzRWzmr2dJJOBr+BKtFUtnnJTvH0oCLe4U2tDQgVWGieNBKkSZcfUhNGs0gViC3jSmKe9lbROkvo7yZZfL/86gRtn/AtgT3F7OVECakHOCC/HaAswul2z0kbrFoFhTBREbnwVDyKv5IkxrINUpX7epToUNBIEIXSKG+B1w==
Received: from DB7PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:10:36::28)
 by DU2PR10MB7680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:499::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:40:51 +0000
Received: from DB5EUR01FT105.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::a6) by DB7PR05CA0015.outlook.office365.com
 (2603:10a6:10:36::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.20 via Frontend
 Transport; Wed, 4 Jan 2023 13:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT105.mail.protection.outlook.com (10.152.5.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.17 via Frontend Transport; Wed, 4 Jan 2023 13:40:51 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 4 Jan 2023 14:40:50 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.69.242) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 4 Jan 2023 14:40:50 +0100
From: Henning Schild <henning.schild@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Wang Jing <wangjing@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Henning Schild <henning.schild@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/1] change-root-homedir: split root home move into own package
Date: Wed, 4 Jan 2023 14:40:39 +0100
Message-ID: <20230104134039.11897-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230104134039.11897-1-henning.schild@siemens.com>
References: <20230104134039.11897-1-henning.schild@siemens.com>
MIME-Version: 1.0
X-Originating-IP: [139.25.69.242]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT105:EE_|DU2PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0973af-b6a4-4162-7a73-08daee594bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sZa4Wd1FpIKS0QNU5GyGO4ExiPN1pcrBHZ+nJdvUyl+uFl1cW9A88kfQRdjHFC4gsOU+WIl5wQQ3HFnp/Uj+2VqSHuPVXcaC8daDDvwdGwA1pCk69dcsq6JstdoDqs75l7Ojxpm0SjdADiLl9oPR3yixojr4FdmFS/q+tVO3BjEY7fe6O7Qeiqea8aLWdSSxe2aCsqYZhD/Wfxrvk/T9pRZEJAv5OUygpf8mvxlnaCTKw7cc3xCa5W9oYl3/B8xCDAXulxTuxhqoGVT8khRxIt+wBgCCOescoVQyV2dPvzeT/y4nE4aTqrGIJbDEgZ1SxzXeCriFG8CxiuuGjXUKl4uGlj75nPjiMgZXMismtAHcp0T58XlFjVcqOWP2FsdQrgwrTFoAbEVxRUS8dZSAsSJGWkKLsK/fli5O0MFMyPZ+W3gx2R1LT/h3nRh5YZ7Cifexh4mt7q2bSZf1PQKjnoGHB4dwL5xbzFOOmRARNBJdbkmoZr6U5jm3xWmfhN0oacbWXe0FlgrblFwQMwgrhOwaD1Cp/GL4IYdIL06g8HBPzJ+CXMfDIluOoGGklUmbkPxQYCgVqRimzWS63K6JGuWtAZktKQVFJTBZGBLQaxXxtnfvt6VXbLfPMNDLTQNt15Sd0+nS7ENty2swnDjxxUUc2RwZCE6BW+HAPEBlYagQEpq14rErnAj6QZBpP9Jw4qsRnk4nOalkCAhAGYIsv4mES7tNsMmG8vXTDQpicHU=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(47076005)(83380400001)(336012)(26005)(16526019)(1076003)(2616005)(956004)(107886003)(82310400005)(186003)(6666004)(40480700001)(40460700003)(36756003)(36860700001)(86362001)(82740400003)(82960400001)(81166007)(356005)(8676002)(4326008)(41300700001)(2906002)(5660300002)(8936002)(44832011)(478600001)(316002)(70586007)(70206006)(54906003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:40:51.6167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0973af-b6a4-4162-7a73-08daee594bc3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT105.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7680
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:41:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10316

Changing the homedir of root that way is required by any layer that
takes ro rootfs pieces from here. Making it its own package allows
reuse without having to take some other customizations.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 .../change-root-homedir_0.1.bb                | 15 +++++++++++++
 .../change-root-homedir/files/postinst        | 21 +++++++++++++++++++
 recipes-core/customizations/common.inc        |  5 +++--
 recipes-core/customizations/files/postinst    |  8 -------
 4 files changed, 39 insertions(+), 10 deletions(-)
 create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.=
1.bb
 create mode 100644 recipes-core/change-root-homedir/files/postinst

diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/=
recipes-core/change-root-homedir/change-root-homedir_0.1.bb
new file mode 100644
index 000000000000..79c7e67d0d70
--- /dev/null
+++ b/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021-2023
+#
+# Authors:
+#  Henning Schild <henning.schild@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+DESCRIPTION =3D "Move roots homedir to /home for read-only rootfs"
+
+SRC_URI =3D "file://postinst"
diff --git a/recipes-core/change-root-homedir/files/postinst b/recipes-core=
/change-root-homedir/files/postinst
new file mode 100644
index 000000000000..918c5ab79aa4
--- /dev/null
+++ b/recipes-core/change-root-homedir/files/postinst
@@ -0,0 +1,21 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019-2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -e
+
+# needed for read-only rootfs with writable /home
+if [ ! -L /root ]; then
+	# usermod --move-home can not be used while the target user
+	# has running processes, also we keep a symlink here
+	mv /root /home/
+	ln -s /home/root /root
+fi
diff --git a/recipes-core/customizations/common.inc b/recipes-core/customiz=
ations/common.inc
index 1124ff2d3590..24c862c32e3b 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -22,10 +22,11 @@ SRC_URI =3D " \
 WIRELESS_FIRMWARE_PACKAGE ?=3D ""
 INSTALL_WIRELESS_TOOLS ??=3D "0"
=20
-DEPENDS +=3D "sshd-regen-keys"
+DEPENDS +=3D "sshd-regen-keys change-root-homedir"
=20
 DEBIAN_DEPENDS =3D " \
-    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-ke=
ys \
+    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-ke=
ys, \
+    change-root-homedir \
     ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) =
\
 	if d.getVar('INSTALL_WIRELESS_TOOLS') =3D=3D '1' else ''}"
=20
diff --git a/recipes-core/customizations/files/postinst b/recipes-core/cust=
omizations/files/postinst
index 7a0b00d98680..7e7ea3692325 100644
--- a/recipes-core/customizations/files/postinst
+++ b/recipes-core/customizations/files/postinst
@@ -21,11 +21,3 @@ fi
 HOSTNAME=3Ddemo
 echo "$HOSTNAME" > /etc/hostname
 echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
-
-# needed for read-only rootfs with writable /home
-if [ ! -L /root ]; then
-	# usermod --move-home can not be used while the target user
-	# has running processes, also we keep a symlink here
-	mv /root /home/
-	ln -s /home/root /root
-fi
--=20
2.38.2



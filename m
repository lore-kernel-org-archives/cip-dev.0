Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA889C433F5
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 17:13:14 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web08.667.1643303593617008214
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 09:13:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=up80/lCP;
 spf=pass (domain: siemens.com, ip: 40.107.7.51,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+ijtb8dlSypfHAxeWCH/+NyOmiCg4XQsyFr+bnliW4y4L1Q2s1t6E0wiSMPjGazdTJTjk3pubAc+A0WN65WfRQoZMFeA8Nn5dR62NQinlUf87W3w8EwT5mR9U1oTG216p5eDerLIw3Wb7LCmOrFM+zrf4maocvdnPxi53kBuQfd13rbCh14v6kX3g2jf69MfFMzhfCkFmzVr2s5DKesDt9qwT/eokHstnPj6ZnlDKkVHGBrAIldjViBVcPq9h21ms9h/nhvK0PpBmeYhgqUSjHU4qrvUqJlMLu3unLfyXOyNuDMa07pvbMh8QOZvGZYH/+p81etj9HCbqIRAb75dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZLkCAPrp2WkAK9+9lRwHHzidQTy6cG9THZR9ETBgcc=;
 b=d0D+5Wvae/n+hEazH6NF+EU+/sAZgBB09N4YoTWhzjcAnsaMbO/CTk2DAt3cEr+g+Bdya5tVHNcTzX3LXqkyvr91wPtF3DT5CN2y1I1IGOeZszdoaUiUiL3clxEZZhkwuLHMu0pNaGKyMISSR+Ojl0DTNSsVFnVSJZApj7TZ9HPg375Yz6VTNIhZhpcjX4M5c7eKUh8R5uuqmplZxRphmav5fT6egxNenqrv+2qWNSoRw7ZZHFwx+rq8/Vrjiu2CvFJbMSjstNrnw3bcLnT13YoFZhW/tgGAvKCX/tL6Ed0h3OLCC8Qw0tD/Yzl5UtsskkzPNc1q45kQEP+See8ekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZLkCAPrp2WkAK9+9lRwHHzidQTy6cG9THZR9ETBgcc=;
 b=up80/lCP1gK8lXprahAPUklfbPLM60SpLuxJTbGxeBNa3C2eP2J3jODeRwq89R0EP8D+Cr3o/AFCI6ibdsPPyshXr62ps0DisuEG8CZYvIJz1TJZShz7+4i5EZOKxFrXSlHsmX7FU3ZUvB8gedHuhbj7A9qZS96e7DWZZ8rdIhzMknJmAKS1/1NuNbDcGcb2d0qjHhxZoQT1qw4MgZlJqqNmKJbk38Ks1vu0DNHJWL09oB9tWl0YwAl8x0iH4ZtIhw2hfC/3WUeyvQPxTeOgBokVfthcTO8gWxX1V16HkTWDyNzL6c6kNDJidb7IVe4oTg30V0UaDww6egjzKQFxJw==
Received: from OL1P279CA0033.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::20)
 by AM0PR10MB3684.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 17:13:10 +0000
Received: from HE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::da) by OL1P279CA0033.outlook.office365.com
 (2603:10a6:e10:13::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 17:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT003.mail.protection.outlook.com (10.152.0.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:13:10 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 18:13:09 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.73.11) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 27 Jan 2022 18:13:09 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v3 5/6] customizations: Factor out a common.inc
Date: Thu, 27 Jan 2022 18:12:42 +0100
Message-ID: 
 <7f039c5d636de4d8d8e781dc384956c69e8d7716.1643303563.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643303563.git.jan.kiszka@siemens.com>
References: <cover.1643303563.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e19d1e1-85e0-46e8-4123-08d9e1b84b60
X-MS-TrafficTypeDiagnostic: AM0PR10MB3684:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB3684C4989D796EBEC7C1682895219@AM0PR10MB3684.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jBgQcOnKPC98OqrbkiJd8aAmJKwUoVSrY8tYPrv1hmqSpz0Lc6YlGi6cB6fVYdkkGcGMKEDHumra/ZBQiVpTJGqh4CD/VaCQNACO75DYvzROh3ZRQGjGnPz27VBG1yZ2/pMmtRVRy3PS3xJz7Udwn6ETuXMHYSLkW2uBhpP5IztFpfUR82GHBPPujJ8ZyHWgR2DvbZFT1Y4D2na3X9L2UBMC5U3ybytL8NvnbvIrAec8EQwsugZvsvzO3Q+d74f9IMXummoLR3bQ8IGLzuCADbbXeTeVPXcjjdW5h4ki7De8um1wYW6Cod5lq8zPggkgB+zXMFsUn0lh3gWuLF7lUYojMch8IakkddxUrGyMA5GgU6Bt0OZUokDLQLBKY88uqQPsEzfKz8x8/B5V3BhWuzHCz9HnT2BD+CqJkqt78MfBrbBLg97McuB5dny4LfMxAdJgx5F65ievZZRb08vIq1ES9ml2TGKUvzhgFIpymPQ7ZxQxwakhJNKCQum64+igXq4oFlUHs93Ld+WfA4PdFvHRgnZFu0OQ6UxTdlZd2hCNaWgLQOkAJyFFI4sUMT8V1q0gpMaXRAVrVr/v3lvbmoOuAeQhBenezYbJyvQ0yD7lmjfpdw22xGLRAbhAPKMmcy3tcW4QaIwRq0RfOm8UYWNMBpgSlVRF/I0b7dq+1YTCEG2oht5vMfdpF1DTRPEXlmg0wlnrFo3bVZXdSODcYQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(44832011)(70206006)(5660300002)(40460700003)(70586007)(8936002)(8676002)(508600001)(316002)(6916009)(36756003)(86362001)(4326008)(83380400001)(16526019)(336012)(82960400001)(47076005)(956004)(26005)(186003)(2616005)(36860700001)(356005)(2906002)(81166007)(6666004)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:13:10.3529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8e19d1e1-85e0-46e8-4123-08d9e1b84b60
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3684
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 17:13:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7514

From: Jan Kiszka <jan.kiszka@siemens.com>

This can be re-used by other customization recipes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{customizations.bb =3D> common.inc}         |  4 +--
 recipes-core/customizations/customizations.bb | 27 ++-----------------
 2 files changed, 4 insertions(+), 27 deletions(-)
 copy recipes-core/customizations/{customizations.bb =3D> common.inc} (90%)

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/c=
ustomizations/common.inc
similarity index 90%
copy from recipes-core/customizations/customizations.bb
copy to recipes-core/customizations/common.inc
index d302b4a..d3eb7b8 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,7 +11,7 @@
=20
 inherit dpkg-raw
=20
-DESCRIPTION =3D "CIP Core image demo & customizations"
+FILESPATH_append :=3D ":${FILE_DIRNAME}/files"
=20
 SRC_URI =3D " \
     file://postinst \
diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/c=
ustomizations/customizations.bb
index d302b4a..96e88dd 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,29 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
=20
-inherit dpkg-raw
+require common.inc
=20
 DESCRIPTION =3D "CIP Core image demo & customizations"
-
-SRC_URI =3D " \
-    file://postinst \
-    file://ethernet \
-    file://99-silent-printk.conf"
-
-WIRELESS_FIRMWARE_PACKAGE ?=3D ""
-INSTALL_WIRELESS_TOOLS ??=3D "0"
-
-DEPENDS +=3D "sshd-regen-keys"
-
-DEBIAN_DEPENDS =3D " \
-    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-ke=
ys \
-    ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) =
\
-	if d.getVar('INSTALL_WIRELESS_TOOLS') =3D=3D '1' else ''}"
-
-do_install() {
-	install -v -d ${D}/etc/network/interfaces.d
-	install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
-
-	install -v -d ${D}/etc/sysctl.d
-	install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
-}
--=20
2.31.1



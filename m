Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DDFC43217
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 17:13:01 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.64])
 by mx.groups.io with SMTP id smtpd.web08.658.1643303580152334181
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 09:13:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=smyh6zN1;
 spf=pass (domain: siemens.com, ip: 40.107.5.64,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAD4rPM1YdoPAhdW6AdNrv/vokF+fWpWWYP3Xeg5f4YS7quHLMA2BLvUr30S9XQD80Z9C8u5IzvC4wqB4raGBkLKXvXPTrGJmLeZ0nxaERfEzMNqwAyTDatdrAyWwu4ME05f44iY6zFFJf0LO1dJvx3RDXzhxEjOu/HLkw4dlvc5FeM6r2lkfsDtRb9CUA73Tc+WfSl47EdTQe8opH442u4GEWF2oCB1shw+S3fvempYzV7Kk2LLhiovwXW2KQc5YMRAEzwFlnWRWX5xynbygJb6cr0YzwpuwIFI0aQ9G797lkPPL75fdZFY4qBRAu3DjonIUvrQ5rTTDPPT4NIfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npiVpDzPZTWZGRHxpAle3dWFjj9AsRudTvkprQehOLk=;
 b=NnRJGKnGETTKkmfnOjC1tbj8MsQ2CX7alFLOckMRbmajesZ3opYJaC/rDpedQAzbPgPhJWV5kCqnZotXM6nhzbX5moRPAa583NnUX7MdcehS6gr0cFXP58DBZhkP+LMF4hjM7uVUhrN5368hm72Ql3XFR9zCzKP5MYwDz9cgsNhIaGg5WgEZCNtjtYvDuGmBC1nI6US9Y462gtm6zd7UAr6RDg9lG5WUad66AGOdV00z3brxSMwT06zaeLpXJ7Bw7zYs2aB90JUtUewGm7cgBD8mxwObBac7NSWfhfFvbpOafm6vohx0WYXh575ImmsJYlfQsstF8ZhlBw4WPNPDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npiVpDzPZTWZGRHxpAle3dWFjj9AsRudTvkprQehOLk=;
 b=smyh6zN1Ak8+1/73IORaeBsNU/Ke3vIv/sXQfODV9aBSjEQlaCnS7tJP3bg2BHYnXvEuqGKbWwcjktAD0w5Gz6u2zHfH+ar/Of5sp93ivc4AcJRDuXBKstVeMEm2foBvdVxqPZpf1lAEut/31N3B6QRa+cm5w0ye+ikbdEkQQKnuu1M4JQqI5osID3Bukgwl/nGxOkFlqXIC7xZa/e7jDLHvr7R0HjQ5d0CBYz0QWM3sj1Z3E01/NtRWrtCIxmndkFp4IeXsrSGpkPOTkPbADeaNE+hMy8wmHfpSb9j9vBrtMdjD6nMyrVM7ev4Y4Birv+xQ6plyPeKOfmp6j2ia6g==
Received: from OL1P279CA0048.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::17)
 by VI1PR10MB2670.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 17:12:56 +0000
Received: from HE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::1) by OL1P279CA0048.outlook.office365.com
 (2603:10a6:e10:14::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 17:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT027.mail.protection.outlook.com (10.152.0.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:12:55 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 18:12:55 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.73.11) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 27 Jan 2022 18:12:55 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v3 1/6] Add cip-core-image-kernelci
Date: Thu, 27 Jan 2022 18:12:38 +0100
Message-ID: 
 <ab1a439384d3ada17be6be0d5e02b294b4c2c5aa.1643303563.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643303563.git.jan.kiszka@siemens.com>
References: <cover.1643303563.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94277967-d6a2-4039-df0d-08d9e1b842c5
X-MS-TrafficTypeDiagnostic: VI1PR10MB2670:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB2670D0F2AE25EE2FFB27ACA495219@VI1PR10MB2670.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GRxaFnVmk6JJrwwJ/qUsMWCF+NPdn4hoC+hZ1DPzFxV0X5Q5DNkH2yMA7uqt1KQxwLE7Qvcq9kjaQ4WwqPlxP8er5+0XUVeASbmqyHgsF3vtf/vl3fZomnipA47S3crBqqTulpTcYp9oB6AymgwM1oGeXVIMOSjNpDyXn5Q/PT/9zywUJ7V75iTA1qFdZ/oAEfQlRVK4331Onmje1AE3eCWD9Dty+WSQlWvZl10jwZ+Hx5MzCObgZSLswAaNOjZUJNDIGInkEluWLHcKeRifxlCVzLBNBlwJivjibHxzalgbM5IufrpI1wXhRMv+LaG2F9p6DczSmid0/OYJQspa76422hJk9nOt0c8vCN+TJfRQtK/o1ODBsOhxKTJqbzw9Rdd24sSM1bjgGUBkVf5SY8KODj3IeIzcp3gr1vdrxS1u0m+CT6qaft9Iv9/5ciNm/dA7/plrUwDk0Zh8DCPeW43y3SD0t8v9B4eFXsMVXCskz7xOBr3v1wrzVrDoW5HojmhWksF0EzjssmqCd9k2PpFNGG8gwCYZFBibHh9vFbUm8D7fxlmOK/n3V5z35IUf8eYNrrflHzcTA5RMUx2g1Qwq0aXUBVvhcbR5TReWOL3TjIqGKgkK0UaxMCMO7aCjHLdqg/zMWDYJ/DXsOxNomZSADdvoZ1zJ07GHJFaEb12CsRD4Um5OaFcXSZTCOTaiegTh/DfeTc+chv/RvXbkm4Z4LmKooU9ULsi5x+EeX2YQuHLlkpnDFzXu5Gn4XrYGyuOcAnnqqzuloiVN28OMJtknwgreTUNTsNAE8eAHzsM=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(70206006)(186003)(8936002)(5660300002)(6666004)(70586007)(81166007)(16526019)(6916009)(86362001)(82310400004)(2616005)(316002)(82960400001)(44832011)(26005)(4326008)(356005)(47076005)(40460700003)(8676002)(508600001)(36756003)(336012)(2906002)(83380400001)(36860700001)(956004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:12:55.9351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 94277967-d6a2-4039-df0d-08d9e1b842c5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2670
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 17:13:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7512

From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

This image is currently used by KernelCI production for testing purpose.
The purpose of this image is that KernelCI need to be able to autologin
without password and to detect the login shell using special characters.
Currently added are the default settings used by KernelCI images.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/kernelci.yml                          | 16 +++++++++
 .../images/cip-core-image-kernelci.bb         | 16 +++++++++
 .../files/99-silent-printk.conf               |  1 +
 .../kernelci-customizations/files/ethernet    | 23 +++++++++++++
 .../kernelci-customizations/files/postinst    | 34 +++++++++++++++++++
 .../kernelci-customizations.bb                | 34 +++++++++++++++++++
 6 files changed, 124 insertions(+)
 create mode 100644 kas/opt/kernelci.yml
 create mode 100644 recipes-core/images/cip-core-image-kernelci.bb
 create mode 100644 recipes-core/kernelci-customizations/files/99-silent-pr=
intk.conf
 create mode 100644 recipes-core/kernelci-customizations/files/ethernet
 create mode 100644 recipes-core/kernelci-customizations/files/postinst
 create mode 100644 recipes-core/kernelci-customizations/kernelci-customiza=
tions.bb

diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
new file mode 100644
index 0000000..9c67864
--- /dev/null
+++ b/kas/opt/kernelci.yml
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2020
+# Copyright (c) Cybertrust Japan Co., Ltd., 2021
+#
+# Authors:
+#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
+#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
+#
+# SPDX-License-Identifier: MIT
+#
+header:
+  version: 10
+
+target: cip-core-image-kernelci
diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-core/=
images/cip-core-image-kernelci.bb
new file mode 100644
index 0000000..479c14c
--- /dev/null
+++ b/recipes-core/images/cip-core-image-kernelci.bb
@@ -0,0 +1,16 @@
+#
+# A reference image for KernelCI
+#
+# Copyright (c) Cybertrust Japan Co., Ltd., 2021
+#
+# Authors:
+#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit image
+
+DESCRIPTION =3D "CIP Core image for KernelCI"
+
+IMAGE_INSTALL +=3D "kernelci-customizations"
diff --git a/recipes-core/kernelci-customizations/files/99-silent-printk.co=
nf b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
new file mode 100644
index 0000000..ad24d3a
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
@@ -0,0 +1 @@
+kernel.printk =3D 3 4 1 3
diff --git a/recipes-core/kernelci-customizations/files/ethernet b/recipes-=
core/kernelci-customizations/files/ethernet
new file mode 100644
index 0000000..fa47d1a
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/ethernet
@@ -0,0 +1,23 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+allow-hotplug eth0
+allow-hotplug enp0s2
+allow-hotplug enp2s0
+
+# used on BBB
+iface eth0 inet dhcp
+
+# used on qemu-amd64
+iface enp0s2 inet dhcp
+
+# used on simatic-ipc227e
+iface enp2s0 inet dhcp
diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-=
core/kernelci-customizations/files/postinst
new file mode 100644
index 0000000..7ae30e8
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/postinst
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+# Copyright (c) Cybertrust Japan Co., Ltd., 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+echo "CIP Core Demo & Test Image" > /etc/issue
+
+# permit root login without password
+echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
+echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
+passwd root -d
+
+# serial getty service for autologin
+mkdir -p /etc/systemd/system/serial-getty@.service.d/
+echo "[Service]" > /etc/systemd/system/serial-getty@.service.d/override.co=
nf
+echo "ExecStart=3D" >> /etc/systemd/system/serial-getty@.service.d/overrid=
e.conf
+echo "ExecStart=3D-/sbin/agetty --autologin root --keep-baud 115200,38400,=
9600 %I $TERM" >> /etc/systemd/system/serial-getty@.service.d/override.conf
+
+# set the profile for KernelCI
+echo "PS1=3D'\$(pwd) # '" > /root/.profile
+echo "cd /" >> /root/.profile
+
+HOSTNAME=3Ddemo
+echo "$HOSTNAME" > /etc/hostname
+echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.b=
b b/recipes-core/kernelci-customizations/kernelci-customizations.bb
new file mode 100644
index 0000000..dca0891
--- /dev/null
+++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
@@ -0,0 +1,34 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+# Copyright (c) Cybertrust Japan Co., Ltd., 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+DESCRIPTION =3D "CIP Core image demo & customizations"
+
+SRC_URI =3D " \
+    file://postinst \
+    file://ethernet \
+    file://99-silent-printk.conf"
+
+DEPENDS +=3D "sshd-regen-keys"
+
+DEBIAN_DEPENDS =3D " \
+    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-ke=
ys"
+
+do_install() {
+  install -v -d ${D}/etc/network/interfaces.d
+  install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
+
+  install -v -d ${D}/etc/sysctl.d
+  install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
+}
--=20
2.31.1



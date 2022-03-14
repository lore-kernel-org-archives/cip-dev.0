Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D31C433EF
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 06:09:37 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.45])
 by mx.groups.io with SMTP id smtpd.web09.23594.1647238176082187798
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Mar 2022 23:09:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=Tu/uyJj1;
 spf=pass (domain: siemens.com, ip: 40.107.15.45,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3VZ9HmC9p4SxJtRgOWioYaboySLRXdtU31YVBfSneE8GcRFiOimF79Ze8WQAjamGUEa+e6C6J3yosxtOXj4weXGi7E3AkhkiHl2EhYuq5IOyAUfs7zEhh1iCbV9LTv9EACJb1/sfbfU15QoORH6DiFhyf7IXNcXSIdA2TbiZrAWAQQbA9HWNePpo7HNSpX98Al4vmfWa3mZkHj3Ywtkc3KQeEJEVA2toKiw7cHLUqHIw8AjyOqRMyu8W+bkcrxCqmnCcQPewlpnnwrKzysPH4hBWWbnD1CLnCGsXje3TXtvjf7x6E9sNJnC2nO3LsPEtL4dW1J30W2pAjJE+ZQ7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxD2TKVyygvx9oL9wQk/wCqCP087JnHw4Fyn3ms4/ls=;
 b=kJdX0Le3DD/7GYlgEpQzi3O+xR5syuLDxkRKq3TytY4teAm8hEueupCiX/PM/fg2yalDMATAjZsbjddEEuE1zJ2KPyumJ4EqNycQjvCsTXTedqA68z8rj80buVfEl1c6U/IOAo6nuTRzkrpvdeTgEmFMA6NV5EAZj+Oj7BPLysM6fZUZcJ0Hlr7ypaPzRnKYy4XX/KoqFd1zhnnMbULAkwhJUagpKd2tG9KrqOcXU2wuo8bhHYWPz81iU1QvbofWY835o+z0t++9+oTNwYwjGDF+WL2YQNqRrkiWuwyHaVjW6r8Hp9TmISd40l1IeJf5q20A9LwQPQL6I6ELqXIGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxD2TKVyygvx9oL9wQk/wCqCP087JnHw4Fyn3ms4/ls=;
 b=Tu/uyJj1bUQ/Azr4MbC38HxecoQocxORqwkSQi4LAuhfzIN80SdpEaxUkCrikA3ZZEqIN9UYaaX3vIuJV6S6d1MIrkcQ1QrMlmV/lIKXVUrk4Y/v1APWRw8ljdzEBGSEyYRpHL3wwg95JpVs6D5ub84fWUNkmtMavUq0cgsr5ayGF3ADlqTeURx2snNc2ZZ8ykA9XkZAZWWOhQfPPB+Jy4iAEoUxe/fdbbrBeyom+79FSVVzSrv0sZDFh1lOojMSRYfmMptlWxXzp8hWYtP0+/0sLQ4fezS++aaXyLEYdxE2l9irEfEw/vwXejauw4Vzs5H9qrShKiV3JodBFGiROA==
Received: from SV0P279CA0047.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::16)
 by AM4PR1001MB1250.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 06:09:33 +0000
Received: from HE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::e6) by SV0P279CA0047.outlook.office365.com
 (2603:10a6:f10:13::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Mon, 14 Mar 2022 06:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT018.mail.protection.outlook.com (10.152.0.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 06:09:33 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:32 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.72.30) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:31 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 4/6] Add python3-shtab package
Date: Mon, 14 Mar 2022 07:09:19 +0100
Message-ID: 
 <e2eca07cdf05c776605a09b30c792f0d8ec1c0f8.1647238161.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647238161.git.jan.kiszka@siemens.com>
References: <cover.1647238161.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.72.30]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87f3747f-9602-4b14-16e2-08da0581356c
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1250:EE_
X-Microsoft-Antispam-PRVS: 
	<AM4PR1001MB1250AE9C59D087D1F10E41E2950F9@AM4PR1001MB1250.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gomvKRtEsPoRNitm52PHWcpnY5uWpHQvNms9IABM70OkYakijHSifb3zkTNb5fAHjjI8sHUnMwqEYmUF0NICs+Td5Q5PqJ96Mk9/LnjZ1870I+mVNNDRpYA8EpaypA+ZoJt9fqENqqvJXCpmudD25mt5xlTRhbGqO4PEhqrh9U2QcDhBmYqczrNCoqpQYPlofm8GexiBKCl6F9ngp6tKDqzjCIN0RTbWV6Y83bS3K2NWuQ833CA8IB2Mcufdzhb6VwTwMPqpykc/FcoZN//L3FbU+jMTBJoqg2835xxHUZSgSn8jdlJnOOLj4A8njDGG4U7tQULdCpiTKz/F8ZI6g6wMqbPiTOEVWKHDL7OUH7e41nxSoVrXn5kj0L9CW7mkaZLf24CgkS9be/Jbvi7uAU9uIho5RT6vk466P12uA93V4gnTNGrNZH7zoB46Nw42hP9u+CO8O6w16DM3KT7Xi556b0QqxzGjhC9kCEZYPzW15lBz45TMZRi7uTwlVo4pkYijaf08DKPtPd+r6yFTNqv1+x01CU2IpXTESL6rwogM8xJ7jvSqhr3lo5gzd4YNXDZNJc5+PjMksK2/jrmkNEtXz85BLtaOJ3WTViAUOmjV4wCSTE+bpOMXB4pFfL36PaCG9buvjppdSIeQm7VOl/rnro183a7Ez+y1lbBOx4ZA/oueiyVq08izNZtrj2/Ou2U2HT966KqJN/Z70j4Hz6/7qc9XlBa+3kMEZHtZUoO1RyBqBIaaq8YotOFhnG63IrGqA9O8XNdm7EKcJvvmTG/7my2lSSvUNP7QpmWAvA8=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(86362001)(316002)(82960400001)(356005)(40460700003)(81166007)(6916009)(966005)(5660300002)(2906002)(36756003)(44832011)(8936002)(8676002)(4326008)(70586007)(70206006)(83380400001)(2616005)(16526019)(107886003)(36860700001)(956004)(47076005)(508600001)(6666004)(336012)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 06:09:33.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 87f3747f-9602-4b14-16e2-08da0581356c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1250
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 06:09:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7707

From: Jan Kiszka <jan.kiszka@siemens.com>

Will be needed for EFI Boot Guard 0.10.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-python/shtab/files/rules            | 21 +++++++++++++
 recipes-python/shtab/python3-shtab_1.4.2.bb | 35 +++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100755 recipes-python/shtab/files/rules
 create mode 100644 recipes-python/shtab/python3-shtab_1.4.2.bb

diff --git a/recipes-python/shtab/files/rules b/recipes-python/shtab/files/=
rules
new file mode 100755
index 0000000..43ba686
--- /dev/null
+++ b/recipes-python/shtab/files/rules
@@ -0,0 +1,21 @@
+#!/usr/bin/make -f
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Felix Moessbauer <felix.moessbauer@siemens.com>
+#
+# This file is subject to the terms and conditions of the MIT License.
+# See COPYING.MIT file in the top-level directory.
+#
+
+export DH_VERBOSE=3D1
+export PYBUILD_VERBOSE=3D1
+export PYBUILD_NAME=3Dpasta
+
+ifneq ($(filter nocheck,$(DEB_BUILD_PROFILES)),)
+export PYBUILD_DISABLE=3Dtest
+endif
+
+%:
+	dh $@ --with python3 --buildsystem=3Dpybuild
diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/s=
htab/python3-shtab_1.4.2.bb
new file mode 100644
index 0000000..d5bc465
--- /dev/null
+++ b/recipes-python/shtab/python3-shtab_1.4.2.bb
@@ -0,0 +1,35 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+SRC_URI =3D " \
+    https://github.com/iterative/shtab/archive/refs/tags/v1.4.2.tar.gz;dow=
nloadfilename=3D${PN}-${PV}.tar.gz \
+    file://rules \
+    "
+SRC_URI[sha256sum] =3D "5e6ef745c223ef1a01a2db491a8ec5c02c8291067328b17695=
c9a44f5b7d6fe6"
+
+S =3D "${WORKDIR}/shtab-${PV}"
+
+DEBIAN_BUILD_DEPENDS =3D " \
+    dh-python, \
+    python3-all, \
+    python3-setuptools, \
+    python3-setuptools-scm, \
+    python3-toml, \
+    "
+
+DEB_BUILD_PROFILES =3D "nocheck"
+
+do_prepare_build[cleandirs] +=3D "${S}/debian"
+do_prepare_build() {
+    deb_debianize
+}
--=20
2.34.1



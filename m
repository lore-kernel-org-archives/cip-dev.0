Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0D3C433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 10:29:45 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.84])
 by mx.groups.io with SMTP id smtpd.web12.24674.1647253783394841683
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Mar 2022 03:29:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zwtU/t5j;
 spf=pass (domain: siemens.com, ip: 40.107.20.84,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In4PiUgd64FqCQq19RGKfuyycE34xTNA2Hb0i7dvhoanIi+rgz5Q0ej2YUtzZnd3+REBJb5EBPRm+/KE7JYowZjQRHlV+ovbFapI5r71qaWieKxCrg6W4dnfbcaWTzVNVPg1K21Z0p7Kkzazxee4SsSyPWDq0S5AbkwhCzmhqzxaR6xzx0/0vZM1yET9oNahpyqvz+tZqiaSuK8yHpjF6hBmELauA3KdHcmFT0jaQEEqKenlUge4UPPJ5ddNAZYTyL0UuPa0LXqXeFvQ1NnQz+oEw97R0jv8XGuXzPt38Fd7KU2PR0+hwCWydoUd+6wGAHGuCjkgdHP+6+mD8FHHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BKfsQvS1tymNWAygpuS7qGkBthnBTBgvD2L3x1OqnM=;
 b=YC6CNazXrsJZSVOwnigy0h+s1Ws0Xjh2NPQaCHYPaa8GJfz16FbvmepAPHooYhlGBiyzlGY/r0PHsxGu/52uJaCvG6v9mai13kb3jUlgxh9bDmh3TzNMCajX4VaVkN7xuFwC2wMI6VZQFCFJg4i+CyRHfxq2cHm6WBsqy2An3Pp4DLOYM0zaLyB9/wAR6EWO08fgLVVvTsPrf+VP+PWgOn2nYouwh+jp9Gb5qM2jUduuUPpUD5PKiYaZY38Mlmd4hU0lhWFMd7Pr9JXYH/VqjQn+mCDcTGiyfHGIsmJbJuLjHpThZAufZXtL+joE3y0sRJeDLbHrWa+1fz2njMF6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BKfsQvS1tymNWAygpuS7qGkBthnBTBgvD2L3x1OqnM=;
 b=zwtU/t5jgMMannHSdAH74tB2aLeVgjS+bGT4EoiNLwFPPIYHe0EFwyEqoN7CZQaEYvyctQX6JbvXKSZ7401Yypleyv41+T58+aHTGF4lynkCBktC4AHkHrjGWpkkzb8w/vhxnONXHXwyDeUbKAbdBB5EYgxi7Yei9ehx764KxUvJbPGyOP5yg+IVMXYs8F6JvCmSABi5H4XHLKA8v8bUUt2GJdtObjsEYSdS99JnIPbFUHpOVXDYhVDw0T1GPfo16DilGiSClHniYkqmjiEuahCY/Yi5rz6dH90jTeFlOe/AOYEIEbAWCQU8eRM0K5XrayQlzdQ7O93H52KGCSd/mg==
Received: from OL1P279CA0007.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::12)
 by AM6PR10MB2680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 10:29:40 +0000
Received: from HE1EUR01FT099.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::ad) by OL1P279CA0007.outlook.office365.com
 (2603:10a6:e10:12::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Mon, 14 Mar 2022 10:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT099.mail.protection.outlook.com (10.152.1.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.10 via Frontend Transport; Mon, 14 Mar 2022 10:29:39 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 11:29:39 +0100
Received: from [167.87.72.30] (167.87.72.30) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Mar
 2022 11:29:38 +0100
Message-ID: <c853463d-16aa-e70f-bdee-3df2c5bd9044@siemens.com>
Date: Mon, 14 Mar 2022 11:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [isar-cip-core][PATCH v2 4/6] Add python3-shtab package
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>, Michael Adler
	<michael.adler@siemens.com>
References: <cover.1647238161.git.jan.kiszka@siemens.com>
 <e2eca07cdf05c776605a09b30c792f0d8ec1c0f8.1647238161.git.jan.kiszka@siemens.com>
In-Reply-To: 
 <e2eca07cdf05c776605a09b30c792f0d8ec1c0f8.1647238161.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.30]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0005be1-8e02-4e01-22d9-08da05a58bb8
X-MS-TrafficTypeDiagnostic: AM6PR10MB2680:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB2680574C645732263E2002C9950F9@AM6PR10MB2680.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2WjoBHhN9Zax9YwD36TGSvhVpnJ0VcSyVedwb4CcIKZ0nDotdqCNy3qCXpU02/jXnjVDoRDCvbAihcDIgljWe8ucHJTJ5mhkAbqwtqbdGQ1eeBc/H7jb5A3NWJVMDVjLRn2g5tgMpDPYsZpxNm5ip2m0IjS+2NlGCpgcyNvO7f68vOk7eVYfHw11OyMw633bb4rSrsJecQ/z71FuYXZvWr1qO536pBM7bQyTTM/bpeVMac65dN6cReJScdIEaqga0mj/TiaKl+xudR3+fFKOEnndXuJdsn8fFNPR5m/twzIyc6yk7pwYWGq1J25CCgGlJds3fx2Aea/AqGBo7GWOda1Z++ndFdJnFdplvL9PBbHbvYgqHX6UsDwfPGY+4CByl6mH9lmPp0/H6Ny+sQc0td1/vahbMLVMw70ieb7VFacO7hvx2EutIc7c4IInHmwbEuTNv0ZYr5EXJFbRqhtcNhgVib2OOTjs3JjAoIiGMnFZhbXubQS8wQRMUwIJme03sffTqYFkEJpZg1+eP4Iyuynm8eG26wgur9PDRohEbp0V8s5p3QILYpP38INfzkrzeeRGdg/7xEnL9fKJfAQVg0WmyKOBMywqCTBNDT/3v/brBifdt8pZE8sdagw4KBXEqjPwHJO1Bo/Qm6rMjvYAymYkcVEonr+k/7JB3Jds6Jq811v1uX/kdnFo1vQZwGNVBbgdjwrjrpvNLLvw8shys44XOeYQkn84dk5mt9iDQUwpBNT527ozVNowvooS9vYeAYpCf3XILqVngH1QJTt6LDRM7VMb0ec24VQWf72ADAumM245Jgl+YTwDkg8NpSVS
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(966005)(508600001)(31696002)(86362001)(336012)(36860700001)(956004)(7636003)(107886003)(356005)(7596003)(26005)(16526019)(2616005)(82310400004)(83380400001)(47076005)(16576012)(8936002)(82960400001)(316002)(6706004)(6916009)(5660300002)(70206006)(31686004)(70586007)(44832011)(4326008)(8676002)(2906002)(54906003)(36756003)(40460700003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 10:29:39.7408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e0005be1-8e02-4e01-22d9-08da05a58bb8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT099.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 10:29:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7720

From: Jan Kiszka <jan.kiszka@siemens.com>

Will be needed for EFI Boot Guard 0.10.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - make compatible with buster

 ...001-Lower-requirements-on-setuptools.patch | 28 +++++++++++++++
 recipes-python/shtab/files/rules              | 21 +++++++++++
 recipes-python/shtab/python3-shtab_1.4.2.bb   | 35 +++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
 create mode 100755 recipes-python/shtab/files/rules
 create mode 100644 recipes-python/shtab/python3-shtab_1.4.2.bb

diff --git a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
new file mode 100644
index 0000000..dccc2dd
--- /dev/null
+++ b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
@@ -0,0 +1,28 @@
+From d347695c4b173c94c4d8a678a67947de3ee5f186 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Mon, 14 Mar 2022 08:17:00 +0100
+Subject: [PATCH] Lower requirements on setuptools
+
+Allows to build against Debian buster.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ setup.cfg | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/setup.cfg b/setup.cfg
+index 55eecd4..186aad6 100644
+--- a/setup.cfg
++++ b/setup.cfg
+@@ -66,7 +66,7 @@ classifiers=
+     Topic :: Terminals
+     Topic :: Utilities
+ [options]
+-setup_requires=setuptools>=42; setuptools_scm[toml]>=3.4
++setup_requires=setuptools>=40; setuptools_scm>=3.2
+ install_requires=
+     argparse; python_version < "2.7" or ("3.0" <= python_version and python_version < "3.2")
+ python_requires= >=2.7, !=3.0.*, !=3.1.*
+-- 
+2.34.1
+
diff --git a/recipes-python/shtab/files/rules b/recipes-python/shtab/files/rules
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
+export DH_VERBOSE=1
+export PYBUILD_VERBOSE=1
+export PYBUILD_NAME=pasta
+
+ifneq ($(filter nocheck,$(DEB_BUILD_PROFILES)),)
+export PYBUILD_DISABLE=test
+endif
+
+%:
+	dh $@ --with python3 --buildsystem=pybuild
diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/shtab/python3-shtab_1.4.2.bb
new file mode 100644
index 0000000..eb5feda
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
+SRC_URI = " \
+    https://github.com/iterative/shtab/archive/refs/tags/v1.4.2.tar.gz;downloadfilename=${PN}-${PV}.tar.gz \
+    file://0001-Lower-requirements-on-setuptools.patch \
+    file://rules \
+    "
+SRC_URI[sha256sum] = "5e6ef745c223ef1a01a2db491a8ec5c02c8291067328b17695c9a44f5b7d6fe6"
+
+S = "${WORKDIR}/shtab-${PV}"
+
+DEBIAN_BUILD_DEPENDS = " \
+    dh-python, \
+    python3-all, \
+    python3-setuptools, \
+    python3-setuptools-scm, \
+    "
+
+DEB_BUILD_PROFILES = "nocheck"
+
+do_prepare_build[cleandirs] += "${S}/debian"
+do_prepare_build() {
+    deb_debianize
+}
-- 
2.34.1


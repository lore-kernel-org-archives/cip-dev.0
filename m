Return-Path: <hirotaka.motai@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9B8C83F34
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 10:10:42 +0000 (UTC)
Received: from smtp.priv.miraclelinux.com (smtp.priv.miraclelinux.com [202.210.215.66])
 by mx.groups.io with SMTP id smtpd.web11.17734.1752833431778523940
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 03:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: miraclelinux.com, ip: 202.210.215.66, mailfrom: hirotaka.motai@miraclelinux.com)
Received: from 120i.miraclelinux.com (21A0120i.priv.miraclelinux.com [10.2.0.233])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 385441400A3;
	Fri, 18 Jul 2025 19:10:30 +0900 (JST)
From: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
Subject: [cip-dev][isar-cip-core][PATCH 1/5] zynqmp-zcu102: Add board support
Date: Fri, 18 Jul 2025 19:09:04 +0900
Message-ID: <20250718100926.3151777-2-hirotaka.motai@miraclelinux.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
References: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 10:10:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19560

Signed-off-by: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
---
 conf/machine/zynqmp-zcu102.conf | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 conf/machine/zynqmp-zcu102.conf

diff --git a/conf/machine/zynqmp-zcu102.conf b/conf/machine/zynqmp-zcu102=
.conf
new file mode 100644
index 000000000000..4aa1b73ecc5b
--- /dev/null
+++ b/conf/machine/zynqmp-zcu102.conf
@@ -0,0 +1,8 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Cybertrust Japan Co., Ltd. 2025
+#
+# SPDX-License-Identifier: MIT
+#
+DISTRO_ARCH =3D "arm64"
--=20
2.47.2



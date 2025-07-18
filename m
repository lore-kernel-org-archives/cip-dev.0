Return-Path: <hirotaka.motai@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB9CC83F3E
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 10:10:42 +0000 (UTC)
Received: from smtp.priv.miraclelinux.com (smtp.priv.miraclelinux.com [202.210.215.66])
 by mx.groups.io with SMTP id smtpd.web11.17736.1752833431794755298
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 03:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: miraclelinux.com, ip: 202.210.215.66, mailfrom: hirotaka.motai@miraclelinux.com)
Received: from 120i.miraclelinux.com (21A0120i.priv.miraclelinux.com [10.2.0.233])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 4BB731400F6;
	Fri, 18 Jul 2025 19:10:30 +0900 (JST)
From: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
Subject: [cip-dev][isar-cip-core][PATCH 2/5] zynqmp-zcu102: add setting for kernel image and dtb
Date: Fri, 18 Jul 2025 19:09:05 +0900
Message-ID: <20250718100926.3151777-3-hirotaka.motai@miraclelinux.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
References: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 10:10:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19561

Signed-off-by: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
---
 conf/machine/zynqmp-zcu102.conf | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/conf/machine/zynqmp-zcu102.conf b/conf/machine/zynqmp-zcu102=
.conf
index 4aa1b73ecc5b..b1df5f20bb92 100644
--- a/conf/machine/zynqmp-zcu102.conf
+++ b/conf/machine/zynqmp-zcu102.conf
@@ -5,4 +5,16 @@
 #
 # SPDX-License-Identifier: MIT
 #
 DISTRO_ARCH =3D "arm64"
+
+# Setting for kernel and boot
+USE_CIP_KERNEL_CONFIG =3D "1"
+KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm6=
4/ctj_zynqmp_defconfig"
+KERNEL_IMAGE=3D"Image"
+DTB_FILES =3D " \
+  zynqmp-zcu102-rev1.0.dtb \
+  zynqmp-zcu102-rev1.1.dtb \
+  zynqmp-zcu102-revA.dtb \
+  zynqmp-zcu102-revB.dtb \
+"
+
--=20
2.47.2



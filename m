Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61924CE7AA9
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 03:25:32 +0000 (UTC)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
 by mx.groups.io with SMTP id smtpd.web11.27084.1725593018277148098
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Sep 2024 20:23:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qq.com header.s=s201512 header.b=yaQpdM/7;
 spf=pass (domain: qq.com, ip: 162.62.58.211, mailfrom: developerdong@qq.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725593006; bh=4R3+z+rigbZuhwDsyQnw6P6j5lhUi/8cov1l5vVpAXc=;
	h=From:To:Cc:Subject:Date;
	b=yaQpdM/7j5Ol2v7CaQLCJQxQ8z1MevfOxs2dUnz6WCXfZUGo729lr048DAbA9wheM
	 eah61CJj2iIx60NpopdWyw2crjFXWu3tsXNtFqttVOX/MY8YALXXg8rgmeXvRnGW9O
	 EAGlBqsuzyZ0PVIVEcVcHZHixPY/gBZNk5HLnhKU=
Received: from md3knb8c.ad001.siemens.net ([220.243.155.14])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 5D81A869; Fri, 06 Sep 2024 11:23:24 +0800
X-QQ-mid: xmsmtpt1725593004tex79eoy6
Message-ID: <tencent_EE69D05C78693B4A0913E07D06A7CF6A2609@qq.com>
X-QQ-XMAILINFO: OLnGMPzD2sDV1Dv+tKOdcpmtzZsH5/JlRHFH0M9RJHqYkFw77+3PxW3+lbwY0t
	 uvRdUl0ZeKI5EmxWUTJTiAEJspWwdGOagLkhyuXTLVuxqiwopSoMqlLD89B4fR5z38e/zWckoc1M
	 6uI3DdfnQZ+0CstYjZEiZABfs8AZ/AK77r5AjEOpr6Ho2SbZ1XbE3rKB+rWvWFWVk9sO20X5dlKH
	 4nlvr5im87oCck6butubEmJ40GhXG1d/FzOmBS1m5yFcYFMgZaaU2P2x/bEwzvpsbdhSodY5cDBj
	 chgBsY2IdKYVJ8rx1sHJpPu5KUwz044puuX2t4+zqekrY2kYNLoN+ihhl6YSbOy/wG/+Ti2aPOSf
	 MUAz9kurbp9TtezyuAAXXTjjFs9pEVgRPnK/539AE3SVLQ30cIAOaLcbT7vnWPftibo6bpwaqNPI
	 mN34HyOkWEZFUV1Fv/bw1Q+2U3Wq6QAXUKwN/9Hz2NX8RiL5EDoGH+M6LQ1PRTP9iTWlaNEzZQ65
	 iEdiWHt3+a8o3uyTyGcLHjCvEHpwcP8Hug+WNy7So4syNgKp/UNv9Uv8j9D2Y0zmf8kf68fzsFbZ
	 DtKV9bLwBmlz3wUMPxLAkCZPBxVGz5y2c8AokDn5o5uxMLYh1m6O4iy/do9JSOPeQL85HO85k5vF
	 yp7QnwGiOua5NYkKoP0/1fai6EY2P7JPPzzdHiQNwOEynyEA4d2tsW3mzg5kWVCk+jowQk5UAjML
	 L4orYeNb0WjVlPBta6IHd2GQhA9zEhGVA1J0L/T7tPxf2xMqcb6us+jMxqDbmseL1PXOtZGjH+MI
	 B4vOOUZ/7tbnPX+efSqdEN6yVfMPyqFoAoL+iAg5zFnQ/uwCGgg5jBYyh+ss6PAeU7T2yL7OtM6Z
	 ZHWuMLTf8tHLH72y6g/LfNLnLOeITYXCXjbt3i3D6Q83qcHaNMrhFykACuhcQB63Pn2s9apsgW
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: developerdong@qq.com
To: cip-dev@lists.cip-project.org
Cc: Zhibin Dong <zhibin.dong@siemens.com>
Subject: [isar-cip-core][PATCH] refactor(squashfs): prompt for dropping acl
Date: Fri,  6 Sep 2024 11:22:27 +0800
X-OQ-MSGID: <20240906032227.23515-1-developerdong@qq.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Sep 2024 03:25:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16854

From: Zhibin Dong <zhibin.dong@siemens.com>

Because squashfs does not support ACL, a prompt is needed when the
squashed path contains ACL.

Signed-off-by: Zhibin Dong <zhibin.dong@siemens.com>
---
 classes/squashfs.bbclass | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index b39be0c..fc4c5d7 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -1,10 +1,11 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2023
+# Copyright (c) Siemens AG, 2021-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Zhibin Dong <zhibin.dong@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
@@ -20,7 +21,7 @@ def get_free_mem():
         pass
     return 4*1024*1024*1024  # 4G
 
-IMAGER_INSTALL:squashfs += "squashfs-tools"
+IMAGER_INSTALL:squashfs += "squashfs-tools acl"
 
 SQUASHFS_EXCLUDE_DIRS ?= ""
 SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
@@ -45,6 +46,23 @@ python __anonymous() {
 IMAGE_CMD:squashfs[depends] = "${PN}:do_transform_template"
 IMAGE_CMD:squashfs[vardepsexclude] += "SQUASHFS_CREATION_LIMITS"
 IMAGE_CMD:squashfs() {
+    acl_paths=$(${SUDO_CHROOT} /usr/bin/getfacl -R -s -p '${SQUASHFS_CONTENT}' | grep '^# file:' | awk '{print $3}' | sed 's|${SQUASHFS_CONTENT}/||')
+    include_acl_paths=""
+    for path in ${acl_paths}; do
+        exclude=false
+        for dir in ${SQUASHFS_EXCLUDE_DIRS}; do
+            if [ "${path#${dir}/}" != "${path}" ]; then
+                exclude=true
+                break
+            fi
+        done
+        if [ "${exclude}" = false ]; then
+            include_acl_paths="${include_acl_paths} ${path}"
+        fi
+    done
+    if [ -n "${include_acl_paths}" ]; then
+        bbwarn "The ACL of following paths under ${SQUASHFS_CONTENT} will be ignored by mksquashfs: ${include_acl_paths}"
+    fi
     ${SUDO_CHROOT} /bin/mksquashfs \
         '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
         -noappend ${SQUASHFS_CREATION_LIMITS} ${SQUASHFS_CREATION_ARGS}
-- 
2.39.2



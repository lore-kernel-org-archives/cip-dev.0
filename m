Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2B2C25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 11:46:31 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.9352.1715759631905502802
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 May 2024 00:53:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm1 header.b=gMHWnHiY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1324425-202405150753488c67da285d5167a4c0-otej_g@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202405150753488c67da285d5167a4c0
        for <cip-dev@lists.cip-project.org>;
        Wed, 15 May 2024 09:53:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Klr1pKy1a2TDm0oNVPmZB9TzQXwWy1IZ/pALrCF0gUU=;
 b=gMHWnHiYi9od8V8WEQ7GZbgYoTpoM7bnulpuhY6P7m3aAVh5zb5VH0F5zDl5/0/uacvNyU
 xCSoFTPU8gs89902ho2SQyS4L9m5tHoEoFm9qPqE+iEbc687yQhFuDdO4tLG9oOLZU4SvU+p
 u7Jx8p5LlGIHtNraCm+w6+qKROgoE=;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [PATCH][isar-cip-core] kas/opt/expand-on-first-boot.yml: add an optional expand-on-first-boot
Date: Wed, 15 May 2024 13:25:48 +0530
Message-Id: <20240515075548.852777-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 May 2024 11:46:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15897

From: Srinuvasan A <srinuvasan.a@siemens.com>

Add expand-on-first-boot package as an optional file,
this systemd service expands the last partition on a the
boot medium to the full size of that medium and then deactivates itself.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 kas/opt/expand-on-first-boot.yml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 kas/opt/expand-on-first-boot.yml

diff --git a/kas/opt/expand-on-first-boot.yml b/kas/opt/expand-on-first-boot.yml
new file mode 100644
index 0000000..03d666b
--- /dev/null
+++ b/kas/opt/expand-on-first-boot.yml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Srinuvasan Arjunan <srinuvasan.a@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  package-expand-on-first-boot: |
+    IMAGE_INSTALL:append = " expand-on-first-boot"
-- 
2.34.1



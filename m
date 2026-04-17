Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660ADEA71B1
	for <webhook@archiver.kernel.org>; Sun, 19 Apr 2026 23:59:31 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42970.1776426450947161940
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Apr 2026 04:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gouravsingh@siemens.com header.s=fm2 header.b=gchFkqcm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1333022-2026041711372593f2c8d335000207ea-b8nihr@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026041711372593f2c8d335000207ea
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Apr 2026 13:37:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=gouravsingh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vzk3SNWLfymF0F9rJyklhM5AovqUOSLM1XlABXrcYTY=;
 b=gchFkqcmui+YWbSz7MFCKufAJPDWxyKJ3QYJmadrGed3S1pP3pywx91V7SJLpMr8092wQO
 fylWUcc0k+KCQF8SXYUGdwqZo2EaWJuPw3prOx8hDEMQUnS1oDduRZqMbMeZM6PtCtnK56Xg
 qw330cc5mS9mvcrjvKzu9S6naaAbu6Z0WWgJ+W4kHmZxKN5dL9wGBM43PHQgWnlZKkKWpxqJ
 1bceEhdaaSWJ7H2L6Y//p+qSO2pgXPETjhvCSW+zRHqlvYUEzfMF2NFA8/jf8JGqCpBxR/6b
 5ooY5hGORohv1pHLI59Dt1oGv+bZynv8Gv/pSwgFGBvkkyJGX/fjMamA==;
From: Gourav Singh <gouravsingh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gouravsingh@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] tests: remount /var with exec after login for LAVA test jobs
Date: Fri, 17 Apr 2026 17:06:51 +0530
Message-Id: <20260417113651.3923307-2-gouravsingh@siemens.com>
In-Reply-To: <20260417113651.3923307-1-gouravsingh@siemens.com>
References: <20260417113651.3923307-1-gouravsingh@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 19 Apr 2026 23:59:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22764

The crypt hook now mounts /var with noexec by default for security
reasons. LAVA places and runs its test binaries under /home, which is
a symlink to /var/home, so any binary execution by lava binaries
fails with "Permission denied" due to the noexec flag on /var.

Add a login_commands step to all affected LAVA job templates to
remount /var with exec after login. This remount is temporary and
only applies to the running test session, it does not persist across
reboots and does not relax the default mount security options at the
image level.

Affected templates:
- IEC_template.yml
- M-COM-x86.yml
- secureboot_template.yml
- swupdate_negative_test.yml
- swupdate_reboot_without_confirm.yml
- swupdate_template.yml

Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
---
 tests/templates/IEC_template.yml                    | 2 ++
 tests/templates/M-COM-x86.yml                       | 2 ++
 tests/templates/secureboot_template.yml             | 2 ++
 tests/templates/swupdate_negative_test.yml          | 2 ++
 tests/templates/swupdate_reboot_without_confirm.yml | 2 ++
 tests/templates/swupdate_template.yml               | 4 ++++
 6 files changed, 14 insertions(+)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index 148f07e..0c4ece5 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -59,6 +59,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - mount -o remount,exec /var

 # TEST_BLOCK
 - test:
diff --git a/tests/templates/M-COM-x86.yml b/tests/templates/M-COM-x86.yml
index 7cb6cc2..b286656 100644
--- a/tests/templates/M-COM-x86.yml
+++ b/tests/templates/M-COM-x86.yml
@@ -46,6 +46,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - mount -o remount,exec /var
     transfer_overlay:
       transfer_method: http
       download_command: "curl -H 'Connection: close' -v --trace-time --output overlay-1.1.1.4.tar.gz"
diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
index 0a075e2..89c2dc1 100644
--- a/tests/templates/secureboot_template.yml
+++ b/tests/templates/secureboot_template.yml
@@ -59,6 +59,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - mount -o remount,exec /var
     parameters:
       kernel-start-message: "EFI stub: UEFI Secure Boot is enabled."

diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
index 250eaa8..49c6f2e 100644
--- a/tests/templates/swupdate_negative_test.yml
+++ b/tests/templates/swupdate_negative_test.yml
@@ -67,6 +67,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - mount -o remount,exec /var

 # TEST_BLOCK
 # Fail the job if software update application error is not as expected
diff --git a/tests/templates/swupdate_reboot_without_confirm.yml b/tests/templates/swupdate_reboot_without_confirm.yml
index 074eb1a..58014d8 100644
--- a/tests/templates/swupdate_reboot_without_confirm.yml
+++ b/tests/templates/swupdate_reboot_without_confirm.yml
@@ -25,6 +25,8 @@
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - mount -o remount,exec /var
     parameters:
        kernel-start-message: "kernel: C:BOOT0:linux.efi"

diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
index d62d312..234298e 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -59,6 +59,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - mount -o remount,exec /var

 # TEST_BLOCK 1
 # Fail the job if software update application failed
@@ -102,6 +104,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - mount -o remount,exec /var
     parameters:
        kernel-start-message: "kernel: C:BOOT1:linux.efi"

--
2.39.5



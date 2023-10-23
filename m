Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DCAC004C0
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 15:02:51 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.122858.1698073370816960200
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Oct 2023 08:02:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=bEUhdAEo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20231023150248055d7a0e12863fe180-1vfzt3@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231023150248055d7a0e12863fe180
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Oct 2023 17:02:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=4yMJjJ/SF4ixxHUG4EcI/irLionAYK3VquIQ/8Nx4yk=;
 b=bEUhdAEovWQxBpU3LNOjS9AJdSZKJZNEGoKXLJrxl9DXwV96rYHZbFtL4FM2o0e03oi6ya
 yXEDwH9GIaMB/lc9BW99I9u1UBBIcBwXgzy2pIFiKv6ICLLTh/t6wEz2ibxV8B4cRK/B2mLO
 m4020VuwQAQwTzfvSPNfy/bPXE7gs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC 8/9] customization-kernelci: Add dependency to customizations
Date: Mon, 23 Oct 2023 17:00:06 +0200
Message-ID: <20231023150243.3990309-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Oct 2023 15:02:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13442

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is to simplify maintenance.

Also extract serial getty override and sshd_config
changes from postinstall to seperate files.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../kernelci-customizations/files/postinst     | 11 -----------
 .../files/serial-getty-kernelci-override.conf  |  3 +++
 .../files/ssh-permit-empty-passwords.conf      |  2 ++
 .../kernelci-customizations.bb                 | 18 ++++++++++++++----
 4 files changed, 19 insertions(+), 15 deletions(-)
 create mode 100644 recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
 create mode 100644 recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf

diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-core/kernelci-customizations/files/postinst
index 7ae30e8..08544a4 100644
--- a/recipes-core/kernelci-customizations/files/postinst
+++ b/recipes-core/kernelci-customizations/files/postinst
@@ -15,20 +15,9 @@
 echo "CIP Core Demo & Test Image" > /etc/issue
 
 # permit root login without password
-echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
-echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
 passwd root -d
 
-# serial getty service for autologin
-mkdir -p /etc/systemd/system/serial-getty@.service.d/
-echo "[Service]" > /etc/systemd/system/serial-getty@.service.d/override.conf
-echo "ExecStart=" >> /etc/systemd/system/serial-getty@.service.d/override.conf
-echo "ExecStart=-/sbin/agetty --autologin root --keep-baud 115200,38400,9600 %I $TERM" >> /etc/systemd/system/serial-getty@.service.d/override.conf
-
 # set the profile for KernelCI
 echo "PS1='\$(pwd) # '" > /root/.profile
 echo "cd /" >> /root/.profile
 
-HOSTNAME=demo
-echo "$HOSTNAME" > /etc/hostname
-echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
diff --git a/recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf b/recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
new file mode 100644
index 0000000..a1472c5
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
@@ -0,0 +1,3 @@
+[Service]
+ExecStart=
+ExecStart=-/sbin/agetty --autologin root --keep-baud 115200,38400,9600 %I $TERM
diff --git a/recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf b/recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
new file mode 100644
index 0000000..b958fec
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
@@ -0,0 +1,2 @@
+PermitEmptyPasswords yes
+
diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
index f972be5..3a99884 100644
--- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
+++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
@@ -11,13 +11,23 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-core/customizations/common.inc
+inherit dpkg-raw
 
 DESCRIPTION = "CIP Core KernelCI image customizations"
 
-SRC_URI += "file://dmesg.sh"
+DEPENDS += "customizations"
+DEBIAN_DEPENDS += "customizations"
 
-do_install:append() {
-  install -v -d ${D}/opt/kernelci
+SRC_URI = "file://postinst \
+           file://dmesg.sh \
+           file://serial-getty-kernelci-override.conf \
+           file://ssh-permit-empty-passwords.conf"
+
+do_install[cleandirs] = "${D}/opt/kernelci/ \
+                         ${D}/etc/systemd/system/serial-getty@.service.d/ \
+                         ${D}/etc/ssh/sshd_config.d/"
+do_install() {
   install -v -m 744 ${WORKDIR}/dmesg.sh ${D}/opt/kernelci/
+  install -v -m 644 ${WORKDIR}/serial-getty-kernelci-override.conf ${D}/etc/systemd/system/serial-getty@.service.d/serial-getty-kernelci-override.conf
+  install -v -m 600 ${WORKDIR}/ssh-permit-empty-passwords.conf ${D}/etc/ssh/sshd_config.d/ssh-permit-empty-passwords.conf
 }
-- 
2.42.0



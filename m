Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66E6C41535
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 08:49:49 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.182058.1698742187077371981
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Oct 2023 01:49:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=NNUHQsxD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2023103108494422d43670e56ceb6843-gggyqe@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023103108494422d43670e56ceb6843
        for <cip-dev@lists.cip-project.org>;
        Tue, 31 Oct 2023 09:49:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=KkrE/aaGJne7YC9Xs4E/hV6L1sOCQbFqkS7i9saxwLk=;
 b=NNUHQsxDQc/IJFSXZa32EP2aC/mZAZVM/i7LjAb5SuJtKJ3KMeme+IYpVYoGCSykOC7478
 oH+FxesJi5hHxb9fH8jTwU99LxKIcOWRhkmlMcy+hFa4jQTVe0/6XxJl3YKG5GnqBl7Mdc2e
 V4zgLnt4FT3BmjyL6hkSC/wgFmSuY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC v2 3/9] customizations: Move ssh configuration from postinst to sshd_config.d
Date: Tue, 31 Oct 2023 09:37:37 +0100
Message-ID: <20231031084943.3105056-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
References: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Oct 2023 08:49:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13498

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Make the ssh configuration in line with Debian guidelines by adding
an additional file to /etc/ssh/sshd_config.d/.

This also allows to disable these changes with a customization.bbappend
instead of overwritting the postinst script.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/customizations/customizations.bb          | 8 ++++++++
 recipes-core/customizations/files/postinst.tmpl        | 4 ----
 recipes-core/customizations/files/ssh-permit-root.conf | 1 +
 3 files changed, 9 insertions(+), 4 deletions(-)
 create mode 100644 recipes-core/customizations/files/ssh-permit-root.conf

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index ad16a90..3dbeb3f 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -11,6 +11,7 @@
 
 require common.inc
 
+SRC_URI += "file://ssh-permit-root.conf"
 DESCRIPTION = "CIP Core image demo & customizations"
 
 do_prepare_build:prepend:qemu-riscv64() {
@@ -20,3 +21,10 @@ do_prepare_build:prepend:qemu-riscv64() {
 		echo "systemctl mask serial-getty@hvc0.service" >> ${WORKDIR}/postinst
 	fi
 }
+
+do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
+do_install:append () {
+	if [ -f "${WORKDIR}/ssh-permit-root.conf" ]; then
+		install -v -m 644 ${WORKDIR}/ssh-permit-root.conf ${D}/etc/ssh/sshd_config.d/
+	fi
+}
diff --git a/recipes-core/customizations/files/postinst.tmpl b/recipes-core/customizations/files/postinst.tmpl
index 2668a93..62e9a1a 100644
--- a/recipes-core/customizations/files/postinst.tmpl
+++ b/recipes-core/customizations/files/postinst.tmpl
@@ -14,10 +14,6 @@ set -e
 
 echo "CIP Core Demo & Test Image (login: root/root)" > /etc/issue
 
-if ! grep -e "^PermitRootLogin.*yes" -q /etc/ssh/sshd_config; then
-	echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
-fi
-
 HOSTNAME="${CUSTOM_HOSTNAME}"
 echo "$HOSTNAME" > /etc/hostname
 echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
diff --git a/recipes-core/customizations/files/ssh-permit-root.conf b/recipes-core/customizations/files/ssh-permit-root.conf
new file mode 100644
index 0000000..1073982
--- /dev/null
+++ b/recipes-core/customizations/files/ssh-permit-root.conf
@@ -0,0 +1 @@
+PermitRootLogin yes
-- 
2.42.0



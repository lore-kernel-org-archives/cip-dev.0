Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70222C83F34
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 10:15:52 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.17820.1752833743257242364
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 03:15:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=LFdEhw38;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1321639-202507181015380350287faedda0d0ae-kexhwe@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202507181015380350287faedda0d0ae
        for <cip-dev@lists.cip-project.org>;
        Fri, 18 Jul 2025 12:15:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Yu0ppRNxr14XwRb6zZe5hHGyAQNsORCG/kd2VCHZvbo=;
 b=LFdEhw38KQCtHn6uHM8cWQJR0TxvgxLmH2uNaT1f7GOfvD+n3VEETkA5SNhp2I0kGybdoq
 NAH5OgHVd69VebhCFwxX2YQ6hMXcYBDXxMD49zoPN1A9JHhag0Fm73MygNFZNH3a0HfysRZq
 FqPV5iLXGImNTrgVpFsY468u+0AloLpi7tZzMWoE8YUGFx5Ab7hE/WtFuApjtjn2jxDPOCXH
 CoiR0N2EaTOmarjYOeCtPqyttvTu2HdvRiqDJCgXlmi+SpLzVkx6FiOtvtuCec2md/6WPbOT
 PYCmqxqe7desQDnaFXvTV68fOHbGRmCTSIYPw6EXZm3sqBjnwzbAs1PQ==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: cedric.hombourger@siemens.com,
	quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] immutable-rootfs: disable daily package update checks
Date: Fri, 18 Jul 2025 12:15:25 +0200
Message-ID: <20250718101525.1270424-2-felix.moessbauer@siemens.com>
In-Reply-To: <20250718101525.1270424-1-felix.moessbauer@siemens.com>
References: <20250718101525.1270424-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 10:15:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19565

When running on an immutable rootfs, we don't allow package updates.
Nonetheless, apt tries to update the daily package list and upgrade some
packages. This is triggered by systemd timers, which are both manually
registered in /etc, as well as deployed via systemd vendor presets.
While it anyways makes no sense to run the update, it also might fail
for various reasons, rendering the system "degraded" after some time.

We disable the timers and also disable the dpkg database backup, as the
database itself is also immutable.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
PS: It is very unlikely, that we catch this kind of errors in our tests,
as they only show up after running the system for some time. We further
don't reliably know severe the impact on production systems is, as still
many don't rely on the overall systemd state (e.g. to bless an update).

Firmware updates: This patch will also cleanup the timers on deployments
with an /etc overlay because:

- the timers previously got installed by debian - hence are part of the
  immutable rootfs (the lowerdir of /etc)
- the systemd presets did not install the timers because they were
  already installed - hence the files are not created in the upperdir.

Best regards,
Felix

 .../files/95-disable-package-updates.preset          |  3 +++
 recipes-core/immutable-rootfs/files/postinst         | 12 ++++++++++++
 .../immutable-rootfs/immutable-rootfs_0.2.bb         | 11 ++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
 create mode 100644 recipes-core/immutable-rootfs/files/postinst

diff --git a/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
new file mode 100644
index 0000000..7e6e9ef
--- /dev/null
+++ b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
@@ -0,0 +1,3 @@
+disable apt-daily.timer
+disable apt-daily-upgrade.timer
+disable dpkg-db-backup.timer
diff --git a/recipes-core/immutable-rootfs/files/postinst b/recipes-core/immutable-rootfs/files/postinst
new file mode 100644
index 0000000..a6e1962
--- /dev/null
+++ b/recipes-core/immutable-rootfs/files/postinst
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+set -e
+
+# These services are installed by "apt" to ensure the system receives
+# updates. As we don't allow updates on an immutable system, we need
+# to disable them.
+deb-systemd-helper disable apt-daily.timer
+deb-systemd-helper disable apt-daily-upgrade.timer
+deb-systemd-helper disable dpkg-db-backup.timer
+
+#DEBHELPER#
diff --git a/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb b/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
index c847f44..85f6184 100644
--- a/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
+++ b/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
@@ -15,7 +15,11 @@ inherit dpkg-raw
 MAINTAINER = "Felix Moessbauer <felix.moessbauer@siemens.com>"
 DESCRIPTION = "Config to link volatile data to immutable copies"
 
-SRC_URI = "file://${BPN}.tmpfiles.tmpl"
+SRC_URI = " \
+    file://postinst \
+    file://${BPN}.tmpfiles.tmpl \
+    file://95-disable-package-updates.preset \
+"
 DPKG_ARCH = "all"
 
 IMMUTABLE_DATA_DIR ??= "/usr/share/immutable-data"
@@ -25,3 +29,8 @@ TEMPLATE_FILES += "${BPN}.tmpfiles.tmpl"
 do_prepare_build:append() {
     cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
 }
+
+do_install() {
+    install -v -d ${D}/usr/lib/systemd/system-preset
+    install -v -m 755 ${WORKDIR}/95-disable-package-updates.preset ${D}/usr/lib/systemd/system-preset
+}
-- 
2.50.0



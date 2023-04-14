Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1FCC77B72
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:45:50 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.5090.1681464260246312473
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Apr 2023 02:24:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=mrVwyGxa;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-20230414092417762433072124e993fc-fqojdl@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230414092417762433072124e993fc
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Apr 2023 11:24:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=TCobiEwgMnyvUTT0KgCT2IW17vGgCP6w2KJSc0LULvI=;
 b=mrVwyGxaXQigAjuWR0RP2exJphFBEM1Oo18/cLeWlWp4izcDSfhJirT6YJg8Tb84STHjeU
 ZmUb3P/YY887/QrVeCCqGjUhtaU/bk3jVOyvqnzsUmXXjscxlx1S78GQQxDkJ7zV0fHnTD9O
 h5ryVZboLkLAeM8hQPdfrset3FLkY=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2] add support to limit resource consumption of squashfs creation
Date: Fri, 14 Apr 2023 17:24:08 +0800
Message-Id: <20230414092408.679342-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:45:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11218

This patch makes it possible to control the number of CPUs and the
memory usage when generating a squashfs. The variable names used
follow the imagetype variable scheme.

Especially when compressing a squashfs internally with cpu and memory
heavy compressors like xz, we inherit the issues we had with the image
compression in the past. On CI systems, where many tasks might run in
parallel, this often led to OOMs and poor performance. By providing
these options similiar to the other imagetype options, we give CI
administrators an easy way to control the memory consumption,
independent of the other options passed to mksquashfs.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v1:

- add reasoning in the commit message
- no functional changes

 classes/squashfs.bbclass | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index a06c501..b14768c 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -15,6 +15,13 @@ SQUASHFS_EXCLUDE_DIRS ?= ""
 SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
 SQUASHFS_CREATION_ARGS ?= ""
 
+SQUASHFS_THREADS ?= "${@oe.utils.cpu_count(at_least=2)}"
+SQUASHFS_THREADS[vardepvalue] = "1"
+# default according to mksquasfs docs
+SQUASHFS_MEMLIMIT ?= "7982M"
+SQUASHFS_DEFAULTS ?= "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
+SQUASHFS_DEFAULTS[vardepsexclude] += "SQUASHFS_MEMLIMIT SQUASHFS_THREADS"
+
 python __anonymous() {
     exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
     if len(exclude_directories) == 0:
@@ -31,5 +38,5 @@ IMAGE_CMD:squashfs[depends] = "${PN}:do_transform_template"
 IMAGE_CMD:squashfs() {
     ${SUDO_CHROOT} /bin/mksquashfs \
         '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
-        -noappend ${SQUASHFS_CREATION_ARGS}
+        -noappend ${SQUASHFS_DEFAULTS} ${SQUASHFS_CREATION_ARGS}
 }
-- 
2.39.2



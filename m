Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AE3C47DD9
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 14:23:47 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.38761.1711548969052309946
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 07:16:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=JVX5RxK+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1321639-20240327141605c1d67fada10d131823-l8xqgs@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240327141605c1d67fada10d131823
        for <cip-dev@lists.cip-project.org>;
        Wed, 27 Mar 2024 15:16:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=5JNWNIhrYOoZpldZCzTMf+wQvZ9W9trotsckTJZZTxk=;
 b=JVX5RxK+m61KyjU21Encu+vHBBYJ/HhUvu3LQt9fJ+EIJEbaK1pmxWnGqc3afcKC7bNr8c
 TIm4E/aZRpHERU25iLaZ9Ti9IlCK4oxz64Ay+6CDehg1W9IA3LIzbjRa7aQkIvLytRL2vz6K
 mdsrzhAtaio8J+D8BiQzKvEW7p+NQ=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] fix(sid): copy immutable dpkg db
Date: Wed, 27 Mar 2024 15:15:56 +0100
Message-Id: <20240327141556.542243-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 14:23:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15471

The immutable copy of the dpkg db is not supported on pre-bookworm.
However, the logic only made it available on bookworm but not on any
later release.

This patch fixes this by inverting the logic: We always enable it and
just exclude buster and bullseye.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/read-only-rootfs.bbclass | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index bb8ab9a..fa56b2e 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -18,9 +18,13 @@ IMAGE_INSTALL += "home-fs"
 IMAGE_INSTALL += "tmp-fs"
 
 # For pre bookworm images, empty /var is not usable
-IMAGE_INSTALL:append:bookworm = " immutable-rootfs"
+IMAGE_INSTALL:append = " immutable-rootfs"
+IMAGE_INSTALL:remove:buster = " immutable-rootfs"
+IMAGE_INSTALL:remove:bullseye = " immutable-rootfs"
 
-ROOTFS_POSTPROCESS_COMMAND:append:bookworm =" copy_dpkg_state"
+ROOTFS_POSTPROCESS_COMMAND:append =" copy_dpkg_state"
+ROOTFS_POSTPROCESS_COMMAND:remove:buster =" copy_dpkg_state"
+ROOTFS_POSTPROCESS_COMMAND:remove:bullseye =" copy_dpkg_state"
 copy_dpkg_state() {
     IMMUTABLE_VAR_LIB="${ROOTFSDIR}/usr/share/immutable-data/var/lib"
     sudo mkdir -p "$IMMUTABLE_VAR_LIB"
-- 
2.39.2



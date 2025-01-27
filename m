Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9514C02188
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 14:08:20 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.52024.1737986899038437719
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jan 2025 06:08:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=LrRZzX6V;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202501271408154fb27e24cbea2e4789-c0it6m@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202501271408154fb27e24cbea2e4789
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Jan 2025 15:08:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=R8aYW007y1NjFH2p6vG1eTMpo/BEaz2e18pR9cZIHxU=;
 b=LrRZzX6VFSecT4e1Tf9GDbbUM6RPfsGvE8mb6tAH9KQ7xcymMIz+crVZwA0a4U5FEWtfCv
 FHu4JIUV5qVY++myp2R0tT4+QVDlhaD8M3Roma1zL2xoHhMXQ2OngDUWFCWVh9p0u2c9thTD
 IptWOjQ/45lqG/SQRUF3GCklx5ltUY4lzSSWo2WaCNRLwqkTxHRvy3WmOxeUji3ME+e05/9C
 Az3/BiQ+g9i/ZLsIvWxuecSbGAslTEhafWo5YkptrH/l5bFKrghjDOYu1zx6WLcclvFE4iJd
 CYODlG/y/klCE3mFb2tT20/MtaG4ijT+gZQN8/Gae12URL1Yy1dtxOhw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: ludwig.nussel@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC] read-only-rootfs.bbclass: Exclude var and home from the erofs and squashfs
Date: Mon, 27 Jan 2025 15:07:47 +0100
Message-ID: <20250127140814.762632-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jan 2025 14:08:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17671

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This excludes the content of both var and home from the root file
system.

This fixes issue #126.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/read-only-rootfs.bbclass | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 9ebcadc..b3bab32 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -34,6 +34,10 @@ copy_dpkg_state() {
     sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
 }
 
+RO_ROOTFS_EXCLUDE_DIRS = "var home"
+EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
+SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
+
 image_configure_fstab() {
     sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
-- 
2.47.0



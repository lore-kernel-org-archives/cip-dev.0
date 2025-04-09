Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0733AC36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 08:27:32 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.3505.1744187249079228506
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Apr 2025 01:27:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=L3XWYkm0;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1321639-2025040908272587f4edbc17c0882a8f-xevwjg@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025040908272587f4edbc17c0882a8f
        for <cip-dev@lists.cip-project.org>;
        Wed, 09 Apr 2025 10:27:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=k/aLDlCO2Z1shfnS/f2UZoRAlWEIxo+Lre3xstMbo0c=;
 b=L3XWYkm0T/SP5Rki2r/w8AtZKwQjubeWyyxtYf65EfrTIBmmkCRTHQkvglR9AFvGBAAUmx
 XzR8KhCDMLO0CSW84hWL9Rh2wA0aDcC7dTIEKvlBeEbbI5Cpy9+H1BXivCLp9+hCi/2JScX3
 yTggFQZ1NQCqskI3es3fQWaAXAEm0PkzGqO592VJUESu+9jIWID1m5fGJfBBEls6ZfTlzM/r
 ++Meo8G/q+el+kiM1WERQlve4kjRQWqIke6CRvYD+RfS7UxPhOroEZ8eDX+gnNEFeth4hyPy
 swvEScx/4pg5BerQdRqVxqMVCkeC1xQURfz3eWlFbM7KxBKSMV/FSjPA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com
Subject: [isar-cip-core][PATCH 1/1] immutable-home: create relative symlink in rootfs_postprocess
Date: Wed,  9 Apr 2025 10:26:59 +0200
Message-ID: <20250409082659.3828643-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Apr 2025 08:27:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18497

The Debian policy 10.5 states that symlinks within the top-level
directory shall be realtive. Further, symlinks shall not be dead at any
point in time.

We now make the symlink relative and create the target directory. While
changing this, we also drop the unnecessary chrooting and make the path
to IMMUTABLE_DATA_DIR canonical.

Fixes: 786ddaa ("Move content of home to IMMUTABLE_DATA_DIR")
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
I decided to add the fixes tag, as I consider violations of the Debian policy
a bug. However, from a runtime POV this does not change anything (hence is not
a bug). Feel free to drop the tag while merging.

Best regards,
Felix

 classes/read-only-rootfs.bbclass | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index f1db4ae..e81084d 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -45,12 +45,13 @@ copy_dpkg_state() {
 ROOTFS_POSTPROCESS_COMMAND:append = " copy_home_to_immutable_data"
 ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part = " copy_home_to_immutable_data"
 copy_home_to_immutable_data() {
-    IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}/"
+    IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}"
     sudo mkdir -p "$IMMUTABLE_HOME_DIR"
     sudo mv ${ROOTFSDIR}/home "$IMMUTABLE_HOME_DIR/"
     # as the rootfs is read-only we need to create the link
     # between /var/home and /home during creation.
-    sudo chroot ${IMAGE_ROOTFS} ln -s /var/home /home
+    sudo ln -s var/home ${IMAGE_ROOTFS}/home
+    sudo mkdir -p ${IMAGE_ROOTFS}/var/home
 }
 
 RO_ROOTFS_EXCLUDE_DIRS ??= ""
-- 
2.49.0



Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6D2E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 16:51:10 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.23921.1736527868964277086
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jan 2025 08:51:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=X3/4GxU+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20250110165104e2f8eb3ac9bc8d380d-htgk3x@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250110165104e2f8eb3ac9bc8d380d
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Jan 2025 17:51:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ujMGZrmoUIhPNtQhoB9ATmLClhnaW0kqv8ggFwTE0G4=;
 b=X3/4GxU+xpqvQ13WCZBYv1n7HOjIIyQOW8D3X0dzoHoOkxJ4LEbcXehYEljQMdASSKBK6i
 VtGqLIaCXEYVo2YW/9K6qa9pXJqUm4I27q/ZmIWEAv+a9u0qnr83OKNq8ie/knLpG/bGCtq5
 wjeRyS5o6pLDKvqamdZ1GAbs8yU1TOgPKFpQEUm9UtbnvD8PZy6ZxI6zRYDY3whcg4tN8C85
 WAzCxolH5WC8NhoOXPlkiD1yrygC48CxunGjVrAZHwBmMuBnvgtfMJWtq2ASSGe9ZglDJrtB
 agzfPxF2m8MLXuD0iWdvtfjtnKTNjCW2qS6bPz4zo1stwr5JklcliIeA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] initramfs-overlay: fix missing scriptpreq
Date: Fri, 10 Jan 2025 17:50:45 +0100
Message-ID: <20250110165103.77249-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jan 2025 16:51:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17530

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

During testing with LAVA it was detect that the overlays are not
mounted on real hardware if the image is booted a second time.

SCRIPT_PREREQ adds a weak prerequisite to the script so it still
works if the crypt hook is not installed.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v2:
 - fixed typo in commit
 - added clarification that SCRIPT_PREREQ adds a weak prerequisite

 .../initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
index 56ae8d2..4e2e292 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
@@ -45,6 +45,8 @@ DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
 HOOK_ADD_MODULES = "overlay"
 HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
 
+SCRIPT_PREREQ="crypt"
+
 do_install:append() {
     install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
         "${D}/usr/share/initramfs-tools/scripts"
-- 
2.46.1



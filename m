Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9041ECCD19A
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:54:13 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.9186.1760622847141199370
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Oct 2025 06:54:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=WBOOoYwj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1321639-20251016135403764718c06600020793-33au4b@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251016135403764718c06600020793
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Oct 2025 15:54:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=tPznloHXklN9Eo8BtTCxCwytsI6YwwnDf0BRi+AnZSg=;
 b=WBOOoYwj4MlUw4wMbKKUD2wMQGjW7U6Q/WJ+tGyQdQ3keTN43i6rTkyXhSSN4skWD4wC3Q
 TWtuR20QyOIgBbKS2YQGw98OBhC1622dLv7lks1xys5abwSbVsMqUaatIO9aVQdDQSlVl8b5
 qrSiXQ1BGAYsh41/w9S7O3fOQP4I5XCxz63Gs1rkgy8zqtypujewa91RM+orQU7UW6qIXlRB
 iFxhSwpHBpKVyw5U+dU9Gj9TORLi3iLwWhOTodigR4PiNBhLL9VyEkCIpFrGh3ybMnkPP0Ux
 iYgM+PLnbx3f4NqNgZO4+B5FdwZjd+ECJaP/yYZGXB5G659l48Eaqwyg==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	christoph.steiger@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] make apt cache world readable
Date: Thu, 16 Oct 2025 15:53:49 +0200
Message-ID: <20251016135349.2030862-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 13:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20189

The apt cache directory in /var/lib/apt has default permissions of 755
on non-ro systems. By that, unprivileged users (or tooling) can access
the apt cache. When running on a ro-rootfs, we need to create the
directory using systemd tmpfiles, as the system is deployed with an
empty /var. This should be done with the same permissions as before.

Note, that this should not have any effect on the target systems, as
we anyways wipe the apt cache before deploying. However, as this
tmpfiles snippet comes as a package, the limitation already applies at
assembly time, which breaks BOM scanners that run as a rootfs
postprocess command.

Fixes: 26763b3 ("create apt directory as needed by apt-daily")
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 .../immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
index e8e58b3..e6d25d2 100644
--- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
+++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
@@ -1,3 +1,3 @@
 L /var/lib/dpkg - - - - ${IMMUTABLE_DATA_DIR}/var/lib/dpkg
 d /var/log/audit 0700 root adm -
-d /var/lib/apt 0700 root root -
+d /var/lib/apt 0755 root root -
-- 
2.51.0



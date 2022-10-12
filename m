Return-Path: <ubely@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921C1C433FE
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 11:19:28 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web10.18957.1665573563240593103
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 04:19:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: ubely@ilbers.de)
Received: from baighyz.m.ilbers.de (host-80-81-17-52.static.customer.m-online.net [80.81.17.52])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8+deb9u1) with ESMTPSA id 29CBJJps026731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 13:19:20 +0200
From: Uladzimir Bely <ubely@ilbers.de>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH] Fix mount options passed to systemd unit
Date: Wed, 12 Oct 2022 13:19:19 +0200
Message-Id: <20221012111919.8911-1-ubely@ilbers.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 11:19:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9740

Mount unit template used wrong variable name for mount options.
This resulted in empty `Options` value used for /tmp mounting.

Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
---
 recipes-core/tmp-fs/files/tmp.mount.tmpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/tmp-fs/files/tmp.mount.tmpl b/recipes-core/tmp-fs/files/tmp.mount.tmpl
index fcb2f3e..be5e663 100644
--- a/recipes-core/tmp-fs/files/tmp.mount.tmpl
+++ b/recipes-core/tmp-fs/files/tmp.mount.tmpl
@@ -5,7 +5,7 @@ Description=Create /tmp
 What=tmpfs
 Where=/tmp
 Type=tmpfs
-Options=${TMP_OPTIONS}
+Options=${TMP_FS_OPTIONS}
 
 [Install]
 WantedBy=local-fs.target
-- 
2.20.1



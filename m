Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA43C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 13:11:24 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.19003.1709285679264799931
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Mar 2024 01:34:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=HgSZxyyM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1321639-20240301093436629b77dea59bc66c00-cf_m0o@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240301093436629b77dea59bc66c00
        for <cip-dev@lists.cip-project.org>;
        Fri, 01 Mar 2024 10:34:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=YdqaWedES9RlHhSmtB4GJjGluvF/HhR8NCHIzeFZXRM=;
 b=HgSZxyyMO8jIybPGcTO08+8Qc9pwZDbRaAxqpv62sDyT5fY0Wp9WUZeQYNwt3UOb+92Q13
 FqL0bdQPVI6z+ogvwW4yMR1o9JtAUreTgYOfnZQNOOer7sj5PEdSGj3WhTNEYt9HE6s8gY2J
 xiR0t+cuH2jpR4y2SXRQREB3wOsyY=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Subject: [isar-cip-core][PATCH 1/1] create audit log folder with tmpfiles.d
Date: Fri,  1 Mar 2024 10:34:22 +0100
Message-Id: <20240301093422.572373-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 13:11:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15117

The current packaging of auditd is incompatible with an empty /var, as
the directory is created at install time. Until this is fixed upstream,
we add a tmpfiles.d entry to create the directory if it does not exist.

Fixes: #101
Reported-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
index d180bc5..2f7c338 100644
--- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
+++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
@@ -1 +1,2 @@
 L /var/lib/dpkg - - - - /usr/share/immutable-data/var/lib/dpkg
+d /var/log/audit 0700 root adm -
-- 
2.39.2



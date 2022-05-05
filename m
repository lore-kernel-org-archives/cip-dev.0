Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B59C433F5
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 16:43:38 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.13539.1651769014539215601
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 09:43:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=N5kR9w6k;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-202205051643319504194c1e9a1c2905-uft87y@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202205051643319504194c1e9a1c2905
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 May 2022 18:43:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=B1Gz+TLYxJ3TSprOo31rYjOWc/C9tv3v3IdLIcb3fMc=;
 b=N5kR9w6kf8fxbiWnn31FhUljUaam6dhIgm/QssNWsTfGgzuJ6UwAUZ7MruWwN6yYGfs8VL
 BPVvi69jI3rerlooZTT1Pqjd1Y5MzRtzGLrbTySMYMx3ha9AS7pNcJuYxrJ6dq10wEO9nEnU
 VDErBw91vfXKR/abFrQ/9Uv4Nw4Kw=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 01/13] initramfs-etc-overlay-hook: Improve
 error reporting of script
Date: Thu,  5 May 2022 18:43:17 +0200
Message-Id: 
 <4f88138887963ae36f0c54258801d4d059b37132.1651769009.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651769009.git.jan.kiszka@siemens.com>
References: <cover.1651769009.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 16:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8255

From: Jan Kiszka <jan.kiszka@siemens.com>

Fail loudly in case the overlay cannot be mounted.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-etc-overlay-hook/files/etc-overlay.script       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
index a9a3663..6e5aacd 100644
--- a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
+++ b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
@@ -31,4 +31,6 @@ fi
 
 mkdir -p ${rootmnt}/var/local/etc
 mkdir -p ${rootmnt}/var/local/.atomic
-mount -t overlay -o lowerdir=${rootmnt}/etc,upperdir=${rootmnt}/var/local/etc,workdir=${rootmnt}/var/local/.atomic overlay ${rootmnt}/etc
+if ! mount -t overlay -o lowerdir=${rootmnt}/etc,upperdir=${rootmnt}/var/local/etc,workdir=${rootmnt}/var/local/.atomic overlay ${rootmnt}/etc; then
+	panic "Can't mount overlay!"
+fi
-- 
2.34.1



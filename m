Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED95C3DA4A
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 02:03:33 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.8682.1733916527133693729
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 03:28:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=IMB4XXvt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1321639-20241211112843d19cbd0904238d144b-raybkv@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20241211112843d19cbd0904238d144b
        for <cip-dev@lists.cip-project.org>;
        Wed, 11 Dec 2024 12:28:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=DIByTd2dx8AqjuIZD0gwl6h7NSJCjdeAR1Wo4eQycPs=;
 b=IMB4XXvt9NHdK/z0nj0ELpaWwTrOCpQ7Gv+7TeVzzrzx+FAQLtibmoN6lhaC9eo6e/o0od
 o1htJb4dZ2398K0D/XD7gKY47ODqOaWkvO1V+KgQAXaPz3fzQ4J0OyI9jEsEYEAQrQvCe9A8
 517Iz0vo/wm698OE4TgVvTKGbwyBFtm1M03LIHM4Qrucf06jbW2KGjGhFcdVurV7bRIFfiZu
 716LmyG14kOrU6KueE8MqDwb2ZmXGPsIDPYlZ3RJ9hR5rM/KFZ5TAGqBSj6nyijWX1Q1ZfbQ
 s10R6HVKG9BUsxrzaOV167sS78UQb4vofAKyvyAXvd88omvT4A+Cqrew==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] squashfs: ensure path glob is not expanded by calling shell
Date: Wed, 11 Dec 2024 12:28:39 +0100
Message-Id: <20241211112839.2743741-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Dec 2024 02:03:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17437

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/squashfs.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index cebda70..751da20 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -38,7 +38,7 @@ python __anonymous() {
     # This allows to use the directory as a mount point.
     args = " -wildcards"
     for dir in exclude_directories:
-        args += " -e {dir}/* ".format(dir=dir)
+        args += " -e '{dir}/*' ".format(dir=dir)
     d.appendVar('SQUASHFS_CREATION_ARGS', args)
 }
 
-- 
2.39.5



Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F6E77183
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 02:03:33 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.7057.1733910910832790430
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 01:55:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=FTqjxD4r;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1321639-20241211095507d9956385f551687e73-xkekbu@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20241211095507d9956385f551687e73
        for <cip-dev@lists.cip-project.org>;
        Wed, 11 Dec 2024 10:55:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cYojANsm5P1Ub1xFY0gDGFZUQUinIZXIbrw3myMWvlI=;
 b=FTqjxD4r+9D/3SslDye/hIekuAvsoaa3w2WCHZ0Un9gxXRzIphgpiXSqvTs8lT+yN4yCVF
 vA2hVTT8XFQluJtmbLH8tg4yS4LhgG26gVfbddC6uKEIkLm54zsDrsc3OO6NZ3PSa5n3s7nF
 zffTsZiOd4FowbLG9EYUCPEeq0JKzJQlJGmDEEHDVMYyN+L+u15XfNXYByTbNWuuCPnKffHh
 pnGD6SdlcFmsTzzGXvBhONqaAdGCVqyxh9lxJFgsE/oAeh13XBBGXkfB1cUDcJkd0XuRcNyO
 roq8A/sUa853vqKqfSTpeBCRSinCrgc2sT6/y7uU3LaqZNw8sHhb3e5w==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 2/3] erofs: ensure only dir prefixes are excluded
Date: Wed, 11 Dec 2024 10:54:55 +0100
Message-Id: <20241211095456.2735691-2-felix.moessbauer@siemens.com>
In-Reply-To: <20241211095456.2735691-1-felix.moessbauer@siemens.com>
References: <20241211095456.2735691-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Dec 2024 02:03:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17433

The regex used to implement the path exclusions in erofs needs to be
"anchored" to only match path prefixes but not arbitrary sections of the
path. Previously, also paths that contained an excluded part were
excluded as well. Further, we must single-quote the regex to ensure that
the '*' is not expanded by bash-globbing.

I further considered to use --exclude-path, but this is not an option as
it excludes the excluded directory as well. In case of /var and /boot
the directories (not the content) needs to be present as mountpoint.
These semantics differ from the equally named parameter in squashfs.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/erofs.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
index 189c1ea..72458bb 100644
--- a/classes/erofs.bbclass
+++ b/classes/erofs.bbclass
@@ -23,7 +23,7 @@ python __anonymous() {
     # Use regex to exclude only content of the directory.
     # This allows to use the directory as a mount point.
     for dir in exclude_directories:
-        args += " --exclude-regex {dir}/.* ".format(dir=dir)
+        args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
     d.appendVar('EROFS_CREATION_ARGS', args)
 }
 
-- 
2.39.5



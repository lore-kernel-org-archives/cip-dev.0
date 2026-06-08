Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3094CD8C8E
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 06:30:04 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47883.1780900194754008541
 for <cip-dev@lists.cip-project.org>;
 Sun, 07 Jun 2026 23:29:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=MfBvycUZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1324425-2026060806294988f9b0af91000207ab-w4q848@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026060806294988f9b0af91000207ab
        for <cip-dev@lists.cip-project.org>;
        Mon, 08 Jun 2026 08:29:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=v2t13W1RSBNyXWS/qqhF+q00lTthvl75Ir93B3AjNtQ=;
 b=MfBvycUZGte7JsM7wZdgFN6udHMsegFtBhV6eZabOLtxS/CW9XYzXtxfaKCVJbtFVgkW9f
 p08A1q8+RvY5eg9Cl9KKSBvBTkJOZenxjuoFjUCAw9V61iStiGCv5JDSE7FoX5uVep2MJ7sg
 c3ErCa6RHTGR4VEgAxHEZGpP1vQWKnhtokm37YoRYRAsWln6Y9CvLsf/89VSMzpJ42JZaKz3
 iUlBIHveS7bEML+lI+gpu3JMVu42KHqA1nmASZT1QkuxaZJ7QpJ9HmNSa+c0hXIOzRkbvKTj
 b7yGxal6A1ERaVk0vl9XcNWhHJ7Qzaqjq4r3IfMjFyFxNcXWDhtx1u2Q==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [PATCH][isar-cip-core] doc: update RT kernel module directory name
Date: Mon,  8 Jun 2026 12:00:58 +0530
Message-Id: <20260608063058.819046-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jun 2026 06:30:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23045

From: Srinuvasan A <srinuvasan.a@siemens.com>

The RT kernel module directory does not include the -rt suffix
Update the documentation to reflect the actual folder name under /lib/modules

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 doc/README.swupdate.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index affb85b..744b979 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -230,7 +230,7 @@ Also check that you are running the RT kernel:
 root@demo:~# uname -a
 Linux demo 4.19.233-cip69-rt24 #1 SMP PREEMPT RT Tue Apr 12 09:23:51 UTC 2022 x86_64 GNU/Linux
 root@demo:~# ls /lib/modules
-4.19.233-cip69-rt24
+4.19.233-cip69
 ```
 
 Now apply swupdate and reboot
-- 
2.34.1



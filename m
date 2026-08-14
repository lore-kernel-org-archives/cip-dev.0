Return-Path: <gouravsingh@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C42EC5CFC1
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 07:16:08 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7924.1786691758512476598
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Aug 2026 00:16:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gouravsingh@siemens.com header.s=fm2 header.b=bq5FMGeh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1333022-20260814070423196395fc1a00020706-oyq1ro@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260814070423196395fc1a00020706
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Aug 2026 09:15:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=gouravsingh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3E9/BYCbS02GZIBzoP0nAl8qYSAN63zU4uMsgS6IPNA=;
 b=bq5FMGeheCrItc4KOVm7VuHRkPCSxlKI5lLBaO7mAW8NNtCRBiGbDQb39rM9rdQf3hpKOi
 +vbvlKDd3ECoNeVWww5X1nilsTFc5JxW90em6efrdplXo9xxJSpNZCok8f89DeWaVwp0Lef6
 2v5+CtqmC+KeNyMjjDD8T4mpLrCvNQunP0BVWLmg03BSl3+60vtbLQ1d26t9GG31I7YZXruc
 7GeLwFnoGb81xdOVow5BRIfNDp1f0/PZIsa6TycfKzeuBJM4e+8m7Q2E8WsRM42SfJ8aKcKh
 ZeNGWHB5CxfF95fy67go3JwmkuMFLZKXPSOh23j342GQifN3Pm7W7VJQ==;
From: Gourav Singh <gouravsingh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gouravsingh@siemens.com>
Subject: [isar-cip-core][PATCH v2] recipes-core: ltp: add python3 and jq runtime dependencies
Date: Fri, 14 Aug 2026 12:34:13 +0530
Message-Id: <20260814070413.899289-1-gouravsingh@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Aug 2026 07:16:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23933

With LTP 20260529, runltp is deprecated and kirk is the recommended runner.
Ensure ltp-full runtime includes tools needed by the bundled kirk runner
and report parsing/inspection workflow.

- python3: required to execute /opt/ltp/kirk.
- jq: required for parsing/inspection of JSON reports produced by kirk.

This avoids manual package installation on targets and makes LTP/kirk usage
reproducible.

Debian buster compatibility is preserved: buster provides Python 3.7, while
kirk requires Python >= 3.6.

Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
---
 recipes-core/ltp/files/debian/control.tmpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/ltp/files/debian/control.tmpl b/recipes-core/ltp/files/debian/control.tmpl
index a7d0087..039c6d0 100644
--- a/recipes-core/ltp/files/debian/control.tmpl
+++ b/recipes-core/ltp/files/debian/control.tmpl
@@ -11,7 +11,7 @@ Homepage: https://linux-test-project.github.io/
 
 Package: ltp-full
 Architecture: any
-Depends: ${shlibs:Depends}, ${misc:Depends}
+Depends: ${shlibs:Depends}, ${misc:Depends}, python3, jq
 Description: A collection of tools for testing the Linux kernel
  The Linux Test Project is a joint project started by SGI,
  developed and maintained by IBM, Cisco, Fujitsu, SUSE,
-- 
2.39.5



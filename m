Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2256C54EFC
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:50 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18263.1784896843617741035
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=HKGX1pg1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20260724124041ab633f2708000207f4-tlycuz@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260724124041ab633f2708000207f4
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 14:40:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=RTHDTiJeGuOgc/RM7tKLuLiVDhrNg/9EO+4MZyb4BgE=;
 b=HKGX1pg1Sm0pDHaISr12FvImsUhXYv1xKSS8CvSEW7wknve7LvgoDVKUJnP0MP6fV47QhA
 IPchhvGZA1IxH1rM92rErCybAkaHXnlQMxyl+E1GotX9VzOnMhrihXjatdzAmP21WtLRctcO
 NSMGqpwZC22XiFxQL4YTv/hGs2YSYUhvDJ5cliT+5W/GZvJ1kI6kqnbDfIHeSMbiwNN2zC7e
 Fr6E2zDgZOfy0SzjldeeuoyPtBCFe1YYjTQ4Bn1MQbl2B914duv0rslcN2JzrtX8VJll85Ab
 Uwo1Uqb9iQB8xDvDr5j8GXvIS771fJ/EXgX9KBeEgtPJMQQFf7VT5OVw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 04/14] Add github.com/ovh/debian-cis for the hardening validation
Date: Fri, 24 Jul 2026 14:39:06 +0200
Message-ID: <20260724124038.3633611-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 12:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23739

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This creates a Debian package out of https://github.com/ovh/debian-cis/
to validate the hardening level during runtime.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-security/cis-hardening/cis-hardening_4.1-6.bb | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb

diff --git a/recipes-security/cis-hardening/cis-hardening_4.1-6.bb b/recipes-security/cis-hardening/cis-hardening_4.1-6.bb
new file mode 100644
index 0000000..bed2dae
--- /dev/null
+++ b/recipes-security/cis-hardening/cis-hardening_4.1-6.bb
@@ -0,0 +1,6 @@
+inherit dpkg
+
+DPKG_ARCH = "all"
+
+SRC_URI = "git://github.com/ovh/debian-cis.git;protocol=https;destsuffix=${P};nobranch=1"
+SRCREV = "efbd5b35ba32226e8950d52bd3f3444c702bbd84"
-- 
2.53.0



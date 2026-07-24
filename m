Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6815BC531C9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 10:51:24 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16607.1784890280823543221
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 03:51:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Cv4Pa5+Q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202607241051180bc14ac07e0002078d-dbfed8@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202607241051180bc14ac07e0002078d
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 12:51:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=4XMZVRRX2A3CV4BJOjS9sCEHHVEztBx/vC/9fqZqH10=;
 b=Cv4Pa5+Q8WnXA2DqThYEeV4tnxZ5noxbO+2R/2Trlvudmgg5e32FbXErLjtVKuBlM+JKUc
 +DvKrKHkiv7SkUTvzvNJr9GJmVprEzSX7N7aVbq5segTkDwtc0oZAjmXse1giJVlf6oq9mi3
 3afh0c+oVjwYa0c9owxEbbkpg5W1D/sea6Wi1jYy0ERJdhuBs1IJTV2uuOBggZSSLQajQAEd
 NZo+fMYrVL66BbBCk1KDuKvBYPmoGDA43J+79XSINrYGl1jH1Vp6imqv9BkMm0qK8Gd0TAkb
 05q+vBG17dSLkQtA+rK0VfVakaHOHFRxbULh13XKMtN4DGRTXHiC5y4Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 4/4] switch to isar-rootless
Date: Fri, 24 Jul 2026 12:51:08 +0200
Message-ID: <20260724105116.3575045-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 10:51:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23730

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig     | 2 +-
 kas-cip.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 438234c..abf9aaf 100644
--- a/Kconfig
+++ b/Kconfig
@@ -17,7 +17,7 @@ config KAS_INCLUDE_MAIN
 
 config KAS_BUILD_SYSTEM
 	string
-	default "isar"
+	default "isar-rootless"
 
 config ARCH_AMD64
 	bool
diff --git a/kas-cip.yml b/kas-cip.yml
index cbccf63..eb26716 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -15,7 +15,7 @@ header:
 distro: cip-core-trixie
 target: cip-core-image
 
-build_system: isar-privileged
+build_system: isar-rootless
 
 repos:
   cip-core:
-- 
2.53.0



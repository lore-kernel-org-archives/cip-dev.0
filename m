X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.18436.1665569293760706027
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 03:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=ESt0htsL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-72506-20221012100811394cf4af91c6d34a7b-89ytoa@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20221012100811394cf4af91c6d34a7b
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Oct 2022 12:08:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rOOoxzW+tB/eJQCkRcDk1+5FA+OWq0sbHYM3he06YPc=;
 b=ESt0htsLQMgOGPDqBsuUWU+QwgfCgprp5WOrL5mVmItBYuXiKGJcOKR0H/oeBxBxk+JDof
 Xi/ibGKJLg0Y1C8HZm45iBs4GCkUz6LUBe6Y7fKFeO1OJ85nUH8QDPou3hz9LwpV0quDTo5Y
 egbxxYFudMQjBz9IAOw0yoUCJ+myI=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	pluto.svc.chengdu.cn@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 3/3] activate nodoc profile for swupdate build
Date: Wed, 12 Oct 2022 12:06:41 +0200
Message-Id: <20221012100641.2986740-4-felix.moessbauer@siemens.com>
In-Reply-To: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
References: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

This patch enables the nodoc debian build profile for swupdate.
By that, the overall download and build time is drastically reduced.
It also helps when building behind proxies that sometimes have issues
with large pagets like texlive-extra.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index 7bcf015..a81c521 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -12,6 +12,10 @@ inherit dpkg-gbp
 
 require swupdate.inc
 
+
+DEB_BUILD_PROFILES += "nodoc"
+DEB_BUILD_OPTIONS += "nodoc"
+
 SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
 SRCREV ="344548c816b555c58ec199f31e45703897d23fb5"
 
-- 
2.30.2



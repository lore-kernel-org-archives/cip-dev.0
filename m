Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB045CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 06:02:13 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6885.1762927323616807302
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 22:02:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm1 header.b=TdULg2vP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1324425-20251112060158c91aed0264000207fc-dkyg3g@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20251112060158c91aed0264000207fc
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Nov 2025 07:01:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=E6emxFIDepFv3YvO/hXlH4VjOE6Kd7ojc5SIS5DDXYk=;
 b=TdULg2vPTSUL2ZXIB/lnfs2h0hRib3/2mRBuzpgNUiUBM5KWViCXgsJsohyQ0ZlJOC1TAX
 z2PMDp0g2ZI+BrUhGNI6q1s6JGk0X6khD3jGTodcDwUnJTs8Xob1vfgQgizVtDF6cASVMev6
 oEeb3LKt5EixyyBtSv43sipZ1BOGAmPx14qfeGXchCDK9p0EGBeHA08WfRGzg+s2B8Qp/XDx
 0ZAV/bHY2PagamZt/3zvUwUm6BTIlMk4o74zP9v8M4opWo9hTHFJs6ep1xJ0I9Icb5q4wy1y
 d7LApH+lyhcrl51WQnPM9UM1+DL792WROmpH6BpFOE70JfjEuZal61Vw==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	srinuvasan <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] recipes-core/ltp: dynamically set Standards-Version for Debian suites
Date: Wed, 12 Nov 2025 11:35:21 +0530
Message-Id: <20251112060521.350022-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 06:02:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20503

From: srinuvasan <srinuvasan.a@siemens.com>

Use the DEBIAN_STANDARDS_VERSION variable to set the Standards-Version dynamically
instead of hardcoding it. This ensures compliance with the current Debian policy,
avoids QA/policy warnings, and prevents the package from being flagged as
unmaintained.

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 recipes-core/ltp/files/debian/{control => control.tmpl} | 2 +-
 recipes-core/ltp/ltp.inc                                | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)
 rename recipes-core/ltp/files/debian/{control => control.tmpl} (94%)

diff --git a/recipes-core/ltp/files/debian/control b/recipes-core/ltp/files/debian/control.tmpl
similarity index 94%
rename from recipes-core/ltp/files/debian/control
rename to recipes-core/ltp/files/debian/control.tmpl
index b43cd6f..0bfc0c2 100644
--- a/recipes-core/ltp/files/debian/control
+++ b/recipes-core/ltp/files/debian/control.tmpl
@@ -3,7 +3,7 @@ Section: embedded
 Priority: optional
 Maintainer: Gylstorff Quirin <quirin.gylstorff@siemens.com>
 Build-Depends: debhelper-compat (= 11), autotools-dev, pkg-config
-Standards-Version: 4.1.3
+Standards-Version: ${DEBIAN_STANDARDS_VERSION}
 Homepage: https://linux-test-project.github.io/
 
 Package: ltp-full
diff --git a/recipes-core/ltp/ltp.inc b/recipes-core/ltp/ltp.inc
index c8f1199..27e26a0 100644
--- a/recipes-core/ltp/ltp.inc
+++ b/recipes-core/ltp/ltp.inc
@@ -18,6 +18,9 @@ SRC_URI = " \
    file://debian \
    "
 
+TEMPLATE_FILES = "debian/control.tmpl"
+TEMPLATE_VARS += "DEBIAN_STANDARDS_VERSION"
+
 do_prepare_build() {
         cp -R ${WORKDIR}/debian ${S}
         deb_add_changelog
-- 
2.39.5



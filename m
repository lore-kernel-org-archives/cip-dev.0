Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6975BC41513
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 05:59:26 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.201450.1697522359846320912
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Oct 2023 22:59:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=hfotEzux;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20231017055916330ef110b26a2f18e4-fvzybj@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20231017055916330ef110b26a2f18e4
        for <cip-dev@lists.cip-project.org>;
        Tue, 17 Oct 2023 07:59:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Ms0DXcwNQS+3sZWZZmXk9SDiswrd2wdcFWdC6Jj1cXQ=;
 b=hfotEzuxX56rY3zbR6CW+ZI04CKKXvoUF/X4qtEYSw3DIczMsCDn8hSf3eChveb1LwClQ3
 QNiXdqGgw2vS8epCWZnepfSFVlICrpotGwTX5wOXSI8krqAjQdkxTag7xK+9xLOyRxWE/boQ
 fha+tBaqcgDL5QZ8/mhRrMWFPe9LE=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/2] Update Isar revision
Date: Tue, 17 Oct 2023 07:59:14 +0200
Message-Id: <d6ebec910bd65b18d0a33abbcf7b57e1ffb8454d.1697522355.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1697522355.git.jan.kiszka@siemens.com>
References: <cover.1697522355.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Oct 2023 05:59:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13399

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings a couple of fixes some downstream users are interesting it.
Therefore, make sure isar-cip-core itself is ready for it.

One adaption is needed because of the factored-out and modified
dpkg-source job. It now filters out binaries from the source package by
default, but we have some in edk2-standalonemm-rpmb. So, drop that
default filter in that package.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml                                       | 2 +-
 recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 84b74414..b255c977 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: dff8ad504b54a4e292a1b986cdc74ebc9e6e177a
+    commit: 30471bb3f787fb0aa822d15e141ecce2f3b99860
     layers:
       meta:
 
diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
index 1a589184..01dcbf99 100644
--- a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
@@ -40,6 +40,9 @@ PV-openssl = "OpenSSL_1_1_1t"
 
 DEBIAN_BUILD_DEPENDS = "bash, python3:native, dh-python, uuid-dev:native"
 
+# edk2-edk2-stable comes with two pre-built .a files that need to be preserved
+DPKG_SOURCE_EXTRA_ARGS = ""
+
 do_prepare_build() {
     deb_debianize
 
-- 
2.35.3



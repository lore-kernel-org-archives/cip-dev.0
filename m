Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B60CDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 05:59:26 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.201449.1697522359801390682
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Oct 2023 22:59:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=QzCKU5+T;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20231017055916de439ade995577b698-cwgdfo@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231017055916de439ade995577b698
        for <cip-dev@lists.cip-project.org>;
        Tue, 17 Oct 2023 07:59:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1YukGsHbi2TLk3bpFa/UQyFmjVQtNP10TkEugf5+Vq0=;
 b=QzCKU5+TE0fFiFI0HyZgZi4OdjfRU0fss7q1ftgcE1lR7/sFlKedh+uNUdzEPILh3cOXrk
 W1L7yQB+0yuQUH+Kp6fe8jh++RUn2wYbdlVCPyK9dUvOYlvo8F3LQ/hKZCCja96i/M8t1pt5
 woCM9WURYVUzekUVLqoVsT7q0Z0hs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/2] dosfstools: Use -native suffix to select the right architecture
Date: Tue, 17 Oct 2023 07:59:15 +0200
Message-Id: <04ea9de0181e72961491f28c294172178efe474a.1697522355.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13398

From: Jan Kiszka <jan.kiszka@siemens.com>

HOST_ARCH is static, not taking cross-compilation mode into account.
Rather than hard-coding the PACKAGE_ARCH, we need to request the -native
version of the tool for the imager. If the latter should switch cross-
building off, the right thing will happen (building of dosfstools for
the target arch).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-common.inc                  | 4 ++--
 recipes-devtools/dosfstools/dosfstools_latest.bb | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 3ae2a3ed..fb5b98d7 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -15,5 +15,5 @@ WKS_FILE ?= "${MACHINE}.wks"
 
 CIP_IMAGE_OPTIONS ?= ""
 
-IMAGER_BUILD_DEPS ?= "dosfstools"
-IMAGER_BUILD_DEPS:remove:buster = "dosfstools"
+IMAGER_BUILD_DEPS ?= "dosfstools-native"
+IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"
diff --git a/recipes-devtools/dosfstools/dosfstools_latest.bb b/recipes-devtools/dosfstools/dosfstools_latest.bb
index ebdf983c..f42ff18a 100644
--- a/recipes-devtools/dosfstools/dosfstools_latest.bb
+++ b/recipes-devtools/dosfstools/dosfstools_latest.bb
@@ -16,9 +16,6 @@ CHANGELOG_V="<orig-version>+cip"
 SRC_URI = "apt://${PN}"
 SRC_URI += "file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=no"
 
-# this is a host tool
-PACKAGE_ARCH = "${HOST_ARCH}"
-
 do_prepare_build() {
 	deb_add_changelog
 
-- 
2.35.3



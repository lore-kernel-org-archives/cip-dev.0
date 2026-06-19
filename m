Return-Path: <benedikt.niedermayr@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B6CCD4F26
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 08:38:44 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38176.1781858319753084213
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jun 2026 01:38:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=benedikt.niedermayr@siemens.com header.s=fm2 header.b=FlPgTLdI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1323861-20260619083836c74508bfb400020784-l3bmua@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260619083836c74508bfb400020784
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Jun 2026 10:38:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=FpWNs3JHPcB4rT3VeDCShEEvT77wvKcEL8COBRRYF6I=;
 b=FlPgTLdICaslBW7YCcKcec/UL9Z4KmK7+xAcP5kdzL1jIP+42pIE7+q43qEWUgdY7Iovoi
 w9FjJAJ9SmO/nlEhitSYOczahPy25tFh2z1WOaCd6Veo/ZjJUTGwRD1i6mgB7PZVgLOxreKp
 Q+9HPrHyOy7fkw9u7Et01fW2Kgs12rKJ1GwCTMGapAOBGYSiDbyAs+7Wj/SJ6V0XGgxWvm/F
 P18NNhkRYwZYfLkXfoVMnm4ZWYtHh1UH484pA7GA7iqWXKnmNZJS0nPvVqZjgf5I0Oh5xAzn
 58aYnbiCEQqYMQUTj5O9t/VHI8eSJKCgZSSkDHWbv/T05a+MmHZwxnTw==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] swupdate: fix compilation
Date: Fri, 19 Jun 2026 10:38:18 +0200
Message-ID: <20260619083820.2252285-1-benedikt.niedermayr@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jun 2026 08:38:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23228

When compiling swupdate the "cross" profile should only be added if
BUILD_ARCH != PACKAGE_ARCH which is already be done in
isar_deb_build_profiles() in the dpkg-base class.

If the "cross" profile is added though, this breaks sbuild builds, since
it will add the host architecture to the barbarian architecture and thus
won't be able to install packages in the host architecture.

Actually this could also be fixed in sbuild itself as well, but setting the
"cross" profile should nevertheless only be done if really required.

This is the error that is fixed with this commit:

| Reading package lists...
| E: The package cache was built for different architectures: amd64 vs
| W: You may want to run apt-get update to correct these problems
| E: The package cache file is corrupted
| E: apt-get dist-upgrade failed

Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
---
 recipes-core/swupdate/swupdate.inc        | 2 +-
 recipes-core/swupdate/swupdate_2023.12.bb | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index 4038e7e38402..b367a96c847a 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -37,7 +37,7 @@ DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
 SWU_SIGNED ?= "1"
 DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"

-# deactivate testing
+# deactivate testing for arm based builds
 DEB_BUILD_PROFILES += "nocheck"

 python do_check_bootloader () {
diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
index 89785b66bf29..a12d22a99bb4 100644
--- a/recipes-core/swupdate/swupdate_2023.12.bb
+++ b/recipes-core/swupdate/swupdate_2023.12.bb
@@ -39,6 +39,9 @@ DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
 # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
 ISAR_CROSS_COMPILE:bullseye = "0"

+# deactivate testing for arm based builds
+DEB_BUILD_PROFILES += "nocheck"
+
 # use backport build profile for bullseye
 DEB_BUILD_PROFILES += "pkg.swupdate.bpo"

--
2.43.0


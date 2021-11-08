Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38B2C433F5
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 13:45:39 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.44964.1636379138285564072
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Nov 2021 05:45:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1A8DjZeW005695
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 8 Nov 2021 14:45:35 +0100
Received: from md2dvrtc.fritz.box ([139.22.43.76])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1A8DjZ0b023136;
	Mon, 8 Nov 2021 14:45:35 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] swupdate: add cross and nocheck to
 build profile
Date: Mon,  8 Nov 2021 14:45:34 +0100
Message-Id: <20211108134534.1866031-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Nov 2021 13:45:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6866

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

During cross compiling for arm the builds fails
with the following message:

```
strip -N main -o /home/builder/swupdate/git/core/built-in.o.tmp /home/builder/swupdate/git/core/built-in.o
strip: Unable to recognise the format of the input file `/home/builder/swupdate/git/core/built-in.o'
make[3]: *** [/home/builder/swupdate/git/test/Makefile:71: test/test_json.lnk] Error 1
m
```

Add cross and nocheck to SWUPDATE_BUILD_PROFILES to avoid
the build error.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v2:
 - Fix commit message

recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
index e62230f..7a0fb9b 100644
--- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
@@ -28,6 +28,8 @@ SRC_URI += "file://0001-debian-Add-option-to-build-with-efibootguard.patch \
 # deactivate signing and encryption for simple a/b rootfs update
 SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
 
+# add cross build and deactivate testing for arm based builds
+SWUPDATE_BUILD_PROFILES += "cross nocheck"
 # If the luahandler shall be embedded into the swupdate binary
 # include the following lines.
 # DEPENDS += "swupdate-handlers"
-- 
2.30.2



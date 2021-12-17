Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E484C433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 15:11:44 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.7265.1639753903067852081
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 07:11:43 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1BHFBevs020612
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 16:11:40 +0100
Received: from md2dvrtc.fritz.box ([139.22.39.215])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1BHFBd8w006742;
	Fri, 17 Dec 2021 16:11:40 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        srinuvasan.a@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] kas/opt/ebg-secure-boot-*: Make
 Backports for OVMF version depended
Date: Fri, 17 Dec 2021 16:11:39 +0100
Message-Id: <20211217151139.1353130-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 15:11:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7186

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

For Debian Buster we need to backport a new version of the OVMF package
with contains the necessary option for secureboot with qemu.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes since RFC:
 - move back to ebg-secure-boot-snakeoil.yml

 kas/opt/ebg-secure-boot-snakeoil.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 9f3eae9..5aa5eff 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -33,6 +33,7 @@ local_conf_header:
     IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
 
   ovmf: |
-    # snakeoil certs are only part of backports
-    DISTRO_APT_SOURCES_append = " conf/distro/debian-buster-backports.list"
-    DISTRO_APT_PREFERENCES_append = " conf/distro/preferences.ovmf-snakeoil.conf"
+    # snakeoil certs are only part of backports, for Debian 11 and later the are not necessary
+    OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
+    DISTRO_APT_SOURCES_append_buster = " conf/distro/debian-buster-backports.list"
+    DISTRO_APT_PREFERENCES_append_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
-- 
2.34.1



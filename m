Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99203C636D4
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 15:06:16 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.16648.1675350372136534435
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 07:06:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=RT2YAr8V;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20230202150608d19528f48e10f8b29e-qakjbk@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230202150608d19528f48e10f8b29e
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Feb 2023 16:06:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=7yZLu59VouX7kixz50r3/jN9LxuxS1iYS1xjU2oox1E=;
 b=RT2YAr8VatkybcnCBdglfnfeCYIU68RnBFIRmyQE/rUXeOjEwVBPyC8WkuSixUqSUmWEOr
 LxUFAo1Dc9jsRhSM6BMtN4HzV0GBWYRIOcl7EB/Og5tS/r4QhHZPQco4Wl3DiyvxHoBdcnde
 lqpYtkiFTnVleinBHvXsvK7x6/zdw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] conf/distro: Use cip prefix and snapshot postfix for sid lists
Date: Thu,  2 Feb 2023 16:06:07 +0100
Message-Id: <20230202150607.824537-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 15:06:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10568

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is done to avoid infecting other layers with the snapshot version.

Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-sid-ports.conf                             | 1 +
 .../{debian-sid.list => cip-debian-sid-ports-snapshot.list}     | 0
 .../{debian-sid-ports.list => cip-debian-sid-snapshot.list}     | 2 +-
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename conf/distro/{debian-sid.list => cip-debian-sid-ports-snapshot.list} (100%)
 rename conf/distro/{debian-sid-ports.list => cip-debian-sid-snapshot.list} (81%)

diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
index 0b369bb..5f41bfb 100644
--- a/conf/distro/cip-core-sid-ports.conf
+++ b/conf/distro/cip-core-sid-ports.conf
@@ -14,3 +14,4 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
+DISTRO_APT_SOURCES = "conf/distro/cip-debian-${BASE_DISTRO_CODENAME}-ports-snapshot.list"
diff --git a/conf/distro/debian-sid.list b/conf/distro/cip-debian-sid-ports-snapshot.list
similarity index 100%
rename from conf/distro/debian-sid.list
rename to conf/distro/cip-debian-sid-ports-snapshot.list
diff --git a/conf/distro/debian-sid-ports.list b/conf/distro/cip-debian-sid-snapshot.list
similarity index 81%
rename from conf/distro/debian-sid-ports.list
rename to conf/distro/cip-debian-sid-snapshot.list
index bf0f7a2..46d34d7 100644
--- a/conf/distro/debian-sid-ports.list
+++ b/conf/distro/cip-debian-sid-snapshot.list
@@ -1,2 +1,2 @@
-deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian-ports/20220925T001806Z sid main
+deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
 deb-src	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
-- 
2.39.1



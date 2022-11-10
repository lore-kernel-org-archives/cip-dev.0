Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EF5C433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 12:45:10 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web09.6908.1668084308965975399
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 04:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=m2Oj88FQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2022111012450622e3a45e1f06f47227-hq9i7g@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2022111012450622e3a45e1f06f47227
        for <cip-dev@lists.cip-project.org>;
        Thu, 10 Nov 2022 13:45:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=gRE+dbT8JTLDs4DcYE/yFUvLGYoPZLZvE2njMrxs2ww=;
 b=m2Oj88FQYxgORCxaxbyYm/xHeoHPmvs40cWJQBeMB1gtkijSw/aKC0H+pQHz4jLOGFn1hE
 YB9ToBZj7xgdylU1oi5ysEnuayUkjHq1AXOyGUi3a8eQx1fP3J2k6yuDQ6hvzLbzQTGeNjag
 GzP9AM4EE63CL4vX1Fgx4uwUIXPdo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 3/5] swupdate-handler-roundrobin: add uuidcheck patch
Date: Thu, 10 Nov 2022 13:45:01 +0100
Message-Id: <20221110124503.274124-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 12:45:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10002

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch adds a pre/post function to the swupdate-handler
roundrobin to compare the uuid parameter from the sw-description
with the uuid of the current system to avoid a updating with
the same image and breaking the update cycle.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...-add-uuidcheck-to-roundrobin-handler.patch | 43 +++++++++++++++++++
 .../swupdate-handler-roundrobin_0.1.bb        |  3 ++
 2 files changed, 46 insertions(+)
 create mode 100644 recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch

diff --git a/recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch b/recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch
new file mode 100644
index 0000000..f2392f4
--- /dev/null
+++ b/recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch
@@ -0,0 +1,43 @@
+From f093a3a097e518ef9f74ff88eafa9259ba50626f Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Tue, 8 Nov 2022 16:08:25 +0100
+Subject: [PATCH] add uuidcheck to roundrobin handler
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ swupdate_handlers_roundrobin.lua | 22 ++++++++++++++++++++++
+ 1 file changed, 22 insertions(+)
+
+diff --git a/swupdate_handlers_roundrobin.lua b/swupdate_handlers_roundrobin.lua
+index bf9c997..bb24fc7 100644
+--- a/swupdate_handlers_roundrobin.lua
++++ b/swupdate_handlers_roundrobin.lua
+@@ -726,3 +726,25 @@ function pp_mmclock(when, device, image)
+     swupdate.info("%s: %s MMC device %s", logprefix, when == WHEN.PRE and "Unlocked" or "Locked", device)
+     return true
+ end
++
++function pp_uuidcheck(when, uuid, image)
++    local filename = "/etc/os-release"
++    local filehandle = io.open(filename, "rb")
++    if not filehandle then
++      swupdate.error("%s: Cannot open file %s", logprefix, filename)
++      return false
++    end
++    osrelease = filehandle:read("*a")
++    filehandle:close()
++    image_uuid = string.match(osrelease, "IMAGE_UUID.*")
++    if not image_uuid then
++      swupdate.error("%s: Cannot find IMAGE_UUID in %s", logprefix, filename)
++      return false
++    end
++    swupdate.debug("%s: %s", logprefix, image_uuid, uuid)
++    if string.find(image_uuid, uuid, 1, true) then
++      swupdate.error("%s: Update already installed.", logprefix)
++      return false
++    end
++    return true
++end
+-- 
+2.35.1
+
diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index 65cd652..447a093 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -13,8 +13,11 @@ inherit dpkg-raw
 PROVIDES = "swupdate-handlers"
 
 SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
+SRC_URI += "file://0001-add-uuidcheck-to-roundrobin-handler.patch"
 SRCREV_swupdate-handler-roundrobin ?= "fbc8d8a7e4ae8c381198cab81ae3fb13398a028e"
 
+S="${WORKDIR}/${PN}"
+
 SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 
 SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
-- 
2.35.1



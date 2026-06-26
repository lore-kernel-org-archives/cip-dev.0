Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FA8C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 15:20:58 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37652.1782487251193610980
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2026 08:20:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=uct3BWIy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20260626152047fc8859fc09000207e5-k2dvjy@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260626152047fc8859fc09000207e5
        for <cip-dev@lists.cip-project.org>;
        Fri, 26 Jun 2026 17:20:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=1QpNNijBckafwU0S2uYA1LrBpaZM2LB4H4MCV5qUnq8=;
 b=uct3BWIyX0atCO+1dq404bkITTEklgtVVy96DxAb0pHLUQccsaSf/M1jHdypUuC1Gk9vxi
 1V3Nli87XM1p3MOilSkEQiEn5O0Ajr24JhhbRKupGIgkIiWeSnsOBg+73I+S8lzF2hf4FYvI
 cZXTsTsWN0WE5rELEEDdkqhRTHrjOqVlw6GuLy8qFZNYR6i2e+DIh2VbrY6E1xd5p5mwXLfy
 7ubYp0TlW3McSBevYlBL9yREtnBD/gxFsldwr9uM/LlBPXCdbWC/AXKhE02ovFUWcCT9svbk
 /+8IRe2S3qaE/7BZAgovPWo+MG5kCoZCgXbHVY+2LXayoIWPE5EpZLhg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] swupdate-config: Set DPKG_ARCH to any
Date: Fri, 26 Jun 2026 17:19:37 +0200
Message-ID: <20260626152038.103044-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jun 2026 15:20:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23283

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids the following error.

| Building dependency tree...
| Reading state information...
| Package swupdate-config is a virtual package provided by:
|   swupdate-config-qemu-riscv64 0.2
|   swupdate-config-qemu-arm64 0.2
|
| E: Package 'swupdate-config' has no installation candidate

This solution works in this case, but to confirm with the Debian
standard we would need to add a conflict to all other versions of
this packages.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../{swupdate-config_0.2.bb => swupdate-config_0.3.bb}         | 3 +++
 1 file changed, 3 insertions(+)
 rename recipes-core/swupdate-config/{swupdate-config_0.2.bb => swupdate-config_0.3.bb} (90%)

diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.3.bb
similarity index 90%
rename from recipes-core/swupdate-config/swupdate-config_0.2.bb
rename to recipes-core/swupdate-config/swupdate-config_0.3.bb
index b48e3d1..013b957 100644
--- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
+++ b/recipes-core/swupdate-config/swupdate-config_0.3.bb
@@ -19,6 +19,9 @@ DEBIAN_PROVIDES := "${PN}"
 
 PN .= "-${MACHINE}"
 
+# architecture specific package as it depends on the machine
+DPKG_ARCH = "any"
+
 SRC_URI = "file://swupdate.cfg \
            file://hwrevision.tmpl"
 
-- 
2.53.0



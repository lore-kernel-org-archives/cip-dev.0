Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922CCC43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 16:33:48 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38922.1782491622497837252
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2026 09:33:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=sV7xyQTM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20260626163339fde917d0cb000207f7-ugdnu_@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260626163339fde917d0cb000207f7
        for <cip-dev@lists.cip-project.org>;
        Fri, 26 Jun 2026 18:33:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=zsjpJoISstmsO3PvnYu8UaB4z4Dw3VKtAkXdO+um0uo=;
 b=sV7xyQTMgXhLr4qvSSF+E1+74yQeZtbegL9qwKG5Vjfkvx/2ljaaGd+guoinnonCjXgJt1
 5tHtBPPTMjnjVQDADWNk81+J6ESidqcEQxqqKzpoLZkeN9M+4GPdB7iyCDEU8TZpGwLjAIam
 UTUPi3PRGv3TaGoWkontSC6CvzXOyrqaKZYOgf6GR6IenYcYSdBEWRLCI+qDPMzjJE/Vk+6T
 XfIf7ZgVfgljUosMUXr6x6Xn4seA0lNkHritjV5on/guZxjGQMDtfc8CYiqDQ1G0xiNBG7UZ
 ejypTi1nyAttaDmEVl14lBNlpwRqe1c717LUFymoux4KDzytn3N3dkaA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] Add missing MACHINE to install swupdate-config*
Date: Fri, 26 Jun 2026 18:33:12 +0200
Message-ID: <20260626163330.523726-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jun 2026 16:33:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23286

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an issue when building swupdate-config* for two different
architectures, for example arm64 and riscv64.

The reason is that both package are ARCH all and provide the virtual
package `swupdate-config` which leads to the following error during
installation in the rootfs with Debian sid:

| Building dependency tree...
| Reading state information...
| Package swupdate-config is a virtual package provided by:
|   swupdate-config-qemu-riscv64 0.2
|   swupdate-config-qemu-arm64 0.2
|
| E: Package 'swupdate-config' has no installation candidate

To be compliant with the Debian standard the conflict field is missing.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

v1 was 'swupdate-config: Set DPKG_ARCH to any'

Changes v2:
 - set explict recipe name in image creation
 - remove DPKG_ARCH setting in swupdate-config

 recipes-core/images/swupdate.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 00e972e..006d622 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -59,7 +59,7 @@ IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFB
 
 WFX_URL ??= ""
 # check for wfx url to enable support for wfx backend based updates
-IMAGE_INSTALL:append = "${@' swupdate-config-wfx' if d.getVar("WFX_URL") else ''}"
+IMAGE_INSTALL:append = "${@' swupdate-config-wfx-' + d.getVar("MACHINE") if d.getVar("WFX_URL") else ''}"
 
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
-IMAGE_INSTALL += " swupdate-config"
+IMAGE_INSTALL += " swupdate-config-${MACHINE}"
-- 
2.53.0



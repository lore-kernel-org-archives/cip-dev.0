Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76668D767D6
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:33:58 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14147.1766140433535131383
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 02:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=CthpHHep;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-202512191033512104efc57c000207b0-hfnlgr@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202512191033512104efc57c000207b0
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Dec 2025 11:33:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=jxQa8yTtrXAHNg/W94ALz/Iz99zmLGTQPL4ZaDa+hDk=;
 b=CthpHHepJSZJJhnutBXXsH/OQ8QsJemi9I7UcX5gGF+8wYVjWcP5VJmJ7Lr4cozUO7Fxc8
 zE7487//xHe9coAQlQ3dKPMKy9mWMajumqMMs9f3ANrn3FACHeoCbZcCUMFaoKnJz2HJBurt
 EI1tZwCP4wHl0GWOb8P3snG/2fKGorTer9RPArYTEhF44qO/1VJaGhkmXBJtfYzdmuHrb0kQ
 bXXdGN1ZmzTZoqzzFO89SJH6nlCzJglmRJtXKo10xYH/8CCws7dER8VVGpo0+9LQcdlJrF0u
 4O4dHZL1w/3b8stYvk6C7PhuaK7dPr9CHQUaI0lZM7RqobgXFLKakZAA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 5/6] Add swupdate-config to swupdate.inc
Date: Fri, 19 Dec 2025 11:31:25 +0100
Message-ID: <20251219103349.1227710-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
References: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 10:33:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21168

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids installing all components and miss the swupdate
configuration.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/customizations/common.inc | 2 --
 recipes-core/images/swupdate.inc       | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index 37872c1..bc51402 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -27,14 +27,12 @@ TEMPLATE_FILES += "postinst.tmpl"
 TEMPLATE_VARS += "CUSTOM_HOSTNAME"
 
 DEPENDS += "sshd-regen-keys change-root-homedir"
-RDEPENDS:append:swupdate = " swupdate-config"
 
 DEBIAN_DEPENDS = " \
     ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
     change-root-homedir \
     ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
 	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
-DEBIAN_DEPENDS:append:swupdate = ", swupdate-config"
 
 do_install() {
 	install -v -d ${D}/etc/network/interfaces.d
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 30b4ecf..a6a9082 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -59,3 +59,4 @@ IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE
 IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
 
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
+IMAGE_INSTALL += " swupdate-config"
-- 
2.51.2



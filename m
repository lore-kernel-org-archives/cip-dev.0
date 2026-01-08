Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE2BD1D473
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 15:17:02 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8641.1767885418129901656
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 07:17:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=U8XRQ8TJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2026010815165909d6862744000207e0-qrjhb_@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026010815165909d6862744000207e0
        for <cip-dev@lists.cip-project.org>;
        Thu, 08 Jan 2026 16:16:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=oxOfFYtuNwAYBoezIqy4zAzjL7AYXC3/p0YoHNYD2WE=;
 b=U8XRQ8TJL88o+6OPryVo/rRrC6Q/qov1Jc+Se45tLQcN/Roql/yfJUpwlswlAJE1IYw0dK
 DT2suhmpdhczBtxSpbM1CXYYLK5whmAWkN/5chhknn2mFvKLyPl07BLW9Ag2d0cXPjTFYsKK
 oupgHKOtdFyNHaNSkOYAoUV/4fU15DiXcWPlVXfmGxdQrb91l6FEclPqD2tYG1ynOKmnEVtq
 Hl/eCmWzaZzhcCOH0WvXN82TsLJueSHQeKNl+myf6PCRRo1jEYFC5arKLpB/Fi6czvBp34lv
 heUgEaeoCZU2jTxxkUjJ/j5VK+l/Rj7MhJUzFwzy4Ky4egI+V6JzHehw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	benedikt.niedermayr@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 5/7] Add swupdate-config to swupdate.inc
Date: Thu,  8 Jan 2026 16:16:12 +0100
Message-ID: <20260108151650.124306-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
References: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 15:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21486

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/customizations/common.inc | 4 +---
 recipes-core/images/swupdate.inc       | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index 37872c1..c4d201f 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2022
+# Copyright (c) Siemens AG, 2019-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
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
index b2fe4ac..7cd816a 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -58,3 +58,4 @@ IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE
 IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
 
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
+IMAGE_INSTALL += " swupdate-config"
-- 
2.51.2



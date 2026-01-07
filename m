Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9878DCFD636
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:27:25 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5659.1767792443619009525
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 05:27:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=TdZPO+W2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20260107132717299c7879740002070d-sy5uwz@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260107132717299c7879740002070d
        for <cip-dev@lists.cip-project.org>;
        Wed, 07 Jan 2026 14:27:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=l5yXt65pPkmLl3jl/wtNxjypAEJQUjtYMTAiMvwcQSw=;
 b=TdZPO+W2QrcOqdBEhJa0dy/lV+/VQKWI60EoL5WqvkyCPusI7E+IHYX4DVUvNK4VNtySb7
 FH4MyiFhRm2S2H0F65c9uq/LeGt2djlbu3QA1ngO7Dmj6+0JR/fMgtDMoqpyzRWTOtUZRjBd
 haJPpzBQ0OaTcKsBvRiUUP9MZFm8tAJuInzh2rdJzE+TTmEczXarI2YoSif1M7OBvpP113/X
 xjoBoTafp6Y8VV3qYSAdvXtpQ8Vs78emJf2q2ZmUlPeg7olGfcZGon/utnURs0D22imRINbZ
 O9Qk6TR6gDyd3Hr6YVZfAPWdhl3m2xvVpJJHd5z4U+UWw+PfA05o36vg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 5/7] Add swupdate-config to swupdate.inc
Date: Wed,  7 Jan 2026 14:26:28 +0100
Message-ID: <20260107132707.733180-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
References: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 13:27:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21404

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

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
index fa35458..6fcf06e 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -58,3 +58,4 @@ IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE
 IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
 
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
+IMAGE_INSTALL += " swupdate-config"
-- 
2.51.2



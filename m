Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FDFCF8555
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 08:17:44 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29236.1763623635975565868
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 23:27:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gourav.singh.ext@siemens.com header.s=fm1 header.b=mxc2HsUA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1333022-20251120071707818ed3208800020727-mbnzwu@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251120071707818ed3208800020727
        for <cip-dev@lists.cip-project.org>;
        Thu, 20 Nov 2025 08:17:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gourav.singh.ext@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=SASVulIPYcbpsyDu03+7TGtsAVJZJW+PxEZf/wWldyY=;
 b=mxc2HsUAfenO4OjOKAObejvTbeSCSNUxDALyCpW0C8QxPAaODxLmxZC2wZ1S2AENo4tcm5
 cm736rKcaMidRid8EpY/EAN+E22+wxW1cMC2hyriS2yEKgggoj8DZRyN6njxqTgdYUIhE8ti
 sOdeiVaxIXC2XQjfCPo6+XcEK8FDTPAXLDKGOBhYx8NpC0LwTFk7dW/m3X7hCt5nRdkqiSvW
 Ci3vVJntj0cN4/BblsicswkFRoWW8wnmek+zC7RnqC6d3ZFrIXxJGJRgPYBSRO8Ln9sov87H
 iGbchjH/y1wO4IqDCDi7ARcMqzh8w7J2ESKebM71Hk230zuYkfuVBSXg==;
From: Gourav Singh <gourav.singh.ext@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gourav.singh.ext@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/2] fix(security): syntax error breaking build on Buster and Bullseye
Date: Thu, 20 Nov 2025 12:46:52 +0530
Message-Id: <20251120071653.606694-1-gourav.singh.ext@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 08:17:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20635

A missing backslash in the PAM_CONFIG string was causing the `sed`
command to fail during the build process. This issue affected Debian
Buster and Bullseye security images, which use `libpam-cracklib`.
The backslash has been added to ensure correct string parsing and
resolve the build failure.

Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
---
 recipes-core/security-customizations/files/postinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index 15be659..f8ebf9e 100755
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -34,7 +34,7 @@ PAM_AUTH_FILE="/etc/pam.d/common-auth"
 # pam_tally2 is deprecated from pam version 1.4.0-7
 if readlink -f /lib/*-linux-gnu*/security/pam_tally2.so; then
        PAM_MODULE="pam_tally2.so"
-       PAM_CONFIG="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60
+       PAM_CONFIG="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
                  \naccount required pam_tally2.so"
 elif readlink -f /lib/*-linux-gnu*/security/pam_faillock.so; then
        PAM_MODULE="pam_faillock.so"
-- 
2.39.5



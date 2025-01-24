Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE73C0218D
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 08:07:10 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.6956.1737706022675200984
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 00:07:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=RHOOn0if;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20250124080700085cb0ffd3be50822e-qu82sw@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250124080700085cb0ffd3be50822e
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jan 2025 09:07:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=8EE8GkAjrs7dRjk7QPm23JwUuXsPA9/kJ9eSVTAAp7c=;
 b=RHOOn0ifTzx7+pIbYsz2PX4Xiew3XEemquioR6eeEVR2qhmWt4eLEnLNwjD3XNidJtRUIz
 LmwsWjm+pexMEgNWp+vg3qcCw3Uwgl115v+Q7mN3n5Vc6OUS1sk6XLTS5fYXicO5rzL86EnE
 oHBmnhS79djuY9ySUs77wsF19x6XMxf/TOlzXE1kE96DhKKvj7nAmGyEuAElhm09WerhYX7x
 r/JobV2MKYxhM2gf0LpF3RM1JriIwukocEtUOEN/7BJod1ZcfzM4gejLxpxYlqsnyvjW9A6W
 KN5GwCKIX6E7r/vRke5gIbgax75S9kbKGR5o3fRYmWnKHVYKYC8tYjiw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 3/3] customizations-security: add curl to download LAVA overlay
Date: Fri, 24 Jan 2025 09:06:27 +0100
Message-ID: <20250124080659.469424-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250124080659.469424-1-Quirin.Gylstorff@siemens.com>
References: <20250124080659.469424-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 08:07:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17619

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Lava generates an directory, in LAVA called overlay, which contains
all scripts and tests of the test stage. The Device-under-test
needs to be instrumented with with this overlay.  LAVA provides the
possibility to download the overlay via http or NFS. We use curl
to download to the overlay from a http server.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/security-customizations/security-customizations.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
index 75a6a99..9fbc2a5 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -18,7 +18,7 @@ SRC_URI = "file://postinst \
            file://ssh-pam-remote.conf"
 
 DEPENDS = "customizations sshd-regen-keys"
-DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd"
+DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd, curl"
 
 # Package names based on the distro version
 DEBIAN_DEPENDS:append:buster = ", libpam-cracklib"
-- 
2.47.0



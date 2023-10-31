Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8A6C4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 08:49:49 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.182060.1698742187162610669
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Oct 2023 01:49:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=O+yBh7x9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20231031084945abdcd5937c79bb22f5-t9o4vd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231031084945abdcd5937c79bb22f5
        for <cip-dev@lists.cip-project.org>;
        Tue, 31 Oct 2023 09:49:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=DpJ5enxTStm0JqVPfSab2POrhUxiD+dzpPTvVi48S5I=;
 b=O+yBh7x9sWkugLgH98PtuJJ3tn7kINLpDoSdySUF4pehG1p+NNm/OKIhdWAHSQSZ2PVWVS
 D7XSMhKQIgOIcEn/8+x4pmrSoGyzogrhIBTPBZ/JP8B6L8Z/9ojE43hh+qC6RKoEj55Yj3cK
 aMwIC8aAE90sES/lEsSzNWJ4y1kq8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC v2 5/9] security-customizations: Fix shell error
Date: Tue, 31 Oct 2023 09:37:39 +0100
Message-ID: <20231031084943.3105056-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
References: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Oct 2023 08:49:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13497

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

if [ -f ... ] does not work with globbing.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/security-customizations/files/postinst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index bbd21bd..717b7ac 100755
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -32,11 +32,11 @@ fi
 # Lock user account after unsuccessful login attempts
 PAM_AUTH_FILE="/etc/pam.d/common-auth"
 # pam_tally2 is deprecated from pam version 1.4.0-7
-if [ -f /lib/*-linux-gnu*/security/pam_tally2.so ]; then
+if readlink -f /lib/*-linux-gnu*/security/pam_tally2.so; then
        PAM_MODULE="pam_tally2.so"
        PAM_CONFIG="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60
                  \naccount required pam_tally2.so"
-elif [ -f /lib/*-linux-gnu*/security/pam_faillock.so ]; then
+elif readlink -f /lib/*-linux-gnu*/security/pam_faillock.so; then
        PAM_MODULE="pam_faillock.so"
        PAM_CONFIG="auth   required  pam_faillock.so preauth silent  deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
                \nauth   required  pam_faillock.so .so authfail deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
-- 
2.42.0



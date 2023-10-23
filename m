Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88B2C25B44
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 15:02:51 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.123305.1698073370104406094
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Oct 2023 08:02:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=RQeAibtr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202310231502475697aa21d7b195a367-1mltm0@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202310231502475697aa21d7b195a367
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Oct 2023 17:02:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=DpJ5enxTStm0JqVPfSab2POrhUxiD+dzpPTvVi48S5I=;
 b=RQeAibtrP7NQ+SSNtdXq0iIrDbM4nXDVGwRgb6wEK1GLAUNfVReVs59ZW8X13URGsAndgJ
 e6qf/igYB3K8Gv5fsDYJ9PnWtqOE/apEcpieY/h1mkk8gmCJx61J2T04IxZ/VQN/IGthLV1J
 UY2RahgRpu/HPNALzQvU7Pvm8+bMY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC 5/9] security-customizations: Fix shell error
Date: Mon, 23 Oct 2023 17:00:03 +0200
Message-ID: <20231023150243.3990309-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Oct 2023 15:02:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13440

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



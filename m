Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2180C44512
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 13:09:25 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12540.1784207358287663052
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 06:09:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=lsit3YRH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20260716130920dcca6fd1e700020783-f_udgr@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260716130920dcca6fd1e700020783
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Jul 2026 15:09:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zXktCmn6iD72vqpmG4lhCx5kenFmHe/cjsp1aFZKoUw=;
 b=lsit3YRHAD8GVa4wTcpka26aYY4bsc2kx7Z2rl2KNAjeNtQzQBuPTLHd/zRAPvOZ+RyyGQ
 qKKkrMCf9IiV9ttBWJcd3eAT/IVrP8PGyvvnzH2jd/c3oT+bCBlIgKF2Sj5vyQ+NwFYtUJci
 v3fLI0EYeBqvRzyyAcNaAXG9GKj5B/VZ1V6kjAstR7G8xjwXT9c7NfId2FdgJKGcXfqhR4Uw
 PhrlFWngIscYkjWe/vHuoj6OvSjpinfMPhGIEFcYqDehLQEPlIKye8IPZP4Dg1yFETUtxUAE
 J1ee+lk9A/lnk1P/9x8flhE5BYYA3TszVUMZkEwzF4xOje/cfyJZolNg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 3/3] verity.bbclass: exclude unit information from verity data
Date: Thu, 16 Jul 2026 15:07:44 +0200
Message-ID: <20260716130816.1095792-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260716130816.1095792-1-Quirin.Gylstorff@siemens.com>
References: <20260716130816.1095792-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 13:09:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23624

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

In newer versions of cryptsetup (see https://gitlab.com/cryptsetup/cryptsetup/-/commit/f8788f347ebfa5ba5df860b2c599e66f312a0693) the unit of the data and hash blocks is
displayed, e.g. in case of the default bytes. To avoid the following
error during opening a verity partition with the collected metadata
remove the unit information.

```
veritysetup: invalid numeric value
```

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/verity.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/verity.bbclass b/classes-recipe/verity.bbclass
index c3b89ec..56e4f4e 100644
--- a/classes-recipe/verity.bbclass
+++ b/classes-recipe/verity.bbclass
@@ -63,7 +63,7 @@ create_verity_env_file() {
     while read KEY VAL; do
         printf '%s=%s\n' \
             "$(echo "$KEY" | tr '[:lower:]' '[:upper:]' | sed 's/ /_/g')" \
-            "$(echo "$VAL" | tr -d ' \t')" >> $ENV
+            "$(echo "$VAL" | tr -d ' \t' | sed -e 's/\[.*\]//' )" >> $ENV
     done < $input
 }
 
-- 
2.53.0



Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA1B1090246
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 15:49:22 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14512.1773935349279162908
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2026 08:49:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Xcbnb68n;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20260319154906639feefdc60002072d-iatj8g@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260319154906639feefdc60002072d
        for <cip-dev@lists.cip-project.org>;
        Thu, 19 Mar 2026 16:49:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=uVRugRpLeprdHN4wM8k+wINdAgyQlQ4xOlET9zRjw/k=;
 b=Xcbnb68nqWNV17dh8li9RAHrdDcYpS08S4mD+bFf8ChhWOWcdKOpoHcJIGwwxnpQaeJ0AI
 jmMu9+57UqlocGHBiW7MmsPxQH6Vcugakgyi4LFRuecZ+BzHz7/B+5IwId1BV1CyUqN1tWtQ
 azpvG+x5bI9wHuSE30+ehmM3gmEzrtfwzh/Kna45wAuNsFE+6a7AGdmdv7VsZVHNbXn3ljXg
 BYDJ0yhtGW6oWA6mcCPVObA/T+sxaHM5d3uFNYVgm2f1hAVD1wdFJx79raItFNzCcQ5TxXYp
 zrHIFtnZ1mKkVGXFyGsFtV8D0Y0Udaa0YeTf35xSibWgde1FEtrb/a8Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Set owner for reproducible swus
Date: Thu, 19 Mar 2026 16:48:35 +0100
Message-ID: <20260319154905.2525216-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2026 15:49:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22510

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids leaking of build information and allows to reproduce the
swu on multiple machines.

Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
index d92d55f..8e90169 100644
--- a/classes-recipe/swupdate.bbclass
+++ b/classes-recipe/swupdate.bbclass
@@ -292,7 +292,7 @@ IMAGE_CMD:swu() {
                     esac
                 fi
             done | cpio \
-                --verbose --dereference --create --reproducible --format=crc \
+                --verbose --owner $(id -u):$(id -g) --dereference --create --reproducible --format=crc \
                 > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
 EOIMAGER
     done
-- 
2.53.0



Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4AF1093180
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 07:56:01 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7573.1773993358747039586
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Mar 2026 00:55:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=cv/7a+vE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2026032007555462c7453cb0000207ad-9hwahv@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026032007555462c7453cb0000207ad
        for <cip-dev@lists.cip-project.org>;
        Fri, 20 Mar 2026 08:55:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=dKuzc7Woh9+siNgwHhNylCqx0/wXrtHeFMM1NcAIjC0=;
 b=cv/7a+vEJiwV9wFH03Y80ZV5SIzQUUEiQJfIAaxvMRiLdzY23RJcY3S4WgmdpLIAwT/NLz
 VjPBpGt3k8tJDgwhCrI9McZ7spC25JgdxjShudVbQQ2IpoBLNRH+IB11q6f0VtTKNUjm06jC
 rB586ISPdK9K1492tF3RxXBhF0otNJ6oK5n5+5xNJnYoaLQVO8KK/H+GpmDYvLuXInhGS8wx
 30A7Gz1mAPJusjriRUoPK/t0/2zq2ODDwvLVO9gnBVRuJb2h6oAwNJeWn1xXcLTuaEz3QLvP
 hLXxFj9RAQZypnd0uw6ypnZYpKgM8bojov9FvFh+gNT5LurtJmyTJl/g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] swupdate.bbclass: Set owner for reproducible swus
Date: Fri, 20 Mar 2026 08:55:27 +0100
Message-ID: <20260320075546.2535828-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2026 07:56:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22514

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids leaking of build information and allows to reproduce the
swu on multiple machines.

As the code is execute in the context of 'imager_run' the owner is always
0:0.

Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v2:
 - use 0:0 directly without id to simplify. No impact as due to
   run_image the owner is always root.

 classes-recipe/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
index d92d55f..b5b5273 100644
--- a/classes-recipe/swupdate.bbclass
+++ b/classes-recipe/swupdate.bbclass
@@ -292,7 +292,7 @@ IMAGE_CMD:swu() {
                     esac
                 fi
             done | cpio \
-                --verbose --dereference --create --reproducible --format=crc \
+                --verbose --owner 0:0 --dereference --create --reproducible --format=crc \
                 > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
 EOIMAGER
     done
-- 
2.53.0



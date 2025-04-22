Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101A2C369DC
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 14:51:07 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.41958.1745333458611589936
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 07:50:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=Lo1IvIPH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202504221450563bdc5a49de09cb823f-hp6yqr@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202504221450563bdc5a49de09cb823f
        for <cip-dev@lists.cip-project.org>;
        Tue, 22 Apr 2025 16:50:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dnlAxHriHrhBvE/6+hQ/463jlKZx08k6rnwsoRbv59M=;
 b=Lo1IvIPHW2Ln/Z9GMLiHynsWulCBTZznaAOA9o2poga0Psx/+5PmEqu38vKGKMwhzt2yo4
 /2Ng/QsCJh4MXwawTgngZg/+MqkD+pvsioSEA/15SzMwHWyxsG7ijJWfBXFXxzHFIoR+gsE7
 UQgbuwOq9SufYUOSs+8CxBf6K+5X/c0d+eCzwzhIzkYOtke16H5/LagwBEaTCiiNx7VtvlBO
 94kFaCofQjZ+PSUwjaHt0eFNRJWvJ5FrhiDA2NLxRQRr/rTP8aTbhKND0/vOAmcRHiNjvwCd
 Bzj2cmEQMgVt7nvzyqr8wn4ftOaq83YmoZrb+vq0gTHo4YIoqDqfePCA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 4/5] wic(ebg): reduce search to generate the verity environment
Date: Tue, 22 Apr 2025 16:35:25 +0200
Message-ID: <20250422145055.1095348-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
References: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 14:51:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18559

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If multiple *.verity.env are available it is possible to select
incorrect verity information.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 941634a..c3098dd 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -155,10 +155,11 @@ class EfibootguardBootPlugin(SourcePlugin):
         verity_sd_keys = ["data-block-size", "hash-block-size", "data-blocks",
                           "hash-offset", "salt", "uuid", "hash"]
         opts = {}
+        image_basename = get_bitbake_var("IMAGE_BASENAME")
         deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
         verityenv = None
         for file in os.listdir(deploy_dir):
-            if fnmatch.fnmatch(file, '*.verity.env'):
+            if fnmatch.fnmatch(file, f'{image_basename}*.verity.env'):
                 verityenv = os.path.join(deploy_dir, file)
                 break
         if not verityenv:
-- 
2.47.0



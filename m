Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908E6C4167D
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 08:49:49 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.182065.1698742188416570026
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Oct 2023 01:49:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=cdmm9DLG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20231031084946ed8281284b9489ef69-srpcry@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231031084946ed8281284b9489ef69
        for <cip-dev@lists.cip-project.org>;
        Tue, 31 Oct 2023 09:49:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=nMbM3+ayTDWkq3ePJRp1e1khVw270YqiABTsAvFuPM0=;
 b=cdmm9DLG2RIMSm2gD29dlcd5OgT9cXU0baVOviGxApVO7XOPqosj9bUFh6ujSD0YJYMBLF
 WQh/9Sn2x/wWDAhsk8pAEG2JggTngUsAIRCNjGVVBogl1I61JR+MCPJhH7/znUPCyY0lwtmL
 LUzc6jeZjvaxfX+uZqrSzq8Wzi/xc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC v2 9/9] kas/opt/reproducible.yml: Move SOURCE_DATE_EPOCH to layer.conf
Date: Tue, 31 Oct 2023 09:37:43 +0100
Message-ID: <20231031084943.3105056-10-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13504

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This ensures that all images are build reproducible.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/layer.conf          | 2 ++
 kas/opt/reproducible.yml | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 2c888b2..82b4084 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -24,3 +24,5 @@ LAYERDIR_cip-core = "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
 
 IMAGE_CLASSES += "squashfs verity swupdate"
+
+SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
index 5d6a896..bc71f28 100644
--- a/kas/opt/reproducible.yml
+++ b/kas/opt/reproducible.yml
@@ -13,5 +13,4 @@ header:
 
 local_conf_header:
   reproducible-builds: |
-    SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
     WIC_DEPLOY_PARTITIONS = "1"
-- 
2.42.0



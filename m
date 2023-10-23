Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33DDC25B45
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 15:02:51 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.123302.1698073368080723669
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Oct 2023 08:02:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=kCc2AZ0n;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20231023150249cbb911ddbbb73d7a76-oiepex@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231023150249cbb911ddbbb73d7a76
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Oct 2023 17:02:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=nMbM3+ayTDWkq3ePJRp1e1khVw270YqiABTsAvFuPM0=;
 b=kCc2AZ0nZhvsn+7tur44nH+ZcWs/zKrOXz0R6RZdT6XtuhrziD5FDoU2z1q+XvLoCFAsZz
 Rr2vvaOoQrVc+a80HFc6Au7Eu9Ph2NK2LgzE6pMq+aPytCgD1E6s4gckdPqb6ODA07MPJtqa
 2DNsKyqKflsQDQHjyukg3Yt+djOM0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC 9/9] kas/opt/reproducible.yml: Move SOURCE_DATE_EPOCH to layer.conf
Date: Mon, 23 Oct 2023 17:00:07 +0200
Message-ID: <20231023150243.3990309-10-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13438

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



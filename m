Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A3C67861
	for <webhook@archiver.kernel.org>; Fri,  5 Apr 2024 12:53:27 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.5342.1712299709547702529
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Apr 2024 23:48:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=iyKZhi21;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1321639-202404050648268136f7f01c3c637d72-qzmagj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202404050648268136f7f01c3c637d72
        for <cip-dev@lists.cip-project.org>;
        Fri, 05 Apr 2024 08:48:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=F72/Bc1mZGjUV0+Yj7JRvO34az7atSEv6IJf8UlD6Mc=;
 b=iyKZhi21WkPR8K2ULGaiVyFu2mvr/N3kEOBLdeeIm0tLaQEyFwVz12xEGY7c4K0e2xABO2
 swEIl/KW8wQusQt0c+gRUGcTqardLSdRUqWrx5QYcbSNpAQ4xKu9EfRUSwcJ26DMyTcmQW07
 RRO7qDcdBP/PppSC3SNpYDlQA76yI=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	dinesh.kumar@toshiba-tsip.com,
	venkata.pyla@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] Revert "kas/opt/reproducible.yml: Move SOURCE_DATE_EPOCH to layer.conf"
Date: Fri,  5 Apr 2024 08:47:57 +0200
Message-Id: <20240405064757.378647-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Apr 2024 12:53:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15494

This change is too invasive. The layer.conf is read after the local
conf. By that, there is no way for a downstream user to set it to a
different value.

This reverts commit fcdbec9d2ab1daebd19e021c2b90ed30d0eeae00.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 conf/layer.conf          | 2 --
 kas/opt/reproducible.yml | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 82b4084..2c888b2 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -24,5 +24,3 @@ LAYERDIR_cip-core = "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
 
 IMAGE_CLASSES += "squashfs verity swupdate"
-
-SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
index bc71f28..5d6a896 100644
--- a/kas/opt/reproducible.yml
+++ b/kas/opt/reproducible.yml
@@ -13,4 +13,5 @@ header:
 
 local_conf_header:
   reproducible-builds: |
+    SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
     WIC_DEPLOY_PARTITIONS = "1"
-- 
2.39.2



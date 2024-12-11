Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B5E77188
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 02:03:33 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.7058.1733910910870362771
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 01:55:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=Sv35vF9q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1321639-2024121109550761e6db7d21ca0f0812-wknfrn@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024121109550761e6db7d21ca0f0812
        for <cip-dev@lists.cip-project.org>;
        Wed, 11 Dec 2024 10:55:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qiP8m9TROp+UIucuQF111dScdcheu3nyIoDTnChVyOE=;
 b=Sv35vF9q/6eN7p0c/FeBzUXQekgtbLReWTPaUkv5+ynkVlB8F5RaoL31d41F2jAOO6yUQn
 YSdxJAx/IdBUuvBFA6LTpWpHF2as+ZkSY00qt48sYlEsr09OgL6+QeA60qQQnXheBgOhtSDj
 4i1XaMck5bAnSQizUGUh3zNSbYXtU4DtjDtmIRYk+4tt+C3Al36/JnjYBxieBoJFCbJ+D4kE
 cpU/kuv2BYcxL+12GrI0C3nicc4eWhR+uCTFHe8ay0BdhDO05NRDjBUIwChPU90Nj0pQHNls
 fe7G5qFF4r0CIwZs42zSYrUaZh7W4vL0EmPpvtGhCKrjr0gmzj0PNoAQ==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 3/3] exclude boot and var in squashfs and erofs
Date: Wed, 11 Dec 2024 10:54:56 +0100
Message-Id: <20241211095456.2735691-3-felix.moessbauer@siemens.com>
In-Reply-To: <20241211095456.2735691-1-felix.moessbauer@siemens.com>
References: <20241211095456.2735691-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Dec 2024 02:03:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17434

These dirs are anyways not used in a ro-rootfs. boot is over-mounted by
systemd via sd boot protocol, implemented by EBG. var is deployed empty.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/erofs.bbclass    | 2 +-
 classes/squashfs.bbclass | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
index 72458bb..0624b75 100644
--- a/classes/erofs.bbclass
+++ b/classes/erofs.bbclass
@@ -11,7 +11,7 @@
 
 IMAGER_INSTALL:erofs += "erofs-utils"
 
-EROFS_EXCLUDE_DIRS ?= ""
+EROFS_EXCLUDE_DIRS ?= "boot var"
 EROFS_CONTENT ?= "${PP_ROOTFS}"
 EROFS_CREATION_ARGS ?= "-z lz4hc,12"
 
diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index b39be0c..cebda70 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -22,7 +22,7 @@ def get_free_mem():
 
 IMAGER_INSTALL:squashfs += "squashfs-tools"
 
-SQUASHFS_EXCLUDE_DIRS ?= ""
+SQUASHFS_EXCLUDE_DIRS ?= "boot var"
 SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
 SQUASHFS_CREATION_ARGS ?= ""
 
-- 
2.39.5



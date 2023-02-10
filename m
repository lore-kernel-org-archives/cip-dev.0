Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AE2C636CD
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 13:58:06 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.14837.1676036914460925767
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Feb 2023 05:48:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=EC9frDDz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-20230210134832b3e171b512917edb1d-sbchjz@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230210134832b3e171b512917edb1d
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Feb 2023 14:48:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4/kDUXu/3oHRiaaFFSxG6ppJQPmO1zJWp1pjRSL0Q5Q=;
 b=EC9frDDzu4gbG+3zBaHYkRcBu9VocKoLeOo6B1oBruxHfvX8/kEHSB15jjEZIAxPtGQWq9
 rC9un8vpLpuEXxafenfmaSp7eIW0s7HJmhp9EUxqoJAhR10dRwLXYeKclyg7mVkz1eZGNdlI
 uXSuzwYvZq95EbJUOCBXtIeSme20k=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 1/5] register image classes via layer.conf
Date: Fri, 10 Feb 2023 13:48:10 +0000
Message-Id: <20230210134814.732118-2-felix.moessbauer@siemens.com>
In-Reply-To: <20230210134814.732118-1-felix.moessbauer@siemens.com>
References: <20230210134814.732118-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 13:58:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10665

This patch registers the provided image classes via the bblayer.conf
file. By that, no manual additions of these classes via kas is required
and erronous implementations are detected early (e.g. mandatory inputs
without defaults).

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 conf/layer.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index 0c5fd39..2c888b2 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -22,3 +22,5 @@ LAYERSERIES_COMPAT_cip-core = "next"
 
 LAYERDIR_cip-core = "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
+
+IMAGE_CLASSES += "squashfs verity swupdate"
-- 
2.34.1



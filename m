Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77E7C636D7
	for <webhook@archiver.kernel.org>; Sun, 12 Feb 2023 22:54:13 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.7532.1676190496701915908
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Feb 2023 00:28:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=IdPOknv7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-72506-202302120828147535b40333f996cc49-eqedmb@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202302120828147535b40333f996cc49
        for <cip-dev@lists.cip-project.org>;
        Sun, 12 Feb 2023 09:28:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4/kDUXu/3oHRiaaFFSxG6ppJQPmO1zJWp1pjRSL0Q5Q=;
 b=IdPOknv7z8aeLrmBJQlSG+rgD0nesPjmn7hdW3Egc1q4DdhV6diEBjAYK7GpLImJt6Dyjp
 eZNIxtblkGCgtCq1FhNwqWyC3OweZV7Yu7JAlEnJBNHiIza0fgbQ/tV2gLpmbhKB/6O+IQVg
 vegLrMks6xbvpE89nFZVPhwfAab+E=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 1/8] register image classes via layer.conf
Date: Sun, 12 Feb 2023 08:27:51 +0000
Message-Id: <20230212082758.1166262-2-felix.moessbauer@siemens.com>
In-Reply-To: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Feb 2023 22:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10672

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



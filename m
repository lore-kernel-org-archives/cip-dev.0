Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F247C83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 10:15:52 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.17819.1752833742856389409
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 03:15:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=jFxfatsY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1321639-2025071810153852cbeef77d42c22e36-vkjiqo@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025071810153852cbeef77d42c22e36
        for <cip-dev@lists.cip-project.org>;
        Fri, 18 Jul 2025 12:15:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=NgJ1BMomqM5wG3X2qPBpUpHNtBhc8Xu1fRgZErOwjMs=;
 b=jFxfatsYSXC+v2J/c854OWtfozxmGTB05KCt/CfFptZsu6UqF3t92WzmrQPQ8TCTiMEdSw
 8M9i+zj/1XudNV7qdTHXTN3uzh5zzUS4o+ntjH3g5MOpLqoyLEUgNKlDKaM6ObDNNQXl3wch
 MvmMYPx9OmFZcnyFVVUQndlSwf/TLdB7H1UAQOxNd0oNlxbxM6rdiETUv+OXkJ2JSJZne4nJ
 9JExP9A9GaD3EyY68J4VIApZX6oOVX26cRJvwP/ncQShoJFVGg3sbK3w9o+067p0etbYzDTh
 ZpFUrUaarX88Qig/XYZugmOBqdcPQplWEN3hsYwjoIEv7k0EyawByozQ==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: cedric.hombourger@siemens.com,
	quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] create apt directory as needed by apt-daily
Date: Fri, 18 Jul 2025 12:15:24 +0200
Message-ID: <20250718101525.1270424-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 10:15:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19564

The apt daily service takes care of daily checking for updates. This
currently fails to start because the /var/lib/apt directory is not
available (it is created by running a manual "apt update", but if not
done explicitly, the service will fail).

While this service is not needed on a ro-rootfs system, it is provided
by the apt package which is installed and automatically enabled.
Disabling the service is an independent topic.

By not providing this directory, the system comes up in a "degraded"
state after the first time the service is executed. This is problematic,
as other logic (e.g. the blessing after an update) might also depend on
this state.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 .../immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
index 001dbb1..e8e58b3 100644
--- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
+++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
@@ -1,2 +1,3 @@
 L /var/lib/dpkg - - - - ${IMMUTABLE_DATA_DIR}/var/lib/dpkg
 d /var/log/audit 0700 root adm -
+d /var/lib/apt 0700 root root -
-- 
2.50.0



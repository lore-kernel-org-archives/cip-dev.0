Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB6AC25B10
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 13:38:03 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.12242.1715346449990411823
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 06:07:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=YC+cdVoU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1321639-20240510130726b01bf47fa154effce3-ahpnga@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240510130726b01bf47fa154effce3
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 May 2024 15:07:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CJ3D5/os1tnw2VorOxxLeRpbwdcRbCNZD4DGuz6amrQ=;
 b=YC+cdVoURCFoVu9xu9aUQPvHpVOgdS8EXcU2WNP23++IngxvUxMhod9gsgbD42Oeic9WwZ
 GzzA9hRbHQ2koD4nwx4R6rIE2lKNX2egkqFU5Xc08Asj9dZDV5vxI4VJpX37WTxLsTLZBH5u
 nfhtc6WEpkELeKMjoc/x71fOP1zvQ=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Adithya.Balakumar@toshiba-tsip.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH] use ISAR snapshot infrastructure for sid
Date: Fri, 10 May 2024 15:07:16 +0200
Message-Id: <20240510130716.152418-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 13:38:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15880

To have a stable base for debian sid, we need to pin the package set to
a fixed (known to be good) timestamp. Previously, this was done by
changing the apt sources list. As ISAR now supports to use snapshot
mirrors on-the-fly, we replace the fixed list with that logic.

This also makes it possible to later manually update the images (only
the non-immutable ones) from a running system, as the default apt
sources are not modified.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 conf/distro/cip-core-sid.conf            | 5 +++--
 conf/distro/cip-debian-sid-snapshot.list | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)
 delete mode 100644 conf/distro/cip-debian-sid-snapshot.list

diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
index 48f26ff..eefcbb5 100644
--- a/conf/distro/cip-core-sid.conf
+++ b/conf/distro/cip-core-sid.conf
@@ -12,8 +12,9 @@
 require conf/distro/debian-sid.conf
 require cip-core-common.inc
 
-DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
-HOST_DISTRO_APT_SOURCES = "${DISTRO_APT_SOURCES}"
+# corresponds to 20240211T000000Z
+ISAR_APT_SNAPSHOT_TIMESTAMP ?= "1707606000"
+ISAR_USE_APT_SNAPSHOT ?= "1"
 
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
diff --git a/conf/distro/cip-debian-sid-snapshot.list b/conf/distro/cip-debian-sid-snapshot.list
deleted file mode 100644
index 874047b..0000000
--- a/conf/distro/cip-debian-sid-snapshot.list
+++ /dev/null
@@ -1,2 +0,0 @@
-deb	[check-valid-until=no trusted=yes] https://snapshot-cloudflare.debian.org/archive/debian/20240211T000000Z sid main
-deb-src	[check-valid-until=no trusted=yes] https://snapshot-cloudflare.debian.org/archive/debian/20240211T000000Z sid main
-- 
2.39.2



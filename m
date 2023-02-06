Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275BEC61DA4
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 08:25:53 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.48779.1675671945456630207
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Feb 2023 00:25:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=pkivPJ0K;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20230206082542c703a965484074b233-jgmii9@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230206082542c703a965484074b233
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 Feb 2023 09:25:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=a9/hfIY60wmsq4ks8H1w0FV24wX6wHHPMnuEjkv7NFI=;
 b=pkivPJ0K9hcAQP6IbJRTYb8/O5Gvj4BLnxVBPXuhV+VOJ22OsPovanLaaTLHtVQ1kq8VCP
 eE1/hoNfezjd7Ohe3s+QCWEQ3gVPSJ7MIm0oX7m2YlVS5GfaOJ2fRKqeRSyijWTfIko2MVGr
 iFBvcfhWBEG1BIcLpKsibV7iWRGSs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4] conf/distro: Use cip prefix and snapshot postfix for sid lists
Date: Mon,  6 Feb 2023 09:25:41 +0100
Message-Id: <20230206082541.15361-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 08:25:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10591

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is done to avoid infecting other layers with the snapshot version.

Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v4:
 - Restore and rename debian-sid.list to cip-debian-sid-snapshot
 - use squash to avoid wrong file assignment in patch after renaming
 - Replace Variables in *DISTRO_APT_SOURCES with names

Changes v3:
 - delete debian-sid.list as it is not used.
 - add missing newline

Changes v2:
 - split renameing into two patches to avoid wrong patch
 - add missing newline

 conf/distro/cip-core-sid-ports.conf                            | 3 +++
 ...ebian-sid-ports.list => cip-debian-sid-ports-snapshot.list} | 0
 conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list}  | 0
 3 files changed, 3 insertions(+)
 rename conf/distro/{debian-sid-ports.list => cip-debian-sid-ports-snapshot.list} (100%)
 rename conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list} (100%)

diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
index 0b369bb..c5d1cc7 100644
--- a/conf/distro/cip-core-sid-ports.conf
+++ b/conf/distro/cip-core-sid-ports.conf
@@ -14,3 +14,6 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
+
+HOST_DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
+DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-ports-snapshot.list"
diff --git a/conf/distro/debian-sid-ports.list b/conf/distro/cip-debian-sid-ports-snapshot.list
similarity index 100%
rename from conf/distro/debian-sid-ports.list
rename to conf/distro/cip-debian-sid-ports-snapshot.list
diff --git a/conf/distro/debian-sid.list b/conf/distro/cip-debian-sid-snapshot.list
similarity index 100%
rename from conf/distro/debian-sid.list
rename to conf/distro/cip-debian-sid-snapshot.list
-- 
2.39.1



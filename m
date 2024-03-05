Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF70C54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 09:07:43 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.18061.1709629657164134555
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 01:07:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=h9xym7QJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20240305090734e79acd4b373d292c9c-a7tvuo@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240305090734e79acd4b373d292c9c
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 10:07:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=0HHW3HJoJSKOfj2oH4myDnSHcwkWULdA10WQDc5Wcbo=;
 b=h9xym7QJq/Kp4k4GRglDhJ7YFQSHfHz6Ub7oF6sVSKcOqdBwRsqR7toH+6wMp730wNKDwp
 Papkeq6nzTjTc2FqtaUcmDbl7sLEQZeWb5fK7f55ttNDlQ0O3cyljk+LloZjD9EpKmaG/giZ
 alxROtWj9tBSx+F16untxgnJ1/+wo=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/4] Switch sid-based riscv64 back to a snapshot
Date: Tue,  5 Mar 2024 10:07:31 +0100
Message-Id: <8e30ee68b209f16b6160fede99658d84c09cb902.1709629653.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1709629653.git.jan.kiszka@siemens.com>
References: <cover.1709629653.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 09:07:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15208

From: Jan Kiszka <jan.kiszka@siemens.com>

It's broken once again, now even the bootstrapping. At the same time, we
found a more performant snapshot source that can make this way of
building more reliable than in the past, so switch over.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-sid.conf            | 3 +++
 conf/distro/cip-debian-sid-snapshot.list | 2 ++
 2 files changed, 5 insertions(+)
 create mode 100644 conf/distro/cip-debian-sid-snapshot.list

diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
index 028b6c00..aff45726 100644
--- a/conf/distro/cip-core-sid.conf
+++ b/conf/distro/cip-core-sid.conf
@@ -12,6 +12,9 @@
 require conf/distro/debian-sid.conf
 require cip-core-common.inc
 
+DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
+HOST_DISTRO_APT_SOURCES = "${DISTRO_APT_SOURCES}"
+
 PREFERRED_VERSION_swupdate ?= "2023.05%"
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
diff --git a/conf/distro/cip-debian-sid-snapshot.list b/conf/distro/cip-debian-sid-snapshot.list
new file mode 100644
index 00000000..874047bf
--- /dev/null
+++ b/conf/distro/cip-debian-sid-snapshot.list
@@ -0,0 +1,2 @@
+deb	[check-valid-until=no trusted=yes] https://snapshot-cloudflare.debian.org/archive/debian/20240211T000000Z sid main
+deb-src	[check-valid-until=no trusted=yes] https://snapshot-cloudflare.debian.org/archive/debian/20240211T000000Z sid main
-- 
2.35.3



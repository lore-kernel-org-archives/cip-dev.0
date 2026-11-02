Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9574.1793615564531606468
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 02:32:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm2 header.b=AuxmPzpc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1328765-2026110210324051fe36a001000207ab-0golmf@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026110210324051fe36a001000207ab
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Nov 2026 11:32:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9DG/gv2G9QIfI0LEH5Ahhi5EOtxXGqhqNNAWddea5Sc=;
 b=AuxmPzpcBpD2ETTWF/JgRrRvJ51p7BLt4x9ssXUwtXNdablR1ICSehls3Jg4ZIYET/z0jp
 MY+TenbtVWzrWqaJI5308jPLWM3uAcVdP5778JaADDJToVKEruJa2SKjXBAr76YaRB9hLrfn
 6vbLgqToYFGOYU9/Sk+8VSC7++eh9VObUWZbcKe7lKA/Isimibh2mf1EyMJm8KwWsSwX/xtq
 w7U9prj/bIWyTjB/rFnzk/0i9oIy1WK+gXozHEKnCWt0Fajfdiaa9m2PUZYkD5vymLPX7Wnh
 c0EF24KJuPJLFCRDZp915s07HscunIPM8kBqBBSSx48jh72yZXV7b3Ug==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [PATCH] linux-cip: Update to 6.12.114-cip34
Date: Mon,  2 Nov 2026 05:32:19 -0500
Message-ID: <20261102103219.387901-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 10:32:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24597
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb             | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb             | 1 +
 ...{linux-cip_6.12.112-cip33.bb => linux-cip_6.12.114-cip34.bb} | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
 rename recipes-kernel/linux/{linux-cip_6.12.112-cip33.bb => linux-cip_6.12.114-cip34.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb b/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
deleted file mode 120000
index 16111eb..0000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.112-cip33.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb b/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
new file mode 120000
index 0000000..91a3ca2
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
@@ -0,0 +1 @@
+linux-cip_6.12.114-cip34.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12.112-cip33.bb b/recipes-kernel/linux/linux-cip_6.12.114-cip34.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.112-cip33.bb
rename to recipes-kernel/linux/linux-cip_6.12.114-cip34.bb
index 0d708db..95cd7b2 100644
--- a/recipes-kernel/linux/linux-cip_6.12.112-cip33.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.114-cip34.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "522caf8dd5a07904705691ba07440d8a557d74eab39a938b95b0c69ad27eed3a"
+SRC_URI[sha256sum] = "801ba01e82a8e25738d4f30d2640e537cc06bb13f9dbf0f6fce5095f3fb1f168"
-- 
2.39.5


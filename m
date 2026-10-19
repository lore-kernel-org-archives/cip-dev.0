Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.849.1792432570502010184
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 10:56:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm2 header.b=cgIb8wHe;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1328765-2026101917560635177a759600020746-y4to85@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026101917560635177a759600020746
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Oct 2026 19:56:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=8yKKsMZ56FB9ECPmGStyPZ626HuqEHqapBoa+NeIaqA=;
 b=cgIb8wHeGb2DLO1WrS9meCLxxif4rYA/dnkJsTv/ZJI55mTvYOmxqbNcP1l+Q/1QO/D1I0
 2HZ++dOc04+c3Xt1MdX8/XEIjjSMCsvdYEnqSR2SKGtCrvKmoXicJd3w50t4cyhVE0M56A1g
 scmz3aDj2Y43ygGZzAcnF3WoXahSCKHgSic5nlZ70/pbhz28/hZYPL8Tw/qi9n4sihodu9dE
 aqaXWFrrayXh7wEPkinuHOc8lUAuMR1EbTH+xzwoDjMok+i3lR/TOn4hKSKCY6Eq3ejNSEd9
 fVY8M2dLww6pzODkyQr/AGP9R3FuBzOZwx7g4D/v4xazG6tNiUZ2rtfg==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [PATCH] linux-cip: Update to 5.10.271-cip78, 6.1.189-cip61[-rt32], 6.12.112-cip33
Date: Mon, 19 Oct 2026 13:55:48 -0400
Message-ID: <20261019175548.124127-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 17:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24495
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 ...6.1.182-cip59-rt31.bb => linux-cip-rt_6.1.189-cip61-rt32.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb             | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb             | 1 +
 ...{linux-cip_5.10.268-cip77.bb => linux-cip_5.10.271-cip78.bb} | 2 +-
 .../{linux-cip_6.12.111-cip32.bb => linux-cip_6.1.189-cip61.bb} | 2 +-
 .../{linux-cip_6.1.187-cip60.bb => linux-cip_6.12.112-cip33.bb} | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.182-cip59-rt31.bb => linux-cip-rt_6.1.189-cip61-rt32.bb} (59%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
 rename recipes-kernel/linux/{linux-cip_5.10.268-cip77.bb => linux-cip_5.10.271-cip78.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.111-cip32.bb => linux-cip_6.1.189-cip61.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.1.187-cip60.bb => linux-cip_6.12.112-cip33.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.182-cip59-rt31.bb b/recipes-kernel/linux/linux-cip-rt_6.1.189-cip61-rt32.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.182-cip59-rt31.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.189-cip61-rt32.bb
index 52fbe64..8da2d14 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.182-cip59-rt31.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.189-cip61-rt32.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "d66e63c93ec04fb51c32cedc97b1ad73998d58055bf3fa021e3d7bb1a2789ac1"
+SRC_URI[sha256sum] = "805490d21893c71af2fe8dcc4e45fa5a1c53619414894072390d6b3ad9fc79b6"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb b/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
deleted file mode 120000
index 8003b24..0000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.111-cip32.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb b/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
new file mode 120000
index 0000000..16111eb
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
@@ -0,0 +1 @@
+linux-cip_6.12.112-cip33.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_5.10.268-cip77.bb b/recipes-kernel/linux/linux-cip_5.10.271-cip78.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.268-cip77.bb
rename to recipes-kernel/linux/linux-cip_5.10.271-cip78.bb
index e7207d3..c6fccfb 100644
--- a/recipes-kernel/linux/linux-cip_5.10.268-cip77.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.271-cip78.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7151537fafb9f395ba41a8ce86b8236b0d2dab9834e9c66b1a12b442aea41ee7"
+SRC_URI[sha256sum] = "a972b3e41472bcbd28f41ef48bec9354ac7a050b8d0e0c880de207c70f929201"
diff --git a/recipes-kernel/linux/linux-cip_6.12.111-cip32.bb b/recipes-kernel/linux/linux-cip_6.1.189-cip61.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.111-cip32.bb
rename to recipes-kernel/linux/linux-cip_6.1.189-cip61.bb
index 5a225b4..4b6c7d5 100644
--- a/recipes-kernel/linux/linux-cip_6.12.111-cip32.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.189-cip61.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "879b45f18c1bd8322b2026f72642faedcb77242418cb10a5aa56f5404f647059"
+SRC_URI[sha256sum] = "7003af449cbaf2af04c671dd3d06193bc8a7d8a10e94a9d286b5a3c36690c923"
diff --git a/recipes-kernel/linux/linux-cip_6.1.187-cip60.bb b/recipes-kernel/linux/linux-cip_6.12.112-cip33.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.187-cip60.bb
rename to recipes-kernel/linux/linux-cip_6.12.112-cip33.bb
index d6120de..0d708db 100644
--- a/recipes-kernel/linux/linux-cip_6.1.187-cip60.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.112-cip33.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "b11ba859c202d5feadd8905f93902a2df6a1434c2fff9eb8eb310b8cf969bd74"
+SRC_URI[sha256sum] = "522caf8dd5a07904705691ba07440d8a557d74eab39a938b95b0c69ad27eed3a"
-- 
2.39.5


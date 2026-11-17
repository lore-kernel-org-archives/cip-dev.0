Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16742.1794919155670456933
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 04:39:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm1 header.b=N7orsmOM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1328765-20261117123911a63691c29f00020728-yvpwrm@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261117123911a63691c29f00020728
        for <cip-dev@lists.cip-project.org>;
        Tue, 17 Nov 2026 13:39:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=aUeol9lKbGV01KEnSA7aK15SiVVpKGXae4t6YTTju18=;
 b=N7orsmOM3YJYmC0WKQ6A7zFKneafrgOsSNJbp7HNsnf+K3taYuUxb0und0kX1oxy7h/7A4
 5OoauSN1LS/0U1uRolr6rLQe3JihAGXYo0VnwWOZmBL+A1ACSPkY0Yz9u4FdPb0fCuwuaII4
 x75/RxGBTEouZnpuCD7xzsG5YKGVuNNN8YFeS4wdwvJiV7mctxDqL9D5j2giml71EIb3Jdtq
 yQnu0zyOjRaqI79QkuepoWlew2rtuvwzQsgWYpYPYcTjirQWvNdHQbKmeIb12Us13i2HGsyt
 0/SiKGPTxcN/J0Ml7OTBqSv4AMlrIt5ptkL7Hn3LiCbfOgmBUldbN42w==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip137[-rt51], 5.10.272-cip79[-rt35], 6.1.190-cip62, 6.12.117-cip35
Date: Tue, 17 Nov 2026 07:38:46 -0500
Message-ID: <20261117123846.177888-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 12:39:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24941
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 ....325-cip136-rt50.bb => linux-cip-rt_4.19.325-cip137-rt51.bb} | 2 +-
 ...10.268-cip77-rt34.bb => linux-cip-rt_5.10.272-cip79-rt35.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb             | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb             | 1 +
 ...inux-cip_4.19.325-cip136.bb => linux-cip_4.19.325-cip137.bb} | 2 +-
 ...{linux-cip_5.10.271-cip78.bb => linux-cip_5.10.272-cip79.bb} | 2 +-
 .../{linux-cip_6.1.189-cip61.bb => linux-cip_6.1.190-cip62.bb}  | 2 +-
 ...{linux-cip_6.12.114-cip34.bb => linux-cip_6.12.117-cip35.bb} | 2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip136-rt50.bb => linux-cip-rt_4.19.325-cip137-rt51.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.268-cip77-rt34.bb => linux-cip-rt_5.10.272-cip79-rt35.bb} (68%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip136.bb => linux-cip_4.19.325-cip137.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.271-cip78.bb => linux-cip_5.10.272-cip79.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.189-cip61.bb => linux-cip_6.1.190-cip62.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.12.114-cip34.bb => linux-cip_6.12.117-cip35.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip137-rt51.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip137-rt51.bb
index 6b54d1d..19b48fe 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip137-rt51.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "424e3e7f2f6e1282021ddf61ceed8cd71332e33fbaf42868784fe22a780fd82b"
+SRC_URI[sha256sum] = "aac5292feb94163f9c97a2886fdb0e58e84f1be87ea787b9fc858e0b17c9529b"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.268-cip77-rt34.bb b/recipes-kernel/linux/linux-cip-rt_5.10.272-cip79-rt35.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.268-cip77-rt34.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.272-cip79-rt35.bb
index 9f3cb2b..f211866 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.268-cip77-rt34.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.272-cip79-rt35.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "735246b660eae9314f9a312eedca69773996d3604399810271c0b544c30400b8"
+SRC_URI[sha256sum] = "bddf7a247276da228aad949208dd769b441e9b67f2c06bd30e1f5bb8d43d4161"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb b/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
deleted file mode 120000
index 91a3ca2..0000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.114-cip34.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb b/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
new file mode 120000
index 0000000..8023eb0
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
@@ -0,0 +1 @@
+linux-cip_6.12.117-cip35.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip136.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip137.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip136.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip137.bb
index 9fb5905..dee0731 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip136.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip137.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "9e753afd86e574a8e67cdadbb8cc43ee8337521cd5afaef931c4c217fb2bbeb2"
+SRC_URI[sha256sum] = "0788097dc70bea3fb512e6f6d6401d21bd54f4d3779c0d0190c62aeb599564d6"
diff --git a/recipes-kernel/linux/linux-cip_5.10.271-cip78.bb b/recipes-kernel/linux/linux-cip_5.10.272-cip79.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.271-cip78.bb
rename to recipes-kernel/linux/linux-cip_5.10.272-cip79.bb
index c6fccfb..dad120e 100644
--- a/recipes-kernel/linux/linux-cip_5.10.271-cip78.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.272-cip79.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "a972b3e41472bcbd28f41ef48bec9354ac7a050b8d0e0c880de207c70f929201"
+SRC_URI[sha256sum] = "d3a621032b579b47692c9127b3e2c643d508e394c5e25f6a6a2606a6571892ca"
diff --git a/recipes-kernel/linux/linux-cip_6.1.189-cip61.bb b/recipes-kernel/linux/linux-cip_6.1.190-cip62.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.189-cip61.bb
rename to recipes-kernel/linux/linux-cip_6.1.190-cip62.bb
index 4b6c7d5..831fbc0 100644
--- a/recipes-kernel/linux/linux-cip_6.1.189-cip61.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.190-cip62.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7003af449cbaf2af04c671dd3d06193bc8a7d8a10e94a9d286b5a3c36690c923"
+SRC_URI[sha256sum] = "404a492ac47b321f2657e1345821e9aac16bb07f8d8703ca1774f59016fa6c3c"
diff --git a/recipes-kernel/linux/linux-cip_6.12.114-cip34.bb b/recipes-kernel/linux/linux-cip_6.12.117-cip35.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.114-cip34.bb
rename to recipes-kernel/linux/linux-cip_6.12.117-cip35.bb
index 95cd7b2..3927cef 100644
--- a/recipes-kernel/linux/linux-cip_6.12.114-cip34.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.117-cip35.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "801ba01e82a8e25738d4f30d2640e537cc06bb13f9dbf0f6fce5095f3fb1f168"
+SRC_URI[sha256sum] = "7c3d5c0938f6030ca3dd6673a11776dd433a80d9544ab3909f073962da40f840"
-- 
2.39.5


Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A91C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 11:56:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.86151.1738583802902832164
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 03:56:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 513BudiY3082679; Mon, 3 Feb 2025 20:56:40 +0900
X-Iguazu-Qid: 2rWhWAeBjLVrkxQ5Ku
X-Iguazu-QSIG: v=2; s=0; t=1738583799; q=2rWhWAeBjLVrkxQ5Ku; m=7VYXzHyOdumxLxHqpXwHD9ukcmrZbnCtCc1e2CjoSeE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 513BucaK764692
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 20:56:39 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 2/3] rules.tmpl: Make ltp rules file as template to make installation path configurable
Date: Mon,  3 Feb 2025 17:23:20 +0530
X-TSB-HOP2: ON
Message-Id: <20250203115321.3589084-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250203115321.3589084-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20250203115321.3589084-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Feb 2025 11:56:34.0806 (UTC) FILETIME=[AC42C160:01DB7632]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 11:56:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17729

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 recipes-core/ltp/files/debian/{rules => rules.tmpl} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-core/ltp/files/debian/{rules => rules.tmpl} (80%)

diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files/debian/rules.tmpl
similarity index 80%
rename from recipes-core/ltp/files/debian/rules
rename to recipes-core/ltp/files/debian/rules.tmpl
index 06b9070..918b443 100755
--- a/recipes-core/ltp/files/debian/rules
+++ b/recipes-core/ltp/files/debian/rules.tmpl
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 export DEB_CFLAGS_MAINT_APPEND  = -Wall  -Wno-format-security
 
-LTP_CONFIGURE_FLAGS = --prefix=/opt/ltp
+LTP_CONFIGURE_FLAGS = --prefix=${LTP_INSTALL_PATH}
 
 %:
 	dh $@  --with autoreconf
-- 
2.30.2




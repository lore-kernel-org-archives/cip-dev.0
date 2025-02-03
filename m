Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FC8C02193
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 11:56:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.86150.1738583802384438543
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 03:56:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 513Buedm3465111; Mon, 3 Feb 2025 20:56:40 +0900
X-Iguazu-Qid: 2yAbuzQy0YtzcUB1MY
X-Iguazu-QSIG: v=2; s=0; t=1738583799; q=2yAbuzQy0YtzcUB1MY; m=3cJET/dyLDkn2TNUSHCaZlRvRNZXS9K5MhSTg2IV9ik=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 513BudNK880670
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 20:56:39 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 3/3] ltp.inc: Set default ltp install path and include template files and variables
Date: Mon,  3 Feb 2025 17:23:21 +0530
X-TSB-HOP2: ON
Message-Id: <20250203115321.3589084-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250203115321.3589084-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20250203115321.3589084-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Feb 2025 11:56:34.0884 (UTC) FILETIME=[AC4EA840:01DB7632]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 11:56:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17728

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 recipes-core/ltp/ltp.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/ltp/ltp.inc b/recipes-core/ltp/ltp.inc
index c8f1199..0890097 100644
--- a/recipes-core/ltp/ltp.inc
+++ b/recipes-core/ltp/ltp.inc
@@ -18,6 +18,10 @@ SRC_URI = " \
    file://debian \
    "
 
+LTP_INSTALL_PATH ??= "/opt/ltp"
+TEMPLATE_FILES += "debian/rules.tmpl"
+TEMPLATE_VARS += "LTP_INSTALL_PATH"
+
 do_prepare_build() {
         cp -R ${WORKDIR}/debian ${S}
         deb_add_changelog
-- 
2.30.2




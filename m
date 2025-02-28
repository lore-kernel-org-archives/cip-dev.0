Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CAEC282C5
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 07:20:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.10531.1740727200468364627
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 23:20:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=L9rPQehA;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key3.smx;t=1740727198;x=1741936798;bh=vS2K
	kGd7u0/BRC59dbecwbDXiI3WBnD4FTvmy53firc=;b=L9rPQehAvsdEzDUc+Pyl24Zhzt7n+GS28K
	qU23JxydTcu2X8eK6ro6lxpwKSfXGycbI2FzZZrY0wf2Z+mV4VdM3KNXJf7ZOJSUP7nhJ8AtoSzS9
	jXWclLW927Ut6SsKclf4PXrZLphWiqFw1EMG3kuU7NcNkYYuWTELY8DGcLCCSjuiNU7FIcit3Uflh
	PukXhcFjWeBsalpUVcM9Tii0+JzM15kS9nZySWgysNPofX8P4/iexOUGFqZUY+ulu11ISl4guKo6z
	WUZgO7R++Bu53kcqCSiaUYivTVXpciYZYcQPFnrSshxNG49q662Nh90VyuKN9CAGvcIhsCJqagpTw
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51S7Jwmt1849748; Fri, 28 Feb 2025 16:19:58 +0900
X-Iguazu-Qid: 2yAbAvUQLqqRlWcbqi
X-Iguazu-QSIG: v=2; s=0; t=1740727197; q=2yAbAvUQLqqRlWcbqi; m=li3DOg71FoiBRl0zi4q1v7ZqOqwBtOr7ZDWOcLa592U=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 51S7Jucb2942960
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 16:19:57 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 2/2] recipes-core: ltp: Update to 20250130
Date: Fri, 28 Feb 2025 16:19:43 +0900
X-TSB-HOP2: ON
Message-Id: <1740727183-24538-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1740727183-24538-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1740727183-24538-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 07:20:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17981

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 recipes-core/ltp/{ltp-full_20240930.bb => ltp-full_20250130.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-core/ltp/{ltp-full_20240930.bb => ltp-full_20250130.bb} (69%)

diff --git a/recipes-core/ltp/ltp-full_20240930.bb b/recipes-core/ltp/ltp-full_20250130.bb
similarity index 69%
rename from recipes-core/ltp/ltp-full_20240930.bb
rename to recipes-core/ltp/ltp-full_20250130.bb
index 95828ee..40fdccf 100644
--- a/recipes-core/ltp/ltp-full_20240930.bb
+++ b/recipes-core/ltp/ltp-full_20250130.bb
@@ -11,4 +11,4 @@
 
 require recipes-core/ltp/ltp.inc
 
-SRC_URI[sha256sum] = "3e9e806405aa602e2d21d221d885fd4914ff2da23eb8bba3d0f0f468bdf60238"
+SRC_URI[sha256sum] = "02e4ec326be54c3fd92968229a468c02c665d168a8a673edc38a891f7395ae10"
-- 
2.45.2




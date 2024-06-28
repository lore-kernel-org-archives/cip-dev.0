Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E95C2BD09
	for <webhook@archiver.kernel.org>; Fri, 28 Jun 2024 02:01:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.8068.1719540109459735251
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jun 2024 19:01:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=qWYXTWbC;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1719540107;x=1720749707;bh=iq0oowB7aztd+nfAVZDl2ql4U5XDWy/60k0YhQ8IxGI=;b=qWY
	XTWbCd0k+0FFeh3EU8aFFI2qdFRNqcPreiJ7WDDoB0CmuzTeBazvLIn3iAhA+tA4npKZhn8J7NZ7d
	rxk35VhwpfxfpZjQpw1zLXpl94rILpXaKr9v4oqKpnARbu/01g80bRFEnqthYEx/QRKhbb+FaIwlC
	c4W9Kca9CqleruYGWzmFWZMZa2w+GVyrPEpSkYfpIpSssK2FfYblIjU6J2ovPgSy/p7nY0D8MPAH2
	4nDv+L5HQAjoJTELcc+yjmuqeIFQtIMZA5inrNmp+OumXl3WI2sWcPQQnGI69vExiR6A046SQsw2X
	F0PuNhO2vQ6vJrrhHTBthcX6IRcwufg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 45S21llA3722941; Fri, 28 Jun 2024 11:01:47 +0900
X-Iguazu-Qid: 2rWgPVHIQi9x3L2sXD
X-Iguazu-QSIG: v=2; s=0; t=1719540106; q=2rWgPVHIQi9x3L2sXD; m=wU+0bzoC8yfPJmMNGaMq5Km/Q73/hllM/ZAG6eQIYIw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 45S21jxv1556738
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 11:01:46 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH] recipes-core: ltp: Update LTP to 20240524
Date: Fri, 28 Jun 2024 11:01:43 +0900
X-TSB-HOP2: ON
Message-Id: <1719540103-23049-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jun 2024 02:01:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16339

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 recipes-core/ltp/{ltp-full_20230516.bb => ltp-full_20240524.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-core/ltp/{ltp-full_20230516.bb => ltp-full_20240524.bb} (69%)

diff --git a/recipes-core/ltp/ltp-full_20230516.bb b/recipes-core/ltp/ltp-full_20240524.bb
similarity index 69%
rename from recipes-core/ltp/ltp-full_20230516.bb
rename to recipes-core/ltp/ltp-full_20240524.bb
index 943340f..1ec0974 100644
--- a/recipes-core/ltp/ltp-full_20230516.bb
+++ b/recipes-core/ltp/ltp-full_20240524.bb
@@ -11,4 +11,4 @@
 
 require recipes-core/ltp/ltp.inc
 
-SRC_URI[sha256sum] = "d78f4bdd5bdc9e91357631954affba7e66190a2509c369b59f55efd190268956"
+SRC_URI[sha256sum] = "2b7c07bb281b7ec49981eeb06c4b66f147b103977254632678d384034f6e9663"
-- 
2.43.0




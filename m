Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DC4C87FD3
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 02:46:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.42107.1754534781147300483
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 19:46:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=D25zCZe+;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1754534779;x=1755744379;bh=GN8LVhQSQ5DhV7YVUBggiPFyrCtMhTnhIKb5UWHzSj4=;b=D25
	zCZe+QTBb21Z8RIoGpCEuY67pz9ORZcr4E27qvxMXjzgIEypKR7Mc56cTcqR21b2aviAN0825zlGx
	AkiF2WXavohXzxQ3HkcZF3y5XZCbFFXsFYarITd/XpFrUYxAZHBJceNfl9gddOFst06tRkp7l+ABv
	dXabMUUEDIQpWFLYUGJWCbIdIjGYWd3aIWg0bSolgUKcMowlzZCgw0X8Q4mzHe/ogSxjMHbPGKtVJ
	a0QF8rgf5fb1OMHm0yJJRMlWT1QfSD4MrkUl3dLg3VGyxJy+FeE7HnMDqC3fdr830fn0BJQOXoXTe
	igL2T/iuMoqNpuxHuN+HO7G/PyPad3A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5772kJEd1387849; Thu, 7 Aug 2025 11:46:19 +0900
X-Iguazu-Qid: 2yAbpfLvKAYg4qSoFu
X-Iguazu-QSIG: v=2; s=0; t=1754534778; q=2yAbpfLvKAYg4qSoFu; m=MgnUmJ64l/w1S8q+WS4fn49MlvatUH8C830hKrdaDd4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 5772kITe3582463
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 11:46:18 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH] recipes-core: ltp: Update to 20250530
Date: Thu,  7 Aug 2025 11:46:10 +0900
X-TSB-HOP2: ON
Message-Id: <1754534770-19831-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Aug 2025 02:46:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19702

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 recipes-core/ltp/{ltp-full_20250130.bb => ltp-full_20250530.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-core/ltp/{ltp-full_20250130.bb => ltp-full_20250530.bb} (69%)

diff --git a/recipes-core/ltp/ltp-full_20250130.bb b/recipes-core/ltp/ltp-full_20250530.bb
similarity index 69%
rename from recipes-core/ltp/ltp-full_20250130.bb
rename to recipes-core/ltp/ltp-full_20250530.bb
index 40fdccf..553b58d 100644
--- a/recipes-core/ltp/ltp-full_20250130.bb
+++ b/recipes-core/ltp/ltp-full_20250530.bb
@@ -11,4 +11,4 @@
 
 require recipes-core/ltp/ltp.inc
 
-SRC_URI[sha256sum] = "02e4ec326be54c3fd92968229a468c02c665d168a8a673edc38a891f7395ae10"
+SRC_URI[sha256sum] = "27586ba78eac1e40cd422add2842f1ad70f09fea55da3bd6a25e10feb786d4f2"
-- 
2.50.0




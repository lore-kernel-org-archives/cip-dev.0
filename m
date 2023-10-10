Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7105DCD68F6
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 07:51:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.85616.1696924271468628453
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 00:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 39A7p7D42215243; Tue, 10 Oct 2023 16:51:08 +0900
X-Iguazu-Qid: 2rWh9TRRTQox3GCkDd
X-Iguazu-QSIG: v=2; s=0; t=1696924267; q=2rWh9TRRTQox3GCkDd; m=1iT4OWI+CoHO/+9lrXgEjJykze9eCJrUrM6kP03eArs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 39A7p6Gc1911050
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Oct 2023 16:51:06 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 1/2] wic: Rename wic/simatic-ipc227e.wks to wic/x86_64-generic.wks
Date: Tue, 10 Oct 2023 16:50:13 +0900
X-TSB-HOP2: ON
Message-Id: <20231010075014.3761016-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 07:51:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13340

Currently wic/simatic-ipc227e.wks has generic settings for x86_64. It is
also available for other x86_64 reference HWs.
Therefore, change this to wic/x86_64-generic.wks as the generic file name.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 wic/{simatic-ipc227e.wks => x86_64-generic.wks} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename wic/{simatic-ipc227e.wks => x86_64-generic.wks} (100%)

diff --git a/wic/simatic-ipc227e.wks b/wic/x86_64-generic.wks
similarity index 100%
rename from wic/simatic-ipc227e.wks
rename to wic/x86_64-generic.wks
-- 
2.42.0




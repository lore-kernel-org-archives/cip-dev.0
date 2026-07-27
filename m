Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86757C531FC
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:25:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32460.1785162298519469265
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:24:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 66REOu1p2654330; Mon, 27 Jul 2026 23:24:56 +0900
X-Iguazu-Qid: 2rWhW3h7oowfa0q8BM
X-Iguazu-QSIG: v=2; s=1; t=1785162296; q=2rWhW3h7oowfa0q8BM; m=F2K04Pn6g8YCYi5Wh84Zw8+sX32fwBKlU+UfU8rbluQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h81881944z1xng; Mon, 27 Jul 2026 23:24:55 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
Subject: [isar-cip-core][PATCH v1 0/2] Enable debian forky builds & tests
Date: Mon, 27 Jul 2026 19:41:34 +0530
X-TSB-HOP2: ON
Message-Id: <20260727141136.1773671-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Jul 2026 14:24:54.0142 (UTC) FILETIME=[B154E9E0:01DD1DD3]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:25:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23773

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

This patch series adds the debian forky based image build & CI test support.

NOTE: The base/security image builds are failing locally due to some dependency
issues in package installation not because of recipe changes.

I request you to create a scheduled pipeline similar to sid and add the
CI variable CI_RUN_UNSTABLE_FORKY with some value. 


Shivanand Kunijadar (2):
  Enable the support of Debian forky based builds
  Enable CI image build and test support for forky

 .gitlab-ci.yml                                | 93 +++++++++++++++++++
 Kconfig                                       |  4 +
 conf/distro/cip-core-forky.conf               | 13 +++
 kas/opt/forky.yml                             | 15 +++
 .../files/forky/PkKek-1-snakeoil.key          | 30 ++++++
 .../files/forky/PkKek-1-snakeoil.pem          | 23 +++++
 .../swupdate-certificates/files/forky         |  1 +
 start-qemu.sh                                 |  2 +
 8 files changed, 181 insertions(+)
 create mode 100644 conf/distro/cip-core-forky.conf
 create mode 100644 kas/opt/forky.yml
 create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
 create mode 120000 recipes-devtools/swupdate-certificates/files/forky

-- 
2.39.5




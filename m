Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A54C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 09:08:53 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7512.1785229722785926567
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 02:08:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 66S98eVw1377470; Tue, 28 Jul 2026 18:08:40 +0900
X-Iguazu-Qid: 2rWhoBnMRL7YCbkqv2
X-Iguazu-QSIG: v=2; s=1; t=1785229720; q=2rWhoBnMRL7YCbkqv2; m=YNxPx632VVLyNyWxWvvmuFQB5/DVcqC6GU/pIJXPqeo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h8V4m30lkz1xnf; Tue, 28 Jul 2026 18:08:40 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
Subject: [isar-cip-core][PATCH v2 0/2] Enable debian forky build & test support
Date: Tue, 28 Jul 2026 14:25:16 +0530
X-TSB-HOP2: ON
Message-Id: <20260728085519.3615499-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Jul 2026 09:08:38.0026 (UTC) FILETIME=[AD1926A0:01DD1E70]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 09:08:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23794

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

This patch series adds the debian forky based image build & CI test support.

It enables SWUpdate, secure boot, security tests in LAVA and RB in
gitlab CI.

NOTE: 
- The existing .reproducible-check-ci.yml is updated to support forky
  images reproducibility check. No need to add the exta scheduled pipeline
  for forky, the current scheduled pipeline covers both trixie and
  forky. The forky builds and RB tests are kept with allowed failure
  option as true.
- The CI variable CI_RUN_UNSTABLE_FORKY is changed to CI_RUN_UNSTABLE,
  however CI_RUN_UNSTABLE_SID is not changed in this patch series, will
  update in a separate patch as it is not related to this series.
- Updated authors list for .gitlab-ci.yml & .reproducible-check-ci.yml

Shivanand Kunijadar (2):
  Enable the support of Debian forky based builds
  Enable CI image build and test support for forky

 .gitlab-ci.yml                                | 148 ++++++++++++++++++
 .reproducible-check-ci.yml                    |  72 +++++++++
 Kconfig                                       |   4 +
 conf/distro/cip-core-forky.conf               |  13 ++
 kas/opt/forky.yml                             |  15 ++
 .../files/forky/PkKek-1-snakeoil.key          |  30 ++++
 .../files/forky/PkKek-1-snakeoil.pem          |  23 +++
 .../swupdate-certificates/files/forky         |   1 +
 start-qemu.sh                                 |   2 +
 9 files changed, 308 insertions(+)
 create mode 100644 conf/distro/cip-core-forky.conf
 create mode 100644 kas/opt/forky.yml
 create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
 create mode 120000 recipes-devtools/swupdate-certificates/files/forky

-- 
2.39.5




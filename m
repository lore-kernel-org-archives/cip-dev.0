Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33882D4898A
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 11:49:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4371.1768564145509916379
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 03:49:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 60GBn3sj4092959; Fri, 16 Jan 2026 20:49:03 +0900
X-Iguazu-Qid: 2yAbG2P4DVUhtYcReK
X-Iguazu-QSIG: v=2; s=0; t=1768564143; q=2yAbG2P4DVUhtYcReK; m=pMOwzquGv2hTB5Pvd9EIUXS2kLDPrdp04nsfmSLAluU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dsymt6xG1zyPZ; Fri, 16 Jan 2026 20:49:02 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com
Subject: [isar-cip-core][PATCH v5 0/4] Enable support for wfx backend based software updates
Date: Fri, 16 Jan 2026 07:03:43 -0500
X-TSB-HOP2: ON
Message-Id: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jan 2026 11:49:00.0526 (UTC) FILETIME=[1AD460E0:01DC86DE]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 11:49:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21632

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

SWUpdate has supported software updates with wfx[1] backend for a while now. But using this requires a few configurations in the image (swupdate.cfg or via command line options). 
These series of patches enables/sets the necessary configurations required to use wfx for software updates.

A couple notes about the implementation:
- Provides using wfx as the update backend as an option (not forced).
- wfx url can be set through Kconfig.
- wfx requires a clientId per device in order to target devices (create jobs for devices). So start
SWUpdate in suricatta daemon mode at service startup with the required suricatta command line args.
- The above point could be made more practical with something like an onboarding function (See [2],
This is still not officially part of the CIP project yet).

[1] https://sbabic.github.io/swupdate/suricatta.html#support-for-wfx
[2] https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin

Changes since v4:
- Minor updates to documentation

Changes since v3:
- Drop self-built SWUpdate package and use debian's (required fix is backported to stable now)
- Use suricatta command line arguments to pass wfx url and client-id
- Include Kconfig option to set wfx url
- Enable wfx support if an url is set via the Kconfig

Changes since v2:
- Fix appending suricatta section in swupdate.cfg when wfx based update is not enabled at build time

Changes since v1:
- Rebase to current next
- Drop carrying the patch to fix swupdate issue as its backported to
  debian
- Fix appending suricatta section in swupdate.cfg only if wfx is
  requested at build time
- Use /etc/machine-id as is for client-id in suricatta

Adithya Balakumar (4):
  swupdate-config-wfx: Recipe to set configs for wfx backend based
    updates
  Kconfig: Add option to set WFX_URL
  swupdate.inc: Enable wfx based updates if WFX_URL is set
  doc/README.swupdate.md: Add section for software update with wfx

 Kconfig                                       |   7 ++
 doc/README.swupdate.md                        | 113 ++++++++++++++++++
 recipes-core/images/swupdate.inc              |   4 +
 .../files/suricatta_wfx.conf.tmpl             |   1 +
 .../swupdate-config-wfx_0.1.bb                |  27 +++++
 5 files changed, 152 insertions(+)
 create mode 100644 recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
 create mode 100644 recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb

-- 
2.39.5




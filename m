Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3C0CCF9EA
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 05:34:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.5106.1761629680130242304
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 22:34:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 59S5Yb6V3032669; Tue, 28 Oct 2025 14:34:38 +0900
X-Iguazu-Qid: 2rWhKtyZUWom1YZrDW
X-Iguazu-QSIG: v=2; s=0; t=1761629677; q=2rWhKtyZUWom1YZrDW; m=mI/b+fXIsxtLJVmOamQ+hudJyq3tP5dhM39j8yRhYQ0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cwfFn49NRz4vyh; Tue, 28 Oct 2025 14:34:37 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][RFC v2 0/5] Enable support for wfx backend based software updates
Date: Tue, 28 Oct 2025 01:46:17 -0400
X-TSB-HOP2: ON
Message-Id: <20251028054623.2268466-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Oct 2025 05:34:34.0890 (UTC) FILETIME=[8B385EA0:01DC47CC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 05:34:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20242

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

SWUpdate has supported software updates with wfx[1] backend for a while now. But using this requires a few configurations in the image (swupdate.cfg). These series of patches enables/sets the necessary configurations required to use wfx for software updates.

For now, I'm sending this as an RFC to understand the opinions of a broader audience.

A couple notes about the implementation:
- Provides using wfx as the update backend as an option (not forced).
- Adds a new section for suricatta in the swupdate.cfg file.
- Starts SWUpdate in suricatta daemon mode at service startup (if wfx support is enabled at build).
- wfx requires a clientId per device in order to target devices (create jobs for devices). This is currently achieved with wfx-customizations package which deploys a script in the image that sets the ID in the swupdate.cfg at run time.
- The above point could be made more practical with something like an onboarding function (See [2], This is still not officially part of the CIP project yet).
- Introduces wfx.yml to set wfx specific variables.

[1] https://sbabic.github.io/swupdate/suricatta.html#support-for-wfx
[2] https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin

Changes since v1:
- Rebase to current next
- Drop carrying the patch to fix swupdate issue as its backported to
  debian
- Fix appending suricatta section in swupdate.cfg only if wfx is
  requested at build time
- Use /etc/machine-id as is for client-id in suricatta

Adithya Balakumar (5):
  SWUpdate: Use self-built SWUpdate 2025.05+dfsg-3 for trixie
  recipes-core/swupdate-config: Add suricatta section in swupdate.cfg
  wfx-customizations: Recipe to add wfx helper specific scripts into
    target
  kas/opt/wfx.yml: Set wfx specific variables
  doc/README.swupdate.md: Add section for software update with wfx

 conf/distro/cip-core-trixie.conf              |   1 +
 doc/README.swupdate.md                        | 124 ++++++++++++++++++
 kas/opt/wfx.yml                               |  20 +++
 recipes-core/images/swupdate.inc              |   3 +-
 recipes-core/swupdate-config/files/suricatta  |   1 +
 .../files/{swupdate.cfg => swupdate.cfg.tmpl} |   2 +
 .../swupdate-config/swupdate-config_0.2.bb    |  27 +++-
 .../swupdate/swupdate_2025.05+dfsg-3.bb       |  36 +++++
 .../wfx-customizations/files/override.conf    |   6 +
 .../files/wfx-generate-client-id.sh           |   9 ++
 .../wfx-customizations_0.1.bb                 |  28 ++++
 11 files changed, 254 insertions(+), 3 deletions(-)
 create mode 100644 kas/opt/wfx.yml
 create mode 100644 recipes-core/swupdate-config/files/suricatta
 rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (83%)
 create mode 100644 recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb
 create mode 100644 recipes-core/wfx-customizations/files/override.conf
 create mode 100644 recipes-core/wfx-customizations/files/wfx-generate-client-id.sh
 create mode 100644 recipes-core/wfx-customizations/wfx-customizations_0.1.bb

-- 
2.39.5




Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D342EFCC9BA
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 04:30:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33011.1773117031840870315
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 21:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 62A4UT9t3654561; Tue, 10 Mar 2026 13:30:30 +0900
X-Iguazu-Qid: 2rWgfie4lwRUfQLQJn
X-Iguazu-QSIG: v=2; s=0; t=1773117029; q=2rWgfie4lwRUfQLQJn; m=xj3+EHqFHkLicHalaAE0hZhUA7b4W2pWammG4WNjMRg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fVLXP4C2Yz4vyq; Tue, 10 Mar 2026 13:30:29 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        koshiro.onuki.h55@mail.toshiba, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com, christian.storm@siemens.com
Subject: [isar-cip-core][RFC v1 0/7] Device onboarding with wfx
Date: Tue, 10 Mar 2026 00:45:47 -0400
X-TSB-HOP2: ON
Message-Id: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Mar 2026 04:30:23.0936 (UTC) FILETIME=[9CD02C00:01DCB046]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 04:30:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22219

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Currently wfx does not handle device registry / onboarding. However, it provides a plugin system that allows to process 
incoming HTTP requests before they are handed over to wfx's internal logic. This can be leveraged to communicate with 
external systems based on certain parameters in the http request.

CIP software update WG has created a simple implementation for this purpose [1]. The concept includes wfx (running with a plugin)
and a device registry service running in the backend. This requires a few customizations on the image side which is explained 
by this patch series. This implementation is currently under the cip-playground.

Here are some notes on how the current implementation works:
- The onboarding process is essentially a configuration update handled with SWUpdate.
- The plugin only interecepts the request if the client ID is set as "onboarding" and respond back without allowing the request to 
reach wfx. Else it lets the request pass through to wfx.
- Creates a onboarding swu file with configuration file.
- Creates a DAU workflow instance (Job).
- Respond with Job ID for onboarding job to SWUpdate.
- SWUpdate queries for the job and installs the onboarding swu in the target.
- A custom progress client [2] listens to progress messages from the onboarding job and triggers a restart swupdate in the activation step.
- The plugin requires signing keys for signing onboarding swu files. Suitable keys as used on the client side must be available to the 
plugin as well. Currently the plugin uses the snakeoil keys from Debian trixie.

For now I send this as a RFC for a broader visibility to understand how this integration can be improved.

[1] https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin
[2] https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin/-/tree/master/onboarding-progress-client?ref_type=heads

Adithya Balakumar (7):
  swupdate-config-wfx: Add the required configuration of wfx based
    onboarding
  wfx-onboarding-progress-client: Custom progress client for device
    onboarding with wfx
  swupdate-config: Add custom-http-headers section in swupdate.cfg
  SWUpdate: Use the backported package for trixie
  Kconfig: Add kas menu options for wfx based onboarding
  kas/opt/wfx.yml: Consolidate wfx options into a separate kas yml file
  doc/README.swupdate.md: Add information about wfx based onboarding
    function

 Kconfig                                       | 22 +++++++++
 conf/distro/cip-core-trixie.conf              |  3 ++
 conf/distro/debian-trixie-backports.list      |  1 +
 conf/distro/preferences.trixie-backports.conf | 11 +++++
 doc/README.swupdate.md                        | 46 +++++++++++++++++++
 kas/opt/wfx.yml                               | 22 +++++++++
 recipes-core/images/swupdate.inc              |  4 --
 .../files/suricatta_wfx_onboarding.conf.tmpl  | 10 ++++
 .../files/swupdate_override.conf              |  6 +++
 .../swupdate-config-wfx_0.1.bb                | 15 ++++--
 .../files/{swupdate.cfg => swupdate.cfg.tmpl} |  2 +
 .../swupdate-config/swupdate-config_0.2.bb    | 18 ++++++--
 .../files/postinst                            |  4 ++
 .../wfx-onboarding-progress-client_0.1.bb     | 26 +++++++++++
 14 files changed, 179 insertions(+), 11 deletions(-)
 create mode 100644 conf/distro/debian-trixie-backports.list
 create mode 100644 conf/distro/preferences.trixie-backports.conf
 create mode 100644 kas/opt/wfx.yml
 create mode 100644 recipes-core/swupdate-config-wfx/files/suricatta_wfx_onboarding.conf.tmpl
 create mode 100644 recipes-core/swupdate-config-wfx/files/swupdate_override.conf
 rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (73%)
 create mode 100644 recipes-core/wfx-onboarding-progress-client/files/postinst
 create mode 100644 recipes-core/wfx-onboarding-progress-client/wfx-onboarding-progress-client_0.1.bb

-- 
2.39.5




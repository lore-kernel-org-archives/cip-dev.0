Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B1AFCC9C4
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 04:30:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33013.1773117035989755436
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 21:30:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 62A4UYsd3654921; Tue, 10 Mar 2026 13:30:34 +0900
X-Iguazu-Qid: 2rWgBS9jVzU7DV2vXV
X-Iguazu-QSIG: v=2; s=0; t=1773117034; q=2rWgBS9jVzU7DV2vXV; m=EvkPkvCqkt4wiVjscwks4wDyd1i+2FBNRCCR/QQ4I44=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fVLXV0lDpz1xnl; Tue, 10 Mar 2026 13:30:34 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        koshiro.onuki.h55@mail.toshiba, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com, christian.storm@siemens.com
Subject: [isar-cip-core][RFC v1 7/7] doc/README.swupdate.md: Add information about wfx based onboarding function
Date: Tue, 10 Mar 2026 00:45:54 -0400
X-TSB-HOP2: ON
Message-Id: <20260310044554.990348-8-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Mar 2026 04:30:24.0405 (UTC) FILETIME=[9D17BC50:01DCB046]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 04:30:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22223

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index f308d7e..e7f0f69 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -595,6 +595,52 @@ ustate:           0 (OK)
 user variables:
 ```
 
+## Device onboarding with wfx
+
+This is a simple function that onboards a device to a management backend with the help of `wfx`. The core logic is implemented as a plugin for `wfx` which intercepts "onboarding" requests and orchestrates a bunch of tasks in the backend. See [here](https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin/-/blob/master/onboarding-plugin/README.md) for more details.
+
+The onboarding plugin is maintained as a separate project [here](https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin). To setup the required services, refer to the [README](https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin#setup-services) in the project. The services in the backend include `wfx` running with the plugin and a device registration service.
+
+Clone the repository
+```
+host$ git clone https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin.git
+```
+
+Build the plugin
+```
+host$ cd onboarding-plugin
+host$ make build
+host$ cd ..
+```
+
+Setup the services with `docker-compose`, set `HOST_IP` to the IP of the host where the services are running.
+```
+host$ HOST_IP=${HOST_IP} docker compose up -d
+```
+
+Device onboarding support can be enabled with the `WFX based device onboarding` option in the `Kconfig` menu.
+
+Building images to try this similar to what's mentioned [here](https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/doc/README.swupdate.md?ref_type=heads&plain=1#L485). Boot the image as mentioned here[https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/doc/README.swupdate.md?ref_type=heads&plain=1#L521].
+
+Right after boot, `SWUpdate` queries `wfx` with a clientId of `onboarding` which is a trigger for the onboarding function to start. This can be seen in the `SWUpdate` logs:
+```
+Mar 09 16:54:55 demo swupdate.sh[413]: [INFO ] : SWUPDATE running :  [notify_helper] : Running with device ID "onboarding" on "http://WFX_HOST/api/wfx/v1"
+Mar 09 16:54:55 demo swupdate.sh[413]: [TRACE] : SWUPDATE running :  [start_suricatta] : Server initialized, entering suricatta main loop.
+```
+
+The plugin creates an onboarding artifact which is essentially a `swu` file, creates to `wfx` job to install the artifact in the target device and sends the job ID as the response to the device. The device now queries for the job and installs the artifact under `/var/wfx`.
+
+The custom [progress client](https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin/-/tree/master/onboarding-progress-client?ref_type=heads) installed in the image listens to the progress of the onboarding job and restarts `SWUpdate` once the onboarding job is complete.
+
+Now, `SWUpdate` queries `wfx` with the new client ID received during onboarding
+```
+Mar 09 17:02:02 demo swupdate.sh[545]: [INFO ] : SWUPDATE running :  [notify_helper] : Running with device ID "15d56255-111d-0c14-fed4-1af082c912da" on "http://WFX_HOST/api/wfx/v1"
+```
+
+The onboarded device is also registered with the device registration service running in the backend.
+
+Now, the new client ID can be used to target `wfx` jobs for devices.
+
 # Building and testing the CIP Core image for BBB
 
 Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
-- 
2.39.5




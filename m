Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59223F557E2
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 08:33:43 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15190.1776672769207135771
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2026 01:12:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alperen.erdogan@siemens.com header.s=fm2 header.b=WlEbqRDV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1334730-2026042008024341bb63f5dc0002071a-0uftmh@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026042008024341bb63f5dc0002071a
        for <cip-dev@lists.cip-project.org>;
        Mon, 20 Apr 2026 10:02:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alperen.erdogan@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=k/KbcMm2Om3cG/O0IIIG94dUIht9kC/zX4GKsO1F4CU=;
 b=WlEbqRDV134d5FMMevfRfNTfadO77KcmXJ3rLgJbt/FrS/AUDMGmyuk6ynlD2OkHkj+RF/
 rw6ZlGzISE5RiQ2nclYd8FhafOQTVInOVrNyKbBjBpWFCBfrouuITBtcyOP6c9I6DMXhl/Um
 RqaTCV16854VJ1UJA7m7H6IxxifUtCVsZpLbxJHg6Jl+qHRz8fei8xnMg/6WNJDPbtY+P6xl
 HGyIHT1mRom5hppYB/UJhpA0QkOEV1e7QwWLns8dj32vuGG1UP0eTlkHnnSrsRdKRE+6Nhro
 kyzBvm1VU6OxUffUTTsErPq81WtXCpFFphSCEUNP+KsowWwTjvwW0DQQ==;
From: Alperen Erdogan <alperen.erdogan@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: erhan.cakir@siemens.com,
	gokhan.cetin@siemens.com,
	jan.kiszka@siemens.com,
	Alperen Erdogan <alperen.erdogan@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] swupdate-config-wfx: make device identity configurable
Date: Mon, 20 Apr 2026 11:00:17 +0300
Message-ID: <20260420080018.7091-2-alperen.erdogan@siemens.com>
In-Reply-To: <20260420080018.7091-1-alperen.erdogan@siemens.com>
References: <20260420080018.7091-1-alperen.erdogan@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1334730:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Apr 2026 08:33:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22768

Replace hard-coded $(cat /etc/machine-id) with WFX_DEVICE_ID
template variable. Bump recipe version to 0.2.

Signed-off-by: Alperen Erdogan <alperen.erdogan@siemens.com>
---
 .../swupdate-config-wfx/files/suricatta_wfx.conf.tmpl         | 2 +-
 ...{swupdate-config-wfx_0.1.bb => swupdate-config-wfx_0.2.bb} | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)
 rename recipes-core/swupdate-config-wfx/{swupdate-config-wfx_0.1.bb => swupdate-config-wfx_0.2.bb} (86%)

diff --git a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
index f750f3d..ae7fcb5 100644
--- a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
+++ b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
@@ -1,4 +1,4 @@
 #
 # SPDX-License-Identifier: MIT
 #
-SWUPDATE_SURICATTA_ARGS="--server lua -u ${WFX_URL} -i $(cat /etc/machine-id)"
+SWUPDATE_SURICATTA_ARGS="--server lua -u ${WFX_URL} -i ${WFX_DEVICE_ID}"
diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb
similarity index 86%
rename from recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
rename to recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb
index c800c84..70a2eb6 100644
--- a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
+++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb
@@ -18,10 +18,12 @@ DEBIAN_PROVIDES := "${PN}"

 PN .= "-${MACHINE}"

+WFX_DEVICE_ID ?= "$(cat /etc/machine-id)"
+
 SRC_URI += "file://suricatta_wfx.conf.tmpl"

 TEMPLATE_FILES += " suricatta_wfx.conf.tmpl"
-TEMPLATE_VARS += " WFX_URL"
+TEMPLATE_VARS += " WFX_URL WFX_DEVICE_ID"

 do_install() {
     install -d ${D}/etc/swupdate/conf.d
--
2.43.0



Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E4FC72A4
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 08:33:33 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14773.1776672678126005410
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2026 01:11:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alperen.erdogan@siemens.com header.s=fm2 header.b=jQ19wWGz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1334730-202604200801109be2e4084500020723-0ingqf@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202604200801109be2e4084500020723
        for <cip-dev@lists.cip-project.org>;
        Mon, 20 Apr 2026 10:01:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alperen.erdogan@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZuBK/uCtLA9xQFs+pJI4U7v7P8/Y3gJBypOW1KFrFrY=;
 b=jQ19wWGzdOllBukHdeGjC+Yku22erX46n41EewF4y5BtrpUJthJzqkpQBnPGTJpmjdvkyK
 Go/WdFX9d29LLtxLt/N2CWHwbRASZ+F5s1wVqgAxXyGapXn8Vk6fQZd4mjOpCqpqFfLVvL8Y
 iDolIEYx0eIJHao2O8SxJA1zC2zvplG5U2mx6UTN4B7/kzWuqprH4f8pERoyKTM0ReXE087n
 UDQdAbsoAtY9tJBpY2XVzcV4FEPkW3wu00XA3yI+b7+Ccek+qBGjz5QFo6HnJX1SYbG8ZP6L
 1enu5jVqP6wFAW/lXPeq5irSPcy1BVCWdbWHijGsBbwFm09S2P6Uitqg==;
From: Alperen Erdogan <alperen.erdogan@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: erhan.cakir@siemens.com,
	gokhan.cetin@siemens.com,
	jan.kiszka@siemens.com,
	Alperen Erdogan <alperen.erdogan@siemens.com>
Subject: [isar-cip-core][PATCH 0/2] swupdate-config-wfx: make device identity configurable
Date: Mon, 20 Apr 2026 11:00:16 +0300
Message-ID: <20260420080018.7091-1-alperen.erdogan@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1334730:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Apr 2026 08:33:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22767

Add WFX_DEVICE_ID variable to allow configuring the wfx suricatta
device identity at build time. Defaults to $(cat /etc/machine-id).

Alperen Erdogan (2):
  swupdate-config-wfx: make device identity configurable
  doc: update wfx documentation for configurable device identity

 doc/README.swupdate.md                                        | 4 ++--
 .../swupdate-config-wfx/files/suricatta_wfx.conf.tmpl         | 2 +-
 ...{swupdate-config-wfx_0.1.bb => swupdate-config-wfx_0.2.bb} | 4 +++-
 3 files changed, 6 insertions(+), 4 deletions(-)
 rename recipes-core/swupdate-config-wfx/{swupdate-config-wfx_0.1.bb => swupdate-config-wfx_0.2.bb} (86%)

--
2.43.0



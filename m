Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833D3C433EF
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 11:12:25 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.4851.1637752344472728820
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 03:12:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AOBCLtK007245
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 12:12:22 +0100
Received: from md2dvrtc.fritz.box ([139.22.38.174])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOBCLdv009575;
	Wed, 24 Nov 2021 12:12:21 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 0/3] start-qemu.sh: Add some ease of
 use functionality
Date: Wed, 24 Nov 2021 12:12:18 +0100
Message-Id: <20211124111221.300917-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 11:12:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6987

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Fix booting of secure-boot image
Parse .config.yaml for ease of use and reduced commandline clutter

Quirin Gylstorff (3):
  start-qemu.sh: set bootindex for SECURE_BOOT
  start-qemu.sh: parse .config.yaml for ease of use
  start-qemu.sh: Simplify qemu call

 start-qemu.sh | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

-- 
2.30.2



Return-Path: <ubely@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74363C4332F
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 09:42:43 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web09.32115.1644831761602450874
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Feb 2022 01:42:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: ubely@ilbers.de)
Received: from baighyz.m.ilbers.de
 (host-80-81-17-52.static.customer.m-online.net [80.81.17.52])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8) with ESMTPSA id 21E9gbdv015308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Feb 2022 10:42:38 +0100
From: Uladzimir Bely <ubely@ilbers.de>
To: ubely@ilbers.de, cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/1] Deploy efibootguardx64.efi and bg_setenv
 from .deb package
Date: Mon, 14 Feb 2022 10:42:36 +0100
Message-Id: <20220214094237.16369-1-ubely@ilbers.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Feb 2022 09:42:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7592

This patchset allows to build efibootguardx64 package against
upcoming sbuild patchset for Isar.

Additionally, deokit stuff could be moved to do_deploy() instead of
currently used dpkg_runbuild_append().

Uladzimir Bely (1):
  Deploy efibootguardx64.efi and bg_setenv from .deb package

 recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb  | 10 ++++++++--
 .../efibootguard/files/debian/efibootguard.install     |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.20.1



Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE0BC433FE
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 16:38:24 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.18358.1636735103102004487
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 08:38:23 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1ACGcKYN021370
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 17:38:21 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.150])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACGcKWU023679;
	Fri, 12 Nov 2021 17:38:20 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.kiszka@siemens.com
Subject: [cip-dev][cip-kernel-config][PATCH 0/2] Add options for read-only
 rootfs
Date: Fri, 12 Nov 2021 17:38:18 +0100
Message-Id: <20211112163820.1701453-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 16:38:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6897

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the necessary kernel options for a read-only rootfs with
dm-verity, secure-boot and swupdate + overlay of /etc.

Quirin Gylstorff (2):
  x86/cip_qemu_defconfig: Add options for read-only rootfs
  x86/siemens_ipc227e_defconfig: Add options for read-only rootfs

 4.19.y-cip/x86/cip_qemu_defconfig        | 4 ++++
 4.19.y-cip/x86/siemens_ipc227e_defconfig | 5 ++++-
 5.10.y-cip/x86/cip_qemu_defconfig        | 4 ++++
 5.10.y-cip/x86/siemens_ipc227e_defconfig | 5 ++++-
 4 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.30.2



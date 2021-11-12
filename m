Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D0BC433F5
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 13:52:07 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.16048.1636725125493288017
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 05:52:06 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1ACDq0uJ025321
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 14:52:00 +0100
Received: from [167.87.32.54] ([167.87.32.54])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACDpxpb011271
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 14:51:59 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] start-qemu: Account for different kernel image
 names
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <7bf0d042-1a88-6a44-7fbc-02010c1f2b6e@siemens.com>
Date: Fri, 12 Nov 2021 14:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 13:52:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6895

From: Jan Kiszka <jan.kiszka@siemens.com>

This was changed in Isar a while ago, making arm64 images "vmlinux".

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 6592ac6..3f62257 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -109,7 +109,7 @@ if [ -n "${SECURE_BOOT}" ]; then
 else
 		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
 
-		KERNEL_FILE=$(ls ${IMAGE_PREFIX}-vmlinuz* | tail -1)
+		KERNEL_FILE=$(ls ${IMAGE_PREFIX}-vmlinu* | tail -1)
 		INITRD_FILE=$(ls ${IMAGE_PREFIX}-initrd.img* | tail -1)
 
 		${QEMU_PATH}${QEMU} \
-- 
2.31.1


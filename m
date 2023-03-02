Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53E9C7EE33
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 20:31:01 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.5501.1677789060160844684
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 12:31:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=KVrx/QmJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202303022030567e2353c5745692055a-vzrsi8@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202303022030567e2353c5745692055a
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 21:30:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6TZPU5gwTATXqObKFt7RMSjAfHfjFQQePhnJnDB8Sk0=;
 b=KVrx/QmJy78hN6wszu6+oF9QbCKS43YFROFo200pV4NrA5NfbLNzlY0BQhSlNR7cUIJ786
 uefzHFkAMucEK9LI0wt+fvJQcTtZ/1aaI3HCWhiEItxwHqvL72zhGRnajExZbyo8Luuckkdf
 V920ia+xpVTSYwwXslWPI43cGrDDM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 3/5] start-qemu: Add support for booting test-extended images
Date: Thu,  2 Mar 2023 21:30:52 +0100
Message-Id: <f701201bf19b1946f2a4695249828564650a3d84.1677789054.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1677789054.git.jan.kiszka@siemens.com>
References: <cover.1677789054.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 20:31:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10885

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index dd16aed9..cccc51ef 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -50,6 +50,10 @@ if [ -z "${TARGET_IMAGE}" ];then
 	fi
 fi
 
+if grep -s -q "IMAGE_TESTING: true" .config.yaml; then
+	TEST_IMAGE="-test"
+fi
+
 arch="$1"
 shift 1
 
@@ -125,7 +129,7 @@ case "${arch}" in
 		;;
 esac
 
-IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${QEMU_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${QEMU_ARCH}"
+IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${QEMU_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${QEMU_ARCH}${TEST_IMAGE}"
 
 if [ -z "${DISPLAY}" ]; then
 	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
-- 
2.35.3



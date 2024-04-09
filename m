Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584A5CD12A1
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:51 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.135729.1712668004309119386
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=kd1lPH6r;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240409130642b74e1f0c3bb2d33644-jqekmf@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240409130642b74e1f0c3bb2d33644
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6rtzSXTdif3zEhZlD9ZuguyGAo5QEudm/It/z1iPNKk=;
 b=kd1lPH6rwJ8W+ei4i/K0niL7nAKEHfphA+z0vdqU8of+sKDyKJA4dZP6G+sD2TUHA85rtb
 /6w1cho9kqdyiwibg2Mc3FLcTfAsBOdJMN34+g6shTVJ0RmKQiBj01+d9m8HmetrAox1F83H
 XEkF80zk5OcDVYP/A1AENE9NcDWdU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 15/15] start-qemu.sh: Support encrypted rootfs
Date: Tue,  9 Apr 2024 15:05:32 +0200
Message-ID: <20240409130638.559398-16-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
References: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 13:06:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15527

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 9ec0f1c..83d1274 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -21,6 +21,7 @@ usage()
 	echo "  QEMU_PATH         use a locally built QEMU version"
 	echo "  SWUPDATE_BOOT     boot swupdate image"
 	echo "  SECURE_BOOT       start a secure boot environment"
+	echo "  TPM2_ENCRYPTION   starts swtpm to encrypt the disk partitions"
 	echo "  DISTRO_RELEASE    select a specific Debian release"
 	echo "  TARGET_IMAGE      select a specific image type"
 	exit 1
@@ -35,6 +36,10 @@ if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml; then
 	TPM2_ENCRYPTION="true"
 fi
 
+if grep -s -q "IMAGE_ROOTFS_ENCRYPTION: true" .config.yaml; then
+	TPM2_ENCRYPTION="true"
+fi
+
 if [ -n "${QEMU_PATH}" ]; then
 	QEMU_PATH="${QEMU_PATH}/"
 fi
@@ -187,7 +192,7 @@ QEMU_COMMON_OPTIONS=" \
 	${QEMU_EXTRA_ARGS} \
 	"
 
-if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
+if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}${TPM2_ENCRYPTION}" ]; then
 	case "${arch}" in
 		x86|x86_64|amd64)
 			if [ -n "${SECURE_BOOT}" ]; then
-- 
2.43.0



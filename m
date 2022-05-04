Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30536C43219
	for <webhook@archiver.kernel.org>; Wed,  4 May 2022 19:46:09 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.2074.1651693565463399558
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 May 2022 12:46:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=bRtJXZOI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-294854-202205041946025bcbe39ebdf837f8e7-altbjm@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202205041946025bcbe39ebdf837f8e7
        for <cip-dev@lists.cip-project.org>;
        Wed, 04 May 2022 21:46:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=H3LAbwPwPAClZiw/dtEOjNGKWWic7d23Z2Eev3QIIss=;
 b=bRtJXZOImzamVp2KZ5WzdO4r8rrCSejynAL/Rs/VCu47TNet3yWaMRNoSPalRH/iPUkXtT
 vB0VzSeN/KhWbZa5EMsTuFzR/GiegpcNgY4xwzYYvlVmtPhUMifycbEgqzIiMkz2x6zQTwwe
 uPaiAlA6Yt14zQoHSIOHeVht7aIt4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 03/12] initramfs-abrootfs-hook: Remove obsolete
 patch
Date: Wed,  4 May 2022 21:45:51 +0200
Message-Id: 
 <ce43aec6418357fbeb6a7489725e2e9153a2d5d2.1651693560.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651693560.git.jan.kiszka@siemens.com>
References: <cover.1651693560.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 May 2022 19:46:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8242

From: Jan Kiszka <jan.kiszka@siemens.com>

Forgotten to remove in f1e559498116.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/debian-local-patch                  | 103 ------------------
 1 file changed, 103 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/debian-local-patch

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/debian-local-patch b/recipes-initramfs/initramfs-abrootfs-hook/files/debian-local-patch
deleted file mode 100644
index cd2d271..0000000
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/debian-local-patch
+++ /dev/null
@@ -1,103 +0,0 @@
---- local.orig	2020-11-18 14:42:43.540055680 +0530
-+++ local	2020-11-18 20:15:48.687164540 +0530
-@@ -1,5 +1,4 @@
- # Local filesystem mounting			-*- shell-script -*-
--
- local_top()
- {
- 	if [ "${local_top_used}" != "yes" ]; then
-@@ -152,36 +151,70 @@
- 	DEV="${real_dev}"
- }
- 
--local_mount_root()
-+local_find_by_uuid()
- {
--	local_top
--	if [ -z "${ROOT}" ]; then
--		panic "No root device specified. Boot arguments must include a root= parameter."
--	fi
--	local_device_setup "${ROOT}" "root file system"
--	ROOT="${DEV}"
-+	partitions="$1"
- 
--	# Get the root filesystem type if not set
--	if [ -z "${ROOTFSTYPE}" ] || [ "${ROOTFSTYPE}" = auto ]; then
--		FSTYPE=$(get_fstype "${ROOT}")
--	else
--		FSTYPE=${ROOTFSTYPE}
--	fi
-+	for part in $partitions; do
-+		if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
-+			local_device_setup "${part}" "root file system"
-+			ROOT="${DEV}"
-+
-+			# Get the root filesystem type if not set
-+			if [ -z "${ROOTFSTYPE}" ] || [ "${ROOTFSTYPE}" = auto ]; then
-+				FSTYPE=$(get_fstype "${ROOT}")
-+			else
-+				FSTYPE=${ROOTFSTYPE}
-+			fi
- 
--	local_premount
-+			local_premount
- 
--	if [ "${readonly?}" = "y" ]; then
--		roflag=-r
--	else
--		roflag=-w
--	fi
-+			if [ "${readonly?}" = "y" ]; then
-+				roflag=-r
-+			else
-+				roflag=-w
-+			fi
-+			checkfs "${ROOT}" root "${FSTYPE}"
- 
--	checkfs "${ROOT}" root "${FSTYPE}"
-+			# Mount root
-+			# shellcheck disable=SC2086
-+			if mount ${roflag} ${FSTYPE:+-t "${FSTYPE}"} ${ROOTFLAGS} "${ROOT}" "${rootmnt?}"; then
-+				if [ -e "${rootmnt?}"/etc/os-release ]; then
-+				image_uuid=$(sed -n 's/^IMAGE_UUID=//p' "${rootmnt?}"/etc/os-release | tr -d '"' )
-+					if [ "${INITRAMFS_IMAGE_UUID}" = "${image_uuid}" ]; then
-+						return 0
-+					fi
-+				fi
-+				umount "${rootmnt?}"
-+			fi
-+		fi
-+	done
-+	return 1
-+}
- 
--	# Mount root
--	# shellcheck disable=SC2086
--	if ! mount ${roflag} ${FSTYPE:+-t "${FSTYPE}"} ${ROOTFLAGS} "${ROOT}" "${rootmnt?}"; then
--		panic "Failed to mount ${ROOT} as root file system."
-+local_mount_root()
-+{
-+	local_top
-+	if [ ! -e /conf/image_uuid ]; then
-+		 panic "could not find image_uuid to select correct root file system"
-+	fi
-+	local INITRAMFS_IMAGE_UUID=$(cat /conf/image_uuid)
-+	local partitions=""
-+	local ret=1
-+	local timeout_uuid=0
-+	while [ "${ret}" != 0 ] && [ "${timeout_uuid}" -le 10 ]; do
-+		wait_for_udev 10
-+		partitions=$(blkid -o device)
-+		local_find_by_uuid "$partitions"
-+		ret=$?
-+		timeout_uuid="$(cat /proc/uptime)"
-+		timeout_uuid="${timeout_uuid%%[. ]*}"
-+		timeout_uuid=$((timeout_uuid - local_top_time))
-+	done
-+	if [ "${ret}" != 0 ]; then
-+		panic "Could not find ROOTFS with matching UUID $INITRAMFS_IMAGE_UUID"
-+	else
-+		return $ret
- 	fi
- }
- 
-- 
2.34.1



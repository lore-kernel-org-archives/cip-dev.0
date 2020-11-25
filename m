Return-Path: <SRS0=KF0c=E7=lists.cip-project.org=bounce+64572+5876+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E074C56201
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:55:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EBC20637
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="T+rIkgac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EBC20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5876+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id eCbBYY4521723xJHVheYyFZA; Wed, 25 Nov 2020 00:55:43 -0800
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.4268.1606294541801857881
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2020 00:55:42 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 0AP8tdiM008393
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2020 09:55:39 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.32.40])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AP8tcJV019062;
	Wed, 25 Nov 2020 09:55:39 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
        Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [cip-dev] [isar-cip-core][PATCH 2/2] Secureboot: Wait until udev populates /dev
Date: Wed, 25 Nov 2020 09:55:38 +0100
Message-Id: <20201125085538.1561-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201125085538.1561-1-Quirin.Gylstorff@siemens.com>
References: <20201125085538.1561-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZveIDjwktTXbuJYdloyzGMZQx4520388AA=
Content-Type: multipart/mixed; boundary="kjYqVyTUNH71rcDQ2O9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606294543;
 bh=xKuLgf/3AV1AJiggjQUervI0R6C2CS107hvlZFJU92U=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=T+rIkgacqL6RkVycs/SWeL6uMw8N/nKAdE3/fdjtuApQUMt1x/eqX3MpxJ72ExMMK4k
 yDS0pakhW0yPInLPOJ6OSFnLywt21ev3tEJvz+wmavdBIJ4Vj/Bbz0cnMPaHMoQSOOof/
 KmNutu9rw9YwOm8e1zriOf1StcsxAM7B9yU=

--kjYqVyTUNH71rcDQ2O9c
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

In actual physical targets like ipc227e, with the current initramfs
local file, the system drops to initramfs shell during boot.

This is due to "blkid -o device" returning empty list since the udev
has not yet created the necessary entries in /dev.

Add a timeout to reattempt finding a valid partition before giving up.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/secure-boot-debian-local-patch      | 104 +++++++++++-------
 1 file changed, 64 insertions(+), 40 deletions(-)

diff --git a/recipes-support/initramfs-config/files/secure-boot-debian-local-patch b/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
index 219578c..cd2d271 100644
--- a/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
+++ b/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
@@ -1,79 +1,103 @@
---- local	2020-07-02 14:59:15.461895194 +0200
-+++ ../../../../../../../../../../../recipes-support/initramfs-config/files/local	2020-07-02 14:58:58.405730914 +0200
+--- local.orig	2020-11-18 14:42:43.540055680 +0530
++++ local	2020-11-18 20:15:48.687164540 +0530
 @@ -1,5 +1,4 @@
  # Local filesystem mounting			-*- shell-script -*-
 -
  local_top()
  {
  	if [ "${local_top_used}" != "yes" ]; then
-@@ -155,34 +154,47 @@
- local_mount_root()
+@@ -152,36 +151,70 @@
+ 	DEV="${real_dev}"
+ }
+ 
+-local_mount_root()
++local_find_by_uuid()
  {
- 	local_top
+-	local_top
 -	if [ -z "${ROOT}" ]; then
 -		panic "No root device specified. Boot arguments must include a root= parameter."
 -	fi
 -	local_device_setup "${ROOT}" "root file system"
 -	ROOT="${DEV}"
--
++	partitions="$1"
+ 
 -	# Get the root filesystem type if not set
 -	if [ -z "${ROOTFSTYPE}" ] || [ "${ROOTFSTYPE}" = auto ]; then
 -		FSTYPE=$(get_fstype "${ROOT}")
 -	else
 -		FSTYPE=${ROOTFSTYPE}
-+	if [ ! -e /conf/image_uuid ]; then
-+		 panic "could not find image_uuid to select correct root file system"
- 	fi
-+	local INITRAMFS_IMAGE_UUID=$(cat /conf/image_uuid)
-+	local partitions=$(blkid -o device)
+-	fi
 +	for part in $partitions; do
-+			if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
-+					local_device_setup "${part}" "root file system"
-+					ROOT="${DEV}"
++		if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
++			local_device_setup "${part}" "root file system"
++			ROOT="${DEV}"
 +
-+					# Get the root filesystem type if not set
-+					if [ -z "${ROOTFSTYPE}" ] || [ "${ROOTFSTYPE}" = auto ]; then
-+							FSTYPE=$(get_fstype "${ROOT}")
-+					else
-+							FSTYPE=${ROOTFSTYPE}
-+					fi
++			# Get the root filesystem type if not set
++			if [ -z "${ROOTFSTYPE}" ] || [ "${ROOTFSTYPE}" = auto ]; then
++				FSTYPE=$(get_fstype "${ROOT}")
++			else
++				FSTYPE=${ROOTFSTYPE}
++			fi
  
 -	local_premount
-+				local_premount
++			local_premount
  
 -	if [ "${readonly?}" = "y" ]; then
 -		roflag=-r
 -	else
 -		roflag=-w
 -	fi
-+				if [ "${readonly?}" = "y" ]; then
-+						roflag=-r
-+				else
-+						roflag=-w
-+				fi
-+				checkfs "${ROOT}" root "${FSTYPE}"
++			if [ "${readonly?}" = "y" ]; then
++				roflag=-r
++			else
++				roflag=-w
++			fi
++			checkfs "${ROOT}" root "${FSTYPE}"
  
 -	checkfs "${ROOT}" root "${FSTYPE}"
-+				# Mount root
-+				# shellcheck disable=SC2086
-+				if mount ${roflag} ${FSTYPE:+-t "${FSTYPE}"} ${ROOTFLAGS} "${ROOT}" "${rootmnt?}"; then
-+						if [ -e "${rootmnt?}"/etc/os-release ]; then
-+								image_uuid=$(sed -n 's/^IMAGE_UUID=//p' "${rootmnt?}"/etc/os-release | tr -d '"' )
-+								if [ "${INITRAMFS_IMAGE_UUID}" = "${image_uuid}" ]; then
-+										return
-+								fi
-+						fi
-+						umount "${rootmnt?}"
++			# Mount root
++			# shellcheck disable=SC2086
++			if mount ${roflag} ${FSTYPE:+-t "${FSTYPE}"} ${ROOTFLAGS} "${ROOT}" "${rootmnt?}"; then
++				if [ -e "${rootmnt?}"/etc/os-release ]; then
++				image_uuid=$(sed -n 's/^IMAGE_UUID=//p' "${rootmnt?}"/etc/os-release | tr -d '"' )
++					if [ "${INITRAMFS_IMAGE_UUID}" = "${image_uuid}" ]; then
++						return 0
++					fi
 +				fi
++				umount "${rootmnt?}"
 +			fi
++		fi
 +	done
-+	panic "Could not find ROOTFS with matching UUID $INITRAMFS_IMAGE_UUID"
++	return 1
++}
  
 -	# Mount root
 -	# shellcheck disable=SC2086
 -	if ! mount ${roflag} ${FSTYPE:+-t "${FSTYPE}"} ${ROOTFLAGS} "${ROOT}" "${rootmnt?}"; then
 -		panic "Failed to mount ${ROOT} as root file system."
--	fi
++local_mount_root()
++{
++	local_top
++	if [ ! -e /conf/image_uuid ]; then
++		 panic "could not find image_uuid to select correct root file system"
++	fi
++	local INITRAMFS_IMAGE_UUID=$(cat /conf/image_uuid)
++	local partitions=""
++	local ret=1
++	local timeout_uuid=0
++	while [ "${ret}" != 0 ] && [ "${timeout_uuid}" -le 10 ]; do
++		wait_for_udev 10
++		partitions=$(blkid -o device)
++		local_find_by_uuid "$partitions"
++		ret=$?
++		timeout_uuid="$(cat /proc/uptime)"
++		timeout_uuid="${timeout_uuid%%[. ]*}"
++		timeout_uuid=$((timeout_uuid - local_top_time))
++	done
++	if [ "${ret}" != 0 ]; then
++		panic "Could not find ROOTFS with matching UUID $INITRAMFS_IMAGE_UUID"
++	else
++		return $ret
+ 	fi
  }
  
- local_mount_fs()
-- 
2.20.1


--kjYqVyTUNH71rcDQ2O9c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5876): https://lists.cip-project.org/g/cip-dev/message=
/5876
Mute This Topic: https://lists.cip-project.org/mt/78496226/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kjYqVyTUNH71rcDQ2O9c--

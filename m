Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFF2C54E49
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 07:45:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.18220.1709797557494404160
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Mar 2024 23:45:57 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4277jtnD829439; Thu, 7 Mar 2024 16:45:55 +0900
X-Iguazu-Qid: 2rWg9o4uiHTCjdeege
X-Iguazu-QSIG: v=2; s=0; t=1709797555; q=2rWg9o4uiHTCjdeege; m=cTHPZuynB6uKoZaXElZXHPuiv56N7DqOPoSyPKOGQw4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 4277jrIj996508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Mar 2024 16:45:55 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v1 4/6] Add Delta update support with rdiff_image and delta handler
Date: Thu,  7 Mar 2024 13:16:10 +0530
X-TSB-HOP2: ON
Message-Id: <20240307074612.1996609-5-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Mar 2024 07:45:48.0728 (UTC) FILETIME=[788AB380:01DA7063]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 07:45:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15256

swupdate supports delta updates with rdiff_image and delta(zchunk)
handler. This change adds support to use either of the handler
for creating delta update artifacts. The type of handler can be set
in the delta-update.yml file along with additional variables needed
for the chosen handler.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 classes/delta_update.bbclass | 90 ++++++++++++++++++++++++++++++++++++
 kas/opt/delta-update.yml     | 21 +++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 classes/delta_update.bbclass
 create mode 100644 kas/opt/delta-update.yml

diff --git a/classes/delta_update.bbclass b/classes/delta_update.bbclass
new file mode 100644
index 0000000..8d47081
--- /dev/null
+++ b/classes/delta_update.bbclass
@@ -0,0 +1,90 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation 2024
+#
+# Authors:
+#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+IMAGER_INSTALL:delta_update += "fdisk zchunk rdiff"
+
+FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}"
+IMAGE_SRC_URI:delta_update += " ${@ "file://"+d.getVar('DELTA_RDIFF_REF_IMAGE') if d.getVar('DELTA_UPDATE_TYPE') == 'rdiff' and d.getVar('DELTA_RDIFF_REF_IMAGE') else '' }"
+
+do_image_delta_update[cleandirs] += "${WORKDIR}/delta_interim_artifacts"
+
+extract_root_fs() {
+    INPUT_ARTIFACT=$1
+    OUTPUT_ARTIFACT=$2
+    SECTOR_SIZE=512
+    ROOTFS_LABEL="primary"
+    ROOTFS_START_SECTOR=$(${SUDO_CHROOT} /sbin/fdisk -l -o Name,Start "${INPUT_ARTIFACT}" | awk -v name="${ROOTFS_LABEL}" '$0 ~ name {print $2}' | head -n 1)
+    SKIP_VALUE="$(expr $(expr $ROOTFS_START_SECTOR \* $SECTOR_SIZE) / $(expr 1024 \* 1024))"
+    ${SUDO_CHROOT} /bin/dd if=${INPUT_ARTIFACT} bs=1M skip=$SKIP_VALUE count=1024 of=${OUTPUT_ARTIFACT} status=none
+}
+
+do_delta_update_sw_description_template() {
+   # Since the sw-description file for delta update would not be very different from that of a 
+   # normal update, copy sw-description.tmpl as sw-description-delta.tmpl and add delta update 
+   # specific properties
+   SWU_DESCRIPTION_DELTA_UPDATE="sw-description-delta"
+   cp "${WORKDIR}/${SWU_DESCRIPTION_FILE}".tmpl "${WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}".tmpl
+   sed -i 's/\SWU_ROOTFS_PARTITION_NAME/SWU_DELTA_UPDATE_ARTIFACT/g' ${WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}.tmpl
+   sed -i '/configfilecheck =/a \                      \'$'{SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES}' ${WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}.tmpl
+}
+addtask do_delta_update_sw_description_template before do_transform_template after do_generate_image_uuid
+
+IMAGE_CMD:delta_update() {
+    if [ "${DELTA_UPDATE_TYPE}" != "zchunk" ] && [ "${DELTA_UPDATE_TYPE}" != "rdiff" ]; then
+        bbfatal "You must set a valid DELTA_UPDATE_TYPE (rdiff/zchunk)"
+    fi
+    
+    DELTA_ARTIFACT_SWU=""
+
+    if [ "${DELTA_UPDATE_TYPE}" = "zchunk" ]; then 
+	extract_root_fs "${PP_DEPLOY}/${IMAGE_FULLNAME}.wic" "${WORKDIR}/delta_interim_artifacts/${IMAGE_FULLNAME}.raw"
+
+    	# Create .zck file
+    	${SUDO_CHROOT} /bin/zck \
+		--output ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck \
+		-u --chunk-hash-type sha256 \
+		${WORKDIR}/delta_interim_artifacts/${IMAGE_FULLNAME}.raw
+
+    	# Calculate size of zck header
+    	HSIZE="$(${SUDO_CHROOT} /bin/zck_read_header -v ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck | grep "Header size" | cut -d ':' -f 2)"
+    
+    	# Extract the zck header
+    	${SUDO_CHROOT} /bin/dd if="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck of="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck.header bs=1 count="$HSIZE" status=none
+
+        DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.zck.header
+
+    elif [ "${DELTA_UPDATE_TYPE}" = "rdiff" ]; then
+        if [ -z "${DELTA_RDIFF_REF_IMAGE}" ]; then
+            bbfatal "You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe"
+        fi
+
+	# Extracting root partition from image1
+	extract_root_fs "${WORKDIR}/${DELTA_RDIFF_REF_IMAGE}"  "${WORKDIR}/delta_interim_artifacts/old-image-rootfs.raw"
+	
+	# Extracting root partition from image2
+	extract_root_fs "${PP_DEPLOY}/${IMAGE_FULLNAME}.wic"  "${WORKDIR}/delta_interim_artifacts/new-image-rootfs.raw"	
+
+	rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta
+	# create signature file with rdiff
+	${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.raw \
+		${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig
+
+        # create delta file with the signature file
+	${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig \
+		${WORKDIR}/delta_interim_artifacts/new-image-rootfs.raw ${PP_DEPLOY}/${IMAGE_FULLNAME}.delta
+
+	DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.delta
+    fi
+        # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
+        ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
+}
+
+addtask do_image_delta_update before do_image_swu after do_image_wic
diff --git a/kas/opt/delta-update.yml b/kas/opt/delta-update.yml
new file mode 100644
index 0000000..c7a3893
--- /dev/null
+++ b/kas/opt/delta-update.yml
@@ -0,0 +1,21 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation 2024
+#
+# Authors:
+#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  delta-update: |
+    IMAGE_CLASSES:append = " delta_update"
+    IMAGE_FSTYPES:append = " delta_update"
+    DELTA_UPDATE_TYPE = ""
+    DELTA_ZCK_URL = ""
+    DELTA_RDIFF_REF_IMAGE = "" 
-- 
2.39.2




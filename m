Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76649C19F53
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 09:44:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.12883.1714038258365392129
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 02:44:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 43P9iFor1152738; Thu, 25 Apr 2024 18:44:16 +0900
X-Iguazu-Qid: 2rWhNMNebx1ufyz8e0
X-Iguazu-QSIG: v=2; s=0; t=1714038255; q=2rWhNMNebx1ufyz8e0; m=pHYnHtVqyo7JP590VV30QHqbLQtjPu8rLulTiRd0Zko=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 43P9iEOr4083735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 25 Apr 2024 18:44:15 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v4 1/3] Add Delta update support with rdiff_image and delta handler
Date: Thu, 25 Apr 2024 15:14:42 +0530
X-TSB-HOP2: ON
Message-Id: <20240425094444.404036-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 25 Apr 2024 09:44:12.0267 (UTC) FILETIME=[20D27BB0:01DA96F5]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 09:44:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15749

swupdate supports delta updates with rdiff_image and delta(zchunk)
handler. This change adds support to use either of the handler
for creating delta update artifacts. zchunk based updates are supported
only for sid.

DELTA_UPDATE_TYPE, DELTA_RDIFF_REF_IMAGE and DELTA_ZCK_URL variables can
be modified based on the update type in the swupdate.yml file.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 classes/delta-update.bbclass | 97 ++++++++++++++++++++++++++++++++++++
 conf/layer.conf              |  2 +-
 kas/opt/swupdate.yml         |  5 ++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 classes/delta-update.bbclass

diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
new file mode 100644
index 0000000..56d2231
--- /dev/null
+++ b/classes/delta-update.bbclass
@@ -0,0 +1,97 @@
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
+IMAGER_INSTALL:delta_update .= " zchunk rdiff"
+
+FILESEXTRAPATHS:prepend = "${TOPDIR}/previous-image:"
+
+DELTA_UPDATE_TYPE ??= ""
+DELTA_RDIFF_REF_IMAGE ??= ""
+DELTA_ZCK_URL ??= ""
+DELTA_PREV_IMAGE_PATH ??= "${TOPDIR}/previous-image"
+
+def disable_delta_update_tasks (d):
+    d.appendVarFlag("do_image_delta_update", "noexec", "1")
+    d.setVar("DELTA_UPDATE_TYPE", "")
+
+def delta_update_prereq_check (d):
+    import os
+    import bb
+    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
+        path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
+        if not os.path.isfile(path):
+            disable_delta_update_tasks(d)
+            bb.fatal("You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe")
+        else:
+            return "file://" + d.getVar("DELTA_RDIFF_REF_IMAGE")
+    elif d.getVar("DELTA_UPDATE_TYPE") == "zchunk":
+        if d.getVar("BASE_DISTRO_CODENAME") != "sid":
+            disable_delta_update_tasks(d)
+            bb.fatal("Zchunk based delta update is only supported from sid")
+    else:
+        disable_delta_update_tasks(d)
+    return ""
+
+SRC_URI += "${@delta_update_prereq_check(d)}"
+
+create_rdiff_delta_artifact() {
+
+    rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta
+    # create signature file with rdiff
+    ${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/${DELTA_RDIFF_REF_IMAGE} \
+        ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig
+
+    # create delta file with the signature file
+    ${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig \
+        ${PP_DEPLOY}/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} ${PP_DEPLOY}/${IMAGE_FULLNAME}.delta
+
+    DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.delta
+
+    # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
+    ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
+}
+
+create_zchunk_delta_artifact() {
+    # Create .zck file
+    ${SUDO_CHROOT} /bin/zck \
+        --output ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck \
+        -u --chunk-hash-type sha256 \
+        ${PP_DEPLOY}/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}
+
+    # Calculate size of zck header
+    HSIZE="$(${SUDO_CHROOT} /bin/zck_read_header -v ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck | grep "Header size" | cut -d ':' -f 2)"
+
+    # Extract the zck header
+    ${SUDO_CHROOT} /bin/dd if="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck of="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck.header bs=1 count="$HSIZE" status=none
+
+    DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.zck.header
+
+    # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
+    ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
+}
+
+do_image_delta_update[cleandirs] += "${WORKDIR}/delta_interim_artifacts"
+do_image_delta_update[depends] += "${PN}:do_transform_template"
+IMAGE_CMD:delta_update() {
+    case "${DELTA_UPDATE_TYPE}" in
+    "rdiff")
+        create_rdiff_delta_artifact
+        ;;
+    "zchunk")
+        create_zchunk_delta_artifact
+        ;;
+    *)
+        bbfatal "You must set a valid DELTA_UPDATE_TYPE (rdiff/zchunk)"
+        ;;
+    esac
+}
+
+addtask do_image_delta_update before do_image_swu after do_image_wic
diff --git a/conf/layer.conf b/conf/layer.conf
index 6198e1b..c652a61 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -23,5 +23,5 @@ LAYERSERIES_COMPAT_cip-core = "next"
 LAYERDIR_cip-core = "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
 
-IMAGE_CLASSES += "squashfs verity swupdate"
+IMAGE_CLASSES += "squashfs verity swupdate delta-update"
 
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index ef61e4e..7907acb 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -30,3 +30,8 @@ local_conf_header:
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
     PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
     PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
+    # delta update specific variables"
+    IMAGE_FSTYPES:append = " delta_update"
+    DELTA_UPDATE_TYPE = ""
+    DELTA_RDIFF_REF_IMAGE = ""
+    DELTA_ZCK_URL = ""
-- 
2.39.2




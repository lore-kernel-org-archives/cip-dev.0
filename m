Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFA2C05023
	for <webhook@archiver.kernel.org>; Mon, 15 Apr 2024 10:45:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.17936.1713177934152165620
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Apr 2024 03:45:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 43FAjVFX2074212; Mon, 15 Apr 2024 19:45:32 +0900
X-Iguazu-Qid: 2rWgYo6Fms1IDI6vqs
X-Iguazu-QSIG: v=2; s=0; t=1713177931; q=2rWgYo6Fms1IDI6vqs; m=NGH5Km5IByi84QABD1d1bMP+iYswap9ob7cN7W+b5wo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 43FAjUqv1070684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Apr 2024 19:45:31 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v3 1/3] Add Delta update support with rdiff_image and delta handler
Date: Mon, 15 Apr 2024 16:16:08 +0530
X-TSB-HOP2: ON
Message-Id: <20240415104610.3073497-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415104610.3073497-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240415104610.3073497-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Apr 2024 10:45:28.0859 (UTC) FILETIME=[081C66B0:01DA8F22]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Apr 2024 10:45:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15559

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
 kas/opt/swupdate.yml         |  6 +++
 3 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 classes/delta-update.bbclass

diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
new file mode 100644
index 0000000..87bf7ff
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
+IMAGER_INSTALL:delta_update .= "zchunk rdiff"
+
+FILESEXTRAPATHS:append = ":${TOPDIR}/previous-image"
+do_image_delta_update[cleandirs] += "${WORKDIR}/delta_interim_artifacts"
+
+DELTA_UPDATE_TYPE ??= "rdiff"
+DELTA_RDIFF_REF_IMAGE ??= "${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}"
+DELTA_ZCK_URL ??= ""
+DELTA_PREV_IMAGE_PATH ??= "${TOPDIR}/previous-image"
+
+def disable_delta_update_tasks (d):
+    d.appendVarFlag("do_image_delta_update", "noexec", "1")
+    d.setVar("DELTA_UPDATE_TYPE", "")
+
+def delta_update_prereq_check (d):
+    import os
+    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
+        path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
+        if not os.path.isfile(path):
+            disable_delta_update_tasks(d)
+        else:
+            return "file://" + d.getVar("DELTA_RDIFF_REF_IMAGE")
+    elif d.getVar("DELTA_UPDATE_TYPE") == "zchunk":
+        if d.getVar("BASE_DISTRO_CODENAME") != "sid":
+            disable_delta_update_tasks(d)
+    else:
+        disable_delta_update_tasks(d)
+    return ""
+
+SRC_URI += "${@delta_update_prereq_check(d)}"
+
+create_rdiff_delta_artifact() {
+    if [ -z "${DELTA_RDIFF_REF_IMAGE}" ]; then
+        bbfatal "You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe"
+    fi
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
index ef61e4e..81dbe95 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -30,3 +30,9 @@ local_conf_header:
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
     PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
     PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
+    # delta update specific variables"
+    IMAGE_FSTYPES:append = " delta_update"
+    DELTA_UPDATE_TYPE = "rdiff"
+    DELTA_RDIFF_REF_IMAGE = "${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}"
+    DELTA_ZCK_URL = ""
+
-- 
2.39.2




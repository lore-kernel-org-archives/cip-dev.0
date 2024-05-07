Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D68BC41513
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 09:14:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.7173.1715073256029667934
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 May 2024 02:14:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4479EE3M3257002; Tue, 7 May 2024 18:14:14 +0900
X-Iguazu-Qid: 2yAbNsrDJoZAUiTZpD
X-Iguazu-QSIG: v=2; s=0; t=1715073253; q=2yAbNsrDJoZAUiTZpD; m=cCW22EtjKZDBOQxVXNDXV+F4EElUPw9SNOP7gE/cSDg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4479EDMt1182850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 7 May 2024 18:14:13 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v6 1/4] Add Delta update support with rdiff_image and delta handler
Date: Tue,  7 May 2024 14:44:29 +0530
X-TSB-HOP2: ON
Message-Id: <20240507091432.895626-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507091432.895626-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240507091432.895626-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 May 2024 09:14:11.0061 (UTC) FILETIME=[EC2D4250:01DAA05E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 May 2024 09:14:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15850

swupdate supports delta updates with rdiff_image and delta(zchunk)
handler. This change adds support to use either of the handler
for creating delta update artifacts. zchunk based updates are supported
only for sid.

DELTA_UPDATE_TYPE, DELTA_RDIFF_REF_IMAGE and DELTA_ZCK_URL variables can
be modified based on the update type in the delta-update.yml file.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 classes/delta-update.bbclass | 99 ++++++++++++++++++++++++++++++++++++
 conf/layer.conf              |  2 +-
 kas/opt/delta-update.yml     | 20 ++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 classes/delta-update.bbclass
 create mode 100644 kas/opt/delta-update.yml

diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
new file mode 100644
index 0000000..c2df266
--- /dev/null
+++ b/classes/delta-update.bbclass
@@ -0,0 +1,99 @@
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
+python () {
+    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
+        if d.getVar("DELTA_RDIFF_REF_IMAGE") == "":
+            bb.fatal("You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe")
+    elif d.getVar("DELTA_UPDATE_TYPE") == "zchunk":
+        if d.getVar("BASE_DISTRO_CODENAME") != "sid":
+            bb.fatal("Zchunk based delta update is only supported from sid")
+    else:
+        disable_delta_update_tasks(d)
+}
+
+python do_fetch_delta_rdiff_ref_image () {
+    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
+        path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
+        if not os.path.isfile(path):
+            bb.fatal("No such file found: "+ path + ". Provide the required files at "+ d.getVar("DELTA_PREV_IMAGE_PATH") + " for rdiff based delta update")
+        else:
+            d.appendVar("SRC_URI", " file://" + d.getVar("DELTA_RDIFF_REF_IMAGE"))
+}
+
+do_fetch[prefuncs] += "do_fetch_delta_rdiff_ref_image"
+do_unpack[prefuncs] += "do_fetch_delta_rdiff_ref_image"
+
+create_rdiff_delta_artifact() {
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
 
diff --git a/kas/opt/delta-update.yml b/kas/opt/delta-update.yml
new file mode 100644
index 0000000..a2f583c
--- /dev/null
+++ b/kas/opt/delta-update.yml
@@ -0,0 +1,20 @@
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
+    IMAGE_FSTYPES:append = " delta_update"
+    DELTA_UPDATE_TYPE = "rdiff"
+    DELTA_RDIFF_REF_IMAGE = "${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}"
+    DELTA_ZCK_URL = ""
-- 
2.39.2




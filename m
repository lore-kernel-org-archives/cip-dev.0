Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB8CD11DB
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 10:32:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.40525.1710930713397130886
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 03:31:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 42KAVpbt1405268; Wed, 20 Mar 2024 19:31:51 +0900
X-Iguazu-Qid: 2yAaAnXldsbUhuyPku
X-Iguazu-QSIG: v=2; s=0; t=1710930711; q=2yAaAnXldsbUhuyPku; m=xPa6qIJx/zetLKo4G0mKXF0UyXooY0rWCB5AyiC87Xw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 42KAVoMm874689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Mar 2024 19:31:51 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v2 2/4] Add Delta update support with rdiff_image and delta handler
Date: Wed, 20 Mar 2024 16:02:27 +0530
X-TSB-HOP2: ON
Message-Id: <20240320103229.1078738-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Mar 2024 10:31:46.0646 (UTC) FILETIME=[CF4B2760:01DA7AB1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 10:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15381

swupdate supports delta updates with rdiff_image and delta(zchunk)
handler. This change adds support to use either of the handler
for creating delta update artifacts. zchunk based updates are supported
only for sid.

DELTA_UPDATE_TYPE, DELTA_RDIFF_REF_IMAGE and DELTA_ZCK_URL variables can
be modified based on the update type in the swupdate.yml file.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 classes/delta-update.bbclass | 107 +++++++++++++++++++++++++++++++++++
 conf/layer.conf              |   2 +-
 kas/opt/swupdate.yml         |   5 ++
 3 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 classes/delta-update.bbclass

diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
new file mode 100644
index 0000000..8443f35
--- /dev/null
+++ b/classes/delta-update.bbclass
@@ -0,0 +1,107 @@
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
+IMAGER_INSTALL:delta_update .= "fdisk zchunk rdiff"
+
+FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}"
+do_image_delta_update[cleandirs] += "${WORKDIR}/delta_interim_artifacts"
+
+DELTA_UPDATE_TYPE ??= "rdiff"
+DELTA_RDIFF_REF_IMAGE ??= "image-v1/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}"
+DELTA_ZCK_URL ??= ""
+
+def disable_delta_update_tasks(d):
+    d.appendVarFlag("do_image_delta_update", "noexec", "1")
+    d.appendVarFlag("do_delta_rdiff_ref_image_fetch", "noexec", "1")
+    d.setVar("DELTA_UPDATE_TYPE", "")
+
+python () {
+    import os
+    path = d.getVar("LAYERDIR_cip-core") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
+    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
+        if not os.path.isfile(path):
+            disable_delta_update_tasks(d)
+    elif d.getVar("DELTA_UPDATE_TYPE") == "zchunk":
+        if d.getVar("DISTRO") != "cip-core-sid":
+            disable_delta_update_tasks(d)
+    else:
+        disable_delta_update_tasks(d)
+}
+
+python do_delta_rdiff_ref_image_fetch () {
+    import bb
+    import os
+    path = d.getVar("LAYERDIR_cip-core") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
+    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
+        if os.path.isfile(path):
+            artifact_uri = "file://" + (d.getVar('DELTA_RDIFF_REF_IMAGE') or "")
+            artifact_uri_list = artifact_uri.split()
+            fetcher = bb.fetch2.Fetch(artifact_uri_list, d)
+            fetcher.download()
+            fetcher.unpack(d.getVar('WORKDIR'))
+}
+addtask do_delta_rdiff_ref_image_fetch before do_transform_template
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
index 82b4084..d4c87a6 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -23,6 +23,6 @@ LAYERSERIES_COMPAT_cip-core = "next"
 LAYERDIR_cip-core = "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
 
-IMAGE_CLASSES += "squashfs verity swupdate"
+IMAGE_CLASSES += "squashfs verity swupdate delta-update"
 
 SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index ef61e4e..50ded36 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -30,3 +30,8 @@ local_conf_header:
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
     PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
     PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
+    # delta update specific variables"
+    IMAGE_FSTYPES:append = " delta_update"
+    DELTA_UPDATE_TYPE = "rdiff"
+    DELTA_RDIFF_REF_IMAGE = "image-v1/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}"
+    DELTA_ZCK_URL = ""
-- 
2.39.2




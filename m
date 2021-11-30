Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBACC4321E
	for <webhook@archiver.kernel.org>; Tue, 30 Nov 2021 11:47:32 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.74730.1638272849968139173
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Nov 2021 03:47:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AUBlR2m025035
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 12:47:27 +0100
Received: from md2dvrtc.fritz.box ([139.22.40.121])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AUBlQAP003770;
	Tue, 30 Nov 2021 12:47:27 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RESEND PATCH 2/9] Add verity-img.bbclass for
 dm-verity based rootfs
Date: Tue, 30 Nov 2021 12:47:19 +0100
Message-Id: <20211130114726.351921-3-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130114726.351921-1-Quirin.Gylstorff@siemens.com>
References: <20211130114726.351921-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 11:47:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7043

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

As we need the output of `veritysetup` to generate
the initrd. Therefore do_verity_image must be called before wic
generates the final disk image.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/verity-img.bbclass | 73 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 classes/verity-img.bbclass

diff --git a/classes/verity-img.bbclass b/classes/verity-img.bbclass
new file mode 100644
index 0000000..3c94643
--- /dev/null
+++ b/classes/verity-img.bbclass
@@ -0,0 +1,73 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+IMAGER_INSTALL += "cryptsetup"
+
+VERITY_IMAGE_TYPE ?= "squashfs"
+VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.img"
+VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img"
+VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
+VERITY_HASH_BLOCK_SIZE ?= "1024"
+VERITY_DATA_BLOCK_SIZE ?= "1024"
+
+create_verity_env_file() {
+
+    local ENV="${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.verity.env"
+    rm -f $ENV
+
+    local input="${WORKDIR}/${VERITY_IMAGE_METADATA}"
+    # remove header from verity meta data
+    sed -i '/VERITY header information for/d' $input
+    IFS=":"
+    while read KEY VAL; do
+        printf '%s=%s\n' \
+            "$(echo "$KEY" | tr '[:lower:]' '[:upper:]' | sed 's/ /_/g')" \
+            "$(echo "$VAL" | tr -d ' \t')" >> $ENV
+    done < $input
+}
+
+verity_setup() {
+    rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
+    rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
+
+    cp -a ${DEPLOY_DIR_IMAGE}/${VERITY_INPUT_IMAGE} ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
+
+    image_do_mounts
+    sudo chroot "${BUILDCHROOT_DIR}" /sbin/veritysetup format \
+        --hash-block-size "${VERITY_HASH_BLOCK_SIZE}"  \
+        --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
+        --data-blocks "${VERITY_DATA_BLOCKS}" \
+        --hash-offset "${VERITY_INPUT_IMAGE_SIZE}" \
+        "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
+        "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
+        >"${WORKDIR}/${VERITY_IMAGE_METADATA}"
+
+    echo "Hash offset:    	${VERITY_INPUT_IMAGE_SIZE}" \
+        >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
+}
+
+do_verity_image[cleandirs] = "${WORKDIR}/verity"
+python do_verity_image() {
+    import os
+
+    image_file = os.path.join(
+        d.getVar("DEPLOY_DIR_IMAGE"),
+        d.getVar("VERITY_INPUT_IMAGE")
+    )
+    data_block_size = int(d.getVar("VERITY_DATA_BLOCK_SIZE"))
+    size = os.stat(image_file).st_size
+    assert size % data_block_size == 0, f"image is not well-sized!"
+    d.setVar("VERITY_INPUT_IMAGE_SIZE", str(size))
+    d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
+
+    bb.build.exec_func('verity_setup', d)
+    bb.build.exec_func('create_verity_env_file', d)
+}
+addtask verity_image before do_image after do_image_tools
-- 
2.30.2



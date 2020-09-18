Return-Path: <SRS0=sqOu=C3=lists.cip-project.org=bounce+64572+5462+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80B3C43464
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 08:04:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B5E2100A
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 08:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nLOgkrxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B5E2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5462+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id neiPYY4521723xU0TWo6zf8C; Fri, 18 Sep 2020 01:04:41 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.8073.1600416279521592592
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2020 01:04:40 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 08I84aEq014038
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2020 10:04:37 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.34.10])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 08I84aku006193;
	Fri, 18 Sep 2020 10:04:36 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] classes/image_uuid: Generate new uuid if a new package is added
Date: Fri, 18 Sep 2020 10:04:35 +0200
Message-Id: <20200918080435.24136-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Ie5lZDs7pVPBxrGG76KPqp1vx4520388AA=
Content-Type: multipart/mixed; boundary="TOpLJHqIBNGc6Bz5pOXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600416281;
 bh=9x53u53Ltc8W6+7obM3iVBwBibkEr/KmtAo9t/gxv/E=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nLOgkrxhWBiis4PC950z18lKhVYA+BaTMX2mSJRCmT8k+GTPEeYV4XoUjc+6uaZmGlU
 CvU1UjWpG83l2zDwkEgr7XAddv48TJbnQs8Nbjxya9KbgOaNBdtroKWgtBSJxcUISoSYS
 Tlnszch1XJ2oWKaPaaVUNbYimS7HJ9seVvU=

--TOpLJHqIBNGc6Bz5pOXu
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

BB_BASEHASH only includes the task itself and its metadata.
Dependencies are not taken into account when this hash is
generated which means updating a package will not generate a new
UUID.

BB_TASKHASH takes the changes into account.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/image_uuid.bbclass | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index d5337b8..873abc5 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -9,23 +9,23 @@
 # SPDX-License-Identifier: MIT
 #
 
-def generate_image_uuid(d):
-    import uuid
+IMAGE_UUID ?= "random"
 
-    base_hash = d.getVar("BB_BASEHASH_task-do_rootfs_install", True)
-    if base_hash is None:
-        return None
-    return str(uuid.UUID(base_hash[:32], version=4))
-
-IMAGE_UUID ?= "${@generate_image_uuid(d)}"
+IMAGE_UUID_NAMESPACE = "6090f47e-b068-475c-b125-7be7c24cdd4e"
 
 do_generate_image_uuid[vardeps] += "IMAGE_UUID"
 do_generate_image_uuid[depends] = "buildchroot-target:do_build"
+IMAGER_INSTALL += "uuid-runtime"
 do_generate_image_uuid() {
+    image_do_mounts
+    if [ "${IMAGE_UUID}" != "random" ]; then
+        IMAGE_UUID_FINAL="${IMAGE_UUID}"
+    else
+        IMAGE_UUID_FINAL="$(sudo -E chroot ${BUILDCHROOT_DIR} uuidgen -s -n "${IMAGE_UUID_NAMESPACE}" -N "${BB_TASKHASH}")"
+    fi
     sudo sed -i '/^IMAGE_UUID=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
-    echo "IMAGE_UUID=\"${IMAGE_UUID}\"" | \
+    echo "IMAGE_UUID=\"${IMAGE_UUID_FINAL}\"" | \
         sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
-    image_do_mounts
 
     # update initramfs to add uuid
     sudo chroot '${IMAGE_ROOTFS}' update-initramfs -u
-- 
2.20.1


--TOpLJHqIBNGc6Bz5pOXu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5462): https://lists.cip-project.org/g/cip-dev/message=
/5462
Mute This Topic: https://lists.cip-project.org/mt/76926695/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TOpLJHqIBNGc6Bz5pOXu--

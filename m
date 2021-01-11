Return-Path: <SRS0=b77E=GO=lists.cip-project.org=bounce+64572+6059+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F72C433DB
	for <cip-dev@archiver.kernel.org>; Mon, 11 Jan 2021 12:42:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFC4224B8
	for <cip-dev@archiver.kernel.org>; Mon, 11 Jan 2021 12:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFC4224B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6059+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lYimYY4521723xWlKMtbKr1h; Mon, 11 Jan 2021 04:42:37 -0800
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.33257.1610368872852728292
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jan 2021 04:41:14 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 10BCfAqV019430
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 11 Jan 2021 13:41:11 +0100
X-Received: from localhost.localdomain ([139.22.47.251])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10BCfAr9013996;
	Mon, 11 Jan 2021 13:41:10 +0100
From: Henning Schild <henning.schild@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Henning Schild <henning.schild@siemens.com>
Subject: [cip-dev] [isar-cip-core] [PATCH] classes: make swu image file variable absolute like the others
Date: Mon, 11 Jan 2021 13:41:04 +0100
Message-Id: <20210111124104.31067-1-henning.schild@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: h57PTM0uKcXS9MGWfjknRxWpx4520388AA=
Content-Type: multipart/mixed; boundary="OwkXOtux6ZRJ06p0NE1m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610368957;
 bh=Kh/CgWa+1nwdwHW5rnookb2cRUknXA6arxGMziOBKCE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kI+cMbsXWYnFhOPM/0pkelIa/3sgTVl4gwnp1WcpK3z57CBNJtv1rkyMhbPq5WDoeI+
 HOZtViZLwzylxorFzz82Q35Ae9lILEu+jetvtqDF4tXvZOxxTYprlZTyuT/OqrpG0GT9z
 CVmaeVYS4vN1Hf2aRAeTMLo98FKpk0HIYRU=

--OwkXOtux6ZRJ06p0NE1m
Content-Transfer-Encoding: 8bit

From: Henning Schild <henning.schild@siemens.com>

All the other variables for images already contain the deploydir
in their absolute names. Only the one for swupdate was relative.

Found this in another layer where we have a task copying deploy
files to a deploy location with bitbake.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 classes/swupdate-img.bbclass | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/classes/swupdate-img.bbclass b/classes/swupdate-img.bbclass
index a21d6ec..09e92cc 100644
--- a/classes/swupdate-img.bbclass
+++ b/classes/swupdate-img.bbclass
@@ -9,7 +9,7 @@
 #
 # SPDX-License-Identifier: MIT
 
-SWU_IMAGE_FILE ?= "${PN}-${DISTRO}-${MACHINE}.swu"
+SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${PN}-${DISTRO}-${MACHINE}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
 SWU_ADDITIONAL_FILES ?= ""
 SWU_SIGNED ?= ""
@@ -21,7 +21,7 @@ IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) e
 do_swupdate_image[stamp-extra-info] = "${DISTRO}-${MACHINE}"
 do_swupdate_image[cleandirs] += "${WORKDIR}/swu"
 do_swupdate_image() {
-    rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'
+    rm -f '${SWU_IMAGE_FILE}'
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
 
     # Create symlinks for files used in the update image
@@ -68,7 +68,7 @@ do_swupdate_image() {
             echo "$file".'${SWU_SIGNATURE_EXT}'
         fi
     done | cpio -ovL -H crc \
-        > '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'
+        > '${SWU_IMAGE_FILE}'
     cd -
 }
 
-- 
2.26.2


--OwkXOtux6ZRJ06p0NE1m
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6059): https://lists.cip-project.org/g/cip-dev/message=
/6059
Mute This Topic: https://lists.cip-project.org/mt/79594351/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OwkXOtux6ZRJ06p0NE1m--

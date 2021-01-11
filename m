Return-Path: <SRS0=zvgx=GO=lists.cip-project.org=bounce+64572+6060+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3914C43331
	for <cip-dev@archiver.kernel.org>; Mon, 11 Jan 2021 15:52:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811F022A84
	for <cip-dev@archiver.kernel.org>; Mon, 11 Jan 2021 15:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811F022A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6060+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BegdYY4521723x0V9XZRLgjp; Mon, 11 Jan 2021 07:52:34 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.36519.1610380147770832157
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jan 2021 07:49:08 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 10BFn1W2014192
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Jan 2021 16:49:01 +0100
X-Received: from localhost.localdomain ([167.87.25.4])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10BFn0bM004157;
	Mon, 11 Jan 2021 16:49:01 +0100
From: Henning Schild <henning.schild@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Claudius Heine <ch@denx.de>, Henning Schild <henning.schild@siemens.com>
Subject: [cip-dev] [isar-cip-core] [PATCH] swupdate-img.bbclass: add checksum in non signed case as well
Date: Mon, 11 Jan 2021 16:48:56 +0100
Message-Id: <20210111154856.6636-1-henning.schild@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0klokA21A0t8OyZ6XeFUjbFIx4520388AA=
Content-Type: multipart/mixed; boundary="AtQixpEHHxQC0JBaB4PO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610380354;
 bh=wuu8sKrHb/4V7uV7jOmBs2y0OINB1N7gD8qAjTSv/fg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BkB3ZvnXSoLC6FfodBAleA2LdbTN9LZNRvCQphckYWulcXQShJIMt2XlWPFv5BH/8O1
 JqBL0ht59htb8FgAppQ+LPLVTP/yRI3aETbDWPqvhevOHI7DRpTMA53GrtJzuwcZUjHFy
 6nrznrHG1MrV4nvJ3cDk56xx00LyKfFgSGI=

--AtQixpEHHxQC0JBaB4PO
Content-Transfer-Encoding: 8bit

From: Claudius Heine <ch@denx.de>

Signed-off-by: Claudius Heine <ch@denx.de>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 classes/swupdate-img.bbclass | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/classes/swupdate-img.bbclass b/classes/swupdate-img.bbclass
index a21d6ec..a7a70f6 100644
--- a/classes/swupdate-img.bbclass
+++ b/classes/swupdate-img.bbclass
@@ -39,14 +39,14 @@ do_swupdate_image() {
         image_do_mounts
         cp -f '${SIGN_KEY}' '${WORKDIR}/dev.key'
         test -e '${SIGN_CRT}' && cp -f '${SIGN_CRT}' '${WORKDIR}/dev.crt'
-
-        # Fill in file check sums
-        for file in ${SWU_ADDITIONAL_FILES}; do
-            sed -i "s:$file-sha256:$(sha256sum '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
-                '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
-        done
     fi
 
+    # Fill in file check sums
+    for file in ${SWU_ADDITIONAL_FILES}; do
+        sed -i "s:$file-sha256:$(sha256sum '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
+            '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
+    done
+
     cd "${WORKDIR}/swu"
     for file in '${SWU_DESCRIPTION_FILE}' ${SWU_ADDITIONAL_FILES}; do
         echo "$file"
-- 
2.26.2


--AtQixpEHHxQC0JBaB4PO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6060): https://lists.cip-project.org/g/cip-dev/message=
/6060
Mute This Topic: https://lists.cip-project.org/mt/79598691/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AtQixpEHHxQC0JBaB4PO--

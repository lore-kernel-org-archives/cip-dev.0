Return-Path: <SRS0=G0vn=FS=lists.cip-project.org=bounce+64572+5964+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D591BC4361B
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:45:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC6821D42
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC6821D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5964+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MNLRYY4521723xLiWcTcIB0m; Mon, 14 Dec 2020 01:45:10 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.32644.1607939109822237884
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Dec 2020 01:45:10 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 0BE9j7lq027735
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 14 Dec 2020 10:45:07 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.32.81])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0BE9j6Wg029707;
	Mon, 14 Dec 2020 10:45:07 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3] initramfs-config: remove FILESPATH
Date: Mon, 14 Dec 2020 10:45:06 +0100
Message-Id: <20201214094506.7643-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <292d014e-f372-7276-0a0e-8aaafcf5dd2f@siemens.com>
References: <292d014e-f372-7276-0a0e-8aaafcf5dd2f@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: C0tM0KR9W45OanUnfGIrRxwkx4520388AA=
Content-Type: multipart/mixed; boundary="6Fr3XlwePPuBqdSX8MUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607939110;
 bh=pVaDOQ5ioutsJHVTUZpb9vli/IzAch9Vp/jJqmdGqaI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=B1jCcGRI4Hl/XHejivxYQJE1wJFyO74D5orBWXZIlq+nLfQNjs5K7uKHvlF9F1D6KBo
 zjELfQRdFXt/fT8Y1g9M0Jq26yb79HmobNyamPzdLmVnJeyVf8UJIrsTGuTsygemwqEeq
 ZCzrcljKN0GLrDer51heiuX6Klbifg0RlzE=

--6Fr3XlwePPuBqdSX8MUn
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The file patch is wrong and not necessary.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-config/initramfs-abrootfs-secureboot_0.1.bb        | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
index 4243b41..a5e09a2 100644
--- a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
+++ b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
@@ -10,7 +10,6 @@
 
 require recipes-support/initramfs-config/initramfs-config.inc
 
-FILESPATH =. "${LAYERDIR_isar-siemens}/recipes-support/initramfs-config/files:"
 
 DEBIAN_DEPENDS += ", busybox, patch"
 
-- 
2.20.1


--6Fr3XlwePPuBqdSX8MUn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5964): https://lists.cip-project.org/g/cip-dev/message=
/5964
Mute This Topic: https://lists.cip-project.org/mt/78947302/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6Fr3XlwePPuBqdSX8MUn--

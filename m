Return-Path: <SRS0=sJ7F=FS=lists.cip-project.org=bounce+64572+5960+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FA6C4361B
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:23:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886B620771
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 09:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886B620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5960+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YTjZYY4521723xE4xkHO25WT; Mon, 14 Dec 2020 01:23:01 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.32311.1607937780064830484
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Dec 2020 01:23:00 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0BE9MwiN005135
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 14 Dec 2020 10:22:58 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.32.81])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 0BE9MvO6024395;
	Mon, 14 Dec 2020 10:22:57 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v2] initramfs-config: use correct syntax for FILESPATH
Date: Mon, 14 Dec 2020 10:22:57 +0100
Message-Id: <20201214092257.385-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <6c1a0b90-4242-987b-5802-0dcb8ea3505d@siemens.com>
References: <6c1a0b90-4242-987b-5802-0dcb8ea3505d@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lyqqnBeGW9YxshQUCChuwpy7x4520388AA=
Content-Type: multipart/mixed; boundary="zDl9dU5zF2Ysavwp77Ow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607937781;
 bh=dmUThYxRacD1w8K7QzVQb+b170HIPAnSjhguPU2Xg4c=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ioxgbFSgwGqfWM0c9YyTpnBUoIm/ODOcppjLSsQnD3aWZqqOtGaPl7zDKc+E6Gyd+jU
 8Ya5fRJV15Z8bVDHUI6EnsHQQyNk7bjxsBLQJdo0ihs6Scdb/j3J/XV063CiJLGUHcJMv
 ggRgn4AjPgH0FUFwV4Ke9EFu56IBohpr5pg=

--zDl9dU5zF2Ysavwp77Ow
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

replace the incorrect usage.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-config/initramfs-abrootfs-secureboot_0.1.bb       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
index 4243b41..3322d71 100644
--- a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
+++ b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
@@ -10,7 +10,7 @@
 
 require recipes-support/initramfs-config/initramfs-config.inc
 
-FILESPATH =. "${LAYERDIR_isar-siemens}/recipes-support/initramfs-config/files:"
+FILESEXTRAPATHS_prepend := "${FILE_DIRNAME}:"
 
 DEBIAN_DEPENDS += ", busybox, patch"
 
-- 
2.20.1


--zDl9dU5zF2Ysavwp77Ow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5960): https://lists.cip-project.org/g/cip-dev/message=
/5960
Mute This Topic: https://lists.cip-project.org/mt/78947110/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zDl9dU5zF2Ysavwp77Ow--

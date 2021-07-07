Return-Path: <SRS0=qbwy=L7=lists.cip-project.org=bounce+64572+6606+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A5BC07E9C
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE7761C9A
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE7761C9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6606+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ebZCYY4521723xS22KmdJqm7; Wed, 07 Jul 2021 05:17:15 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.20227.1625660200558273224
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 05:16:41 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 167CGcRg014167
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:39 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 167CGaEf020405
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:38 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 9/9] wic: Address y2038 warnings of latest Isar
Date: Wed,  7 Jul 2021 14:16:36 +0200
Message-Id: <0d643236aa68d265bc0b7740655dbcf01cc1f8c5.1625660195.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625660195.git.jan.kiszka@siemens.com>
References: <cover.1625660195.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7d4GLZH51PTwJtlAKaOmkc10x4520388AA=
Content-Type: multipart/mixed; boundary="11w3wZ1bIJN4Yb4QH1Yj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625660235;
 bh=e8lYii8dCLrVwhCCFGH9xMXdtrnOzscKBxbPkxJVxXc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NpFrQusrW14np2UKhCWQzLO8Tm+uLy3UOuMkSlfxFB47YcWWMKlUT/Bup/nJ3cP8OcL
 Wv1Z24hIJYPumW7OevxjMtb4bIOUaMwopvqqhlL0h+ZXr2kuCHm3pCNygKm6wXclxZCh3
 m5+l9VCM7iBM6DIr91a0bwUVAv97IaDiiwA=

--11w3wZ1bIJN4Yb4QH1Yj
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Set ext4 defaults that prevent generating y2038-affected filesystems.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 wic/bbb.wks                | 2 +-
 wic/simatic-ipc227e.wks    | 2 +-
 wic/swupdate-partition.inc | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/wic/bbb.wks b/wic/bbb.wks
index 12930a3..17b85f1 100644
--- a/wic/bbb.wks
+++ b/wic/bbb.wks
@@ -9,6 +9,6 @@
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/am335x_boneblack/MLO" --no-table --align 128
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/am335x_boneblack/u-boot.img" --no-table --align 384
 
-part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --label platform --align 1024 --active
+part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active
 
 bootloader --append "rootwait console=ttyO,115200"
diff --git a/wic/simatic-ipc227e.wks b/wic/simatic-ipc227e.wks
index 5d335a1..d0081f7 100644
--- a/wic/simatic-ipc227e.wks
+++ b/wic/simatic-ipc227e.wks
@@ -8,6 +8,6 @@
 
 part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --ondisk sda --label efi --part-type EF00 --align 1024
 
-part / --source rootfs --ondisk sda --fstype ext4 --label platform --align 1024 --use-uuid
+part / --source rootfs --ondisk sda --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid
 
 bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"
diff --git a/wic/swupdate-partition.inc b/wic/swupdate-partition.inc
index 7bec9d7..6912542 100644
--- a/wic/swupdate-partition.inc
+++ b/wic/swupdate-partition.inc
@@ -1,2 +1,2 @@
-part --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000001" --size 1000M   --extra-space 128M --overhead-factor 1 --label systema --align 1024 --fstype=ext4
-part  --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000002" --size 1000M   --extra-space 128M --overhead-factor 1 --label systemb --align 1024 --fstype=ext4
+part --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000001" --size 1000M   --extra-space 128M --overhead-factor 1 --label systema --align 1024 --fstype=ext4 --mkfs-extraopts "-T default"
+part  --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000002" --size 1000M   --extra-space 128M --overhead-factor 1 --label systemb --align 1024 --fstype=ext4 --mkfs-extraopts "-T default"
-- 
2.26.2


--11w3wZ1bIJN4Yb4QH1Yj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6606): https://lists.cip-project.org/g/cip-dev/message=
/6606
Mute This Topic: https://lists.cip-project.org/mt/84042873/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--11w3wZ1bIJN4Yb4QH1Yj--

Return-Path: <SRS0=C0Tf=L7=lists.cip-project.org=bounce+64572+6602+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E64C07E95
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE63661C9A
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE63661C9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6602+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id B1DCYY4521723xVqDoyIk2BF; Wed, 07 Jul 2021 05:17:07 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.20224.1625660199783920877
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 05:16:40 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 167CGcTk014160
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:38 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 167CGaEb020405
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:37 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 5/9] conf: Drop no longer needed DISTRO_APT_SOURCES settings
Date: Wed,  7 Jul 2021 14:16:32 +0200
Message-Id: <b0afaa12935cdfc6f358d69b24665e56556bbf32.1625660195.git.jan.kiszka@siemens.com>
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
X-Gm-Message-State: QEhIHeayGM9EtMAhjyhIKK6Kx4520388AA=
Content-Type: multipart/mixed; boundary="ykhnyo338bLihcE85hGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625660227;
 bh=zKRE40md2KdC6wawI2AkoXlRqMX6tvzfYFMFd8PuemE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=OXa0rRdXW2ORo2TGc9FvJ6cDzjP7g0T1tU64eBjLSLGCFjBBhZZEFlvCjqq9i/Wgq4j
 jQBvWhia58MzajJIrbRxeHNoJE6Kx8+sGs81tfet+gdgFwc5wpu09VDWhWEFzLcbiRV4A
 LuxtVwSLs5aDUTiS1En77/b9aloL5T3oUbw=

--ykhnyo338bLihcE85hGy
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Isar changed its debian.conf files again to make this obsolete.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-buster.conf  | 2 --
 conf/distro/cip-core-stretch.conf | 2 --
 2 files changed, 4 deletions(-)

diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-buster.conf
index ef60d24..c5cb39c 100644
--- a/conf/distro/cip-core-buster.conf
+++ b/conf/distro/cip-core-buster.conf
@@ -12,7 +12,5 @@
 require conf/distro/debian-buster.conf
 require cip-core-common.inc
 
-DISTRO_APT_SOURCES = "conf/distro/debian-buster.list"
-
 PREFERRED_VERSION_linux-cip ?= "4.19.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
diff --git a/conf/distro/cip-core-stretch.conf b/conf/distro/cip-core-stretch.conf
index ad185dd..31900fa 100644
--- a/conf/distro/cip-core-stretch.conf
+++ b/conf/distro/cip-core-stretch.conf
@@ -12,7 +12,5 @@
 require conf/distro/debian-stretch.conf
 require cip-core-common.inc
 
-DISTRO_APT_SOURCES = "conf/distro/debian-stretch.list"
-
 PREFERRED_VERSION_linux-cip ?= "4.19.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
-- 
2.26.2


--ykhnyo338bLihcE85hGy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6602): https://lists.cip-project.org/g/cip-dev/message=
/6602
Mute This Topic: https://lists.cip-project.org/mt/84042869/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ykhnyo338bLihcE85hGy--

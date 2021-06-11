Return-Path: <SRS0=ANNl=LF=lists.cip-project.org=bounce+64572+6503+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846DAC48BE5
	for <cip-dev@archiver.kernel.org>; Fri, 11 Jun 2021 14:21:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0387E61421
	for <cip-dev@archiver.kernel.org>; Fri, 11 Jun 2021 14:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0387E61421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6503+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nXshYY4521723xrV4KF8yVBQ; Fri, 11 Jun 2021 07:21:17 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.8909.1623421276648424383
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jun 2021 07:21:17 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 15BELEqf010937
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 11 Jun 2021 16:21:14 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.46.52])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 15BELCQb002059;
	Fri, 11 Jun 2021 16:21:13 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        christian.storm@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-dev][PATCH 1/2] swupdate: Update to 2021.04
Date: Fri, 11 Jun 2021 16:21:11 +0200
Message-Id: <20210611142112.2453-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210611142112.2453-1-Quirin.Gylstorff@siemens.com>
References: <20210611142112.2453-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NTCxqLa4wY2LRdnHoRYAxgNxx4520388AA=
Content-Type: multipart/mixed; boundary="utAxyvvmb1qjnz8Tr6aD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623421277;
 bh=zKZ+8D4WwZaup7m3F8qiLONxXvBCk6LUpAWPcS/88iE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dLLKllPzJJFJFvKnX8tCZ0wsH4fC0LQeeRWnTpl0LZOzJOhncMR1ly+FPCGH7QDeAfi
 e1XcgTi7X9KyZxq7BW8geuDXV/r+Adi1a/G8Aja7pYDcvOQHazBYrlY8Shmq7uiDao0xC
 SezEtOucbR5q7Bz9CWAu3PJYSTn1Xxzy+uU=

--utAxyvvmb1qjnz8Tr6aD
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The new round robin handler requires SWUpdate 2021.04
for the function `getroot`.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/swupdate/swupdate.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
index 526c72f..75eaf8d 100644
--- a/recipes-core/swupdate/swupdate.bb
+++ b/recipes-core/swupdate/swupdate.bb
@@ -15,8 +15,8 @@ LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260
 
 SRC_URI = "git://github.com/sbabic/swupdate.git;branch=master;protocol=https"
 
-SRCREV = "1a6dfbb5a0be978ac1a159758e278ab4d44167e2"
-PV = "2020.4-git+isar"
+SRCREV = "47a1246435fdb78fba15cc969596994130412956"
+PV = "2021.4-git+isar"
 
 DEFCONFIG := "swupdate_defconfig"
 
-- 
2.20.1


--utAxyvvmb1qjnz8Tr6aD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6503): https://lists.cip-project.org/g/cip-dev/message=
/6503
Mute This Topic: https://lists.cip-project.org/mt/83469365/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--utAxyvvmb1qjnz8Tr6aD--

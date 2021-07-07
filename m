Return-Path: <SRS0=pjM1=L7=lists.cip-project.org=bounce+64572+6599+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAB1C07E95
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7C461CA8
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7C461CA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6599+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id umIhYY4521723xWVLUktV44h; Wed, 07 Jul 2021 05:17:01 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.20216.1625660199336006262
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 05:16:39 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 167CGbU3014142
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:37 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 167CGaEZ020405
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:37 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 3/9] swupdate: Do not add .ini file to SRC_URI if SWUPDATE_BOOTLOADER is not set
Date: Wed,  7 Jul 2021 14:16:30 +0200
Message-Id: <b4a6f8b0e71388d56fefb458e78d7943fd6fa45c.1625660195.git.jan.kiszka@siemens.com>
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
X-Gm-Message-State: EhsVEFgj4hTTkke62nISAVMax4520388AA=
Content-Type: multipart/mixed; boundary="uqeZVElmIFEMKPd5Bgbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625660221;
 bh=0ZAIt7MwmASCFEQv8aBOmJ263OAVF7Ki3kxkrhCv9wI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=DGKQypM/HjE12iS10KV1Nk4YNxOyZcSCH6+qPDpYMbQn4VCqq6/zK1z7TFOL9m2cbOu
 BDFh6q4rCa7sLvCaaLh7mGXzGpLTUxdCLxtAXqU4iw21CNJtw7Y+KbOFHS49h9IV9ZBaA
 jlebLC/lFSlJ7L2Z7NS+P1+nj1eHDjXQbJw=

--uqeZVElmIFEMKPd5Bgbu
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

This prevents false warning during the parsing stage when swupdate is
not used, thus SWUPDATE_BOOTLOADER is not configured.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/swupdate/swupdate.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
index 4984a63..8bef9ab 100644
--- a/recipes-core/swupdate/swupdate.bb
+++ b/recipes-core/swupdate/swupdate.bb
@@ -30,7 +30,7 @@ inherit dpkg
 inherit swupdate-config
 
 SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
-SRC_URI += "file://${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG}"
+SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
 KFEATURES += "luahandler"
 
 S = "${WORKDIR}/git"
-- 
2.26.2


--uqeZVElmIFEMKPd5Bgbu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6599): https://lists.cip-project.org/g/cip-dev/message=
/6599
Mute This Topic: https://lists.cip-project.org/mt/84042866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uqeZVElmIFEMKPd5Bgbu--

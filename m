Return-Path: <SRS0=vY8d=FH=lists.cip-project.org=bounce+64572+5938+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5B4C64E8A
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 11:14:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0C322201
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 11:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0C322201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5938+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jCtKYY4521723xMwWmAEwoMI; Thu, 03 Dec 2020 03:14:12 -0800
X-Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web08.6719.1606809020295536354
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 23:50:20 -0800
IronPort-SDR: uVXvTXNeEyv8wwXTSUgV0R+iEOt9FOAodjpNFgfp91FIqwWRXzBdiS77OEL3DvpMd5Z2RSRVip
 +UusN9DZdaqpSK/VH/ZAIBaeG8OtEcCv+xxkQ8SBF/ZKX75gaqjiUrsTkg/tQjP02uRe8jsyki
 VE9G1y8kvnBednL4B+ARyLw5NNUbBQ9ucl5lFftJ/Lay2FuxRFTcAGMqnXlyQp3r/JWqOV29AZ
 bI5odJJlNP4GegWrQ0E1+bVIMb6HgmZ3eh37Q14TUnNDAUBhMf+Vd6WepLqkwIRrzxTlB+F06V
 kzs=
X-IronPort-AV: E=Sophos;i="5.78,383,1599552000"; 
   d="scan'208";a="55626128"
X-Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 30 Nov 2020 23:50:19 -0800
IronPort-SDR: vYDl4tVJVHHXrtM12lMOKiQcH+8XhbjhI7G9JYxmxBxAZm/deSE7r3CtUfOhxsPtdpWq6pK2oi
 9lEESdGhRGPkQ8RlehOxLKtUFgCtegpPLR0JlsmUOgRd8D5lPqBJuj780POTW9pi33SF8/a2E5
 2UNZfoywB+72C22JTCaDNSPL4aXTgXTsbHqWQKjTiXUxiE/I0b4Mz32po6ORUCHoGi/c/7QSql
 wPUsbc1nAxx5vhlFYr4gsQqsDPz2Zzqj4GBgZTmmj1e+7V/KAkoQRA2lWkqIlFk6D1fqjt8EoX
 fP8=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>, <Quirin.Gylstorff@siemens.com>
CC: <jan.kiszka@siemens.com>, Vijai Kumar K
	<Vijaikumar_Kanagarajan@mentor.com>
Subject: [cip-dev] [isar-cip-core][PATCH] ebg-secure-boot-secrets: Fix broken SRC_URI
Date: Tue, 1 Dec 2020 13:19:47 +0530
Message-ID: <20201201074947.24702-1-Vijaikumar_Kanagarajan@mentor.com>
MIME-Version: 1.0
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OX4YVAnEArTearvUs2mgit7Mx4520388AA=
Content-Type: multipart/mixed; boundary="7qkfjhFHae1OCJ2yhM6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606994052;
 bh=neNG1t8e8Pg0HbKBJCayL0cxbc15NjhthLvForJ65is=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=i2l5P8d8xnALmse/hz5I8kaVsnfbAC18Y3wQdBTviFCCQ88zZaPTvILRbo5N1pEIogp
 MOrD2Jzwdxucz9FQDUcoWVg5/h6th7rd6UwIHPFe8an4gLNhYEOrBgEMpsv3RxYl3nHUr
 c+/bUo7g3zTMHW/awOocxvINwpGE/4EQtco=

--7qkfjhFHae1OCJ2yhM6Y
Content-Type: text/plain

As per documentation, we need to copy the db and cert
to recipes-devtools/ebg-secure-boot-secrets/files.

SRC_URI expects file:// prefix for local files. Add that.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 .../ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb b/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
index 37b35c9..0d57910 100644
--- a/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
+++ b/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
@@ -29,8 +29,8 @@ DEBIAN_CONFLICTS = "ebg-secure-boot-snakeoil"
 SRC_URI = " \
     file://sign_secure_image.sh.tmpl \
     file://control.tmpl"
-SRC_URI_append = " ${@ d.getVar(SB_CERTDB) or "" }"
-SRC_URI_append = " ${@ d.getVar(SB_VERIFY_CERT) or "" }"
+SRC_URI_append = " ${@ "file://"+d.getVar('SB_CERTDB') if d.getVar('SB_CERTDB') else '' }"
+SRC_URI_append = " ${@ "file://"+d.getVar('SB_VERIFY_CERT') if d.getVar('SB_VERIFY_CERT') else '' }"
 TEMPLATE_FILES = "sign_secure_image.sh.tmpl"
 TEMPLATE_VARS += "SB_CERT_PATH SB_CERTDB SB_VERIFY_CERT SB_KEY_NAME"
 
-- 
2.17.1


--7qkfjhFHae1OCJ2yhM6Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5938): https://lists.cip-project.org/g/cip-dev/message=
/5938
Mute This Topic: https://lists.cip-project.org/mt/78629989/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7qkfjhFHae1OCJ2yhM6Y--

Return-Path: <SRS0=XfD5=FF=lists.cip-project.org=bounce+64572+5930+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09332C64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 10:23:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D86C20770
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 10:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sacjKDW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D86C20770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5930+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cveUYY4521723x9OdZOdkxrD; Tue, 01 Dec 2020 02:23:44 -0800
X-Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web10.8227.1606818223617436300
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 02:23:43 -0800
IronPort-SDR: P13hfRfWoV6Sb7KvD3xf9YWdqe72dSJGjp4NUXUGkdvq2p/SX7ET+oY7Oi8y72Tzh4ht87MUvg
 gJGr3W3evEyqsybNmowrHqTs9gF35necsTbbggG6ikGv6W9nLyQFrQGvMfA+aqx731rdsilXKn
 hLQvtXa+kPdjSh14P4lnmRhP2cJzosJ6pVRfkIdCd28D4Ku+FHBadF1pSCHAgJDvxN6EjS9bRN
 TJMObLZkqXwiwCSes60i1j3NquSY8LJNXPCgOfHH7RTmlYDh2Wue+LI5b0dqsS6SK+GRTj2ZWN
 4Vg=
X-IronPort-AV: E=Sophos;i="5.78,384,1599552000"; 
   d="scan'208";a="55656808"
X-Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 01 Dec 2020 02:23:43 -0800
IronPort-SDR: z98EfiGuHSSt9PFb2oTUWqa745zr5xlH/SMioJirY202nwN+f8eRsyc8HC/UKAiSYjvEg22a85
 wqKSV4+ovJgPGCbrGSe/9Fm43lJnujSrandc8DJSDGNvnqxeN0nlydB0aD/VW+k39LdzmkZZ20
 t6PzNwpkm58JkfTWJConLZ+meDyOzAfgkdGUWzH2QyaXo/wGM3/mtVrZTeh0XBHnsLBofMdQ36
 tsQUpGzGWacoh/cd2hedNdBUkIJor9HhQv7PVVtpcGO6/Vz0nb1JyV1tzJEuVLNk8ylw8Bg6ZH
 uwc=
From: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [cip-dev] [isar-cip-core][PATCH] ebg-secure-boot-secrets: Fix broken SRC_URI
Date: Tue, 1 Dec 2020 15:52:43 +0530
Message-ID: <20201201102243.28738-1-Vijaikumar_Kanagarajan@mentor.com>
MIME-Version: 1.0
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Dr0ciBJYeGXClgaLasRfLHomx4520388AA=
Content-Type: multipart/mixed; boundary="fYpFYT89CjcueJemZwkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606818224;
 bh=WIPROUq4NUGBI54IPPnQ3/NhwVFaPtQLq0NJPYNUO+w=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=sacjKDW2to5Y1OvlX9WXGOw1z4GmFjEFgHu2FafDoeTs1Ad/kFqOr3JLhSWmBy0Noc2
 nUk86TysnQsW0GNKm+cJ0JJsaTh3xYMdlSgGGGPBcgBpoOehQSA8blG0sdpP9cPbYDo8n
 PEuVNUkG9fnPe+mi8RwNqIZGr5uw03+GQ2c=

--fYpFYT89CjcueJemZwkO
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


--fYpFYT89CjcueJemZwkO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5930): https://lists.cip-project.org/g/cip-dev/message=
/5930
Mute This Topic: https://lists.cip-project.org/mt/78629989/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fYpFYT89CjcueJemZwkO--

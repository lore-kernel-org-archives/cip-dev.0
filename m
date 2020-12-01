Return-Path: <SRS0=qpun=FF=lists.cip-project.org=bounce+64572+5929+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD5C64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 10:20:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B86E20770
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 10:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="JgmgAR0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B86E20770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5929+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id K597YY4521723xlK4ARgc7Di; Tue, 01 Dec 2020 02:20:44 -0800
X-Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web10.8202.1606818043378998050
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 02:20:43 -0800
IronPort-SDR: 9drrLjX/N1qkIBT8ZEymKj4+gidOikaPQ3FCiqIS7WChI4in8v7uIAYsW4nfLB26gFkaGdYOgI
 X/olwXP8jIG23cu7OBy3nS2dGuN3Ct3VSMpOrxPa3cpGJaCoPFoanSgj52JjQcmUEzruiLpZyd
 hBv8liYTR8rin/ulUwGjIL4ugcg5J6kOCFC/gAqYUeMgLTxjOaIFJOqFcr2JwHLeA5zy8Q3fMg
 fuk1CS4fchGacp5e0C8PfcclDqzm2aLvd51Vp0ablqhZQCT43MVp2/1dU8HeklhDPfVa7t3pc4
 9mw=
X-IronPort-AV: E=Sophos;i="5.78,384,1599552000"; 
   d="scan'208";a="55771574"
X-Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 01 Dec 2020 02:20:42 -0800
IronPort-SDR: qo0gWF8HaH0pG0feELkk/fNx/Qj9Obrf+lenRqVm8zX8y4Tq0vPBsnLaJNyJ7h8lgF5fobwVLB
 sK0j02TXnqzzz+rf1Uo2iutsJHuNFedY9DbkyVgKivsJTwL3ZeXDQz2BatCQl+4nbFldZeyhnr
 7X/ZYMyKnLjUFXqoD8icN8k7umMnMYYxlexbOdO4aKTT3Us0VTQFs9h7SVmOlrv1j/qEhkIUnT
 DryDMs+3lnzVe+uDdZhSh05zI+b9+aDv0/Vd20gjdy7XnnOHFiU+cuyPq6yAkTMeoCJftMkEEi
 AdY=
From: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [cip-dev] [PATCH] ebg-secure-boot-secrets: Fix broken SRC_URI
Date: Tue, 1 Dec 2020 15:50:20 +0530
Message-ID: <20201201102020.28569-1-Vijaikumar_Kanagarajan@mentor.com>
MIME-Version: 1.0
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4eOcGv66Yd3pjijnd9aa5A7Jx4520388AA=
Content-Type: multipart/mixed; boundary="UtT2OxA6PCFbCzCU0Eos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606818044;
 bh=oQoDuIzS03L9D4Hii0QmhLcChXmyhfUngv6sxWCVBro=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=JgmgAR0XeXhun98KZglSzI1LkPykbCu/WGgAqkt6ZeKYzikmZMb5sV6RppuoK7TkOsT
 R4xeKGahBHxllw23lI6qXp5OKh2l2K+XS9lP56qGZ2ef++PkUo+VSSQslUwUQndtLNan6
 1CCp98QNgYZkJjQBeDCULVIvnzakByDFEGc=

--UtT2OxA6PCFbCzCU0Eos
Content-Type: text/plain

As per documentation, we need to copy the db and cert
to recipes-devtools/ebg-secure-boot-secrets/files.

SRC_URI expects file:// prefix for local files. Add that.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 .../ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb b/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
index dd6e303..aeb666d 100644
--- a/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
+++ b/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
@@ -25,8 +25,8 @@ DEBIAN_CONFLICTS = "ebg-secure-boot-snakeoil"
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


--UtT2OxA6PCFbCzCU0Eos
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5929): https://lists.cip-project.org/g/cip-dev/message=
/5929
Mute This Topic: https://lists.cip-project.org/mt/78629968/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UtT2OxA6PCFbCzCU0Eos--

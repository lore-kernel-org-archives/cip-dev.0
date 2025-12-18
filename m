Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F93D6E2A5
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:35 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44885.1766071945764535443
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hqBbXN0Z;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so409508f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071944; x=1766676744; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEYaBUCdktVP/dW4Sp8l7dD1cMdeiB29NTdKsl6xCS0=;
        b=hqBbXN0ZLRG7jVPlgvGrkne7AmaBRNelsYwUznoG24V8H2HrbUCGVdEVecQDCRWNMw
         Cpdk9mFBRlsSr/iS54cbjqs1W+9MwmmtFMzmsHBCTfhgKC6CPcVUIW7kxUcnbXoAzgVa
         RCiXeDrVnS3Vm6fDuigieYA5s8nuG79SZnEswZH3C4QdvclTWrlG8l3mJ9k555qjUUSW
         52U2eLfBTomA8jv0ODCdZvf/3ZGyNuSvzZ6M2nGvzlM2zdQBCcXHnjS/PKbmI2nolvKV
         TfrA2SoqbJJMGv6eauD4HHS20BG8UihHuVQE5DUFUDkU3nqCumP975SODivZb7a69qKH
         UNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071944; x=1766676744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mEYaBUCdktVP/dW4Sp8l7dD1cMdeiB29NTdKsl6xCS0=;
        b=RJeE6JqHrn0fJLp43OYS0fTg4U383zl1OFJzzia5G46azcM05UPSKoeRBfJvPsj1Os
         yGGf0cUJXl/yrp1plv4L4O/CTzID5av43/2UW5dwwsqFBQ5Lrm9VyZ4w0lPFZZt5/gIS
         8UuhKneOvmF8G5iZ+R2DflaWArNgm6aai+4c5jc7q7iiUfzheHI+jW/anLOpQuuJBP82
         qRzkyYNqRIT0WV0Jf0Q0fEMBmlvTAvl9sN/gru2XHYoOCmO9ElJUda5NJgE5Bp240ThZ
         APXZBQGMOrVoes4oJG+xcb96so6NMX7h1lmESwHexm1g+KRgngjathHhhJBjnTbYJdoL
         JrmQ==
X-Gm-Message-State: AOJu0YyZKrTnTqetlacngbE5Y3y+l7fC0VBBnHDrhDqnjC6ALnSW+jRB
	t8HdeA+DD4n9hoAkjXh1p53tnMYP/gZxEpsw+RdH4MDMVS+nOnRDGwk1sghTrA==
X-Gm-Gg: AY/fxX5sa8lrghfohPZfbeWb2PIKzv6eEIY0iQoYgx15zrGXcDEt4RG6fxl3/JjzyPq
	WgRA0kMhlCHocgbBIgA1lVRcmeHjGH7/DBZTwhhgo/Fk3jVi0j3+O95rVN17QYZBPqNfIYuWFqD
	YlZeddC9wO1D14ApP30I5cPX1TIZgvSHhYynluYPgtVVBkdC4tLh1OUzxPVd/J/PiR18H8irP9n
	ZcsATqCbpA/w5sPIDXaONAfrtLNz9KS/Y17SPcQUit1ZvT7xPZJ8HQPuj0maebbSEJ4+KP1y8l0
	ebZ8UDMla6blPGeVmIeFugfvdG8mIjMgRtULfuJNpHH2s4caL+SzWUkRdv2iUd+zAVNbQurKW4z
	wV5BZDRadppuf8MbQp+dugXR8caRJo0uG3RSYPcS3awjZfZiBfnS2+Qp0Tcvck2e9nV9lOsuBID
	ONcyKcOICW7hCTL7UACQ==
X-Google-Smtp-Source: AGHT+IFmCs1gJ4+nts0JGCj+KAm9I4sIZwM3/7QQZvay98SZKedgxz16Ne22HfylGPOz7kFy4PBtpw==
X-Received: by 2002:a05:6000:24c3:b0:430:f718:23a6 with SMTP id ffacd0b85a97d-430f71825d0mr17854643f8f.57.1766071943826;
        Thu, 18 Dec 2025 07:32:23 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:23 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 07/12] pinctrl: renesas: rzg2l: Fix PMC restore
Date: Thu, 18 Dec 2025 15:31:56 +0000
Message-ID: <20251218153219.228506-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21132

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit cea950101108b7bfffe26ec4007b8e263a4b56a8 ]

PMC restore needs unlocking the register using the PWPR register.

Fixes: ede014cd1ea6422d ("pinctrl: renesas: rzg2l: Add function pointer for PMC register write")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250921111557.103069-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 6a87da0ee50e..493c81ba4827 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -3014,7 +3014,11 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 		 * Now cache the registers or set them in the order suggested by
 		 * HW manual (section "Operation for GPIO Function").
 		 */
-		RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + PMC(off), cache->pmc[port]);
+		if (suspend)
+			RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + PMC(off), cache->pmc[port]);
+		else
+			pctrl->data->pmc_writeb(pctrl, cache->pmc[port], PMC(off));
+
 		if (has_iolh) {
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IOLH(off),
 						 cache->iolh[0][port]);
-- 
2.43.0



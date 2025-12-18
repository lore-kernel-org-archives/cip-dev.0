Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8AAD6E2AE
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:35 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44891.1766071948345910864
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AW0Xb5Mt;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2d52c24dso342508f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071946; x=1766676746; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtEPTBy2hQnjNGsWpi3O9Oio1s3cnXSslVdEMBVFxgI=;
        b=AW0Xb5Mt/P2adokcDy6IhNWoM2hfoEQ93OcvVJiDiwds90Eqxl8QkQ44goS04cLEAT
         8u9frmUP0uB0PRPYepXwNc1JCuqS2VuK6DC+6fLt26Mgm1iXvNJJeeyT7GHtOpwhTSY2
         VVXDNWcV2+fybEVoV5YwLBONvvyH6+qJ11XDDrRINpq3ol1cJr6Ef34Pv/7NPVdles0T
         66tFj9xjHODrr4nWY+Adr6QngiFWvjc9CXgPfgQAau0hOgtBRdva5UQQWUVg5C9hI1tg
         pw4L14BNInjpfRhIm0+/6Y+glioNES/wksNISFV0z/RGYy+tvrBDCtDbQPxad61YAvmt
         MVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071946; x=1766676746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RtEPTBy2hQnjNGsWpi3O9Oio1s3cnXSslVdEMBVFxgI=;
        b=QfvWxvmo+8mouuYMzSqN416Um8rcf6lzJt24EnQXEAdRN8bnLqZHEjkrwVXeTkZKx8
         fUfUfjJKzazgDt9iBb7VKYO4kuD4S4XNvMYZYn5J886dpo8kRzcX5iCQsDBrcROxsYcM
         l11h18L4W7q1y1lZVUaLHCMID8UTBAd046ozNVXK99xzmxhBUCiqSOxVRDYgjGWY811f
         Oj0NoBELWh7h3IgCoKD/1jIHRHZpuVDSPJiu72Mk1PdzW4MMbTpkQ8OtZdT/bLqPivcU
         km5t/8706NP914D7s1xmPkf4oRoznE5GT2ndS+Szflqf46MkfvVO4heIEwshPf1gs8eI
         6xUg==
X-Gm-Message-State: AOJu0Yyjf3K9MmmnbkvxRxlgzcsEZ2Xhr2Ektih1BJk7jxG5OrdCwwEO
	QnKFaiNTE3RsnNhKHgoPrA0XvGo+tanaBogBg8JP7IJLYa4VsAHr5nayJkedoQ==
X-Gm-Gg: AY/fxX6TpTuSSDBYbLA5dEaLslsUDvequwbHvHYHqeRTEoXUYqL6NCXl58rlkEMSrna
	kYqPetY+rBIMNR5U6eyG/khMzV3jQemWzKMBr1LKML2GAeZV9z57LUrlBV2QlCC4eEaXh/nr29Z
	+k02d/tk1kH3HVYCHiqLplFxSEjuXDoQ4htkDeh0q4y4nna096TzpfYb7Nv2Xvkh8VqcNmJ8hZt
	kNpScpcZFjTE2e6zUFfGJa5zzWFCa/fLDI2hrIpz/QhVaKn61WXlnSOaUvMKliqru6SRZ9QxV/j
	ZO0vhKUNekv1IgGJgSKFVTOQtN1vFSXmyuaNVkouRQCXbV2Qy/pPZDFp6iQRH0SeglrBsVWqF2T
	Fnw2vx1U3BZsx/MhCFGuvz5VRl3EvDkyr+RV6yXFd52QTzv14enJIus30aYelOj5BswNxItxgZL
	5yU+JA20ZAyxk/7GfeWw==
X-Google-Smtp-Source: AGHT+IF6471z4vZcIN+nRbREQRCNdPPJRBbmJpsQaCYrxcrhtiNJj4rBc9yIecTnzTPgJVFsiaGMiA==
X-Received: by 2002:a05:6000:2f83:b0:431:907:f307 with SMTP id ffacd0b85a97d-4310907f51bmr8836230f8f.48.1766071946233;
        Thu, 18 Dec 2025 07:32:26 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:26 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 12/12] arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI function
Date: Thu, 18 Dec 2025 15:32:01 +0000
Message-ID: <20251218153219.228506-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21137

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 4b9e0d8aa96c92be0073825344b661afc49242aa ]

The latest RZ/G3E pin control document (rev 1.2) recommends using
Schmitt input when PS0 pin used as NMI function.  Enable Schmitt input
for PS0 pin.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250817145135.166591-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index a855c2a31578..444fe4f32847 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -140,6 +140,7 @@ i2c0_pins: i2c0 {
 
 	nmi_pins: nmi {
 		pinmux = <RZG3E_PORT_PINMUX(S, 0, 0)>; /* NMI */
+		input-schmitt-enable;
 	};
 
 	scif_pins: scif {
-- 
2.43.0



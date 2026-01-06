Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B8EC47BEA
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:41:57 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87305.1767696116806998893
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 02:41:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nVr8zu//;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43277900fb4so1218681f8f.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 02:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696115; x=1768300915; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RIMT7TSQn35/W6nEY4lVq9LIUttn9JKsW9R0SyAHbs=;
        b=nVr8zu//Og354XMyDY7YcIzVlw3O07y6ub6ZHjXympJ1+UKCAB9PYIcXSL/qyzFgyF
         QULJUKmZfseWw4CIstnq6BAc59wywCqgdE84pHWQ19pTqR0FmGR+Vm9PM6ejlnfczWpo
         yUhvpRFbWDIahcIzo335MkbECvCT3ILMjAYjix/d1dvPwlez0uS2v248FoUqTERlpWS6
         C6CRvnvLhmxFIlTaW1Uy48VTYp3vZtRQTAuJvGVv1HbsC9dy4o7gUH7EHq/uOZjKB0nv
         Kc/b+85ibsMJCjFHaPPEemxdBdIrxfAvTQ3lsnIUnKfnf4mDGDEUD66VXtlC3/u5DZYK
         l2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696115; x=1768300915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2RIMT7TSQn35/W6nEY4lVq9LIUttn9JKsW9R0SyAHbs=;
        b=DO9SbGKAAXsumr93CkOPcx21as2ozm5uovdhvs5W6ga5h9JIXHqgWQMNsjk+91HDtZ
         FY6TpzTulbN/AYwaGE0BZwVISSWaY+1Y9qgIVdgko872+hTcqJXviZCPXS9W62ckSHt4
         r2W0tzZI8qRlMMg1LEVqf6p5W6ojnofbeA4xh1eoSc5kdI9FFfWijNahazMZGSDSa9NO
         S4mMfZXdd6lvwJu0Icjrd8evsM/VMIXRQtSIkvJFd28wthEDFCiwct1wG2uJ0MNDl0Fg
         bGujCyxQIgj6IUsx9dwDbzZ8QirVP5GOPlCawoekHiy5NG7FD9jZH2trojnAB8OK6Jc5
         KEZA==
X-Gm-Message-State: AOJu0YzNfIfzY8GP9vgdvQ1Lb0gZy6KJGTyJ0XdAvYAd5Rw9VXZoBQZu
	wpMgk8qZigU4rbTlRPeUoyEQzefbjjvW80H6Vg2DQOBkHexFjxAhPCx6LsAPGg==
X-Gm-Gg: AY/fxX4R4ZaZ/BGy51M74yR8vo2Z+Hb4mY9YOqaEDbuqz2BKw3PtHfw9CWhm/G+PruD
	Ed3qR1CDj2jYyJPjepMQ/aRjboOt7eL9UQmYMz1le/5OtXJRYWlfu8MxXyQidyO8TFhGgPlNUtw
	2wiUesoDs9CjXzYnSmOlhGTi7++szBGbPH39u6+CwONzwfHfnbFT+wGIXcnLm/AOuTL7iTLVclI
	yHXpR+rsiCgzcxnEffCIUefCt8neZUwGoSHRM15uYWuuvMtlVob0gbB22fyE0sYkzTKazOvHO2I
	ZGdYDhmVwE/4ujiy2FmjPLQTxr70EDwZg/clPeWfjXDWMTH9rCNZcM2VrQD0rcv61SmTa9+s1gV
	2+qw0Gxr6EMdYaG0Xstt0W6AfWwMnbpSJ+zl/ENLTh9ZBwr2Yoz7Ggt9XXmocC6Pal2BdXxkBs3
	4UrheqYleUnJaMbhcm7A==
X-Google-Smtp-Source: AGHT+IE67xSB52i6d7tIDUCS9+XXyYRGMkaRyIA5wFLYDMkKV32NOt8kFANXmhq7RJSQLIkjrTtScA==
X-Received: by 2002:a05:6000:22c7:b0:431:66a:cbda with SMTP id ffacd0b85a97d-432bcf3bfcemr2897859f8f.0.1767696114959;
        Tue, 06 Jan 2026 02:41:54 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm3583184f8f.39.2026.01.06.02.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:41:54 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 5/6] arm64: dts: renesas: r9a09g047e57-smarc: Fix gpio key's pin control node
Date: Tue,  6 Jan 2026 10:41:47 +0000
Message-ID: <20260106104151.88020-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
References: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 10:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21330

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 3e5df910b592d47734b6dcd03d57498d4766bf6c ]

Adding pin control node to the child won't parse the pins during driver
bind. Fix the issue by moving it to parent node.

This issue is observed while adding Schmitt input enable for PS0 pin on
later patch. Currently the reset value of the PIN is set to NMI function
and hence there is no breakage.

Fixes: 9e95446b0cf9 ("arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250817145135.166591-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index eed03e43ca6a..4a3153b33eb8 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -89,10 +89,10 @@ &i2c0 {
 };
 
 &keys {
-	key-sleep {
-		pinctrl-0 = <&nmi_pins>;
-		pinctrl-names = "default";
+	pinctrl-0 = <&nmi_pins>;
+	pinctrl-names = "default";
 
+	key-sleep {
 		interrupts-extended = <&icu 0 IRQ_TYPE_EDGE_FALLING>;
 		linux,code = <KEY_SLEEP>;
 		label = "SLEEP";
-- 
2.43.0



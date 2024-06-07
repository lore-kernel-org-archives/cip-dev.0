Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01272C27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:51 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.42702.1717769262113333879
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=USBkdw3V;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a20c600a7so2412670a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769260; x=1718374060; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y+MY8k/pnVTlSarxHN/WqPvm6+TlqgzmOV+6G8YjoA=;
        b=USBkdw3VDkDwt6hxGnQ+TOjs+zuNdbBe/p4mVk2gj666Hy7X/xCMSTEHfrrzDnvl45
         9G73Vl48SjXDY/qDRtJ7in9fyTY+TphXx4gNN9wyjsh2sUV/hUQj+tBIVcTd5YAD5T5q
         Lwb/7YzpMRfPJDXEm1md9i/JECYOH3eVpyZLVcRAWVhNG3cfZNHK8LupWwd2ZlD3CfcY
         KSdTtJOYzb3iNKobmMZQjul7DpwuHv3CyinoC0L2wzTgr+wZuvstsIlB7nD7x3Q2TrTd
         vlZZtbiMvOIVuKAVndTjWpk59ncxGl6ScbtDuiqFG4AJXEoLbj/TQySIjUn9JbLOrfEh
         xExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769260; x=1718374060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y+MY8k/pnVTlSarxHN/WqPvm6+TlqgzmOV+6G8YjoA=;
        b=X/wGVUZrWFBG1j3vdFffTz4KQkIjDfzYJU+tci8Xb59hkputKIzo8ANf4fKMi7xHxr
         YuPvFcST6VyK1THCQFd2lDrByZ+/Y31ffPWemBaJZuyW7AjYkdAfVOy16UGFpDMr7fm3
         Zd+nl8Ns0bF/EUlEL2ryrDOjVYsr6BF2e4JNCp9PVOfIVYxYD7emkUd04PJot1sYress
         o77D8MBJDrkGDBGmk9JhX7Pam4WoCl26pgAZ5DjbH++vx3GfQf6FUxt+wLLkR7xSCU2J
         OMCo7JXnuXSoeBAu2JocOFKMt6/2WbEyeb27Cmk0kWAw5fTErM4zp4YEv8psZ5MqXSvH
         Aqkg==
X-Gm-Message-State: AOJu0Yz87pImw3eWVx6cIDnXqwp2jIiNubV5G0yGwUDK7Mpm3YqGHhU+
	nwWUgPPrM+K17Y2LedGSgjJeJUoVB8nYJWUobsEVGRzmhjf2tp8Sqmqdy4XdyuY=
X-Google-Smtp-Source: AGHT+IGSuCEs4lYzH/1ItfX7kUw+rXIeR0gPFkjfZxUyVpM/rX/4D/TFMjVs9goQ3/96gRxrJl3Znw==
X-Received: by 2002:a50:9b46:0:b0:57a:243c:202 with SMTP id 4fb4d7f45d1cf-57c509817aamr1653910a12.32.1717769260582;
        Fri, 07 Jun 2024 07:07:40 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 18/19] arm64: dts: renesas: r9a08g045: Add PSCI support
Date: Fri,  7 Jun 2024 17:07:10 +0300
Message-Id: <20240607140711.2497286-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16159

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 145f33d1f1db869da15beff664f2c787fc94541f upstream.

Add PSCI support to enable suspend/resume with the help of TF-A.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240208135629.2840932-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 6315ffa6c1bb..aba6b0383778 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -42,6 +42,11 @@ extal_clk: extal-clk {
 		clock-frequency = <0>;
 	};
 
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-- 
2.39.2



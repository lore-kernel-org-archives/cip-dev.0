Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BDC10611F8
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:51 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18703.1773227141308586518
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=IljXITPj;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485445e80bdso15817285e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227140; x=1773831940; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cAirLql7+DAYJjr1pvJrQ7ypMF0RKONtD+7+XXW7Do=;
        b=IljXITPjkms6OPIrCtbJoMgDExkzhquAN+KHdMoAeONKweqYKVUz51/ALFYconQAyh
         5mE6L2N0LyCfAgJP1M1h1lpbkqZRkAHoTZkmMaX88EfnkH/B28X961pu9dG7R3rJKCu4
         FCtPVm7ADfI4TtwIVYBUzys+mIAN8axTPjDhy2hDPL0XxTdYTpKf/cStkXp9VawCbfcT
         kzNhELxjEq/CGD4H63DM6dOMjErh7gCvTlLavOnSrQm9qq+UmeOXbVb9KLWpeYrOABXQ
         jeZVOQBNF1S/cJmJ+oazS+S0qwwg19rIEKN9py/pZaPyGSgTp4DTGkJMLq0+HtVKmAsn
         Apig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227140; x=1773831940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6cAirLql7+DAYJjr1pvJrQ7ypMF0RKONtD+7+XXW7Do=;
        b=WZAn9M/GYiD8zrf+KkRdDbxvHzjFD9hQz1hooCzCcfjFctmxAvJDCvKmNMtAh5hQfS
         M2DrOoVj+V2q876sMYLdHqO2YTqpZ9KApXlNeahzR84cwD0VDg6a7AxXb4WI/uQW3TYw
         gIWinp384KapYaoHkDrztEi0r86zWquFRABdIM5rVeUDtSmhmf6pF1eW1UZdsH1iP/xC
         eyVOsfBKSbFqiSe42cgiHuVUwK00JjSU3yxNCr62ilKz5dOikJUF9PPfeUKahgPBEqKk
         87qRVAS9b6nYZjo16vtMwRUYmilKySmr5EnBdWHXOn4YMKv8EiVFiSgLFGkKHiPcHIiw
         Uucw==
X-Gm-Message-State: AOJu0YyvuklvmT3nNaiGZD8RmHuNWUupmzbXN1CkaYBt6qxc/owNAUqT
	z0bWP2rePR+1OpCDLN2GZqLCl5AFH61/YpU4LBUHHDYNzt9ru40lDSa9wfB9+t9q9bU=
X-Gm-Gg: ATEYQzwGHALd37HcTe+xVXejWAq7mhksg8Z+xO5PG1bPlP+s6Lv9vgTD7mMcqrgcDj/
	fm5qwCYc7/FKoAbcEvfruOSd7U3ErIaqS9CdtCIMON/Nd9vEUSHbREqp/3mxVw4WdnSm3qmkPrj
	8oZ21R57/Ne/Jrz5f/TA+sVxzTaYjbleHi/hK1e0P0idKyZHWBqAznSfBJTJm77dJ9937e8t28C
	i809iAuGBuXQmWR6XzWit+WmGg7goVrr5g5RJyopTRh4nPrZdf9xTR4CPYtzFLwLCMx2GzVgYMQ
	jmbDkh08Q9RSjB2LN5gzolk2gWIExCIz1rYPNBMszsorDGDywF2+HDmkGEY2lLaTBv/ej8rZmwI
	9sha9xL/htjEnBT9wi819UCF0OyeeH7+Fk0EkUkZk4eAsB2PV8V2vyQ8wLYpTCZQK3rVTRRqhVU
	/sdup+WGZmagtQ5BsloWjT3bAnwXXNTZkZcKe5KxHskCAmHDsRhphR
X-Received: by 2002:a05:600c:3b99:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-4854b10cf7emr35487265e9.20.1773227139616;
        Wed, 11 Mar 2026 04:05:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:38 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 13/17] arm64: dts: renesas: r9a08g045: Use syscon compatible for the system controller
Date: Wed, 11 Mar 2026 13:05:16 +0200
Message-ID: <20260311110520.1938414-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22321

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ/G3S PCIe driver needs the system controller syscon to be able to set
its registers. For this, it uses syscon_node_to_regmap(). But, in v6.1
CIP, the syscon_node_to_regmap() returns ERR_PTR(-EINVAL) if the node
for which it is called don't have the syscon compatible.

Add syscon compatible for the system controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index b9255a7d52c6..d01f7c9e8e92 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -473,7 +473,7 @@ cpg: clock-controller@11010000 {
 		};
 
 		sysc: system-controller@11020000 {
-			compatible = "renesas,r9a08g045-sysc";
+			compatible = "renesas,r9a08g045-sysc", "syscon";
 			reg = <0 0x11020000 0 0x10000>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0



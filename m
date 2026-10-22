Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23302.1792676430704816335
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2026 06:40:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=okUTC2tJ;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso19744225e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676429; x=1793281229; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63QI94CPtdBo2PuOI7DGuvOhgePK5L/yROTzGitS94w=;
        b=okUTC2tJ7Ew4iD0WMjYnAEPjS56ygKxMkV+tLuKIdnmRVsTDCxMtFQ1Chwlql5pUWX
         +McCS+vl2whC5wrLE6ezGljNnM40M3EqmGe8kg1FK9bqwmLq7kHDng5UFqyh0weuNQvs
         fxUIySAl9zQddQ6//QuTNOIfVdhAK9z/lJZC/D/TO8sKvzOLUGnt4+ygM7rhLhkr2HT+
         ZbDBteQTFCeVLdWV+ANL7ozhT+PETcnltueR7GY/EuHpa7P4JY+GsziAA0903wcgv1OC
         da3DtIsHZmc8RF1NUDajND7Vwhsk9hNE3zB2wAPjG7LmMx1cuA/RiHM07FN4LOoVUzeK
         IVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676429; x=1793281229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=63QI94CPtdBo2PuOI7DGuvOhgePK5L/yROTzGitS94w=;
        b=QYCZUAczEegzbPmy6LX2C+T+Aa3dh4kMRUoXWtX8YfpZwqP7ERToaD2DXspkkqJb3/
         RW3r1uSiig83uvay6qHeKN2F17tj1uiE5qZ4gbiXKLJ2uGoiifdnmg3pdZTu2O6nZI2L
         OU5vOqmFQZ1wCm8rfYvSivrv56l9tekCEOcY1XzcA59YBhglGANsyDjvqlJOZKp8s2+v
         GNwp+JH9a7R6DNRK608pXg+Y9oUu1ci1dhxSJSnuBWowzdh+S9HqFOEPd6eqX7+llO9O
         YTIKZgGHhmW+yQ4E46BNXnQ6rkfRXvcSjBGQAHvsW8/pezeIrv1uoHXeRQhoA1vVf9/6
         /6Ig==
X-Gm-Message-State: AFq9FYK3S9l4fOvXzyCv8EOPw5Cst38QrEkcV+yS0y5iyef8rmRHLBHN
	kLb5FTGXBBTnDdP0lMWNQcrho3sY/VnJ5SrSrfcwWONbkNwyfgCse8POzPNHrw==
X-Gm-Gg: AYBFou1kEjfIndF9dbVDjlWxE7zpK3kC3gzx2Z+02b+OfiyF1Mv7bGRZr4JYvgHVGVs
	DH/fp/72hgOh9uTa6Y26GMSgL7eiSjhi0EbWJhTk36Y+oyFiu5iryZD4IPErFwgqIw0kd8sHvlI
	ZGReyrdBUpzidUhyKect5KGO0vKH+KI2sF8jsS75DccyWBfd6EBujnIUVVZOpmS90TWuHTYWi16
	+qAxaeARxeus51tQljlX4VDhEf3zZdqonSyK5Bqyr+4YWJX+I5r/9laRgNQqK8ONY1JcA6bg98B
	vsVGLkIYQHAvaxAnHBvBnGlcEyDtq+SUGwdgCQCLdwK/kvxM/9rfISwewc5rj2Y7OUvpgHx7dZf
	pkX/DEtwNbhy/HaBEPsAXsfrtkx9EszPCip/bqJeu/e0mYdV7yJLhIobxUU4Ij8B0aG4FD4MbZA
	+nYv9MyJi0+oZkfT4EdfrTzhq0idSoXOvBq7tQqoiwAbbOjXbw9GfP7ceAZpibHJf9/AuaNK770
	kNPHD+84ZVU8NDywIPRcu15vkczHHIdjYIkVh03kDhfi+dir+YbIKmu4jUwoocUPbTYsHDr3/ux
	3i35lVsQrZleoKiXjwc5U4RVs+r0Vg==
X-Received: by 2002:a05:600c:8b72:b0:4a1:8efb:c9ae with SMTP id 5b1f17b1804b1-4a1fdd2b8e4mr95416865e9.23.1792676428824;
        Thu, 22 Oct 2026 06:40:28 -0700 (PDT)
Return-Path: <biju.das.au@gmail.com>
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3c4e:ba43:9a8e:7e31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203963f3fsm82888415e9.2.2026.10.22.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:40:27 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a08g046l48-smarc: Enable rsci{1,2,3} nodes
Date: Thu, 22 Oct 2026 14:40:13 +0100
Message-ID: <20261022134021.217964-5-biju.das.au@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134021.217964-1-biju.das.au@gmail.com>
References: <20261022134021.217964-1-biju.das.au@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 13:40:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24513
Content-Type: text/plain; charset="utf-8"

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 4fb32d9e4836c33ea9861f7c3e57beab6f546eb1 ]

Enable rsci{1,2,3} device nodes for the RZ/G3L SMARC EVK.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260529125442.327290-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
index c1c36f7529597..5289efd1a430a 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
@@ -13,6 +13,7 @@
 #define SW_DPI_EN		0
 #define SW_GPIO4		1
 #define SW_I3C_EN		0
+#define SW_SER0_PMOD		1
 
 #define PMOD_GPIO4		0
 #define PMOD_GPIO6		0
@@ -37,6 +38,9 @@ / {
 	aliases {
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		serial0 = &rsci2;
+		serial1 = &rsci3;
+		serial2 = &rsci1;
 		serial3 = &scif0;
 	};
 
@@ -134,6 +138,30 @@ i2c3_pins: i2c3 {
 			 <RZG3L_PORT_PINMUX(2, 1, 4)>; /* RIIC3_SDA */
 	};
 
+	rsci1_pins: rsci1 {
+		pinmux = <RZG3L_PORT_PINMUX(D, 4, 5)>, /* RSCI1_RXD_MISO_SCL */
+			 <RZG3L_PORT_PINMUX(D, 5, 5)>, /* RSCI1_TXD_MOSI_SDA */
+			 <RZG3L_PORT_PINMUX(D, 6, 6)>, /* RSCI1_CTS */
+			 <RZG3L_PORT_PINMUX(D, 7, 5)>; /* RSCI1_SS_CTS#_RTS# */
+		bias-pull-up;
+	};
+
+	rsci2_pins: rsci2 {
+		pinmux = <RZG3L_PORT_PINMUX(7, 6, 5)>, /* RSCI2_RXD_MISO_SCL */
+			 <RZG3L_PORT_PINMUX(7, 7, 5)>, /* RSCI2_TXD_MOSI_SDA */
+			 <RZG3L_PORT_PINMUX(8, 0, 6)>, /* RSCI2_CTS */
+			 <RZG3L_PORT_PINMUX(8, 1, 5)>; /* RSCI2_SS_CTS#_RTS# */
+		bias-pull-up;
+		power-source = <1800>;
+	};
+
+	rsci3_pins: rsci3 {
+		pinmux = <RZG3L_PORT_PINMUX(8, 2, 5)>, /* RSCI3_RXD_MISO_SCL */
+			 <RZG3L_PORT_PINMUX(8, 3, 5)>; /* RSCI3_TXD_MOSI_SDA */
+		bias-pull-up;
+		power-source = <1800>;
+	};
+
 	rspi2_pins: rspi2 {
 		pinmux = <RZG3L_PORT_PINMUX(6, 0, 2)>, /* RSPI2_MISO */
 			 <RZG3L_PORT_PINMUX(6, 1, 2)>, /* RSPI2_MOSI */
@@ -155,6 +183,37 @@ ssi0_pins: ssi0 {
 	};
 };
 
+#if SW_SER0_PMOD
+&rsci1 {
+	pinctrl-0 = <&rsci1_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+
+	status = "okay";
+};
+#endif
+
+#if !SW_DPI_EN
+&rsci2 {
+	pinctrl-0 = <&rsci2_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+
+	status = "okay";
+};
+#endif
+
+#if (!SW_DPI_EN)
+&rsci3 {
+	pinctrl-0 = <&rsci3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+#endif
+
 #if !SW_DPI_EN
 &rspi2 {
 	pinctrl-0 = <&rspi2_pins>;
-- 
2.43.0


Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B0FD7096
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:34 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73582.1773746250126477524
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HmhBeNK2;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48540355459so53953425e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746248; x=1774351048; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5FHxy7K2nukqibMIhiUrRWz9Ox8LViZ4Y0p7HJXJ60=;
        b=HmhBeNK29lAQYn083CeJin02Whst9eB9e+bEuofs2/U3fSbrdybm+voZM4Eqmf4zN7
         dTqH0w2l7R/moNOdmiT5SEunoRjyLjjup/42jPkpFY/20igPp/Vk3vZYVpO1GxaKYwXK
         2kXOqZZHjD9OoD1NDt4iN7AhB9OY/lqAM8eqgMuMJ+zBHUk9ZdMobTdQfdrNhJrkXoBf
         FmTD71ofbhPakNkJwCmye36PbV+Qyr5VK0FhFexhIrtw1tpUuvKkwY2PBLIwgn1SdvAW
         Zc51s6r5InU+pPLzxVnidjtSTO1eLrtmuhim47nqL17y1VVac/jtTF7vjuxrGrrGra3N
         D+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746248; x=1774351048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5FHxy7K2nukqibMIhiUrRWz9Ox8LViZ4Y0p7HJXJ60=;
        b=aXdPq2EOWuq8UF+L4rEkjoPcVUHJIfsfjGxLoQ/i8pLY+kxDwRNineKCU+bjWLLPh4
         u85TeZZVOhi8g0uCjpvsenXOfMF6lDFxZRXkNsRnCSGfQmzO4myg2PxWPOVRyeG6Rm+s
         125EvXlGW1ehxl3mLgdLzuIRw8weSq9rYdV8pWvp7KcHF2RGuOBhTe/ngmtSMcc3oWuE
         rEibYX1aGrnQfPDZOOQ/osyIKtSlM+iJ+bEOgdIk9oJpx+vuzUCN7Kbg+Xrlcld5O6+n
         HInJvf336s07+C1q9p5koNM6XRTWTylgle2dL+cRz0vXzK1sof97nO4iNIlmBDUilX/x
         9KUw==
X-Gm-Message-State: AOJu0YyFSruzK06B+42JETLtMQOZJC1tRzJdahNV960OBLJxnqmiq4R7
	/aqq26bBMnxgkXSxye1K0YZ6fXxhgPhi1ZOQsVfX7V4Dbe2OT/Af2FXqz5ldQw==
X-Gm-Gg: ATEYQzw/I0ophhDkg8As0SOe4QUPEOQYjfH9vu3B5IYJvTlU9cqdxIiQFZfoJonC8hV
	EENFl+b+NAGOEXeY+GFQfu2jOTW//cvLVo55yBHeE8hPVPSpOYFKs9BoBQJhms47E38PThB7HBB
	NgrjAKswSE7pkWRBUqY0CYIQ9mUhfFbChJmrdrjGvgDsx2OopcIG5EXMuPVFZsvOWILOXbHsFHD
	33Nt7ZbVpq+dYtE/LGbRKdIfjcg1xRzT0da1ABVg0HGke2sco6h93HXnMwG6txV2tP3RBK47IqP
	I4ks0HYmwFjXxveOwRpQg5mSg6DsaH0K5jaqOFxbCnTUqqrt52oOXrkY3jHdsF8dKcnA0gxBjka
	H2+mMXEBG3F9N08Cv+qSjxrt2lgP2ux5zXKYi/lUXqw8LNKGIPSwLDRMuERlP7R7n48JDsE8Xf+
	IadJkErytrTO6Oumi2fF1ZmxBslrYk6QRNa27W4B5rKjQDT/mENHS0YYoX6Ak=
X-Received: by 2002:a05:600c:1f8b:b0:485:3c66:e21d with SMTP id 5b1f17b1804b1-485566d2fa1mr298372685e9.2.1773746248136;
        Tue, 17 Mar 2026 04:17:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:27 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 11/39] serial: add PORT_GENERIC definition
Date: Tue, 17 Mar 2026 11:16:36 +0000
Message-ID: <20260317111718.281633-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22444

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit c7c5be58620a3b1e5fbaf4daea59f2eb6f8fe034 ]

Current pattern in the linux kernel is that every new serial driver adds
one or more new PORT_ definitions because uart_ops::config_port()
callback documentation prescribes setting port->type according to the
type of port found, or to PORT_UNKNOWN if no port was detected.

When the specific type of the port is not important to the userspace
there's no need for a unique PORT_ value, but so far there's no suitable
identifier for that case.

Provide generic port type identifier other than PORT_UNKNOWN for ports
which type is not important to userspace.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20231008001804.889727-1-jcmvbkbc@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/uapi/linux/serial_core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 3ba34d8378bd..5f19ff08f36c 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -276,4 +276,7 @@
 /* Sunplus UART */
 #define PORT_SUNPLUS	123
 
+/* Generic type identifier for ports which type is not important to userspace. */
+#define PORT_GENERIC	(-1)
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.43.0



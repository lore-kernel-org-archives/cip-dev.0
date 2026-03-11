Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A3510611E0
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:29 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18272.1773227060838418803
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=DSrXkuB6;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so30470035e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227059; x=1773831859; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU+7NFJRxaCZD4DpYEkbrDqWfN0jDht6gnrrYBOpap4=;
        b=DSrXkuB61BuMlHY80VFAXj+txloqUmjDGIci15BiUBNBBsRFUpYhLQC/fcsX4CtLHZ
         98krE2mvq0/8IkzeE0XvajKfoQfPzYa/CTa7XPnuEvVAztDnQzBnVg7HLELvEFpvYYAL
         oIJeunokFv9IHnUalM84TED5iSPVhyEURiSwnyGCNFr3qlu/kMkGyr3kqaSU2xJs5tWS
         HkY+ao9HDeJhDFFWJoTZtUl0NwVaPc84+Xe45aVv9oorNMsfFh8kqcx+KmEF/MLUfnQ2
         phbV52iaxGJXdr+SFnuHZzYfDqiakxZxMGFQvU4lvf4VNhDPE8xuasTh2H3xO1KZ4E6F
         aG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227059; x=1773831859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FU+7NFJRxaCZD4DpYEkbrDqWfN0jDht6gnrrYBOpap4=;
        b=M/l0Z7Kp7f8BZk7sF7Vrz1QFcYaWFo/MRr2qUTsCPpqumG7dPaFQuX5zZUDW76Mka8
         rdS/pwqD53LzBOWtYE7c5do7D213UDircIqzLcv5MTEovrgSDSJ6AHQ7hOQjfzHdXFr+
         u2QZ7oH3TFMT+weS0iK6bGn16cg6dD5BWla91F++QndlW6Ogs91ytWCDZY0Mo4XOMWLz
         5caW/pJ2P841Sma1JXuTCAagy80hgjUqwdUtizzp6mILwPKUGiIoiSML/Rb1sEkM6YUb
         Qlnxf2Rx5snDOJL/ytVzC0/250/rSXao5qQpkvfFxM5PdCaaG+QQ1YdBbpCYw2AEea1R
         voqg==
X-Gm-Message-State: AOJu0Yxwe8d4RXcF+XQduDR9XbRtEdeLVnKIJkz6seD7Cs+SBknLQVxa
	bHoxkAFB7c7n0nQqiZAr9bVnWh6b6wBy9N+G5u8n2xe6u9srz7GlCxRtSMyV7f2CH3E=
X-Gm-Gg: ATEYQzxExz6zZQlVpXaenbn3v4t31lTpJCCBKvyHA2eVnIUE8AooaEHkbQ3ekOUm4/t
	IphAET1U28KaLhKhMkAVQmvW8ldnv+EvVZR2eayzht3wAeC0coLc4A5efbDdDNzsNi5jUlemOq5
	z4jPEQsuf0wOCnZdpIkmdUpVqpUc4Wa+6cJwI079bOHQb3I+rFeqNK52nMNZkTpfSz3wwWMP9xE
	v7e/8IRUGIBn39zeWboYKHJzi3QtHHwsxRQvSL5b0e504lyRU3Sagz0wyqmryf2uW+jHeDbE2Tc
	oiSXnje62CGEg5WmQ314MLaKqZCPZR58Fd9SW9XMZOg51N59BgCDefLLP7WBMJAbcG5vfnY1rbp
	Xw2z1/8syOOvh3SAhdNf6BLgH4obvJ+4HxUfd99cdxoTRD2Zrpu5fZ2WbF+Bf8ryhXo5DpN9fxV
	Xu4nNVtqHkhkqhbUSoWLdb+OdUcQnI3oxv1xQApVnlv1maN1EvVqPc
X-Received: by 2002:a05:600c:3551:b0:485:3f72:324d with SMTP id 5b1f17b1804b1-4854b0cabe4mr36727745e9.14.1773227059130;
        Wed, 11 Mar 2026 04:04:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:18 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 15/28] of/irq: Allow matching of an interrupt-map local to an interrupt controller
Date: Wed, 11 Mar 2026 13:03:44 +0200
Message-ID: <20260311110357.1938200-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22294

From: Marc Zyngier <maz@kernel.org>

commit c12346543a7850d20ff70923ce12b60ef81a8416 upstream.

of_irq_parse_raw() has a baked assumption that if a node has an
interrupt-controller property, it cannot possibly also have an
interrupt-map property (the latter being ignored).

This seems to be an odd behaviour, and there is no reason why we should
avoid supporting this use case. This is specially useful when a PCI root
port acts as an interrupt controller for PCI endpoints, such as this:

  pcie0: pcie@690000000 {
      [...]
      port00: pci@0,0 {
	  device_type = "pci";
	  [...]
	  #address-cells = <3>;

	  interrupt-controller;
	  #interrupt-cells = <1>;

	  interrupt-map-mask = <0 0 0 7>;
	  interrupt-map = <0 0 0 1 &port00 0 0 0 0>,
			  <0 0 0 2 &port00 0 0 0 1>,
			  <0 0 0 3 &port00 0 0 0 2>,
			  <0 0 0 4 &port00 0 0 0 3>;
      };
  };

Handle it by detecting that we have an interrupt-map early in the parsing,
and special case the situation where the phandle in the interrupt map
refers to the current node (which is the interesting case here).

Link: https://lore.kernel.org/r/20210929163847.2807812-3-maz@kernel.org
Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rob Herring <robh@kernel.org>
[claudiu.beznea: made the code in this patch be executable only for the
 Renesas RZ/G3S SoC]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/of/irq.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index fe88a23240f5..691e72598f70 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -102,6 +102,14 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	const __be32 *tmp, *imap, *imask, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
 	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
 	int imaplen, match, i, rc = -EINVAL;
+	static const char * const renesas_socs[] = {
+		"renesas,r9a08g045", /* Renesas RZ/G3S */
+		NULL
+	};
+	bool renesas = false;
+
+	if (of_machine_compatible_match(renesas_socs))
+		renesas = true;
 
 #ifdef DEBUG
 	of_print_phandle_args("of_irq_parse_raw: ", out_irq);
@@ -160,12 +168,17 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 	/* Now start the actual "proper" walk of the interrupt tree */
 	while (ipar != NULL) {
-		/* Now check if cursor is an interrupt-controller and if it is
-		 * then we are done
+		/*
+		 * Now check if cursor is an interrupt-controller and
+		 * if it is then we are done, unless there is an
+		 * interrupt-map which takes precedence.
 		 */
+		imap = of_get_property(ipar, "interrupt-map", &imaplen);
 		if (of_property_read_bool(ipar, "interrupt-controller")) {
-			pr_debug(" -> got it !\n");
-			return 0;
+			if ((renesas && !imap) || !renesas) {
+				pr_debug(" -> got it !\n");
+				return 0;
+			}
 		}
 
 		/*
@@ -177,8 +190,6 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 			goto fail;
 		}
 
-		/* Now look for an interrupt-map */
-		imap = of_get_property(ipar, "interrupt-map", &imaplen);
 		/* No interrupt map, check for an interrupt parent */
 		if (imap == NULL) {
 			pr_debug(" -> no map, getting parent\n");
@@ -259,6 +270,13 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		out_irq->args_count = intsize = newintsize;
 		addrsize = newaddrsize;
 
+		if (renesas) {
+			if (ipar == newpar) {
+				pr_debug("%pOF interrupt-map entry to self\n", ipar);
+				return 0;
+			}
+		}
+
 	skiplevel:
 		/* Iterate again with new parent */
 		out_irq->np = newpar;
-- 
2.43.0



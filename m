Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FC9CDB474
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 00:22:12 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
 by mx.groups.io with SMTP id smtpd.web11.269839.1697583660443876819
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Oct 2023 16:01:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dVMsHg7U;
 spf=pass (domain: gmail.com, ip: 209.85.221.173, mailfrom: djkirsch326@gmail.com)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-49d39f07066so2627005e0c.0
        for <cip-dev@lists.cip-project.org>; Tue, 17 Oct 2023 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697583659; x=1698188459; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aOij4Rn5ozAYC/xaktJnewmfwxtNFuLqbYYOx4qcnY=;
        b=dVMsHg7U0obEmuHJzs2cABGiBCwHiwbX+N3IKaT5JOWqic+YxcrHbeXUxoPyhJjwUw
         a2Giw48nnTwEHaybyE+3xIWKIWvAKLhCknyaSf3Yx44ZRJr96tK3rhSoDxdeM3e7isLc
         HgbEnXRDjUnY5+22LAERQkN/u/Bigs5w3/rnjsNodRodnVBpBg/tP9+QcMkXCCbKrZ/J
         xeaxi38BdxlO8PvCww1lkZ/2oMmkQvzBULh4HT1VYaw05Oyf4BuuOUCafn5cr67DD/Xq
         wpzFVWqbFieIJrq/mt/JuM6XEgZpFUK/FxHnds2Kvo7A/sdlv2CN4i+iiLv3sWfu4W+I
         sxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697583659; x=1698188459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aOij4Rn5ozAYC/xaktJnewmfwxtNFuLqbYYOx4qcnY=;
        b=O1FXsAyzTASHjoO7Yl/Tl5V6d6tJwa90g6gOxbFw964QeP3lH1hlIT6dLkJveOSQX4
         9zoydRO/gsjP/OV7Y4ArucJSuS2fksAD3bCzXjva0aFoq74f59DExjNZsve5Swqmxw/b
         27ZunECDWTIbxfzX/kevhoy2+9yZl1DIlFq2aelwGa0ugIMhi/Osz5OPyF/zPl2A4qft
         tSqEjFjhvtwmqD9NM1CcRKjNobbqKUynOsw9ssilv2hILcAqtXaTiTKxKEekWGwWT4Ln
         PiTH7eovMwZI7mbrPDEyAOmCcaEnDjV2kibw1KZ0+aJUwtfdMcQPkKc6h3HdpUqZukNa
         J/Yw==
X-Gm-Message-State: AOJu0YzoHdrJsXBhvH2UYRGSqsz4q0vuP/VLc5cvsLMzRfsJmr2sW8FR
	llo9msLBaJtyTQktLTE7af111/oKZyKzBw==
X-Google-Smtp-Source: AGHT+IEhU1vD8v1m+ekF+ucRRBJmFG7TIm5dIPxv294gQblXA7bAn4MVUEtsbs+xYURNwuIgPPStnA==
X-Received: by 2002:a1f:a658:0:b0:49a:bff1:23 with SMTP id p85-20020a1fa658000000b0049abff10023mr3686790vke.5.1697583658923;
        Tue, 17 Oct 2023 16:00:58 -0700 (PDT)
Received: from localhost.localdomain (ool-4573ff95.dyn.optonline.net. [69.115.255.149])
        by smtp.googlemail.com with ESMTPSA id fv21-20020a05622a4a1500b004197079f2f8sm963664qtb.64.2023.10.17.16.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 16:00:58 -0700 (PDT)
From: Daniel Kirsch <djkirsch326@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: Daniel Kirsch <djkirsch326@gmail.com>
Subject: [4.4.y-cip, PATCH] powerpc/prom: fix build
Date: Tue, 17 Oct 2023 18:59:15 -0400
Message-Id: <20231017225915.45448-1-djkirsch326@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Oct 2023 00:22:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13401

A missing include generated a implicit function declaration error
when compiling for PowerPC. This patch fixes the build.

Signed-off-by: Daniel Kirsch <djkirsch326@gmail.com>
---
 arch/powerpc/kernel/prom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d040662e4c16..cc03dab1eb64 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -34,6 +34,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/jump_label.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
-- 
2.39.3



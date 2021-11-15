Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6563C433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:34 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web12.24750.1636993233820531416
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=coidG+EQ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.171,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pg1-f171.google.com with SMTP id r5so9097224pgi.6
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fu1ZwHDvpZi9jq3+hed5IRsIxvqULgbBYlnr/kEPFy0=;
        b=coidG+EQEp7aaz3FPrQ/jJiCvvWuETfLs7caNRVyDJzriPizf2vZlUTkjFUv2uQY7R
         vuCnvcTHJ5IOG6i8HkvsBLMGeF9v4HDUumcmTIT8UVHsuHOJPoFpcu1ZJku6ONW0lVQM
         +YXATm7UfzlgXkcE9QD/IfxyUtgVThYKsIv3Xcfiim/dQi/YlAtRr2y9/0XVYGRUAfwG
         mZWtAHwyFCdvD7RPiwKfbtVHg7NX/7aqHAbIwZiT+saV15UqtN/gVNUeXj8oKhyCNoyR
         kfuyzmhvtaSVnyqKNoXL0dTfvAon1j3QCXcS7aq/vsS5TrXJWW4Y1yzYYang1dIX6/3O
         J4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fu1ZwHDvpZi9jq3+hed5IRsIxvqULgbBYlnr/kEPFy0=;
        b=lmNGMrziN0VDov4zAerVF2YAGTZFQiEmj2Olo1ccmzD39B8J7xYW/F+wiWByEXN2CB
         aYXrI20f6ggAJ9jmxihfg5+YGp0Z/BiCwJFMmh3Eerd8Nyy6PVXRvTc3ZpvUjH/SC1R5
         sEgNpEG4BvxOjjkkFhfv2Mzpq5DergxZZzRptrzLx7YsW6WbK4rLb7a1mAPgcb+4dQCW
         PFZmMzGy74CKkQAIF5Z/8Nd3mT9j9oZttto9xKdImcISK2H6QmOvmVc3kyy2F8sXyYLS
         ST7p88Ee0AE4HiX7W2i7pVBrUxh1YtzX6vW4Rgsb3wg4sIaYpG8ZZCnvfGXfuZImZJBS
         Piyg==
X-Gm-Message-State: AOAM5319a6hpnhXAkCTuC87Vun7pPT7jKqsdzBqH7pMSnkax1O2egYo+
	G0zocVcUfyyfaX53chkMHBfQiqzmnhi8tJI=
X-Google-Smtp-Source: 
 ABdhPJwMjV6tFzANDccHOXdIUjIhZhziLi2to/KWX32yTgUYQ2vhr55VUV91DRL4La4nYz7tLliPQw==
X-Received: by 2002:aa7:99cf:0:b0:49f:9d3c:ac0f with SMTP id
 v15-20020aa799cf000000b0049f9d3cac0fmr34352046pfi.39.1636993233399;
        Mon, 15 Nov 2021 08:20:33 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:32 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 08/11] Remove root password
Date: Tue, 16 Nov 2021 01:17:21 +0900
Message-Id: <20211115161724.19516-9-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6911

KernelCI require the image to login automatically without
root password for testing.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 recipes-core/kernelci-customizations/files/postinst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-core/kernelci-customizations/files/postinst
index 33faaeb..68ef9d3 100644
--- a/recipes-core/kernelci-customizations/files/postinst
+++ b/recipes-core/kernelci-customizations/files/postinst
@@ -14,8 +14,16 @@
 
 echo "CIP Core Demo & Test Image" > /etc/issue
 
+# permit root login without password
 echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
 echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
+passwd root -d
+
+# serial getty service for autologin
+mkdir -p /etc/systemd/system/serial-getty@.service.d/
+echo "[Service]" > /etc/systemd/system/serial-getty@.service.d/override.conf
+echo "ExecStart=" >> /etc/systemd/system/serial-getty@.service.d/override.conf
+echo "ExecStart=-/sbin/agetty --autologin root --keep-baud 115200,38400,9600 %I $TERM" >> /etc/systemd/system/serial-getty@.service.d/override.conf
 
 HOSTNAME=demo
 echo "$HOSTNAME" > /etc/hostname
-- 
2.33.1



Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D42C433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:39 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web08.24761.1636993238292250385
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=xTatHn4J;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.172,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pf1-f172.google.com with SMTP id 8so3556248pfo.4
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpNNBhzx+EkkmLyYUt8Ys1hUWbKadF//lbTRS+QvB7U=;
        b=xTatHn4J5hZ55d+cBdrPWMaFp73zL1wFvqo5/wFuUR+poqwUrvepNT8ZUXW9CH0/Hm
         FxN4/A+R3Bat+B7NgdkR3Ze75VLFCRyckS5ASumqUMoh2ibyf/FEmon26+m88lWtf5LI
         GZ5dFWJCu+x7dkOekWSqU22rJiW1NpBpEb1nSfN0PlzDozZzXpeDQ54B0V6RLh1d95Xk
         eh5j4UsvmZFdD4jfDgxzuB5TW5kOu/FU5OPYIyIbwuhLrzDm/NdgdqcbfIotswzu8AGD
         peqp/gzrcVRBfPyyRjKBNLnuT5HVgTsuiN7f37U47vz6bFankFngOZPHVhALb7Q8m3as
         c/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpNNBhzx+EkkmLyYUt8Ys1hUWbKadF//lbTRS+QvB7U=;
        b=SuNu4bjxarepvF6QJAjXM2TWXJyHvenhIvhUOVq9Uu5oZJSUiq+qYhlfltMKmZ436z
         NQ4+eLqKTodIZ6Jbfnoac1j+YGXIckJid6TzJ8MrEGguJGlNwqQgew1aNMpx6I782R6t
         nR3XD2BybqRQj9HmWoyjF2qipB6MK0qRN/vdzILNsbArh9s0BfRSk/goVAk1iS5zaPY5
         x69z1XWeFe95oncDgYhoN1OnqaIjiPIbwlWnlq+FxfmfnitkMCfTOlLTOqorpz32v7yl
         Oqo/dV7K/n7UkY002w4FELREeZVPmGRVvmljLcOKUnjv7pY+FL7oUh8i1qdrH6HH1df+
         Y7/w==
X-Gm-Message-State: AOAM533TO2qGLBzF0LMdMZMpHZE+s6OLdvxIXFIPSClaPXu6oHCZiJ14
	Wvb8ZZZPX4n3GqPY/IfVERahWlKk/oI4TL8=
X-Google-Smtp-Source: 
 ABdhPJzCDVI8mIdGyq5SFssG2vqJp2yLfUE5n21ZfbB5E6nUuQD1Awm2NVXL1xF1kY52nV2Folpj4g==
X-Received: by 2002:a63:6806:: with SMTP id d6mr34373pgc.268.1636993237860;
        Mon, 15 Nov 2021 08:20:37 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:36 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 09/11] Set the profile for KernelCI
Date: Tue, 16 Nov 2021 01:17:22 +0900
Message-Id: <20211115161724.19516-10-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6912

This profile is need for make KernelCI recognize that we have 
successfully effectuated the log in.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 recipes-core/kernelci-customizations/files/postinst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-core/kernelci-customizations/files/postinst
index 68ef9d3..7ae30e8 100644
--- a/recipes-core/kernelci-customizations/files/postinst
+++ b/recipes-core/kernelci-customizations/files/postinst
@@ -25,6 +25,10 @@ echo "[Service]" > /etc/systemd/system/serial-getty@.service.d/override.conf
 echo "ExecStart=" >> /etc/systemd/system/serial-getty@.service.d/override.conf
 echo "ExecStart=-/sbin/agetty --autologin root --keep-baud 115200,38400,9600 %I $TERM" >> /etc/systemd/system/serial-getty@.service.d/override.conf
 
+# set the profile for KernelCI
+echo "PS1='\$(pwd) # '" > /root/.profile
+echo "cd /" >> /root/.profile
+
 HOSTNAME=demo
 echo "$HOSTNAME" > /etc/hostname
 echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
-- 
2.33.1



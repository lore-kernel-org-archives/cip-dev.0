Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B18C433EF
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:22 +0000 (UTC)
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by mx.groups.io with SMTP id smtpd.web10.24550.1636993221342773731
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Q94CWY27;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.193,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pf1-f193.google.com with SMTP id r130so15502700pfc.1
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhQxOc/l4/QaKw59aPNOabJyqbtmcQ6EDiF4DBzwq+4=;
        b=Q94CWY27eU0P9qYYAyrBlPXtNRuZFJf2sqSpj24d5aOW05hjWLVI+L27Q8P0VJQhn9
         RxBgeh2ePDYqlYhLCnsAXjPmLtB53+nXolSPrD162kO79ID4zxKTP/GLxnSHdKTuWlNG
         kRszwjYz5IwcKU6LX87wDqvyyLFQ4akbVWKWTHK5QK8kCn0ZYhro7cumMg45BcHvkIDA
         /y6RMLz9OLH3KkxTUPPl7evZ1cs7yHURi5XGJMzd76/4WsUIAqjFG6fsKCq0TOa/w2+c
         SbsfXqPyb0299wSgf0hD08KuEihKyvd3NbtIyhZM9v2f6m+fbieD6Js1spaHmaQeVQyK
         K9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhQxOc/l4/QaKw59aPNOabJyqbtmcQ6EDiF4DBzwq+4=;
        b=Gi7tJGUpFdxRWIRXkaUJTivNnMU0/AmBTgwZ6xWc8C460laHsG5dPh6tYgkZ9Myj/J
         j+9KooF7PuR4NOf4R+gg7n3wGpLIkYXH+ocgAy+B+51Cdg8i7AVI/Q5+nm+WqVPmuO7B
         kVDNr8bHItF+BJiUuDKSNtld98GfscuZQnfNd3KbltSIIlZjdm0oUTpgMNddfTddOwwo
         mxgppJ7pLz+ggfXOPQmwNavpFy3n9PCzmKfRf2A8uGwalaK24B+406yMiSIfMTyIiLOa
         ns/7LzdciF+2ZKWaLCY5L3GEUyUDZIFf/gGBY8HAvwfcBNhFNqMS9HoCDZcxMpcbNohN
         JLRg==
X-Gm-Message-State: AOAM530F/PN5Z9+KCAH6EkcVsFQBW5xSv6xZmAyq2Hf1Yv74iwu6l8Hn
	z44vQB9VPhmyMqhQjSXHeoEa3BdruRWPDow=
X-Google-Smtp-Source: 
 ABdhPJwBVRVAdh6JBhomNh+Msu30kSG9EGyMk9OSiWBFiaz3wrVhfm5g/xuZ6RGxUbtuJwddWrvtXA==
X-Received: by 2002:a63:4a60:: with SMTP id j32mr47279pgl.140.1636993220809;
        Mon, 15 Nov 2021 08:20:20 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:20 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 02/11] Rename initrd with the gz suffix
Date: Tue, 16 Nov 2021 01:17:15 +0900
Message-Id: <20211115161724.19516-3-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6905

Generated initrd are actually gz compressed and KernelCI need
the initrd image filename to contain the gz suffix for work.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 scripts/deploy-kernelci.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
index 931504c..c2341a6 100755
--- a/scripts/deploy-kernelci.py
+++ b/scripts/deploy-kernelci.py
@@ -18,6 +18,10 @@ extension=sys.argv[3]
 
 rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
 initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
+
+# initrd is actually gz compressed
+initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
+
 input_dir="build/tmp/deploy/images/"+target
 upload_path="/images/rootfs/cip/"+cdate+"/"+target+"/"
 rootfs=input_dir+"/"+rootfs_filename
@@ -44,5 +48,5 @@ if os.path.exists(rootfs) and os.path.exists(initrd):
     print("uploading rootfs to KernelCI")
     upload_file(api, token, upload_path, rootfs, rootfs_filename)
     print("uploading initrd to KernelCI")
-    upload_file(api, token, upload_path, initrd, initrd_filename)
+    upload_file(api, token, upload_path, initrd, initrd_gz_filename)
     print("uploaded to: https://storage.staging.kernelci.org"+upload_path)
-- 
2.33.1



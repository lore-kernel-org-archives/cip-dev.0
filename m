Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9118C43219
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:27 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web12.24747.1636993227385951774
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Wxj59Vkb;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.170,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pf1-f170.google.com with SMTP id n85so15464113pfd.10
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Afwy6WTweoh3vqNkF33Puyh8Rk+RVYkBpdBKe+XAUmc=;
        b=Wxj59Vkb/A2X8Mdv5HU7c81PsFOGR8Oeyixr05BX6ZBDMD5eZEXesa8ipnlUDOnY5u
         ycQgjr8vJTuyzZWnQCRVDYRcuQQ4F2mnRRiofOP0bQI8YtUpRfyJtKIVpu6x//LHunC7
         XhdyfZHiDMGy8G84F6U1+1xzdwZwuERJlb4oFOC4UJ59mWLigzMBd2/oP31XyOmfV+LM
         DOmALNPMDYkwRVnNPmO2SlA/w8m4WE7REo8wYV0PunDk+aMO1qFMR4pd5rbsxUwRob8W
         35XUyDgGToVgAl50qdGs1sPhbj5OmhhMcNIoZavStpiKJbZbEkdI08Wn4GCbxyEZb+xk
         Xc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Afwy6WTweoh3vqNkF33Puyh8Rk+RVYkBpdBKe+XAUmc=;
        b=SiPk8UxCBhZxJdxa4sTkIYMZ9P61yT2h+XMye2UdY2dkLSD15C2UaEx5kx1hwdm9Od
         YNU5QICaDSnP0FoPB161HU80bh76NMqzO9QfgiqscuK09va9bSGepojOjedGM5e+PAg+
         4jIM4femy9J37pim6fTAt4zFSWuKjpJM6z/xi0PjZXz5wfN1xP7t92Yue2jPBykZFRWr
         yFiyyLwQfFqesuyLw1gjGANwSEQ1srEIUxyxYrmAdKNmFH3FF5mcE69IDrsD9IfUNCfe
         dhvZlymOSv+1HvtZme4zuZqRdPo4/YCrBcU/wpKfcFt3L76f3iy+LkRdYACTlE0GoqlP
         Y/qw==
X-Gm-Message-State: AOAM5301zuMqrxBvCNoSYGJEp5T8mByo94OTYKKLffjzEKX1izodgSJJ
	g5CBICBeDunIQTug//3pxtkb9Ybb9s2C/ok=
X-Google-Smtp-Source: 
 ABdhPJzditP/WiH9DjAa76kc2i6+ZfjFa78qVBNuyyQTcZkggODuodnIIgw/vrrOQBTYCIhmVbOmxA==
X-Received: by 2002:a05:6a00:10d3:b0:49f:faf7:6f8e with SMTP id
 d19-20020a056a0010d300b0049ffaf76f8emr34646519pfu.75.1636993226991;
        Mon, 15 Nov 2021 08:20:26 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:26 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 05/11] Ignore extension argument when not set
Date: Tue, 16 Nov 2021 01:17:18 +0900
Message-Id: <20211115161724.19516-6-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6908

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 scripts/deploy-kernelci.py | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
index 88c09d7..c234113 100755
--- a/scripts/deploy-kernelci.py
+++ b/scripts/deploy-kernelci.py
@@ -16,11 +16,18 @@ release=sys.argv[1]
 target=sys.argv[2]
 extension=sys.argv[3]
 
-rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
-initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
+if extension == "security":
+    rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
+    initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
+elif extension == "base":
+    rootfs_filename="cip-core-image-cip-core-"+release+"-"+target+".tar.gz"
+    initrd_filename="cip-core-image-cip-core-"+release+"-"+target+"-initrd.img"
 
 # initrd is actually gz compressed
-initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
+if extension == "security":
+    initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
+elif extension == "base":
+    initrd_gz_filename="cip-core-image-cip-core-"+release+"-"+target+"-initrd.img.gz"
 
 input_dir="build/tmp/deploy/images/"+target
 upload_path="/images/rootfs/cip/"+cdate+"/"+target+"/"
@@ -28,6 +35,14 @@ upload_path_latest="/images/rootfs/cip/latest/"+target+"/"
 rootfs=input_dir+"/"+rootfs_filename
 initrd=input_dir+"/"+initrd_filename
 
+print("arguments:")
+print(release)
+print(target)
+print(extension)
+print("filenames:")
+print(rootfs_filename)
+print(initrd_filename)
+print(initrd_gz_filename)
 print("build directory contents:")
 print(os.listdir(input_dir))
 
-- 
2.33.1



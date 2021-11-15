Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7343C433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:24 +0000 (UTC)
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by mx.groups.io with SMTP id smtpd.web12.24746.1636993223447334007
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=5b0oGJZx;
 spf=pass (domain: miraclelinux.com, ip: 209.85.216.68,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pj1-f68.google.com with SMTP id
 gb13-20020a17090b060d00b001a674e2c4a8so245176pjb.4
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3vwrzovosFv17eIiHM/BH7UUdoVlOvjSOw9eXLjzdA=;
        b=5b0oGJZxCY78r1j2cfxZ6zvtebFh53dlUTNLsuO2TAs1/JQa4kwQFb3lHng+1a0pnE
         zUdN3NhlkkNtlzU5jierGiNc9GybKNmBRsKP/EMxONVDHcoDdml1uSCiN0j0oS8egwyv
         RSDz0qRgZQYy/8YNXCup1B8XgB+zhIptXlREbGUd8SdkW8agRpTegX9Bru0adXb6yryr
         6UfAJBz1ub5iXQ+iic8CK+jcgYrc0sAL533zUZmFHpuEKgtc3XxchzsX7Pr1TzKhjQFg
         zjtlBmZrMCBnXDQ8hfaqmMvZE9s8DJ383xvpHiVwa8dfCidN6yVmWIapeHjTCCKPmO2c
         6fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3vwrzovosFv17eIiHM/BH7UUdoVlOvjSOw9eXLjzdA=;
        b=ASCWpTQIeQgt+qD57TfPl6/+BBu7dmg915CznD50rJBF/85x6wfLo55SjCGcCYFiGa
         nCWL49necFsc+N0nmxHDlYMFGJV1vvyFAbLg9coyyk1nd1ol8mQ5egw+4wJqH0z7Xidu
         ofzf1uvhUdaopIIIrf6M5Q1ZlpDrnZONLTJvdfjrTEqPgbQUMZ19VOYQbPCCa57RARZN
         HOPfYh4j4+t2O9VKU+L3DLm5tai3E4NLCSBiEP23Z8zEamRvJmDUC5FHiUOiUwojqRx0
         9KkmTchM6dr+5W8d+5/zVQXWva0tcYzTlLfssPgHtSKpdDua8O7LWI8jkMDHOGtK5eo/
         bpOA==
X-Gm-Message-State: AOAM532z/mzjTGkavmmIKF+XijQ7AtoyV94zF2UHEa7sWm9qYGinzpMs
	OGznGn1TjxMKVUOjRsJU1rewcUaVlxGS6CM=
X-Google-Smtp-Source: 
 ABdhPJyufONINA/WzwZAJShAcPuJhFkKEqVOZtU2II3F8L830B9tpE/d3qmVUrco1dBf+UPaeG6qFw==
X-Received: by 2002:a17:902:e88f:b0:141:f982:777 with SMTP id
 w15-20020a170902e88f00b00141f9820777mr37441953plg.68.1636993222929;
        Mon, 15 Nov 2021 08:20:22 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:22 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 03/11] Add latest folder to the storage
 fileserver
Date: Tue, 16 Nov 2021 01:17:16 +0900
Message-Id: <20211115161724.19516-4-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6906

Creating a latest folder useful if we want to test the latest
image.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 scripts/deploy-kernelci.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
index c2341a6..88c09d7 100755
--- a/scripts/deploy-kernelci.py
+++ b/scripts/deploy-kernelci.py
@@ -24,6 +24,7 @@ initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"
 
 input_dir="build/tmp/deploy/images/"+target
 upload_path="/images/rootfs/cip/"+cdate+"/"+target+"/"
+upload_path_latest="/images/rootfs/cip/latest/"+target+"/"
 rootfs=input_dir+"/"+rootfs_filename
 initrd=input_dir+"/"+initrd_filename
 
@@ -50,3 +51,10 @@ if os.path.exists(rootfs) and os.path.exists(initrd):
     print("uploading initrd to KernelCI")
     upload_file(api, token, upload_path, initrd, initrd_gz_filename)
     print("uploaded to: https://storage.staging.kernelci.org"+upload_path)
+
+    # Upload latest
+    print("uploading rootfs to KernelCI CIP latest")
+    upload_file(api, token, upload_path_latest, rootfs, rootfs_filename)
+    print("uploading initrd to KernelCI CIP latest")
+    upload_file(api, token, upload_path_latest, initrd, initrd_gz_filename)
+    print("uploaded to: https://storage.staging.kernelci.org"+upload_path_latest)
-- 
2.33.1



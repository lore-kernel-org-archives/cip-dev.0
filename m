Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B3C433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:43 +0000 (UTC)
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by mx.groups.io with SMTP id smtpd.web10.24558.1636993242789494934
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=eSKqbaRo;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.196,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pf1-f196.google.com with SMTP id x5so4810057pfr.0
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YhMnsci9kUDecgebxD7brs2H6ZIc9DiW1q8g3wJtknE=;
        b=eSKqbaRo//5+ZcxRVFMY8QszDBWoSAq35FCfCg7r7nnwMPp6I/R9bz/w9aGc/wileE
         yqysY0ofOFg1OL0rh0o4Zv3+19kYPRF0/2CraPm+ejynwlItBmxG96/NDs4bBo3BAqgl
         wyliqCqeuE8bmbWF+Za5mwhUtBcnvN+bfO1nnqC8Li6oo65wA1Sb8S04Mp+Hx5Hy6t3M
         CXsuAUBN+OxHzlv8G3UgZ/uNaRcTlzsgeQuL4vYcHxYriONxt0vNEsJf14dWMuxbaJve
         COd415ulBR+GL26g9KIExPB91+EdVtiQoB9cmf9LQ8S0at+DZ+JPhS4V7BVd0xbtgJma
         cKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YhMnsci9kUDecgebxD7brs2H6ZIc9DiW1q8g3wJtknE=;
        b=uYjbT3RJt0CA85x8jCUjhKuOKLTzeM1VnaxXt7kznJoy/GZVBL15RNM4cS8ykfDRDw
         USW+A8fH+onanvHjrG/1aEXz5fCRqopLk0tWxPpdS3TOeGoUZ/hnH5+NKZaWXtKmRBIv
         7hafGsLkZvSGA0AGmp0qTnc2y5rSFZZGIKWKw6gzRYIjAelyQP2rmP/I95eCwSwjmDod
         mC3W2Pk8POjQJISBrOgDK7LmNuiSDixdGdnUhDlNZi95Tf7GajjoSjiKnJs8qxXIdiaW
         c4wAFIR5521++UGRsXXdSeexPzUvPK/ZSNxm26w/eHVW8yrXSuYH1KYCQDYgSy4UOzsg
         SJjw==
X-Gm-Message-State: AOAM530YU9IY2OOEDaSNFPBqhnhZt26C6eRmK0mbtgILvcEkn6yHwmqf
	cufgmIXgAFMJlW2fzpk/cHrES1pOEWCWlpo=
X-Google-Smtp-Source: 
 ABdhPJzEeUyYwGDIQ8YB89B2OieZfLZv1paQ/eBRBxbWmyDQcMiuwHIy3r+qqyqGDShZeTY1cNA3Yw==
X-Received: by 2002:a05:6a00:1945:b0:44c:a955:35ea with SMTP id
 s5-20020a056a00194500b0044ca95535eamr33461509pfk.85.1636993242378;
        Mon, 15 Nov 2021 08:20:42 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:41 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 11/11] Upload to KernelCI production
Date: Tue, 16 Nov 2021 01:17:24 +0900
Message-Id: <20211115161724.19516-12-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6914

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 scripts/deploy-kernelci.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
index 1df4e72..479b971 100755
--- a/scripts/deploy-kernelci.py
+++ b/scripts/deploy-kernelci.py
@@ -9,7 +9,7 @@ import time
 from urllib.parse import urljoin
 
 cdate=time.strftime("%Y%m%d")
-api="https://api.staging.kernelci.org/upload"
+api="https://api.kernelci.org/upload"
 token=os.getenv("KERNELCI_TOKEN")
 
 release=sys.argv[1]
@@ -66,11 +66,11 @@ if os.path.exists(rootfs) and os.path.exists(initrd):
     upload_file(api, token, upload_path, rootfs, rootfs_filename)
     print("uploading initrd to KernelCI")
     upload_file(api, token, upload_path, initrd, initrd_gz_filename)
-    print("uploaded to: https://storage.staging.kernelci.org"+upload_path)
+    print("uploaded to: https://storage.kernelci.org"+upload_path)
 
     # Upload latest
     print("uploading rootfs to KernelCI CIP latest")
     upload_file(api, token, upload_path_latest, rootfs, rootfs_filename)
     print("uploading initrd to KernelCI CIP latest")
     upload_file(api, token, upload_path_latest, initrd, initrd_gz_filename)
-    print("uploaded to: https://storage.staging.kernelci.org"+upload_path_latest)
+    print("uploaded to: https://storage.kernelci.org"+upload_path_latest)
-- 
2.33.1



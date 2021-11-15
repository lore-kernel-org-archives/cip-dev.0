Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C581EC433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:30 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web09.24763.1636993229865640659
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=cbfHfuW2;
 spf=pass (domain: miraclelinux.com, ip: 209.85.214.169,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pl1-f169.google.com with SMTP id b11so14827428pld.12
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orvSFtW0B9gucw2Op06xc2t0p/UXAg+WCI05HLcjNho=;
        b=cbfHfuW2UxcFcLoBX3svz/tP1bE3+0k9d/S6aMi3t37ngCgt1VFi00Q7n2plgdZ4hm
         87pdh46b00wCP5kHzSCxGm2cpmnyX3cjAmeGSuolv34xGNpEJtv+x4fxuVOH76rjK3Nj
         5z1cxm83S2rnZXWdLrU9OReg+4C9drD4gRLeFH1TOEGhJAae2d5MQbWoEWMFNKKWemkQ
         JzVUE9o0M0uaNM612PZk9JZ2auoRzbQlOxcy6o1lwUbhCqTg8UkTjBip1rS6XFKGNhB3
         8gOjb/+fgME9m2r2Q8cdbgFv27uoukupMRvQX2tJCdVoyfY7p3H/funYG1NHj3qYCsHN
         M8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orvSFtW0B9gucw2Op06xc2t0p/UXAg+WCI05HLcjNho=;
        b=FbzTKPX+WRz/Us4hUoTBIjB5SwFGTTZcgG+3sg6POBBwxPawF9tCAq7HKcbFLV46fJ
         M+7IOxXSrHhTKQxhNqobFhJY/vQNM44btwe0uj6uzu4JUi+W8b0qXe9npClJCuggxfUM
         gfNxH3FjEKa0+FSzzE2miohnBHbTwTFLFRy9hZK1XJaVT/+Zbl5Iinr8KfaazlYA8L79
         zKExQ/olwEGoY+s3bofZcD/oy6qJAwjZ3hqEkO5xL9a3oF1HTV8uTEftghpB358jdQC6
         RqZJGAXnFZyJI/scKYt4L5jRqmY5/wr09ZyvnONt18Q9pHVXDaCADNPRbA44540qWbr+
         n6Vg==
X-Gm-Message-State: AOAM531sAfiwDZmVYRUvI9HAUIGRln00wma9MUfukVfStc6ak4yp1GWN
	M9PlnLRzyOGqXHBjpNEpwRFUnQWR4h0aTrE=
X-Google-Smtp-Source: 
 ABdhPJz0rYcPC/PClDUbbmmA9cU6XtUM9yvJYrYBpjbH+QCiFGRLJAB7O+Wdc0pm923praRcfkiEIA==
X-Received: by 2002:a17:90a:df88:: with SMTP id
 p8mr67053644pjv.32.1636993229439;
        Mon, 15 Nov 2021 08:20:29 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:28 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 06/11] Enable KernelCI build step also for arm
 and arm64
Date: Tue, 16 Nov 2021 01:17:19 +0900
Message-Id: <20211115161724.19516-7-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6909

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 .gitlab-ci.yml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5f0463e..9776754 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -100,6 +100,17 @@ build:qemu-arm64-base:
     wic_targz: disable
     targz: enable
 
+build:qemu-arm64-base-kernelci:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm64
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    kernelci: enable
+
 build:qemu-arm-base:
   extends:
     - .build_base
@@ -110,6 +121,17 @@ build:qemu-arm-base:
     wic_targz: disable
     targz: enable
 
+build:qemu-arm-base-kernelci:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    kernelci: enable
+
 # test
 build:simatic-ipc227e-test:
   extends:
-- 
2.33.1



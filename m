Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1387C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 08:03:37 +0000 (UTC)
Received: from smtp.priv.miraclelinux.com (smtp.priv.miraclelinux.com [202.210.215.66])
 by mx.groups.io with SMTP id smtpd.web11.156058.1692173016770911851
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 01:03:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: miraclelinux.com, ip: 202.210.215.66, mailfrom: arisu.tachibana@miraclelinux.com)
Received: from localhost.localdomain (alitoo.miraclelinux.com [10.2.1.103])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id A5253140053;
	Wed, 16 Aug 2023 17:03:34 +0900 (JST)
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Subject: [isar-cip-core][PATCH] .gitlab-ci: Create amd64 release variations for KernelCI
Date: Wed, 16 Aug 2023 17:03:00 +0900
Message-ID: <20230816080300.5559-1-arisu.tachibana@miraclelinux.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 08:03:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12661

Force the creation of buster, bullseye and bookworm images
for KernelCI storage with GitLabCI
This images will be tested with the relative linux-cip=20
kernel version
```
buster with linux-4.19.y-cip
bullseye with kernel linux-5.10.y-cip
bookworm with kernel linux-6.1.y-cip
```

Signed-off-by: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
---
 .gitlab-ci.yml | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 892ba92..183efcd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -101,12 +101,39 @@ build:qemu-amd64-base:
     wic_targz: disable
     targz: enable
=20
-build:qemu-amd64-base-kernelci:
+build:qemu-amd64-base-kernelci-buster:
   extends:
     - .build_base
   variables:
     target: qemu-amd64
     extension: kernelci
+    release: buster
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    deploy_kernelci: enable
+
+build:qemu-amd64-base-kernelci-bullseye:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    extension: kernelci
+    release: bullseye
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    deploy_kernelci: enable
+
+build:qemu-amd64-base-kernelci-bookworm:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    release: bookworm
+    extension: kernelci
     use_rt: disable
     wic_targz: disable
     targz: enable
--=20
2.41.0



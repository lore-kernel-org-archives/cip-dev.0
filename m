Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE2C05027
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:26:04 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.9075.1676647561569175503
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 07:26:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=JY1Le68O;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2023021715255879a5bdf8c5f7d65f18-lcc4wb@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023021715255879a5bdf8c5f7d65f18
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Feb 2023 16:25:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hTDLQjQzcKtqFAFdYJliKrralRvWDJuA+hjkzw0VyFs=;
 b=JY1Le68OahxOC/B89gKZfFsLTnp1u9CPp1oKWEXrH2UBF/EqPLLaPfFrGJ7hyCmLmFmJka
 VDyLwA+NI9cfip0KEGLsnk9bsrqyLquOd7HmXRYrHW6As6PYGCULhMfCBh6AHktxJoe+WEHr
 epyFqMsn3QnIYkrnKZiVdfEGoZhis=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 3/3] .gitlabci: add riscv64
Date: Fri, 17 Feb 2023 16:25:56 +0100
Message-Id: <20230217152556.516948-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
References: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 15:26:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10732

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 311702f..95adad5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -38,6 +38,7 @@ default:
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
+    - if [ "${release}" = "sid-ports" ]; then base_yaml="${base_yaml}:kas/opt/sid-ports.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
@@ -326,3 +327,17 @@ build:qemu-amd64-secure-boot-bookworm:
     use_rt: disable
     wic_targz: disable
     deploy: disable
+
+# riscV
+
+build:qemu-risv64:
+  extends:
+    - .build_base
+  variables:
+    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
+    release: sid-ports
+    target: qemu-riscv64
+    use_rt: disable
+    wic_targz: disable
+    deploy: disable
+
-- 
2.39.1



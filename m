Return-Path: <SRS0=Ggbf=KW=lists.cip-project.org=bounce+64572+6476+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB73DC4708A
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 13:25:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1E2613EB
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 13:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1E2613EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6476+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 91ciYY4521723xglyG9yBxfU; Thu, 27 May 2021 06:25:06 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.6787.1622121904602111136
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 May 2021 06:25:05 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 14RDP3Pv027137
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 27 May 2021 15:25:03 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.10.167])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 14RDHgb0007209;
	Thu, 27 May 2021 15:17:43 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 3/5] .gitlabci.yml: add secureboot build
Date: Thu, 27 May 2021 15:17:39 +0200
Message-Id: <20210527131741.8828-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210527131741.8828-1-Quirin.Gylstorff@siemens.com>
References: <20210527131741.8828-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 55DUtCxN7icTKU0LqPMX10xDx4520388AA=
Content-Type: multipart/mixed; boundary="IIWoIh8Wg5Ui8F1uzzrk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622121906;
 bh=b1/wwBa5AkID8V1p/oFP6kcPIqfsmiJp4jJxbU6A+W0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rLmsluOGc4D9Et8EOpc61tqSmk5vYbNPgIhfrfzz+1ec6FD+Tb0Dni2+Sb3iBK4rw3g
 5nUrWQu6uWfSjLWSSpKc0I1wiJSAqr57lNRPE4ujFVluuYIeNmiatAkk5W6a1uHOL5JO3
 EcIuylGzddt0c52uL7WxbWMGi5ktHYqFEJQ=

--IIWoIh8Wg5Ui8F1uzzrk
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Avoid build errors due to changes in the secure boot configuration.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 84c1257..2bfed93 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -151,3 +151,15 @@ build:qemu-arm-test:
     extention: test
     wic_targz: disable
     targz: enable
+
+build:qemu-amd64-secure-boot:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    extention: ebg-secure-boot-snakeoil
+    use_rt: disable
+    wic_targz: disable
+    targz: disable
+    deploy: disable
+
-- 
2.20.1


--IIWoIh8Wg5Ui8F1uzzrk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6476): https://lists.cip-project.org/g/cip-dev/message=
/6476
Mute This Topic: https://lists.cip-project.org/mt/83123998/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--IIWoIh8Wg5Ui8F1uzzrk--

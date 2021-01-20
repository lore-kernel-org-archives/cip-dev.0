Return-Path: <SRS0=JwKF=GX=lists.cip-project.org=bounce+64572+6116+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE5BC433E9
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 08:34:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CD222573
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 08:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CD222573
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6116+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kcWfYY4521723xrWb7pJR0Zp; Wed, 20 Jan 2021 00:34:50 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.25411.1611131687200841938
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jan 2021 00:34:47 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 10K8YjuJ023921
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 20 Jan 2021 09:34:45 +0100
X-Received: from md2dvrtc.ad001.siemens.net ([139.22.114.182])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10K8YhY8009837;
	Wed, 20 Jan 2021 09:34:45 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 3/4] update linux kernels
Date: Wed, 20 Jan 2021 09:34:42 +0100
Message-Id: <20210120083443.8105-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210120083443.8105-1-Quirin.Gylstorff@siemens.com>
References: <20210120083443.8105-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uGCuQAza5x3LGss0LIYXpyKcx4520388AA=
Content-Type: multipart/mixed; boundary="TIub5bLEGZAbI3XlaBcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611131690;
 bh=eIfYDx6pmxVT4vuoRvMBvQu3h5op2NyvD6Ons+bhwqE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vt8wz2Id4F4qfAZZCLVsOw0rfknRJoU+O41v5Ppoie9F85ZdZeLCXchI7dWpy+/QbQl
 e7fupoerj6E4uMUEjSyCzEgM/rfJWY+iTsO2/bnAUBEyK7czG+LCIgvrUnnFDK+Jr82RV
 LasbUEfJ3RLSTtJttY+fKPgByyIA79P3oCg=

--TIub5bLEGZAbI3XlaBcA
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ....135-cip31-rt13.bb => linux-cip-rt_4.19.160-cip39-rt17.bb} | 4 ++--
 ...4.231-cip47-rt30.bb => linux-cip-rt_4.4.244-cip51-rt32.bb} | 4 ++--
 ...inux-cip_4.19.140-cip33.bb => linux-cip_4.19.165-cip41.bb} | 4 ++--
 ...{linux-cip_4.4.230-cip47.bb => linux-cip_4.4.249-cip53.bb} | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.135-cip31-rt13.bb => linux-cip-rt_4.19.160-cip39-rt17.bb} (54%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.231-cip47-rt30.bb => linux-cip-rt_4.4.244-cip51-rt32.bb} (54%)
 rename recipes-kernel/linux/{linux-cip_4.19.140-cip33.bb => linux-cip_4.19.165-cip41.bb} (53%)
 rename recipes-kernel/linux/{linux-cip_4.4.230-cip47.bb => linux-cip_4.4.249-cip53.bb} (53%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb b/recipes-kernel/linux/linux-cip-rt_4.19.160-cip39-rt17.bb
similarity index 54%
rename from recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.160-cip39-rt17.bb
index 820c1ab..3c0aea5 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.160-cip39-rt17.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019 - 2021
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "b827f45b8f97b71b3917c84b43fd6593030d01ea7261d3be6c15a76250308743"
+SRC_URI[sha256sum] = "c2e0f50670c298aed94c35628caf4ddf0eefc20d2f17e0a5f024bf4d99a38460"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb b/recipes-kernel/linux/linux-cip-rt_4.4.244-cip51-rt32.bb
similarity index 54%
rename from recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.244-cip51-rt32.bb
index e13fc14..6679144 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.244-cip51-rt32.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019 - 2021
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "e7a0c7b8e4d91f52cbc2ee17a546d1afbc5fcfed95ba44dd113e534fab3a157e"
+SRC_URI[sha256sum] = "070dc2084d2a64c1c8d64382978ec01ed7875b012401d09f37428a9c8c52b9c3"
diff --git a/recipes-kernel/linux/linux-cip_4.19.140-cip33.bb b/recipes-kernel/linux/linux-cip_4.19.165-cip41.bb
similarity index 53%
rename from recipes-kernel/linux/linux-cip_4.19.140-cip33.bb
rename to recipes-kernel/linux/linux-cip_4.19.165-cip41.bb
index 9e958c0..f19b4c3 100644
--- a/recipes-kernel/linux/linux-cip_4.19.140-cip33.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.165-cip41.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019 - 2021
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "f6a9aec6848a5897c90bafda5a9eba010c03d5d0cf99508adfb1cf7a2f4af9e5"
+SRC_URI[sha256sum] = "c1404d0a0a1ba71656c237d6d606714d34364814dc9a3998add93fe1749cb27d"
diff --git a/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb b/recipes-kernel/linux/linux-cip_4.4.249-cip53.bb
similarity index 53%
rename from recipes-kernel/linux/linux-cip_4.4.230-cip47.bb
rename to recipes-kernel/linux/linux-cip_4.4.249-cip53.bb
index af49441..03b1a04 100644
--- a/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.249-cip53.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019 - 2021
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "3ff33e497064ba8e7d9b5e1ee575c6a936154fa8216774782cbc0db2e4b71cdf"
+SRC_URI[sha256sum] = "f8a6eba35572da13c81fec6c2d451db8f75b0ab4a5b6b80113523fbb035bf384"
-- 
2.20.1


--TIub5bLEGZAbI3XlaBcA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6116): https://lists.cip-project.org/g/cip-dev/message=
/6116
Mute This Topic: https://lists.cip-project.org/mt/79974654/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TIub5bLEGZAbI3XlaBcA--

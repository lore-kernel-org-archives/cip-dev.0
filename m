Return-Path: <SRS0=jvuV=L7=lists.cip-project.org=bounce+64572+6605+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AEDC11F67
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABD661C9A
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABD661C9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6605+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DeINYY4521723xEI08ufAxui; Wed, 07 Jul 2021 05:17:19 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.20220.1625660200269770710
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 05:16:40 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 167CGc53018256
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:38 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 167CGaEe020405
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:38 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 8/9] linux-cip: Update to latest releases
Date: Wed,  7 Jul 2021 14:16:35 +0200
Message-Id: <3128e2e21ec0bf5667c1080ddd4752bf2428ec08.1625660195.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625660195.git.jan.kiszka@siemens.com>
References: <cover.1625660195.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zgvZGuOogL66UkW7rVUskCA5x4520388AA=
Content-Type: multipart/mixed; boundary="AS4TxUC0q3Unblo9Pkhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625660239;
 bh=pQCJH8Oq7ZOLAWeNElx58OrXtKgQKmE1KxUz3sywVD4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bcOfM+ybjZuJhB10ogJHgdDecYiIl0VXFybG+/IWVe0wYspfH+337YbkUHETaQelvcB
 hNQFjQIazaC3SwBMJNwMDa8jPinixImuhrCyNI9mFiCdG4vaeBgVILWh2DcsjWr7GhLCq
 D/AfEjCob+zIQxt5z+rqwkffNm1BcbVp+Fo=

--AS4TxUC0q3Unblo9Pkhf
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...19.160-cip39-rt17.bb => linux-cip-rt_4.19.195-cip52-rt20.bb} | 2 +-
 ...4.4.244-cip51-rt32.bb => linux-cip-rt_4.4.262-cip55-rt34.bb} | 2 +-
 ...{linux-cip_4.19.165-cip41.bb => linux-cip_4.19.195-cip52.bb} | 2 +-
 .../{linux-cip_4.4.249-cip53.bb => linux-cip_4.4.272-cip58.bb}  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.160-cip39-rt17.bb => linux-cip-rt_4.19.195-cip52-rt20.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.244-cip51-rt32.bb => linux-cip-rt_4.4.262-cip55-rt34.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.19.165-cip41.bb => linux-cip_4.19.195-cip52.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.249-cip53.bb => linux-cip_4.4.272-cip58.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.160-cip39-rt17.bb b/recipes-kernel/linux/linux-cip-rt_4.19.195-cip52-rt20.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.160-cip39-rt17.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.195-cip52-rt20.bb
index 3c0aea5..4c9a735 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.160-cip39-rt17.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.195-cip52-rt20.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "c2e0f50670c298aed94c35628caf4ddf0eefc20d2f17e0a5f024bf4d99a38460"
+SRC_URI[sha256sum] = "fee95d77599f5a0321ae818f63bf595f5e3015e674f2f428503267b8471379fb"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.244-cip51-rt32.bb b/recipes-kernel/linux/linux-cip-rt_4.4.262-cip55-rt34.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.244-cip51-rt32.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.262-cip55-rt34.bb
index 6679144..37f2018 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.244-cip51-rt32.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.262-cip55-rt34.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "070dc2084d2a64c1c8d64382978ec01ed7875b012401d09f37428a9c8c52b9c3"
+SRC_URI[sha256sum] = "5f8c3fe1ec1cb82e12a6929945f29bfd7dd432a81ad9891cd7490e86d7d91d7a"
diff --git a/recipes-kernel/linux/linux-cip_4.19.165-cip41.bb b/recipes-kernel/linux/linux-cip_4.19.195-cip52.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.165-cip41.bb
rename to recipes-kernel/linux/linux-cip_4.19.195-cip52.bb
index f19b4c3..05dc765 100644
--- a/recipes-kernel/linux/linux-cip_4.19.165-cip41.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.195-cip52.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "c1404d0a0a1ba71656c237d6d606714d34364814dc9a3998add93fe1749cb27d"
+SRC_URI[sha256sum] = "9eb4fb2a9b0065e3c8ac2a1045da7bc6377309dd7c01292985c3e978b8d61d8f"
diff --git a/recipes-kernel/linux/linux-cip_4.4.249-cip53.bb b/recipes-kernel/linux/linux-cip_4.4.272-cip58.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.249-cip53.bb
rename to recipes-kernel/linux/linux-cip_4.4.272-cip58.bb
index 03b1a04..e883794 100644
--- a/recipes-kernel/linux/linux-cip_4.4.249-cip53.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.272-cip58.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "f8a6eba35572da13c81fec6c2d451db8f75b0ab4a5b6b80113523fbb035bf384"
+SRC_URI[sha256sum] = "e8300f194bd99866d5d1b467475270f2739aaf1e87536097465f636d37437ff9"
-- 
2.26.2


--AS4TxUC0q3Unblo9Pkhf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6605): https://lists.cip-project.org/g/cip-dev/message=
/6605
Mute This Topic: https://lists.cip-project.org/mt/84042872/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AS4TxUC0q3Unblo9Pkhf--

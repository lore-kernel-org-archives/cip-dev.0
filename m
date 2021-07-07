Return-Path: <SRS0=muK/=L7=lists.cip-project.org=bounce+64572+6598+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6335C07E9B
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:16:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DD861C9A
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DD861C9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6598+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Hyx2YY4521723xQ1wJjdjUvi; Wed, 07 Jul 2021 05:16:58 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.20133.1625660199090065128
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 05:16:39 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 167CGbrc014136
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:37 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 167CGaEY020405
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:37 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 2/9] Update to kas 2.5
Date: Wed,  7 Jul 2021 14:16:29 +0200
Message-Id: <b788a6953cdae0e6a46e3b1af206dbad4fe7e4d1.1625660195.git.jan.kiszka@siemens.com>
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
X-Gm-Message-State: fxpHvegETEzzxaVAG63Fy8DBx4520388AA=
Content-Type: multipart/mixed; boundary="PvSwXTb0IKJwKb0mw8th"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625660218;
 bh=VeYqJzF+xliGHWbsomaHpmp3GqZY5ikgkRqR2xTln/4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=V2euCmVn/84FwJ7/9xyeKUwlxUXyiyfsffR/jAaOtV9qXqhILYdzDj8BisS3qZoDtuP
 WLdvf5gsyvhuDoRG6+5wddh/BzIW5525p/I195Xq/5r+t+olPilowgpq/m4/sjcFcklFc
 Sp821KoB27uQ2hYZbuBSZ+eYPIA0QPRONJk=

--PvSwXTb0IKJwKb0mw8th
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 README.md      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 823160f..2a9ae22 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,4 +1,4 @@
-image: ghcr.io/siemens/kas/kas-isar:2.3.3
+image: ghcr.io/siemens/kas/kas-isar:2.5
 
 variables:
   GIT_STRATEGY: clone
diff --git a/README.md b/README.md
index f038db3..32812a2 100644
--- a/README.md
+++ b/README.md
@@ -12,7 +12,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/2.3.3/kas-container
+    wget https://raw.githubusercontent.com/siemens/kas/2.5/kas-container
     chmod a+x kas-container
 
 Furthermore, install docker and make sure you have required permissions to
-- 
2.26.2


--PvSwXTb0IKJwKb0mw8th
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6598): https://lists.cip-project.org/g/cip-dev/message=
/6598
Mute This Topic: https://lists.cip-project.org/mt/84042865/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PvSwXTb0IKJwKb0mw8th--

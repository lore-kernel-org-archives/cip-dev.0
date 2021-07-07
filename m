Return-Path: <SRS0=JGJa=L7=lists.cip-project.org=bounce+64572+6601+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D452BC11F6A
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC3961CA8
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC3961CA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6601+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id v19gYY4521723xAaJbiB6JFU; Wed, 07 Jul 2021 05:17:17 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.20223.1625660199736032157
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 05:16:40 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 167CGbm8029829
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:37 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 167CGaEX020405
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:37 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 1/9] ci: Select large runner
Date: Wed,  7 Jul 2021 14:16:28 +0200
Message-Id: <687844f994dd0a79b63f5263ba2d7d8716c4bb05.1625660195.git.jan.kiszka@siemens.com>
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
X-Gm-Message-State: B8dDsPwMsoafWuH2uuzjtlC5x4520388AA=
Content-Type: multipart/mixed; boundary="BjRl95xX4cvK5sdUlMKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625660237;
 bh=zNqvpFgp3fiXO7Yrq0f5Hi35tZVLSQyf3YZpc4q6raY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=HHpBzAIZviI/+G78jue7pvE3qnfurzzHCTzYZYQM/WGhpOe4qhFOWzQtURPgnjHWmgH
 noi9TADKoRCrZdS03wvOKVGwyI4FqVYh+LelKMKzjAWoej/FgMMja4JIOL6NPcSp2yDDO
 gxljOPCL9j4Gncsc9fZNyNh4hrqjjBBeKxk=

--BjRl95xX4cvK5sdUlMKb
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Needed since we now have multiple options, and the smaller one is not
even compatible with Isar.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9d9ced0..823160f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -24,6 +24,8 @@ default:
 
 .build_base:
   stage: build
+  tags:
+    - large
   variables:
     base_yaml: "kas-cip.yml:kas/board/${target}.yml"
   script:
-- 
2.26.2


--BjRl95xX4cvK5sdUlMKb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6601): https://lists.cip-project.org/g/cip-dev/message=
/6601
Mute This Topic: https://lists.cip-project.org/mt/84042868/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BjRl95xX4cvK5sdUlMKb--

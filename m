Return-Path: <SRS0=v6ho=MS=lists.cip-project.org=bounce+64572+6629+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81F1C4338F
	for <cip-dev@archiver.kernel.org>; Mon, 26 Jul 2021 06:38:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41ED460F45
	for <cip-dev@archiver.kernel.org>; Mon, 26 Jul 2021 06:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41ED460F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Gd2KYY4521723xyZAs2inyuq; Sun, 25 Jul 2021 23:38:25 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.26855.1627281504750378159
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Jul 2021 23:38:25 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 16Q6cMc6008390
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jul 2021 08:38:22 +0200
X-Received: from [167.87.33.191] ([167.87.33.191])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 16Q6cLDF030037;
	Mon, 26 Jul 2021 08:38:21 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] images: Enable inclusion of swupdate.inc by external layers
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Srinuvasan A <srinuvasan_a@mentor.com>,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
Message-ID: <096ae2a4-58bf-e622-7073-453e29bb7136@siemens.com>
Date: Mon, 26 Jul 2021 08:38:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: a9Cc4XIIAI9CDfs6S6ZEDx93x4520388AA=
Content-Type: multipart/mixed; boundary="4md49rzriJk4nKp44FeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627281505;
 bh=EKaGWp0GbCclR2zt5QrC2VMNrj7K18bXtetlXPVFggs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uU7GxE9H59H5dtjZaNs59VX25f1Pk09zh18nosofh0Y24vdeYTSsLoM9+7lwmfo/IbO
 bUKbBbpyyFO25cv5IdRfF2bashYf+VD6MU4bbBqbkuNB+2Y+QEsd1qk2W+6ega1c6Ik0S
 Gkd4A8SJ9sfIJFv6He2NsfbtYfYzblqIOxg=

--4md49rzriJk4nKp44FeE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Analogously to secureboot.inc, this file needs to ensure that
sw-description.tmpl artifact it pulls can be found even if the including
recipe is in a different layer.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/swupdate.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 6708a7e..06ad5af 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -9,6 +9,8 @@
 # SPDX-License-Identifier: MIT
 #
 
+FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
+
 EXTRACT_PARTITIONS = "img4"
 ROOTFS_PARTITION_NAME="img4.gz"
 
-- 
2.26.2

--4md49rzriJk4nKp44FeE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6629): https://lists.cip-project.org/g/cip-dev/message=
/6629
Mute This Topic: https://lists.cip-project.org/mt/84453358/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4md49rzriJk4nKp44FeE--

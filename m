Return-Path: <SRS0=iTq/=GV=lists.cip-project.org=bounce+64572+6094+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF91C4332D
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 10:36:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2703B22227
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 10:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2703B22227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6094+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xWn5YY4521723x1kJibn9zuX; Mon, 18 Jan 2021 02:36:04 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.31925.1610966162210926758
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jan 2021 02:36:02 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 10IAa0tD008296
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 18 Jan 2021 11:36:00 +0100
X-Received: from md2dvrtc.fritz.box ([139.22.46.47])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10IAZwgl032291;
	Mon, 18 Jan 2021 11:36:00 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 4/4] kas: update ISAR
Date: Mon, 18 Jan 2021 11:35:58 +0100
Message-Id: <20210118103558.18100-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210118103558.18100-1-Quirin.Gylstorff@siemens.com>
References: <20210118103558.18100-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Rftihmv3LAbL3K09cbcuXplex4520388AA=
Content-Type: multipart/mixed; boundary="WFmjfbhAZwY80ITNeh0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610966164;
 bh=rXVw5aBq2Gr32bP/3FxtnhKWC7argaNq6SilWW9u/o4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=GQ/2f8xGHoQwVOpswOgPr8sENObm2Gh8Ek/IAzLkmS8VSGjfToS1pS0gIavqhSCooO6
 UaRuKV9K5Ij03HcKKqw2ZpxaxIT5MpC7g1JEh9UgHJPfAnRp0/jJpDcYEEYWQawdmmcgK
 QBo992ZYYeb8igEAO3tHSRbuzH+3evrpH2g=

--WFmjfbhAZwY80ITNeh0f
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index f50cd6c..9514083 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 76eac233f1b1d0d117b3f05b3dec8a6da1cdf4c7
+    refspec: cd1327a47a7b00df98eded582aaf5b1ebdd45628
     layers:
       meta:
     patches:
-- 
2.20.1


--WFmjfbhAZwY80ITNeh0f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6094): https://lists.cip-project.org/g/cip-dev/message=
/6094
Mute This Topic: https://lists.cip-project.org/mt/79920022/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WFmjfbhAZwY80ITNeh0f--

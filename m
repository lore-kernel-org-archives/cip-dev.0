Return-Path: <SRS0=jD7e=CJ=lists.cip-project.org=bounce+64572+5339+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CBFC433E2
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 09:21:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF09208DB
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 09:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="C9KU5sZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF09208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5339+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id h8PxYY4521723xkbB6OdnP7f; Mon, 31 Aug 2020 02:21:28 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.49900.1598865686656645735
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 02:21:27 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 07V9LNO0030076
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2020 11:21:24 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.39.104])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07V9LMgP030412;
	Mon, 31 Aug 2020 11:21:23 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH 1/3] hihope-rzg2m: Align kas filename with machine name
Date: Mon, 31 Aug 2020 11:21:20 +0200
Message-Id: <9be5523d6a3ef4bdd3a01b3b8c834b9a4d140a64.1598865682.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1598865682.git.jan.kiszka@siemens.com>
References: <cover.1598865682.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ScraMLFRobb8yrDHrQK8qJOFx4520388AA=
Content-Type: multipart/mixed; boundary="eXMFbXcapXm7xT4UEhq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598865688;
 bh=Xu5ctG+B9SH7O7FpKbJ2haQaBj6ZYdenKSf2m/rzbJw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=C9KU5sZMkAL8OH6zMhMsVRCsp0oXLWZeyr2MNZcx+V9kMo+FoUQ0kpj3Kl6/TWuECUA
 LkvX7KGqPPMrF0J28D/pKw8YheVm81lrz8YB80BOdyDbiPLWMHBHP6EwWjoFO5ANLk10o
 +lHJou0bpqmtUl1qJCKIDtwVoQBtw8Jn5Xg=

--eXMFbXcapXm7xT4UEhq4
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows for fixing the extends-based CI build.

Fixes: 3510f8a66f80 ("ci: Rewrite using extends")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                            | 4 ++--
 kas/board/{rzg2m.yml => hihope-rzg2m.yml} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename kas/board/{rzg2m.yml => hihope-rzg2m.yml} (100%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index af900de..cd25437 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -57,7 +57,7 @@ build:hihope-rzg2m-base:
   extends:
     - .build_base
   variables:
-    target: rzg2m
+    target: hihope-rzg2m
     dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
 
 build:qemu-amd64-base:
@@ -97,6 +97,6 @@ build:hihope-rzg2m-test:
   extends:
     - .build_base
   variables:
-    target: rzg2m
+    target: hihope-rzg2m
     extention: test
     dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
diff --git a/kas/board/rzg2m.yml b/kas/board/hihope-rzg2m.yml
similarity index 100%
rename from kas/board/rzg2m.yml
rename to kas/board/hihope-rzg2m.yml
-- 
2.26.2


--eXMFbXcapXm7xT4UEhq4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5339): https://lists.cip-project.org/g/cip-dev/message=
/5339
Mute This Topic: https://lists.cip-project.org/mt/76530565/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--eXMFbXcapXm7xT4UEhq4--

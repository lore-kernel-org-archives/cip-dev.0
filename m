Return-Path: <SRS0=/FKB=CJ=lists.cip-project.org=bounce+64572+5333+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A8CC433E6
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 06:08:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D03720782
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 06:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="w8qEDHj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D03720782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5333+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wzJhYY4521723xyzE3LQ5Cld; Sun, 30 Aug 2020 23:08:50 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.47972.1598854128259118244
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Aug 2020 23:08:49 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 07V68i9I032721
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2020 08:08:45 +0200
X-Received: from [167.87.39.104] ([167.87.39.104])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07V68iA1011144;
	Mon, 31 Aug 2020 08:08:44 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] ci: Fix hihope-rzg2m deployment
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <9e5cfe5b-70e0-d9fa-f5b7-117326329421@siemens.com>
Date: Mon, 31 Aug 2020 08:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aCRmYp50xZerGwRLf3SNzzPmx4520388AA=
Content-Type: multipart/mixed; boundary="mhzWg1S1uN6WzkH49drQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598854130;
 bh=XBw8CElZlwD5PIhE7R2/OXiyzVgvRV0SiaoDB1GwxEc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=w8qEDHj3kn5xpAC28CL6ih7T9F+EEmDwdyasgLSxMvWdsbgqPeKgyhUYhLc3NqxZx8M
 iD22a09uyU+cUXDKy6Kd5ESlq7R/yo6lZR+Of5LDT+xeqfgdCPs7Y86bnadkovqA4u/iO
 OBP/7o/HUjK40Gj4l9BEDvTjbWq2CMDBp1I=

--mhzWg1S1uN6WzkH49drQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Fixes: 3510f8a66f80 ("ci: Rewrite using extends")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5bd4774..e8f398d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -24,7 +24,7 @@ all:
     - scripts/deploy-cip-core.sh buster iwg20m base r8a7743-iwg20d-q7-dbcm-ca.dtb
     # rzg2m
     - kas build kas-cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
-    - scripts/deploy-cip-core.sh buster rzg2m base renesas/r8a774a1-hihope-rzg2m-ex.dtb
+    - scripts/deploy-cip-core.sh buster hihope-rzg2m base renesas/r8a774a1-hihope-rzg2m-ex.dtb
 
     # qemu-amd64 / security
     - kas build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
@@ -41,4 +41,4 @@ all:
     - scripts/deploy-cip-core.sh buster iwg20m test r8a7743-iwg20d-q7-dbcm-ca.dtb
     # rzg2m / test
     - kas build kas-cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/test.yml:kas/opt/targz-img.yml
-    - scripts/deploy-cip-core.sh buster rzg2m test renesas/r8a774a1-hihope-rzg2m-ex.dtb
+    - scripts/deploy-cip-core.sh buster hihope-rzg2m test renesas/r8a774a1-hihope-rzg2m-ex.dtb
-- 
2.26.2


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--mhzWg1S1uN6WzkH49drQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5333): https://lists.cip-project.org/g/cip-dev/message=
/5333
Mute This Topic: https://lists.cip-project.org/mt/76529103/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mhzWg1S1uN6WzkH49drQ--

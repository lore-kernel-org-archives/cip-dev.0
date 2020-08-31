Return-Path: <SRS0=xIVU=CJ=lists.cip-project.org=bounce+64572+5337+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D69CC43461
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 09:21:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBFD20936
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 09:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VrsrJJxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBFD20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5337+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KdtvYY4521723xRA9xyjwZHc; Mon, 31 Aug 2020 02:21:29 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.49655.1598865687016356714
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 02:21:27 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 07V9LOGE001624
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2020 11:21:24 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.39.104])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07V9LMgQ030412;
	Mon, 31 Aug 2020 11:21:23 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH 2/3] ci: Do not try to deploy the security image
Date: Mon, 31 Aug 2020 11:21:21 +0200
Message-Id: <83d75816ceb5f74802ac0cec5292bf257ffc2d48.1598865682.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1598865682.git.jan.kiszka@siemens.com>
References: <cover.1598865682.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SYCvSYbG4VvyX4nUr2C02JVCx4520388AA=
Content-Type: multipart/mixed; boundary="BK3avaEwgclKfRy03ZRf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598865689;
 bh=WBKDUeTFptzeaUzMHoishU/EvUNY+XlOqtP05+DXj7o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VrsrJJxmXJMjtxyCQPitjQxRpxmX+BRfeATx3nGJXzAOw5AJX/CgW2ONpVgh6CIT2AB
 BKORp4YvsytKfBoNXUoL5Z/RWmHO/vnNRC3WRPtvJySwjU0zZzQByF9kcl7XGa1ZBxFwz
 bqySnTcpRs0YwjRWQb5G0OsSkYVnYgqEtww=

--BK3avaEwgclKfRy03ZRf
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

This is not used, and the image is not available, so it breaks the
build.

Fixes: 3510f8a66f80 ("ci: Rewrite using extends")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index cd25437..0b0a771 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -7,6 +7,7 @@ variables:
   use_rt: enable
   targz: enable
   dtb: none
+  deploy: enable
 
 stages:
   - build
@@ -30,7 +31,7 @@ default:
     - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
     - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
     - kas build ${base_yaml}
-    - scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}
+    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi
 
 # base image
 build:simatic-ipc227e-base:
@@ -68,6 +69,7 @@ build:qemu-amd64-base:
     extention: security
     use_rt: disable
     targz: disable
+    deploy: disable
 
 # test
 build:simatic-ipc227e-test:
-- 
2.26.2


--BK3avaEwgclKfRy03ZRf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5337): https://lists.cip-project.org/g/cip-dev/message=
/5337
Mute This Topic: https://lists.cip-project.org/mt/76530563/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BK3avaEwgclKfRy03ZRf--

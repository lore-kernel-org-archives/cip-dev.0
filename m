Return-Path: <SRS0=boLY=CJ=lists.cip-project.org=bounce+64572+5334+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418F0C433E6
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 06:09:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1078420707
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 06:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cgTSURlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1078420707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5334+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lesvYY4521723xE1yLFMpgWH; Sun, 30 Aug 2020 23:09:20 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.47652.1598854159869183525
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Aug 2020 23:09:20 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07V69IWh004658
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 31 Aug 2020 08:09:18 +0200
X-Received: from [167.87.39.104] ([167.87.39.104])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07V69HoL011507
	for <cip-dev@lists.cip-project.org>; Mon, 31 Aug 2020 08:09:18 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] Update / pin to kas 2.2
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <0024db12-65df-d18f-0220-b2c57c958981@siemens.com>
Date: Mon, 31 Aug 2020 08:09:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sluVaG9KTeiaeJVLmCKxas6Ux4520388AA=
Content-Type: multipart/mixed; boundary="cM029ZXcVwMPJBxONv1d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598854160;
 bh=12Kd3A3RrkZimv2h5nnxGqJboHe7Gw6pij6RZN4K+zc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cgTSURlPR4Th/yc7I8ds1gM+8nyrWUid5xJdVjEMdSi25PlX4OqBGFkg5ZK0Ve+AA4h
 wPnIj/M0GCe62T8uUop4PbFG1CrgKE8+0qvXp8aGaxoh7b95fOnT1xagE/QjL+P3WXzi6
 bgQnmE2fb+U9uwehctpWi6Z0jWJMl0f3jBA=

--cM029ZXcVwMPJBxONv1d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Better recommend a well-defined version in the README and use that in CI
as well. 2.2 is latest release.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 README.md      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e8f398d..163c0d3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,4 +1,4 @@
-image: kasproject/kas-isar:1.1
+image: kasproject/kas-isar:2.2
 
 variables:
   GIT_STRATEGY: clone
diff --git a/README.md b/README.md
index 250dbad..4f74af7 100644
--- a/README.md
+++ b/README.md
@@ -12,7 +12,7 @@ from scratch.
 
 Install `kas-docker` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/master/kas-docker
+    wget https://raw.githubusercontent.com/siemens/kas/2.2/kas-docker
     chmod a+x kas-docker
 
 Furthermore, install docker and make sure you have required permissions to
-- 
2.26.2

--cM029ZXcVwMPJBxONv1d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5334): https://lists.cip-project.org/g/cip-dev/message=
/5334
Mute This Topic: https://lists.cip-project.org/mt/76529104/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--cM029ZXcVwMPJBxONv1d--

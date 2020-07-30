Return-Path: <SRS0=Bx9z=BJ=lists.cip-project.org=bounce+64572+5071+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF96C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:36:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904072075F
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aOIVXypi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904072075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5071+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SNsHYY4521723xwaTHbFLrqf; Thu, 30 Jul 2020 02:36:46 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web11.4787.1596101804899929581
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2020 02:36:45 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 06U9agR3002356
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2020 11:36:42 +0200
X-Received: from [167.87.91.228] ([167.87.91.228])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06U9afHV028520
	for <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2020 11:36:42 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [PATCH] kas: Pull common target out of board files
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <e3f79f2a-303f-c489-5901-9dd80457b2d0@siemens.com>
Date: Thu, 30 Jul 2020 11:36:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7lfCopLLOmYszlR16793Gjlvx4520388AA=
Content-Type: multipart/mixed; boundary="be56BKvcu38dBTflv1mW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596101806;
 bh=fLh8+Qq6OdBbBZq6VKg7RSjoNv4aTOe2xiuOOwFXWrg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=aOIVXypiuC6GyHLzsnnfdYtA3qA7DWid7sWY0dfOGmdqbtRNbHhjehC11NejqSXrzKp
 /o2cur7h+guEprWVeoBUcSTvxVCYu5kWEJBMyfdEx9JcewioVChfm0C2Za6HE3PuXeHCT
 MmUZXEc8YR9NAx1bTZhNxy9DzNMv6jmWL0g=

--be56BKvcu38dBTflv1mW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml                   | 1 +
 kas/board/bbb.yml             | 1 -
 kas/board/iwg20m.yml          | 1 -
 kas/board/qemu-amd64.yml      | 1 -
 kas/board/rzg2m.yml           | 1 -
 kas/board/simatic-ipc227e.yml | 1 -
 6 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 0da07db..f4edd0f 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -13,6 +13,7 @@ header:
   version: 8
 
 distro: cip-core-buster
+target: cip-core-image
 
 repos:
   cip-core:
diff --git a/kas/board/bbb.yml b/kas/board/bbb.yml
index 08e9ec0..fc8dbbe 100644
--- a/kas/board/bbb.yml
+++ b/kas/board/bbb.yml
@@ -13,4 +13,3 @@ header:
   version: 8
 
 machine: bbb
-target: cip-core-image
diff --git a/kas/board/iwg20m.yml b/kas/board/iwg20m.yml
index fbb2a2e..3def3af 100644
--- a/kas/board/iwg20m.yml
+++ b/kas/board/iwg20m.yml
@@ -13,4 +13,3 @@ header:
   version: 8
 
 machine: iwg20m
-target: cip-core-image
diff --git a/kas/board/qemu-amd64.yml b/kas/board/qemu-amd64.yml
index 8b6a3ac..02e99ba 100644
--- a/kas/board/qemu-amd64.yml
+++ b/kas/board/qemu-amd64.yml
@@ -13,4 +13,3 @@ header:
   version: 8
 
 machine: qemu-amd64
-target: cip-core-image
diff --git a/kas/board/rzg2m.yml b/kas/board/rzg2m.yml
index f68c7b8..bbef122 100644
--- a/kas/board/rzg2m.yml
+++ b/kas/board/rzg2m.yml
@@ -13,4 +13,3 @@ header:
   version: 8
 
 machine: hihope-rzg2m
-target: cip-core-image
diff --git a/kas/board/simatic-ipc227e.yml b/kas/board/simatic-ipc227e.yml
index 25db755..a2c6965 100644
--- a/kas/board/simatic-ipc227e.yml
+++ b/kas/board/simatic-ipc227e.yml
@@ -13,4 +13,3 @@ header:
   version: 8
 
 machine: simatic-ipc227e
-target: cip-core-image
-- 
2.26.2

--be56BKvcu38dBTflv1mW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5071): https://lists.cip-project.org/g/cip-dev/message=
/5071
Mute This Topic: https://lists.cip-project.org/mt/75883195/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--be56BKvcu38dBTflv1mW--

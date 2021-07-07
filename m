Return-Path: <SRS0=Usbx=L7=lists.cip-project.org=bounce+64572+6600+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC6C07E9B
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B553161C9A
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B553161C9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6600+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8JMDYY4521723xI40JUF3NSz; Wed, 07 Jul 2021 05:17:12 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.20222.1625660199616047543
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 05:16:40 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 167CGbXp014150
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:38 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 167CGaEa020405
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:37 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 4/9] Update Isar revision
Date: Wed,  7 Jul 2021 14:16:31 +0200
Message-Id: <4b8eaad4b549aa53bab9c39919ee19b8d8356d1a.1625660195.git.jan.kiszka@siemens.com>
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
X-Gm-Message-State: gOOdIFHov2UDbrZMSu2KqXfbx4520388AA=
Content-Type: multipart/mixed; boundary="XWzYlfNK5lQdfmJNAUeH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625660232;
 bh=D5icoiB1cHiUhGkB1zMjsihLAJiLP7GLqV5dStM/GnE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=dMn6/D8jl/mb7uMU4crtE2gDj7m8kJ0uCZ+60PBU4mvYO8yuw6LTCVH+YZWc9UgP/fP
 sFs81Yffl/yQNzm1TRnjBlzOh6AdiRv4OSObbMjxDN931Va0+RdKfnXA7MrrvfjQq3kz2
 0n5SVYbDQ6i/QS06jhHD1hftgqbvN9VTHh0=

--XWzYlfNK5lQdfmJNAUeH
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Move to latest master. The only patch we have still applied, could be
replaced by an upstream mechanism now, but that can come separately.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 9514083..8fb9004 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: cd1327a47a7b00df98eded582aaf5b1ebdd45628
+    refspec: 03124cca669f50b682336a0bdf4ede5a4238e144
     layers:
       meta:
     patches:
-- 
2.26.2


--XWzYlfNK5lQdfmJNAUeH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6600): https://lists.cip-project.org/g/cip-dev/message=
/6600
Mute This Topic: https://lists.cip-project.org/mt/84042867/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XWzYlfNK5lQdfmJNAUeH--

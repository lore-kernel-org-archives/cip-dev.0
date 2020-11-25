Return-Path: <SRS0=7sOA=E7=lists.cip-project.org=bounce+64572+5871+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE54C5519F
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:44:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE93F208C3
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Endpi+X1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE93F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5871+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id eW6FYY4521723x0lamw3bQjT; Wed, 25 Nov 2020 00:44:38 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.4182.1606293877788310671
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2020 00:44:38 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0AP8iYsS018085
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2020 09:44:35 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.32.40])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 0AP8iY4d024748;
	Wed, 25 Nov 2020 09:44:34 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH v2] classes/image_uuid: Generate new uuid if a new package is added
Date: Wed, 25 Nov 2020 09:44:33 +0100
Message-Id: <20201125084433.1277-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <c02e7a38-5bc1-7e4a-61fe-77cce775acab@siemens.com>
References: <c02e7a38-5bc1-7e4a-61fe-77cce775acab@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wJgBPYXrkJ5ILQCLHFwummgAx4520388AA=
Content-Type: multipart/mixed; boundary="cfT2kLX4rQjEAxj5LwqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606293878;
 bh=XrSqoEqXC2jBmdDc2u0fj7LoZZbcqhj4wIRJ0i6+IwI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Endpi+X1xWrT+fAqIEV15EONK+SL6EaCtLBEBgrnVGZIHskJwjyKRKitc2JFDPBZChN
 n4/F88bIZ8vArSTnx7IxUmG4kCiyU/9Tm99sMRfe2vuHbjw3ep9Sr8ZEFwMj7UdkQeO55
 q/09r+/QqP2GkjV6vzHiqRiSGaLejd5ngOw=

--cfT2kLX4rQjEAxj5LwqN
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

BB_BASEHASH only includes the task itself and its metadata.
Dependencies are not taken into account when this hash is
generated which means updating a package will not generate a new
UUID.

BB_TASKHASH takes the changes into account.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/image_uuid.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index d5337b8..2813ed9 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -12,7 +12,7 @@
 def generate_image_uuid(d):
     import uuid
 
-    base_hash = d.getVar("BB_BASEHASH_task-do_rootfs_install", True)
+    base_hash = d.getVar("BB_TASKHASH", True)
     if base_hash is None:
         return None
     return str(uuid.UUID(base_hash[:32], version=4))
-- 
2.20.1


--cfT2kLX4rQjEAxj5LwqN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5871): https://lists.cip-project.org/g/cip-dev/message=
/5871
Mute This Topic: https://lists.cip-project.org/mt/78496128/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--cfT2kLX4rQjEAxj5LwqN--

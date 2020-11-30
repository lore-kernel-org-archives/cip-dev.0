Return-Path: <SRS0=CveC=FE=lists.cip-project.org=bounce+64572+5902+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D97FC64E7B
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:48:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394192085B
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="C4n1TkuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394192085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5902+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IN97YY4521723xn2jrnEzveW; Mon, 30 Nov 2020 06:48:47 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.60860.1606747726391195267
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 06:48:46 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 0AUEmhGY021136
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 30 Nov 2020 15:48:44 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.13.210])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AUEmhOc017252;
	Mon, 30 Nov 2020 15:48:43 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH v2 0/2] Secureboot fixes
Date: Mon, 30 Nov 2020 15:48:40 +0100
Message-Id: <20201130144842.4221-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XR4VfRioMwCDJ4MdSgrXq3YZx4520388AA=
Content-Type: multipart/mixed; boundary="johzX9TQ6nt8GDT7c9c5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606747727;
 bh=3j9WwMAeP/7LDGN/ncRJnhsojFHVFAON3LrNyaOQVds=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=C4n1TkuFydXielAQSx3BleISuQQsn3SGt/KG0zmqayR7V8sZl8c/ioJ7hmgHoD0Bza0
 VKHuMQoHxzwN2tzXWJe5sNzlC2HrBT6zzY6+z9V+dhXgHR6qhIvvFp8jQ1M1wLN6qp8iq
 YxEyOHUMRW6gjknIubv0lo4uquyiY/MIlCo=

--johzX9TQ6nt8GDT7c9c5
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Adapt OVMF binaries to new upstream names.
Repeat scan for rootfs until udev finished populating /dev or a timeout occurs.
Build at:
https://gitlab.com/Quirin.Gy/isar-cip-core/-/pipelines/223158898

--
Changes Version 2:
- fix author and commit message

Vijai Kumar K (2):
  start-qemu.sh: Change OVMF binary names
  Secureboot:  Wait until udev populates /dev

 doc/README.secureboot.md                      |  12 +-
 .../files/secure-boot-debian-local-patch      | 104 +++++++++++-------
 start-qemu.sh                                 |   4 +-
 3 files changed, 72 insertions(+), 48 deletions(-)

-- 
2.20.1


--johzX9TQ6nt8GDT7c9c5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5902): https://lists.cip-project.org/g/cip-dev/message=
/5902
Mute This Topic: https://lists.cip-project.org/mt/78609367/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--johzX9TQ6nt8GDT7c9c5--

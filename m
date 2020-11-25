Return-Path: <SRS0=9GQH=E7=lists.cip-project.org=bounce+64572+5875+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1958C63777
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:55:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5586D208C3
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mm8ZPUgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5586D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5875+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HRcpYY4521723xJbWiokQ3Qx; Wed, 25 Nov 2020 00:55:42 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web11.4259.1606294541586499349
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2020 00:55:42 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 0AP8tdQX006908
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2020 09:55:39 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.32.40])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AP8tcJT019062;
	Wed, 25 Nov 2020 09:55:38 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH 0/2] Secureboot fixes
Date: Wed, 25 Nov 2020 09:55:36 +0100
Message-Id: <20201125085538.1561-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pZ230Zhn2ipwmWuAdQLuldjYx4520388AA=
Content-Type: multipart/mixed; boundary="GTFg6tHXlzoF5NL8TEdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606294542;
 bh=Ld+Y4/o9+HJHpt3KHGucJgNbeHXZRgfJgkwkMVf5mS4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=mm8ZPUgiPYIC9L8Ren1noDztx5BepN/9keWOblgbtt6+qXxhqVs7eJkYsgKOq5pnikW
 DdSpbqHtvuOp2By8L+ZFnn5G7L/8uZIYHPmImtlQ8q79ZdzM4OJgox7gVj5Q8neVMwcsT
 +tfCtd3b2j6/2hQFmymR1wv37qf6hpC5PuI=

--GTFg6tHXlzoF5NL8TEdX
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Adapt OVMF binaries to new upstream names.
Repeat scan for rootfs until udev finished populating /dev or a timeout occurs.
Build at:
https://gitlab.com/Quirin.Gy/isar-cip-core/-/pipelines/220660576

Quirin Gylstorff (2):
  start-qemu.sh: Change OVMF binary names
  Secureboot:  Wait until udev populates /dev

 doc/README.secureboot.md                      |  12 +-
 .../files/secure-boot-debian-local-patch      | 104 +++++++++++-------
 start-qemu.sh                                 |   4 +-
 3 files changed, 72 insertions(+), 48 deletions(-)

-- 
2.20.1


--GTFg6tHXlzoF5NL8TEdX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5875): https://lists.cip-project.org/g/cip-dev/message=
/5875
Mute This Topic: https://lists.cip-project.org/mt/78496225/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GTFg6tHXlzoF5NL8TEdX--

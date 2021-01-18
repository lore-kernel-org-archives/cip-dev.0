Return-Path: <SRS0=VFSy=GV=lists.cip-project.org=bounce+64572+6095+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A02C433E6
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 10:37:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77D422241
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 10:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77D422241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6095+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id h7e3YY4521723xWsOPMCqv6w; Mon, 18 Jan 2021 02:37:08 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.31678.1610966227614755179
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jan 2021 02:37:08 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 10IAb5GQ003036
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jan 2021 11:37:06 +0100
X-Received: from md2dvrtc.fritz.box ([139.22.46.47])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10IAb54V008329;
	Mon, 18 Jan 2021 11:37:05 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org,
        kazuhiro3.hayashi@toshiba.co.jp
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][RFC 0/1] Move root password
Date: Mon, 18 Jan 2021 11:37:03 +0100
Message-Id: <20210118103704.18195-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KDu8XemMlVeWounUeYXPVU2qx4520388AA=
Content-Type: multipart/mixed; boundary="6tBXy8jjeiFEVOCxStJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610966228;
 bh=GcFRbmub/fG7wDrLzM7oZUA7ZCh9HqwSiIjMXU3lUCY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pe9dFVwCjvdYfyFaU+JkzY37z1Sh8Xbf15hvsS8ed1rQ/Ufe5gX7iWwqmVR3xaJz2QA
 7CtSxSpu0fsT9uFqQhdWnA9+k5oFeIPf/ESQhZqKKJhzyQ7WK3G8aAI2lejPvgYdIjCWa
 Vv+6jM1VBnyUcWPMmoSYHO1Dvg/MTVrkeYQ=

--6tBXy8jjeiFEVOCxStJG
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If you use isar-cip-core downstream the root user in kas-cip.yml
can set the root password in a production image. Avoid this by moving
 the user and password to cip-core-image.

Should we rename the cip-core-image to cip-core-image-demo to
clarify the indented use?

cip-core-image-security now requires cip-core-image as base. We could
move the content of cip-core-image-security to a include to fasilitate
the usage downstream.

Quirin Gylstorff (1):
  image: Move root password

 kas-cip.yml                                         | 4 ----
 recipes-core/images/cip-core-image-security.bb      | 3 +++
 recipes-core/images/cip-core-image.bb               | 8 +++++++-
 recipes-core/security-customizations/files/postinst | 6 ------
 4 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.20.1


--6tBXy8jjeiFEVOCxStJG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6095): https://lists.cip-project.org/g/cip-dev/message=
/6095
Mute This Topic: https://lists.cip-project.org/mt/79920034/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6tBXy8jjeiFEVOCxStJG--

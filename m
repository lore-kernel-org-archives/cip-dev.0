Return-Path: <SRS0=7TrT=HD=lists.cip-project.org=bounce+64572+6156+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BE2C433E0
	for <cip-dev@archiver.kernel.org>; Mon,  1 Feb 2021 16:24:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F75164E8D
	for <cip-dev@archiver.kernel.org>; Mon,  1 Feb 2021 16:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F75164E8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6156+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Mr2IYY4521723xaCJOSV1Xhd; Mon, 01 Feb 2021 08:24:30 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.36560.1612196668211915275
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Feb 2021 08:24:29 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 111GOPx7008685
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 1 Feb 2021 17:24:26 +0100
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.15.10])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 111GOPdi017026;
	Mon, 1 Feb 2021 17:24:25 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 0/2] Secureboot fixes
Date: Mon,  1 Feb 2021 17:24:23 +0100
Message-Id: <20210201162425.31726-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FZfIkqmoOcKK7rZUL4r3PRWdx4520388AA=
Content-Type: multipart/mixed; boundary="Awguf7Oq6kRD3Uw9Su5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612196670;
 bh=SRPtV1I4vaN5VJ/5AhJHC+caVLxxl2p5aKxlF7Pck/c=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wuotCZ6SgWMfXuh0jLYCzWkqygp3k7P1zuUK2Sdii5+3gQ0kJfqwgur69qBYalnmDWv
 VeCzjoCHMNcwfqLelx+W/t7oedD9QS8/9q06xPOH2FOB8ocH3mxPA6gDjwPeGFydEOTAW
 B4OGLRIi5BmFSqfr8DjkNqO8UB8J8YFbrE8=

--Awguf7Oq6kRD3Uw9Su5g
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Use correct swu-description.tmpl and use own file for image-uuid
to avoid overwrite by Debian package `base-files`.

Quirin Gylstorff (2):
  swupdate: Secure-boot fix paths
  secure-boot: Move image-uuid to own file

 classes/image_uuid.bbclass                                  | 4 +---
 recipes-core/images/secureboot.inc                          | 2 ++
 recipes-core/images/swupdate.inc                            | 2 --
 .../initramfs-config/files/initramfs.image_uuid.hook        | 6 +++---
 .../initramfs-config/files/secure-boot-debian-local-patch   | 4 ++--
 5 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.20.1


--Awguf7Oq6kRD3Uw9Su5g
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6156): https://lists.cip-project.org/g/cip-dev/message=
/6156
Mute This Topic: https://lists.cip-project.org/mt/80289767/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Awguf7Oq6kRD3Uw9Su5g--

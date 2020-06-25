Return-Path: <SRS0=vlr+=AG=lists.cip-project.org=bounce+64572+4814+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF5FC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:12:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AB820720
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Cfm+/Hkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AB820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4814+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NvakYY4521723xbYEjMj2dqd; Thu, 25 Jun 2020 06:12:54 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.10140.1593090772502602768
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 06:12:53 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 05PDCnA0028149
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 15:12:49 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05PDCmRG024761;
	Thu, 25 Jun 2020 15:12:48 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH 0/2] Cleanup
Date: Thu, 25 Jun 2020 15:12:46 +0200
Message-Id: <20200625131248.15742-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ksjNe6vZIue2oCoxqr52sq69x4520388AA=
Content-Type: multipart/mixed; boundary="ErWPiTPkdgBlpAZPuzAU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593090774;
 bh=zsk14kJbSYZB9rfwAPE3k3ZHd5il1BezBzvrvQkGops=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Cfm+/Hkz6tJFqwof/3qnC9ckgSuoz+NmoXR3eBkxxc2Edkb6s87zcDJR/jnaKJSX7n3
 pT4A1oqfOziR+0Xg64yowcXAznn3g86LEXCOduM1K3X+BLQ9sx0y6lc4xokU51Z8gve8X
 aHLQrG6R4No0R9nFkgHLsqflKK2lRaLAEI4=

--ErWPiTPkdgBlpAZPuzAU
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Move kas related files into folder kas for a cleaner repository root.
Update isar to remove patches folder for now

Quirin Gylstorff (2):
  update ISAR
  kas: Restructure kas files.

 .gitlab-ci.yml                                |  8 ++--
 README.md                                     |  4 +-
 conf/machine/hihope-rzg2m.conf                |  4 +-
 conf/machine/iwg20m.conf                      |  4 +-
 ...d-path-to-image-for-arm-kernels-4.12.patch | 37 -------------------
 board-bbb.yml => kas/board/bbb.yml            |  0
 board-iwg20m.yml => kas/board/iwg20m.yml      |  0
 .../board/qemu-amd64.yml                      |  0
 board-rzg2m.yml => kas/board/rzg2m.yml        |  0
 .../board/simatic-ipc227e.yml                 |  0
 kas.yml => kas/cip.yml                        |  7 +---
 opt-4.4.yml => kas/opt/4.4.yml                |  0
 opt-rt.yml => kas/opt/rt.yml                  |  0
 opt-stretch.yml => kas/opt/stretch.yml        |  0
 opt-targz-img.yml => kas/opt/targz-img.yml    |  0
 15 files changed, 11 insertions(+), 53 deletions(-)
 delete mode 100644 isar-patches/0001-linux-custom-add-path-to-image-for-arm-kernels-4.12.patch
 rename board-bbb.yml => kas/board/bbb.yml (100%)
 rename board-iwg20m.yml => kas/board/iwg20m.yml (100%)
 rename board-qemu-amd64.yml => kas/board/qemu-amd64.yml (100%)
 rename board-rzg2m.yml => kas/board/rzg2m.yml (100%)
 rename board-simatic-ipc227e.yml => kas/board/simatic-ipc227e.yml (100%)
 rename kas.yml => kas/cip.yml (74%)
 rename opt-4.4.yml => kas/opt/4.4.yml (100%)
 rename opt-rt.yml => kas/opt/rt.yml (100%)
 rename opt-stretch.yml => kas/opt/stretch.yml (100%)
 rename opt-targz-img.yml => kas/opt/targz-img.yml (100%)

-- 
2.20.1


--ErWPiTPkdgBlpAZPuzAU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4814): https://lists.cip-project.org/g/cip-dev/message=
/4814
Mute This Topic: https://lists.cip-project.org/mt/75102307/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ErWPiTPkdgBlpAZPuzAU--

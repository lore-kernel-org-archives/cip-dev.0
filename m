Return-Path: <SRS0=E0nY=FE=lists.cip-project.org=bounce+64572+5906+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6641BC64E8A
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 19:32:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674E12067C
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 19:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EjYZGShC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674E12067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5906+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uFXiYY4521723x0Wgo4PyJXo; Mon, 30 Nov 2020 11:32:23 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.2145.1606764739987916373
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 11:32:21 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 0AUJWHo3018324
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 30 Nov 2020 20:32:17 +0100
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.39.132])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AUJWGdg001649
	for <cip-dev@lists.cip-project.org>; Mon, 30 Nov 2020 20:32:17 +0100
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 0/3] Some updates
Date: Mon, 30 Nov 2020 20:32:13 +0100
Message-Id: <cover.1606764736.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KmbsBx3iTHM2dZL5nYfXaKGjx4520388AA=
Content-Type: multipart/mixed; boundary="qQtzeKwqrHTE0TGXgVkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606764743;
 bh=LuVikXtttazEiSh+qPKIEdx6USCm0Lsqui5HjMvjoOY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=EjYZGShCrh1huliV5F7TbhXA5ggfYdVz6RLCTT4TaO9gx99UDR8NdPsqiiuYW1B6mK5
 claHIOSBtaOkt5Lejhqc6lBKg7zYeZo7LDZEv2nNMwLX7EVsu4bYBWrwYYP0EBjczEn4W
 hGf1/WEwaRGgMJPDNlzU8u+Us4OlNKqsbPU=

--qQtzeKwqrHTE0TGXgVkD
Content-Transfer-Encoding: 8bit

The last patch has to wait until [1] is rolled out to our CI
infrastructure.

Jan

[1] https://gitlab.com/cip-project/cip-testing/gitlab-cloud-ci/-/commit/1cd85bec680587b9410c56cdfebc3a4d6ba1bd8b

Jan Kiszka (3):
  README: Add some community resources
  Update Isar revision
  Update to kas 2.3.3

 .gitignore                                    |   3 +-
 .gitlab-ci.yml                                |   2 +-
 README.md                                     |  29 ++-
 conf/distro/cip-core-buster.conf              |   2 +
 conf/distro/cip-core-stretch.conf             |   2 +
 doc/README.secureboot.md                      |   4 +-
 doc/README_iwg20m.md                          |  11 +-
 .../0001-u-boot-add-libubootenv.patch         | 168 ------------------
 kas-cip.yml                                   |   9 +-
 kas/board/bbb.yml                             |   2 +-
 kas/board/hihope-rzg2m.yml                    |   2 +-
 kas/board/iwg20m.yml                          |   2 +-
 kas/board/qemu-amd64.yml                      |   2 +-
 kas/board/simatic-ipc227e.yml                 |   2 +-
 kas/opt/4.4.yml                               |   2 +-
 kas/opt/ebg-secure-boot-base.yml              |   2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml          |   2 +-
 kas/opt/ebg-swu.yml                           |   2 +-
 kas/opt/qemu-swupdate.yml                     |   2 +-
 kas/opt/rt.yml                                |   2 +-
 kas/opt/security.yml                          |   2 +-
 kas/opt/stretch.yml                           |   2 +-
 kas/opt/targz-img.yml                         |   2 +-
 kas/opt/test.yml                              |   2 +-
 .../wic/plugins/source/efibootguard-boot.py   |   2 +-
 .../wic/plugins/source/efibootguard-efi.py    |   2 +-
 26 files changed, 57 insertions(+), 207 deletions(-)
 delete mode 100644 isar-patches/0001-u-boot-add-libubootenv.patch

-- 
2.26.2


--qQtzeKwqrHTE0TGXgVkD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5906): https://lists.cip-project.org/g/cip-dev/message=
/5906
Mute This Topic: https://lists.cip-project.org/mt/78616510/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qQtzeKwqrHTE0TGXgVkD--

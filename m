Return-Path: <SRS0=Qw8c=GV=lists.cip-project.org=bounce+64572+6102+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E1C433E6
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 15:06:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DDD622BEA
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 15:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDD622BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6102+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zzndYY4521723xbs5RqP57Y4; Mon, 18 Jan 2021 07:06:30 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.34428.1610982389237115992
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jan 2021 07:06:30 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 10IF6QLb018937
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 18 Jan 2021 16:06:27 +0100
X-Received: from md2dvrtc.fritz.box ([139.22.46.47])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10IF6PYS021968;
	Mon, 18 Jan 2021 16:06:26 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v2 0/4] Updates & Fixes
Date: Mon, 18 Jan 2021 16:06:21 +0100
Message-Id: <20210118150625.20155-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xzVw7r1wcRpgvOwgHUUbnIaxx4520388AA=
Content-Type: multipart/mixed; boundary="0orP6p2RJ1Z2Kz1v2fhS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610982390;
 bh=lAqE2asif3PP4faMqjKuZin84nUfd2JQPSN5r8wVmaI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=d1lUAgAn+FBTv/GdA7Dy8Khd4DLTSgc9VudM0zahVTqyCj5hjEccd+QPwwtQgnbFdxs
 D8u3W73uXguDryRcUYHW9AQ4NkO5YZowkkbARDPg/6JPYLb8C2Vj2NDEo304g0jjwWimW
 /VQmeMG4THZJ65gPDKRgdbJ6dUA6TgaqaGY=

--0orP6p2RJ1Z2Kz1v2fhS
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>


- Update Kernel releases
- Update ISAR to current HEAD of next

- fix swupdate cross-compile
- use libubootenv for swupdate & u-boot this works only with upstream u-boot-tools
  newer than 2019.10. The isar build is fixed with commit e77d030ed0ac5b122aa7b798131062946cb36699.

Changes V2:
- fix recipe name,  add missing rt

Quirin Gylstorff (4):
  swupdate: enable cross-compile by setting PKG_CONFIG_PATH
  swupdate: use libubootenv
  update linux kernels
  kas: update ISAR

 classes/swupdate-config.bbclass                             | 6 +++---
 kas-cip.yml                                                 | 2 +-
 recipes-core/swupdate/files/debian/rules.tmpl               | 1 +
 recipes-core/swupdate/swupdate.bb                           | 2 +-
 ...35-cip31-rt13.bb => linux-cip-rt_4.19.160-cip39-rt17.bb} | 4 ++--
 ...231-cip47-rt30.bb => linux-cip-rt_4.4.244.cip51-rt32.bb} | 4 ++--
 ...ux-cip_4.19.140-cip33.bb => linux-cip_4.19.165-cip41.bb} | 4 ++--
 ...inux-cip_4.4.230-cip47.bb => linux-cip_4.4.249-cip53.bb} | 4 ++--
 8 files changed, 14 insertions(+), 13 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.135-cip31-rt13.bb => linux-cip-rt_4.19.160-cip39-rt17.bb} (54%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.231-cip47-rt30.bb => linux-cip-rt_4.4.244.cip51-rt32.bb} (54%)
 rename recipes-kernel/linux/{linux-cip_4.19.140-cip33.bb => linux-cip_4.19.165-cip41.bb} (53%)
 rename recipes-kernel/linux/{linux-cip_4.4.230-cip47.bb => linux-cip_4.4.249-cip53.bb} (53%)

-- 
2.20.1


--0orP6p2RJ1Z2Kz1v2fhS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6102): https://lists.cip-project.org/g/cip-dev/message=
/6102
Mute This Topic: https://lists.cip-project.org/mt/79924716/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0orP6p2RJ1Z2Kz1v2fhS--

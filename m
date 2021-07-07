Return-Path: <SRS0=yiB1=L7=lists.cip-project.org=bounce+64572+6597+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D71C07E95
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:16:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461AF61CAA
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461AF61CAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6597+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WZ8PYY4521723xXgkhEInLcF; Wed, 07 Jul 2021 05:16:58 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.20221.1625660199018565824
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 05:16:39 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 167CGbea013756
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:37 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 167CGaEW020405;
	Wed, 7 Jul 2021 14:16:36 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH 0/9] Varions Updates: bullseye, kernel, kas, isar
Date: Wed,  7 Jul 2021 14:16:27 +0200
Message-Id: <cover.1625660195.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 51CZCQmBpgQuFjLkEyu0F9Tax4520388AA=
Content-Type: multipart/mixed; boundary="OWKYUDzJGTT8zxtVJUB0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625660218;
 bh=bMMYj1WMrUqXocu4UV1jqy+kXj4fMte6a6vuOYzvN/0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=W2vscOXzin0f9XM7hX0vuliUP87+W9xb3gfvUQ2kiSxjEw55kUSy9yQ90pqb46MOS8U
 9bj8cPb4Tcu65ei6rHWoYg5IRIBoMEc+Swz6k8wUeJJwqf3LwrfO0RO1+1Q8niTJj7mjb
 maoyaBYz88SPRf+R3ffG4puwTstqbcR1LwM=

--OWKYUDzJGTT8zxtVJUB0
Content-Transfer-Encoding: 8bit

See patches for Details.

Jan


CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Jan Kiszka (9):
  ci: Select large runner
  Update to kas 2.5
  swupdate: Do not add .ini file to SRC_URI if SWUPDATE_BOOTLOADER is
    not set
  Update Isar revision
  conf: Drop no longer needed DISTRO_APT_SOURCES settings
  Add bullseye image option
  ci: Add bullseye targets
  linux-cip: Update to latest releases
  wic: Address y2038 warnings of latest Isar

 .gitlab-ci.yml                                | 39 ++++++++++++++++++-
 README.md                                     |  2 +-
 ...ore-buster.conf => cip-core-bullseye.conf} |  6 +--
 conf/distro/cip-core-buster.conf              |  2 -
 conf/distro/cip-core-stretch.conf             |  2 -
 kas-cip.yml                                   |  2 +-
 kas/opt/bullseye.yml                          | 15 +++++++
 recipes-core/swupdate/swupdate.bb             |  2 +-
 ...bb => linux-cip-rt_4.19.195-cip52-rt20.bb} |  2 +-
 ....bb => linux-cip-rt_4.4.262-cip55-rt34.bb} |  2 +-
 ...9-cip53.bb => linux-cip_4.19.195-cip52.bb} |  2 +-
 ...65-cip41.bb => linux-cip_4.4.272-cip58.bb} |  2 +-
 wic/bbb.wks                                   |  2 +-
 wic/simatic-ipc227e.wks                       |  2 +-
 wic/swupdate-partition.inc                    |  4 +-
 15 files changed, 66 insertions(+), 20 deletions(-)
 copy conf/distro/{cip-core-buster.conf => cip-core-bullseye.conf} (64%)
 create mode 100644 kas/opt/bullseye.yml
 rename recipes-kernel/linux/{linux-cip-rt_4.19.160-cip39-rt17.bb => linux-cip-rt_4.19.195-cip52-rt20.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.244-cip51-rt32.bb => linux-cip-rt_4.4.262-cip55-rt34.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.249-cip53.bb => linux-cip_4.19.195-cip52.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.19.165-cip41.bb => linux-cip_4.4.272-cip58.bb} (68%)

-- 
2.26.2


--OWKYUDzJGTT8zxtVJUB0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6597): https://lists.cip-project.org/g/cip-dev/message=
/6597
Mute This Topic: https://lists.cip-project.org/mt/84042864/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OWKYUDzJGTT8zxtVJUB0--

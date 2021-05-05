Return-Path: <SRS0=Twf7=KA=lists.cip-project.org=bounce+64572+6420+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A7C433ED
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 08:05:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF6D600D4
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 08:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF6D600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6420+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kpsRYY4521723xXeVaLyVPLS; Wed, 05 May 2021 01:05:23 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.4864.1620201921946451791
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 01:05:22 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 14585JIo030525
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 5 May 2021 10:05:19 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.16.18])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 14585I0Q018849;
	Wed, 5 May 2021 10:05:19 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 0/2] swupdate-config: variables cleanup
Date: Wed,  5 May 2021 10:05:16 +0200
Message-Id: <20210505080518.18186-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <bebc037e-654a-ea94-70a2-7f8502cbb17d@siemens.com>
References: <bebc037e-654a-ea94-70a2-7f8502cbb17d@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: eFpkLOzUhY5QWnLZWwq7NiNux4520388AA=
Content-Type: multipart/mixed; boundary="kqlmDSDjF3TLHfvrIi8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620201923;
 bh=EXI2wcJMtD23qIiFzInB0uzMYUZE/Twp+hiHAS1NZTQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EhDs39Qm/odI9IH/eJo9Fb1qQeM0O6CULKZdGM85bapn/Tj5lGvYO4aKHNIIMfJmqCR
 QeArJ+KgsQo9JCat8+/DdmX3FKmynOsp0XsBd88ZJCICoAUfjpK5C0axiI0Y1jhoa4A8q
 tAFUcYZvV/5TUlFJ8IFATW+ljV4lIX41yHQ=

--kqlmDSDjF3TLHfvrIi8Z
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch removes the variable U_BOOT from the swupdate-config.bbclass.
It also adds the suffix `SWUPDATE` to the variable BOOTLOADER.

If a custom u-boot is used in concunction with swupdate it is
recommened to set `U_BOOT_CONFIG_PACKAGE` to '1'. This now adds
a dependency from SWupdate to u-boot-{MACHINE}-config for installing
fw_env.config.

Quirin Gylstorff (2):
  swupdate-config: remove variable U_BOOT
  swupdate-config: add prefix to variables

 classes/swupdate-config.bbclass      | 17 ++++++++++-------
 kas/opt/ebg-secure-boot-snakeoil.yml |  2 +-
 kas/opt/ebg-swu.yml                  |  4 ++--
 kas/opt/qemu-swupdate.yml            |  2 +-
 4 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.20.1


--kqlmDSDjF3TLHfvrIi8Z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6420): https://lists.cip-project.org/g/cip-dev/message=
/6420
Mute This Topic: https://lists.cip-project.org/mt/82599403/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kqlmDSDjF3TLHfvrIi8Z--

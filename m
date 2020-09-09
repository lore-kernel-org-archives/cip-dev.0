Return-Path: <SRS0=atJt=CS=lists.cip-project.org=bounce+64572+5422+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69812C2D0E2
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E921321D43
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DMhyggaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E921321D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5422+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TaZdYY4521723xpl3CCkVUI7; Tue, 08 Sep 2020 21:44:45 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.6631.1599626681622422639
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:42 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id AB9175FCF0; Wed,  9 Sep 2020 12:44:32 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 00/11] ti-cpufreq backport
Date: Wed,  9 Sep 2020 12:42:22 +0800
Message-Id: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7xmtVkrCHkO1TqId1PwwsQQQx4520388AA=
Content-Type: multipart/mixed; boundary="pbySSQmKdMAJugja8RcB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626685;
 bh=cJPEoVAt82LyOYlmiyGDocrfFPw3uHMYwHyueF/ZNuE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DMhyggaMnZk4t1iNBhk1XG9VyovD79hJybmu44/NV/jmy3OFeW17WIaZGBR89najt/h
 2lfQcpKRkwjywaNM+Lq2JnHaWm4xjqDfA90BTCJKLDj5Ui9uJntRhIb7qb8CUyxQe04Bd
 dCvBQPY/yB4/RdUEc1gHhI7QGcHtaMULT5A=

--pbySSQmKdMAJugja8RcB
Content-Transfer-Encoding: quoted-printable

Hi everyone,

This is the final part of MOXA's PM / OPP / ti-cpufreq backport series.
Part 2, which consisted of OPP / cpufreq-dt cleanups, is abandoned in
favor of directly backporting the ti-cpufreq driver.

This part includes a couple of patches to the PM / OPP subsystem to
expose required APIs, and deal with the v1/v2 mixed OPP table used
by am33xx. The rest are the backport of the ti-cpufreq driver, and
fixes for this driver. The fixes were requested by CIP kernel
maintainers as part of MOXA's previous attempt to backport ti-cpufreq.
They are included as separate patches, as there are quite a few of them
spread over multiple kernel releases.

The result is that my BeagleBone Black can run at higher speeds than
without the ti-cpufreq driver due to having a better silicon revision.

Please have a look.

Regards
ChenYu


Christophe Jaillet (1):
  cpufreq: ti: Fix 'of_node_put' being called twice in error handling
    path

Dave Gerlach (6):
  PM / OPP: Expose _of_get_opp_desc_node as dev_pm_opp API
  Documentation: dt: add bindings for ti-cpufreq
  cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
  cpufreq: dt: Don't use generic platdev driver for ti-cpufreq platforms
  ARM: omap2plus_defconfig: Enable support for ti-cpufreq
  ARM: dts: am33xx: Add updated operating-points-v2 table for cpu

Suman Anna (1):
  cpufreq: ti-cpufreq: Fix an incorrect error return value

Viresh Kumar (1):
  PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings

Zumeng Chen (2):
  cpufreq: ti-cpufreq: kfree opp_data when failure
  cpufreq: ti-cpufreq: add missing of_node_put()

 .../bindings/cpufreq/ti-cpufreq.txt           | 128 ++++++++
 arch/arm/boot/dts/am33xx.dtsi                 |  87 +++++-
 arch/arm/configs/omap2plus_defconfig          |   1 +
 arch/arm/mach-omap2/pm.c                      |   3 +
 drivers/base/power/opp/core.c                 |  25 +-
 drivers/base/power/opp/cpu.c                  |   4 +-
 drivers/base/power/opp/opp.h                  |   6 +
 drivers/cpufreq/Kconfig.arm                   |  11 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/ti-cpufreq.c                  | 276 ++++++++++++++++++
 include/linux/pm_opp.h                        |   6 +
 11 files changed, 531 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.=
txt
 create mode 100644 drivers/cpufreq/ti-cpufreq.c

--=20
2.28.0


--pbySSQmKdMAJugja8RcB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5422): https://lists.cip-project.org/g/cip-dev/message=
/5422
Mute This Topic: https://lists.cip-project.org/mt/76726426/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--pbySSQmKdMAJugja8RcB--

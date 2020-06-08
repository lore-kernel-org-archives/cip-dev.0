Return-Path: <SRS0=7JgL=7V=lists.cip-project.org=bounce+64572+4765+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E2C433EA
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D082076C
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hp+D3AzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D082076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4765+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qDX0YY4521723xQgPUpuBxFv; Mon, 08 Jun 2020 05:01:39 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web10.26112.1591607689005941619
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 02:14:49 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 9D8365FCF6; Mon,  8 Jun 2020 17:14:43 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v2 00/15] PM / OPP v2 & cpufreq backports part 1
Date: Mon,  8 Jun 2020 17:14:17 +0800
Message-Id: <20200608091432.15366-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nO78Gy2ztj6H2CdTlxcTgaH4x4520388AA=
Content-Type: multipart/mixed; boundary="KQx95YHl8yPCBESkYQgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591617699;
 bh=Gm4YocgxQCFjXax6rbmBjkDUeQMTCb/1jyB/5RWQrs0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hp+D3AzJbIGeTUoM9kihrySWAycSps4oOqF+KhK3KIjAB5XTGx5u+Z3ppZ11dSRrhws
 aBHehfRKehXHtZaaw6Xn3TkCdEPAaavSInezGhhkuG6nw6jzZ1PzqM0FaBaq9fwH/slOB
 dVHHIUwLNhbR9tGn8UMqnxK8bxrrnZqq84c=

--KQx95YHl8yPCBESkYQgb
Content-Transfer-Encoding: quoted-printable

Hi everyone,

This is v2 of the part 1 of MOXA's PM / OPP / cpufreq backport series.
Changes since v1:

  - Added missing SoB and upstream commit hash for "PM / OPP: Set
    cpu_dev->id in cpumask first"

Original cover letter:

This is part 1 of MOXA's PM / OPP / cpufreq backport series. The whole
series aims to backport patches related to PM / OPPv2 and cpufreq
which were included in the v4.4 kernel from TI's SDK. The end goal is
to include cpufreq-ti and convert am33xx to using it and OPPv2.

Part 1 here includes patches from the v4.5 cycle, listed in topological
order:

    deaa51465105 PM / OPP: Add debugfs support
    1c4d12de2719 PM / OPP: Add "opp-supported-hw" binding
    ffdb8cc7a27c PM / OPP: Add {opp-microvolt|opp-microamp}-<name> bindin=
g
    af87a39a5f7c PM / OPP: Remove 'operating-points-names' binding
    754dcf35f346 PM / OPP: Rename OPP nodes as opp@<opp-hz>
    dc4e7b1fa20a PM / OPP: Add missing doc comments
    7de36b0aa51a PM / OPP: Parse 'opp-supported-hw' binding
    01fb4d3c39d3 PM / OPP: Parse 'opp-<prop>-<name>' bindings
    fd8d8e63467c PM / OPP: Fix parsing of opp-microvolt and opp-microamp =
properties
    d9de19b1cc01 PM / OPP: Set cpu_dev->id in cpumask first
    5ff24d601092 PM / OPP: Use snprintf() instead of sprintf()
    3be3f8f36e73 devicetree: bindings: Add optional dynamic-power-coeffic=
ient property
    f8fa8ae06b8c cpufreq-dt: Supply power coefficient when registering co=
oling devices
    929ca89c305a cpufreq-dt: fix handling regulator_get_voltage() result
    b331bc20d928 cpufreq: cpufreq-dt: avoid uninitialized variable warnin=
gs:

Of these,

    dc4e7b1fa20a PM / OPP: Add missing doc comments

was identified as a patch dependency, but otherwise serves no purpose. An=
d

    d9de19b1cc01 PM / OPP: Set cpu_dev->id in cpumask first

was found while looking through git logs. Last,

    3be3f8f36e73 devicetree: bindings: Add optional dynamic-power-coeffic=
ient property

is related to

    f8fa8ae06b8c cpufreq-dt: Supply power coefficient when registering co=
oling devices

All other patches were included from TI's SDK.

The patches apply cleanly on top of linux-4.4.y-cip. Please have a look.


Regards
ChenYu


Andrzej Hajda (1):
  cpufreq-dt: fix handling regulator_get_voltage() result

Arnd Bergmann (1):
  cpufreq: cpufreq-dt: avoid uninitialized variable warnings:

Bartlomiej Zolnierkiewicz (1):
  PM / OPP: Fix parsing of opp-microvolt and opp-microamp properties

Pi-Cheng Chen (1):
  PM / OPP: Set cpu_dev->id in cpumask first

Punit Agrawal (2):
  devicetree: bindings: Add optional dynamic-power-coefficient property
  cpufreq-dt: Supply power coefficient when registering cooling devices

Viresh Kumar (9):
  PM / OPP: Add debugfs support
  PM / OPP: Add "opp-supported-hw" binding
  PM / OPP: Add {opp-microvolt|opp-microamp}-<name> binding
  PM / OPP: Remove 'operating-points-names' binding
  PM / OPP: Rename OPP nodes as opp@<opp-hz>
  PM / OPP: Add missing doc comments
  PM / OPP: Parse 'opp-supported-hw' binding
  PM / OPP: Parse 'opp-<prop>-<name>' bindings
  PM / OPP: Use snprintf() instead of sprintf()

 .../devicetree/bindings/arm/cpus.txt          |  17 +
 Documentation/devicetree/bindings/opp/opp.txt | 132 +++++--
 drivers/base/power/opp/Makefile               |   1 +
 drivers/base/power/opp/core.c                 | 336 +++++++++++++++++-
 drivers/base/power/opp/cpu.c                  |   3 +-
 drivers/base/power/opp/debugfs.c              | 219 ++++++++++++
 drivers/base/power/opp/opp.h                  |  53 ++-
 drivers/cpufreq/cpufreq-dt.c                  |  29 +-
 include/linux/pm_opp.h                        |  22 ++
 9 files changed, 742 insertions(+), 70 deletions(-)
 create mode 100644 drivers/base/power/opp/debugfs.c

--=20
2.27.0.rc0


--KQx95YHl8yPCBESkYQgb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4765): https://lists.cip-project.org/g/cip-dev/message=
/4765
Mute This Topic: https://lists.cip-project.org/mt/74748491/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--KQx95YHl8yPCBESkYQgb--

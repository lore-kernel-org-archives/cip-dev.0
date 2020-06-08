Return-Path: <SRS0=y66e=7V=lists.cip-project.org=bounce+64572+4733+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE6DC433E0
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 09:30:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E83F206A4
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 09:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="L7Ow/0Js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E83F206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4733+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id m9jnYY4521723xiBNrAG698X; Mon, 08 Jun 2020 02:30:37 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.26368.1591608636336806405
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 02:30:36 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 51F185FCF6; Mon,  8 Jun 2020 17:30:34 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v2 00/15] PM / OPP v2 & cpufreq backports part 1
Date: Mon,  8 Jun 2020 17:30:13 +0800
Message-Id: <20200608093028.21612-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VHRXIQlZUW5jCCVXJ0IktSClx4520388AA=
Content-Type: multipart/mixed; boundary="El8cXVPw8mQ9R45h5hHp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591608637;
 bh=aYMU0zCkUHuIVRIIaYCzOhk+2EAtfpukkxP2LFDwO2U=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=L7Ow/0Jsh7LL/onRiU1MQdlF3lXIfyFlFJLsti5ai5HZxM0qYfwQ49p3EHeBjMUORh6
 eQsOprhFq/aG1wdTkhBYtKz1Rtxx+lTLID9QhW8oBMOLr/mb3mLCjLy2sqdvI3Pxt2mLF
 ye1XAkMZYBCOj0zLm85q1iYDzMZqgMdjW2s=

--El8cXVPw8mQ9R45h5hHp
Content-Transfer-Encoding: quoted-printable

(resending from correct address...)

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


--El8cXVPw8mQ9R45h5hHp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4733): https://lists.cip-project.org/g/cip-dev/message=
/4733
Mute This Topic: https://lists.cip-project.org/mt/74748491/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--El8cXVPw8mQ9R45h5hHp--

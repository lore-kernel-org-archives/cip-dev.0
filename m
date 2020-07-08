Return-Path: <SRS0=HFrZ=AT=lists.cip-project.org=bounce+64572+4890+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D918C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF58207D0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="iB1YbtYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF58207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4890+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1uurYY4521723xHdKs5Hb5Do; Wed, 08 Jul 2020 08:46:22 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.13559.1594223180864735099
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:21 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 09D4B5FC87; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 00/23] PM / OPP v2 & cpufreq backports part 2
Date: Wed,  8 Jul 2020 23:45:31 +0800
Message-Id: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2XABo2fDcGL46yOs3aB5AnLpx4520388AA=
Content-Type: multipart/mixed; boundary="T24uUPSCubB2SbJSr6NT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223182;
 bh=KG7x5Vjk8uMKelfdQIZRPXxNFiiv113doYcaVy2LVzM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=iB1YbtYoY/5HGhKhFy+f4oBYJC0nWTYiqbX5i1qsMo6r8r/VazcXuSZ33gdQBc7w35L
 uMmx90bqehqZJvyymMVyImXsZ7jz9CK1396byvAYn9qhhTZrfkRBHWx/4pgyNH7aG9L7L
 y15J7qBU2Rs7BIuEdtMhMO7hEbMFUdJaLdU=

--T24uUPSCubB2SbJSr6NT
Content-Transfer-Encoding: quoted-printable

Hi everyone,

This is part 2 of MOXA's PM / OPP / cpufreq backport series. The whole
series aims to backport patches related to PM / OPPv2 and cpufreq
which were included in the v4.4 kernel from TI's SDK. The end goal is
to include cpufreq-ti and convert am33xx to using it and OPPv2.

Part 2 here includes patches from the v4.6 cycle, as well as additional
fixed found through Fixes tags:

    9f8ea969d5cf PM / OPP: get/put regulators from OPP core
    7d34d56ef334 PM / OPP: Disable OPPs that aren't supported by the regu=
lator
    655c9df96175 PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
    2174344765f4 PM / OPP: Introduce dev_pm_opp_get_max_transition_latenc=
y()
    50f8cfbd5897 PM / OPP: Parse clock-latency and voltage-tolerance for =
v1 bindings
    d54974c2513f PM / OPP: Manage device clk
    6a0712f6f199 PM / OPP: Add dev_pm_opp_set_rate()
    896d6a4c0f41 cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg=
/err()
    457e99e60a8f cpufreq: dt: Rename 'need_update' to 'opp_v1'
    391d9aef8145 cpufreq: dt: OPP layers handles clock-latency for V1 bin=
dings as well
    050794aaebbb cpufreq: dt: Pass regulator name to the OPP core
    6def6ea75e6d cpufreq: dt: Unsupported OPPs are already disabled
    755b888ff098 cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency=
()
    78c3ba5df96c cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequen=
cy
    df2c8ec28e73 cpufreq: dt: No need to fetch voltage-tolerance
    dd02a3d92008 cpufreq: dt: No need to allocate resources anymore
    78ecc56247f0 PM / OPP: Fix NULL pointer dereference crash when disabl=
ing OPPs
    0c717d0f9cb4 PM / OPP: Initialize regulator pointer to an error value
    a5da64477ee7 PM / OPP: Fix incorrect comments
    2c2709dc6921 PM / OPP: Rename structures for clarity
    b318556479cc cpufreq: dt: Drop stale comment
    21f8a99ce61b PM / OPP: Remove useless check
    c5c2a97b3ac7 PM / OPP: Update voltage in case freq =3D=3D old_freq

Of these,

    b318556479cc cpufreq: dt: Drop stale comment

was found while looking through git logs.

    21f8a99ce61b PM / OPP: Remove useless check
    c5c2a97b3ac7 PM / OPP: Update voltage in case freq =3D=3D old_freq

were found by looking for commit hashes in Fixes tags.
All other patches were included from TI's SDK.

The patches apply cleanly on top of linux-4.4.y-cip. The last patch
involved some backporting due to path and code changes between v4.6
and v4.18.

Please have a look.


Regards
ChenYu


Jon Hunter (1):
  PM / OPP: Fix NULL pointer dereference crash when disabling OPPs

Viresh Kumar (21):
  PM / OPP: get/put regulators from OPP core
  PM / OPP: Disable OPPs that aren't supported by the regulator
  PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
  PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
  PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
  PM / OPP: Manage device clk
  PM / OPP: Add dev_pm_opp_set_rate()
  cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg/err()
  cpufreq: dt: Rename 'need_update' to 'opp_v1'
  cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
  cpufreq: dt: Pass regulator name to the OPP core
  cpufreq: dt: Unsupported OPPs are already disabled
  cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
  cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
  cpufreq: dt: No need to fetch voltage-tolerance
  cpufreq: dt: No need to allocate resources anymore
  PM / OPP: Initialize regulator pointer to an error value
  PM / OPP: Fix incorrect comments
  PM / OPP: Rename structures for clarity
  cpufreq: dt: Drop stale comment
  PM / OPP: Remove useless check

Waldemar Rymarkiewicz (1):
  PM / OPP: Update voltage in case freq =3D=3D old_freq

 drivers/base/power/opp/core.c    | 1066 +++++++++++++++++++++---------
 drivers/base/power/opp/cpu.c     |   22 +-
 drivers/base/power/opp/debugfs.c |   85 ++-
 drivers/base/power/opp/opp.h     |   74 ++-
 drivers/cpufreq/cpufreq-dt.c     |  303 +++------
 include/linux/pm_opp.h           |   27 +
 6 files changed, 973 insertions(+), 604 deletions(-)

--=20
2.27.0


--T24uUPSCubB2SbJSr6NT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4890): https://lists.cip-project.org/g/cip-dev/message=
/4890
Mute This Topic: https://lists.cip-project.org/mt/75379082/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--T24uUPSCubB2SbJSr6NT--

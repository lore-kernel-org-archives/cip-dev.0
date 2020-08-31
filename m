Return-Path: <SRS0=8esL=CJ=lists.cip-project.org=bounce+64572+5331+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0526EC433E6
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 03:42:01 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9231920738
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 03:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aWsvYK/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9231920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5331+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TGfNYY4521723xJY7T3wjfl2; Sun, 30 Aug 2020 20:41:59 -0700
X-Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
 by mx.groups.io with SMTP id smtpd.web11.46039.1598845317666687163
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Aug 2020 20:41:58 -0700
X-Received: by mail-lf1-f66.google.com with SMTP id u27so1291537lfm.13
        for <cip-dev@lists.cip-project.org>; Sun, 30 Aug 2020 20:41:57 -0700 (PDT)
X-Gm-Message-State: 8juuIOAKjcQrQuipQloltXbpx4520388AA=
X-Google-Smtp-Source: ABdhPJzbe2er/9Qu+ZqekItlOgGNfQadA4FK2Y/SZYbYialqSMNNiRbFPILYzwXL51WkxXj+BtpuTg==
X-Received: by 2002:ac2:55b4:: with SMTP id y20mr4593833lfg.103.1598845315314;
        Sun, 30 Aug 2020 20:41:55 -0700 (PDT)
X-Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id s21sm1286906ljs.8.2020.08.30.20.41.55
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 20:41:55 -0700 (PDT)
X-Received: by mail-lj1-f171.google.com with SMTP id k25so2005962ljg.9
        for <cip-dev@lists.cip-project.org>; Sun, 30 Aug 2020 20:41:55 -0700 (PDT)
X-Received: by 2002:a2e:b051:: with SMTP id d17mr4094824ljl.190.1598845314315;
 Sun, 30 Aug 2020 20:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200708154554.26450-1-wens@csie.org> <20200714173342.GA18210@amd>
In-Reply-To: <20200714173342.GA18210@amd>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Mon, 31 Aug 2020 11:41:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v67RNWMWrMtoiobSSYrw4HXOL9+_rAn6awmPAgR-82Seyw@mail.gmail.com>
Message-ID: <CAGb2v67RNWMWrMtoiobSSYrw4HXOL9+_rAn6awmPAgR-82Seyw@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/23] PM / OPP v2 & cpufreq backports part 2
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>, 
	=?UTF-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= <JohnsonCH.Chen@moxa.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="PvCYQUtUnfYUvf19VlT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598845319;
 bh=EdK9yXv7eIVJuOVoPRLhwmTzSKtGqqM587zZP6sbuCk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=aWsvYK/IWZ4UnEt24rQ88nsQbS1E6idZeID5vcRpo5WN6pgVkHcsq606bTmj9fFAz+X
 B+ij5rgIuSZMqKGr1rC1eAwM8BdxG6fs1Wn89S/CfIWe1JJ0nJDGVYZehly8eFUlSw0k5
 WRcpj+BmuGcR6sc6bH9Wddqj7Uq3bvnNFQs=

--PvCYQUtUnfYUvf19VlT8
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 15, 2020 at 1:33 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > This is part 2 of MOXA's PM / OPP / cpufreq backport series. The whole
> > series aims to backport patches related to PM / OPPv2 and cpufreq
> > which were included in the v4.4 kernel from TI's SDK. The end goal is
> > to include cpufreq-ti and convert am33xx to using it and OPPv2.
>
> Ok, I went through them, and most of them are ok.
>
> OTOH lots of them are changing common code, and I don't believe all of
> them are neccessary for am33xx support.
>
> Could you identify changes that are not neccesary for am33xx support,
> and drop those?

So I tried just backporting the ti-cpufreq driver. However as the am33xx
OPP table wasn't completely converted to the v2 format, missing the
clock-latency-ns property, it is unusable in this standalone state.

A couple of patches for PM/OPP are needed:

    0764c604c812 PM / OPP: Expose _of_get_opp_desc_node as dev_pm_opp API
    50f8cfbd5897 PM / OPP: Parse clock-latency and voltage-tolerance
for v1 bindings

I suppose this would be preferred over backporting all the OPP / PM
cleanups?

> Could the fixes be moved closer to patch they fix (ideally merged
> together)?

Sure. They are currently listed in roughly the same order as mainline.


> Best regards,
>                                                                 Pavel
>
>
> > Part 2 here includes patches from the v4.6 cycle, as well as additional
> > fixed found through Fixes tags:
> >
> >     9f8ea969d5cf PM / OPP: get/put regulators from OPP core
> >     7d34d56ef334 PM / OPP: Disable OPPs that aren't supported by the regulator
> >     655c9df96175 PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
> >     2174344765f4 PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
> >     50f8cfbd5897 PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
> >     d54974c2513f PM / OPP: Manage device clk
> >     6a0712f6f199 PM / OPP: Add dev_pm_opp_set_rate()
> >     896d6a4c0f41 cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg/err()
> >     457e99e60a8f cpufreq: dt: Rename 'need_update' to 'opp_v1'
> >     391d9aef8145 cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
> >     050794aaebbb cpufreq: dt: Pass regulator name to the OPP core
> >     6def6ea75e6d cpufreq: dt: Unsupported OPPs are already disabled
> >     755b888ff098 cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
> >     78c3ba5df96c cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
> >     df2c8ec28e73 cpufreq: dt: No need to fetch voltage-tolerance
> >     dd02a3d92008 cpufreq: dt: No need to allocate resources anymore
> >     78ecc56247f0 PM / OPP: Fix NULL pointer dereference crash when disabling OPPs
> >     0c717d0f9cb4 PM / OPP: Initialize regulator pointer to an error value
> >     a5da64477ee7 PM / OPP: Fix incorrect comments
> >     2c2709dc6921 PM / OPP: Rename structures for clarity
> >     b318556479cc cpufreq: dt: Drop stale comment
> >     21f8a99ce61b PM / OPP: Remove useless check
> >     c5c2a97b3ac7 PM / OPP: Update voltage in case freq == old_freq
> >
> > Of these,
> >
> >     b318556479cc cpufreq: dt: Drop stale comment
> >
> > was found while looking through git logs.
> >
> >     21f8a99ce61b PM / OPP: Remove useless check
> >     c5c2a97b3ac7 PM / OPP: Update voltage in case freq == old_freq
> >
> > were found by looking for commit hashes in Fixes tags.
> > All other patches were included from TI's SDK.
> >
> > The patches apply cleanly on top of linux-4.4.y-cip. The last patch
> > involved some backporting due to path and code changes between v4.6
> > and v4.18.
> >
> > Please have a look.
> >
> >
> > Regards
> > ChenYu
> >
> >
> > Jon Hunter (1):
> >   PM / OPP: Fix NULL pointer dereference crash when disabling OPPs
> >
> > Viresh Kumar (21):
> >   PM / OPP: get/put regulators from OPP core
> >   PM / OPP: Disable OPPs that aren't supported by the regulator
> >   PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
> >   PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
> >   PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
> >   PM / OPP: Manage device clk
> >   PM / OPP: Add dev_pm_opp_set_rate()
> >   cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg/err()
> >   cpufreq: dt: Rename 'need_update' to 'opp_v1'
> >   cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
> >   cpufreq: dt: Pass regulator name to the OPP core
> >   cpufreq: dt: Unsupported OPPs are already disabled
> >   cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
> >   cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
> >   cpufreq: dt: No need to fetch voltage-tolerance
> >   cpufreq: dt: No need to allocate resources anymore
> >   PM / OPP: Initialize regulator pointer to an error value
> >   PM / OPP: Fix incorrect comments
> >   PM / OPP: Rename structures for clarity
> >   cpufreq: dt: Drop stale comment
> >   PM / OPP: Remove useless check
> >
> > Waldemar Rymarkiewicz (1):
> >   PM / OPP: Update voltage in case freq == old_freq
> >
> >  drivers/base/power/opp/core.c    | 1066 +++++++++++++++++++++---------
> >  drivers/base/power/opp/cpu.c     |   22 +-
> >  drivers/base/power/opp/debugfs.c |   85 ++-
> >  drivers/base/power/opp/opp.h     |   74 ++-
> >  drivers/cpufreq/cpufreq-dt.c     |  303 +++------
> >  include/linux/pm_opp.h           |   27 +
> >  6 files changed, 973 insertions(+), 604 deletions(-)
> >
>
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> 

--PvCYQUtUnfYUvf19VlT8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5331): https://lists.cip-project.org/g/cip-dev/message=
/5331
Mute This Topic: https://lists.cip-project.org/mt/75379082/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--PvCYQUtUnfYUvf19VlT8--

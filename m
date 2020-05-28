Return-Path: <SRS0=0VVs=7K=lists.cip-project.org=bounce+64572+4652+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A67C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 28 May 2020 12:39:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD5A2074B
	for <cip-dev@archiver.kernel.org>; Thu, 28 May 2020 12:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="JqL5XZYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD5A2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4652+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5ZY3YY4521723xhJms1P08fa; Thu, 28 May 2020 05:39:41 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web11.7941.1590654535076544799
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 May 2020 01:28:55 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 126AB5FCE9; Thu, 28 May 2020 16:28:50 +0800 (CST)
Date: Thu, 28 May 2020 16:28:50 +0800
From: Chen-Yu Tsai <wens@csie.org>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, JohnsonCH.Chen@moxa.com,
	pavel@denx.de, wens@csie.org
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/3] Add TI CPUFreq/OPP hw-supported driver
Message-ID: <20200528082850.GA6672@wens.csie.org>
References: <HK2PR01MB32811FA86BAC56B8CDA4B1B7FAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <OSAPR01MB3667E8AE3A76EB13D1C03BF292AA0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <20200501093615.GC11782@amd>
MIME-Version: 1.0
In-Reply-To: <20200501093615.GC11782@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mLHqqLTGrh9gVigS3w38b0knx4520388AA=
Content-Type: multipart/mixed; boundary="XJzhOixOvfQxP7MNBUp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590669581;
 bh=GLCuC2wJsD0f8PXsXBDsCq9SbrIhbeT3KN8T0Cn6Igs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=JqL5XZYELlyf2USuAIMgSVlYaYjU+wifU2MfIxfXVe5Fbe61NG1RkkqS/azF8rBINU+
 jvdU9fe2cB2KkjxZfJz6qupl+ENDiupS0SsdbbSWrMMMOx438TM1TUjK2HhXDOVO35J0H
 wtQnK996d3MvzayWTXa/sstilCFNAQ+5+LU=

--XJzhOixOvfQxP7MNBUp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, May 01, 2020 at 11:36:15AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Tested on MOXA UC-8100A-ME that uses AM335x's SoC we have in house.
> > > 
> > > Dave Gerlach (1):
> > >   cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
> > > 
> > > Viresh Kumar (2):
> > >   PM / OPP: Add "opp-supported-hw" binding
> > >   PM / OPP: Parse 'opp-supported-hw' binding
> > 
> > Looks good to me.
> > If there is no opinion, I will apply this series.
> 
> I have made some comments. 3/3 has double-free in error path, that one
> may be worth fixing before the merge.

I will take over backporting these patches from Johnson, and other
in MOXA's kernel tree that were included from TI's SDK.

TI's SDK actually includes many more patches related to PM/OPP and
cpufreq. Most of them are already in mainline. I plan to backport
these in several steps, split by the original submission and kernel
version.

The first part will be from kernel v4.5, which includes the series
"PM / OPP: opp-supported-hw and <prop>-name bindings" [1] and later
-rc fixes in v4.5

The second part will be from kernel v4.6, which is the series
"PM / OPP: Introduce APIs to transition OPPs" [2] and -rc fixes.

The last part will be the ti-cpufreq driver and related fixes request
by Pavel, as well as conversion of am33xx dts to opp-v2.


Regards
ChenYu

[1] https://lore.kernel.org/linux-pm/cover.1447209519.git.viresh.kumar@linaro.org/
[2] https://lore.kernel.org/linux-pm/cover.1454992186.git.viresh.kumar@linaro.org/


--XJzhOixOvfQxP7MNBUp8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4652): https://lists.cip-project.org/g/cip-dev/message=
/4652
Mute This Topic: https://lists.cip-project.org/mt/73369238/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--XJzhOixOvfQxP7MNBUp8--

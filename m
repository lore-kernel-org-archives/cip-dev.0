Return-Path: <Amy_Fong@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26997C433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Jan 2022 14:43:25 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web10.8098.1641912203855067782
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jan 2022 06:43:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: amy_fong@mentor.com)
IronPort-SDR: 
 jO74Q4EfDmpfobhoI1TtFQzMjYl0SkBvO0mJA/c9inu7EgprKD4Qdwnttl2HdMv5LtVWE1+GUr
 39GTpCFa7DGJvumntypGPNvePyNSUccKuyfNYFBTUBXq53W2MHhA7Jr8QtZqrkMQ92BH8lsJaP
 AWOW9Lvo1OQt8LjrG7w5JJ+t6FFLiXXKnpXGJkV03fIwv+SiiCrKiaWRSTvcZgg4NHVTzpOwnO
 CdDI10GlEYM3OiYcBwsoLpbkgHHQ6WFKGZkT3P7ykObh0ZZ/dcHWavCcYTHNSWST8YNqWVSqoF
 ptsOcEHLdqlEXkzgQdXKtoz3
X-IronPort-AV: E=Sophos;i="5.88,279,1635235200";
   d="scan'208";a="70623644"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 11 Jan 2022 06:43:23 -0800
IronPort-SDR: 
 gBLKgYlRfmR94DBn0bRZ9wIPqZ7/f4Jg6J62cAOkQP9GN+rvQ7LAFg1POCVFx5MmKWctMc3k5q
 2Sq86v6EPPv8LoiSRlts59F0ej61Y3x0URxugTp4+OQW1EazHAmmVjUKBZi81W5Dd1SgJhJc4x
 yw/hE9TAKEm+8PXD34HE//TZeqZwVrOKww9ezbWuWUAYPDziGxgRtOE6RiFgq1/yPwwwZ6ZDjY
 wdl4rRKYH6b6jriFO06HivlVB94/WlN5Blw5F/sLaOuVQR0K59i7TUdDkGryiJJPhl4aA1pvO0
 X4U=
Date: Tue, 11 Jan 2022 09:43:18 -0500
From: Amy Fong <Amy_Fong@mentor.com>
To: Pavel Machek <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Message-ID: <Yd2XhiWzYwTbFp/c@cat>
References: <16C8EE09FDEB733D.27414@lists.cip-project.org>
 <Ydw+c4lHNdN0zAE6@cat>
 <20220110175519.GA3396@duo.ucw.cz>
 <20220110180635.GB3396@duo.ucw.cz>
 <YdyTRgrErYXoQzti@cat>
 <20220111090218.GA22781@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220111090218.GA22781@amd>
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jan 2022 14:43:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7445

On Tue, Jan 11, 2022 at 10:02:18AM +0100, Pavel Machek wrote:
> Hi!
> > > > Ok, let me take a look at the series. But... could you provide some
> > > > kind of explanation of what these are and why you want them in -cip?
> > > > 
> > > > These are not usual "hardware enablement" patches...
> > > 
> > > 0/6 email was not part of the thread, so I missed it in the first
> > > look.
> > > 
> > > I see it fixes sysbot report.
> > > 
> > > Do you have special loads where you are hitting these netfilter
> > > problems? Are similar fixes needed in 4.4 / 5.10?
> > > Would it make sense to get it fixed in -stable kernels?
> > 
> > We haven't been able to reproduce the issue but apparently it's being reproduced 
> > periodically.
> > 
> > The offending patch doesn't appear in linux-4.4.y-cip
> > linux-5.10.y-cip has the fix already.
> > 
> > Both patches were introduced in 5.5.0-rc5
> 
> Thank you for answers.
> 
> Is there reason not to submit it to stable? You are describing it is
> as a bugfix, and Greg takes those. [Advantages are a) community
> review, b) less patches to maintain for us, c) bug fixed for everyone,
> not just us].
> 
> Best regards,
> 
> 								Pavel
> -- 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

I will submit the patches to stable.

Thanks.
Amy


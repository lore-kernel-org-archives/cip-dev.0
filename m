Return-Path: <Amy_Fong@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EE5C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 20:13:02 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web10.37352.1641845581107514689
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 12:13:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: amy_fong@mentor.com)
IronPort-SDR: 
 BS9wfUhDDvwhndtvm7DztINJgrivBJpGrStWH5pYP77aaPiq2uG1ELbZ3QSCOXmFCL94SYyJeJ
 mHw7BwFDLM7D3hqsraqXX7BbNCFaYHUbbpGWz+flyGu9/UPJiFpg3lRvVeyEv2yPC22dGGoeX/
 2Gl/1MEyFD98IAD6gO6lsB4x7Bokvnq5v+Yofetn2fx95pBkvd2EAGI8m9m884Gk6fUTkRzs16
 uYzKX8aD1364KR31VSL4e9jL8ZsodektoYIXAnkOUm/AiaHNYuTEjkthn1ywHLI4a9VjT/2p1Y
 TH1mKs/k8IeAR5YtpX6x0mug
X-IronPort-AV: E=Sophos;i="5.88,278,1635235200";
   d="scan'208";a="70591856"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 10 Jan 2022 12:12:59 -0800
IronPort-SDR: 
 iMFhG79VtaOGBfzDKrvZs4p5xnLd3wdx6kgc1srmb5GTQg2IVXBbXlfr9Xkm1HA2+YvHffqb3x
 BNguSHQIhIfLSi0HsvMm1jHf+zI6APd+MM7gnGEQGOV6jaOxeiUjqEOjOfk8pCbXEe/91zrs91
 wp2B+fVSYfjj5OjVi6kao0Z4t2YqB9JqFYlUKjd6amoR03qOUVlCczu6Is7xZXUsgRdpemfRGu
 HyVhzxrGsS7l0aOGJjt0xBtknvRs2fXjRa6cpee0tz11zT4+TmvBMOATohTPN1A4ZVssSWRNX9
 6u0=
Date: Mon, 10 Jan 2022 15:12:54 -0500
From: Amy Fong <Amy_Fong@mentor.com>
To: Pavel Machek <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Message-ID: <YdyTRgrErYXoQzti@cat>
References: <16C8EE09FDEB733D.27414@lists.cip-project.org>
 <Ydw+c4lHNdN0zAE6@cat>
 <20220110175519.GA3396@duo.ucw.cz>
 <20220110180635.GB3396@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220110180635.GB3396@duo.ucw.cz>
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 20:13:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7441

On Mon, Jan 10, 2022 at 07:06:35PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Ok, let me take a look at the series. But... could you provide some
> > kind of explanation of what these are and why you want them in -cip?
> > 
> > These are not usual "hardware enablement" patches...
> 
> 0/6 email was not part of the thread, so I missed it in the first
> look.
> 
> I see it fixes sysbot report.
> 
> Do you have special loads where you are hitting these netfilter
> problems? Are similar fixes needed in 4.4 / 5.10?
> Would it make sense to get it fixed in -stable kernels?
> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

We haven't been able to reproduce the issue but apparently it's being reproduced 
periodically.

The offending patch doesn't appear in linux-4.4.y-cip
linux-5.10.y-cip has the fix already.

Both patches were introduced in 5.5.0-rc5

Thanks.
Amy


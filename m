Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC7AC2A062
	for <webhook@archiver.kernel.org>; Sun,  4 Jan 2026 23:54:06 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.81631.1767166237105169542
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Dec 2025 23:30:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=r2XMhgfi;
 spf=pass (domain: samsung.com, ip: 210.118.77.11, mailfrom: m.szyprowski@samsung.com)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251231072348euoutp019ff4461526f6a61c19ec6bf6012c740d~GO-VkiZah0809808098euoutp01y
	for <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 07:23:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251231072348euoutp019ff4461526f6a61c19ec6bf6012c740d~GO-VkiZah0809808098euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767165828;
	bh=SReBMGoIq2xPAKWQLn/ji9s22Y01CZGdJ+8XXX4vNY0=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=r2XMhgfiWKJRdW/6aemMsK1ES0xn/zyP1fTIzI02OBQcPgBldH/6X5uBb8UHsvP/P
	 YtcWtzw/o6Ew2R+2J3V4D5ABIDvwB0flerFQkBjoiK+xKD70+mXYYDhjVRRMZ1AWnz
	 jRH5wl16ZBUWYhrA46z2SpJ2CDv/8ovwlrDSi+WE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251231072347eucas1p2f8fb1e19c50fcae453fbe4ba7d89be44~GO-UfCwiP3043830438eucas1p2q;
	Wed, 31 Dec 2025 07:23:47 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251231072347eusmtip1b377f40a1e435c69839f96294845bc1f~GO-UJgQvZ1529415294eusmtip14;
	Wed, 31 Dec 2025 07:23:47 +0000 (GMT)
Message-ID: <79338dfa-5f6f-4776-a006-20cac0036ab7@samsung.com>
Date: Wed, 31 Dec 2025 08:23:45 +0100
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [cip-dev] 4.19-y-cip missing backport?
To: Yann Sionneau <yann.sionneau@vates.tech>, uli@fpond.eu,
	cip-dev@lists.cip-project.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <0d89d301-20dd-42e6-a588-c7d2c616df2c@vates.tech>
X-CMS-MailID: 20251231072347eucas1p2f8fb1e19c50fcae453fbe4ba7d89be44
X-Msg-Generator: CA
X-RootMTR: 20251228212320eucas1p162cbc8f4aa9387db360048b481b292d5
X-EPHeader: CA
X-CMS-RootMailID: 20251228212320eucas1p162cbc8f4aa9387db360048b481b292d5
References: <1151fc2f-6b21-419c-a655-7f68a6e54444@vates.tech>
	<1534957620.311452.1766834410980@webmail.strato.de>
	<CGME20251228212320eucas1p162cbc8f4aa9387db360048b481b292d5@eucas1p1.samsung.com>
	<0d89d301-20dd-42e6-a588-c7d2c616df2c@vates.tech>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Jan 2026 23:54:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21299

On 28.12.2025 22:23, Yann Sionneau wrote:
> On 12/27/25 12:20, Ulrich Hecht via lists.cip-project.org wrote:
>>> On 12/23/2025 3:19 PM CET Yann Sionneau via lists.cip-project.org <yann.sionneau=vates.tech@lists.cip-project.org> wrote:
>>> I noticed that 4.19.325 (as well as the latest -cip126 release) has this
>>> backport:
>>>
>>> commit 2b8f2afa311c722a90f00fb2960e6deb4f5100a5
>>> Author: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Date:   Thu Aug 29 07:30:28 2019 +0200
>>>
>>>        usb: dwc3: remove generic PHY calibrate() calls
>>>
>>>        [ Upstream commit a0a465569b45e3690be155c96fb54603d6904f41 ]
>>>
>>>
>>> But it does not have this:
>>>
>>> commit 34c7ed72f4f04e73901ca6ec2e1db6c040495935
>>> Author: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Date:   Thu Aug 29 07:30:27 2019 +0200
>>>
>>>        usb: core: phy: add support for PHY calibration
>>>
>>>
>>> So it seems nobody calls phy_calibrate() anymore.
>>> I must add to this report that I didn't notice any crash or debug anything.
>>> I was just skimming through the 4.19.323 ChangeLog when I noticed this.
>>>
>>> So maybe someone needs to confirm that this is a real issue, but it's
>>> suspicious at least.
>> Thank you for reporting this. I'm not quite sure what to do about it, though. The options are:
>>
>> 1. Backport "usb: core: phy: add support for PHY calibration". I like this one the least because it potentially affects all drivers, none of which have any issues ATM.
>> 2. Revert "usb: dwc3: remove generic PHY calibrate() calls". Better in terms of regression risk, but still may have unwanted side effects for dwc3.
>> 3. Do nothing. Least likely to introduce regressions but leaves the code in a known-bad state, although one that may not cause any real-life issue.
>>
>> Any opinions, anyone?
>>
>> CU
>> Uli
>>
> Hello Uli,
>
> Thanks for your answer, I think you're right about the 3 options.
> Let's pull Marek Szyprowski into this so that he can give us his opinion
> since he's the Author of those patches.
> I'm putting him in CC.

I think You can go with 3rd option. In 4.19 kernel this phy->calibrate 
call affects only one legacy Exynos based board, which I don't think is 
or will be ever used with this kernel branch. You can always apply a 
revert (2nd option) if one complains.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



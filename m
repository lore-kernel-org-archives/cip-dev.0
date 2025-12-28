Return-Path: <yann.sionneau@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4E2E784BE
	for <webhook@archiver.kernel.org>; Sun, 28 Dec 2025 21:23:37 +0000 (UTC)
Received: from mail137-23.atl71.mandrillapp.com (mail137-23.atl71.mandrillapp.com [198.2.137.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32271.1766956996439958313
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Dec 2025 13:23:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@mandrillapp.com header.s=mte1 header.b=IXVfBQPz;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=yann.sionneau@vates.tech header.s=mte1 header.b=gUqaro6I;
 spf=pass (domain: bounce.vates.tech, ip: 198.2.137.23, mailfrom: bounce-md_30504962.69519fc3.v1-abbfb222a9264c01af3e0d81fad463de@bounce.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1766956995; x=1767226995;
	bh=5dka9qTy+R9FsxAZH2qQhP6uBDmu6Y7sikAA1CV4dqM=;
	h=From:Subject:Message-Id:To:References:Cc:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=IXVfBQPzG7EQVlzbUo6GfDbEB/EgDnlcnLDIbpXX/IWy2hIxM8Jouxurh50ENh3qw
	 EFEkc976bPe0jCN9p9R4wTEO/WT3fmzC8Z8TcdTU5qlbLNDmkXYNs/cI8LFgTaRqqJ
	 CzrtQxhLOoShj7KgLEUKF0UKtu29j4ivnYoNTj4oxR4WEo06tpSkP3yDWCUb54FHK7
	 LBg197iX1alZX0J+r2XqXNK9xZW2VpA9ggpvCD1/0Iyfpp+7c62qlz25Y7A3HatNUD
	 qfSZTiKt/mmYBMggtN8wneHrbk11mZ0O9OSMpqqtRd+eIWBRmI8oyKzD72SahB4iAG
	 KqXPGWDxIijkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1766956995; x=1767217495; i=yann.sionneau@vates.tech;
	bh=5dka9qTy+R9FsxAZH2qQhP6uBDmu6Y7sikAA1CV4dqM=;
	h=From:Subject:Message-Id:To:References:Cc:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=gUqaro6IB25Rw/onrzlIByZmSrCiKAJu+k9RTHQvvp7Voo9iS5ZtUGGohmDtSCFZE
	 tNrLu/VSTLl8mEj4Wk8V58Ueop7P7gxLgUX7Ujp81ek26gwjVcaVjzWwCsl9HSyQtm
	 y2SHWWFzaWaVU+HVuxKajlzvIn7yq8DJxjzHIqi8L1pnGz0TKJp23Xafk9f4gbKjla
	 B+z2cQClmYr6tQWAgmVLSu55ddLQY3mvJzJlr7iPrA15O7XC015QJSKNAK2AknO930
	 OKmWj0qbmc81DJEtUbmIOdSpYLrgwKMF8wyL9LupUUWDVWMA2CoS80YeLoY2jMDBtn
	 +Nm32dOrH05MA==
Received: from pmta07.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
	by mail137-23.atl71.mandrillapp.com (Mailchimp) with ESMTP id 4dfXQC14hbz1XLFWJ
	for <cip-dev@lists.cip-project.org>; Sun, 28 Dec 2025 21:23:15 +0000 (GMT)
From: "Yann Sionneau" <yann.sionneau@vates.tech>
Subject: =?utf-8?Q?Re:=20[cip-dev]=204.19-y-cip=20missing=20backport=3F?=
Received: from [37.26.189.201] by mandrillapp.com id abbfb222a9264c01af3e0d81fad463de; Sun, 28 Dec 2025 21:23:15 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1766956994064
Message-Id: <0d89d301-20dd-42e6-a588-c7d2c616df2c@vates.tech>
To: uli@fpond.eu, cip-dev@lists.cip-project.org
References: <1151fc2f-6b21-419c-a655-7f68a6e54444@vates.tech> <1534957620.311452.1766834410980@webmail.strato.de>
Cc: m.szyprowski@samsung.com
In-Reply-To: <1534957620.311452.1766834410980@webmail.strato.de>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.abbfb222a9264c01af3e0d81fad463de?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20251228:md
Date: Sun, 28 Dec 2025 21:23:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 28 Dec 2025 21:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21221

On 12/27/25 12:20, Ulrich Hecht via lists.cip-project.org wrote:
> 
>> On 12/23/2025 3:19 PM CET Yann Sionneau via lists.cip-project.org <yann.sionneau=vates.tech@lists.cip-project.org> wrote:
>> I noticed that 4.19.325 (as well as the latest -cip126 release) has this
>> backport:
>>
>> commit 2b8f2afa311c722a90f00fb2960e6deb4f5100a5
>> Author: Marek Szyprowski <m.szyprowski@samsung.com>
>> Date:   Thu Aug 29 07:30:28 2019 +0200
>>
>>       usb: dwc3: remove generic PHY calibrate() calls
>>
>>       [ Upstream commit a0a465569b45e3690be155c96fb54603d6904f41 ]
>>
>>
>> But it does not have this:
>>
>> commit 34c7ed72f4f04e73901ca6ec2e1db6c040495935
>> Author: Marek Szyprowski <m.szyprowski@samsung.com>
>> Date:   Thu Aug 29 07:30:27 2019 +0200
>>
>>       usb: core: phy: add support for PHY calibration
>>
>>
>> So it seems nobody calls phy_calibrate() anymore.
>> I must add to this report that I didn't notice any crash or debug anything.
>> I was just skimming through the 4.19.323 ChangeLog when I noticed this.
>>
>> So maybe someone needs to confirm that this is a real issue, but it's
>> suspicious at least.
> 
> Thank you for reporting this. I'm not quite sure what to do about it, though. The options are:
> 
> 1. Backport "usb: core: phy: add support for PHY calibration". I like this one the least because it potentially affects all drivers, none of which have any issues ATM.
> 2. Revert "usb: dwc3: remove generic PHY calibrate() calls". Better in terms of regression risk, but still may have unwanted side effects for dwc3.
> 3. Do nothing. Least likely to introduce regressions but leaves the code in a known-bad state, although one that may not cause any real-life issue.
> 
> Any opinions, anyone?
> 
> CU
> Uli
> 

Hello Uli,

Thanks for your answer, I think you're right about the 3 options.
Let's pull Marek Szyprowski into this so that he can give us his opinion 
since he's the Author of those patches.
I'm putting him in CC.

Regards,

-- 


--
Yann Sionneau | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech




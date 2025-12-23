Return-Path: <yann.sionneau@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3CDE6F095
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 14:19:14 +0000 (UTC)
Received: from mail137-31.atl71.mandrillapp.com (mail137-31.atl71.mandrillapp.com [198.2.137.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.101428.1766499551349895200
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Dec 2025 06:19:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mandrillapp.com header.s=mte1 header.b=UC3vqtrj;
 dkim=pass header.i=yann.sionneau@vates.tech header.s=mte1 header.b=r5sX3RPu;
 spf=pass (domain: bounce.vates.tech, ip: 198.2.137.31, mailfrom: bounce-md_30504962.694aa4de.v1-8a669c3eb91542948224283b9e331459@bounce.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1766499550; x=1766769550;
	bh=gte4myE3X8Vv8Eidl0aJQhp1pLbTj+X6sJfdJAAuhsk=;
	h=From:Subject:Message-Id:To:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=UC3vqtrjBr10ad1POZAtP8lvsfXDxGDEEb/EKGnZG5fzOfIYtJySVg2z6OhduwyCa
	 f2Fm44bwi7/L4ejuu2VUbk5vEU6LyD9RAPeELbDLWQtY0dQhvkGkYu7BTQ0Rad9UBz
	 T+CBLBH7G6xpa3KN0vVuSXexvb3Qv4WKarnq7lBf7P0w8RFF0huJUgHc/lc5KUzBjw
	 wyjjo5q84SO7P2gh4meGXWR7/R0bJWbjioy65n9MB9t2jq7mFrk9VzjHsE2zokSLzm
	 pO0B+rTjQw5pRxHDZxE3phAOBSbDqgGCJBh1gi66UlArmm/4UolXhENJhDsCvyvs2/
	 QN7M41e7lYWJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1766499550; x=1766760050; i=yann.sionneau@vates.tech;
	bh=gte4myE3X8Vv8Eidl0aJQhp1pLbTj+X6sJfdJAAuhsk=;
	h=From:Subject:Message-Id:To:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=r5sX3RPufiMXFeOq2FU3dyVjKjYA3EB91vu8JjEp054vEfciKBSoJCup86GE/NKxa
	 F1bCNF7QmfukoBpEU20I2zHnMQiE/4fYXuA6oDTwHNolOFGEpi6743f036FRini96m
	 A2P50zgkCyayMJJqMo+Mfm5hdfsKVB3cYEFWiHnlBfLbDQmPYlTbmu7SDTAhK7qNkG
	 QcRlkTQDmOKHUi684AUxMNA+AbnJbB4AdK/xIw1WtDjdgxDoIXu1JHd9YWO338K2QM
	 JZTzIxD8OxnyTuvTkXiV+nqp8JNXVeGL4DSjJoFyk7hLqycF9k+46xl42pJkYfX9Tx
	 TiupLKjC+5Nsg==
Received: from pmta07.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
	by mail137-31.atl71.mandrillapp.com (Mailchimp) with ESMTP id 4dbHFB1h2Qz7lmDHT
	for <cip-dev@lists.cip-project.org>; Tue, 23 Dec 2025 14:19:10 +0000 (GMT)
From: "Yann Sionneau" <yann.sionneau@vates.tech>
Subject: =?utf-8?Q?4.19-y-cip=20missing=20backport=3F?=
Received: from [37.26.189.201] by mandrillapp.com id 8a669c3eb91542948224283b9e331459; Tue, 23 Dec 2025 14:19:10 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1766499549377
Message-Id: <1151fc2f-6b21-419c-a655-7f68a6e54444@vates.tech>
To: cip-dev@lists.cip-project.org
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.8a669c3eb91542948224283b9e331459?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20251223:md
Date: Tue, 23 Dec 2025 14:19:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Dec 2025 14:19:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21211

Hello CIP people,

I noticed that 4.19.325 (as well as the latest -cip126 release) has this 
backport:

commit 2b8f2afa311c722a90f00fb2960e6deb4f5100a5
Author: Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu Aug 29 07:30:28 2019 +0200

     usb: dwc3: remove generic PHY calibrate() calls

     [ Upstream commit a0a465569b45e3690be155c96fb54603d6904f41 ]


But it does not have this:

commit 34c7ed72f4f04e73901ca6ec2e1db6c040495935
Author: Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu Aug 29 07:30:27 2019 +0200

     usb: core: phy: add support for PHY calibration


So it seems nobody calls phy_calibrate() anymore.
I must add to this report that I didn't notice any crash or debug anything.
I was just skimming through the 4.19.323 ChangeLog when I noticed this.

So maybe someone needs to confirm that this is a real issue, but it's 
suspicious at least.

Enjoy end-of-year breaks if you have those!

Regards,

-- 


--
Yann Sionneau | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech





Return-Path: <SRS0=OQwu=D5=lists.cip-project.org=bounce+64572+5655+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40860C4363A
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 17:27:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD8D24641
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 17:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jvtgog+E"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5655+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2I92YY4521723xAFZphlqAG5; Thu, 22 Oct 2020 10:27:00 -0700
X-Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
 by mx.groups.io with SMTP id smtpd.web10.134.1603387618988743632
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 10:26:59 -0700
X-Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
	by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1kVeMT-0005zK-U2; Thu, 22 Oct 2020 18:26:49 +0100
Message-ID: <fd3abdebef90cfa62fb03acc0057274737e886cc.camel@codethink.co.uk>
Subject: Re: [cip-dev] Direct Pushes for cip-kernel-sec
From: "Ben Hutchings" <ben.hutchings@codethink.co.uk>
To: Chen-Yu Tsai <wens@csie.org>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, SZ Lin
 =?UTF-8?Q?=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= <sz.lin@moxa.com>
Date: Thu, 22 Oct 2020 18:26:48 +0100
In-Reply-To: <CAGb2v65SBE5GnV4o-6y-PMz-on2Mav6iDVeuJ3KRVYgx76a__w@mail.gmail.com>
References: 
	<CAGb2v65SBE5GnV4o-6y-PMz-on2Mav6iDVeuJ3KRVYgx76a__w@mail.gmail.com>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nlDMM03AsRLcaKyW55FAbpfcx4520388AA=
Content-Type: multipart/mixed; boundary="ia4pq5XRLW96LDkK3NSV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603387620;
 bh=jrihCgcdbd2qXPSA0eRor/AE5U6ogeGNkDAmxlZmStA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jvtgog+EVMcVvnsp8yLfD6RoH9MwwNnn7Je26Ga5heArzpoFjD/4Mks29cvwrykkU73
 wT+ummE+mMRtMuYzZaCtylCjz0FYLfZRdppDQdyWO8Uag31vHRfTJNheuc361u2SAhoY4
 tu8BtonBhSyH1iXsiSbI6MHoDed2niAvHoo=

--ia4pq5XRLW96LDkK3NSV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-10-22 at 18:00 +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> After today's CIP weekly meeting, Pavel proposed the idea of skipping
> merge requests for the cip-kernel-sec repository:
[...]
> Ben, could you share your thoughts on this?

I was going to suggest you do that, for other reasons.  I didn't
realise you weren't able to do so.  It looks you have been granted that
permission now, is that right?

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


--ia4pq5XRLW96LDkK3NSV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5655): https://lists.cip-project.org/g/cip-dev/message=
/5655
Mute This Topic: https://lists.cip-project.org/mt/77727077/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ia4pq5XRLW96LDkK3NSV--

Return-Path: <SRS0=rRfF=EC=lists.cip-project.org=bounce+64572+5675+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FE1C64EBC
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 15:27:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B96822284
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 15:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="XSkkKXAw"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5675+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id o95RYY4521723xxBGwmfomyd; Tue, 27 Oct 2020 08:27:17 -0700
X-Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
 by mx.groups.io with SMTP id smtpd.web11.405.1603812436474907882
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2020 08:27:16 -0700
X-Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
	by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1kXQsQ-0003Ek-Bo; Tue, 27 Oct 2020 15:27:10 +0000
Message-ID: <dc74ef6c272614274b44c9f1ab4b3d613f42ddeb.camel@codethink.co.uk>
Subject: Re: [cip-dev] Direct Pushes for cip-kernel-sec
From: "Ben Hutchings" <ben.hutchings@codethink.co.uk>
To: Chen-Yu Tsai <wens@csie.org>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, SZ Lin
 =?UTF-8?Q?=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= <sz.lin@moxa.com>
Date: Tue, 27 Oct 2020 15:27:09 +0000
In-Reply-To: <CAGb2v66mLYZGYxf-b+LYfA9DRaYB597UGNVKyXiec=jorcDHuw@mail.gmail.com>
References: 
	<CAGb2v65SBE5GnV4o-6y-PMz-on2Mav6iDVeuJ3KRVYgx76a__w@mail.gmail.com>
	 <fd3abdebef90cfa62fb03acc0057274737e886cc.camel@codethink.co.uk>
	 <CAGb2v66mLYZGYxf-b+LYfA9DRaYB597UGNVKyXiec=jorcDHuw@mail.gmail.com>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RQbU3t9ScA6Pcj0yXWRyo0nEx4520388AA=
Content-Type: multipart/mixed; boundary="q1Av6Hq2VfEiaxvyIQIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603812437;
 bh=bsrJnQZBQ59zYbK8vardVjJNlSw1QX6C6h2FZcJGBCI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XSkkKXAwqh6gGSTzQyjCWsd2es3O4+3TOkUAeJ7jzeZNfQ906XZrIHaJgEGsw1eUrDG
 IrG3q1ykQpsfHYXr+QZEIF3XzxnaSYAd9BDkGY0UCAaikUPxx3PKiAsCxXLXH26atTvzO
 M+LDMGN8zjtcgVLNl9AHLykeR3Kdn6bZn7U=

--q1Av6Hq2VfEiaxvyIQIE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-10-27 at 14:49 +0800, Chen-Yu Tsai wrote:
> On Fri, Oct 23, 2020 at 1:27 AM Ben Hutchings
> <ben.hutchings@codethink.co.uk> wrote:
> > On Thu, 2020-10-22 at 18:00 +0800, Chen-Yu Tsai wrote:
> > > Hi,
> > > 
> > > After today's CIP weekly meeting, Pavel proposed the idea of skipping
> > > merge requests for the cip-kernel-sec repository:
> > [...]
> > > Ben, could you share your thoughts on this?
> > 
> > I was going to suggest you do that, for other reasons.  I didn't
> > realise you weren't able to do so.  It looks you have been granted that
> > permission now, is that right?
> 
> Yes. So in the future I'll push all script-imported updates directly.
> Would you still like to review manual data input, or should I push those
> directly as well?

Please push them directly.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


--q1Av6Hq2VfEiaxvyIQIE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5675): https://lists.cip-project.org/g/cip-dev/message=
/5675
Mute This Topic: https://lists.cip-project.org/mt/77727077/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--q1Av6Hq2VfEiaxvyIQIE--

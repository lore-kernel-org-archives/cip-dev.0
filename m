Return-Path: <SRS0=A7JG=G7=lists.cip-project.org=bounce+64572+6147+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF54C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 28 Jan 2021 09:11:01 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7428864DDF
	for <cip-dev@archiver.kernel.org>; Thu, 28 Jan 2021 09:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7428864DDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6147+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BdFUYY4521723xioMudyWGds; Thu, 28 Jan 2021 01:10:59 -0800
X-Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.21863.1611825056703572247
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Jan 2021 01:10:57 -0800
X-Received: by mail-lf1-f54.google.com with SMTP id q8so6611630lfm.10
        for <cip-dev@lists.cip-project.org>; Thu, 28 Jan 2021 01:10:56 -0800 (PST)
X-Gm-Message-State: g12xF5MEfyM0FozeGFqJHf3Ux4520388AA=
X-Google-Smtp-Source: ABdhPJwL30QOLnX0xchEkqPe0gyadol3fffk4m8S7aTBfhR983KeT8LAXvL1FWq4RKsuxm+HWgvVxw==
X-Received: by 2002:a19:f203:: with SMTP id q3mr6897021lfh.166.1611825052885;
        Thu, 28 Jan 2021 01:10:52 -0800 (PST)
X-Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d17sm1745979ljg.125.2021.01.28.01.10.52
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 01:10:52 -0800 (PST)
X-Received: by mail-lj1-f182.google.com with SMTP id y11so5454335ljk.1
        for <cip-dev@lists.cip-project.org>; Thu, 28 Jan 2021 01:10:52 -0800 (PST)
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr8359632ljk.74.1611825052546;
 Thu, 28 Jan 2021 01:10:52 -0800 (PST)
MIME-Version: 1.0
References: <CAGb2v67U62fBOE-OxbfGkOa-SJhmiJQQCXDvJ3bd44sWhsoTig@mail.gmail.com>
 <CAGb2v65bFWTC_c0TAdL2GExpB48b_GcFXeM4PCte0NZb2U38Vw@mail.gmail.com>
In-Reply-To: <CAGb2v65bFWTC_c0TAdL2GExpB48b_GcFXeM4PCte0NZb2U38Vw@mail.gmail.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 28 Jan 2021 17:10:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v64K9CiGYaqwfErbyra_b7cVT6jjRpXJCdZGG20GLcm5Pw@mail.gmail.com>
Message-ID: <CAGb2v64K9CiGYaqwfErbyra_b7cVT6jjRpXJCdZGG20GLcm5Pw@mail.gmail.com>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-28
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="ReRxarz4P6ZubdLD7rDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611825059;
 bh=9vVRHwpTDdYFmiG4O28ku5U5Ld4w13NcFKgaSGtPjHU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DbaWFdcic1ZqRjQcYTPJ5PMeP4R2REy1J+lIh3+0X8YXaewQZgMkuzwt3Vj272x+GYo
 Apgspur1R9A46DCkKA32j5Qd3W7syvguH38fyRlU0IWud9hZP+NdbU/4PFR5XIefXM8Ql
 V1pdow5WJnymmrROoiRiTfEjGRCAm+ouE4I=

--ReRxarz4P6ZubdLD7rDm
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 28, 2021 at 10:47 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> (Resent from correct email address)
>
> Hi everyone,
>
> One new issue this week:
> - CVE-2020-35513 [nfsd: incorrect umask] - fixed in all branches
>
> In addition, the fix for CVE-2021-3178 was backported to all stable kernels.
> The security concerns for this issue are being disputed though.
>
> Also, information for CVE-2020-27066 still hasn't been disclosed, and
> the affected commit is still unclear.
>
> Last, for CVE-2020-27825 the Fixes tag was incorrect; it is actually a
> Depends-On [1].
> The issue is known to affect at least in 4.14, 4.19 and 5.4. A sample
> backport for 4.4+ [2]
> was posted, but a proper backport is still pending [3].

Looks like there's an update:
https://lore.kernel.org/stable/20210125142126.70d6a33c@gandalf.local.home/

I will update the tracker.


ChenYu


> Regards
> ChenYu
> Moxa
>
> [1] https://lore.kernel.org/linux-arm-msm/20200915141304.41fa7c30@gandalf.local.home/
> [2] https://lore.kernel.org/stable/021b1b38-47ce-bc8b-3867-99160cc85523@linux.com/
> [3] https://lore.kernel.org/stable/YA1GU+xjL+zUDIjN@kroah.com/
>   * All from the same mail thread

--ReRxarz4P6ZubdLD7rDm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6147): https://lists.cip-project.org/g/cip-dev/message=
/6147
Mute This Topic: https://lists.cip-project.org/mt/80176441/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ReRxarz4P6ZubdLD7rDm--

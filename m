Return-Path: <SRS0=VkBu=A3=lists.cip-project.org=bounce+64572+4930+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2B4C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 16 Jul 2020 06:11:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D73620578
	for <cip-dev@archiver.kernel.org>; Thu, 16 Jul 2020 06:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IPhgUJdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D73620578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4930+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aCI2YY4521723xsibbwfbCjy; Wed, 15 Jul 2020 23:11:42 -0700
X-Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.9814.1594879901142028182
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2020 23:11:41 -0700
X-Received: by mail-lj1-f170.google.com with SMTP id x9so5804172ljc.5
        for <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2020 23:11:40 -0700 (PDT)
X-Gm-Message-State: 9ccXWtR1Dr9rwYRhguoN8qabx4520388AA=
X-Google-Smtp-Source: ABdhPJwdnis9qa/SK6K6Rg/1+N8opVpGCoJZ9FLcXqCGRPKOBGx9eT+Jn1E7axPnprr5ERUu8XjfLQ==
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr1166676ljq.1.1594879898679;
        Wed, 15 Jul 2020 23:11:38 -0700 (PDT)
X-Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m14sm1157415lfp.18.2020.07.15.23.11.38
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 23:11:38 -0700 (PDT)
X-Received: by mail-lj1-f178.google.com with SMTP id e4so5816470ljn.4
        for <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2020 23:11:38 -0700 (PDT)
X-Received: by 2002:a2e:958f:: with SMTP id w15mr1148571ljh.190.1594879898217;
 Wed, 15 Jul 2020 23:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <TY2PR01MB497247C1E04F817F6E364E73A07F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB497247C1E04F817F6E364E73A07F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 16 Jul 2020 14:11:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v65652De21w-sut7wEqL38CP6ugxkKKLV0t9G-yJH5mmWg@mail.gmail.com>
Message-ID: <CAGb2v65652De21w-sut7wEqL38CP6ugxkKKLV0t9G-yJH5mmWg@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="fWoql5gqLlY5RpR9EhsO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594879902;
 bh=E8Ooddekgz8XQaS/ONo0wC/QiCJ1iW1lj95CQNrKG2I=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=IPhgUJdFbkQW7DnSunmhdYieI+ljFi4qNjA/7J0V+eulO5r3WQSENpv5eZl0gPpW0Bx
 RFAHcprStWSYhZAYPZ1RJhobtYsN2M/qvr/OvCuQwzd6l0hQScm0me1/eIZnXfBe9Ky+p
 cTDIDzbQlJQyxe3EPUhInbO+OL7n4tniWVk=

--fWoql5gqLlY5RpR9EhsO
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Jul 16, 2020 at 9:30 AM masashi.kudo@cybertrust.co.jp
<masashi.kudo@cybertrust.co.jp> wrote:
>
> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss technical topics with CIP kernel today.
>
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starting from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2020&month=7&day=16&hour=9&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
>
> USWest  USEast  UK      DE      TW      JP
> 02:00   05:00   10:00   11:00   17:00   18:00
>
> Channel:
> * irc:chat.freenode.net:6667/cip
>
> Last meeting minutes:
> https://irclogs.baserock.org/meetings/cip/2020/07/cip.2020-07-09-09.00.log.html
>
> Agenda:
>
> * Action item
>   1. Combine root filesystem with kselftest binary - iwamatsu
>   2. Post LTP results to KernelCI - patersonc
>   3. Issues to be fixed for swupdate "copyright correction and salsa CI testing" - iwamatsu
>
> * Kernel maintenance updates

I might not make it, so here are updates from me for this week:

Two new issues:

  - CVE-2020-11935 (aufs, not applicable to mainline)
  - CVE-2020-14314 (ext4 related, fix posted)


Regards
ChenYu

> * Kernel testing
> * Software update
> * CIP Security
> * AOB
>
> The meeting will take 30 min, although it can be extended to an hour if it makes sense and those involved in the topics can stay. Otherwise, the topic will be taken offline or in the next meeting.
>
> Best regards,
> --
> M. Kudo
> Cybertrust Japan Co., Ltd.
> 

--fWoql5gqLlY5RpR9EhsO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4930): https://lists.cip-project.org/g/cip-dev/message=
/4930
Mute This Topic: https://lists.cip-project.org/mt/75533779/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fWoql5gqLlY5RpR9EhsO--

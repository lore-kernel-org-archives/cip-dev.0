Return-Path: <SRS0=e/WX=HU=lists.cip-project.org=bounce+64572+6181+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372ABC433DB
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 08:46:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CBE64E5F
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 08:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CBE64E5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6181+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YoiQYY4521723xd6ciCjT0AE; Thu, 18 Feb 2021 00:46:31 -0800
X-Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web09.4242.1613637990422964080
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Feb 2021 00:46:30 -0800
X-Received: by mail-lj1-f171.google.com with SMTP id t4so2926732ljh.11
        for <cip-dev@lists.cip-project.org>; Thu, 18 Feb 2021 00:46:30 -0800 (PST)
X-Gm-Message-State: Ga5PKt105TUyApxwRFe3y6gbx4520388AA=
X-Google-Smtp-Source: ABdhPJyLoC0FNVQyDQFFXwAh3uxQPvJ96RKLaOChPO7w9JHlSs0U0PDzU8ss8kywHQ7OHsQNvFsKEg==
X-Received: by 2002:a2e:8993:: with SMTP id c19mr2050099lji.213.1613637987988;
        Thu, 18 Feb 2021 00:46:27 -0800 (PST)
X-Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id z11sm530094lfd.98.2021.02.18.00.46.27
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 00:46:27 -0800 (PST)
X-Received: by mail-lj1-f182.google.com with SMTP id y7so854358lji.7
        for <cip-dev@lists.cip-project.org>; Thu, 18 Feb 2021 00:46:27 -0800 (PST)
X-Received: by 2002:a2e:9e42:: with SMTP id g2mr2085551ljk.94.1613637987578;
 Thu, 18 Feb 2021 00:46:27 -0800 (PST)
MIME-Version: 1.0
References: <TY2PR01MB49721F716203EDF622E53CD9A0859@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB49721F716203EDF622E53CD9A0859@TY2PR01MB4972.jpnprd01.prod.outlook.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 18 Feb 2021 16:46:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v64MhytthB=Zit_QP_5tPuUbmoMb_mVa8F+NmwcmKy4RmQ@mail.gmail.com>
Message-ID: <CAGb2v64MhytthB=Zit_QP_5tPuUbmoMb_mVa8F+NmwcmKy4RmQ@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="0lPavoLnxf1iNCq9apPj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613637991;
 bh=WiKqe/dFGDLvC/PbOUuthSiUR5KObKw4QWx2PS0SAw4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=KUgvwhHACjWMSRCe41Kn0fpt01/3P8cfQoryrDeP5POWy/djSKDNK7W2A9/TSOMB+3a
 NRlpJWBIY116KPxPc4RKlHoTt7BPIfMPBMeBWRLLfxcPlsaeA7f8yC3H/F10K4OIVcm1I
 AoATkW+UQaiDaC5UYDHVmUlfBgINZ60TLJU=

--0lPavoLnxf1iNCq9apPj
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 18, 2021 at 8:09 AM masashi.kudo@cybertrust.co.jp
<masashi.kudo@cybertrust.co.jp> wrote:
>
> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss technical topics with CIP kernel today.
>
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starting from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=2&day=18&hour=9&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
>
> USWest  USEast  UK      DE      TW      JP
> 01:00   04:00   9:00    10:00   17:00   18:00
>
> Channel:
> * irc:chat.freenode.net:6667/cip
>
> Last meeting minutes:
> https://irclogs.baserock.org/meetings/cip/2021/02/cip.2021-02-11-09.00.log.html
>
> * Action item
>   1. Combine root filesystem with kselftest binary - iwamatsu
>   2. Do some experiment to lower burdens on CI - patersonc
>   3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - Hitachi-team
>   4. Track the CVE-2021-3347 patch status - Kernel Team

FTR, fixes have now been incorporated into 4.4.

ChenYu

--0lPavoLnxf1iNCq9apPj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6181): https://lists.cip-project.org/g/cip-dev/message=
/6181
Mute This Topic: https://lists.cip-project.org/mt/80718652/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0lPavoLnxf1iNCq9apPj--

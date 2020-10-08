Return-Path: <SRS0=lHIP=DP=lists.cip-project.org=bounce+64572+5513+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9164FC433E7
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 08:19:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CCC21531
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 08:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BVRjwAKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CCC21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5513+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nGChYY4521723xqwSHWjTslq; Thu, 08 Oct 2020 01:19:43 -0700
X-Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web12.7306.1602145182418336557
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2020 01:19:42 -0700
X-Received: by mail-lj1-f178.google.com with SMTP id f21so4786228ljh.7
        for <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2020 01:19:42 -0700 (PDT)
X-Gm-Message-State: Nw4og3yi9TXArLd6chFZkIbKx4520388AA=
X-Google-Smtp-Source: ABdhPJw5aLdjZlsWwMAwYySrSUnIBlRpOiTk2UctnDo91eoY1Bu2JYOvnEkaVb7WkoSKU+aukP4JbA==
X-Received: by 2002:a2e:8903:: with SMTP id d3mr2853899lji.270.1602145180360;
        Thu, 08 Oct 2020 01:19:40 -0700 (PDT)
X-Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i139sm742761lfi.276.2020.10.08.01.19.40
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 01:19:40 -0700 (PDT)
X-Received: by mail-lf1-f45.google.com with SMTP id w11so5502293lfn.2
        for <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2020 01:19:40 -0700 (PDT)
X-Received: by 2002:ac2:4c10:: with SMTP id t16mr41823lfq.193.1602145179813;
 Thu, 08 Oct 2020 01:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <OSBPR01MB4967B53707E24AB20B083FA0A00B0@OSBPR01MB4967.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4967B53707E24AB20B083FA0A00B0@OSBPR01MB4967.jpnprd01.prod.outlook.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 8 Oct 2020 16:19:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v67OZmFYa3w4sUyNfw4mRceQMOnvoudT0Gx5W79nDS+0LQ@mail.gmail.com>
Message-ID: <CAGb2v67OZmFYa3w4sUyNfw4mRceQMOnvoudT0Gx5W79nDS+0LQ@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="0uSjjepthiGAg6agEi96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602145183;
 bh=/ymYqFGw160eIWWAdpD0Mb3hr5JmIb2I/hWSEbwfp64=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BVRjwAKp/9rSldMOAcxOXViyek4bsDafn+EuZYe/tkqpSAxoREeW9fpliIBboYDZE6K
 wLvJjvq9M6UAdTVrv4NqvOPMeik7Qxu/uZrkees41CBDuKUZ8QYRUpEe4g78n8zEwV40P
 4tpU0dJBV6SsinCYGUhQhJ9DvqcHY/1ZdWA=

--0uSjjepthiGAg6agEi96
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 8, 2020 at 8:57 AM masashi.kudo@cybertrust.co.jp
<masashi.kudo@cybertrust.co.jp> wrote:
>
> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss technical topics with CIP kernel today.
>
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starting from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2020&month=10&day=8&hour=9&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
>
> USWest  USEast  UK      DE      TW      JP
> 02:00   05:00   10:00   11:00   17:00   18:00
>
> Channel:
> * irc:chat.freenode.net:6667/cip
>
> Last meeting minutes:
> https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-01-09.00.log.html
>
> Agenda:
>
> * Action item
>   1. Combine root filesystem with kselftest binary - iwamatsu
>   2. Check whether CVE-2020-25284 needs to be backported to 4.4-rt
>       ->  Delete rbd ( Ceph block device ) from 4.4-rt x86 config - iwamatsu
>       ->  Done, so will be closed today.
>
> * Kernel maintenance updates

I might not make it. Here's this week's update:

Five new CVEs:
- CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 [net/i40e] - Fixed for
mainline and 4.19+
  - This is enabled in Siemens x86 configs for both 4.4 and 4.19
    and we should probably backport them.
- CVE-2020-25643 [hdlc_ppp] - Fixed in all current stable kernels
- CVE-2020-26541 [UEFI secure boot] - Fix posted but hasn't landed

I also reviewed some patches from Daniel for cip-kernel-sec on the mailing list.

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
>
> 
>

--0uSjjepthiGAg6agEi96
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5513): https://lists.cip-project.org/g/cip-dev/message=
/5513
Mute This Topic: https://lists.cip-project.org/mt/77375242/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0uSjjepthiGAg6agEi96--

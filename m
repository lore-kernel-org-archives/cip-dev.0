Return-Path: <SRS0=PIru=43=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E9C10F27
	for <cip-dev@archiver.kernel.org>; Tue, 10 Mar 2020 16:57:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43235222C3
	for <cip-dev@archiver.kernel.org>; Tue, 10 Mar 2020 16:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43235222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 185CC886BE;
	Tue, 10 Mar 2020 16:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cPuGBK553cax; Tue, 10 Mar 2020 16:57:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2840A886BC;
	Tue, 10 Mar 2020 16:57:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB6FC0177;
	Tue, 10 Mar 2020 16:57:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5311BC0177
 for <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2020 16:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 41CD9875BB
 for <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2020 16:57:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y2l-Ojd6u_G0 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2020 16:57:44 +0000 (UTC)
X-Greylist: delayed 00:07:08 by SQLgrey-1.7.6
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1F47E861AA
 for <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2020 16:57:44 +0000 (UTC)
IronPort-SDR: H2OpH44A7xWrDbmwhc/LEkh02U8GeyFTv9bjauw6EMX9iwY8q1Q9SBjnsgvjTYM9xY7CNK2xsd
 3RspKiVLMGcLfsny5Mcagp0jne5VPiwtlHdK6Plt1hWTvb0AycWckFQu0h4Ylny+a+jQfcXfTR
 AJBwj7kzUNR+7fvwIzM5kvuWcUCFM1l8r7LgsXkJxNYVNNrgl6lmCJsM85dm13TELrwlkNUyPn
 k5DlAEy/5WHZAe59I0JbgBeDtDD5AODwsYPZRPdOcPRhjv5elXLcvdqAwzqBqlSOkabF7tZV9A
 Vhw=
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; d="scan'208";a="46520720"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 10 Mar 2020 08:50:35 -0800
IronPort-SDR: XQMIBoZhdjfxdwemF2JqV47TSnkwLt7WIAbztLJT8AcQbZvCuBj6PSnfIxDplxTKyt+NdE1jcm
 k6o8UDOPyscLokYTA9LnCDDUIDgPjqFfhSFawgHnBYIinyeLu0msScXinNHpxcFNUfj1GvKhz+
 RGegCq2Mr8J+DIZcKq530vp++EC0sF6qpDtR68YC3rbfJ3VlqJbf4t2KNcxh7lSKUkXt7xGgKV
 oAgliaOnDm5YpG3pYE8Vnfp1uJjqaspyZ+O+fFNLji8/G2afdwyBdGTwMdWTEymeBEdUhABlmF
 QYQ=
From: "Bhola, Bikram" <Bikram_Bhola@mentor.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@denx.de>, "Quirin
 Gylstorff" <quirin.gylstorff@siemens.com>
Thread-Topic: I need de0-nano testing for -rt release was Re: [cip-dev]
 4.19.106-cip21-rt8 problems on de0-nano
Thread-Index: AQHV9kP24swRbJhFDEOoDhesdkjwTahBz/4A
Date: Tue, 10 Mar 2020 16:50:30 +0000
Message-ID: <a91890283bd0414ea3f282106c142e75@SVR-IES-MBX-03.mgc.mentorg.com>
References: <20200303091556.GA10040@duo.ucw.cz>
 <20200303092343.GA11594@duo.ucw.cz> <20200303171049.GB24044@duo.ucw.cz>
 <20200303212826.GA16402@duo.ucw.cz>
 <fe189e62-baee-4f6a-cc19-295c4c023dc7@siemens.com>
 <20200309102132.GB18031@duo.ucw.cz>
 <c3f20059-7663-b216-a799-14cb943669ea@siemens.com>
In-Reply-To: <c3f20059-7663-b216-a799-14cb943669ea@siemens.com>
Accept-Language: en-US, en-IE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
MIME-Version: 1.0
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] I need de0-nano testing for -rt release was Re:
 4.19.106-cip21-rt8 problems on de0-nano
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi Jan and All,,

We are working on it. 

Looks like we have a slow network in last few days in our lab that results in rootfs download timeout failure. Time being we need to increase the current timeout from 15 mins to 30 mins for safer side (its failing in between 90% completion). Meantime I am working with our network team to diagnose the slowness. 

Thank You!!

Regards,
Bikram 

-----Original Message-----
From: Jan Kiszka [mailto:jan.kiszka@siemens.com] 
Sent: 10 March 2020 00:23
To: Pavel Machek <pavel@denx.de>; Bhola, Bikram <Bikram_Bhola@mentor.com>; Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: cip-dev@lists.cip-project.org
Subject: Re: I need de0-nano testing for -rt release was Re: [cip-dev] 4.19.106-cip21-rt8 problems on de0-nano

On 09.03.20 11:21, Pavel Machek wrote:
> Hi!
> 
>>>>>> I pushed candidate for -cip-rt, but it seems to fail on de0-nano 
>>>>>> board. Code under testing is at:
>>>>>>
>>>>>> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel
>>>>>> /linux-cip
>>>>>
>>>>> It is pipeline
>>>>>
>>>>> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/1227
>>>>> 62401
>>>>>
>>>>> I'll reuse the branch for more testing.
>>>>
>>>> I managed to narrow the bad commit to the -rt tree, between:
>>>>
>>>> OK 122904930 pick 69aa73357e6a rcu: Don't allow to change 
>>>> rcu_normal_after_boot on RT pick 849ef8789077 pci/switchtec: fix 
>>>> stream_open.cocci warnings pick ad8a5e8279c4 sched/core: Drop a 
>>>> preempt_disable_rt() statement pick 966f066d96cb timers: Redo the 
>>>> notification of canceling timers on -RT pick 0393fd5a4f9a Revert "futex: Ensure lock/unlock symetry versus pi_lock and hash bucket lock"
>>>> pick 84eb0b64a27a Revert "futex: Fix bug on when a requeued RT task times out"
>>>> pick fcc893280f4e Revert "rtmutex: Handle the various new futex race conditions"
>>>> pick 2eac93cf9d16 Revert "futex: workaround migrate_disable/enable in different context"
>>>> pick 9b8964629f4f futex: Make the futex_hash_bucket lock raw pick 
>>>> cc1812bf198b futex: Delay deallocation of pi_state
>>>>> pick f5e115c43100 mm/zswap: Do not disable preemption in 
>>>>> zswap_frontswap_store()
>>>> pick e0d0d09a08ad revert-aio
>>>> pick a0a40bfb4300 fs/aio: simple simple work pick 0fae581d8c5e 
>>>> revert-thermal pick c0d95b4a8a1b thermal: Defer thermal wakups to 
>>>> threads pick 700fbb4afb6e revert-block pick 4cda50ff12cf block: 
>>>> blk-mq: move blk_queue_usage_counter_release() into process context 
>>>> pick 9e982f55745b workqueue: rework pick c0db53dc3bf4 i2c: exynos5: 
>>>> Remove IRQF_ONESHOT pick 1f160d170203 i2c: hix5hd2: Remove 
>>>> IRQF_ONESHOT BAD 122882826 eae5a7cab722 sched/deadline: Ensure 
>>>> inactive_timer runs in hardirq context
>>>>
>>>
>>> And something went seriously wrong after these tests. I submitted 
>>> same tree twice, and got different results.
>>>
>>> First this -- de0-nano succeeds:
>>>
>>> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/122904
>>> 930
>>>
>>> Now this -- de0-nano fails (and ipc227e is unfinished for long time):
>>>
>>> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/122959
>>> 477
>>>
>>> I'll need some help here.
>>
>> The logs read like the targets are not (always) coming up, e.g.
>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/457824214#
>> L377
> 
> Yes... I don't need that target, but I need de0-nano... and it did not 
> work last time I checked.

Bikram, could someone on your side check the board status in the Mentor lab? Thanks!

> 
> On a related note... it would be good to somehow show difference 
> between "kernel test failure" and "target failure".
> 
> If we see bootloader in the logs, and then test fails/timeouts => 
> "kernel test failure", I need to solve it.
> 
> If we don't get messages from the bootloader => "target failure", 
> someone needs to check the power relays or something...

I'm not happy about the parsability of those LAVA logs either, but I have no idea if/how that can be improved best. Maybe Quirin has some idea based on his work with them.

Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Center Embedded Linux
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

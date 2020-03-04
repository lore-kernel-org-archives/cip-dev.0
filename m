Return-Path: <SRS0=WbXS=4V=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB96C3F2CE
	for <cip-dev@archiver.kernel.org>; Wed,  4 Mar 2020 19:54:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394CE21739
	for <cip-dev@archiver.kernel.org>; Wed,  4 Mar 2020 19:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394CE21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F185383664;
	Wed,  4 Mar 2020 19:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0-MgTBZQGk0s; Wed,  4 Mar 2020 19:53:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58E1383617;
	Wed,  4 Mar 2020 19:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 360B8C013E;
	Wed,  4 Mar 2020 19:53:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5115AC013E
 for <cip-dev@lists.cip-project.org>; Wed,  4 Mar 2020 19:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 33310204A8
 for <cip-dev@lists.cip-project.org>; Wed,  4 Mar 2020 19:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A9tRwhcDT8BD for <cip-dev@lists.cip-project.org>;
 Wed,  4 Mar 2020 19:53:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by silver.osuosl.org (Postfix) with ESMTPS id 9715A2047C
 for <cip-dev@lists.cip-project.org>; Wed,  4 Mar 2020 19:53:56 +0000 (UTC)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 024JrrUk013093
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 20:53:53 +0100
Received: from [167.87.36.242] ([167.87.36.242])
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 024Jrr7S013237;
 Wed, 4 Mar 2020 20:53:53 +0100
To: Pavel Machek <pavel@denx.de>
References: <20200303091556.GA10040@duo.ucw.cz>
 <20200303092343.GA11594@duo.ucw.cz> <20200303171049.GB24044@duo.ucw.cz>
 <20200303212826.GA16402@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fe189e62-baee-4f6a-cc19-295c4c023dc7@siemens.com>
Date: Wed, 4 Mar 2020 20:53:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303212826.GA16402@duo.ucw.cz>
Content-Language: en-US
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] 4.19.106-cip21-rt8 problems on de0-nano
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

On 03.03.20 22:28, Pavel Machek wrote:
> Hi!
> 
>>>> I pushed candidate for -cip-rt, but it seems to fail on de0-nano
>>>> board. Code under testing is at:
>>>>
>>>> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-cip
>>>
>>> It is pipeline
>>>
>>> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/122762401
>>>
>>> I'll reuse the branch for more testing.
>>
>> I managed to narrow the bad commit to the -rt tree, between:
>>
>> OK 122904930 pick 69aa73357e6a rcu: Don't allow to change rcu_normal_after_boot on RT
>> pick 849ef8789077 pci/switchtec: fix stream_open.cocci warnings
>> pick ad8a5e8279c4 sched/core: Drop a preempt_disable_rt() statement
>> pick 966f066d96cb timers: Redo the notification of canceling timers on -RT
>> pick 0393fd5a4f9a Revert "futex: Ensure lock/unlock symetry versus pi_lock and hash bucket lock"
>> pick 84eb0b64a27a Revert "futex: Fix bug on when a requeued RT task times out"
>> pick fcc893280f4e Revert "rtmutex: Handle the various new futex race conditions"
>> pick 2eac93cf9d16 Revert "futex: workaround migrate_disable/enable in different context"
>> pick 9b8964629f4f futex: Make the futex_hash_bucket lock raw
>> pick cc1812bf198b futex: Delay deallocation of pi_state
>>> pick f5e115c43100 mm/zswap: Do not disable preemption in zswap_frontswap_store()
>> pick e0d0d09a08ad revert-aio
>> pick a0a40bfb4300 fs/aio: simple simple work
>> pick 0fae581d8c5e revert-thermal
>> pick c0d95b4a8a1b thermal: Defer thermal wakups to threads
>> pick 700fbb4afb6e revert-block
>> pick 4cda50ff12cf block: blk-mq: move blk_queue_usage_counter_release() into process context
>> pick 9e982f55745b workqueue: rework
>> pick c0db53dc3bf4 i2c: exynos5: Remove IRQF_ONESHOT
>> pick 1f160d170203 i2c: hix5hd2: Remove IRQF_ONESHOT
>> BAD 122882826 eae5a7cab722 sched/deadline: Ensure inactive_timer runs in hardirq context
>>
> 
> And something went seriously wrong after these tests. I submitted same
> tree twice, and got different results.
> 
> First this -- de0-nano succeeds:
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/122904930
> 
> Now this -- de0-nano fails (and ipc227e is unfinished for long time):
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/122959477
> 
> I'll need some help here.
> 

The logs read like the targets are not (always) coming up, e.g.
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/457824214#L377

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

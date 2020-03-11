Return-Path: <Bikram_Bhola@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3D10C0177
 for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2020 15:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E0E30876FD
 for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2020 15:44:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P-aXvd77aqYW for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2020 15:44:02 +0000 (UTC)
X-Greylist: delayed 00:07:06 by SQLgrey-1.7.6
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C1D19876DB
 for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2020 15:44:02 +0000 (UTC)
IronPort-SDR: z/tk2sNhjAu2SiYQk9J2vyxwYu5ZeQXqnOwcjJQXK4on54OKYD41x6hVOYF1rSQm3jhS+1GuUp
 bwezHWovnvXTMnb9+EIVnIyvTTtygejJC29nSjVIt6m7B+dBU4CC45/VtGBjSei/eYvMa65IIv
 NWpfrXa1xt8TEKkA6kj6lE2FLLeWrHecWzfsv4m51nklxELXkNHcH9bgwVmlGLqvtDIZF6fQpL
 hGtZOyXVwKTpgQ9pGmlLZwm0qn10pSLShZbyWkq0MrGhA25vDW2k3f0Bl1tIHizmaM+PLV2cTl
 A2M=
X-URL-LookUp-ScanningError: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; d="scan'208";a="48578644"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 11 Mar 2020 07:36:55 -0800
IronPort-SDR: nV8fQEMZZwSBeL+2nFd7Snn6Mss4amJFQ+DFGI4PjkeeeH9Ibw4cpd/j+eekwBYggKPqzjPUsl
 edqssqZINhvpYQ4aXPtVs7+9NFOVWuq1wXB3Vy+iIFQX5XDVXwPB2eNCX6S5G+o6B8tihsl53Z
 4eFao8LpLTNA6TQXn9Hxac1BaIa3E1fCXbOrFLY6Ipy4YeN+B3EZr4wMDk3saCnpENhWutw36D
 iGZblh6wtmBIv3GWTw/R5hRQrKKenAYhfxlSqyXnTiGTB4girau9Sdql1wFdcBtu7k50GcC7n7
 9qE=
From: "Bhola, Bikram" <Bikram_Bhola@mentor.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@denx.de>, "Quirin
 Gylstorff" <quirin.gylstorff@siemens.com>
Thread-Topic: I need de0-nano testing for -rt release was Re: [cip-dev]
 4.19.106-cip21-rt8 problems on de0-nano
Thread-Index: AQHV9kP24swRbJhFDEOoDhesdkjwTahBz/4AgAG354A=
Date: Wed, 11 Mar 2020 15:36:50 +0000
Message-ID: <a9aa2dd7e7fd43eca840d7825e835ffc@SVR-IES-MBX-04.mgc.mentorg.com>
References: <20200303091556.GA10040@duo.ucw.cz>
 <20200303092343.GA11594@duo.ucw.cz> <20200303171049.GB24044@duo.ucw.cz>
 <20200303212826.GA16402@duo.ucw.cz>
 <fe189e62-baee-4f6a-cc19-295c4c023dc7@siemens.com>
 <20200309102132.GB18031@duo.ucw.cz>
 <c3f20059-7663-b216-a799-14cb943669ea@siemens.com>
 <78fd4f1df8034021ae195b8287cf2f29@SVR-IES-MBX-03.mgc.mentorg.com>
In-Reply-To: <78fd4f1df8034021ae195b8287cf2f29@SVR-IES-MBX-03.mgc.mentorg.com>
Accept-Language: en-US, en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
MIME-Version: 1.0
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: I need de0-nano testing for -rt release was Re: 4.19.106-cip21-rt8 problems on de0-nano
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
X-List-Received-Date: Wed, 11 Mar 2020 15:44:04 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jan and All,

Both de0-nano and IPC227E targets are up and running. I have monitored for =
test jobs on it and those completed successfully.=20

Thank You!!

Regards,
Bikram=20
-----Original Message-----
From: Bhola, Bikram=20
Sent: 10 March 2020 22:20
To: 'Jan Kiszka' <jan.kiszka@siemens.com>; Pavel Machek <pavel@denx.de>; Qu=
irin Gylstorff <quirin.gylstorff@siemens.com>
Cc: cip-dev@lists.cip-project.org
Subject: RE: I need de0-nano testing for -rt release was Re: [cip-dev] 4.19=
.106-cip21-rt8 problems on de0-nano

Hi Jan and All,,

We are working on it.=20

Looks like we have a slow network in last few days in our lab that results =
in rootfs download timeout failure. Time being we need to increase the curr=
ent timeout from 15 mins to 30 mins for safer side (its failing in between =
90% completion). Meantime I am working with our network team to diagnose th=
e slowness.=20

Thank You!!

Regards,
Bikram=20

-----Original Message-----
From: Jan Kiszka [mailto:jan.kiszka@siemens.com]
Sent: 10 March 2020 00:23
To: Pavel Machek <pavel@denx.de>; Bhola, Bikram <Bikram_Bhola@mentor.com>; =
Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: cip-dev@lists.cip-project.org
Subject: Re: I need de0-nano testing for -rt release was Re: [cip-dev] 4.19=
.106-cip21-rt8 problems on de0-nano

On 09.03.20 11:21, Pavel Machek wrote:
> Hi!
>=20
>>>>>> I pushed candidate for -cip-rt, but it seems to fail on de0-nano=20
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
>>>> OK 122904930 pick 69aa73357e6a rcu: Don't allow to change=20
>>>> rcu_normal_after_boot on RT pick 849ef8789077 pci/switchtec: fix=20
>>>> stream_open.cocci warnings pick ad8a5e8279c4 sched/core: Drop a
>>>> preempt_disable_rt() statement pick 966f066d96cb timers: Redo the=20
>>>> notification of canceling timers on -RT pick 0393fd5a4f9a Revert "fute=
x: Ensure lock/unlock symetry versus pi_lock and hash bucket lock"
>>>> pick 84eb0b64a27a Revert "futex: Fix bug on when a requeued RT task ti=
mes out"
>>>> pick fcc893280f4e Revert "rtmutex: Handle the various new futex race c=
onditions"
>>>> pick 2eac93cf9d16 Revert "futex: workaround migrate_disable/enable in =
different context"
>>>> pick 9b8964629f4f futex: Make the futex_hash_bucket lock raw pick=20
>>>> cc1812bf198b futex: Delay deallocation of pi_state
>>>>> pick f5e115c43100 mm/zswap: Do not disable preemption in
>>>>> zswap_frontswap_store()
>>>> pick e0d0d09a08ad revert-aio
>>>> pick a0a40bfb4300 fs/aio: simple simple work pick 0fae581d8c5e=20
>>>> revert-thermal pick c0d95b4a8a1b thermal: Defer thermal wakups to=20
>>>> threads pick 700fbb4afb6e revert-block pick 4cda50ff12cf block:
>>>> blk-mq: move blk_queue_usage_counter_release() into process context=20
>>>> pick 9e982f55745b workqueue: rework pick c0db53dc3bf4 i2c: exynos5:
>>>> Remove IRQF_ONESHOT pick 1f160d170203 i2c: hix5hd2: Remove=20
>>>> IRQF_ONESHOT BAD 122882826 eae5a7cab722 sched/deadline: Ensure=20
>>>> inactive_timer runs in hardirq context
>>>>
>>>
>>> And something went seriously wrong after these tests. I submitted=20
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
>=20
> Yes... I don't need that target, but I need de0-nano... and it did not=20
> work last time I checked.

Bikram, could someone on your side check the board status in the Mentor lab=
? Thanks!

>=20
> On a related note... it would be good to somehow show difference=20
> between "kernel test failure" and "target failure".
>=20
> If we see bootloader in the logs, and then test fails/timeouts =3D>=20
> "kernel test failure", I need to solve it.
>=20
> If we don't get messages from the bootloader =3D> "target failure",=20
> someone needs to check the power relays or something...

I'm not happy about the parsability of those LAVA logs either, but I have n=
o idea if/how that can be improved best. Maybe Quirin has some idea based o=
n his work with them.

Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Ce=
nter Embedded Linux



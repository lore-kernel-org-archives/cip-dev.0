From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Mon, 8 Jan 2018 12:45:16 +0100
Subject: [cip-dev] [ANNOUNCE] Linux 4.4.15-cip15-rt10
In-Reply-To: <20180108105621.osnfazlumesxkwv3@linutronix.de>
References: <b4cf2728-0d0c-5128-d007-818e66da5613@siemens.com>
	<20180108093350.lxjocaxlvrmjwpav@linutronix.de>
	<94212c58-73c7-7356-b325-9e7f18c9bfbc@siemens.com>
	<20180108105621.osnfazlumesxkwv3@linutronix.de>
Message-ID: <84996d9c-54e1-b90b-fd06-948cabf447ef@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 01/08/2018 11:56 AM, Sebastian Andrzej Siewior wrote:
>>>>     kernel/utilities/compiletest-runner at 2/build/../include/linux/compiler.h:484 call to ?__compiletime_assert_150? declared with attribute error: BUILD_BUG_ON failed: hw_flag_names[NUM_IEEE80211_HW_FLAGS] != (void *)0x1
>>>>
>>>> Not sure how to handle those. IIRC, we don't support allmodconfig.
>>>
>>> yes but adding
>>>   68920c973254 ("net/mac80211/debugfs.c: prevent build failure with
>>>   CONFIG_UBSAN=y")
>>>
>>> could solve the issue.
>>
>> Okay, I just don't know if Ben wants to add the patch to his tree though.
> 
> If the patch solves the issue then please forward the patch upstream.
> The "normal" v4.4 stable tree is affected by this, too.

Ah, I misunderstood you first. I'll picked the patch and let it run
through the ci system now and forward it to Greg if it solved the issue.

Thanks,
Daniel

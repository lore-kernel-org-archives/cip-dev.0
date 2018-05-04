From: wagi@monom.org (Daniel Wagner)
Date: Fri, 4 May 2018 13:29:41 +0200
Subject: [cip-dev] iWave RZ/G1M hrtimers
In-Reply-To: <OSBPR01MB2103BDA152FACACF7085F50EB8860@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <288bed25-0560-69a2-7239-d25387f9ab64@monom.org>
	<45738fc6-fe53-8309-77ab-be6204fdc68c@monom.org>
	<OSBPR01MB2103BDA152FACACF7085F50EB8860@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <5c279f28-7dfa-5b47-9d12-f4a566901ac8@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Biju,

On 05/04/2018 01:22 PM, Biju Das wrote:
> We just  backported CMT timers to CIP kernel. We will be sending this patches soon.

Excellent!

> With this , I get below output.  Is it the output are you looking for?
> 
> root at skrzg1m:~# cat /proc/timer_list
> Timer List Version: v0.8
> HRTIMER_MAX_CLOCK_BASES: 4
> now at 16058914800 nsecs
> 
> cpu: 0
>   clock 0:
>    .base:       dfbc7c00
>    .index:      0
>    .resolution: 1 nsecs
>    .get_time:   ktime_get
>    .offset:     0 nsecs

Yes, that looks much better.

Thanks,
Daniel

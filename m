From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 2 Oct 2019 10:35:01 +0200
Subject: [cip-dev] Testing results for 4.19-cip-rt
In-Reply-To: <TYAPR01MB22851D795B68DB436855A441B79C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <20191002082238.GA9041@amd>
	<43099417-d106-47cc-e784-4a5f25c4aa31@siemens.com>
	<TYAPR01MB22851D795B68DB436855A441B79C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <21c270b8-2de0-aa4f-d9f6-867e9f6465db@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 02.10.19 10:34, Chris Paterson wrote:
> Hello Jan,
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 02 October 2019 09:30
>>
>> On 02.10.19 10:22, Pavel Machek wrote:
>>> Hi!
>>>
>>> I pushed -cip-rt version to kernel.org, which got me automatic test on
>>> gitlab:
>>>
>>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/309275693
>>>
>>> ...compile okay, but run_tests failed; unfortunately I don't quite
>>> understand what went wrong with the test. Can someone help?
>>>
>>
>> Job #4665: Finished
>>     Device Type: r8a774a1-hihope-rzg2m-ex
>>     Device: r8a774a1-hihope-rzg2m-ex-01
>>     Test: healthcheck
>>
>> Chris can probably explain.
>>
>> I see only the Renesas lab used here, right? Are we missing something for the
>> IPC227E and de0-nano-soc to be used as well?
> 
> Correct. I was waiting on Kernel configurations in order to start testing the boards in the Mentor lab.
> These have now been submitted[0] to the cip-kernel-config repository, so hopefully we'll get tests up and running soon.
> 
> [0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/merge_requests/11
> 

Ah, cool!

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

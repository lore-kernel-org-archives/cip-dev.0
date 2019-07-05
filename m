From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 5 Jul 2019 10:44:29 +0200
Subject: [cip-dev] [ANNOUNCE] v4.19.50-cip3-rt1
In-Reply-To: <20190704182042.GA4117@amd>
References: <20190623203704.GA12734@amd> <20190628125904.GA24508@amd>
	<d3b02a62-7931-17aa-ea81-e7a3554346ee@siemens.com>
	<20190704182042.GA4117@amd>
Message-ID: <152a8f06-2876-0d38-9c99-ba5ddec592da@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 04.07.19 20:20, Pavel Machek wrote:
> Hi!
> 
>>> 4.19.50-cip3-rt1 should be available at kernel.org. I did limited
>>> testing, but it seems to have some bugs fixed relative to
>>> 4.19.13-cip1-rt1. (Boots on x86-32 and cyclictest on iwg20m does not
>>> hit WARN_ON).
>>>
>>> Trees are available at
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt-rebase
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt
>>>
>>> And their content should be identical.
>>>
>>
>> Shouldn't this be 4.19.50-cip3-rt2? It's the second -rt release for 4.19-cip.
> 
> Its first realtime release based on 4.19.50-cip3 :-). It is also based
> on 4.19.50-rt22. So yes, the naming is a bit confusing.
> 
> If such version would previously be named -rt2, I'll obviously need to
> fix it.

Please keep the old naming scheme and increment the -rt number when releasing a 
new rt kernel.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

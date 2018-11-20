From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 20 Nov 2018 13:03:52 +0100
Subject: [cip-dev] CIP-dev IRC weekly meeting log: week 46
In-Reply-To: <CAGDrK-ZwTxeqPCZ89x571UUXHJ+nuNXOwe+wK4+ePf_J0hmyhA@mail.gmail.com>
References: <HK0PR01MB297977BFF65F27987171DBEAE2D80@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
	<8644c672-422a-5089-bc1e-b90f7e78c0bc@siemens.com>
	<CAGDrK-ZwTxeqPCZ89x571UUXHJ+nuNXOwe+wK4+ePf_J0hmyhA@mail.gmail.com>
Message-ID: <25c0605c-0016-7958-d2ee-c0c01f398405@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Nobuhiro,

On 19.11.18 23:17, Nobuhiro Iwamatsu wrote:
> Hi,
> 
> 2018?11?19?(?) 17:53 Jan Kiszka <jan.kiszka@siemens.com>:
>>
>> On 19.11.18 09:14, SZ Lin (???) wrote:
>>> Hi,
>>>
>>> Please find the logs of CIP meeting last week in below link:
>>>
>>> https://irclogs.baserock.org/cip/%23cip.2018-11-15.log.html#t2018-11-15T09:00:17
>>>
>>> #action Confirm the next official CIP kernel announcement in TSC meeting.
>>> #action Make sure armhf is available in Debian 10 (or not)
>>> https://release.debian.org/buster/arch_qualify.html
>>
>> Huh?! Can we support them with hardware to avoid that?
> 
> We can see the current hardware problem of armel / armhf from the following.
> 
> https://lists.debian.org/debian-arm/2018/09/msg00049.html
> 

Hmm, that message does not yet read to me like a blocker. It's a list of 
complications, yes.

I also wonder what makes this buster-specific. The issues with the build 
environment should be generic, shared with supported arm* for stretch or even older.

Again, if there is any concrete thing we could help with here, please let us 
discuss proposals at TSC level and with Debian folks. armhf is critical for most 
of us, and that for quite a few years onward.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

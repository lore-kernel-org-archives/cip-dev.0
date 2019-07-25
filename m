From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 25 Jul 2019 11:06:42 +0200
Subject: [cip-dev] [ANNOUNCE] v4.4.185-cip35-rt24
In-Reply-To: <06bacec2-fc43-f208-45e7-07d02791d162@monom.org>
References: <20190723124015.GA13044@amd> <20190723211219.GB23154@amd>
	<06bacec2-fc43-f208-45e7-07d02791d162@monom.org>
Message-ID: <157e1ecf-20eb-7fd0-2441-5eb91490cec9@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 25.07.19 10:50, Daniel Wagner wrote:
> Hi,
> 
> On 7/23/19 11:12 PM, Pavel Machek wrote:
>> v4.4.185-cip35-rt24 should be available at kernel.org.
>>
>> Daniel says:
>> # in the v4.4-rt is still a problem with f01f17d3705b ("mm,
>> # vmstat: make quiet_vmstat lighter"). It is needed to boot on x86_64
>> # but it breaks on NVIDIA's boards, e.g. Jetson. Unfortunately, I don't
>> # have a NVIDIA board in my lab to figure out what is missing. So I
>> # suspect there is a still a problem hidden in the current v4.4-rt tree.
>>
>> I did nothing to solve that problem. If someone uses NVIDIA boards,
>> let me know.
> 
> I still try to get hands on a NVIDIA board. They are not terrible expensive but
> I still don't want to buy it myself :)
> 
> So if someone is willing to lend me a board, I can't try to reproduce it.

Which one do you need? I have a TK1 in reach, Ralf should have a TX1 with the
potential of remote access.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

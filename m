From: ralf.ramsauer@oth-regensburg.de (Ralf Ramsauer)
Date: Thu, 25 Jul 2019 13:42:04 +0200
Subject: [cip-dev] [ANNOUNCE] v4.4.185-cip35-rt24
In-Reply-To: <24afcb80-66d6-c745-057d-5459c1eda78c@monom.org>
References: <20190723124015.GA13044@amd> <20190723211219.GB23154@amd>
	<06bacec2-fc43-f208-45e7-07d02791d162@monom.org>
	<157e1ecf-20eb-7fd0-2441-5eb91490cec9@siemens.com>
	<24afcb80-66d6-c745-057d-5459c1eda78c@monom.org>
Message-ID: <0091cf11-fbd0-2926-1937-dbe8626c9d1d@oth-regensburg.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 7/25/19 11:12 AM, Daniel Wagner wrote:
> Hi Jan,
> 
> On 7/25/19 11:06 AM, Jan Kiszka wrote:
>>> So if someone is willing to lend me a board, I can't try to reproduce
>>> it.
>>
>> Which one do you need? I have a TK1 in reach, Ralf should have a TX1
>> with the
>> potential of remote access.

Yep, he does.

> 
> It should be reproducable on a TK1:
> 
> https://lore.kernel.org/stable/f32de22f-c928-2eaa-ee3f-d2b26c184dd4 at nvidia.com/
> 
> 
> So if I could get hands on one of those, it would really help.

You can either get your hands dirty on your own, or you simply give me a
.config together with a commit hash and a short description what I
should test. The latter is probably the easier choice, if the test isn't
that complex.

> 
> Remote access is also good, if the uplink from the board is reasonable
> fast. I finally got a fast uplink (400MBit/s) :)

Come on, 400Mbit/s... But it should be fast enough to tease our 1GBit/s
DFN network ;-)

  Ralf

> 
> Thanks,
> Daniel

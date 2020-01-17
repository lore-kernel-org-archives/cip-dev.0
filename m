From: punit1.agrawal@toshiba.co.jp (Punit Agrawal)
Date: Fri, 17 Jan 2020 10:01:36 +0900
Subject: [cip-dev] RT Testing
In-Reply-To: <TYAPR01MB22851DD503672EF581BBBD7AB7360@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 (Chris Paterson's message of "Thu, 16 Jan 2020 09:57:08 +0000")
References: <TYAPR01MB2285FB4BDC74EB669E362E89B7340@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <TYXPR01MB18081C565B8B2F072CC2C9E5E1360@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <TYAPR01MB22851DD503672EF581BBBD7AB7360@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <87lfq6hp5b.fsf@kokedama.swc.toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chris,

Just thinking out loud below so please bear with me if I'm just stating
the obvious.

Chris Paterson <Chris.Paterson2@renesas.com> writes:

> Hello,
>
>> From: kazuhiro3.hayashi at toshiba.co.jp <kazuhiro3.hayashi@toshiba.co.jp>
>> Sent: 16 January 2020 06:55
>> 
>> Hello Chris,
>> 
>> Thank you for your updates!
>> 
>> > Hello Pavel, Hayashi-san, Jan, Daniel,
>> >
>> [...]
>> >
>> > Currently there is an issue with the way that the cyclic test case results are
>> shown (i.e. they aren't) in LAVA due to
>> > a change [0] made to Linaro's cyclictest.sh.
>> > That means that the test parsing now depends on Python, which isn't included
>> in the cip-core RFS [1] that is currently
>> > being used.
>> >
>> > Do either of the CIP Core profiles include Python support?
>> 
>> At the moment, we've just started creating the supported package list, so I
>> cannot clearly say Yes.
>> However, at least, the both profiles can create an image including python only
>> for testing
>> because the python packages are already provided in upstream projects (isar,
>> meta-debian).
>
> Okay. I'm thinking that we aren't going to be able to escape having a
> separate 'testing' version of CIP-Core, based on ISAR on the
> assumption that it has more supported packages then Deby.
>
> Or not use CIP-Core for testing the Kernel as punit suggested ??

I think CIP-core shouldn't be thought of as a complete filesystem, but
the base components that should exist as part of any CIP system.

As it is, it's unlikely that any real product will need only the
functionality provided by CIP core.

If that makes sense, then we should make it easy to create derived
images / filesystems that include additional software as needed for the
task at hand, e.g., testing CIP kernels.

In addition, there is a need to test the functionality provided by the
core components, i.e., CIP-core packages along with relevant kernels on
supported devices. As yet, I don't think these tests exist (or even
defined).

But I'm new to the project so am very likely missing things.

Thanks,
Punit

[...]

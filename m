From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 16 Sep 2016 07:03:48 +0200
Subject: [cip-dev] Introduction
In-Reply-To: <1473978694.23987.41.camel@codethink.co.uk>
References: <1473851440.4719.37.camel@codethink.co.uk>
	<005e01d20f1d$64afb270$2e0f1750$@toshiba.co.jp>
	<57DA5C43.5010001@codethink.co.uk>
	<2db652238ec32fb02f30541a75454292@codethink.co.uk>
	<1473978694.23987.41.camel@codethink.co.uk>
Message-ID: <a2d29f67-3aab-20d9-6cba-162c0dcc7fb5@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

my name is Jan Kiszka. I'm working for Siemens Corporate Technology on
enabling and enhancing open source components for the use in our
embedded products, and that primarily at lower levels like the kernel.

On 2016-09-16 00:31, Ben Hutchings wrote:
> On Thu, 2016-09-15 at 17:17 +0100, Paul Sherwood wrote:
> [...]
>   [Greg K-H wrote:]
>> "But if we didn't provide an LTS, would companies constantly update 
>> their kernels to newer releases to keep up with the security and 
>> bugfixes? That goes against everything those managers/PMs have ever been 
>> used to in the past, yet it's actually the best thing they could do."
> 
> Linux does have a very good record of maintaining application binary
> compatibility, which should make it safe to upgrade.  But every new
> release from Linus brings some or all of the following problems:
> 
> - feature regressions
> - performance regressions
> - security regressions
> - increased resource consumption
> - removal of deprecated features
> - driver API churn
> 
> Most of the regressions get fixed quickly, but some linger long after
> support for the previous stable branch has ended.
> 
> So I don't think it's generally sensible to use the latest stable update
> in production, and that's why I care about longterm branches (and I
> don't know why Greg does).

Exactly.

> 
>> I've been recommending the constant update route route to customers 
>> over the last few years, with some success, but many ecosystem members 
>> are extremely uncomfortable with the whole idea of aligning with 
>> mainline.  I think this is broadly because as embedded engineers we've 
>> learned over many years that it's best to change the platform as little 
>> as possible.  I wrote an article trying to challenge this traditional 
>> embedded thinking earlier this year [3]
>>
>> Would be very interested in others' thoughts on this.
> 
> I agree it's possible to do rolling upgrades, but it's very dependent on
> the capability and the will (1) to do regular regression testing on the
> target systems and (2) to address the regressions that are found without
> waiting for them to be fixed upstream.  Where a performance regression
> or increased resource consumption stretches an existing system so that
> it no longer meets its requirements, this might not be practically
> possible.  This also applies where non-upstream code is broken by
> upstream API changes, and that issue is not going away soon.

And while we are investing in extending long-term support with our SLTS
versions, we have to improve regression testing as well to ensure the
quality of those releases. But nothing prevents to use the results also
for latest upstream versions. That can also contribute to making rolling
updates more realistic in the future, I we should point this out
whenever folks complain that SLTS would be against the upstream trend.

Jan

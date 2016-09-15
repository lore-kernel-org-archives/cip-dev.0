From: paul.sherwood@codethink.co.uk (Paul Sherwood)
Date: Thu, 15 Sep 2016 17:17:38 +0100
Subject: [cip-dev] Introduction
In-Reply-To: <57DA5C43.5010001@codethink.co.uk>
References: <1473851440.4719.37.camel@codethink.co.uk>
	<005e01d20f1d$64afb270$2e0f1750$@toshiba.co.jp>
	<57DA5C43.5010001@codethink.co.uk>
Message-ID: <2db652238ec32fb02f30541a75454292@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2016-09-15 09:30, Agustin Benito Bethencourt wrote:
>>> I'm now adding another part-time role as lead kernel maintainer for 
>>> the
>>> CIP.  I look forward to working with you all to establish a project 
>>> and
>>> process that can extend the support lifetime even further.
>>>
>>> Ben.
>>
>> Welcome to the CIP project. It's great to have such an experienced 
>> maintainer
>> in the project. Looking forward to working with you too!
>
> Daniel, can you tell us a little about yourself?
>
> My name is Agust?n Benito Bethencourt. I represent Codethink at CIP.
> I've managed teams-programs-projects for some years ago, the last in
> the open.
>
> I am looking forward to find out how we are going to deal with this
> outstanding challenge, keeping a Linux system alive and healthy for
> many years in mission critical environments. I think it is an 
> exciting
> one.

To introduce myself, I'm CEO at Codethink, but to the best of my 
ability I'll be commenting here from a personal perspective, independent 
of Codethink's official involvement in CIP.

To start the ball rolling, I'm personally worried about how we are 
actually going to achieve super-long-term-support and am happy that we 
can discuss the issues in public.

Greg K-H, Ben Hutchings and others have contributed a huge amount to 
Long Term Stable and followon initiatives in the community over the 
years. But when I first started exploring how things like LTS and LTSI 
can work for embedded and automotive in 2012/2013, I hit some 
fundamental questions, not least - how in practice can a complex 
embedded project consume a 'stable' kernel that's being released ** 
every couple of weeks ** with the words 'users of this series must 
upgrade'? I presented some work at an  automotive GENIVI event in Oct 
2013 [1] but the audience at that time literally refused to accept that 
the idea of whole-of-life  updates.

And as Greg said at the time:

"The patches that apply for stuff after 2 years drops off dramatically, 
and the work involved in keeping stuff working and testing for problems 
increases greatly.?

Just yesterday there was a very interesting post about backports and 
long term stable kernels on LWN [2]. Greg is quoted there considering:

"But if we didn't provide an LTS, would companies constantly update 
their kernels to newer releases to keep up with the security and 
bugfixes? That goes against everything those managers/PMs have ever been 
used to in the past, yet it's actually the best thing they could do."

I've been recommending the constant update route route to customers 
over the last few years, with some success, but many ecosystem members 
are extremely uncomfortable with the whole idea of aligning with 
mainline. I think this is broadly because as embedded engineers we've 
learned over many years that it's best to change the platform as little 
as possible.  I wrote an article trying to challenge this traditional 
embedded thinking earlier this year [3]

Would be very interested in others' thoughts on this.

br
Paul

[1] 
http://www.devcurmudgeon.com/pdfs/mainline-lts-ltsi-genivi-20131025.pdf
[2] https://lwn.net/SubscriberLink/700557/091f804480fab479/
[3] http://www.devcurmudgeon.com/technical-debt-for-whole-systems.html

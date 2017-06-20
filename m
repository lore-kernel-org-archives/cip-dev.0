From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Tue, 20 Jun 2017 19:05:38 +0200
Subject: [cip-dev] CIP Kernel release cadence
In-Reply-To: <1497971890.1935.24.camel@codethink.co.uk>
References: <TY1PR06MB070244570A65174FAA8CBCF4B7C50@TY1PR06MB0702.apcprd06.prod.outlook.com>
	<1497971890.1935.24.camel@codethink.co.uk>
Message-ID: <594955E2.9070101@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chris,

I think I mentioned before some of the below arguments when this topic 
was risen months ago. It is a good time to publish them here.

On 20/06/17 17:18, Ben Hutchings wrote:
> On Tue, 2017-06-20 at 09:12 +0000, Chris Paterson wrote:
>> Hello Ben,
>>
>> Do you have a plan for when future releases of the CIP Kernel will be
>> made?
>>
>> It would be good to have a fixed release cadence or roadmap, so people
>> using the Kernel can plan their activities accordingly.
>
> I expect to release about every month, and whenever there's an urgent
> security update (which there will be soon, for the "stack clash" issue).

I would like to keep flexibility here, that is, do not tight ourselves 
to releases yet for a variety of reasons. These are the main ones I can 
think of right now:

* We are in an LTS phase. Defining a cadence at this point might 
reinforce the idea that our kernel maintenance process is somehow 
different than LTS when, except for a few packages, it is not yet. That 
was intentional.

* I would like to be able to consistently test the kernel, even with a 
single test, before claiming to make releases, that is, before making a 
public commitment on any delivery process. The expectations can be 
higher that we can commit to.

* We do not know at this point what the maintenance cycle is going to be 
from the kernel community. I am not suggesting that we have to follow 
it, but before defining our cadence, I would have a clear idea about 
what upstream will do.

* A kernel release for SLTS has severe implications in other areas, like 
the testing tools, testing results, tests, etc. We need also to 
freeze/store/release them, together with the build instructions, 
metadata, artifacts, source code.... In other words, we need to define 
what "a release" means for CIP and how much effort requires.

* With the above and the fact that we are starting to put effort in -RT, 
I wonder if we will talk about releasing the CIP kernel or we will talk 
about releasing the CIP platform (assuming that at the beginning the 
kernel is the main bit).

Defining a release today might play against us in a year or two.

Once this said, if Members require at this point a cadence, we will 
provide one but I think that sticking to LTS cycle until Feb'18 and 
assuming that we will catch up every 4-8 weeks is the way to go. Once 
the 4.4 maintainer is published, let's talk to him/her and take decisions.

Is there a specific reason why you need a cadence now beyond what LTS 
provides? I am trying to understand the details in order to think about 
a solution for Renesas compatible with the above.

Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk

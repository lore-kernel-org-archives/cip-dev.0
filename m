From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 13 Nov 2017 17:52:37 +0100
Subject: [cip-dev] CIP Testing Project next steps: some ideas
Message-ID: <5A09CDD5.3000502@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

(this is a long mail)

in order to understand the ideas about the future of the CIP Testing 
project, let me enumerate the basic requirements that led CIP to pursue 
the current strategy, now under revision.

++ Fully de-centralise service architecture

A decision to go for a transparent & fully de-centralised service 
architecture as testing service architecture for CIP based on LAVA + 
KernelCI was based in the following arguments:

  - Conclusion from evaluating other projects: kernelci.org , LTSI, AGL, 
openSUSE, openStack.
    - Back then, AGL picture around testing was unclear.
    - FUEGO back then had 3 different repositories/forks.
  - Cost and current manpower availability.
    - After evaluating costs, it was easy to come to the conclusion that 
CIP could not create its own (semi)centralised service. This was the 
main driver to design a fully distributed service architecture for CIP 
testing at that point.
    - Priorities within CIP.
       - Back then the priority was to test the CIP kernel.
    - Adaptability to CIP nature.
       - The CIP Testing team concluded that LAVA+KernelCI could be 
adapted to our use case and service architecture.
    - Dependencies.
       - Back then we agreed that we could only maintain the kernel for 
a very long time if we took ownership of the kernel maintenance 
activities. The same principle applies to the testing service, 
environment, tests...

I summarised the above arguments in the following text that some of you 
have read before:

Sharing results is far from enough. CIP needs to ensure transparently 
that any engineer is:
...using the same tests...
...to test the same CIP system...
...on the same boards...
...with the same tool set...
...under the same environment...
...producing the same reports...
...comparable through canonical logs.

++ New picture

Over a year later there are some new elements to consider

1. AGL is making a significant investment in a semi-centralised testing 
service, based on LAVA+KernelCI. They are committed to maintain it.

2. As part of that work, several containers (KernelCI) to be maintained 
by AGL will be available soon, which would open the door for CIP to 
adopt a container based solution instead of a VM based one, reducing the 
effort to meet our use case.

Part of the work Codethink did in the provisioning and deployment front 
could then be delegated to AGL, reducing the effort to the configuration 
side only.

3. As part of the AGL work, KernelCI (data visualization) is being 
improved. The expectation is that these improvements end upstream, in 
kernelci.org

4.There are plans to integrate LAVA and FUEGO in the future according to 
FUEGO maintainer, Tim Bird.

5. LAVA development seem to go through a more stable phase. Dramatic 
changes in core areas has not been the norm in the last few months, once 
the transition from V1 to V2 was completed.

6. kernelci.org today includes older kernels like 4.4, 3.2...

7. KernelCI maintainer is no longer a Linaro employee.

8. Toshiba, a CIP Member, is investing directly in FUEGO.

++ Conversations at ELCE 2017

* CIP and AGL CIAT held a meeting to stablish areas of collaboration. 
The main conclusion was that CIP can adopt the containers based 
architecture in B at D, relying on AGL on maintaining each container 
(KernelCI).

On the other hand, CIP could focus more on the reporting side and also 
on creating tests. These two areas should be shared with AGL and 
upstream to kernelci.org

I see this agreement as a natural step forward. Action 2 of CIP Testing 
strategy already defined those two work areas as ToDo. It would be about 
raising their priority.

By relying on AGL on the provisioning and deployment side (containers) 
it is expected that the current workload on B at D could be reduced in the 
mid term. There is an initial technical work to be done that would take 
effort, in order to release B at D v2.0 as containers.

Keeping a similar effort than in the past, the amount of effort 
available for Action 2 would then be greater than Codethink could put 
during the past year.

++ Collaborating with kernelci.org

There are several collaboration points with kernelci.org:

a. Upstream any work done by CIP on the testing creation front.
b. Upstream any work done by CIP on the reporting side.
c. Sharing CIP results from B at D through kernelci.org
d. Include the CIP kernel tree in kernelci.org Some consideration about 
this will be done later.
e. Fully participate in kernelci.org

Let me add some considerations for each point.

a. Upstream any work done by CIP on the testing creation front.

I do not see in theory any significant issue in this front as long as 
the tests we create refers to upstream kernel code. If tests refers to 
code that is not upstream, I see some challenges in using them upstream.

b. Upstream any work done by CIP on the reporting side

The question CIP will need to answer is if the reports CIP kernel 
maintainers need are generic enough that will be also useful for other 
old kernel maintainers and kernel developers.

In general the answer should be yes, they should be useful, so it would 
surprise me if most of our reports does not end up upstream. Obviously 
we would need to comply with some technical decisions implemented in 
kernelci.org.

c. Sharing CIP results through kernelci.org

kernelci.org has a specific service architecture. B at D does not match 
that architecture since it was designed to test kernel locally.

I am not very optimistic about being able to use only the visualization 
part of the kernelci.org service since B at D uses its own LAVA, not Linaro 
one.

CIP would need to raise this use case upstream and evaluate the answer 
from Linaro and the kernelci.org project.

d. Include the CIP kernel tree in kernelci.org

I see no problem in including Ben's tree in kernelci.org. The 4.4 LTS 
tree is already there.

The problem comes with the fact that CIP/Ben H. would be expected of 
taking care of the results analysis associated with that tree. That is 
what good Open Source citizens would do, assume the workload of their 
requests. I doubt we can assume that workload anytime soon. In any case 
  we only care about specific boards.

Managing this use case would require some discussion with the 
kernelci.org community. I would explore it.

e. Fully participate in kernelci.org

With the above in mind, any organization, company or individual can 
participate in kernelci.org. CIP can too. But different requirements 
lead to adaptations which cannot be done and maintained without control 
over the service.

Linaro and the CIP project (Linux Foundation) do not necessarily have 
the same requirements today (or in 15 years). No matter if CIP fully 
participates upstream or not, my opinion is that the same strategy than 
in CIP Core applies here.

CIP needs control over its own testing service.

++ Current options

1. If kernelci.org is the answer, I propose to explore an agreement with 
Linaro. That would provide CIP some level of control.

Participating directly upstream in the current setup of the project, 
where it is Linaro the organization providing the service and the main 
investment without such agreement has risks. CIP should become upstream.

2. If the idea is joining forces with AGL, then an agreement with them 
should be the way to go.

I see two approaches:
    i The one discussed during ELCE 2017, described above, where both 
organization collaborate but each one has its own strategy. Both of them 
upstream as much as possible.
    ii One in which AGL provides the service to CIP, becoming AGL CIAT 
service consumers, contributing where we can and make sense to us.

3. Set up our own (semi)centralised testing service.

I think the same rationale CIP applied over a year ago is valid today. 
Setting up our own service is not an option unless the current level of 
investment in the CIP Testing project significantly increases, via 
monetary investment or/and contributions from Member.

Now we have a clear cost example in AGL. We just need to ask to find out 
how much we are talking about for the set up. In a couple of years we 
will know more about its maintenance.

++ Final remarks

I am glad that the technical and strategic decisions we took over a year 
ago has not closed CIP any door in the current scenario. Back then the 
situation was more blur than it is today.

Based on my experience, a (semi)centralised testing service is very 
expensive. I wonder how viable it is to have several LF initiatives 
setting up and maintaining independent embedded focused testing 
services. I hope the situation in a year is significantly better than 
today in this regard across initiatives.

When AGL decided to go for LAVA + KernelCI for its testing service, as 
CIP did, several new options opened for us. They need to be carefully 
considered. We are in a good position to share costs and risks with them.

As we have done in the kernel maintenance front, the closer we stay to 
upstream in the testing front, the less work we will do and the greater 
support we will get. kernelci.org is upstream in this regard. We can 
contribute in key areas, like tests, with very little cost and great 
benefit.

As in any Open Source project, before relying completely on upstream, an 
evaluation of the ownership and set up (ground rules) of that upstream 
project need to be carefully considered to understand, and ultimately 
assume, the potential risks inherited at the organization, legal... 
levels. This is true also for kernelci.org

I believe that with the current level of investment, CIP needs to share 
part of the workload related with the tooling in order to make 
meaningful contributions in the testing front, which is at the very end 
what we all want.

The CIP investment will need to grow in order to raise the quality 
threshold of what we are shipping. We all agree that testing is a 
central part of the CIP activity. It is not just a technical commitment. 
It is also about credibility.

Based on the new facts, if as a result of the re-thinking of the current 
testing strategy, B at D stop being a central part of the picture, that is 
fine for Codethink. My company is not afraid of killing their own babies 
when better options appear. What over a year ago made sense might not 
next year. We've been there several times before. The tragedy would be 
carrying on an iron ball chained to our foot.

I would explore in depth options 2.i and 2.ii, in that order, as initial 
steps.

Excuses for these two long mails. There will be no more :-)

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk

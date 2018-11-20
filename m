From: paul.sherwood@codethink.co.uk (Paul Sherwood)
Date: Tue, 20 Nov 2018 18:58:05 +0000
Subject: [cip-dev] [SystemSafety] Critical systems Linux
In-Reply-To: <1793f9677177e46904ff76e9ed88c51a@codethink.co.uk>
References: <037a01d480f8$1f486570$5dd93050$@phaedsys.com>
	<1793f9677177e46904ff76e9ed88c51a@codethink.co.uk>
Message-ID: <e5bcaec2b35a99e151627fbab8047e72@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Now to attempt to answer the question...

On 2018-11-20 18:45, Paul Sherwood wrote:
>> The question is:-
>> 
>> As Linux is monolithic, already written  (with minimal 
>> requirements/design
>> docs) and not to any coding standard
>> How would the world go about making a Certifiable Linux?

>> Is it possible?
>> 

Some initiatives have already started down this road, for example 
SIL2LINUXMP (in cc)

But my personal perspective is

1) it may be the the certifications themselves are inappropriate. It's 
far from clear to me that the current standards are fit for purpose.

2) there are many cases of folks retrofitting documentation to support 
compliance with standards, so perhaps that would be a feasible thing to 
attempt (although there is far too much code in the Linux kernel and 
associated FOSS tooling and userland components to make this something 
which could be achieved in a short time)

3) if we could establish justifiable concrete improvements to make in 
Linux (and the tools, and the userland), we could hope to persuade the 
upstreams to make them, or accept our patches.

4) we could construct new software to meet the ABI commitments of Linux 
(and other components) while adhering to some specific standards and/or 
processes, but I'm unconvinced this could be achieved in a 
time/cost-effective way.

>> And the question I asked: why do it at all when there are plenty of 
>> other
>> POSIX Compliant RTOS and OS out there that have full Safety 
>> Certification to
>> 61508 SIL3 and  Do178  etc.?

My understanding is that existing certified RTOS/OS tend to be 
microkernels with limited functionality, limited hardware support, and 
performance limitations for some usecases. I'd be happy to be wrong, and 
no-doubt advocates of some of those technologies can explain the reality 
by return.

br
Paul

From: paul.sherwood@codethink.co.uk (Paul Sherwood)
Date: Tue, 20 Nov 2018 18:45:16 +0000
Subject: [cip-dev] [SystemSafety] Critical systems Linux
In-Reply-To: <037a01d480f8$1f486570$5dd93050$@phaedsys.com>
References: <037a01d480f8$1f486570$5dd93050$@phaedsys.com>
Message-ID: <1793f9677177e46904ff76e9ed88c51a@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2018-11-20 17:40, Chris Hills wrote:
> A subversion of the thread to answer one of the points raised by Paul 
> and
> almost every Linux aficionado
> 
>> -----Original Message-----
>> bielefeld.de] On Behalf Of Paul Sherwood
>> Sent: Sunday, November 4, 2018 8:54 PM
> 
>> One anti-pattern I've grown a bit tired of is people choosing a
> micro-kernel instead of Linux, because of the notional 'safety cert',
>> and then having to implement tons of custom software in attempting to
> match off-the-shelf Linux functionality or performance. When 
> application
>> of the standards leads to "develop new, from scratch" instead of using
> existing code which is widely used and known to be reliable, something
>> is clearly weird imo.
> 
> The question is:-
> 
> As Linux is monolithic, already written  (with minimal 
> requirements/design
> docs) and not to any coding standard
> How would the world go about making a Certifiable Linux?
> 
> Is it possible?
> 
> 
> And the question I asked: why do it at all when there are plenty of 
> other
> POSIX Compliant RTOS and OS out there that have full Safety 
> Certification to
> 61508 SIL3 and  Do178  etc.?

While systemsafety may be the leading community for public discussion 
around systems (and software) safety, it is not the only ML that has an 
interest in this topic so I'm cross-posting to some other (including 
Linux) lists in the hope that we may see wider discussion and 
contribution.

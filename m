From: paul.sherwood@codethink.co.uk (Paul Sherwood)
Date: Thu, 22 Nov 2018 09:24:27 +0000
Subject: [cip-dev] [SystemSafety]   Critical systems Linux
In-Reply-To: <e5bcaec2b35a99e151627fbab8047e72@codethink.co.uk>
References: <037a01d480f8$1f486570$5dd93050$@phaedsys.com>
	<1793f9677177e46904ff76e9ed88c51a@codethink.co.uk>
	<e5bcaec2b35a99e151627fbab8047e72@codethink.co.uk>
Message-ID: <e65ecf916a6f7952737b52aeb591eaa5@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi again...
>>> The question is:-
>>> 
>>> As Linux is monolithic, already written  (with minimal 
>>> requirements/design
>>> docs) and not to any coding standard
>>> How would the world go about making a Certifiable Linux?
> 
>>> Is it possible?

Sadly most of the followon discussion seems to have stayed only on 
systemsafetylist.org [1] which rather reduces its impact IMO.

I cross-posted in the hope that knowledge from the safety community 
could be usefully shared with other communities who are (for better or 
worse) considering and in some cases already using Linux in 
safety-critical systems. For example Linux Foundation is actively 
soliciting contributors expressly for an initiative to establish how 
best to support safety scenarios, as discussed at ELCE [2] with 
contributors from OSADL (e.g. [3]) and others.

Perhaps I'm being stupid but it's still unclear to me, after the 
discussion about existing certificates, whether the 'pre-certification' 
approach is justifiable at all, for **any** software, not just Linux.

As I understand it, for any particular project/system/service we need to 
define safety requirements, and safety architecture. From that we need 
to establish constraints and required properties and behaviours of 
chosen architecture components (including OS components). On that basis 
it seems to me that we must always prepare a specific argument for an 
actual system, and cannot safely claim that any generic 
pre-certification fits our use-case?

Please could someone from systemsafetylist.org reply-all and spell it 
out, preferably without referring to standards and without triggering a 
lot of controversy?

br
Paul

[1] http://systemsafetylist.org/4310.htm
[2] 
https://www.osadl.org/Linux-in-Safety-Critical-Systems-Summit.lfsummit-elce-safety.0.html
[3] 
https://events.linuxfoundation.org/wp-content/uploads/2017/12/Collaborate-on-Linux-for-Use-in-Safety-Critical-Systems-Lukas-Bulwahn-BMW-Car-IT-GmbH-1.pdf

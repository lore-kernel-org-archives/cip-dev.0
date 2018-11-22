From: clivepygott@gmail.com (Clive Pygott)
Date: Thu, 22 Nov 2018 11:57:32 +0000
Subject: [cip-dev] [C-safe-secure-studygroup] [SystemSafety] Critical
 systems Linux
In-Reply-To: <e65ecf916a6f7952737b52aeb591eaa5@codethink.co.uk>
References: <037a01d480f8$1f486570$5dd93050$@phaedsys.com>
	<1793f9677177e46904ff76e9ed88c51a@codethink.co.uk>
	<e5bcaec2b35a99e151627fbab8047e72@codethink.co.uk>
	<e65ecf916a6f7952737b52aeb591eaa5@codethink.co.uk>
Message-ID: <CABXWzybkB3f8ocM64oEACGwFTbarh1Qiu_ohn65JhMJS3YzLQQ@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Paul

I'll have a go at your question - FYI my background is system safety
management (as in 61508 & DO178) and coding standards (MISRA & JSF++)

You are right that ultimately system safety is a *system *property. You
cannot talk about software doing harm without knowing what its controlling
and how it fits into its physical environment. However, a standard like
61508 takes a layered approach to safety. The topmost levels are system
specific: how could the system behave (intentionally or under fault
conditions) to cause harm? and what features of the architecture (including
software requirements) mitigate these risks? This establishes traceability
from software requirements to safety.

>From the software perspective, under this is the requirement to show that
those software requirements related to safety have been implemented
correctly, and as usual this has two components:

   - showing that the code implements the requirements (verification -
   we've built the right thing)
   - showing the code is well behaved under all circumstances (validation -
   we've built the thing right)

If you are doing full formal semantic verification, the second step is
unnecessary, as the semantic proof will consider all possible combinations
of input and state. However, in practice formal proof is so onerous that
its almost never done. This means that verification is based on testing,
which no matter how thorough, is still based on sampling. There is an
implied belief that the digital system will behave continuously, even
though its known that this isn't true (a good few years ago an early home
computer had an implementation of BASIC that had an integer ABS functions
that worked perfectly except for ABS(-32768) which gave -32768  and it
wasn't because it was limited to 16-bits, ABS(-32769) gave 32769 etc).

The validation part aims to improve the (albeit flawed) belief in
contiguous behaviour by:

   - checking that any constraints imposed by the language are respected
   - any deviations from arithmetic logic are identified (i.e. flagging
   where underflow, overflow, truncation, wraparound or loss of precision may
   occur)

This is the domain of MISRA and JSF++  checking that the code will behave
sensibly, without knowledge of what it should be doing.

To get back to the original discussion, it is staggeringly naive to claim
that 'I have a safe system, because I've used a certified OS kernel'.  I'm
sure you weren't suggesting that, but I have seen companies try it. What
the certified kernel (or any other architectural component) buys you is
that someone has done the verification and validation activities on that
component, so you can be reasonably confident that that component will
behave as advertised - its a level of detail your project doesn't have to
look into (though you may want to audit the quality of the certification
evidence).

As I read your original message you are asking 'why can't a wide user base
be accepted as evidence of correctness?'  The short answer is, do you have
any evidence of what features of the component the users are using and in
what combination? Is my project about to use some combination of features
in an inventive manner that no-one has previously tried, so the wide user
base provides no evidence that it will work  (again a good few years ago,
colleagues of mine were writing a compiler for a VAX and traced a bug to a
particular instruction in the VAX instruction set that had an error in its
implementation. No DEC product or other customer had ever used this
instruction.  BTW, DEC's solution was to remove it from the instruction set)

Hope this helps

       Clive
       LDRA Inc.

On Thu, Nov 22, 2018 at 9:24 AM Paul Sherwood <paul.sherwood@codethink.co.uk>
wrote:

> Hi again...
> >>> The question is:-
> >>>
> >>> As Linux is monolithic, already written  (with minimal
> >>> requirements/design
> >>> docs) and not to any coding standard
> >>> How would the world go about making a Certifiable Linux?
> >
> >>> Is it possible?
>
> Sadly most of the followon discussion seems to have stayed only on
> systemsafetylist.org [1] which rather reduces its impact IMO.
>
> I cross-posted in the hope that knowledge from the safety community
> could be usefully shared with other communities who are (for better or
> worse) considering and in some cases already using Linux in
> safety-critical systems. For example Linux Foundation is actively
> soliciting contributors expressly for an initiative to establish how
> best to support safety scenarios, as discussed at ELCE [2] with
> contributors from OSADL (e.g. [3]) and others.
>
> Perhaps I'm being stupid but it's still unclear to me, after the
> discussion about existing certificates, whether the 'pre-certification'
> approach is justifiable at all, for **any** software, not just Linux.
>
> As I understand it, for any particular project/system/service we need to
> define safety requirements, and safety architecture. From that we need
> to establish constraints and required properties and behaviours of
> chosen architecture components (including OS components). On that basis
> it seems to me that we must always prepare a specific argument for an
> actual system, and cannot safely claim that any generic
> pre-certification fits our use-case?
>
> Please could someone from systemsafetylist.org reply-all and spell it
> out, preferably without referring to standards and without triggering a
> lot of controversy?
>
> br
> Paul
>
> [1] http://systemsafetylist.org/4310.htm
> [2]
>
> https://www.osadl.org/Linux-in-Safety-Critical-Systems-Summit.lfsummit-elce-safety.0.html
> [3]
>
> https://events.linuxfoundation.org/wp-content/uploads/2017/12/Collaborate-on-Linux-for-Use-in-Safety-Critical-Systems-Lukas-Bulwahn-BMW-Car-IT-GmbH-1.pdf
>
>
> _______________________________________________
> C-safe-secure-studygroup mailing list
> C-safe-secure-studygroup at lists.trustable.io
>
> https://lists.trustable.io/cgi-bin/mailman/listinfo/c-safe-secure-studygroup
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181122/95bcb11d/attachment-0001.html>

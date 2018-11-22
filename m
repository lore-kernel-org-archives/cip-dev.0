From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Thu, 22 Nov 2018 18:43:02 +0100
Subject: [cip-dev] [Safety-linux-formation] [C-safe-secure-studygroup]
 [SystemSafety] Critical systems Linux
In-Reply-To: <62a60dde1d1d014ff87735b3f6f4d56a@codethink.co.uk>
References: <037a01d480f8$1f486570$5dd93050$@phaedsys.com>
	<1793f9677177e46904ff76e9ed88c51a@codethink.co.uk>
	<e5bcaec2b35a99e151627fbab8047e72@codethink.co.uk>
	<e65ecf916a6f7952737b52aeb591eaa5@codethink.co.uk>
	<CABXWzybkB3f8ocM64oEACGwFTbarh1Qiu_ohn65JhMJS3YzLQQ@mail.gmail.com>
	<62a60dde1d1d014ff87735b3f6f4d56a@codethink.co.uk>
Message-ID: <20181122174302.GA28676@osadl.at>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, Nov 22, 2018 at 01:19:44PM +0000, Paul Sherwood wrote:
> Hi Clive,
> this is very helpful, thank you. I'm going to re-add the other lists, for
> the same reason as before, and hope you're ok with that. Please see my
> comments inline below...
> 
> On 2018-11-22 10:26, Clive Pygott wrote:
> >I'll have a go at your question - FYI my background is system safety
> >management (as in 61508 & DO178) and coding standards (MISRA & JSF++)
> >
> >You are right that ultimately system safety is a _system _property.
> >You cannot talk about software doing harm without knowing what its
> >controlling and how it fits into its physical environment.
> 
> Understood, and I'd be surprised if anyone would challenge this reasoning.
> 
> >However, a standard like 61508 takes a layered approach to safety.
> 
> I'm not sure I understand "layered approach", since I've heard it mentioned
> in multiple situations outside safety (security for one, and general
> architecture/abstraction for another).
> 
> Are you saying that the aim is redundant/overlapping safety methods, to
> avoid single-point-of-failure, or something else?

61508 starts out with the top layer wich is actually technology
agnostic - simply put if we do not understand the system then it
can?t be adequately safe - so part 1 does not talk about HW/SW at all
but about context/scope/hazard-analysis/mitigation-allocation...
independent of technological issues. Part 2 then looks at the 
technical system (and not just HW) with respect to systematic and
random deviations from specifications as derived by applying part 1
part 3 then looks at the specifics of software. So the layering
of 61508 is a very abstract process layering to ensure that the
poetntial high-level faults - non-understanding expressed in requirements
and design faults - we do not kill that many people wiht dereferenced
NULL pointers - atleast not repetedly if the high-level processes work
are addressed at all levels. see e.g. HSE HSG238

In addition there may be technical "layering" as in layers of protection
and architectural measures - but thats already at the implementation
level.

> 
> >The topmost
> >levels are system specific: how could the system behave (intentionally
> >or under fault conditions) to cause harm? and what features of the
> >architecture (including software requirements) mitigate these risks?
> >This establishes traceability from software requirements to safety.
> 
> OK, understood. In previous discussions I've been attempting to understand
> whether there's any fundamental reasons that such requirements would need to
> exist before the software, or whether they could be originated for a
> specific system, and then considered/applied to pre-existing code. Is there
> a hard and fast argument one way or the other?

The simplest argument is that the goal of any safety process is that the
safety functional requirements are implemented in the software elements - the
outlined process (route 1_S) is one way seen suitable to achieve the objectives
of the safety standards (61508 and derivatives - DO 178 is a bit different
because the context of ARP 4751A is well defined - so they can put very specific
needs into DO 178/254 while 61508 is a generic standard and can?t do that.

Essentially the goal of achieving the objectives is not dependent on the
process by which the implementation is achieved - verification of the
achieving of the objectives *may* though depend on the means by which
the imlementation wsa achieved (but then again is quite independent of
the question of "intent for use in safety related systems" or not).

> 
> >From the software perspective, under this is the requirement to show
> >that those software requirements related to safety have been
> >implemented correctly, and as usual this has two components:
> >
> >	* showing that the code implements the requirements (verification -
> >we've built the right thing)
> 
> OK, makes sense.
> 
> >	* showing the code is well behaved under all circumstances
> >(validation - we've built the thing right)

DO 178B (respectively DO 248) - but that misses the essential point of

      * showing that the assurance data (often process data) on which we
        based any such claim is adequate

and this is the thing that is changing because the two highlevel requirements
you give are fully adequate for deterministic and relatively simple
system (type-A systems in 61508-2 Ed 2 7.4.4.1.2) but not for type B
system because we generally can?t demonstrate correctness nor compleness
in any meaningful sense - with other words we increasingly simply do not
know what the "right thing" is and as soon as non-determinism comes
into play the "built the thing right" becomes a probability as well and
needs to be assessed as such (e.g. a pLRUt cache replacement in many
current CPU does not allow to claim that it is built right other than
probabilistically).

> 
> Here I fall off the horse. I don't believe we can be 100% certain about "all
> circumstances", except for small/constrained/simple systems. So I distrust
> claims of certainty about the behaviour of modern COTS multicore
> microprocessors, for example.

..we fell off that horse about 20 years ago but many did not notice ;)

The point is to accept what has been stated many time alreday that
safety is not a 100% property anyway - as long as system were simple
we could entertain the illusion of completeness of testing (an absurd
assertion since the mid 1990s for many systems) and we have not yet
fully developed the necessary understanding and tools to actually
handle complex systems. Also note that this idea of correctness is 
bound to strongly to technical realisation which puts the focus on
mitigation of faults rather than the elimination of faults at the
requirements and design level - and that is really why we are so lost
with current safety standards when it comes to complex systems because
we emediately jump to mitigation rather than harvesting the potential
for elimination first - with other words the problem is systems engineering
not software engineering.

> 
> >If you are doing full formal semantic verification, the second step is
> >unnecessary, as the semantic proof will consider all possible
> >combinations of input and state.

...and who ever had a fault free initial specification to start
with for her formal specificaiton that then was shown to be implemented ?

the idea that "everything in the system matches the requirments" and
"every requirement is built into the system" - kind of the corrolary to
your two components above - does not address the key issue in fucntional
safety and that is that our reqiurements are wrong because we do not 
fully understand the system and its environment (except for the most trivial
of systems).

> 
> It's not fair to single out any individual project/system/community, but as
> an example [1] SEL4's formal proof of correctness proved to be insufficient
> in the context of spectre/meltdown. I'd be (pleasantly) surprised if any
> semantic proof can withstand misbehaviour of the
> hardware/firmware/OS/tooling underneath it.

...and the misunderstanding of the systems intent by those writing
the formal specification that then is proven - it is interesting to note
that 61508 Ed 2 (Table A.1) ranks formal requiremets specification
lower than semi-formal requirements specification and in Table C.1 it
is clarified why - reduced understandability !

> 
> >However, in practice formal proof is
> >so onerous that its almost never done. This means that verification is
> >based on testing, which no matter how thorough, is still based on
> >sampling. There is an implied belief that the digital system will
> >behave continuously, even though its known that this isn't true (a
> >good few years ago an early home computer had an implementation of
> >BASIC that had an integer ABS functions that worked perfectly except
> >for ABS(-32768) which gave -32768  and it wasn't because it was
> >limited to 16-bits, ABS(-32769) gave 32769 etc).

it is not based on testing - no sane safety standard would suggest to
achieve verification by testing - it is always  analysis and testing 
and if it is reduced to testing only then it will for sure produce a
warm cosy fealing after execution of 100k test-csae... which covered
10E-20% of the systems state-space. 

The problem of testing is that in the heads of many we sitll have the
idea that an aggregation of highly-reliable components forms a highly
reliable system - which is wrong in it self but becomes a real hazard
as soon as the ability to inspec comonents is so much easier that we
focus on components because we can believe that we understand then
in isolation and then simply drop the main cause which is interaction
(which is in genreal not covered by testing - not even integratoin
testing - maybe to a limited level by field trials)


> 
> Understood, and agreed.
> 
> >The validation part aims to improve the (albeit flawed) belief in
> >contiguous behaviour by:
> >
> >	* checking that any constraints imposed by the language are respected
> >	* any deviations from arithmetic logic are identified (i.e. flagging
> >where underflow, overflow, truncation, wraparound or loss of precision
> >may occur)
> >
> >This is the domain of MISRA and JSF++  checking that the code will
> >behave sensibly, without knowledge of what it should be doing.
> 

Does anyone have hard evidence that shows that there is *any*
significant correlation between MISRA C coding rules and bug rates ?
This is one of the cases where we focus on formality because we can
even though we have little (or no) evidence that these rules or metrics
have any effect (aside from them being used in a way that they
were never intended for anyway) ?

as a corrolary think about your personal driving experience - how many#
situations were you in where you got out by violating a rule ?
the assumption that following context agnostic rules leads to 
safety properties of system is truely absurd.


> OK, IIUC this is mainly
> 
> - 'coding standards lead to tests we can run'. And once we are into tests,
> we have to consider applicability, correctness and completeness of the
> tests, in addition to the "flawed belief in contiguous behaviour".
> 
> - and possibly some untestable guidance/principles which may or may not be
> relevant/correct

If you have no specific context how can you assert more than correctness against
context free reqiuremnts which them selve have no assurance of correctness or
comleteness in the context of any specific system - focussing on what we can
because we know that we can?t handle the level that actually is
relevant is a form of deliberate ignorance.

Coding standards (and this is the intent of the Linux kernel coding standard)
lead to  *readability*  which is the maybe only relevant defence 
against correct implementation of the wrong function (or as you
state above not "building the right system"). That is the expressed
intent of the Linux kernel coding standard and readability respectively
understandability of code (and fault behavior) is the key to actually
being able to detect when the correctly implemented code is the wrong
solution for a particular context - the requirements don?t do as they are
an abstraction and as such they focus on the intended behavior not on the
side effects or unintended interactions - thus matching only requirements
of perceived generic elements will necessarily lead to missing the specific
intent for any system in the systems specific corner cases.

> 
> >To get back to the original discussion, it is staggeringly naive to
> >claim that 'I have a safe system, because I've used a certified OS
> >kernel'.  I'm sure you weren't suggesting that, but I have seen
> >companies try it.
> 
> I've also seen that (in part that's why I'm here) but I certainly wouldn't
> dream of suggesting it.
> 
> >What the certified kernel (or any other
> >architectural component) buys you is that someone has done the
> >verification and validation activities on that component, so you can
> >be reasonably confident that that component will behave as advertised

No - thats precisely what only is true for very simple components - but 
never holds for complex components and any OS is a type-B system 

a) the failure mode of at least one constituent component is not well defined; or
b) the behaviour of the element under fault conditions cannot be completely determined; or
c) there is insufficient dependable failure data to support claims for rates of failure for
   detected and undetected dangerous failures (see 7.4.9.3 to 7.4.9.5).
[IEC 61508-2 Ed 2 7.4.4.1.3]

Pre-certified OS (or complex libraries) buy you the illusion that you
took care of safety by giving someone else enough money - thats it.


> >- its a level of detail your project doesn't have to look into (though
> >you may want to audit the quality of the certification evidence).
> 
> OK in principle. However from some of the discussion, which I won't rehash
> here it seemed to me that some of the safety folks were expressly not
> confident in some of the certified/advertised/claimed behaviours.

good to hear that - they should not be - because it depends entirely on the
specific context - the higher the complexity of a system the more we depend
on looking at the right corners of the system to undrestand
where they can go wrong - focussing on generic properties (unspecific behaviors
and their correctness asserted against a more or less random model) gives
you very little. The higher the complexity of a system the more the abiltiy
to analyze the systems specific behavior in context of env/Use-case will determine
the systems safety properties. Even *if* testing could achieve the
initial goal of correctness the inability to analyze the system would
impair any effort to understand and thus learn from incidences.

> 
> >As I read your original message you are asking 'why can't a wide user
> >base be accepted as evidence of correctness?'
> 
> If that's the question I seemed to be asking I apologise; certainly I
> wouldn't count a wide user base as evidence of correctness. It's evidence of
> something, though, and that evidence may be part of what could be assessed
> when considering the usefulness of software.

prior usage may well be one building block in a chain of assessment
of a pre-existing element but I would claim primarily in the sense
of selecting the lowest risk elements - it will not save you any effort in
assessing the objectives of functional safety - but careful selectoin
based on prior usage will increas the likelyhood that the assessment
will actually conclude positively. To the specifics of 61508 Ed 2
route 3_S (assessment of non-compliant development) the relevance of
a large user base is also the ability to actually harvest process level
data that can allow to assess the effectiveness of different measures
e.g. it is trivial to state that a pre-existing element wsa reviewed but
without any data on finding, peoples competency, level of deviations later
found during operations, etc. we can not actually use "review was done"
as an argument in the assessment of a non-compliant development - and in
this sense user base is as you say "evidence of something" the trick
is to find sound procedures how to extract the relevant information in that
something so as to be able to make a statement on the process that created
the element. So as soon as you shift the focus from the implementation 
details to the process that created these implementation details
then the user base becomes the key "data set" that allows to actually build
an argument - at least that is the assumption behind the SIL2LinuxMP project.

> 
> >The short answer is, do
> >you have any evidence of what features of the component the users are
> >using and in what combination?
> 
> I totally agree - which brings us back to the need for required/architected
> behaviours/properties.
> 

with an important change - the use of pre-existing elements always
implies that you are building functionality into the system that
does NOT match you needs exactly and the mitigation again only
lies in the ability to analyze the system to the point where the system can
ither be adjusted to the specifics of the element (by updating requirements
and design) or by handling the discrepency at runtime (e.g. wrappers)
in a complex system it is highly unlikely that the requirements anyone put
on a complex element like an OS is in exact alignment with any particular 
system - not even POSIX 1003.13 PSE 51 matchies any real system 100%.

> >Is my project about to use some
> >combination of features in an inventive manner that no-one has
> >previously tried, so the wide user base provides no evidence that it
> >will work  (again a good few years ago, colleagues of mine were
> >writing a compiler for a VAX and traced a bug to a particular
> >instruction in the VAX instruction set that had an error in its
> >implementation. No DEC product or other customer had ever used this
> >instruction.  BTW, DEC's solution was to remove it from the
> >instruction set)
> 
> Makes sense. Thanks again Clive!
>
Thats the prime felacy I see in the whole pre-existing SW discussion
that the focus on fuctionality - the argument for using the common
setup is that the process initially was generating this common
setup and the measures and techniques to achieve the specfied
behavior where IN CONTEXT of the common use-case no mater if explicidly
stated or implied - diverting from the common use-case potentially
invalidates the results of these measures and techniques. So the 
requirement to be allowed to draw on any process level claims of the
pre-existing element is to operate it in as close a context to the
original intent as possible - using common configurations is one
aprt of this.

thx!
hofrat

From: paul.sherwood@codethink.co.uk (Paul Sherwood)
Date: Thu, 22 Nov 2018 13:19:44 +0000
Subject: [cip-dev] [C-safe-secure-studygroup] [SystemSafety] Critical
 systems Linux
In-Reply-To: <CABXWzybkB3f8ocM64oEACGwFTbarh1Qiu_ohn65JhMJS3YzLQQ@mail.gmail.com>
References: <037a01d480f8$1f486570$5dd93050$@phaedsys.com>
	<1793f9677177e46904ff76e9ed88c51a@codethink.co.uk>
	<e5bcaec2b35a99e151627fbab8047e72@codethink.co.uk>
	<e65ecf916a6f7952737b52aeb591eaa5@codethink.co.uk>
	<CABXWzybkB3f8ocM64oEACGwFTbarh1Qiu_ohn65JhMJS3YzLQQ@mail.gmail.com>
Message-ID: <62a60dde1d1d014ff87735b3f6f4d56a@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Clive,
this is very helpful, thank you. I'm going to re-add the other lists, 
for the same reason as before, and hope you're ok with that. Please see 
my comments inline below...

On 2018-11-22 10:26, Clive Pygott wrote:
> I'll have a go at your question - FYI my background is system safety
> management (as in 61508 & DO178) and coding standards (MISRA & JSF++)
> 
> You are right that ultimately system safety is a _system _property.
> You cannot talk about software doing harm without knowing what its
> controlling and how it fits into its physical environment.

Understood, and I'd be surprised if anyone would challenge this 
reasoning.

> However, a standard like 61508 takes a layered approach to safety.

I'm not sure I understand "layered approach", since I've heard it 
mentioned in multiple situations outside safety (security for one, and 
general architecture/abstraction for another).

Are you saying that the aim is redundant/overlapping safety methods, to 
avoid single-point-of-failure, or something else?

> The topmost
> levels are system specific: how could the system behave (intentionally
> or under fault conditions) to cause harm? and what features of the
> architecture (including software requirements) mitigate these risks?
> This establishes traceability from software requirements to safety.

OK, understood. In previous discussions I've been attempting to 
understand whether there's any fundamental reasons that such 
requirements would need to exist before the software, or whether they 
could be originated for a specific system, and then considered/applied 
to pre-existing code. Is there a hard and fast argument one way or the 
other?

> From the software perspective, under this is the requirement to show
> that those software requirements related to safety have been
> implemented correctly, and as usual this has two components:
> 
> 	* showing that the code implements the requirements (verification -
> we've built the right thing)

OK, makes sense.

> 	* showing the code is well behaved under all circumstances
> (validation - we've built the thing right)

Here I fall off the horse. I don't believe we can be 100% certain about 
"all circumstances", except for small/constrained/simple systems. So I 
distrust claims of certainty about the behaviour of modern COTS 
multicore microprocessors, for example.

> If you are doing full formal semantic verification, the second step is
> unnecessary, as the semantic proof will consider all possible
> combinations of input and state.

It's not fair to single out any individual project/system/community, but 
as an example [1] SEL4's formal proof of correctness proved to be 
insufficient in the context of spectre/meltdown. I'd be (pleasantly) 
surprised if any semantic proof can withstand misbehaviour of the 
hardware/firmware/OS/tooling underneath it.

> However, in practice formal proof is
> so onerous that its almost never done. This means that verification is
> based on testing, which no matter how thorough, is still based on
> sampling. There is an implied belief that the digital system will
> behave continuously, even though its known that this isn't true (a
> good few years ago an early home computer had an implementation of
> BASIC that had an integer ABS functions that worked perfectly except
> for ABS(-32768) which gave -32768  and it wasn't because it was
> limited to 16-bits, ABS(-32769) gave 32769 etc).

Understood, and agreed.

> The validation part aims to improve the (albeit flawed) belief in
> contiguous behaviour by:
> 
> 	* checking that any constraints imposed by the language are respected
> 	* any deviations from arithmetic logic are identified (i.e. flagging
> where underflow, overflow, truncation, wraparound or loss of precision
> may occur)
> 
> This is the domain of MISRA and JSF++  checking that the code will
> behave sensibly, without knowledge of what it should be doing.

OK, IIUC this is mainly

- 'coding standards lead to tests we can run'. And once we are into 
tests, we have to consider applicability, correctness and completeness 
of the tests, in addition to the "flawed belief in contiguous 
behaviour".

- and possibly some untestable guidance/principles which may or may not 
be relevant/correct

> To get back to the original discussion, it is staggeringly naive to
> claim that 'I have a safe system, because I've used a certified OS
> kernel'.  I'm sure you weren't suggesting that, but I have seen
> companies try it.

I've also seen that (in part that's why I'm here) but I certainly 
wouldn't dream of suggesting it.

> What the certified kernel (or any other
> architectural component) buys you is that someone has done the
> verification and validation activities on that component, so you can
> be reasonably confident that that component will behave as advertised
> - its a level of detail your project doesn't have to look into (though
> you may want to audit the quality of the certification evidence).

OK in principle. However from some of the discussion, which I won't 
rehash here it seemed to me that some of the safety folks were expressly 
not confident in some of the certified/advertised/claimed behaviours.

> As I read your original message you are asking 'why can't a wide user
> base be accepted as evidence of correctness?'

If that's the question I seemed to be asking I apologise; certainly I 
wouldn't count a wide user base as evidence of correctness. It's 
evidence of something, though, and that evidence may be part of what 
could be assessed when considering the usefulness of software.

> The short answer is, do
> you have any evidence of what features of the component the users are
> using and in what combination?

I totally agree - which brings us back to the need for 
required/architected behaviours/properties.

> Is my project about to use some
> combination of features in an inventive manner that no-one has
> previously tried, so the wide user base provides no evidence that it
> will work  (again a good few years ago, colleagues of mine were
> writing a compiler for a VAX and traced a bug to a particular
> instruction in the VAX instruction set that had an error in its
> implementation. No DEC product or other customer had ever used this
> instruction.  BTW, DEC's solution was to remove it from the
> instruction set)

Makes sense. Thanks again Clive!

br
Paul

[1] https://research.csiro.au/tsblog/crisis-security-vs-performance/

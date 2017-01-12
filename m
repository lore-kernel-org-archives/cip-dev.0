From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 12 Jan 2017 13:40:48 +0000
Subject: [cip-dev] [PATCH 4.4-cip 0/6] Extend user-space ASLR range
In-Reply-To: <CAGXu5j+bcjMQAahRnWnBzV9YD38_OhPiHkKSSURnRCFBD-pDdA@mail.gmail.com>
References: <1481241380.1860.120.camel@codethink.co.uk>
	<7c58c7d6-92fa-4b99-aa15-25c41243810c@siemens.com>
	<155216cf-3c1a-7f41-3ff2-956f92e3c7cb@siemens.com>
	<CAGXu5j+bcjMQAahRnWnBzV9YD38_OhPiHkKSSURnRCFBD-pDdA@mail.gmail.com>
Message-ID: <1484228448.10206.24.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2017-01-03 at 15:56 -0800, Kees Cook wrote:
> On Mon, Dec 19, 2016 at 2:52 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > On 2016-12-09 13:20, Jan Kiszka wrote:
[...]
> >> Did you try to discuss the back-port topic with the KSPP folks or other
> >> key persons involved in these patches? In the ideal case, the authors
> >> can be CC'ed, do not get annoyed by "these crazy people doing legacy
> >> stuff", and may even do some reviews.
> >>
> >
> > I've chatted with Elena over this last week, and she talked to Kees who
> > pointed out that the Android people are also doing KSPP backports to 4.4
> > (thanks, folks!). I didn't check any details, just a heads-up to avoid
> > duplicate work.
> 
> Hi!
> 
> The Android common kernel tree is visible here:
> 
> https://android.googlesource.com/kernel/common/
> 
> In the android-4.4 branch, the backport are these:
> 
> b471fcd FROMLIST: mm: ASLR: use get_random_long()
> 9a3fe39 FROMLIST: drivers: char: random: add get_random_long()
> d51891f FROMLIST: x86: mm: support ARCH_MMAP_RND_BITS.
> e2240a1 FROMLIST: arm64: mm: support ARCH_MMAP_RND_BITS.
> 25106ff FROMLIST: arm: mm: support ARCH_MMAP_RND_BITS.
> d49d887 FROMLIST: mm: mmap: Add new /proc tunable for mmap_base ASLR.
>
> Hopefully that helps!

Thanks.  My backports are identical aside from the placement of some
changes in Kconfig files, which shouldn't make a functional difference.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.

From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Wed, 4 Jan 2017 14:51:50 +0000
Subject: [cip-dev] [PATCH 4.4-cip 0/6] Extend user-space ASLR range
In-Reply-To: <CAGXu5j+bcjMQAahRnWnBzV9YD38_OhPiHkKSSURnRCFBD-pDdA@mail.gmail.com>
References: <1481241380.1860.120.camel@codethink.co.uk>
	<7c58c7d6-92fa-4b99-aa15-25c41243810c@siemens.com>
	<155216cf-3c1a-7f41-3ff2-956f92e3c7cb@siemens.com>
	<CAGXu5j+bcjMQAahRnWnBzV9YD38_OhPiHkKSSURnRCFBD-pDdA@mail.gmail.com>
Message-ID: <586D0C06.5060104@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 03/01/17 23:56, Kees Cook wrote:
> On Mon, Dec 19, 2016 at 2:52 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 2016-12-09 13:20, Jan Kiszka wrote:
>>> On 2016-12-09 00:56, Ben Hutchings wrote:
>>>> This is a backport of changes in 4.5 to extend the range of Address
>>>> Space Layout Randomisation for user-space processes.  When enabled, this
>>>> should make some user-space vulnerabilities harder to exploit, but it
>>>> can also cause some applications to fail if they currently use a large
>>>> proportion of the virtual address space.
>>>>
>>>> The default ASLR range remains the same, but it can be changed through
>>>> kernel config (CONFIG_ARCH_MMAP_RND_BITS) or at run-time through sysctl
>>>> (vm.mmap_rnd_bits).  (For 32-bit compat tasks, the range is controlled
>>>> through CONFIG_ARCH_MMAP_RND_COMPAT_BITS and vm.mmap_rnd_compat_bits.)
>>>>
>>>> This includes support for arm, arm64 and x86 (32- and 64-bit).  (arm64
>>>> is not currently supported by CIP, but it was easier to include it in
>>>> the backport than to leave it out.)
>>>>
>>>> For this and other backports, I'm looking for feedback like:
>>>> - Did I miss a follow-up fix or an earlier dependency?
>>>> - Does this cause a regression (other than as explained above)?
>>>> - Are you likely to use it?
>>>> - Are there related features you want in 4.4?
>>>>
>>>> Ben.
>>>>
>>>> Daniel Cashman (6):
>>>>    mm: mmap: add new /proc tunable for mmap_base ASLR
>>>>    arm: mm: support ARCH_MMAP_RND_BITS
>>>>    arm64: mm: support ARCH_MMAP_RND_BITS
>>>>    x86: mm: support ARCH_MMAP_RND_BITS
>>>>    drivers: char: random: add get_random_long()
>>>>    mm: ASLR: use get_random_long()
>>>>
>>>>   Documentation/sysctl/vm.txt      | 29 +++++++++++++++++
>>>>   arch/Kconfig                     | 68 ++++++++++++++++++++++++++++++++++++++++
>>>>   arch/arm/Kconfig                 |  9 ++++++
>>>>   arch/arm/mm/mmap.c               |  3 +-
>>>>   arch/arm64/Kconfig               | 29 +++++++++++++++++
>>>>   arch/arm64/mm/mmap.c             |  8 +++--
>>>>   arch/mips/mm/mmap.c              |  4 +--
>>>>   arch/powerpc/kernel/process.c    |  4 +--
>>>>   arch/powerpc/mm/mmap.c           |  4 +--
>>>>   arch/sparc/kernel/sys_sparc_64.c |  2 +-
>>>>   arch/x86/Kconfig                 | 16 ++++++++++
>>>>   arch/x86/mm/mmap.c               | 12 +++----
>>>>   drivers/char/random.c            | 22 +++++++++++++
>>>>   fs/binfmt_elf.c                  |  2 +-
>>>>   include/linux/mm.h               | 11 +++++++
>>>>   include/linux/random.h           |  1 +
>>>>   kernel/sysctl.c                  | 22 +++++++++++++
>>>>   mm/mmap.c                        | 12 +++++++
>>>>   18 files changed, 240 insertions(+), 18 deletions(-)
>>>>
>>>
>>> Did you try to discuss the back-port topic with the KSPP folks or other
>>> key persons involved in these patches? In the ideal case, the authors
>>> can be CC'ed, do not get annoyed by "these crazy people doing legacy
>>> stuff", and may even do some reviews.
>>>
>>
>> I've chatted with Elena over this last week, and she talked to Kees who
>> pointed out that the Android people are also doing KSPP backports to 4.4
>> (thanks, folks!). I didn't check any details, just a heads-up to avoid
>> duplicate work.
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

It does, thanks. I sent Dmitry Shmidt a mail this morning asking for 
this. Thanks.

>
> -Kees
>
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA ITP SES-DE
>> Corporate Competence Center Embedded Linux
>
>
>

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk

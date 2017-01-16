From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 16 Jan 2017 10:47:45 +0000
Subject: [cip-dev] [PATCH 4.4-cip 0/6] Extend user-space ASLR range
In-Reply-To: <587CA1EC.3040705@codethink.co.uk>
References: <1481241380.1860.120.camel@codethink.co.uk>
	<587CA1EC.3040705@codethink.co.uk>
Message-ID: <587CA4D1.9040804@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 16/01/17 10:35, Agustin Benito Bethencourt wrote:
> Hi,
>
> On 08/12/16 23:56, Ben Hutchings wrote:
>> This is a backport of changes in 4.5 to extend the range of Address
>> Space Layout Randomisation for user-space processes.  When enabled, this
>> should make some user-space vulnerabilities harder to exploit, but it
>> can also cause some applications to fail if they currently use a large
>> proportion of the virtual address space.
>>
>> The default ASLR range remains the same, but it can be changed through
>> kernel config (CONFIG_ARCH_MMAP_RND_BITS) or at run-time through sysctl
>> (vm.mmap_rnd_bits).  (For 32-bit compat tasks, the range is controlled
>> through CONFIG_ARCH_MMAP_RND_COMPAT_BITS and vm.mmap_rnd_compat_bits.)
>>
>> This includes support for arm, arm64 and x86 (32- and 64-bit).  (arm64
>> is not currently supported by CIP, but it was easier to include it in
>> the backport than to leave it out.)
>>
>> For this and other backports, I'm looking for feedback like:
>> - Did I miss a follow-up fix or an earlier dependency?
>> - Does this cause a regression (other than as explained above)?
>> - Are you likely to use it?
>> - Are there related features you want in 4.4?
>
> since there is no further feedback, I assume you me merge the patches,
> isn't is?

since there is no further feedback, I assume you will merge the patches, 
isn't is?

>
> Hopefully in a couple or three more weeks we can start testing it with
> kernelci tooling.
>
>>
>> Ben.
>>
>> Daniel Cashman (6):
>>    mm: mmap: add new /proc tunable for mmap_base ASLR
>>    arm: mm: support ARCH_MMAP_RND_BITS
>>    arm64: mm: support ARCH_MMAP_RND_BITS
>>    x86: mm: support ARCH_MMAP_RND_BITS
>>    drivers: char: random: add get_random_long()
>>    mm: ASLR: use get_random_long()
>>
>>   Documentation/sysctl/vm.txt      | 29 +++++++++++++++++
>>   arch/Kconfig                     | 68
>> ++++++++++++++++++++++++++++++++++++++++
>>   arch/arm/Kconfig                 |  9 ++++++
>>   arch/arm/mm/mmap.c               |  3 +-
>>   arch/arm64/Kconfig               | 29 +++++++++++++++++
>>   arch/arm64/mm/mmap.c             |  8 +++--
>>   arch/mips/mm/mmap.c              |  4 +--
>>   arch/powerpc/kernel/process.c    |  4 +--
>>   arch/powerpc/mm/mmap.c           |  4 +--
>>   arch/sparc/kernel/sys_sparc_64.c |  2 +-
>>   arch/x86/Kconfig                 | 16 ++++++++++
>>   arch/x86/mm/mmap.c               | 12 +++----
>>   drivers/char/random.c            | 22 +++++++++++++
>>   fs/binfmt_elf.c                  |  2 +-
>>   include/linux/mm.h               | 11 +++++++
>>   include/linux/random.h           |  1 +
>>   kernel/sysctl.c                  | 22 +++++++++++++
>>   mm/mmap.c                        | 12 +++++++
>>   18 files changed, 240 insertions(+), 18 deletions(-)
>>
>

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sat, 15 Feb 2020 12:25:32 +0100
Subject: [cip-dev] [PATCH] vfs: keep inodes with page cache off the
	inode shrinker LRU
In-Reply-To: <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
Message-ID: <CAMuHMdV8-=dj5n-FM1nHjXq1DhkJVOh4rLFxERt33jAQmU4h_A@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Arnd,

On Thu, Feb 13, 2020 at 5:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Tue, Feb 11, 2020 at 05:03:02PM -0800, Linus Torvalds wrote:
> > > So at least my gut feel is that the arm people don't have any big
> > > reason to push for maintaining HIGHMEM support either.
> > >
> > > But I'm adding a couple of arm people and the arm list just in case
> > > they have some input.
> > >
> > > [ Obvious background for newly added people: we're talking about
> > > making CONFIG_HIGHMEM a deprecated feature and saying that if you want
> > > to run with lots of memory on a 32-bit kernel, you're doing legacy
> > > stuff and can use a legacy kernel ]
> >
> > Well, the recent 32-bit ARM systems generally have more than 1G
> > of memory, so make use of highmem as a rule.  You're probably
> > talking about crippling support for any 32-bit ARM system produced
> > in the last 8 to 10 years.
>
> What I'm observing in the newly added board support is that memory
> configurations are actually going down, driven by component cost.
> 512MB is really cheap (~$4) these days with a single 256Mx16 DDR3
> chip or two 128Mx16. Going beyond 1GB is where things get expensive
> with either 4+ chips or LPDDR3/LPDDR4 memory.
>
> For designs with 1GB, we're probably better off just using
> CONFIG_VMSPLIT_3G_OPT (without LPAE) anyway, completely
> avoiding highmem. That is particularly true on systems with a custom
> kernel configuration.
>
> 2GB machines are less common, but are definitely important, e.g.
> MT6580 based Android phones and some industrial embedded machines
> that will live a long time. I've recently seen reports of odd behavior
> with CONFIG_VMSPLIT_2G and plus CONFIG_HIGHMEM and a 7:1
> ratio of lowmem to highmem that apparently causes OOM despite lots
> of lowmem being free. I suspect a lot of those workloads would still be
> better off with a CONFIG_VMSPLIT_2G_OPT (1.75 GB user, 2GB
> linear map). That config unfortunately has a few problems, too:
> - nobody has implemented it
> - it won't work with LPAE and therefore cannot support hardware
>   that relies on high physical addresses for RAM or MMIO
>   (those could run CONFIG_VMSPLIT_2G at the cost of wasting
>   12.5% of RAM).
> - any workload that requires the full 3GB of virtual address space won't
>   work at all. This might be e.g. MAP_FIXED users, or build servers
>   linking large binaries.
> It will take a while to find out what kinds of workloads suffer the most
> from a different vmsplit and what can be done to address that, but we
> could start by changing the kernel defconfig and distro builds to see
> who complains ;-)
>
> I think 32-bit ARM machines with 3GB or more are getting very rare,
> but some still exist:
> - The Armada XP development board had a DIMM slot that could take
>   large memory (possibly up to 8GB with LPAE). This never shipped as
>   a commercial product, but distro build servers sometimes still run on
>   this, or on the old Calxeda or Keystone server systems.
> - a few early i.MX6 boards  (e.g. HummingBoard) came had 4GB of
>   RAM, though none of these seem to be available any more.
> - High-end phones from 2013/2014 had 3GB LPDDR3 before getting
>   obsoleted by 64-bit phones. Presumably none of these ever ran
>   Linux-4.x or newer.
> - My main laptop is a RK3288 based Chromebook with 4GB that just
>   got updated to linux-4.19 by Google. Official updates apparently
>   stop this summer, but it could easily run Debian later on.
> - Some people run 32-bit kernels on a 64-bit Raspberry Pi 4 or on
>   arm64 KVM with lots of RAM. These should probably all
>   migrate to 64-bit kernels with compat user space anyway.
> In theory these could also run on a VMSPLIT_4G_4G-like setup,
> but I don't think anyone wants to go there. Deprecating highmem
> definitely impacts any such users significantly, though staying on
> an LTS kernel may be an option if there are only few of them.

The CIP-supported RZ/G1 SoCs can have up to 4 GiB, typically split (even
for 1 GiB or 2 GiB configurations) in two parts, one below and one above
the 32-bit physical limit.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

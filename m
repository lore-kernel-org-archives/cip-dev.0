From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 16 Feb 2020 10:44:42 +0100
Subject: [cip-dev] [PATCH] vfs: keep inodes with page cache off the
	inode shrinker LRU
In-Reply-To: <CAK8P3a0m574dHYuKBPLf6q2prnbFxX1w7xe4-JX-drN6dqH6TQ@mail.gmail.com>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <CAMuHMdV8-=dj5n-FM1nHjXq1DhkJVOh4rLFxERt33jAQmU4h_A@mail.gmail.com>
 <CAK8P3a0m574dHYuKBPLf6q2prnbFxX1w7xe4-JX-drN6dqH6TQ@mail.gmail.com>
Message-ID: <CAMuHMdVpTngVXUnLzpS3hZWuVg97GVTf2Y3X8md--41AtaD1Ug@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Arnd,

On Sat, Feb 15, 2020 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Feb 15, 2020 at 12:25 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Thu, Feb 13, 2020 at 5:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> >
> > The CIP-supported RZ/G1 SoCs can have up to 4 GiB, typically split (even
> > for 1 GiB or 2 GiB configurations) in two parts, one below and one above
> > the 32-bit physical limit.
>
> Good to know. I think there are several other chips that have dual-channel
> DDR3 and thus /can/ support this configuration, but this rarely happens.
> Are you aware of commercial products that use a 4GB configuration, aside from
> the reference board?

Unfortunately I don't know.
Chris Paterson might know.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

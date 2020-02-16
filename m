From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 16 Feb 2020 21:38:27 +0100
Subject: [cip-dev] [PATCH] vfs: keep inodes with page cache off the
	inode shrinker LRU
In-Reply-To: <TYAPR01MB228505DD9E7C85F9FA4AA785B7170@TYAPR01MB2285.jpnprd01.prod.outlook.com>
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
 <CAMuHMdVpTngVXUnLzpS3hZWuVg97GVTf2Y3X8md--41AtaD1Ug@mail.gmail.com>
 <TYAPR01MB228505DD9E7C85F9FA4AA785B7170@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <CAK8P3a3Za8dthPE7czQs+rK+xUq+ZZC4Sbj8QF5YjXvtfzop4Q@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Sun, Feb 16, 2020 at 8:54 PM Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>
> Hello Arnd, Geert,
>
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 16 February 2020 09:45
> > To: Arnd Bergmann <arnd@arndb.de>
> >
> > Hi Arnd,
> >
> > On Sat, Feb 15, 2020 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Sat, Feb 15, 2020 at 12:25 PM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Thu, Feb 13, 2020 at 5:54 PM Arnd Bergmann <arnd@arndb.de>
> > wrote:
> > > > > On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
> > > > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > The CIP-supported RZ/G1 SoCs can have up to 4 GiB, typically split (even
> > > > for 1 GiB or 2 GiB configurations) in two parts, one below and one above
> > > > the 32-bit physical limit.
>
> Yep. One example is r8a7743-iwg20m.dtsi.

This one has 2x512MB, with half above the 4GiB limit. This means it needs
LPAE to address high physical addresses (which is fine), but it does not need
highmem if one uses an appropriate CONFIG_VMSPLIT_* option.

> > > Good to know. I think there are several other chips that have dual-channel
> > > DDR3 and thus /can/ support this configuration, but this rarely happens.
> > > Are you aware of commercial products that use a 4GB configuration, aside
> > from
> > > the reference board?
>
> iWave Systems make a range of SOM modules using the RZ/G1 SoCs.
> I believe there are options for some of these to use 4 GB, although 1 or 2 GB is
> used in the boards we've upstreamed support for.
>
> There are also other SOM vendors (e.g. Emtrion) and end users of RZ/G1,
> but I'm not sure of the details.

Both iWave and Emtrion only seem to list boards with 2GB or less on their
websites today (with up to 15 year availability). My guess is that they had
the same problem as everyone else in finding the right memory chips in
the required quantities and/or long-term availability. iWave lists "By default
1GB DDR3 and 4GB eMMC only supported. Contact iWave for memory
expansion support." on some boards, but that doesn't mean they ever
shipped a 4GB configuration.

       Arnd

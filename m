From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 Dec 2019 10:44:54 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 08/39] soc: renesas: r8a7795-sysc:
 Fix power request conflicts
In-Reply-To: <OSBPR01MB2103CCD07F5187D51623EF7CB8520@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
 <1576668829-59767-9-git-send-email-biju.das@bp.renesas.com>
 <20191218193234.GB15353@amd>
 <OSBPR01MB2103CCD07F5187D51623EF7CB8520@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <CAMuHMdVeeJDQxC56PFnK_s-sZgSd-oQ95BCihh=_na8HMgZX9A@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Biju, Pavel,

On Thu, Dec 19, 2019 at 8:43 AM Biju Das <biju.das@bp.renesas.com> wrote:
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Wednesday, December 18, 2019 7:33 PM
> > To: Biju Das <biju.das@bp.renesas.com>
> > Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> > Chris Paterson <Chris.Paterson2@renesas.com>; Marian-Cristian Rotariu
> > <marian-cristian.rotariu.rb@bp.renesas.com>; Fabrizio Castro
> > <fabrizio.castro@bp.renesas.com>
> > Subject: Re: [PATCH 4.19.y-cip 08/39] soc: renesas: r8a7795-sysc: Fix power
> > request conflicts
> >
> > > This register does not exist on R-Car H3 ES1.x and ES2.x.
> > >
> > > Based on a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.
> >
> > So you are storing bitfield in the pointer, ok.
> >
> > > -   { .soc_id = "r8a7795", .revision = "ES1.*" },
> > > +#define HAS_A2VC0  BIT(0)          /* Power domain A2VC0 is
> > present */
> > > +#define NO_EXTMASK BIT(1)          /* Missing SYSCEXTMASK
> > register */
> > > +
> > > +static const struct soc_device_attribute r8a7795_quirks_match[]
> > __initconst = {
> > > +   {
> > > +           .soc_id = "r8a7795", .revision = "ES1.*",
> > > +           .data = (void *)(HAS_A2VC0 | NO_EXTMASK),
> > > +   }, {
> > > +           .soc_id = "r8a7795", .revision = "ES2.*",
> > > +           .data = (void *)(NO_EXTMASK),
> > > +   },
> > >     { /* sentinel */ }
> > >  };
> > >
> > >  static int __init r8a7795_sysc_init(void)  {
> > > -   if (!soc_device_match(r8a7795es1))
> > > +   const struct soc_device_attribute *attr;
> > > +   u32 quirks = 0;
> > > +
> > > +   attr = soc_device_match(r8a7795_quirks_match);
> > > +   if (attr)
> > > +           quirks = (uintptr_t)attr->data;
> >
> > But now you do strange dance with types. I'd understand quirks being
> > unsigned long (because that's same size as void *). I also could understand
> > quirks being uintptr_t in the first place (but we normally use unsigned long
> > for that in the kernel).
> >
> > But having it as u32, then casting it over uintptr_t is strange.
>
> Dien, Geert,
>
> Could you please share your thoughts on Pavel's comments?

struct soc_device_attribute.data contains an opaque value, just like
e.g. of_device_id.data and platform_device_id.driver_data.
In some structs, the opaque value is a "void *", in other structs it is an
"unsigned long".  But the actual meaning and contents depend on the
driver.  It may be used to store a pointer to a struct with features,
an integer value, or a feature mask.
Conversion between pointer and integer is done by casting to "void *",
or to "uintptr_t" (historically, "unsigned long" was used for this, but
modern code uses "uintptr_t").

In this case, it contains a feature mask, which fits in "u32", which is
"unsigned int", and "(unsigned) int" is still the standard type for any random
variable that doesn't have special requirements.
  - To store the feature mask, a cast to "void *" is needed.
  - To retrieve the feature mask, a cast to "uintptr_t" is needed.
    A cast to "u32" would cause a warning on 64-bit platforms, due to
    the truncation of a 64-bit pointer to a 32-bit integer.

I agree "unsigned long" could have been a suitable type for "quirks"
as well, but I see no reason to make that change when backporting
a patch to stable.

$ git grep "unsigned long quirks" | wc -l
58
$ git grep "unsigned int quirks" | wc -l
26
$ git grep "u32 quirks" | wc -l
46

Hope this helps.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

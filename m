From: wens@kernel.org (Chen-Yu Tsai)
Date: Wed, 11 Dec 2019 20:19:36 +0800
Subject: [cip-dev] Linux 4.19.89-rc1 5944fcdd errors
In-Reply-To: <TYAPR01MB22852454802BAB486871D944B75A0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB228505DBC22568339F914C15B7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191209173637.GF1290729@kroah.com>
 <TYAPR01MB2285135B15E6A152163E1A1AB7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191210073514.GB3077639@kroah.com>
 <TYAPR01MB2285B5834B1FBA71F8DA512BB75B0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191210145528.GA4012363@kroah.com>
 <TYAPR01MB2285433EA1E6DF9EC621E31AB75B0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191210205951.GA4081499@kroah.com>
 <TYAPR01MB22852454802BAB486871D944B75A0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <CAGb2v66mXBtyypam9iPbT_=cpm-ZYSpFqDBA9f3mxM9ME8q-ug@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, Dec 11, 2019 at 6:52 PM Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>
> Hello Greg,
>
> [...]
>
> > > > That's a lot, are these all new?
> > >
> > > I've only just started building with this config in our CI setup, but
> > > building the dtbs locally with v4.19.88 didn't produce these results
> > > for me (and building locally with v4.19.89-rc1 does result in the
> > > above issues).
> >
> > Any chance you can run 'git bisect' to track down the offending patch?
>
> The two dtbs that fail to build are fixed by reverting by the patches below:
>
> > allwinner/sun50i-a64-pinebook.dtb
> ea03518a3123 ("arm64: dts: allwinner: a64: enable sound on Pinebook")

I suggest dropping this if possible. It depends on another dtsi patch,

    ec4a95409d5c arm64: dts: allwinner: a64: add nodes necessary for
analog sound support

and multiple driver patches

    55b407f6468c ASoC: sun8i-codec-analog: split regmap code into
separate driver
    42371f327df0 ASoC: sunxi: Add new driver for Allwinner A64 codec's
analog path controls
    7e95aac96b55 ASoC: sunxi: allow the sun8i-codec driver to be built on ARM64
    66ecce332538 ASoC: sun4i-i2s: Add compatibility with A64 codec I2S
    ... (there quite a few more)

to actually work. Quite sure those aren't backportable since one is over
four hundred lines.

Regards
ChenYu

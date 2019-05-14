From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Tue, 14 May 2019 22:28:02 +0900
Subject: [cip-dev] [PATCH 4.4.y 00/52] Add basic support for the iwg23s
In-Reply-To: <TY1PR01MB1770786FF0F16BDBBE3DA1D2C0080@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190513201718.GF27497@amd>
	<20190514002814.zbgrh2iwn2vxf3zi@toshiba.co.jp>
	<TY1PR01MB1770786FF0F16BDBBE3DA1D2C0080@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <CABMQnV+RxsoR36WzX41sYvrysxxCngcZmQnhFFivx6rmzE-i7A@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

2019?5?14?(?) 19:12 Fabrizio Castro <fabrizio.castro@bp.renesas.com>:
>
> Thank you guys for your help!
>
> I think for the future we would need to agree on a format we are all comfortable with
> when backporting a patch from mainline is not an option.
>
> Do you have any suggestions?

I think it is enough to write down a note why each commit is not
backported from the linux kernel.
CIP has an "upstream first" policy, so if we can not choice this
policy, it is better to include a
reason to commit message, I think.
For example, 'We can not backport a patch because the clock framework
is different in 4.4, so we
need to create a new patch.'

How is this?

Best regards,
  Nobuhiro


>
> Thanks,
> Fab
>
> > From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Sent: 14 May 2019 01:28
> > Subject: Re: [cip-dev] [PATCH 4.4.y 00/52] Add basic support for the iwg23s
> >
> > Hi,
> >
> > On Mon, May 13, 2019 at 10:17:18PM +0200, Pavel Machek wrote:
> > > Hi!
> > >
> > > > This series adds basic support for the iwg23s from iWave, based
> > > > on the RZ/G1C (a.k.a. r8a77470).
> > >
> > > Thanks, applied. Minor comments were sent in replies to response to
> > > patches.
> >
> > There are patches in this patch series that is not match to the CIP kernel maintenance rules.
> > If we include these, I think that the commit message is not enough.
> >
> > Best regards,
> >   Nobuhiro
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev



--
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6

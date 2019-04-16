From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 16 Apr 2019 00:36:28 +0000
Subject: [cip-dev] Was: Software updates comparison
In-Reply-To: <OSAPR01MB3763A5D79B2FDA22985A27E6D0240@OSAPR01MB3763.jpnprd01.prod.outlook.com>
References: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
	<CWx3VAY6FR4u8TvvCYpZVU4PEFDDpIV3oLzmvLIH2328@mailpile>
	<OSAPR01MB3763A5D79B2FDA22985A27E6D0240@OSAPR01MB3763.jpnprd01.prod.outlook.com>
Message-ID: <OSAPR01MB376377C4BBC17C1B4988D4D1D0240@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Oops, I sent it too quickly.

> I know meta-updater because it was proposed to be used in AGL by
> advancedtelematic. Their approach wasn't using A/B updates, which is a
> requirement for the initial architecture. But we did consider it for devices
> with small storage, it's just that we left that approach for later.
> Do you know the relation and differences between meta-
> updater/TUF/Uptane. If possible could

If possible could you tell us whether they align to the requirements of the initial architecture?
- A/B updates (the bootloader controls a hardware watchdog)
- Delta support (low bandwidth)
- Generic (can support any OS image builder such as meta-debian or ISAR)
- Low dependencies (no python or similar dependencies)
- Support for custom scripts

Thanks,
Daniel

> 
> Thanks,
> Daniel
> 
> [1]
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_comparison
> _report
> [2]
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_software_u
> pdates_architecture
> 
> > > >
> > > > This comparison is mostly based on other comparisons reports,
> > experience from CIP members and from reading the documentation.
> > > >
> > > > For this initial iteration we decided to prepare a prototype using
> > SWUpdate+librsync (for the binary deltas) and ISAR. Having said that,
> > SWUpdate+the CIP
> > Software updates workgroup is open to other methods and contributions
> > (specially in the form of patches). Our aim is to provide guidance and
> > reference code/metadata for CIP users to update their devices using
> > existing OSS update tools.
> > > >
> > > > If you think that information in the comparison is not accurate or
> > > > you
> > want to complement it please let me know.
> > >
> > > Thanks for the document - I am mainly interested on the good and bad
> > > points about SWpdate and I can put a couple of details:
> > >
> > > Bad points
> > >
> > > - depends on libubootenv which needs to be rebuilt for each target.
> > >
> > > This was a well known issue and source of several conflicts in the
> > > past. Thanks to a customer of mines, I have implemented a new
> > > libubootenv library that is hardware independent and fixes this issue.
> > > Not only, this could allow in future to extend it and introduce
> > > security features, like signed environment:
> > >
> > > 	https://github.com/sbabic/libubootenv
> > >
> > > The library must be explicitely activated in SWUpdate's
> > > configuration, it will become the default in future.
> > >
> > > - hard to manage updates from v1 to v5 directly
> > >
> > > This is also a topic I had on my desk - as it is possible to read in
> > > your comparison / research, this can be solved if SWUpdate and
> > > CASync can be combined. But to make things correct, SWUpdate should
> > > well integrate CASync and uses it as library - this requires some
> > > changes in CASync, too. I had a draft design about this, but due to
> > > the complexity / effort, the project asking for delta-update decided
> > > in another direction. There is currently no further work in SWUpdate
> > > in this direction.
> > >
> > > Best regards,
> > > Stefano
> > >
> >
> > - --
> > Sent using Mailpile, Free Software from www.mailpile.is
> >
> > -----BEGIN PGP SIGNATURE-----
> >
> >
> iQGzBAEBCgAdFiEED83jmcaGxJZGGerGKdK9XRgP+iUFAlyz3o0ACgkQKdK9XRgP
> >
> +iVBZAv/a9kHLyHdZUbZA1EiJE0WaLwmmD+lp07A9s2cPfNTf5px/8DtbYPrLhm
> > 9
> >
> s+atSMbrWUl1R7v1hmZ6tPmZpXAOz+EJgknoRr40+FlBIgF/MZvnq29Zg91igKcG
> >
> ZEHJq1AJl68dzm5O70DGoMIrxZ/k2WAeElZ+JPR7aN7RiYCNm4qTwvt/QLpNw
> > muT
> >
> Hr+sDZvWbomGd/VwuXuttW6o/Lpq1al9GljmedBsycBcPCWkc6G7eupyoNSTN
> > mli
> >
> jKvwlxx/5loapVDMuI+l2cQX6MVVTSrhqGxhB1w2SFmZBsWDgFV/snds9rK4Q6
> > KE
> >
> SS4sLsM2PxrFK/fRFHHUzUPc4thmnRHOp0XOR3+qRen2MyVeQxJjlouTBn9nCS
> > Oy
> >
> wy5zh10QAMboC0H5HARnS4fWOrwpwEfFPX16s+uSMbF36JJMyqokk23Z5asx
> > QTV8
> >
> +YBV9tJch1U311BUG4zS8yTKm1kRSDbGQs21V5xxPirKhsFTepwgLfwbTSK+cxjk
> > MyCZR5wM
> > =7PB7
> > -----END PGP SIGNATURE-----
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev

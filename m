From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 16 Apr 2019 00:28:54 +0000
Subject: [cip-dev] Was: Software updates comparison
In-Reply-To: <CWx3VAY6FR4u8TvvCYpZVU4PEFDDpIV3oLzmvLIH2328@mailpile>
References: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
	<CWx3VAY6FR4u8TvvCYpZVU4PEFDDpIV3oLzmvLIH2328@mailpile>
Message-ID: <OSAPR01MB3763A5D79B2FDA22985A27E6D0240@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Scott!

Thank god that Christian answered, for some reason your e-mail was in my junk folder.

> From: Scott V. Kamp <scottk@optimcloud.com>
> > > I have added a Software updates comparison report to our wiki:
> > > https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_com
> > > parison_report
> 
> 
> I actually find this comparison surprisingly lacking from a security and
> methodology stand point given that its quite limited, and leaves out other
> well know and not so well known. 

Actually, this is not a "pure" comparison between tools. What we actually did was to read existing comparison reports (see Comparison references at [1]), mix the experience of our members and "compare" which tools aligned best with the requirements of our initial architecture [2].

> I am sure we dont need to mention the
> likes of Balena and Mender..... 

These tools are great but it was obvious to me that they did not satisfy the requirements of our initial architecture [2] so I skipped them right away. 
# this requirements come from a survey between CIP members.
- Balena sounds great if your OS is based on docker containers. I prefer to start with a generic solution that can be used on any OS image.
- Mender server is in the comparison actually and we would like to try it at some point (for the first prototype we use Hawkbit though). The client does not support enough features in the open source version (e.g. delta updates are a strict requirement).

Having said that, I am open to contributions (e.g.: prototypes that show how to update CIP kernel/core with OSS update tools and a text file explaining how it works).  The goal of this workgroup is to show how to use existing OSS update tools with the CIP kernel (LTS kernel + alpha) and CIP Core (Debian-based OS images built from source or binaries). We want to provide them as examples on our reference boards (e.g. BeagleBone Black) so that anyone can start from something that works. In the future I want to add an implementation that uses CASync. If you want to have a try with a different update tool, I will be glad to accept your work for the users of CIP to have more choices.

> I was quite surprised to see RAUC, as it is not
> so well known however... 

Actually I know RAUC because I met his developer on a conference. But the reason that RAUC is there is mostly because it supports CASync (well, not a perfect integration because it is not a library yet). I really like the CASync approach because of its simplicity.

> your missing ostree, tuf and uptane .. and honestly
> from a security standpoint this combination far surpasses any of the
> previously mentioned in methodology and implementation. Along with OTA
> Community Edition, it is by far the best solution, far more so then hawkbit,
> swupdate and TUF
> 
> https://uptane.github.io/
> https://github.com/advancedtelematic/...
> https://github.com/advancedtelematic/...

Actually advancedtelematic/OStree work IS included in the the comparison [1] and is in fact one of the 3 best candidates.
1. SWUpdate+librsync
2. CASync (I added RAUC mostly because it supports CASync)
3. meta-updater (based on OSTree and originally designed by advanced telematic

Here I need your help. I found TUF and Uptane, but I wasn't sure about the difference with meta-updater.
I know meta-updater because it was proposed to be used in AGL by advancedtelematic. Their approach wasn't using A/B updates, which is a requirement for the initial architecture. But we did consider it for devices with small storage, it's just that we left that approach for later.
Do you know the relation and differences between meta-updater/TUF/Uptane. If possible could

Thanks,
Daniel

[1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_comparison_report
[2] https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_software_updates_architecture

> > >
> > > This comparison is mostly based on other comparisons reports,
> experience from CIP members and from reading the documentation.
> > >
> > > For this initial iteration we decided to prepare a prototype using
> SWUpdate+librsync (for the binary deltas) and ISAR. Having said that, the CIP
> Software updates workgroup is open to other methods and contributions
> (specially in the form of patches). Our aim is to provide guidance and
> reference code/metadata for CIP users to update their devices using existing
> OSS update tools.
> > >
> > > If you think that information in the comparison is not accurate or you
> want to complement it please let me know.
> >
> > Thanks for the document - I am mainly interested on the good and bad
> > points about SWpdate and I can put a couple of details:
> >
> > Bad points
> >
> > - depends on libubootenv which needs to be rebuilt for each target.
> >
> > This was a well known issue and source of several conflicts in the
> > past. Thanks to a customer of mines, I have implemented a new
> > libubootenv library that is hardware independent and fixes this issue.
> > Not only, this could allow in future to extend it and introduce
> > security features, like signed environment:
> >
> > 	https://github.com/sbabic/libubootenv
> >
> > The library must be explicitely activated in SWUpdate's configuration,
> > it will become the default in future.
> >
> > - hard to manage updates from v1 to v5 directly
> >
> > This is also a topic I had on my desk - as it is possible to read in
> > your comparison / research, this can be solved if SWUpdate and CASync
> > can be combined. But to make things correct, SWUpdate should well
> > integrate CASync and uses it as library - this requires some changes
> > in CASync, too. I had a draft design about this, but due to the
> > complexity / effort, the project asking for delta-update decided in
> > another direction. There is currently no further work in SWUpdate in
> > this direction.
> >
> > Best regards,
> > Stefano
> >
> 
> - --
> Sent using Mailpile, Free Software from www.mailpile.is
> 
> -----BEGIN PGP SIGNATURE-----
> 
> iQGzBAEBCgAdFiEED83jmcaGxJZGGerGKdK9XRgP+iUFAlyz3o0ACgkQKdK9XRgP
> +iVBZAv/a9kHLyHdZUbZA1EiJE0WaLwmmD+lp07A9s2cPfNTf5px/8DtbYPrLhm
> 9
> s+atSMbrWUl1R7v1hmZ6tPmZpXAOz+EJgknoRr40+FlBIgF/MZvnq29Zg91igKcG
> ZEHJq1AJl68dzm5O70DGoMIrxZ/k2WAeElZ+JPR7aN7RiYCNm4qTwvt/QLpNw
> muT
> Hr+sDZvWbomGd/VwuXuttW6o/Lpq1al9GljmedBsycBcPCWkc6G7eupyoNSTN
> mli
> jKvwlxx/5loapVDMuI+l2cQX6MVVTSrhqGxhB1w2SFmZBsWDgFV/snds9rK4Q6
> KE
> SS4sLsM2PxrFK/fRFHHUzUPc4thmnRHOp0XOR3+qRen2MyVeQxJjlouTBn9nCS
> Oy
> wy5zh10QAMboC0H5HARnS4fWOrwpwEfFPX16s+uSMbF36JJMyqokk23Z5asx
> QTV8
> +YBV9tJch1U311BUG4zS8yTKm1kRSDbGQs21V5xxPirKhsFTepwgLfwbTSK+cxjk
> MyCZR5wM
> =7PB7
> -----END PGP SIGNATURE-----

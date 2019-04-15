From: scottk@optimcloud.com (Scott V. Kamp)
Date: Mon, 15 Apr 2019 01:30:13 -0000
Subject: [cip-dev] Was: Software updates comparison
In-Reply-To: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
References: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
Message-ID: <CWx3VAY6FR4u8TvvCYpZVU4PEFDDpIV3oLzmvLIH2328@mailpile>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Stefano Babic <sbabic@denx.de> wrote:
> Hi Daniel,
> 
> > Hi,
> > 
> > I have added a Software updates comparison report to our wiki:
> > https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_comparison_report


I actually find this comparison surprisingly lacking from a
security and methodology stand point given that its quite
limited, and leaves out other well know and not so well known. I
am sure we dont need to mention the likes of Balena and
Mender..... I was quite surprised to see RAUC, as it is not so
well known however... your missing ostree, tuf and uptane .. and
honestly from a security standpoint this combination far
surpasses any of the previously mentioned in methodology and
implementation. Along with OTA Community Edition, it is by far
the best solution, far more so then hawkbit, swupdate and TUF

https://uptane.github.io/
https://github.com/advancedtelematic/...
https://github.com/advancedtelematic/...


> > 
> > This comparison is mostly based on other comparisons reports, experience from CIP members and from reading the documentation.
> > 
> > For this initial iteration we decided to prepare a prototype using SWUpdate+librsync (for the binary deltas) and ISAR. Having said that, the CIP Software updates workgroup is open to other methods and contributions (specially in the form of patches). Our aim is to provide guidance and reference code/metadata for CIP users to update their devices using existing OSS update tools.
> > 
> > If you think that information in the comparison is not accurate or you want to complement it please let me know.
> 
> Thanks for the document - I am mainly interested on the good
> and bad points about SWpdate and I can put a couple of details:
> 
> Bad points
> 
> - depends on libubootenv which needs to be rebuilt for each target.
> 
> This was a well known issue and source of several conflicts in
> the past. Thanks to a customer of mines, I have implemented a
> new libubootenv library that is hardware independent and fixes
> this issue. Not only, this could allow in future to extend it
> and introduce security features, like signed environment:
> 
> 	https://github.com/sbabic/libubootenv
> 
> The library must be explicitely activated in SWUpdate's
> configuration, it will become the default in future.
> 
> - hard to manage updates from v1 to v5 directly
> 
> This is also a topic I had on my desk - as it is possible to
> read in your comparison / research, this can be solved if
> SWUpdate and CASync can be combined. But to make things
> correct, SWUpdate should well integrate CASync and uses it as
> library - this requires some changes in CASync, too. I had a
> draft design about this, but due to the complexity
> / effort, the project asking for delta-update decided in another
> direction. There is currently no further work in SWUpdate in
> this direction.
> 
> Best regards,
> Stefano
>

- -- 
Sent using Mailpile, Free Software from www.mailpile.is

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEED83jmcaGxJZGGerGKdK9XRgP+iUFAlyz3o0ACgkQKdK9XRgP
+iVBZAv/a9kHLyHdZUbZA1EiJE0WaLwmmD+lp07A9s2cPfNTf5px/8DtbYPrLhm9
s+atSMbrWUl1R7v1hmZ6tPmZpXAOz+EJgknoRr40+FlBIgF/MZvnq29Zg91igKcG
ZEHJq1AJl68dzm5O70DGoMIrxZ/k2WAeElZ+JPR7aN7RiYCNm4qTwvt/QLpNwmuT
Hr+sDZvWbomGd/VwuXuttW6o/Lpq1al9GljmedBsycBcPCWkc6G7eupyoNSTNmli
jKvwlxx/5loapVDMuI+l2cQX6MVVTSrhqGxhB1w2SFmZBsWDgFV/snds9rK4Q6KE
SS4sLsM2PxrFK/fRFHHUzUPc4thmnRHOp0XOR3+qRen2MyVeQxJjlouTBn9nCSOy
wy5zh10QAMboC0H5HARnS4fWOrwpwEfFPX16s+uSMbF36JJMyqokk23Z5asxQTV8
+YBV9tJch1U311BUG4zS8yTKm1kRSDbGQs21V5xxPirKhsFTepwgLfwbTSK+cxjk
MyCZR5wM
=7PB7
-----END PGP SIGNATURE-----

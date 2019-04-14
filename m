From: info@optimus-es.com (Info)
Date: Sun, 14 Apr 2019 16:20:15 -0000
Subject: [cip-dev] Was: Software updates comparison
In-Reply-To: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
References: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
Message-ID: <qP8cpI7bnB7TGmfkhIyDwxGQo8J6csFBeiL83qWq2328@mailpile>
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
https://github.com/advancedtelematic/ota-community-edition
https://github.com/advancedtelematic/aktualizr

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

iQGzBAEBCgAdFiEEu1jhkyGqo2gz54+mOQO0cdlUo7MFAlyzXdsACgkQOQO0cdlU
o7NWCQv+J7i7SevPTWa2qcIzQZzQEViXe9eATi+n68J3ZETC3Gqm0nFzzUPObryU
dOGbp8t5mf02RT8ppPLkCTA/sLxmVJOEBAzWErVA1y6KQzaTkmZe4y+iSrX0E87s
Fl8giVRiXT2cxq3s1uLhfo3X0GWT/DJqTHdNc8X8OFkoyYTzDh6HiYqWMungplyC
SQnzzfPGZkFECoaZUaepkzWvYILIJN7vCta5NeDKSTaYsbdyfpY9vDZRi7eCgmNw
WfxS4qcW4IEaNZ647AUa0LAYRhMJgMqOmUICuOuoyVd2nx7tU6ZtsQMTpD+2lu40
hcvu2Ew2Hcn/If1UhaWJL2sGlfRY4T8wVdz/UdP8bRK1cTqXEBKbexIPFmcOwhPM
wix0E8DbbhPoQR/tefJolnK7UPj5x7aoMsYWayvnE2VkKYhbGu3e5CaqElIakpdt
xZtiZUqvqHUrrhVhnIlUIfCA4nhMFY+0xTP13Gvgxl+4Ai75QN/Rtw0xFQxktjSI
AiCfvh8G
=ownp
-----END PGP SIGNATURE-----

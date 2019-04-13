From: sbabic@denx.de (Stefano Babic)
Date: Sat, 13 Apr 2019 21:00:37 +0200
Subject: [cip-dev] Was: Software updates comparison
Message-ID: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

> Hi,
> 
> I have added a Software updates comparison report to our wiki:
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_comparison_report
> 
> This comparison is mostly based on other comparisons reports, experience from CIP members and from reading the documentation.
> 
> For this initial iteration we decided to prepare a prototype using SWUpdate+librsync (for the binary deltas) and ISAR. Having said that, the CIP Software updates workgroup is open to other methods and contributions (specially in the form of patches). Our aim is to provide guidance and reference code/metadata for CIP users to update their devices using existing OSS update tools.
> 
> If you think that information in the comparison is not accurate or you want to complement it please let me know.

Thanks for the document - I am mainly interested on the good and bad
points about SWpdate and I can put a couple of details:

Bad points

- depends on libubootenv which needs to be rebuilt for each target.

This was a well known issue and source of several conflicts in the past.
Thanks to a customer of mines, I have implemented a new libubootenv
library that is hardware independent and fixes this issue. Not only,
this could allow in future to extend it and introduce security features,
like signed environment:

	https://github.com/sbabic/libubootenv

The library must be explicitely activated in SWUpdate's configuration,
it will become the default in future.

- hard to manage updates from v1 to v5 directly

This is also a topic I had on my desk - as it is possible to read in
your comparison / research, this can be solved if SWUpdate and CASync
can be combined. But to make things correct, SWUpdate should well
integrate CASync and uses it as library - this requires some changes in
CASync, too. I had a draft design about this, but due to the complexity
/ effort, the project asking for delta-update decided in another
direction. There is currently no further work in SWUpdate in this direction.

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic at denx.de
=====================================================================

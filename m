From: christian.storm@siemens.com (Christian Storm)
Date: Mon, 15 Apr 2019 12:46:08 +0200
Subject: [cip-dev] Was: Software updates comparison
In-Reply-To: <CWx3VAY6FR4u8TvvCYpZVU4PEFDDpIV3oLzmvLIH2328@mailpile>
Message-ID: <20190415104608.dtouxgbumb2pw3rc@MD1ZFJVC.ad001.siemens.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Scott,

> > > I have added a Software updates comparison report to our wiki:
> > > https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_comparison_report
> 
> 
> I actually find this comparison surprisingly lacking from a
> security and methodology stand point given that its quite
> limited, and leaves out other well know and not so well known. 
>
> I am sure we dont need to mention the likes of Balena and Mender.....

Well, just for the record....

Balena{,OS} revolves around Docker, e.g., to fetch the firmware
(=container) images prior to extracting them to the spare partition in
A/B deployments. Granted, one could also imagine to use OSTree for this...
Bootloader support is currently grub-efi and u-boot.
As a sidenote: Having reliable firmware update realized with grub is
quite involved, that's -- among other reasons -- why Siemens came up
with EFI Boot Guard [1] for x86/UEFI systems.
So, Balena is quite tied to Docker with all its benefits and drawbacks.

Mender.io can be seen as a one-stop alternative to HawkBit in the
backend plus some agent running on the device as they offer both:
a backend and an according on-device agent.
The on-device agent is written in Golang and tied to the Mender backend.
In terms of features and configurability it's not as advanced as others.
That said, one can implement support for Mender's backend into, e.g.,
SWUpdate quite easily. I already talked to the Mender guys about this...


> I was quite surprised to see RAUC, as it is not so well known
> however...

Well, as an on-device agent not tied to a particular backend, RAUC can
be seen as a competitor to SWUpdate, and hence is usually evaluated as
well for the same use cases.

Both are building blocks for a firmware update solution focusing on the
device-side of things. They are not a one-stop all-in-one solution but
building blocks that are intended to be integrated into a solution.


> your missing ostree, [...]

That depends on what use case you're after. OSTree is a tool for
managing filesystem trees. It is not (primarily) a tool to manage full
disk images. It's somewhere in between with a blend of both approaches'
pros and cons.

That said, there are definitely use cases for OSTree and there speaks
nothing against integrating it into the on-device agents. However, IMO,
doing full disk image firmware updates lends itself to other solutions.
Speaking of OSTree, there's also casync [2] having similar properties,
however, supporting full disk images as well. Once this has become
a proper library, I'm sure it will find its way into SWUpdate.

The question is whether to identify and settle to a particular software/
solution or whether the on-device agent should be flexible enough to
employ different methods serving the many particular -- and naturally
different -- use cases.


> [...] tuf and uptane .. 
> and honestly from a security standpoint this combination far surpasses
> any of the previously mentioned in methodology and implementation.
> Along with OTA Community Edition, it is by far the best solution, far
> more so then hawkbit, swupdate and TUF
> 
> https://uptane.github.io/
> https://github.com/advancedtelematic/...
> https://github.com/advancedtelematic/...

TUF, uptane, aktualizr, and alikes certainly do have their merits, fully
agree. The question here again is what use cases you're after and
whether you want to shop a one-stop all-in-one solution or build/
integrate it using building blocks for the different components.
Granted, in terms of full vertical integration (i.e., backend and
on-device agent), there's surely still work to be done to make a proper
integration of the building blocks, in particular regarding
documentation w.r.t. best (security) practices.
However, I do not see an inherent or general superiority of using TUF,
uptane, aktualizr, or alikes compared to integrating building blocks,
particularly in hindsight to integration flexibility.


Kind regards,
   Christian

[1] https://github.com/siemens/efibootguard
[2] https://github.com/systemd/casync

-- 
Dr. Christian Storm
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M?nchen, Germany

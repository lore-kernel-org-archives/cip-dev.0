From: pjones@redhat.com (Peter Jones)
Date: Wed, 1 May 2019 10:52:18 -0400
Subject: [cip-dev] EFIBootGuard for CIP and SecureBoot
In-Reply-To: <8bfa74c6-fd58-c1c0-d327-2dbe22463f84@csgraf.de>
References: <OSAPR01MB37639B3931B3AA6A9765099BD03E0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<20190426083106.643evxbnzkxyhqsy@MD1ZFJVC.ad001.siemens.net>
	<CAHFG_=VQigOtWZRiRy=zMVSb1BpfFNyVa3dnGfn=fBQW-KjGMA@mail.gmail.com>
	<ad933d6b-86ae-bbad-9138-730cb71849e4@siemens.com>
	<dc1dd410-08d4-334b-4a9d-acad8283ab19@arm.com>
	<b62f89d8-284d-66d4-4156-3079f058d8aa@siemens.com>
	<f75d46c2-d8f3-42f9-f3d6-6786d3147c1d@gmx.de>
	<8bfa74c6-fd58-c1c0-d327-2dbe22463f84@csgraf.de>
Message-ID: <20190501145212.uexjqutgphk6pofr@redhat.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Sat, Apr 27, 2019 at 09:56:08AM +0200, Alexander Graf wrote:
> 
> >>> UEFI gets a bad rap at being complicated, but I think the U-Boot work
> >>> has shown that implementing the core UEFI ABI doesn't require much code
> >>> and isn't the complicated mess they everyone fears it to be.
> >> Depends on how much you start to rely on UEFI features.
> > The format for a UEFI capsule is described in the
> > EFI_FIRMWARE_MANAGEMENT_PROTOCOL chapter of the UEFI spec. Essentially
> 
> Are you sure? I thought that protocol was about other devices in the
> system, not the main firmware. It also seems to be optional - so we
> could just have a board specific function to implement CapsuleUpdate,
> but no cruft for all the other bits in the spec.

There's no requirement to use that format in order to use capsule
updates, but some vendors have found it convenient.  There's also no
requirement to implement the EFI_FIRMWARE_MANAGEMENT_PROTOCOL at all -
and the only place it's distinctly useful from an application point of
view (i.e. while trying to drive a firmware update) is if you want to
independently update two of the same kind of peripheral device's
firmware from within a UEFI application.  It's not clear to me that's a
very interesting use case from an EBBR point of view - I'm haven't seen
much demand for it on server, laptop, or desktop systems either.

But it's also how option ROMs register their firmware to be updated via
UpdateCapsule().  That's interesting on machines where you regularly
expect peripherals to be in PCIe slots, but I'm still not sure it's that
useful for EBBR style devices.  I guess it could be useful in the
thunderbolt case, but I think in order to avoid thwarting DMA attack
mitigations, that would best be done from the OS just like for USB
devices.

> That's where the idea came from to just put a fit image into the capsule
> body (set CapsuleGUID to a newly defined FIT-GUID). With that, we could
> share a lot of code inside of U-Boot, as DT parsing is already there. We
> could then have individual segments, that can either be data or command
> payloads and thus a capsule update could basically just be a few data
> segments with a U-Boot script.

This makes a lot of sense to me, though there have been some pain points
about this approach in the past.  The biggest one is because the
EFI_FIRMWARE_MANAGEMENT_PROTOCOL capsule format has a header on it
that's the same as the EFI_CAPSULE_HEADER structure, which we have to
add in fwupd if we can't find it.  If we plan on recommending that
vendors implement these ad-hoc firmware blobs, we should also require
that when they do so, they already include the EFI_CAPSULE_HEADER on the
image, with a GUID that matches what's in the ESRT, and is specifically
not EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID.

> > it is a file containing multiple UEFI binaries which are individually
> > signed and can be loaded as UEFI boottime drivers. Further payloads are
> > passed to the SetImage() method of the EFI_FIRMWARE_MANAGEMENT_PROTOCOL.
> >
> > Two ways for the delivery of a capsule are defined.

Three, I think?  I'm not seeing why an application can't also call
FMP->SetImage() to do this when it's present.  I'm not sure it's worth
supporting at all, though.

> > Capsules can be delivered by placing a file in the
> > \EFI\UpdateCapsule directory or by calling the UpdateCapsule() boot
> > service. The UpdateCapsule() boot service can either be implemented
> > as available at boottime only or as a full runtime service.

Right now in fwupd we support only boot-service calls to do this,
because of the history of bugs with SetVirtualAddressMap() and
ExitBootServices(), and because it's the only thing required to be
tested for Windows logo cert.  I suspect MS has made that the case
because of the exact same bugs.

The path-based mechanism makes a lot of sense with EBBR, but runtime
UpdateCapsule() is a lot more viable here than on the desktop or
servers as well.  The reason I say that is because with these devices
we're more in a situation where the hardware vendor is likely to be
producing the kernel as well, so there's a better integration testing
story here.

-- 
  Peter

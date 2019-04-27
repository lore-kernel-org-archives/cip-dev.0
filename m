From: agraf@csgraf.de (Alexander Graf)
Date: Sat, 27 Apr 2019 09:56:08 +0200
Subject: [cip-dev] EFIBootGuard for CIP and SecureBoot
In-Reply-To: <f75d46c2-d8f3-42f9-f3d6-6786d3147c1d@gmx.de>
References: <OSAPR01MB37639B3931B3AA6A9765099BD03E0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<20190426083106.643evxbnzkxyhqsy@MD1ZFJVC.ad001.siemens.net>
	<CAHFG_=VQigOtWZRiRy=zMVSb1BpfFNyVa3dnGfn=fBQW-KjGMA@mail.gmail.com>
	<ad933d6b-86ae-bbad-9138-730cb71849e4@siemens.com>
	<dc1dd410-08d4-334b-4a9d-acad8283ab19@arm.com>
	<b62f89d8-284d-66d4-4156-3079f058d8aa@siemens.com>
	<f75d46c2-d8f3-42f9-f3d6-6786d3147c1d@gmx.de>
Message-ID: <8bfa74c6-fd58-c1c0-d327-2dbe22463f84@csgraf.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


On 26.04.19 15:46, Heinrich Schuchardt wrote:
>
> On 4/26/19 1:21 PM, Jan Kiszka wrote:
>> On 26.04.19 12:21, Grant Likely wrote:
>>> On 26/04/2019 10:49, Jan Kiszka wrote:
>>>> On 26.04.19 11:07, Francois Ozog wrote:
>>> [...]
>>>>> Here are the guiding principles of our efforts :
>>>>> 0) we want a cross architecture (x86/Arm/...), cross vendor and cross
>>>>> processor model update solution
>>>>> 1) untrusted world cannot update trusted world
>>>> Conceptually, it can. It's a matter of validating the update by the
>>>> trusted world before using it. A trusted instance can allow an untrusted
>>>> one to write version 2, validate that before switching to it, and stick
>>>> with version 1 if that fails.
>>>>
>>>>> 2) what the UEFI implementation does with the capsule is platform
>>>>> specific
>>>>> 3) the update capsule payload is opaque
>>>>>
>>>>> 1) is a "philosophy" decision. When you have a root of trust down to
>>>>> the operating system. So in theory everything should be fine. But the
>>>>> attack surface is such that we can't rule out hacking (and history
>>>>> prove this is unfortunately a safe assumption). In addition, there may
>>>>> be liability aspects related to the who does the update: the hardware
>>>>> platform administrator may not be the legal entity than the operating
>>>>> system administrator. For instance:
>>>>> -? on Packet.net could, a customer can flash up to the BL33 untrusted
>>>>> firmware but that is all.
>>>>> - A surveillance camera can be operated by city personnel but only law
>>>>> enforcement agency can see raw video (un-blurred faces and licence
>>>>> plates). This can be implemented by a derivative of OPTEE SecureMedia
>>>>> Path but if you allow untrusted world to update the trusted one, city
>>>>> personnel can overcome the legal restriction.
>>>>> With 1) this means that even U-Boot code shall not be able/allowed to
>>>>> update S-EL3 firmware (be it Trusted Firmware A or something else),
>>>>> Secure EL1/0 software (OPTEE and its applications or something else).
>>>>> If possible, allowing the operating system administrator to
>>>>> selectively (BL33 is OK but not S-EL3) update firmware is at least
>>>>> platform dependent. Hence defeats 0)
>>>>>
>>>>> With 2) we do not impose reboot to update. Some platform may impose
>>>>> reboot or some designers will prefer reboot. We say that there is a
>>>>> chain of responsibility for updates.
>>>>> So it is perfectly OK to have a Linux software agent receive an update
>>>>> by any mean (network, USB, serial...). The agent will pack this (or
>>>>> those) into a capsule and push it to UEFI implementation.
>>>>> The UEFI implementation (U-Boot or Tianocore) will then do whatever it
>>>>> pleases for the update providing it complies with 1) So the UEFI
>>>>> implementation can live update up to BL33 firmware.
>>>>> Should the update be targeted to secure world, then the UEFI
>>>>> implementation can pass it to S-EL3 for update (platform specific)
>>>>> which means the update can also be live. It is a designer decision.
>>>>>
>>>>> With 3) we have flexibility but sometimes too much flexibility is a
>>>>> problem. Alexander Graf suggested we can use a FIT object to pass
>>>>> diverse objects. It is "half" opaque but I really like the idea.
>>>>> The contents of individual FIT components can be blocks to be placed
>>>>> at a fix location in a NOR flash or a file, no importance.
>>>>>
>>>>> What do everyone think about those design principles ?
>>>>>
>>>> UEFI and capsules can be fine for those platform that support it (and
>>>> it's still a rare feature) and for stuff like boot and peripheral
>>>> firmware. I don't think it's a wise, future-proof idea to use it for
>>>> more.
>>>>
>>>> UEFI is not a very healthy ecosystem yet, and I'm personally skeptical
>>>> it will evolve towards that (looking at that as both a user as well as
>>>> an OEM). It's not even present in quite a few of our use cases. In some
>>>> it will never be - think of safety-critical system: not affordable with
>>>> such a complex approach like UEFI.
>>> Can I challenge that view a bit? On the Tianocore side I agree that the
>>> ecosystem isn't very healthy. That project in particular struggles with
>>> what to do with board support, having decided early on that board
>>> support generally doesn't need to be in the main repository.
>>>
>>> However, U-Boot support for the UEFI ABI is improving in leaps and
>>> bounds. SUSE and Fedora both depend on U-Boot UEFI for booting on all
>>> the Arm SBCs that they support, and enabling UEFI in U-Boot is just a
>>> config option or two. There is a fair bit of encouragement from within
>>> the project to enable UEFI by default.
>> I don't disagree that this aspect is a step forward (though pulling in
>> things redundant code via grub & Co is not really progress). But a Unix
>> community would have probably designed a technically more elegant
>> solution on a green field than the clumsy, legacy-based UEFI interfaces.
>>
>>> UEFI gets a bad rap at being complicated, but I think the U-Boot work
>>> has shown that implementing the core UEFI ABI doesn't require much code
>>> and isn't the complicated mess they everyone fears it to be.
>> Depends on how much you start to rely on UEFI features.
> The format for a UEFI capsule is described in the
> EFI_FIRMWARE_MANAGEMENT_PROTOCOL chapter of the UEFI spec. Essentially


Are you sure? I thought that protocol was about other devices in the
system, not the main firmware. It also seems to be optional - so we
could just have a board specific function to implement CapsuleUpdate,
but no cruft for all the other bits in the spec.

That's where the idea came from to just put a fit image into the capsule
body (set CapsuleGUID to a newly defined FIT-GUID). With that, we could
share a lot of code inside of U-Boot, as DT parsing is already there. We
could then have individual segments, that can either be data or command
payloads and thus a capsule update could basically just be a few data
segments with a U-Boot script.


> it is a file containing multiple UEFI binaries which are individually
> signed and can be loaded as UEFI boottime drivers. Further payloads are
> passed to the SetImage() method of the EFI_FIRMWARE_MANAGEMENT_PROTOCOL.
>
> Two ways for the delivery of a capsule are defined. Capsules can be
> delivered by placing a file in the \EFI\UpdateCapsule directory or by
> calling the UpdateCapsule() boot service. The UpdateCapsule() boot
> service can either be implemented as available at boottime only or as a
> full runtime service.
>
> The development target that we have defined for U-Boot is to reach
> conformance to the Embedded Base Boot Requirements (EBBR) specification.
> EBBR 1.0 does not mandate implementing update via UEFI capsules.


Correct, this is about post-1.0 :).


> In U-Boot we have severe size limitations. On many boards U-Boot has to
> fit into 512 kB. So I think we should not link the capsule update
> functionality into the main U-Boot binary.
>
> The implementation of the EFI_FIRMWARE_MANAGEMENT_PROTOCOL will be
> device specific. So if you are interested in adding capsule support I
> think it should be provided as a device specific UEFI driver that can be
> loaded by U-Boot.
>
> Currently loading and unloading of drivers is not fully implemented in
> U-Boot. But it is on my agenda.


One of the things I love about U-Boot is that it's monolithic :). As an
end user, it means that I get something and it just contains everything
I need. Imagine a world where you first have to load your driver to
update your firmware from some arbitrary storage. It would create a huge
mess.


Alex

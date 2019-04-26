From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Fri, 26 Apr 2019 15:46:38 +0200
Subject: [cip-dev] EFIBootGuard for CIP and SecureBoot
In-Reply-To: <b62f89d8-284d-66d4-4156-3079f058d8aa@siemens.com>
References: <OSAPR01MB37639B3931B3AA6A9765099BD03E0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<20190426083106.643evxbnzkxyhqsy@MD1ZFJVC.ad001.siemens.net>
	<CAHFG_=VQigOtWZRiRy=zMVSb1BpfFNyVa3dnGfn=fBQW-KjGMA@mail.gmail.com>
	<ad933d6b-86ae-bbad-9138-730cb71849e4@siemens.com>
	<dc1dd410-08d4-334b-4a9d-acad8283ab19@arm.com>
	<b62f89d8-284d-66d4-4156-3079f058d8aa@siemens.com>
Message-ID: <f75d46c2-d8f3-42f9-f3d6-6786d3147c1d@gmx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



On 4/26/19 1:21 PM, Jan Kiszka wrote:
> On 26.04.19 12:21, Grant Likely wrote:
>> On 26/04/2019 10:49, Jan Kiszka wrote:
>>> On 26.04.19 11:07, Francois Ozog wrote:
>> [...]
>>>> Here are the guiding principles of our efforts :
>>>> 0) we want a cross architecture (x86/Arm/...), cross vendor and cross
>>>> processor model update solution
>>>> 1) untrusted world cannot update trusted world
>>>
>>> Conceptually, it can. It's a matter of validating the update by the
>>> trusted world before using it. A trusted instance can allow an untrusted
>>> one to write version 2, validate that before switching to it, and stick
>>> with version 1 if that fails.
>>>
>>>> 2) what the UEFI implementation does with the capsule is platform
>>>> specific
>>>> 3) the update capsule payload is opaque
>>>>
>>>> 1) is a "philosophy" decision. When you have a root of trust down to
>>>> the operating system. So in theory everything should be fine. But the
>>>> attack surface is such that we can't rule out hacking (and history
>>>> prove this is unfortunately a safe assumption). In addition, there may
>>>> be liability aspects related to the who does the update: the hardware
>>>> platform administrator may not be the legal entity than the operating
>>>> system administrator. For instance:
>>>> -? on Packet.net could, a customer can flash up to the BL33 untrusted
>>>> firmware but that is all.
>>>> - A surveillance camera can be operated by city personnel but only law
>>>> enforcement agency can see raw video (un-blurred faces and licence
>>>> plates). This can be implemented by a derivative of OPTEE SecureMedia
>>>> Path but if you allow untrusted world to update the trusted one, city
>>>> personnel can overcome the legal restriction.
>>>> With 1) this means that even U-Boot code shall not be able/allowed to
>>>> update S-EL3 firmware (be it Trusted Firmware A or something else),
>>>> Secure EL1/0 software (OPTEE and its applications or something else).
>>>> If possible, allowing the operating system administrator to
>>>> selectively (BL33 is OK but not S-EL3) update firmware is at least
>>>> platform dependent. Hence defeats 0)
>>>>
>>>> With 2) we do not impose reboot to update. Some platform may impose
>>>> reboot or some designers will prefer reboot. We say that there is a
>>>> chain of responsibility for updates.
>>>> So it is perfectly OK to have a Linux software agent receive an update
>>>> by any mean (network, USB, serial...). The agent will pack this (or
>>>> those) into a capsule and push it to UEFI implementation.
>>>> The UEFI implementation (U-Boot or Tianocore) will then do whatever it
>>>> pleases for the update providing it complies with 1) So the UEFI
>>>> implementation can live update up to BL33 firmware.
>>>> Should the update be targeted to secure world, then the UEFI
>>>> implementation can pass it to S-EL3 for update (platform specific)
>>>> which means the update can also be live. It is a designer decision.
>>>>
>>>> With 3) we have flexibility but sometimes too much flexibility is a
>>>> problem. Alexander Graf suggested we can use a FIT object to pass
>>>> diverse objects. It is "half" opaque but I really like the idea.
>>>> The contents of individual FIT components can be blocks to be placed
>>>> at a fix location in a NOR flash or a file, no importance.
>>>>
>>>> What do everyone think about those design principles ?
>>>>
>>>
>>> UEFI and capsules can be fine for those platform that support it (and
>>> it's still a rare feature) and for stuff like boot and peripheral
>>> firmware. I don't think it's a wise, future-proof idea to use it for
>>> more.
>>>
>>> UEFI is not a very healthy ecosystem yet, and I'm personally skeptical
>>> it will evolve towards that (looking at that as both a user as well as
>>> an OEM). It's not even present in quite a few of our use cases. In some
>>> it will never be - think of safety-critical system: not affordable with
>>> such a complex approach like UEFI.
>>
>> Can I challenge that view a bit? On the Tianocore side I agree that the
>> ecosystem isn't very healthy. That project in particular struggles with
>> what to do with board support, having decided early on that board
>> support generally doesn't need to be in the main repository.
>>
>> However, U-Boot support for the UEFI ABI is improving in leaps and
>> bounds. SUSE and Fedora both depend on U-Boot UEFI for booting on all
>> the Arm SBCs that they support, and enabling UEFI in U-Boot is just a
>> config option or two. There is a fair bit of encouragement from within
>> the project to enable UEFI by default.
>
> I don't disagree that this aspect is a step forward (though pulling in
> things redundant code via grub & Co is not really progress). But a Unix
> community would have probably designed a technically more elegant
> solution on a green field than the clumsy, legacy-based UEFI interfaces.
>
>>
>> UEFI gets a bad rap at being complicated, but I think the U-Boot work
>> has shown that implementing the core UEFI ABI doesn't require much code
>> and isn't the complicated mess they everyone fears it to be.
>
> Depends on how much you start to rely on UEFI features.

The format for a UEFI capsule is described in the
EFI_FIRMWARE_MANAGEMENT_PROTOCOL chapter of the UEFI spec. Essentially
it is a file containing multiple UEFI binaries which are individually
signed and can be loaded as UEFI boottime drivers. Further payloads are
passed to the SetImage() method of the EFI_FIRMWARE_MANAGEMENT_PROTOCOL.

Two ways for the delivery of a capsule are defined. Capsules can be
delivered by placing a file in the \EFI\UpdateCapsule directory or by
calling the UpdateCapsule() boot service. The UpdateCapsule() boot
service can either be implemented as available at boottime only or as a
full runtime service.

The development target that we have defined for U-Boot is to reach
conformance to the Embedded Base Boot Requirements (EBBR) specification.
EBBR 1.0 does not mandate implementing update via UEFI capsules.

In U-Boot we have severe size limitations. On many boards U-Boot has to
fit into 512 kB. So I think we should not link the capsule update
functionality into the main U-Boot binary.

The implementation of the EFI_FIRMWARE_MANAGEMENT_PROTOCOL will be
device specific. So if you are interested in adding capsule support I
think it should be provided as a device specific UEFI driver that can be
loaded by U-Boot.

Currently loading and unloading of drivers is not fully implemented in
U-Boot. But it is on my agenda.

Best regards

Heinrich

>
>>
>> I don't see the conflict with safety critical for boot services. I can
>
> Everything is certifiable - with infinite time and money. So you will
> likely reduce the boot process to the very essential of your concrete
> system, removing then unneeded abstractions and stages. Or you will find
> ways to eliminate that from your argumentation, which would definitely
> include removing runtime services.
>
>> however see the arguement against UEFI runtime services as a poor
>> implementation could result in unbounded execution times. There's been
>> recent movement on the UEFI spec to make runtime services optional, and
>> in U-Boot they are mostly empty stubs.
>
> Of course, it also depends on how much you need from UEFI to boot or to
> use certain services like capsule updates (and which would be gone when
> you remove runtime services).
>
>>
>>> It should not expand further into OS
>>> domains. Updating complete filesystems and their content is beyond its
>>> duties. We have all the required, tested, matured means for the OS in
>>> the OS. For firmware, it can be an option - if that firmware is UEFI
>>> compliant, with all needed options.
>>
>> Here I agree 100%. Capsule update is a useful ABI for the OS to pass
>> firmware update blobs without needing to know specifics about the
>> platform, but everything from the kernel on up is out of scope.
>
> OK, that's good.
>
>>
>>> So let's use UEFI and capsules as a one possible building block in the
>>> design, but not as the cornerstone. Just like we do mandate that all
>>> updates must be served and managed by our IoT cloud ;).
>>
>> What do the firmware stacks in your projects look like? What percentage
>> are based on U-Boot? Littlekernel? Others?
>
> I don't have absolute numbers. We have a lot of "standard" x86 UEFI
> systems, many U-boot devices (of which, to my knowledge, none is on UEFI
> yet - no surprise, that feature is still too "new"), and quite a few
> Coreboot designs (so far only x86) that just need to load Linux and
> bypass a lot therefore. There will likely be more exotic things but they
> will likely also do not deserve attention.
>
>>
>> UEFI has the advantage that it has a defined ABI, and only a small
>> amount of it needs to be implemented to execute UEFI OS loaders (ie. the
>> Linux UEFI stub). For the reference platform, I think it makes sense to
>> make the design decision that firmware provides UEFI, and the update
>> infrastructure is based on that. However, if UEFI doesn't work for a
>> particular stack/project then it can be swapped out. There will need to
>> be work done on the boot sequence, but all the rest of the OS stack is
>> still relevant.
>
> Yes, I would design it in a way that a perfect UEFI implementation can
> take a lot of boot-related tasks like safe boot configuration switching,
> watchdog management, firmware and peripheral updating (possibly in
> lock-step with the OS) etc. But I would always ensure that incomplete or
> immature UEFI implementations will not complicate partial or complete
> replacements. Because the latter will remain the default for quite a
> while, if not longer, I'm sure. UEFI should not become the systemd of
> unattended device updates (or worse, due to closed implementations).
>
> Jan
>

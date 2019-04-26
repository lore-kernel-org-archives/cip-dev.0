From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 26 Apr 2019 11:49:47 +0200
Subject: [cip-dev] EFIBootGuard for CIP and SecureBoot
In-Reply-To: <CAHFG_=VQigOtWZRiRy=zMVSb1BpfFNyVa3dnGfn=fBQW-KjGMA@mail.gmail.com>
References: <OSAPR01MB37639B3931B3AA6A9765099BD03E0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<20190426083106.643evxbnzkxyhqsy@MD1ZFJVC.ad001.siemens.net>
	<CAHFG_=VQigOtWZRiRy=zMVSb1BpfFNyVa3dnGfn=fBQW-KjGMA@mail.gmail.com>
Message-ID: <ad933d6b-86ae-bbad-9138-730cb71849e4@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 26.04.19 11:07, Francois Ozog wrote:
> On Fri, 26 Apr 2019 at 10:30, Christian Storm
> <christian.storm@siemens.com> wrote:
>>
>> Hi,
>>
>>>>> Background: during the last Linaro connect in Bangkok I was told
>>>>> that Linaro Edge (LEDGE) were working on a secure software update
>>>>> mechanism based on UEFI capsules that would flash firmware updates
>>>>> from a UEFI application, instead of using a Linux agent such as
>>>>> SWUpdate.
>>>>
>>>> How would capsules help with writing to arbitrary storage, updating
>>>> only files on filesystem, reducing the update size (binary diffs),
>>>> or talking to the cloud?
>>>
> 
> See below
>>
>>> - arbitrary storage: I guess they can only write to what is supported
>>>    by the machine's UEFI implementation.
>>>
> 
> Yes, see below
>>
>>> - updating only files on filesystem: I assume this is out of scope in
>>>    their architecture (Francois: do you want to support file-based
>>>    updates or only block-based ones?)
>>
> Both, see below
>>
>>> - reducing the update size (binary diffs), or talking to the cloud:
>>>    they will do that from non-secure Linux. It would be dangerous to use
>>>    a fragile network stack from an UEFI application or the secure world.
>>>    In that sense, they also need a Linux agent.
>>
>> If I understand the idea correctly, there's then a Linux companion agent
>> that does, e.g., the cloud communication and sets up the update payload
>> to be consumed and applied by the UEFI firmware update application. The
>> actual update action will take place on reboot, e.g., flashing the
>> inactive partition in an A/B setup and thereafter booting into the newly
>> flashed, then active partition.
>>
>> If so, this would prolong the time the system is unavailable due to disk
>> flashing I/O in the UEFI firmware update application compared to flashing
>> the inactive partition from within Linux and have the bootloader just
>> switch the to be booted partitions.
>>
>> Generally, but in particular regarding binary diffs, a binary diff
>> application mechanism would have to be implemented and maintained in the
>> UEFI realm as opposed to "just" using the respective shared libraries
>> (e.g. librsync, casync, ...) in the Linux realm. Granted, one could
>> come up with a unified format to which the output of, e.g, librsync's rdiff
>> or a casync run is converted but nonetheless, this creates some porting/
>> implementation and maintenance effort.
>>
>>
> Here are the guiding principles of our efforts :
> 0) we want a cross architecture (x86/Arm/...), cross vendor and cross
> processor model update solution
> 1) untrusted world cannot update trusted world

Conceptually, it can. It's a matter of validating the update by the trusted 
world before using it. A trusted instance can allow an untrusted one to write 
version 2, validate that before switching to it, and stick with version 1 if 
that fails.

> 2) what the UEFI implementation does with the capsule is platform specific
> 3) the update capsule payload is opaque
> 
> 1) is a "philosophy" decision. When you have a root of trust down to
> the operating system. So in theory everything should be fine. But the
> attack surface is such that we can't rule out hacking (and history
> prove this is unfortunately a safe assumption). In addition, there may
> be liability aspects related to the who does the update: the hardware
> platform administrator may not be the legal entity than the operating
> system administrator. For instance:
> -  on Packet.net could, a customer can flash up to the BL33 untrusted
> firmware but that is all.
> - A surveillance camera can be operated by city personnel but only law
> enforcement agency can see raw video (un-blurred faces and licence
> plates). This can be implemented by a derivative of OPTEE SecureMedia
> Path but if you allow untrusted world to update the trusted one, city
> personnel can overcome the legal restriction.
> With 1) this means that even U-Boot code shall not be able/allowed to
> update S-EL3 firmware (be it Trusted Firmware A or something else),
> Secure EL1/0 software (OPTEE and its applications or something else).
> If possible, allowing the operating system administrator to
> selectively (BL33 is OK but not S-EL3) update firmware is at least
> platform dependent. Hence defeats 0)
> 
> With 2) we do not impose reboot to update. Some platform may impose
> reboot or some designers will prefer reboot. We say that there is a
> chain of responsibility for updates.
> So it is perfectly OK to have a Linux software agent receive an update
> by any mean (network, USB, serial...). The agent will pack this (or
> those) into a capsule and push it to UEFI implementation.
> The UEFI implementation (U-Boot or Tianocore) will then do whatever it
> pleases for the update providing it complies with 1) So the UEFI
> implementation can live update up to BL33 firmware.
> Should the update be targeted to secure world, then the UEFI
> implementation can pass it to S-EL3 for update (platform specific)
> which means the update can also be live. It is a designer decision.
> 
> With 3) we have flexibility but sometimes too much flexibility is a
> problem. Alexander Graf suggested we can use a FIT object to pass
> diverse objects. It is "half" opaque but I really like the idea.
> The contents of individual FIT components can be blocks to be placed
> at a fix location in a NOR flash or a file, no importance.
> 
> What do everyone think about those design principles ?
> 

UEFI and capsules can be fine for those platform that support it (and it's still 
a rare feature) and for stuff like boot and peripheral firmware. I don't think 
it's a wise, future-proof idea to use it for more.

UEFI is not a very healthy ecosystem yet, and I'm personally skeptical it will 
evolve towards that (looking at that as both a user as well as an OEM). It's not 
even present in quite a few of our use cases. In some it will never be - think 
of safety-critical system: not affordable with such a complex approach like 
UEFI. It should not expand further into OS domains. Updating complete 
filesystems and their content is beyond its duties. We have all the required, 
tested, matured means for the OS in the OS. For firmware, it can be an option - 
if that firmware is UEFI compliant, with all needed options.

So let's use UEFI and capsules as a one possible building block in the design, 
but not as the cornerstone. Just like we do mandate that all updates must be 
served and managed by our IoT cloud ;).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

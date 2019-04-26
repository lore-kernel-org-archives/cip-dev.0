From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Fri, 26 Apr 2019 04:49:41 +0000
Subject: [cip-dev] EFIBootGuard for CIP and SecureBoot
In-Reply-To: <26998f72-94f6-894f-f095-16e752572b6b@siemens.com>
References: <CAHFG_=Ujd5m3uSq87MuiK-7HWM379GoJjTQ3HMvk_m8V0gzqMg@mail.gmail.com>
	<20190422175446.GO4664@bill-the-cat>
	<OSAPR01MB3763A83FABF505EC4E0A5534D03C0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<26998f72-94f6-894f-f095-16e752572b6b@siemens.com>
Message-ID: <OSAPR01MB37639B3931B3AA6A9765099BD03E0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan, Francois:

Grant: thanks!

> From: Jan Kiszka <jan.kiszka@siemens.com>
> On 24.04.19 03:23, daniel.sangorrin at toshiba.co.jp wrote:
> > Hello Francois, Jan, Christian, and all
> >  EFI Boot Guard is now shipped in quite a few devices, to my knowledge not only at
> > Sorry for the late reply, I was waiting for the administrator of the Boot Architecture mailing list to accept my
> subscription request, but it seems it will take a bit more time. I will send this reply and hope it will not be blocked.
> I have also added the u-boot mailing list to Cc, as Tom suggested (although I'm not a member), the CIP mailing
> list, Jan Kiszka (one of the main developers of Efibootguard) and Christian (an expert in software updates).
> >
> > Background: during the last Linaro connect in Bangkok I was told that Linaro Edge (LEDGE) were working on
> a secure software update mechanism based on UEFI capsules that would flash firmware updates from a UEFI
> application, instead of using a Linux agent such as SWUpdate.
> 
> How would capsules help with writing to arbitrary storage, updating only files
> on filesystem, reducing the update size (binary diffs), or talking to the cloud?

- arbitrary storage: I guess they can only write to what is supported by the machine's UEFI implementation.
- updating only files on filesystem: I assume this is out of scope in their architecture (Francois: do you want to support file-based updates or only block-based ones?)
- reducing the update size (binary diffs), or talking to the cloud: they will do that from non-secure Linux. It would be dangerous to use a fragile network stack from an UEFI application or the secure world. In that sense, they also need a Linux agent.

I believe that LEDGE is looking for a software update method that works the same on any machine (that supports UEFI). To do that they want to use the UEFI interfaces/services. They also want the ability to update the TrustZone secure world (you can't do that unless you have enough privileges).

> > As far as I know, there is no concept of "Secure Booting" in Efibootguard at the moment. Adding signature
> checks before booting into the selected kernel would be a possible solution.
> 
> Secure boot is a pending feature on our to-do list. It's a bit more complicated
> than that, like secure boot is "a bit" more complicated than you think once you
> actually try to implement it. Once we do that, it's really about adding
> signature checks or relying on UEFI validating the payloads we boot for us PLUS
> ensuring the our config sections can either be validated (despite being
> volatile) or split the security-wise critical parts (specifically EFI payload
> parameters) from the less critical ones (update states) and remove the latter
> from the validation.

I suppose that those "bits" are hard to predict until you start the implementation. From an architectural point of view, I guess that the "revision" variables will need to be secured to avoid downgrades (e.g. an attacker causing a rollback to a previous revision of the OS image). 

> BTW, what we do in EFI Board Guard could also be done in any other UEFI
> bootloader, may it be grub (if you like to use that complex and fragile beast in
> production), systemd-boot or even TianoCore. But for now, it was easier - and
> more robust - to add our requirements in form of this tiny bootloader to the
> ecosystem. EFI Boot Guard is now shipped in quite a few devices, to my best
> knowledge not only at Siemens.

Jan: do you have a schedule or a list of tasks that need to be done?
Francois: what direction should we take from here?

Thanks,
Daniel

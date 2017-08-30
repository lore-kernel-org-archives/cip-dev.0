From: minmin@plathome.co.jp (Masato Minda)
Date: Wed, 30 Aug 2017 15:01:30 +0900
Subject: [cip-dev] Kernel feature support - core features and debugging
In-Reply-To: <1500652489.12197.162.camel@codethink.co.uk>
References: <1500652489.12197.162.camel@codethink.co.uk>
Message-ID: <efc17a0c-ef13-4a04-f5a1-377cfa4134e0@plathome.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Ben,

Sorry for late reply. I checked with our development team. And, I got reply from them.

Here is from our team too.

minmin

On 2017/07/22 0:54, Ben Hutchings wrote:
>
> This is the third and last part.? There are actually a few features that
> I'm recommending to *enable* here.
>
> All the configs I was given *disable* the stack protector
> (CONFIG_CC_STACKPROTECTOR_NONE enabled).? Please enable
> CONFIG_CC_STACKPROTECTOR_REGULAR or CONFIG_CC_STACKPROTECTOR_STRONG
> instead.
>
> Some configs disable heap randomisation (CONFIG_COMPAT_BRK enabled), but
> this is only necessary for old C libraries and it weakens.? Please
> enable heap randomisation by default, i.e. disable CONFIG_COMPAT_BRK.
>
> Module symbol versioning (CONFIG_MODVERSIONS) is disabled in some
> configs.? Consider enabling it in order to catch mistakes.
>
> Performance events (CONFIG_PERF_EVENTS) provide a significant attack
> surface and generally allow unprivileged users to crash the system.? If
> you do need them enabled in production - which I can understand - you
> might want to apply the Grsecurity/Debian/Android patch that disables
> use by unprivileged users.
>
> Obsolete syscalls (CONFIG_SGETMASK_SYSCALL, CONFIG_SYSCTL_SYSCALL,
> CONFIG_SYSFS_SYSCALL, CONFIG_UID16, CONFIG_USELIB) are enabled in some
> configs.? Consider disabling these.
>
> Deprecated sysfs entries (CONFIG_SYSFS_DEPRECATED,
> CONFIG_SYSFS_DEPRECATED_V2) are enabled in the toshiba powerpc config.
> This is incompatible with current udev and other tools.? Please disable
> them.
>
> User namespaces (CONFIG_USER_NS) open up a huge attack surface to
> unprivileged users, which has resulted in a large number of privilege
> escalation vulnerabilities.? This is enabled in the plathome_obsvx1,
> siemens_iot2000 and siemens_server configs.? Do you need it?

O.K. I understand to disable.
?
> Magic Sysrq (CONFIG_MAGIC_SYSRQ) can leak sensitive information if it's
> possible for an untrusted user to invoke it.? Consider setting
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x01b6 (this is what Debian uses) or
> some other restrictive mask for production builds.
>
> Linked list debug checks (CONFIG_LIST_DEBUG) are disabled in all
> configs.? Consider enabling them as these can make it harder to exploit
> some bugs.
>
> Kernel timer statistics (CONFIG_TIMER_STATS) have been removed upstream,
> but are enabled in toshiba_zynq and plathome_obsvx1 configs.? Apparently
> there are tracepoints that provide similar functionality.? Please
> disable this.

O.K. I understand to disable.

> Kernel shared memory (CONFIG_KSM) has an inherent security problem that
> the merging of memory introduces a timing side-channel between VMs.? On
> systems vulnerable to Rowhammer, it can also be used to *modify* memory
> belonging to other VMs.? This is enabled in the toshiba_tegra,
> plathome_obsvx1 and siemens_server configs.? Please consider disabling
> it.

O.K. I understand to disable.

> --
> Ben Hutchings
> Software Developer, Codethink Ltd.

--
Masato Minda <minmin@plathome.co.jp>
Plat'Home Co., Ltd.

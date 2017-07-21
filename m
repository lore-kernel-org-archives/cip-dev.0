From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 21 Jul 2017 19:27:45 +0200
Subject: [cip-dev] Kernel feature support - architecture options and
 drivers
In-Reply-To: <1500657071.12197.183.camel@codethink.co.uk>
References: <1500643130.12197.123.camel@codethink.co.uk>
	<2b838876-3237-ab6f-4377-0bbbdc7c6e65@siemens.com>
	<1500657071.12197.183.camel@codethink.co.uk>
Message-ID: <3d4184ca-8f5b-c855-e47e-dbe932cbe2dc@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-07-21 19:11, Ben Hutchings wrote:
> On Fri, 2017-07-21 at 17:19 +0200, Jan Kiszka wrote:
>> On 2017-07-21 15:18, Ben Hutchings wrote:
>>> Intel Quark support (CONFIG_X86_INTEL_QUARK) is enabled in the
>>> siemens_iot2000 config.  Are you really using Quark SoCs?
>>
>> Yeah...
>> http://w3.siemens.com/mcms/pc-based-automation/en/industrial-iot/pages/default.aspx.
>> This revision will stop being shipped at latest in 2020, but there will
>> be a lot of these chips in the field until then.
>>
>> Likely all needed patches will be in 4.13 (just still struggling to get
>> userspace software ported from the Intel BSP to mainline). So I'm
>> planning to submit the essential patches for CIP integration "soon".
> 
> I assume you're aware of erratum #24 affecting the LOCK prefix?  There
> seems to be no solution except to use Intel's forked version of binutils
> which deletes the LOCK prefix.

That switch is even upstream. But, yeah, we need to rebuild everything
in userland from scratch and can't use, e.g., normal Debian packages.
For the next version, we software folks will be involved now.

>  I don't know if it's an issue for kernel
> code, but probably not - the kernel shouldn't use LOCK if CONFIG_SMP is
> not enabled, and in any case shouldn't get a page fault on such an
> instruction..

Exactly, the kernel is fine as-is.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

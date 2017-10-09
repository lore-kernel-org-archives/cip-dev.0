From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 9 Oct 2017 17:26:37 +0200
Subject: [cip-dev] [PATCH 00/10] Backport of watchdog core triggered
 keepalive infrastructure
In-Reply-To: <1507561248.26687.26.camel@codethink.co.uk>
References: <20171004144104.14403-1-mosipov@ilbers.de>
	<1507561248.26687.26.camel@codethink.co.uk>
Message-ID: <77be825b-9aaf-d8e1-5d1d-7907678e2bec@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-10-09 17:00, Ben Hutchings wrote:
> On Wed, 2017-10-04 at 16:40 +0200, Maxim Yu. Osipov wrote:
>> Hello Ben,
>>
>> This series contains 
>>
>> * backport of patches of watchdog core infrastructure 
>> supporting handling watchdog keepalive. 
>>
>> * imx21_wdt converted to use infrastructure triggered keepalives.
>>
>> * backported support of WATCHDOG_HANDLE_BOOT_ENABLED option 
> [...]
> 
> Are you working for Siemens on this?  Can you provide the config you are
> using?

Yes, Maxim is working for a project of us, and I asked him to propose
these backports for CIP. They will likely become relevant for other
boards as well because the bootloader-started watchdog is a cornerstone
of safe system updates.

> 
> The reason I ask is that CIP kernel branches will have hardware support
> limited to the needs of members.  Currently, none of the kernel
> configurations I collected enable CONFIG_IMX2_WDT, or even
> CONFIG_ARCH_MXC, which implies that imx2_wdt won't be supported.

Yeah, this config wasn't included in the set I sent back then. Maxim,
please provide it to Ben. We are in the process of migrating to the CIP
kernel right now.

Thanks,
Jan
-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

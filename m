From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Mon, 09 Oct 2017 16:00:48 +0100
Subject: [cip-dev] [PATCH 00/10] Backport of watchdog core triggered
 keepalive infrastructure
In-Reply-To: <20171004144104.14403-1-mosipov@ilbers.de>
References: <20171004144104.14403-1-mosipov@ilbers.de>
Message-ID: <1507561248.26687.26.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2017-10-04 at 16:40 +0200, Maxim Yu. Osipov wrote:
> Hello Ben,
> 
> This series contains 
> 
> * backport of patches of watchdog core infrastructure 
> supporting handling watchdog keepalive. 
> 
> * imx21_wdt converted to use infrastructure triggered keepalives.
>
> * backported support of WATCHDOG_HANDLE_BOOT_ENABLED option 
[...]

Are you working for Siemens on this?  Can you provide the config you are
using?

The reason I ask is that CIP kernel branches will have hardware support
limited to the needs of members.  Currently, none of the kernel
configurations I collected enable CONFIG_IMX2_WDT, or even
CONFIG_ARCH_MXC, which implies that imx2_wdt won't be supported.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.

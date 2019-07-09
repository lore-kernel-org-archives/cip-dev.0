From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 09 Jul 2019 15:40:43 +0100
Subject: [cip-dev] Kernel configurations for 4.19?
In-Reply-To: <1555501985.3557.26.camel@codethink.co.uk>
References: <1555501985.3557.26.camel@codethink.co.uk>
Message-ID: <9210b0ba912e7a8c64f6562b43f25e4763ac4379.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2019-04-17 at 12:53 +0100, Ben Hutchings wrote:
> Please could members send their kernel configuration files for Linux
> 4.19-cip?  Either send them to the list as attachments, or create merge
> requests for
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-config>;.
> 
> There are already configuration files for 4.19 in cip-kernel-config
> that were produced by automatically updating the 4.4 configurations. 
> Please also let us know which of these can be deleted.

I have received new config files from most members, but no-one told me
if the old configs can be deleted.  For reference, these are the files
we have for 4.19 that are based on those submitted for 4.4:

4.19/arm/hitachi_omap_defconfig
4.19/arm/moxa_mxc_defconfig
4.19/arm/siemens_am335x-axm2_defconfig
4.19/arm/siemens_am335x-draco_defconfig
4.19/arm/siemens_am335x-dxr2_defconfig
4.19/arm/siemens_am335x-etamin_defconfig
4.19/arm/siemens_am57xx-pxm3_defconfig
4.19/arm/toshiba_tegra_defconfig
4.19/arm/toshiba_zynq_defconfig
4.19/powerpc/toshiba_defconfig
4.19/x86/plathome_obsvx1.config
4.19/x86/siemens_i386-rt.config
4.19/x86/siemens_iot2000.config
4.19/x86/siemens_server_defconfig
4.19/x86/toshiba_defconfig

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

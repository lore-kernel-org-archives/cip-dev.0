From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Fri, 12 Jul 2019 00:57:06 +0000
Subject: [cip-dev] Kernel configurations for 4.19?
In-Reply-To: <9210b0ba912e7a8c64f6562b43f25e4763ac4379.camel@codethink.co.uk>
References: <1555501985.3557.26.camel@codethink.co.uk>
	<9210b0ba912e7a8c64f6562b43f25e4763ac4379.camel@codethink.co.uk>
Message-ID: <OSBPR01MB30774E79BB6AE34E75621D82D0F20@OSBPR01MB3077.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

[Note] repeating the reply because I got some rejected mails.

> From: Ben Hutchings
> I have received new config files from most members, but no-one told me
> if the old configs can be deleted.  For reference, these are the files
> we have for 4.19 that are based on those submitted for 4.4:

You can discard the 4.4 old configurations from Toshiba. At the moment, we only need support for this one:
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/blob/master/4.19/x86/toshiba_atom_baytrail_cip.config

[Note] we may send more configuration files in the near future.

Thanks,
Daniel

> 4.19/arm/hitachi_omap_defconfig
> 4.19/arm/moxa_mxc_defconfig
> 4.19/arm/siemens_am335x-axm2_defconfig
> 4.19/arm/siemens_am335x-draco_defconfig
> 4.19/arm/siemens_am335x-dxr2_defconfig
> 4.19/arm/siemens_am335x-etamin_defconfig
> 4.19/arm/siemens_am57xx-pxm3_defconfig
> 4.19/arm/toshiba_tegra_defconfig
> 4.19/arm/toshiba_zynq_defconfig
> 4.19/powerpc/toshiba_defconfig
> 4.19/x86/plathome_obsvx1.config
> 4.19/x86/siemens_i386-rt.config
> 4.19/x86/siemens_iot2000.config
> 4.19/x86/siemens_server_defconfig
> 4.19/x86/toshiba_defconfig
> 
> Ben.
> 
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev

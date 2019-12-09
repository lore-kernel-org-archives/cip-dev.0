From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 9 Dec 2019 21:56:29 +0000
Subject: [cip-dev] Linux 4.19.89-rc1 5944fcdd errors
In-Reply-To: <20191209173637.GF1290729@kroah.com>
References: <TYAPR01MB228505DBC22568339F914C15B7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191209173637.GF1290729@kroah.com>
Message-ID: <TYAPR01MB2285135B15E6A152163E1A1AB7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> From: stable-owner at vger.kernel.org <stable-owner@vger.kernel.org> On
> Behalf Of Greg Kroah-Hartman
> Sent: 09 December 2019 17:37
> 
> On Mon, Dec 09, 2019 at 04:29:22PM +0000, Chris Paterson wrote:
> > 3)
> > Config: arm shmobile_defconfig
> > Link: https://gitlab.com/cip-playground/linux-stable-rc-ci/-
> /jobs/373484089#L2249
> > Probable culprit: 984d7a8bff57 ("pinctrl: sh-pfc: r8a7792: Fix VIN versioned
> groups")
> > Issue log:
> > 2249 drivers/pinctrl/sh-pfc/pfc-r8a7792.c:1750:38: error: macro
> "VIN_DATA_PIN_GROUP" passed 3 arguments, but takes just 2
> > 2250   VIN_DATA_PIN_GROUP(vin1_data, 24, _b),
> > 2251                                       ^
> > 2252 drivers/pinctrl/sh-pfc/pfc-r8a7792.c:1750:2: error:
> 'VIN_DATA_PIN_GROUP' undeclared here (not in a function); did you mean
> 'PIN_MAP_TYPE_MUX_GROUP'?
> > 2253   VIN_DATA_PIN_GROUP(vin1_data, 24, _b),
> > 2254   ^~~~~~~~~~~~~~~~~~
> > 2255   PIN_MAP_TYPE_MUX_GROUP
> > 2256 drivers/pinctrl/sh-pfc/pfc-r8a7792.c:1751:38: error: macro
> "VIN_DATA_PIN_GROUP" passed 3 arguments, but takes just 2
> > 2257   VIN_DATA_PIN_GROUP(vin1_data, 20, _b),
> > 2258                                       ^
> > 2259 drivers/pinctrl/sh-pfc/pfc-r8a7792.c:1753:38: error: macro
> "VIN_DATA_PIN_GROUP" passed 3 arguments, but takes just 2
> > 2260   VIN_DATA_PIN_GROUP(vin1_data, 16, _b),
> > 2261                                       ^
> 
> Now dropped for 4.19, 4.14, and 4.9 (2 patches for 4.19 here.)

Latest 4.19 now building, but I'm seeing a number of warnings and errors when trying to build the arm64 defconfig dtbs.
https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/374092442
arm/juno.dtb
qcom/apq8016-sbc.dtb
arm/juno-r2.dtb
arm/juno-r1.dtb
hisilicon/hi6220-hikey.dtb
allwinner/sun50i-a64-pinebook.dtb
qcom/msm8916-mtp.dtb
qcom/msm8916-mtp.dtb
qcom/sdm845-mtp.dtb

Kind regards, Chris

> 
> thanks,
> 
> greg k-h

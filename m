From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 9 Dec 2019 16:34:45 +0000
Subject: [cip-dev] Linux 4.19.89-rc1 5944fcdd errors
In-Reply-To: <TYAPR01MB228505DBC22568339F914C15B7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB228505DBC22568339F914C15B7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB22851FBD29EBB28CDEA502CAB7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

+cip-dev

Chris

> From: Chris Paterson
> Sent: 09 December 2019 16:29
> 
> Hello Greg, all,
> 
> I've seen a few errors with 4.19.89-rc1 (5944fcdd).
> 
> 1)
> Config: arm64 defconfig
> Link: https://gitlab.com/cip-playground/linux-stable-rc-ci/-
> /jobs/373484093#L267
> Probable culprit: 227b635dcae6 ("bpf, arm64: fix getting subprog addr from
> aux for calls")
> Issue log:
> 267 arch/arm64/net/bpf_jit_comp.c: In function 'build_insn':
> 268 arch/arm64/net/bpf_jit_comp.c:633:9: error: implicit declaration of
> function 'bpf_jit_get_func_addr'; did you mean 'bpf_jit_binary_hdr'? [-
> Werror=implicit-function-declaration]
> 269    ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
> 270          ^~~~~~~~~~~~~~~~~~~~~
> 271          bpf_jit_binary_hdr
> 
> 
> 2)
> Config: arm multi_v7_defconfig
> Link: https://gitlab.com/cip-playground/linux-stable-rc-ci/-
> /jobs/373484091#L2147
> Probable culprit: 192929fd944d ("dmaengine: xilinx_dma: Fix 64-bit simple
> CDMA transfer")
> Issue log:
> 2147 drivers/dma/xilinx/xilinx_dma.c: In function
> 'xilinx_cdma_start_transfer':
> 2148 drivers/dma/xilinx/xilinx_dma.c:1252:9: error: implicit declaration of
> function 'xilinx_prep_dma_addr_t'; did you mean 'xilinx_dma_start'? [-
> Werror=implicit-function-declaration]
> 2149          xilinx_prep_dma_addr_t(hw->src_addr));
> 2150          ^~~~~~~~~~~~~~~~~~~~~~
> 2151          xilinx_dma_start
> 
> 
> 3)
> Config: arm shmobile_defconfig
> Link: https://gitlab.com/cip-playground/linux-stable-rc-ci/-
> /jobs/373484089#L2249
> Probable culprit: 984d7a8bff57 ("pinctrl: sh-pfc: r8a7792: Fix VIN versioned
> groups")
> Issue log:
> 2249 drivers/pinctrl/sh-pfc/pfc-r8a7792.c:1750:38: error: macro
> "VIN_DATA_PIN_GROUP" passed 3 arguments, but takes just 2
> 2250   VIN_DATA_PIN_GROUP(vin1_data, 24, _b),
> 2251                                       ^
> 2252 drivers/pinctrl/sh-pfc/pfc-r8a7792.c:1750:2: error:
> 'VIN_DATA_PIN_GROUP' undeclared here (not in a function); did you mean
> 'PIN_MAP_TYPE_MUX_GROUP'?
> 2253   VIN_DATA_PIN_GROUP(vin1_data, 24, _b),
> 2254   ^~~~~~~~~~~~~~~~~~
> 2255   PIN_MAP_TYPE_MUX_GROUP
> 2256 drivers/pinctrl/sh-pfc/pfc-r8a7792.c:1751:38: error: macro
> "VIN_DATA_PIN_GROUP" passed 3 arguments, but takes just 2
> 2257   VIN_DATA_PIN_GROUP(vin1_data, 20, _b),
> 2258                                       ^
> 2259 drivers/pinctrl/sh-pfc/pfc-r8a7792.c:1753:38: error: macro
> "VIN_DATA_PIN_GROUP" passed 3 arguments, but takes just 2
> 2260   VIN_DATA_PIN_GROUP(vin1_data, 16, _b),
> 2261                                       ^
> 
> 
> Kind regards, Chris

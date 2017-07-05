From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Wed, 5 Jul 2017 18:16:25 +0200
Subject: [cip-dev] Fwd: stable/linux-4.4.y build: 199 builds: 0 failed,
 199 passed, 4 warnings (v4.4.76)
In-Reply-To: <595d0cf0.08891c0a.c2f48.7db1@mx.google.com>
References: <595d0cf0.08891c0a.c2f48.7db1@mx.google.com>
Message-ID: <595D10D9.8010807@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

please see below an example of a report sent to the 
kernel-build-reports at lists.linaro.org of the latest LTS kernel version.

As you know, kernelci is mainly targeting kernel developers, not kernel 
maintainers. I suspect that Ben H. and Daniel W. will suggest changes in 
this report, specially when we add specific tests to our "CIP suite". I 
think this is a great reference though.


-------- Forwarded Message --------
Subject: 	stable/linux-4.4.y build: 199 builds: 0 failed, 199 passed, 4
warnings (v4.4.76)
Date: 	Wed, 05 Jul 2017 08:59:44 -0700 (PDT)
From: 	kernelci.org bot <bot@kernelci.org>
To: 	kernel-build-reports at lists.linaro.org



stable/linux-4.4.y build: 199 builds: 0 failed, 199 passed, 4 warnings
(v4.4.76) *stable/linux-4.4.y build: 199 builds: 0 failed, 199 passed, 4
warnings (v4.4.76)*
Full Build Summary:
https://kernelci.org/build/stable/branch/linux-4.4.y/kernel/v4.4.76/
Tree: stable
Branch: linux-4.4.y
Git Describe: v4.4.76
Git Commit: 4282d39575bf17daedc18f2fe01ca349830a6e99
Git URL:
http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
<https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=4282d39575bf17daedc18f2fe01ca349830a6e99>
Built: 4 unique architectures

*Warnings Detected:*

x86: 	gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4)
defconfig+CONFIG_KASAN=y
<https://kernelci.org/build/id/595d084059b514da801baba7/> 		4 warnings
<https://storage.kernelci.org/stable/linux-4.4.y/v4.4.76/x86/defconfig+CONFIG_KASAN=y/build-warnings.log> 



Warnings summary:
1 	net/wireless/nl80211.c:5096:1: warning: the frame size of 2064 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
1 	net/wireless/nl80211.c:3859:1: warning: the frame size of 2168 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
1 	net/wireless/nl80211.c:1728:1: warning: the frame size of 5640 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
1 	drivers/tty/vt/keyboard.c:1470:1: warning: the frame size of 2344
bytes is larger than 2048 bytes [-Wframe-larger-than=]

*Detailed per-defconfig build reports:*

*acs5k_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*acs5k_tiny_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*allmodconfig+CONFIG_OF=n* (x86) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*allnoconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*allnoconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*allnoconfig* (x86) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*allnoconfig* (arm64) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*am200epdkit_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*ar7_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*assabet_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*at91_dt_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*ath79_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*axm55xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*badge4_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*bcm2835_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*bcm47xx_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*bcm63xx_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*bcm_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*bigsur_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*bmips_be_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*bmips_stb_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*capcella_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*cavium_octeon_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*cerfcube_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*ci20_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*clps711x_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*cm_x2xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*cm_x300_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*cns3420vb_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*cobalt_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*colibri_pxa270_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*colibri_pxa300_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*collie_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*corgi_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*davinci_all_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*db1xxx_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*decstation_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*defconfig* (arm64) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*defconfig+CONFIG_CPU_BIG_ENDIAN=y* (arm64) ? PASS, 0 errors, 0
warnings, 0 section mismatches

*defconfig+CONFIG_EXPERT=y+CONFIG_ACPI=y* (arm64) ? PASS, 0 errors, 0
warnings, 0 section mismatches

*defconfig+CONFIG_KASAN=y* (x86) ? PASS, 0 errors, 4 warnings, 0 section
mismatches

Warnings:
net/wireless/nl80211.c:3859:1: warning: the frame size of 2168 bytes is
larger than 2048 bytes [-Wframe-larger-than=]
net/wireless/nl80211.c:5096:1: warning: the frame size of 2064 bytes is
larger than 2048 bytes [-Wframe-larger-than=]
net/wireless/nl80211.c:1728:1: warning: the frame size of 5640 bytes is
larger than 2048 bytes [-Wframe-larger-than=]
drivers/tty/vt/keyboard.c:1470:1: warning: the frame size of 2344 bytes
is larger than 2048 bytes [-Wframe-larger-than=]

*defconfig+CONFIG_LKDTM=y* (mips) ? PASS, 0 errors, 0 warnings, 0
section mismatches

*defconfig+CONFIG_LKDTM=y* (x86) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*defconfig+CONFIG_LKDTM=y* (arm64) ? PASS, 0 errors, 0 warnings, 0
section mismatches

*defconfig+CONFIG_OF_UNITTEST=y* (x86) ? PASS, 0 errors, 0 warnings, 0
section mismatches

*defconfig+CONFIG_OF_UNITTEST=y* (arm64) ? PASS, 0 errors, 0 warnings, 0
section mismatches

*defconfig+CONFIG_RANDOMIZE_BASE=y* (arm64) ? PASS, 0 errors, 0
warnings, 0 section mismatches

*defconfig+kvm_guest* (x86) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*dove_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*e55_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*ebsa110_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*efm32_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*em_x270_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*ep93xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*eseries_pxa_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*exynos_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*ezx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*footbridge_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*fuloong2e_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*gpr_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*h3600_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*h5000_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*hackkit_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*hisi_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*i386_defconfig* (x86) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*imote2_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*imx_v4_v5_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*imx_v6_v7_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*integrator_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*iop13xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*iop32x_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*iop33x_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*ip22_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*ip27_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*ip28_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*ip32_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*ixp4xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*jazz_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*jmr3927_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*jornada720_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*keystone_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*ks8695_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*lart_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*lasat_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*lemote2f_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*loongson3_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*lpc18xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*lpc32xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*lpd270_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*ls1b_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*lubbock_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*magician_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*mainstone_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*malta_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*malta_kvm_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*malta_kvm_guest_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0
section mismatches

*malta_qemu_32r6_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0
section mismatches

*maltaaprp_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*maltasmvp_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*maltasmvp_eva_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*maltaup_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*maltaup_xpa_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*markeins_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*mini2440_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*mips_paravirt_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*mmp2_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*moxart_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*mpc30x_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*msp71xx_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*mtx1_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*multi_v5_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*multi_v7_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*multi_v7_defconfig+CONFIG_ARM_LPAE=y* (arm) ? PASS, 0 errors, 0
warnings, 0 section mismatches

*multi_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y* (arm) ? PASS, 0 errors, 0
warnings, 0 section mismatches

*multi_v7_defconfig+CONFIG_EFI=y* (arm) ? PASS, 0 errors, 0 warnings, 0
section mismatches

*multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y* (arm) ? PASS, 0
errors, 0 warnings, 0 section mismatches

*multi_v7_defconfig+CONFIG_LKDTM=y* (arm) ? PASS, 0 errors, 0 warnings,
0 section mismatches

*multi_v7_defconfig+CONFIG_PROVE_LOCKING=y* (arm) ? PASS, 0 errors, 0
warnings, 0 section mismatches

*multi_v7_defconfig+CONFIG_SMP=n* (arm) ? PASS, 0 errors, 0 warnings, 0
section mismatches

*multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y+CONFIG_ARM_MODULE_PLTS=y*
(arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*mv78xx0_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*mvebu_v5_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*mvebu_v7_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*mvebu_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y* (arm) ? PASS, 0 errors, 0
warnings, 0 section mismatches

*mxs_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*neponset_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*netwinder_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*netx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*nhk8815_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*nlm_xlp_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*nlm_xlr_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*nuc910_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*nuc950_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*nuc960_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*omap1_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*omap2plus_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*orion5x_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*palmz72_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*pcm027_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*pistachio_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*pleb_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*pnx8335_stb225_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0
section mismatches

*prima2_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*pxa168_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*pxa255-idp_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*pxa3xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*pxa910_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*qcom_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*qi_lb60_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*raumfeld_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*rb532_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*rbtx49xx_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*realview-smp_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*realview_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*rm200_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*rpc_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*rt305x_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*s3c2410_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*s3c6400_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*s5pv210_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*sama5_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*sb1250_swarm_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*sead3_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*sead3micro_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*shannon_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*shmobile_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*simpad_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*socfpga_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*spear13xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*spear3xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*spear6xx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*spitz_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*stm32_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*sunxi_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*tb0219_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*tb0226_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*tb0287_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*tct_hammer_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*tegra_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*tinyconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*tinyconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*tinyconfig* (x86) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*tinyconfig* (arm64) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*trizeps4_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*u300_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*u8500_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*versatile_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*versatile_defconfig+CONFIG_OF_UNITTEST=y* (arm) ? PASS, 0 errors, 0
warnings, 0 section mismatches

*vexpress_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*vf610m4_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*viper_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*vt8500_v6_v7_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*workpad_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*x86_64_defconfig* (x86) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*xcep_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*xilfpga_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section
mismatches

*xway_defconfig* (mips) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*zeus_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

*zx_defconfig* (arm) ? PASS, 0 errors, 0 warnings, 0 section mismatches

?
For more info write to <info at kernelci.org <mailto:info@kernelci.org>>


-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk


-------------- next part --------------
_______________________________________________
Kernel-build-reports mailing list
Kernel-build-reports at lists.linaro.org
https://lists.linaro.org/mailman/listinfo/kernel-build-reports

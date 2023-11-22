Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE76C61D9B
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 19:36:31 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.33514.1700681783954619078
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 11:36:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=O3KPQFCV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-283a2c8dbe9so143405a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 11:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700681783; x=1701286583; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EcRmRMRxYWMd+DlCJln19dpIcFPTSLfLOEST7XhI3S4=;
        b=O3KPQFCVNN2geJoTCjTpUqRDYWTQbUTdFc8Q86Ax3SyxUJ0FxswHvOdgbQHBEERBd4
         ZvnHxrq3uhErcJEFXUGC3wjbCjlPcCFUL4cdMjxq7AaqKtKvuAtDDkpr5HZFJ1+s+FcU
         QzdNOrhUVeqCdTv6GHMbajaCyAnJfjLODi4XOs0N5mo0jIxczVVXHcHeMCSBTaIGVsnt
         fbhwM9xICd7bGg8m16bDgibzYoCrDLMbMXHFVScjdU5DAzp3PCVIkyctJjyRTvvn8O3/
         1qGaAq1CmJljMopu2kjcTn8saoXmMN0cYcBugKJTty6DXUMLh7g5llzhkE3UFHI/DSvZ
         Y44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700681783; x=1701286583;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcRmRMRxYWMd+DlCJln19dpIcFPTSLfLOEST7XhI3S4=;
        b=GV4p4klI85xwQdXhLZ/PLRQH/j+6VqUyLfFHY2qqwBoUmbJGW9rQw2Mc5pU7gq5I5M
         DPGEwF2FzKFoiK7dxvrrKKHXXyQZFU8jPPwIKrb6HKvX6XK7F9v3A13zoPEQKt3B3Imb
         5I5o/yIjfp+FuMK7t5zFxUIHPqIFaMYZoiWP/SOHW+ONW2YXP759E1419GSfQsoBFqQu
         yKCf6GFfhGnOjhG2E0SZQs35lRv2qyL97DMVLHIsWNgSjJUZu1WboUtHA8jPpCtLEAAW
         pfLXiTfS/KKRBiH4MJpZXxqcc7aK7h1FzfE3khh21VYeU4Rr71K0ETjFAXwGAhxHNyp6
         29jA==
X-Gm-Message-State: AOJu0YyflYXcKbrFHTRRE8u8sI1u00BepGFslSOcb2aNAT2shf1Jz36r
	JLu/GLHmXaykcIRz6nEmP38EZh1pkoyUsZgDh5U=
X-Google-Smtp-Source: AGHT+IGO8KjGA7T/Ig498Xkbx+d61iflHztoZhJBWRHFBgtwh88QC3B3ZUVLWgqR7mvt4A5GjXIs1w==
X-Received: by 2002:a17:90b:380a:b0:285:3511:6269 with SMTP id mq10-20020a17090b380a00b0028535116269mr3531977pjb.38.1700681781514;
        Wed, 22 Nov 2023 11:36:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090a408600b00282eb74ec9esm110549pjg.51.2023.11.22.11.36.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:36:20 -0800 (PST)
Message-ID: <655e5834.170a0220.a2328.0a4a@mx.google.com>
Date: Wed, 22 Nov 2023 11:36:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc build: 190 builds: 5
 failed, 185 passed, 6 errors, 116 warnings (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 19:36:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13639

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc build: 190 builds: 5 failed, 185=
 passed, 6 errors, 116 warnings (v5.10.200-cip40-188-g33d0b44cd71d)

Full Build Summary: https://kernelci.org/build/cip-gitlab/branch/ci%2Fiwama=
tsu%2Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/

Tree: cip-gitlab
Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Git Describe: v5.10.200-cip40-188-g33d0b44cd71d
Git Commit: 33d0b44cd71d9f81944784e605bc1def7fa0b71e
Git URL: https://gitlab.com/cip-project/cip-kernel/linux-cip.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL
    defconfig+arm64-chromebook+kselftest: (gcc-10) FAIL

arm:
    rpc_defconfig: (gcc-10) FAIL

mips:
    ip27_defconfig: (gcc-10) FAIL
    ip28_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:
    axs103_defconfig (gcc-10): 1 warning
    axs103_smp_defconfig (gcc-10): 1 warning
    hsdk_defconfig (gcc-10): 1 warning
    nsimosci_hs_defconfig (gcc-10): 1 warning
    nsimosci_hs_smp_defconfig (gcc-10): 1 warning
    vdk_hs38_smp_defconfig (gcc-10): 1 warning

arm64:
    defconfig (gcc-10): 1 warning
    defconfig+arm64-chromebook (gcc-10): 1 error, 1 warning
    defconfig+arm64-chromebook+kselftest (gcc-10): 1 error, 1 warning
    defconfig+kselftest (gcc-10): 1 warning

arm:
    aspeed_g4_defconfig (gcc-10): 1 warning
    aspeed_g5_defconfig (gcc-10): 1 warning
    at91_dt_defconfig (gcc-10): 1 warning
    axm55xx_defconfig (gcc-10): 1 warning
    badge4_defconfig (gcc-10): 1 warning
    bcm2835_defconfig (gcc-10): 1 warning
    cm_x300_defconfig (gcc-10): 1 warning
    colibri_pxa270_defconfig (gcc-10): 1 warning
    corgi_defconfig (gcc-10): 1 warning
    davinci_all_defconfig (gcc-10): 1 warning
    dove_defconfig (gcc-10): 1 warning
    efm32_defconfig (gcc-10): 1 warning
    ep93xx_defconfig (gcc-10): 1 warning
    exynos_defconfig (gcc-10): 1 warning
    ezx_defconfig (gcc-10): 1 warning
    footbridge_defconfig (gcc-10): 1 warning
    gemini_defconfig (gcc-10): 1 warning
    hisi_defconfig (gcc-10): 1 warning
    imote2_defconfig (gcc-10): 1 warning
    imx_v6_v7_defconfig (gcc-10): 1 warning
    integrator_defconfig (gcc-10): 1 warning
    iop32x_defconfig (gcc-10): 1 warning
    ixp4xx_defconfig (gcc-10): 1 warning
    keystone_defconfig (gcc-10): 1 warning
    lpc18xx_defconfig (gcc-10): 1 warning
    lpc32xx_defconfig (gcc-10): 1 warning
    magician_defconfig (gcc-10): 1 warning
    mini2440_defconfig (gcc-10): 1 warning
    mmp2_defconfig (gcc-10): 1 warning
    multi_v4t_defconfig (gcc-10): 1 warning
    multi_v5_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    multi_v7_defconfig+kselftest (gcc-10): 1 warning
    mvebu_v5_defconfig (gcc-10): 1 warning
    mvebu_v7_defconfig (gcc-10): 1 warning
    mxs_defconfig (gcc-10): 1 warning
    neponset_defconfig (gcc-10): 1 warning
    netwinder_defconfig (gcc-10): 1 warning
    nhk8815_defconfig (gcc-10): 1 warning
    omap1_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning
    orion5x_defconfig (gcc-10): 1 warning
    palmz72_defconfig (gcc-10): 1 warning
    pcm027_defconfig (gcc-10): 1 warning
    prima2_defconfig (gcc-10): 1 warning
    pxa3xx_defconfig (gcc-10): 1 warning
    pxa_defconfig (gcc-10): 1 warning
    qcom_defconfig (gcc-10): 1 warning
    realview_defconfig (gcc-10): 1 warning
    rpc_defconfig (gcc-10): 4 errors
    s3c2410_defconfig (gcc-10): 1 warning
    s3c6400_defconfig (gcc-10): 1 warning
    s5pv210_defconfig (gcc-10): 1 warning
    sama5_defconfig (gcc-10): 1 warning
    shmobile_defconfig (gcc-10): 1 warning
    socfpga_defconfig (gcc-10): 1 warning
    spear13xx_defconfig (gcc-10): 1 warning
    spear3xx_defconfig (gcc-10): 1 warning
    spear6xx_defconfig (gcc-10): 1 warning
    spitz_defconfig (gcc-10): 1 warning
    stm32_defconfig (gcc-10): 1 warning
    sunxi_defconfig (gcc-10): 1 warning
    tango4_defconfig (gcc-10): 1 warning
    tegra_defconfig (gcc-10): 1 warning
    trizeps4_defconfig (gcc-10): 1 warning
    u300_defconfig (gcc-10): 1 warning
    u8500_defconfig (gcc-10): 1 warning
    versatile_defconfig (gcc-10): 1 warning
    vexpress_defconfig (gcc-10): 1 warning
    viper_defconfig (gcc-10): 1 warning
    vt8500_v6_v7_defconfig (gcc-10): 1 warning
    xcep_defconfig (gcc-10): 1 warning
    zeus_defconfig (gcc-10): 1 warning

i386:
    i386_defconfig (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 2 warnings
    ath79_defconfig (gcc-10): 1 warning
    bigsur_defconfig (gcc-10): 1 warning
    cavium_octeon_defconfig (gcc-10): 1 warning
    ci20_defconfig (gcc-10): 1 warning
    cu1000-neo_defconfig (gcc-10): 1 warning
    cu1830-neo_defconfig (gcc-10): 1 warning
    db1xxx_defconfig (gcc-10): 1 warning
    decstation_64_defconfig (gcc-10): 1 warning
    decstation_defconfig (gcc-10): 1 warning
    decstation_r4k_defconfig (gcc-10): 1 warning
    fuloong2e_defconfig (gcc-10): 1 warning
    gcw0_defconfig (gcc-10): 1 warning
    gpr_defconfig (gcc-10): 1 warning
    loongson3_defconfig (gcc-10): 1 warning
    mtx1_defconfig (gcc-10): 1 warning
    nlm_xlp_defconfig (gcc-10): 1 warning
    nlm_xlr_defconfig (gcc-10): 1 warning
    pistachio_defconfig (gcc-10): 1 warning
    qi_lb60_defconfig (gcc-10): 1 warning
    rm200_defconfig (gcc-10): 1 warning
    rs90_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 warning
    rv32_defconfig (gcc-10): 5 warnings

x86_64:
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+kselftest (gcc-10): 1 warning
    x86_64_defconfig+x86-board (gcc-10): 1 warning
    x86_64_defconfig+x86-board+kselftest (gcc-10): 1 warning

Errors summary:

    2    drivers/interconnect/qcom/sc7180.c:158:3: error: =E2=80=98struct q=
com_icc_bcm=E2=80=99 has no member named =E2=80=98enable_mask=E2=80=99
    2    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3m
    2    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-marc=
h=3D=E2=80=99

Warnings summary:

    101  drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of=
 =E2=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 q=
ualifier from pointer target type [-Wdiscarded-qualifiers]
    6    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of=
 'device_get_match_data' discards 'const' qualifier from pointer target typ=
e [-Wdiscarded-qualifiers]
    3    kernel/rcu/tasks.h:736:13: warning: =E2=80=98show_rcu_tasks_rude_g=
p_kthread=E2=80=99 defined but not used [-Wunused-function]
    2    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    2    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]
    1    drivers/block/paride/bpck.c:32: warning: "PC" redefined
    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

Section mismatches summary:

    1    WARNING: modpost: vmlinux.o(___ksymtab_gpl+ixp4xx_irq_init+0x0): S=
ection mismatch in reference from the variable __ksymtab_ixp4xx_irq_init to=
 the function .init.text:ixp4xx_irq_init()
    1    WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0):=
 Section mismatch in reference from the variable __ksymtab_prom_init_numa_m=
emory to the function .init.text:prom_init_numa_memory()

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
am200epdkit_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
ar7_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
aspeed_g4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
aspeed_g5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
assabet_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
at91_dt_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
ath25_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
ath79_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
axm55xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
axs103_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of 'dev=
ice_get_match_data' discards 'const' qualifier from pointer target type [-W=
discarded-qualifiers]

---------------------------------------------------------------------------=
-----
axs103_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of 'dev=
ice_get_match_data' discards 'const' qualifier from pointer target type [-W=
discarded-qualifiers]

---------------------------------------------------------------------------=
-----
badge4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
bcm2835_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
bcm47xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
bcm63xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
bigsur_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
bmips_be_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
bmips_stb_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
capcella_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
cavium_octeon_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
cerfcube_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
ci20_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
cm_x300_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
cobalt_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
colibri_pxa270_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
colibri_pxa300_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings=
, 0 section mismatches

---------------------------------------------------------------------------=
-----
collie_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
corgi_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
cu1000-neo_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
cu1830-neo_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
davinci_all_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
db1xxx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
decstation_64_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    kernel/rcu/tasks.h:736:13: warning: =E2=80=98show_rcu_tasks_rude_gp_kth=
read=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
decstation_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    kernel/rcu/tasks.h:736:13: warning: =E2=80=98show_rcu_tasks_rude_gp_kth=
read=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
decstation_r4k_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning=
, 0 section mismatches

Warnings:
    kernel/rcu/tasks.h:736:13: warning: =E2=80=98show_rcu_tasks_rude_gp_kth=
read=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warni=
ng, 0 section mismatches

Errors:
    drivers/interconnect/qcom/sc7180.c:158:3: error: =E2=80=98struct qcom_i=
cc_bcm=E2=80=99 has no member named =E2=80=98enable_mask=E2=80=99

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook+kselftest (arm64, gcc-10) =E2=80=94 FAIL, 1 erro=
r, 1 warning, 0 section mismatches

Errors:
    drivers/interconnect/qcom/sc7180.c:158:3: error: =E2=80=98struct qcom_i=
cc_bcm=E2=80=99 has no member named =E2=80=98enable_mask=E2=80=99

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
dove_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
e55_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
ebsa110_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
efm32_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
ep93xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
eseries_pxa_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
exynos_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
ezx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section =
mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
footbridge_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
fuloong2e_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
gcw0_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
gemini_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
gpr_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
h3600_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
h5000_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
hackkit_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
haps_hs_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
hisi_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
hsdk_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of 'dev=
ice_get_match_data' discards 'const' qualifier from pointer target type [-W=
discarded-qualifiers]

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
imote2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
imx_v4_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
integrator_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
iop32x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
ip22_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
ip27_defconfig (mips, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
ip28_defconfig (mips, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
ip32_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
ixp4xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

Section mismatches:
    WARNING: modpost: vmlinux.o(___ksymtab_gpl+ixp4xx_irq_init+0x0): Sectio=
n mismatch in reference from the variable __ksymtab_ixp4xx_irq_init to the =
function .init.text:ixp4xx_irq_init()

---------------------------------------------------------------------------=
-----
jazz_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
jmr3927_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
jornada720_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
keystone_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
lart_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
lemote2f_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
loongson1b_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
loongson1c_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
loongson3_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

Section mismatches:
    WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Sect=
ion mismatch in reference from the variable __ksymtab_prom_init_numa_memory=
 to the function .init.text:prom_init_numa_memory()

---------------------------------------------------------------------------=
-----
lpc18xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
lpc32xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
lpd270_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
lubbock_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
magician_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
mainstone_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
malta_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
malta_kvm_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
malta_kvm_guest_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnin=
gs, 0 section mismatches

---------------------------------------------------------------------------=
-----
malta_qemu_32r6_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnin=
gs, 0 section mismatches

---------------------------------------------------------------------------=
-----
maltaaprp_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
maltasmvp_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
maltasmvp_eva_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings=
, 0 section mismatches

---------------------------------------------------------------------------=
-----
maltaup_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
maltaup_xpa_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
milbeaut_m10v_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
mini2440_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
mmp2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
moxart_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
mpc30x_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
mps2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
mtx1_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
multi_v4t_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
mvebu_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
mvebu_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
mxs_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section =
mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
neponset_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
netwinder_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
nhk8815_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
nlm_xlp_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
nlm_xlr_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
nsimosci_hs_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of 'dev=
ice_get_match_data' discards 'const' qualifier from pointer target type [-W=
discarded-qualifiers]

---------------------------------------------------------------------------=
-----
nsimosci_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning=
, 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of 'dev=
ice_get_match_data' discards 'const' qualifier from pointer target type [-W=
discarded-qualifiers]

---------------------------------------------------------------------------=
-----
omap1_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
omega2p_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
orion5x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
oxnas_v6_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
palmz72_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
pcm027_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
pic32mzda_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
pistachio_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
pleb_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
prima2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
pxa168_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
pxa255-idp_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
pxa3xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
pxa910_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
pxa_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section =
mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
qcom_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
qi_lb60_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
rb532_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
rbtx49xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
realview_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
rm200_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/block/paride/bpck.c:32: warning: "PC" redefined

---------------------------------------------------------------------------=
-----
rpc_defconfig (arm, gcc-10) =E2=80=94 FAIL, 4 errors, 0 warnings, 0 section=
 mismatches

Errors:
    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3m
    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=
=E2=80=99
    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3m
    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=
=E2=80=99

---------------------------------------------------------------------------=
-----
rs90_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
rt305x_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 sect=
ion mismatches

Warnings:
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]

---------------------------------------------------------------------------=
-----
s3c2410_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
s3c6400_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
s5pv210_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
sama5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
sb1250_swarm_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
shannon_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
shmobile_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
simpad_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
socfpga_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
spear13xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
spear3xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
spear6xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
spitz_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
stm32_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
sunxi_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
tango4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
tb0219_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
tb0226_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
tb0287_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
tct_hammer_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
tegra_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
trizeps4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
u300_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
u8500_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
vdk_hs38_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
vdk_hs38_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of 'dev=
ice_get_match_data' discards 'const' qualifier from pointer target type [-W=
discarded-qualifiers]

---------------------------------------------------------------------------=
-----
versatile_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
vf610m4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
viper_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
vocore2_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
vt8500_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
workpad_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 err=
ors, 1 warning, 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
xcep_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
zeus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
zx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---
For more info write to <info@kernelci.org>


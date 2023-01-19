Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DAFC004D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 13:07:11 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.44489.1674133622140962637
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 19 Jan 2023 05:07:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=VXSC3xBE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so5806591pjm.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 19 Jan 2023 05:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L7MasIp2rqO8nAF5BT7G3x9Ob6qDwyBopWApidZt1t0=;
        b=VXSC3xBEUBYpRvNxGvmuiTEzPcaoOPilAVVM884u7hS0daF2uQoren2dZ1+Oi1NQT1
         De2UKVjqsKZnucdtI8bNWVStZBp94xCzw6DD4GKkDx2EIoxzQFtktvzbdZ1qufX6qm6I
         HuEU5OOVRiP42jJvolt8u/DCXRXzvieTvZM5RLd+/IEZiQmMeVMA922V/QBLxGEBWq7T
         IVDFUMRAZURqf+ZzqAkSq95+TwDGDm/ItnE8v6SvXlRJ8tuB7z3kQkDrSbgRNFq0CqMF
         HgzC9EsD4d667wo81oe38zWB37WQFhWRgYG64M/WJ2ePFwjnuqOnYx2I7z9UhYH1GHvN
         XTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7MasIp2rqO8nAF5BT7G3x9Ob6qDwyBopWApidZt1t0=;
        b=hAqHCtBK7Z0sC2czqSZ5yZZlsuwTJdF5HlCMfjKzenz7keEGNJPlqp0aSENEOfCWge
         Ov67ELuYQuM+GuOACBiM9DrsKErUR5+3phWiTcE6Fetc1fyztomP326jrMREhgqfQ8Ci
         pOtPo2ib9M4dyFfrq1xbNkUArzDkgt0c8ng27AKeIy2an7W/l/iA9bz5xT3zlZC/udWG
         4q1UsJM7XpNh7jbH5HLoubXUKsD8pv7biRhBer4ZqQdlr2HBFRR85tih/SqRfYysP/BW
         X1XaFnOoIDALm1kfwukS1ZPOvm3d6F9QfdB5mbpPoMLfPyGUpehLpFxJIZ/AV3Pr45hz
         6Ecw==
X-Gm-Message-State: AFqh2kr2XOJw5HEgV1sxvedJGCV0o9shOZP3BcrO4iVFYCQKXOJ/SpmQ
	U29uqDro/MdHQQnGjrWPytPHBKoQiTu6XNm6gzw=
X-Google-Smtp-Source: AMrXdXtF/GRT6T4JN2m9N/HRg9+EK6l6Y1BdDw0hTU10O6JswdlrVhVLVLFDYegNh/SfUt3hHBSrfg==
X-Received: by 2002:a17:902:d718:b0:194:a529:9984 with SMTP id w24-20020a170902d71800b00194a5299984mr10285555ply.58.1674133620329;
        Thu, 19 Jan 2023 05:07:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902dac100b0019141c79b1dsm25041611plx.254.2023.01.19.05.06.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:06:59 -0800 (PST)
Message-ID: <63c94073.170a0220.6b235.90ae@mx.google.com>
Date: Thu, 19 Jan 2023 05:06:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.162-929-gae713b3c4626e
X-Kernelci-Report-Type: build
Subject: cip-gitlab/ci/pavel/linux-test build: 192 builds: 112 failed,
 80 passed, 113 errors, 9 warnings (v5.10.162-929-gae713b3c4626e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 13:07:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10441

cip-gitlab/ci/pavel/linux-test build: 192 builds: 112 failed, 80 passed, 11=
3 errors, 9 warnings (v5.10.162-929-gae713b3c4626e)

Full Build Summary: https://kernelci.org/build/cip-gitlab/branch/ci%2Fpavel=
%2Flinux-test/kernel/v5.10.162-929-gae713b3c4626e/

Tree: cip-gitlab
Branch: ci/pavel/linux-test
Git Describe: v5.10.162-929-gae713b3c4626e
Git Commit: ae713b3c4626e7f02c44b3495f9b37717dd93ef0
Git URL: https://gitlab.com/cip-project/cip-kernel/linux-cip.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    defconfig+arm64-chromebook: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

arm:
    allnoconfig: (gcc-10) FAIL
    am200epdkit_defconfig: (gcc-10) FAIL
    aspeed_g4_defconfig: (gcc-10) FAIL
    aspeed_g5_defconfig: (gcc-10) FAIL
    assabet_defconfig: (gcc-10) FAIL
    at91_dt_defconfig: (gcc-10) FAIL
    axm55xx_defconfig: (gcc-10) FAIL
    badge4_defconfig: (gcc-10) FAIL
    bcm2835_defconfig: (gcc-10) FAIL
    cerfcube_defconfig: (gcc-10) FAIL
    clps711x_defconfig: (gcc-10) FAIL
    cm_x300_defconfig: (gcc-10) FAIL
    cns3420vb_defconfig: (gcc-10) FAIL
    colibri_pxa270_defconfig: (gcc-10) FAIL
    colibri_pxa300_defconfig: (gcc-10) FAIL
    collie_defconfig: (gcc-10) FAIL
    corgi_defconfig: (gcc-10) FAIL
    davinci_all_defconfig: (gcc-10) FAIL
    dove_defconfig: (gcc-10) FAIL
    ebsa110_defconfig: (gcc-10) FAIL
    efm32_defconfig: (gcc-10) FAIL
    ep93xx_defconfig: (gcc-10) FAIL
    eseries_pxa_defconfig: (gcc-10) FAIL
    exynos_defconfig: (gcc-10) FAIL
    ezx_defconfig: (gcc-10) FAIL
    footbridge_defconfig: (gcc-10) FAIL
    gemini_defconfig: (gcc-10) FAIL
    h3600_defconfig: (gcc-10) FAIL
    h5000_defconfig: (gcc-10) FAIL
    hackkit_defconfig: (gcc-10) FAIL
    hisi_defconfig: (gcc-10) FAIL
    imote2_defconfig: (gcc-10) FAIL
    imx_v4_v5_defconfig: (gcc-10) FAIL
    imx_v6_v7_defconfig: (gcc-10) FAIL
    integrator_defconfig: (gcc-10) FAIL
    iop32x_defconfig: (gcc-10) FAIL
    ixp4xx_defconfig: (gcc-10) FAIL
    jornada720_defconfig: (gcc-10) FAIL
    keystone_defconfig: (gcc-10) FAIL
    lart_defconfig: (gcc-10) FAIL
    lpc18xx_defconfig: (gcc-10) FAIL
    lpc32xx_defconfig: (gcc-10) FAIL
    lpd270_defconfig: (gcc-10) FAIL
    lubbock_defconfig: (gcc-10) FAIL
    magician_defconfig: (gcc-10) FAIL
    mainstone_defconfig: (gcc-10) FAIL
    milbeaut_m10v_defconfig: (gcc-10) FAIL
    mini2440_defconfig: (gcc-10) FAIL
    mmp2_defconfig: (gcc-10) FAIL
    moxart_defconfig: (gcc-10) FAIL
    mps2_defconfig: (gcc-10) FAIL
    multi_v4t_defconfig: (gcc-10) FAIL
    multi_v5_defconfig: (gcc-10) FAIL
    multi_v7_defconfig: (gcc-10) FAIL
    mv78xx0_defconfig: (gcc-10) FAIL
    mvebu_v5_defconfig: (gcc-10) FAIL
    mvebu_v7_defconfig: (gcc-10) FAIL
    mxs_defconfig: (gcc-10) FAIL
    neponset_defconfig: (gcc-10) FAIL
    netwinder_defconfig: (gcc-10) FAIL
    nhk8815_defconfig: (gcc-10) FAIL
    omap1_defconfig: (gcc-10) FAIL
    omap2plus_defconfig: (gcc-10) FAIL
    orion5x_defconfig: (gcc-10) FAIL
    oxnas_v6_defconfig: (gcc-10) FAIL
    palmz72_defconfig: (gcc-10) FAIL
    pcm027_defconfig: (gcc-10) FAIL
    pleb_defconfig: (gcc-10) FAIL
    prima2_defconfig: (gcc-10) FAIL
    pxa168_defconfig: (gcc-10) FAIL
    pxa255-idp_defconfig: (gcc-10) FAIL
    pxa3xx_defconfig: (gcc-10) FAIL
    pxa910_defconfig: (gcc-10) FAIL
    pxa_defconfig: (gcc-10) FAIL
    qcom_defconfig: (gcc-10) FAIL
    realview_defconfig: (gcc-10) FAIL
    rpc_defconfig: (gcc-10) FAIL
    s3c2410_defconfig: (gcc-10) FAIL
    s3c6400_defconfig: (gcc-10) FAIL
    s5pv210_defconfig: (gcc-10) FAIL
    sama5_defconfig: (gcc-10) FAIL
    shannon_defconfig: (gcc-10) FAIL
    shmobile_defconfig: (gcc-10) FAIL
    simpad_defconfig: (gcc-10) FAIL
    socfpga_defconfig: (gcc-10) FAIL
    spear13xx_defconfig: (gcc-10) FAIL
    spear3xx_defconfig: (gcc-10) FAIL
    spear6xx_defconfig: (gcc-10) FAIL
    spitz_defconfig: (gcc-10) FAIL
    stm32_defconfig: (gcc-10) FAIL
    sunxi_defconfig: (gcc-10) FAIL
    tango4_defconfig: (gcc-10) FAIL
    tct_hammer_defconfig: (gcc-10) FAIL
    tegra_defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL
    trizeps4_defconfig: (gcc-10) FAIL
    u300_defconfig: (gcc-10) FAIL
    u8500_defconfig: (gcc-10) FAIL
    versatile_defconfig: (gcc-10) FAIL
    vexpress_defconfig: (gcc-10) FAIL
    vf610m4_defconfig: (gcc-10) FAIL
    viper_defconfig: (gcc-10) FAIL
    vt8500_v6_v7_defconfig: (gcc-10) FAIL
    xcep_defconfig: (gcc-10) FAIL
    zeus_defconfig: (gcc-10) FAIL
    zx_defconfig: (gcc-10) FAIL

mips:
    ip27_defconfig: (gcc-10) FAIL
    ip28_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    allnoconfig (gcc-10): 1 error
    defconfig (gcc-10): 1 error
    defconfig+arm64-chromebook (gcc-10): 1 error
    tinyconfig (gcc-10): 1 error

arm:
    allnoconfig (gcc-10): 1 error
    am200epdkit_defconfig (gcc-10): 1 error
    aspeed_g4_defconfig (gcc-10): 1 error
    aspeed_g5_defconfig (gcc-10): 1 error
    assabet_defconfig (gcc-10): 1 error
    at91_dt_defconfig (gcc-10): 1 error
    axm55xx_defconfig (gcc-10): 1 error
    badge4_defconfig (gcc-10): 1 error
    bcm2835_defconfig (gcc-10): 1 error
    cerfcube_defconfig (gcc-10): 1 error
    clps711x_defconfig (gcc-10): 1 error
    cm_x300_defconfig (gcc-10): 1 error
    cns3420vb_defconfig (gcc-10): 1 error
    colibri_pxa270_defconfig (gcc-10): 1 error
    colibri_pxa300_defconfig (gcc-10): 1 error
    collie_defconfig (gcc-10): 1 error
    corgi_defconfig (gcc-10): 1 error
    davinci_all_defconfig (gcc-10): 1 error
    dove_defconfig (gcc-10): 1 error
    ebsa110_defconfig (gcc-10): 1 error
    efm32_defconfig (gcc-10): 1 error
    ep93xx_defconfig (gcc-10): 1 error
    eseries_pxa_defconfig (gcc-10): 1 error
    exynos_defconfig (gcc-10): 1 error
    ezx_defconfig (gcc-10): 1 error
    footbridge_defconfig (gcc-10): 1 error
    gemini_defconfig (gcc-10): 1 error
    h3600_defconfig (gcc-10): 1 error
    h5000_defconfig (gcc-10): 1 error
    hackkit_defconfig (gcc-10): 1 error
    hisi_defconfig (gcc-10): 1 error
    imote2_defconfig (gcc-10): 1 error
    imx_v4_v5_defconfig (gcc-10): 1 error
    imx_v6_v7_defconfig (gcc-10): 1 error
    integrator_defconfig (gcc-10): 1 error
    iop32x_defconfig (gcc-10): 1 error
    ixp4xx_defconfig (gcc-10): 1 error
    jornada720_defconfig (gcc-10): 1 error
    keystone_defconfig (gcc-10): 1 error
    lart_defconfig (gcc-10): 1 error
    lpc18xx_defconfig (gcc-10): 1 error
    lpc32xx_defconfig (gcc-10): 1 error
    lpd270_defconfig (gcc-10): 1 error
    lubbock_defconfig (gcc-10): 1 error
    magician_defconfig (gcc-10): 1 error
    mainstone_defconfig (gcc-10): 1 error
    milbeaut_m10v_defconfig (gcc-10): 1 error
    mini2440_defconfig (gcc-10): 1 error
    mmp2_defconfig (gcc-10): 1 error
    moxart_defconfig (gcc-10): 1 error
    mps2_defconfig (gcc-10): 1 error
    multi_v4t_defconfig (gcc-10): 1 error
    multi_v5_defconfig (gcc-10): 1 error
    multi_v7_defconfig (gcc-10): 1 error
    mv78xx0_defconfig (gcc-10): 1 error
    mvebu_v5_defconfig (gcc-10): 1 error
    mvebu_v7_defconfig (gcc-10): 1 error
    mxs_defconfig (gcc-10): 1 error
    neponset_defconfig (gcc-10): 1 error
    netwinder_defconfig (gcc-10): 1 error
    nhk8815_defconfig (gcc-10): 1 error
    omap1_defconfig (gcc-10): 1 error
    omap2plus_defconfig (gcc-10): 1 error
    orion5x_defconfig (gcc-10): 1 error
    oxnas_v6_defconfig (gcc-10): 1 error
    palmz72_defconfig (gcc-10): 1 error
    pcm027_defconfig (gcc-10): 1 error
    pleb_defconfig (gcc-10): 1 error
    prima2_defconfig (gcc-10): 1 error
    pxa168_defconfig (gcc-10): 1 error
    pxa255-idp_defconfig (gcc-10): 1 error
    pxa3xx_defconfig (gcc-10): 1 error
    pxa910_defconfig (gcc-10): 1 error
    pxa_defconfig (gcc-10): 1 error
    qcom_defconfig (gcc-10): 1 error
    realview_defconfig (gcc-10): 1 error
    rpc_defconfig (gcc-10): 4 errors
    s3c2410_defconfig (gcc-10): 1 error
    s3c6400_defconfig (gcc-10): 1 error
    s5pv210_defconfig (gcc-10): 1 error
    sama5_defconfig (gcc-10): 1 error
    shannon_defconfig (gcc-10): 1 error
    shmobile_defconfig (gcc-10): 1 error
    simpad_defconfig (gcc-10): 1 error
    socfpga_defconfig (gcc-10): 1 error
    spear13xx_defconfig (gcc-10): 1 error
    spear3xx_defconfig (gcc-10): 1 error
    spear6xx_defconfig (gcc-10): 1 error
    spitz_defconfig (gcc-10): 1 error
    stm32_defconfig (gcc-10): 1 error
    sunxi_defconfig (gcc-10): 1 error
    tango4_defconfig (gcc-10): 1 error
    tct_hammer_defconfig (gcc-10): 1 error
    tegra_defconfig (gcc-10): 1 error
    tinyconfig (gcc-10): 1 error
    trizeps4_defconfig (gcc-10): 1 error
    u300_defconfig (gcc-10): 1 error
    u8500_defconfig (gcc-10): 1 error
    versatile_defconfig (gcc-10): 1 error
    vexpress_defconfig (gcc-10): 1 error
    vf610m4_defconfig (gcc-10): 1 error
    viper_defconfig (gcc-10): 1 error
    vt8500_v6_v7_defconfig (gcc-10): 1 error
    xcep_defconfig (gcc-10): 1 error
    zeus_defconfig (gcc-10): 1 error
    zx_defconfig (gcc-10): 1 error

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning
    decstation_64_defconfig (gcc-10): 1 warning
    decstation_defconfig (gcc-10): 1 warning
    decstation_r4k_defconfig (gcc-10): 1 warning
    rm200_defconfig (gcc-10): 1 warning

riscv:
    rv32_defconfig (gcc-10): 4 warnings

x86_64:

Errors summary:

    105  include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SI=
GNAL=E2=80=99 undeclared (first use in this function)
    4    arch/arm64/kernel/entry.S:763: Error: immediate out of range at op=
erand 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(=
1<<13)|(1<<7))'
    2    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3m
    2    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-marc=
h=3D=E2=80=99

Warnings summary:

    3    kernel/rcu/tasks.h:710:13: warning: =E2=80=98show_rcu_tasks_rude_g=
p_kthread=E2=80=99 defined but not used [-Wunused-function]
    2    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    2    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]
    1    drivers/block/paride/bpck.c:32: warning: "PC" redefined
    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

Section mismatches summary:

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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
allnoconfig (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section =
mismatches

Errors:
    arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand=
 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13=
)|(1<<7))'

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section mi=
smatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
am200epdkit_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 =
section mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
ar7_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
aspeed_g4_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
aspeed_g5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
assabet_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
at91_dt_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
ath25_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
ath79_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
axm55xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
axs103_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
axs103_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
badge4_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
bcm2835_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

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
bigsur_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
cavium_octeon_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings=
, 0 section mismatches

---------------------------------------------------------------------------=
-----
cerfcube_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
ci20_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
clps711x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
cm_x300_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
cns3420vb_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
cobalt_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
colibri_pxa270_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings,=
 0 section mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
colibri_pxa300_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings,=
 0 section mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
collie_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
corgi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
cu1000-neo_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
cu1830-neo_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
davinci_all_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 =
section mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
db1xxx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
decstation_64_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    kernel/rcu/tasks.h:710:13: warning: =E2=80=98show_rcu_tasks_rude_gp_kth=
read=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
decstation_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    kernel/rcu/tasks.h:710:13: warning: =E2=80=98show_rcu_tasks_rude_gp_kth=
read=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
decstation_r4k_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning=
, 0 section mismatches

Warnings:
    kernel/rcu/tasks.h:710:13: warning: =E2=80=98show_rcu_tasks_rude_gp_kth=
read=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section mi=
smatches

Errors:
    arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand=
 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13=
)|(1<<7))'

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 0 warni=
ngs, 0 section mismatches

Errors:
    arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand=
 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13=
)|(1<<7))'

---------------------------------------------------------------------------=
-----
dove_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
e55_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
ebsa110_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
efm32_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
ep93xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
eseries_pxa_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 =
section mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
exynos_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
ezx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section =
mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
footbridge_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 s=
ection mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
fuloong2e_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
gcw0_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
gemini_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
gpr_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
h3600_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
h5000_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
hackkit_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

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
hisi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
hsdk_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
imote2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
imx_v4_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
integrator_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 s=
ection mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
iop32x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

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
ixp4xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

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
jornada720_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 s=
ection mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
keystone_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
lart_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

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
loongson3_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

Section mismatches:
    WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Sect=
ion mismatch in reference from the variable __ksymtab_prom_init_numa_memory=
 to the function .init.text:prom_init_numa_memory()

---------------------------------------------------------------------------=
-----
lpc18xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
lpc32xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
lpd270_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
lubbock_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
magician_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
mainstone_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

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
milbeaut_m10v_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, =
0 section mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
mini2440_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
mmp2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
moxart_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
mpc30x_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
mps2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
mtx1_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
multi_v4t_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
mv78xx0_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
mvebu_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
mvebu_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
mxs_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section =
mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
neponset_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
netwinder_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
nhk8815_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
nlm_xlp_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
nlm_xlr_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
nsimosci_hs_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
nsimosci_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
omap1_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
omega2p_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
orion5x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
oxnas_v6_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
palmz72_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
pcm027_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
pic32mzda_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
pistachio_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
pleb_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
prima2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
pxa168_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
pxa255-idp_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 s=
ection mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
pxa3xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
pxa910_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
pxa_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section =
mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
qcom_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
qi_lb60_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

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
realview_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

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
rs90_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
rt305x_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sect=
ion mismatches

Warnings:
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]

---------------------------------------------------------------------------=
-----
s3c2410_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
s3c6400_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
s5pv210_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
sama5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
sb1250_swarm_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
shannon_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
shmobile_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
simpad_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
socfpga_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
spear13xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
spear3xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
spear6xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
spitz_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
stm32_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
sunxi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
tango4_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

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
tct_hammer_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 s=
ection mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
tegra_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
tinyconfig (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section m=
ismatches

Errors:
    arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand=
 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13=
)|(1<<7))'

---------------------------------------------------------------------------=
-----
tinyconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section mis=
matches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
tinyconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
trizeps4_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
u300_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
u8500_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
vdk_hs38_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
vdk_hs38_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
versatile_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
vf610m4_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
viper_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
vocore2_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
vt8500_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0=
 section mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
workpad_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
xcep_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
zeus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
zx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section m=
ismatches

Errors:
    include/linux/sched/signal.h:369:39: error: =E2=80=98TIF_NOTIFY_SIGNAL=
=E2=80=99 undeclared (first use in this function)

---
For more info write to <info@kernelci.org>


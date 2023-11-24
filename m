Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C43C61D85
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 02:02:03 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.124975.1700791316703434766
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 18:01:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=M1HowP/m;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6c4d06b6ddaso1236677b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 18:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700791315; x=1701396115; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZYaYJhLwlkZQ+KCkFIxupLP2jGCl/nICLG1+HMMNhc=;
        b=M1HowP/mckEYsgk0ZAiOHAYiDJNJnWm6Ct5Zryvr3lElv8z+7hvEr7ZWUuZKN0r4xA
         6Qz2HiP3V1B5iO31hNQrNJn0Hux7HsC+i9w3rfjEbVfZc/4xi1NrFo8wulOrU9JTw8X3
         ixQDcZaqgpYH8FDgltTEBwGeqL5GtKYKQokfeT1qW7ZQgoepPXRwn2CxrmN3CyEuQnJr
         2wwJ0WBHKEY3aEELr+Xvn+7Q1Ylp4OUgN+EeVtHJldksXX24Qks8XHL6T8PhCKOwQF0U
         J95lJawlGTwy/EbsLom82LSFSFRbXAKbfxTIadYI7EFhA59ZYzeGS3ZKiR56K7EtH9jq
         /49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700791315; x=1701396115;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZYaYJhLwlkZQ+KCkFIxupLP2jGCl/nICLG1+HMMNhc=;
        b=YiXvMW7Iijf2oqfalduNiAvOre15ur98IWHdyDQ3Ku6I41YgWc1z7aKNNMSpjwu7Nb
         bbdxGbhc9e3QSZb/fuRbhYnUR2n/Bt3oYgpZJDbSFA8oCwrDYkusajhKhc4XoQAm6o/u
         BUBsh1nG9uPqhvPIjCh7mFGgR6YPHhlpV9uItFX0s0I/gbCSS9WkjaUw3+vBhLyt1oC1
         aSLwCujSPABb7SN9ng6/IXxvABi1bMoWx+wedM8LTly5CcJ7Ulrx5UmjJemxJo5ovyjq
         qtYF8DuJAx/99LJyn4sL6gwYfD9bEGKVQ8QMqFVVmZPhLbG/8x43P4fsX34tI82BRu8r
         TFVQ==
X-Gm-Message-State: AOJu0YxM+uCHcwIoAIAR0L2eapyndTi3xCtjXxh/C5Jn+HjK68D/T1mm
	H2kS8wwYaWzkKEOrPrTjLJbVdqLaqAnoNjNAVrg=
X-Google-Smtp-Source: AGHT+IGW7twJ/raFPVsSortH2nF2afFzLA6vs3eH6BLPfaqkn1m63UoNsgsjFnetqGvo0IcNCECOMA==
X-Received: by 2002:a05:6a20:3d85:b0:18b:af9d:438f with SMTP id s5-20020a056a203d8500b0018baf9d438fmr1531609pzi.49.1700791314460;
        Thu, 23 Nov 2023 18:01:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y192-20020a638ac9000000b005c2967852c5sm1712494pgd.30.2023.11.23.18.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 18:01:53 -0800 (PST)
Message-ID: <65600411.630a0220.9bcf4.4683@mx.google.com>
Date: Thu, 23 Nov 2023 18:01:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-rt17
Subject: cip/linux-5.10.y-cip-rt build: 191 builds: 5 failed, 186 passed,
 12 errors, 121 warnings (v5.10.201-cip41-rt17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 02:02:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13700

cip/linux-5.10.y-cip-rt build: 191 builds: 5 failed, 186 passed, 12 errors,=
 121 warnings (v5.10.201-cip41-rt17)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-5.10.y-cip-=
rt/kernel/v5.10.201-cip41-rt17/

Tree: cip
Branch: linux-5.10.y-cip-rt
Git Describe: v5.10.201-cip41-rt17
Git Commit: 78ed1354cecc021db9a1d8a8b4755fdfcd826e33
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
Built: 7 unique architectures

Build Failures Detected:

arm:
    defconfig+preempt_rt: (gcc-10) FAIL
    multi_v7_defconfig+preempt_rt: (gcc-10) FAIL
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
    defconfig+preempt_rt (gcc-10): 1 warning

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
    defconfig (gcc-10): 1 warning
    defconfig+preempt_rt (gcc-10): 4 errors, 1 warning
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
    multi_v7_defconfig+preempt_rt (gcc-10): 4 errors, 1 warning
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
    i386_defconfig+preempt_rt (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 2 warnings
    32r2el_defconfig+preempt_rt (gcc-10): 2 warnings
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
    defconfig+preempt_rt (gcc-10): 1 warning
    rv32_defconfig (gcc-10): 5 warnings

x86_64:
    defconfig (gcc-10): 1 warning
    defconfig+preempt_rt (gcc-10): 1 warning
    defconfig+x86-board (gcc-10): 1 warning
    x86_64_defconfig+preempt_rt (gcc-10): 1 warning
    x86_64_defconfig+x86-board+preempt_rt (gcc-10): 1 warning

Errors summary:

    4    include/linux/spinlock_rt.h:115:2: error: =E2=80=98return=E2=80=99=
 with a value, in function returning void [-Werror=3Dreturn-type]
    4    include/linux/spinlock_rt.h:115:2: error: expected expression befo=
re =E2=80=98do=E2=80=99
    2    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3m
    2    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-marc=
h=3D=E2=80=99

Warnings summary:

    103  drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of=
 =E2=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 q=
ualifier from pointer target type [-Wdiscarded-qualifiers]
    6    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of=
 'device_get_match_data' discards 'const' qualifier from pointer target typ=
e [-Wdiscarded-qualifiers]
    3    kernel/rcu/tasks.h:736:13: warning: =E2=80=98show_rcu_tasks_rude_g=
p_kthread=E2=80=99 defined but not used [-Wunused-function]
    2    cc1: some warnings being treated as errors
    2    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.
    2    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    2    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]
    1    drivers/block/paride/bpck.c:32: warning: "PC" redefined

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
32r2el_defconfig+preempt_rt (mips, gcc-10) =E2=80=94 PASS, 0 errors, 2 warn=
ings, 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

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
defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section m=
ismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mism=
atches

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
defconfig+preempt_rt (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
defconfig+preempt_rt (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
defconfig+preempt_rt (arm, gcc-10) =E2=80=94 FAIL, 4 errors, 1 warning, 0 s=
ection mismatches

Errors:
    include/linux/spinlock_rt.h:115:2: error: expected expression before =
=E2=80=98do=E2=80=99
    include/linux/spinlock_rt.h:115:2: error: =E2=80=98return=E2=80=99 with=
 a value, in function returning void [-Werror=3Dreturn-type]
    include/linux/spinlock_rt.h:115:2: error: expected expression before =
=E2=80=98do=E2=80=99
    include/linux/spinlock_rt.h:115:2: error: =E2=80=98return=E2=80=99 with=
 a value, in function returning void [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
defconfig+preempt_rt (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, =
0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
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
haps_hs_smp_defconfig+preempt_rt (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 =
warnings, 0 section mismatches

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
i386_defconfig+preempt_rt (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warnin=
g, 0 section mismatches

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
multi_v7_defconfig+preempt_rt (arm, gcc-10) =E2=80=94 FAIL, 4 errors, 1 war=
ning, 0 section mismatches

Errors:
    include/linux/spinlock_rt.h:115:2: error: expected expression before =
=E2=80=98do=E2=80=99
    include/linux/spinlock_rt.h:115:2: error: =E2=80=98return=E2=80=99 with=
 a value, in function returning void [-Werror=3Dreturn-type]
    include/linux/spinlock_rt.h:115:2: error: expected expression before =
=E2=80=98do=E2=80=99
    include/linux/spinlock_rt.h:115:2: error: =E2=80=98return=E2=80=99 with=
 a value, in function returning void [-Werror=3Dreturn-type]

Warnings:
    cc1: some warnings being treated as errors

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
x86_64_defconfig+preempt_rt (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 wa=
rning, 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board+preempt_rt (x86_64, gcc-10) =E2=80=94 PASS, 0 er=
rors, 1 warning, 0 section mismatches

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


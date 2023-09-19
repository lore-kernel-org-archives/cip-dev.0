Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90D8CD5BD0
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 14:57:27 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.11567.1695135440042230162
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 07:57:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=j5A+ije8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4732777a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695135439; x=1695740239; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O6IfzMj/IbN1fjwdXyBiQ/TWoVzY1A0GHR4/O9/s9kk=;
        b=j5A+ije8Eizt0p8oUplOyZ3OE8tOT/48E7BV4KiDli/ZwTr0OWvbvM3x99NLXxf1IJ
         y8PxRmdG1L+jRR0DJZo1+cr44ify6wNLFsjifEa+asZ6HhXaVXdT1p4xwQo4X69+9rKm
         LUtj6ubDZF968wQAUnzHyHg8XynGX23I5b37Ti4dVv1WxDdJX3MUP4zAjxArJOu8m+Z+
         ooSruCUNqG0zRES5M0kVuRZLk447tgj3yeTu7jCPQxwDfE4YpAaPGXOB9v4oYjbrlK/Q
         k+Iy7BLp9XxMHW8bzxAevstbNyUASq+HOxWD5d2vrURr7JhkOdmYiGhCfwspJ87u66YY
         a4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695135439; x=1695740239;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6IfzMj/IbN1fjwdXyBiQ/TWoVzY1A0GHR4/O9/s9kk=;
        b=GeJcD/H49wvBJMqG4SoTJo0cPpAjVH55eNk3QxHQkHoWE6/f7jZRq2Ps5+BnIqCrbl
         oDVAkbwQZLZ3N+LPwDAZrRt5SclpPJ2QQYGpQNvPjjLAdTth51srB4sRvq8RjQ8eXZNH
         E1CCJU3ITxZECQRGucOFUIgK9pv7qpbTN0RDochpGmGstyZLaKO9GJMRBbV3oFDg10XX
         TnYtXuVvBihOLKOFItIY5QO3UaLXgJ0IHEi5YD8dwMpwKQi/prh/PnHE/lbmNXHF+nYD
         Gvyn5Y/JEuRRoU8ugjKmWZI9ftlJMgJORgEzoZjRDaaxFhBH2EyydmybPp+gUTJeqJpp
         l1Zg==
X-Gm-Message-State: AOJu0Ywk/CArSDmPZsTlT93oIbyuyHgsBAKDOiaoNNaCPshQU664+h6B
	7wnqBWthGP6xzOA++kZv6aGKg7rbyO3L5Zsys20qbQ==
X-Google-Smtp-Source: AGHT+IG8dNx02ayBAg+YtcxkOF7UsVO8JC7DzAEWyEFHNukBKWX6UTLTdtbbMB9HOREu8b/ruTefyw==
X-Received: by 2002:a05:6a20:7d9a:b0:157:64e4:4260 with SMTP id v26-20020a056a207d9a00b0015764e44260mr8737633pzj.9.1695135438406;
        Tue, 19 Sep 2023 07:57:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bt28-20020a63291c000000b005776aeea638sm8385409pgb.21.2023.09.19.07.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:57:17 -0700 (PDT)
Message-ID: <6509b6cd.630a0220.26315.cc28@mx.google.com>
Date: Tue, 19 Sep 2023 07:57:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39
X-Kernelci-Report-Type: build
Subject: cip/linux-5.10.y-cip build: 114 builds: 0 failed, 114 passed,
 87 warnings (v5.10.194-cip39)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 14:57:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13155

cip/linux-5.10.y-cip build: 114 builds: 0 failed, 114 passed, 87 warnings (=
v5.10.194-cip39)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-5.10.y-cip/=
kernel/v5.10.194-cip39/

Tree: cip
Branch: linux-5.10.y-cip
Git Describe: v5.10.194-cip39
Git Commit: ecda23c2ad8c5eae1f19054d0b67a7904546b7f4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
Built: 4 unique architectures

Warnings Detected:

arm64:
    cip://5.10.y-cip/arm64/qemu_arm64_defconfig (gcc-10): 1 warning
    defconfig (gcc-10): 1 warning
    defconfig+arm64-chromebook (gcc-10): 1 warning
    defconfig+kselftest (gcc-10): 1 warning

arm:
    aspeed_g4_defconfig (gcc-10): 1 warning
    aspeed_g5_defconfig (gcc-10): 1 warning
    at91_dt_defconfig (gcc-10): 1 warning
    axm55xx_defconfig (gcc-10): 1 warning
    badge4_defconfig (gcc-10): 1 warning
    bcm2835_defconfig (gcc-10): 1 warning
    cip://5.10.y-cip/arm/qemu_arm_defconfig (gcc-10): 1 warning
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

riscv:
    cip://5.10.y-cip/riscv/qemu_riscv64_defconfig (gcc-10): 1 warning
    defconfig (gcc-10): 1 warning
    rv32_defconfig (gcc-10): 5 warnings

x86_64:
    cip://5.10.y-cip/x86/cip_qemu_defconfig (gcc-10): 1 warning
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+kselftest (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning


Warnings summary:

    83   drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of=
 =E2=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 q=
ualifier from pointer target type [-Wdiscarded-qualifiers]
    2    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    2    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]

Section mismatches summary:

    1    WARNING: modpost: vmlinux.o(___ksymtab_gpl+ixp4xx_irq_init+0x0): S=
ection mismatch in reference from the variable __ksymtab_ixp4xx_irq_init to=
 the function .init.text:ixp4xx_irq_init()

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
am200epdkit_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

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
axm55xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

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
cerfcube_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
cip://5.10.y-cip/arm/qemu_arm_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 err=
ors, 1 warning, 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
cip://5.10.y-cip/arm64/qemu_arm64_defconfig (arm64, gcc-10) =E2=80=94 PASS,=
 0 errors, 1 warning, 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
cip://5.10.y-cip/riscv/qemu_riscv64_defconfig (riscv, gcc-10) =E2=80=94 PAS=
S, 0 errors, 1 warning, 0 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

---------------------------------------------------------------------------=
-----
cip://5.10.y-cip/x86/cip_qemu_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 =
errors, 1 warning, 0 section mismatches

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
davinci_all_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

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
gemini_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

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
hisi_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

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
mps2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

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
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

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
realview_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

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
vt8500_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of =E2=
=80=98device_get_match_data=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]

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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

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


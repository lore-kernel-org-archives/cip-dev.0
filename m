Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916BEC10F05
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:03:46 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.83421.1701954222643269690
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:03:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qgmwlCha;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d0c94397c0so6107165ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 05:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701954222; x=1702559022; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=68bH6RZ6L/iEyN1f4aMqQXqcQisyYXkUl/C8h1aWaQE=;
        b=qgmwlChaXfegUtXejprijpQYgCTcow55fETBUe8t4NkZLB0NafKxqdLtkEKtSNEqLV
         u2K5qW1PSgK1cIvHK/DWKwnWw5uXv20nKzSZ+e2j7m2qX1xh5Xjm7M26QHoH6M00Ifpy
         in1uOMzd3U75Ej5goAHgMIyxuiY+lDTMlfKe+ZQ981IPEwxi08r0lwWrR7pXEBhfrgAx
         w+xnIJBF0DHkXJJwauHuqzYeqFOnnqU+6dDGBAdD8VKH1ChtQqYIzV8CosPrx0E8H71j
         mOFLBU3WIboKgIRa6cqNPQbwS2O6L/RREFTdLO164OJxUl0nPYy2+v6C6pnHcPfNYUyd
         2MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701954222; x=1702559022;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68bH6RZ6L/iEyN1f4aMqQXqcQisyYXkUl/C8h1aWaQE=;
        b=N4/inT6EXbyY0jRu+dqHV1nlGRA9fr+UMBbgUtBQezsqim1MnayUQobb3MN8ry0bZA
         GPgy5Cn2HTOctBeakxtwskiKUJl/3uKvN64Ngr+ot3S7F0S/UJFqeZ7Ir1+gTUcPF+Al
         H4Qb2/7+Y7AsoqwhseB6u6DcI9gxGsC4LwYOWADS/awGeesIhPhT2DcvO51jZGp77DMn
         rvdQOZIsxTEIqezm4Rmzw+G7ZpRm/AjZzPZACkeapoRpGlAGfRxCi9lUtlh93XwvvmQj
         iohgY5+4MGCMXMESvhGMSBOUVX4mj5iQpIvv+0JGN4xDTeHhSSBnc1d4XRp9D0rz6D4W
         w3Ag==
X-Gm-Message-State: AOJu0Yy4DZyNJwpbJ6l03RXcxsQK/p3707Img+1Ts9iGNStkqF09SXrw
	EWR7MfBNq/9V4RBk+AQk8DZuUCXfQ4G6hNcuv8lcsA==
X-Google-Smtp-Source: AGHT+IGPOVbCkVGoYR19ZVfJcEov39gkoY19dkhltIkuFq+/yaNUKFyHbJPuRddxDsUATUHoJqOOmA==
X-Received: by 2002:a17:902:a601:b0:1d0:80a7:2b45 with SMTP id u1-20020a170902a60100b001d080a72b45mr1856242plq.72.1701954221164;
        Thu, 07 Dec 2023 05:03:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902b41200b001cfb4d36eb1sm1330670plr.215.2023.12.07.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:03:40 -0800 (PST)
Message-ID: <6571c2ac.170a0220.11741.29e8@mx.google.com>
Date: Thu, 07 Dec 2023 05:03:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip build: 113 builds: 1 failed, 112 passed, 1 error,
 87 warnings (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:03:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13833

cip/linux-5.10.y-cip build: 113 builds: 1 failed, 112 passed, 1 error, 87 w=
arnings (v5.10.201-cip41-16-g3c85fba3b6e5d)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-5.10.y-cip/=
kernel/v5.10.201-cip41-16-g3c85fba3b6e5d/

Tree: cip
Branch: linux-5.10.y-cip
Git Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
Git Commit: 3c85fba3b6e5da8b112e7ecd142649674648028f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
Built: 4 unique architectures

Build Failure Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

Errors and Warnings Detected:

arm64:
    cip://5.10.y-cip/arm64/qemu_arm64_defconfig (gcc-10): 1 warning
    defconfig (gcc-10): 1 warning
    defconfig+arm64-chromebook (gcc-10): 1 error, 1 warning
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
    x86_64_defconfig+x86-board (gcc-10): 1 warning

Errors summary:

    1    drivers/interconnect/qcom/sc7180.c:158:3: error: =E2=80=98struct q=
com_icc_bcm=E2=80=99 has no member named =E2=80=98enable_mask=E2=80=99

Warnings summary:

    82   drivers/i2c/i2c-core-base.c:101:31: warning: passing argument 1 of=
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 war=
ning, 0 section mismatches

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


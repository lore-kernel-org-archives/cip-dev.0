Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F99C433FE
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 14:53:59 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.6540.1664549630154678292
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 07:53:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=rIezJGLZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id
 u59-20020a17090a51c100b00205d3c44162so9331917pjh.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=4q4bJOyrvXfRbapVKLa3W6edWYYPB2Gvf6U4Fp8p+Qo=;
        b=rIezJGLZk0NgVKf584APcBh8w4ZbfKKx7/6iZKwk1+Bh3XWGJC8YZuUt+kb8l5NXXE
         ZtRLsbM4DpgpHop+H+tdrYLTWFgcIEZ5gXCbnvlBaOk+Yk7WTPUqvH1gKDkg0u8fZdQU
         fFosOBk3Ao1qtLIFdYB9icvYz1/Uv6/LtO+SM2ZswLLXOPRc4Ho/ZJAvAbK6bYggnWZC
         /Pl0aNLCuRE5h/r79g+FBfTAf88b7pXbmoTqjWnH0gvXPQDAj4lgedy7yJCptFf3envP
         YEXJsFFPhhRUmxuZN9Q6VmpL9LXczSucyytcRCjGdeTlwZgCAbhlcNOpcdHWiShEi0XT
         /BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=4q4bJOyrvXfRbapVKLa3W6edWYYPB2Gvf6U4Fp8p+Qo=;
        b=LnMwzgQMeDBnlVWbTsh7Ml3z7bx5Ks8CkB7svXnC0gBOTw+6xUvHTCuA09uSVS9gC3
         cs0MF7zzpqO8BEC38FOtYQlXksupc/bjlq2PzYpLC/fsydHZ53fGPgnfICPhPEIFTmUW
         uVWUD3+PNfdM8tTE0F2El6/WUQaXu00VQF61/1UXkqx6iwOxwIbbztP+uQetesiSLJvT
         wFUYuaHrv1HofzMgEDhMcDxvXATbSfUjXiXPcdhWxSyk00Xh+O0HmaD41J608Jv63Dsp
         Z0HtkMFL/qBOaXYvpwMpqTBOKT2jexjU+i6bWW4uqWXpE6dsHn6c0R8je8/STLlbu6jJ
         hMBQ==
X-Gm-Message-State: ACrzQf2mzQqqhZTohGPIx+WBcFjC8gii69iXD9p9aKE12G2GKpebnpY7
	+uU1eS0K8RgRGurMGBBMNueR9MmzAU8T/9ni6sw=
X-Google-Smtp-Source: 
 AMsMyM77GDsBh/V73hLjJh83/XAtmpjRqxmIrfSdVjOSQ9Rik6Td2EAgwaNySxyNNEQpf+P/4cvEAA==
X-Received: by 2002:a17:903:230d:b0:178:29a3:df38 with SMTP id
 d13-20020a170903230d00b0017829a3df38mr9166713plh.10.1664549628153;
        Fri, 30 Sep 2022 07:53:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n10-20020a170903404a00b00172a670607asm1923250pla.300.2022.09.30.07.53.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:53:47 -0700 (PDT)
Message-ID: <633702fb.170a0220.66a8.3861@mx.google.com>
Date: Fri, 30 Sep 2022 07:53:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.4.302-cip70-98-gb2bfffe124dae
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test build: 185 builds: 5 failed,
 180 passed,
 8 errors, 196 warnings (v4.4.302-cip70-98-gb2bfffe124dae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 14:53:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9588

cip-gitlab/ci/pavel/linux-test build: 185 builds: 5 failed, 180 passed, 8 e=
rrors, 196 warnings (v4.4.302-cip70-98-gb2bfffe124dae)

Full Build Summary: https://kernelci.org/build/cip-gitlab/branch/ci%2Fpavel=
%2Flinux-test/kernel/v4.4.302-cip70-98-gb2bfffe124dae/

Tree: cip-gitlab
Branch: ci/pavel/linux-test
Git Describe: v4.4.302-cip70-98-gb2bfffe124dae
Git Commit: b2bfffe124dae9fd793da3a9d45f286a98412d6b
Git URL: https://gitlab.com/cip-project/cip-kernel/linux-cip.git
Built: 5 unique architectures

Build Failures Detected:

arm:
    rpc_defconfig: (gcc-10) FAIL

mips:
    fuloong2e_defconfig: (gcc-10) FAIL
    ip27_defconfig: (gcc-10) FAIL
    ip28_defconfig: (gcc-10) FAIL
    lemote2f_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:
    axs103_defconfig (gcc-10): 1 warning
    axs103_smp_defconfig (gcc-10): 1 warning
    nsim_hs_defconfig (gcc-10): 1 warning
    nsim_hs_smp_defconfig (gcc-10): 1 warning
    nsimosci_hs_defconfig (gcc-10): 1 warning
    nsimosci_hs_smp_defconfig (gcc-10): 1 warning
    vdk_hs38_defconfig (gcc-10): 1 warning
    vdk_hs38_smp_defconfig (gcc-10): 1 warning

arm:
    acs5k_defconfig (gcc-10): 1 warning
    acs5k_tiny_defconfig (gcc-10): 1 warning
    am200epdkit_defconfig (gcc-10): 1 warning
    assabet_defconfig (gcc-10): 1 warning
    at91_dt_defconfig (gcc-10): 1 warning
    axm55xx_defconfig (gcc-10): 1 warning
    badge4_defconfig (gcc-10): 1 warning
    bcm2835_defconfig (gcc-10): 1 warning
    bcm_defconfig (gcc-10): 1 warning
    cerfcube_defconfig (gcc-10): 1 warning
    clps711x_defconfig (gcc-10): 2 warnings
    cm_x2xx_defconfig (gcc-10): 1 warning
    cm_x300_defconfig (gcc-10): 1 warning
    colibri_pxa270_defconfig (gcc-10): 1 warning
    colibri_pxa300_defconfig (gcc-10): 1 warning
    collie_defconfig (gcc-10): 1 warning
    corgi_defconfig (gcc-10): 1 warning
    davinci_all_defconfig (gcc-10): 2 warnings
    dove_defconfig (gcc-10): 1 warning
    ebsa110_defconfig (gcc-10): 1 warning
    efm32_defconfig (gcc-10): 1 warning
    em_x270_defconfig (gcc-10): 1 warning
    ep93xx_defconfig (gcc-10): 1 warning
    eseries_pxa_defconfig (gcc-10): 1 warning
    exynos_defconfig (gcc-10): 1 warning
    ezx_defconfig (gcc-10): 1 warning
    footbridge_defconfig (gcc-10): 1 warning
    h3600_defconfig (gcc-10): 1 warning
    h5000_defconfig (gcc-10): 1 warning
    hackkit_defconfig (gcc-10): 1 warning
    hisi_defconfig (gcc-10): 1 warning
    imote2_defconfig (gcc-10): 1 warning
    imx_v4_v5_defconfig (gcc-10): 1 warning
    imx_v6_v7_defconfig (gcc-10): 1 warning
    integrator_defconfig (gcc-10): 1 warning
    iop13xx_defconfig (gcc-10): 1 warning
    iop32x_defconfig (gcc-10): 1 warning
    iop33x_defconfig (gcc-10): 1 warning
    ixp4xx_defconfig (gcc-10): 1 warning
    jornada720_defconfig (gcc-10): 1 warning
    keystone_defconfig (gcc-10): 1 warning
    ks8695_defconfig (gcc-10): 1 warning
    lart_defconfig (gcc-10): 1 warning
    lpc18xx_defconfig (gcc-10): 1 warning
    lpc32xx_defconfig (gcc-10): 2 warnings
    lpd270_defconfig (gcc-10): 1 warning
    lubbock_defconfig (gcc-10): 1 warning
    magician_defconfig (gcc-10): 1 warning
    mainstone_defconfig (gcc-10): 1 warning
    mini2440_defconfig (gcc-10): 2 warnings
    mmp2_defconfig (gcc-10): 1 warning
    multi_v5_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    mv78xx0_defconfig (gcc-10): 1 warning
    mvebu_v5_defconfig (gcc-10): 1 warning
    mvebu_v7_defconfig (gcc-10): 1 warning
    mxs_defconfig (gcc-10): 2 warnings
    neponset_defconfig (gcc-10): 1 warning
    netwinder_defconfig (gcc-10): 1 warning
    netx_defconfig (gcc-10): 1 warning
    nhk8815_defconfig (gcc-10): 1 warning
    omap1_defconfig (gcc-10): 2 warnings
    omap2plus_defconfig (gcc-10): 2 warnings
    orion5x_defconfig (gcc-10): 1 warning
    palmz72_defconfig (gcc-10): 1 warning
    pcm027_defconfig (gcc-10): 1 warning
    pleb_defconfig (gcc-10): 1 warning
    pxa168_defconfig (gcc-10): 1 warning
    pxa255-idp_defconfig (gcc-10): 1 warning
    pxa3xx_defconfig (gcc-10): 1 warning
    pxa910_defconfig (gcc-10): 1 warning
    qcom_defconfig (gcc-10): 1 warning
    raumfeld_defconfig (gcc-10): 1 warning
    realview-smp_defconfig (gcc-10): 1 warning
    realview_defconfig (gcc-10): 1 warning
    rpc_defconfig (gcc-10): 4 errors
    s3c2410_defconfig (gcc-10): 2 warnings
    s3c6400_defconfig (gcc-10): 2 warnings
    sama5_defconfig (gcc-10): 1 warning
    shannon_defconfig (gcc-10): 1 warning
    shmobile_defconfig (gcc-10): 1 warning
    simpad_defconfig (gcc-10): 1 warning
    socfpga_defconfig (gcc-10): 1 warning
    spear13xx_defconfig (gcc-10): 1 warning
    spitz_defconfig (gcc-10): 1 warning
    sunxi_defconfig (gcc-10): 1 warning
    tegra_defconfig (gcc-10): 1 warning
    trizeps4_defconfig (gcc-10): 1 warning
    u8500_defconfig (gcc-10): 1 warning
    versatile_defconfig (gcc-10): 1 warning
    vexpress_defconfig (gcc-10): 1 warning
    viper_defconfig (gcc-10): 1 warning
    vt8500_v6_v7_defconfig (gcc-10): 1 warning
    xcep_defconfig (gcc-10): 1 warning
    zeus_defconfig (gcc-10): 1 warning

i386:
    i386_defconfig (gcc-10): 5 warnings

mips:
    ar7_defconfig (gcc-10): 1 warning
    ath79_defconfig (gcc-10): 1 warning
    bcm47xx_defconfig (gcc-10): 1 warning
    bcm63xx_defconfig (gcc-10): 1 warning
    bigsur_defconfig (gcc-10): 1 warning
    bmips_be_defconfig (gcc-10): 1 warning
    bmips_stb_defconfig (gcc-10): 1 warning
    capcella_defconfig (gcc-10): 1 warning
    cavium_octeon_defconfig (gcc-10): 1 warning
    ci20_defconfig (gcc-10): 1 warning
    cobalt_defconfig (gcc-10): 1 warning
    db1xxx_defconfig (gcc-10): 1 warning
    decstation_defconfig (gcc-10): 1 warning
    fuloong2e_defconfig (gcc-10): 2 errors
    gpr_defconfig (gcc-10): 1 warning
    ip22_defconfig (gcc-10): 2 warnings
    ip32_defconfig (gcc-10): 1 warning
    jazz_defconfig (gcc-10): 1 warning
    jmr3927_defconfig (gcc-10): 1 warning
    lasat_defconfig (gcc-10): 1 warning
    lemote2f_defconfig (gcc-10): 2 errors
    loongson3_defconfig (gcc-10): 1 warning
    ls1b_defconfig (gcc-10): 1 warning
    malta_defconfig (gcc-10): 1 warning
    malta_kvm_defconfig (gcc-10): 1 warning
    malta_kvm_guest_defconfig (gcc-10): 1 warning
    malta_qemu_32r6_defconfig (gcc-10): 1 warning
    maltaaprp_defconfig (gcc-10): 1 warning
    maltasmvp_defconfig (gcc-10): 1 warning
    maltasmvp_eva_defconfig (gcc-10): 1 warning
    maltaup_defconfig (gcc-10): 1 warning
    maltaup_xpa_defconfig (gcc-10): 1 warning
    markeins_defconfig (gcc-10): 1 warning
    mips_paravirt_defconfig (gcc-10): 1 warning
    mpc30x_defconfig (gcc-10): 1 warning
    msp71xx_defconfig (gcc-10): 1 warning
    mtx1_defconfig (gcc-10): 4 warnings
    nlm_xlp_defconfig (gcc-10): 1 warning
    nlm_xlr_defconfig (gcc-10): 1 warning
    pnx8335_stb225_defconfig (gcc-10): 1 warning
    qi_lb60_defconfig (gcc-10): 1 warning
    rb532_defconfig (gcc-10): 1 warning
    rbtx49xx_defconfig (gcc-10): 1 warning
    rm200_defconfig (gcc-10): 1 warning
    rt305x_defconfig (gcc-10): 1 warning
    sb1250_swarm_defconfig (gcc-10): 1 warning
    sead3_defconfig (gcc-10): 1 warning
    sead3micro_defconfig (gcc-10): 1 warning
    tb0219_defconfig (gcc-10): 1 warning
    tb0226_defconfig (gcc-10): 1 warning
    tb0287_defconfig (gcc-10): 1 warning
    workpad_defconfig (gcc-10): 1 warning
    xway_defconfig (gcc-10): 1 warning

x86_64:
    allnoconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 9 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 9 warnings

Errors summary:

    4    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=
=80=98-mhard-float=E2=80=99
    2    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
    2    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-marc=
h=3D=E2=80=99

Warnings summary:

    147  net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses ar=
ound =E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    8    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses ar=
ound '+' in operand of '&' [-Wparentheses]
    7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    4    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    4    arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic s=
uffix given and no register operands; using default for `sysret'
    3    ld: warning: creating DT_TEXTREL in a PIE
    3    drivers/tty/serial/samsung.c:1776:34: warning: array =E2=80=98s3c2=
4xx_uart_dt_match=E2=80=99 assumed to have one element
    3    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-alloc=
atable section.
    3    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable s=
ection.
    2    sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration 1073=
741824 invokes undefined behavior [-Waggressive-loop-optimizations]
    2    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    1    sound/pci/echoaudio/echoaudio_dsp.c:658:9: warning: iteration 1073=
741824 invokes undefined behavior [-Waggressive-loop-optimizations]
    1    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    1    drivers/net/ethernet/seeq/sgiseeq.c:804:26: warning: passing argum=
ent 5 of =E2=80=98dma_free_attrs=E2=80=99 makes pointer from integer withou=
t a cast [-Wint-conversion]
    1    drivers/mmc/host/sdhci-s3c.c:429:34: warning: array =E2=80=98sdhci=
_s3c_dt_match=E2=80=99 assumed to have one element
    1    drivers/gpio/gpio-omap.c:1161:34: warning: array =E2=80=98omap_gpi=
o_match=E2=80=99 assumed to have one element
    1    drivers/cpufreq/ti-cpufreq.c:250:24: warning: passing argument 1 o=
f =E2=80=98PTR_ERR_OR_ZERO=E2=80=99 makes pointer from integer without a ca=
st [-Wint-conversion]
    1    arch/arm/mach-mxs/mach-mxs.c:285:26: warning: duplicate =E2=80=98c=
onst=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    1    arch/arm/mach-lpc32xx/phy3250.c:215:36: warning: duplicate =E2=80=
=98const=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    1    arch/arm/mach-davinci/da8xx-dt.c:23:34: warning: duplicate =E2=80=
=98const=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    1    arch/arm/mach-clps711x/board-autcpu12.c:163:26: warning: duplicate=
 =E2=80=98const=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
acs5k_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
acs5k_tiny_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sectio=
n mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

---------------------------------------------------------------------------=
-----
allnoconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
am200epdkit_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ar7_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
assabet_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
at91_dt_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ath79_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
axm55xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
axs103_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
axs103_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
badge4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bcm2835_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bcm47xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bcm63xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bcm_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section =
mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bigsur_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bmips_be_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bmips_stb_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
capcella_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
cavium_octeon_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
cerfcube_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ci20_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
clps711x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 se=
ction mismatches

Warnings:
    arch/arm/mach-clps711x/board-autcpu12.c:163:26: warning: duplicate =E2=
=80=98const=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
cm_x2xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
cm_x300_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
cobalt_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
colibri_pxa270_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
colibri_pxa300_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
collie_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
corgi_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
davinci_all_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0=
 section mismatches

Warnings:
    arch/arm/mach-davinci/da8xx-dt.c:23:34: warning: duplicate =E2=80=98con=
st=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
db1xxx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
decstation_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
dove_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
e55_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
ebsa110_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
efm32_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
em_x270_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ep93xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
eseries_pxa_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
exynos_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ezx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section =
mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
footbridge_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
fuloong2e_defconfig (mips, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 =
section mismatches

Errors:
    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=
=98-mhard-float=E2=80=99
    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=
=98-mhard-float=E2=80=99

---------------------------------------------------------------------------=
-----
gpr_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
h3600_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
h5000_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
hackkit_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
hisi_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imote2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
imx_v4_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
integrator_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
iop13xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
iop32x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
iop33x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ip22_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 secti=
on mismatches

Warnings:
    drivers/net/ethernet/seeq/sgiseeq.c:804:26: warning: passing argument 5=
 of =E2=80=98dma_free_attrs=E2=80=99 makes pointer from integer without a c=
ast [-Wint-conversion]
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

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
ip32_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ixp4xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
jazz_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
jmr3927_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
jornada720_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
keystone_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ks8695_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lart_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lasat_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lemote2f_defconfig (mips, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 s=
ection mismatches

Errors:
    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=
=98-mhard-float=E2=80=99
    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=
=98-mhard-float=E2=80=99

---------------------------------------------------------------------------=
-----
loongson3_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lpc18xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lpc32xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sec=
tion mismatches

Warnings:
    arch/arm/mach-lpc32xx/phy3250.c:215:36: warning: duplicate =E2=80=98con=
st=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lpd270_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ls1b_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lubbock_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
magician_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mainstone_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
malta_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
malta_kvm_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
malta_kvm_guest_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warnin=
g, 0 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
malta_qemu_32r6_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warnin=
g, 0 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
maltaaprp_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
maltasmvp_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
maltasmvp_eva_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
maltaup_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
maltaup_xpa_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
markeins_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mini2440_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    drivers/tty/serial/samsung.c:1776:34: warning: array =E2=80=98s3c24xx_u=
art_dt_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
mips_paravirt_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning,=
 0 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mmp2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mpc30x_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
msp71xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mtx1_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration 107374182=
4 invokes undefined behavior [-Waggressive-loop-optimizations]
    sound/pci/echoaudio/echoaudio_dsp.c:658:9: warning: iteration 107374182=
4 invokes undefined behavior [-Waggressive-loop-optimizations]
    sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration 107374182=
4 invokes undefined behavior [-Waggressive-loop-optimizations]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mv78xx0_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mvebu_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mvebu_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mxs_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    arch/arm/mach-mxs/mach-mxs.c:285:26: warning: duplicate =E2=80=98const=
=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
neponset_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
netwinder_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
netx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
nhk8815_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
nlm_xlp_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
nlm_xlr_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
nsim_hs_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
nsim_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
nsimosci_hs_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
nsimosci_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning=
, 0 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
nuc910_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
nuc950_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
nuc960_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
omap1_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 secti=
on mismatches

Warnings:
    drivers/gpio/gpio-omap.c:1161:34: warning: array =E2=80=98omap_gpio_mat=
ch=E2=80=99 assumed to have one element
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    drivers/cpufreq/ti-cpufreq.c:250:24: warning: passing argument 1 of =E2=
=80=98PTR_ERR_OR_ZERO=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
orion5x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
palmz72_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pcm027_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pleb_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pnx8335_stb225_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning=
, 0 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
prima2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
pxa168_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pxa255-idp_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 s=
ection mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pxa3xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pxa910_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
qcom_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
qi_lb60_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
raumfeld_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
rb532_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
rbtx49xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
realview-smp_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
realview_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
rm200_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
rpc_defconfig (arm, gcc-10) =E2=80=94 FAIL, 4 errors, 0 warnings, 0 section=
 mismatches

Errors:
    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=
=E2=80=99
    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=
=E2=80=99

---------------------------------------------------------------------------=
-----
rt305x_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
s3c2410_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    drivers/tty/serial/samsung.c:1776:34: warning: array =E2=80=98s3c24xx_u=
art_dt_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
s3c6400_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sec=
tion mismatches

Warnings:
    drivers/mmc/host/sdhci-s3c.c:429:34: warning: array =E2=80=98sdhci_s3c_=
dt_match=E2=80=99 assumed to have one element
    drivers/tty/serial/samsung.c:1776:34: warning: array =E2=80=98s3c24xx_u=
art_dt_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
s5pv210_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
sama5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
sb1250_swarm_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, =
0 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
sead3_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
sead3micro_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
shannon_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
shmobile_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
simpad_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
socfpga_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
spear13xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
spear3xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
spear6xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
spitz_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
stm32_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
sunxi_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
tb0219_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
tb0226_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
tb0287_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
tct_hammer_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
tegra_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
tinyconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section=
 mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

---------------------------------------------------------------------------=
-----
tinyconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
tinyconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
trizeps4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
u300_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
u8500_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
vdk_hs38_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
vdk_hs38_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
versatile_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
vf610m4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
viper_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
vt8500_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0=
 section mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
workpad_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 9 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
9 warnings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
xcep_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
xilfpga_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
xway_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
zeus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
zx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---
For more info write to <info@kernelci.org>


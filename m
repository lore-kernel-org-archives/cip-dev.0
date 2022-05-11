X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web10.10834.1652271985356730095
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 05:26:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Gx93Qknr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id r71so1325070pgr.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3sHXLTXWeQlWWGxVt2pHQ4QC6TkKiTR1RT7EzJNE3r8=;
        b=Gx93Qknrc1/0vTgryIB1BMm0z/A1RM2g/Xq1JSCykc+yjTbOwU+uKf7TDTfOulKI+P
         +YoHt8gKOwkQ48unQympplgsQ+ntr73uKZaK295/Cd0BWipTERJA1QeM0rW4R9syxloK
         5FaG3rGKfwwb5urpHkptIb5TmHxAabfF+fCRS5Kg8NsA5JDvHNgDrvx3lNB3i5EcTEe+
         ssWSGneGF47ptmWM9s/MURFk6JsV06tAHUQj1TsxKpdnQTvIsK7b2bAECaL7bqMs8iRB
         5G8+bvBvhL5VPgegrLzhS6LrlxsJfomKY1RKDZ9J+gqIZLyjrCaCwus8gN7m6j3gm9dg
         t7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3sHXLTXWeQlWWGxVt2pHQ4QC6TkKiTR1RT7EzJNE3r8=;
        b=rEFO8At7tdN1LDh7ZvxZ6Mmepe7TbGcttTNu4F6f1mEngRp7o8l04CcCGBNhHYaaEA
         6xiaYnBSpG7H8okGi7wtN5rRFJjBYZxQJCnSaY2K0atGKtnhdxszsWVKrOtcgZ6AjPHi
         n0XPl3LGjq+3f0Y5Hd1hvQ//hanFdpG+WtBkJs4oFWjtFHpNLnJEy2S089XonFuwDDIo
         f4xeJvxN06bumZyWisqDS5TwEngGMfGaaZWmNU0HbqFPMX+8R7IJIkwO9zj2BKjNrZNS
         HoIP72KLnN+i4HonBF3gDOZrryHj28kHhklBspbNVFgDw4SjfOWaOr3mJiUZQ04qauut
         smuw==
X-Gm-Message-State: AOAM531GK5Wzs1UaqFrQUfsvilS8U4PPRNeiMS39mt25IDHrer3aamsg
	CHPkkk76RZAnyKxakHALYMCXeI1uuC0OXGoxqsE=
X-Google-Smtp-Source: ABdhPJyRC0FR9CkmmobKhjiyV8ZSwKySV/wFsDedznuUD+cDuDxnwkITZybjjFDU6o64jjP92qaTOA==
X-Received: by 2002:a63:6c0a:0:b0:3ab:894f:8309 with SMTP id h10-20020a636c0a000000b003ab894f8309mr20730712pgc.536.1652271983209;
        Wed, 11 May 2022 05:26:23 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w63-20020a628242000000b0050dc7628151sm1596433pfd.43.2022.05.11.05.26.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 05:26:22 -0700 (PDT)
Message-ID: <627bab6e.1c69fb81.bac90.32c5@mx.google.com>
Date: Wed, 11 May 2022 05:26:22 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: build
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-23-gf7cf04ab668f1
Subject: cip-gitlab/ci/pavel/linux-test build: 188 builds: 31 failed, 157 passed, 72 errors, 86 warnings (v4.4-st5-23-gf7cf04ab668f1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test build: 188 builds: 31 failed, 157 passed, 72=
 errors, 86 warnings (v4.4-st5-23-gf7cf04ab668f1)

Full Build Summary: https://kernelci.org/build/cip-gitlab/branch/ci%2Fpavel=
%2Flinux-test/kernel/v4.4-st5-23-gf7cf04ab668f1/

Tree: cip-gitlab
Branch: ci/pavel/linux-test
Git Describe: v4.4-st5-23-gf7cf04ab668f1
Git Commit: f7cf04ab668f124b54f47c93fca7625e6eff3cfe
Git URL: https://gitlab.com/cip-project/cip-kernel/linux-cip.git
Built: 6 unique architectures

Build Failures Detected:

arm:
    axm55xx_defconfig: (gcc-10) FAIL
    bcm_defconfig: (gcc-10) FAIL
    cns3420vb_defconfig: (gcc-10) FAIL
    dove_defconfig: (gcc-10) FAIL
    exynos_defconfig: (gcc-10) FAIL
    hisi_defconfig: (gcc-10) FAIL
    imx_v6_v7_defconfig: (gcc-10) FAIL
    keystone_defconfig: (gcc-10) FAIL
    mmp2_defconfig: (gcc-10) FAIL
    multi_v7_defconfig: (gcc-10) FAIL
    mvebu_v7_defconfig: (gcc-10) FAIL
    omap2plus_defconfig: (gcc-10) FAIL
    prima2_defconfig: (gcc-10) FAIL
    qcom_defconfig: (gcc-10) FAIL
    rpc_defconfig: (gcc-10) FAIL
    s5pv210_defconfig: (gcc-10) FAIL
    sama5_defconfig: (gcc-10) FAIL
    shmobile_defconfig: (gcc-10) FAIL
    socfpga_defconfig: (gcc-10) FAIL
    spear13xx_defconfig: (gcc-10) FAIL
    sunxi_defconfig: (gcc-10) FAIL
    tegra_defconfig: (gcc-10) FAIL
    u8500_defconfig: (gcc-10) FAIL
    vexpress_defconfig: (gcc-10) FAIL
    vt8500_v6_v7_defconfig: (gcc-10) FAIL
    zx_defconfig: (gcc-10) FAIL

i386:
    i386_defconfig: (gcc-10) FAIL

mips:
    fuloong2e_defconfig: (gcc-10) FAIL
    ip27_defconfig: (gcc-10) FAIL
    ip28_defconfig: (gcc-10) FAIL
    lemote2f_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 1 warning
    defconfig+arm64-chromebook (gcc-10): 1 warning

arm:
    axm55xx_defconfig (gcc-10): 2 errors, 2 warnings
    bcm_defconfig (gcc-10): 2 errors, 2 warnings
    clps711x_defconfig (gcc-10): 1 warning
    cns3420vb_defconfig (gcc-10): 2 errors, 2 warnings
    davinci_all_defconfig (gcc-10): 1 warning
    dove_defconfig (gcc-10): 2 errors, 2 warnings
    exynos_defconfig (gcc-10): 2 errors, 2 warnings
    hisi_defconfig (gcc-10): 2 errors, 2 warnings
    imx_v6_v7_defconfig (gcc-10): 2 errors, 2 warnings
    keystone_defconfig (gcc-10): 2 errors, 2 warnings
    lpc32xx_defconfig (gcc-10): 1 warning
    mini2440_defconfig (gcc-10): 1 warning
    mmp2_defconfig (gcc-10): 2 errors, 2 warnings
    multi_v7_defconfig (gcc-10): 6 errors, 3 warnings
    mvebu_v7_defconfig (gcc-10): 2 errors, 2 warnings
    mxs_defconfig (gcc-10): 1 warning
    omap1_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 2 errors, 2 warnings
    prima2_defconfig (gcc-10): 2 errors, 2 warnings
    qcom_defconfig (gcc-10): 3 errors, 1 warning
    rpc_defconfig (gcc-10): 2 errors
    s3c2410_defconfig (gcc-10): 1 warning
    s3c6400_defconfig (gcc-10): 2 warnings
    s5pv210_defconfig (gcc-10): 2 errors, 2 warnings
    sama5_defconfig (gcc-10): 2 errors, 2 warnings
    shmobile_defconfig (gcc-10): 2 errors, 2 warnings
    socfpga_defconfig (gcc-10): 2 errors, 2 warnings
    spear13xx_defconfig (gcc-10): 2 errors, 2 warnings
    sunxi_defconfig (gcc-10): 6 errors, 3 warnings
    tegra_defconfig (gcc-10): 2 errors, 2 warnings
    u8500_defconfig (gcc-10): 2 errors, 2 warnings
    vexpress_defconfig (gcc-10): 6 errors, 3 warnings
    vt8500_v6_v7_defconfig (gcc-10): 2 errors, 2 warnings
    zx_defconfig (gcc-10): 3 errors, 1 warning

i386:
    i386_defconfig (gcc-10): 2 errors, 1 warning

mips:
    fuloong2e_defconfig (gcc-10): 2 errors
    ip22_defconfig (gcc-10): 1 warning
    lemote2f_defconfig (gcc-10): 2 errors
    mtx1_defconfig (gcc-10): 3 warnings

x86_64:
    allnoconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 6 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 6 warnings

Errors summary:

    25   include/linux/err.h:23:35: error: conflicting types for =E2=80=98E=
RR_PTR=E2=80=99
    25   include/linux/bpf.h:204:9: error: implicit declaration of function=
 =E2=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    4    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=
=80=98-mhard-float=E2=80=99
    3    include/linux/arm-smccc.h:321:13: error: =E2=80=98SMCCC_CONDUIT_NO=
NE=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98=
PSCI_CONDUIT_NONE=E2=80=99?
    3    include/linux/arm-smccc.h:316:8: error: =E2=80=98SMCCC_CONDUIT_SMC=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98PS=
CI_CONDUIT_SMC=E2=80=99?
    3    include/linux/arm-smccc.h:313:8: error: =E2=80=98SMCCC_CONDUIT_HVC=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98PS=
CI_CONDUIT_HVC=E2=80=99?
    3    include/linux/arm-smccc.h:311:16: error: implicit declaration of f=
unction =E2=80=98arm_smccc_1_1_get_conduit=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
    2    include/linux/bpf.h:204:18: error: =E2=80=98EOPNOTSUPP=E2=80=99 un=
declared (first use in this function)
    2    arch/x86/include/asm/nospec-branch.h:166:2: error: expected =E2=80=
=98:=E2=80=99 or =E2=80=98)=E2=80=99 before =E2=80=98ANNOTATE_RETPOLINE_SAF=
E=E2=80=99
    1    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
    1    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-marc=
h=3D=E2=80=99

Warnings summary:

    28   cc1: some warnings being treated as errors
    23   include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=
=99 from a function with return type =E2=80=98struct bpf_prog *=E2=80=99 ma=
kes pointer from integer without a cast [-Wint-conversion]
    7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    4    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    4    arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic s=
uffix given and no register operands; using default for `sysret'
    3    drivers/tty/serial/samsung.c:1780:34: warning: array =E2=80=98s3c2=
4xx_uart_dt_match=E2=80=99 assumed to have one element
    2    sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration 1073=
741824 invokes undefined behavior [-Waggressive-loop-optimizations]
    2    ld: warning: creating DT_TEXTREL in a PIE
    2    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    2    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: a=
rray =E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element
    1    sound/pci/echoaudio/echoaudio_dsp.c:658:9: warning: iteration 1073=
741824 invokes undefined behavior [-Waggressive-loop-optimizations]
    1    drivers/net/ethernet/seeq/sgiseeq.c:804:26: warning: passing argum=
ent 5 of =E2=80=98dma_free_attrs=E2=80=99 makes pointer from integer withou=
t a cast [-Wint-conversion]
    1    drivers/mmc/host/sdhci-s3c.c:429:34: warning: array =E2=80=98sdhci=
_s3c_dt_match=E2=80=99 assumed to have one element
    1    drivers/gpio/gpio-omap.c:1161:34: warning: array =E2=80=98omap_gpi=
o_match=E2=80=99 assumed to have one element
    1    arch/x86/kernel/irq_32.c:75:23: warning: unused variable =E2=80=98=
arg1=E2=80=99 [-Wunused-variable]
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
acs5k_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
acs5k_tiny_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
allnoconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
assabet_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
at91_dt_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
ath79_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
axm55xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

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
badge4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
bcm2835_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
bcm_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 section=
 mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

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
cerfcube_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
ci20_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
clps711x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    arch/arm/mach-clps711x/board-autcpu12.c:163:26: warning: duplicate =E2=
=80=98const=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]

---------------------------------------------------------------------------=
-----
cm_x2xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
cm_x300_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
cns3420vb_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 s=
ection mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
cobalt_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
colibri_pxa270_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings=
, 0 section mismatches

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
corgi_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
davinci_all_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    arch/arm/mach-davinci/da8xx-dt.c:23:34: warning: duplicate =E2=80=98con=
st=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]

---------------------------------------------------------------------------=
-----
db1xxx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
decstation_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: array =
=E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

Warnings:
    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: array =
=E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
dove_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

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
efm32_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
em_x270_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
ep93xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
eseries_pxa_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
exynos_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
ezx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
footbridge_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

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
gpr_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

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
hisi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 1 warning, 0 sectio=
n mismatches

Errors:
    arch/x86/include/asm/nospec-branch.h:166:2: error: expected =E2=80=98:=
=E2=80=99 or =E2=80=98)=E2=80=99 before =E2=80=98ANNOTATE_RETPOLINE_SAFE=E2=
=80=99
    arch/x86/include/asm/nospec-branch.h:166:2: error: expected =E2=80=98:=
=E2=80=99 or =E2=80=98)=E2=80=99 before =E2=80=98ANNOTATE_RETPOLINE_SAFE=E2=
=80=99

Warnings:
    arch/x86/kernel/irq_32.c:75:23: warning: unused variable =E2=80=98arg1=
=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
imote2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
imx_v4_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 s=
ection mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
integrator_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
iop13xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
iop32x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
iop33x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
ip22_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/net/ethernet/seeq/sgiseeq.c:804:26: warning: passing argument 5=
 of =E2=80=98dma_free_attrs=E2=80=99 makes pointer from integer without a c=
ast [-Wint-conversion]

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
ixp4xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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
keystone_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 se=
ction mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
ks8695_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
lart_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
lasat_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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
loongson3_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
lpc18xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
lpc32xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/arm/mach-lpc32xx/phy3250.c:215:36: warning: duplicate =E2=80=98con=
st=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]

---------------------------------------------------------------------------=
-----
lpd270_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
ls1b_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
lubbock_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
magician_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

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
markeins_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
mini2440_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/tty/serial/samsung.c:1780:34: warning: array =E2=80=98s3c24xx_u=
art_dt_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
mips_paravirt_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings=
, 0 section mismatches

---------------------------------------------------------------------------=
-----
mmp2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 sectio=
n mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
mpc30x_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
msp71xx_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
mtx1_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 secti=
on mismatches

Warnings:
    sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration 107374182=
4 invokes undefined behavior [-Waggressive-loop-optimizations]
    sound/pci/echoaudio/echoaudio_dsp.c:658:9: warning: iteration 107374182=
4 invokes undefined behavior [-Waggressive-loop-optimizations]
    sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration 107374182=
4 invokes undefined behavior [-Waggressive-loop-optimizations]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 6 errors, 3 warnings, 0 se=
ction mismatches

Errors:
    include/linux/arm-smccc.h:311:16: error: implicit declaration of functi=
on =E2=80=98arm_smccc_1_1_get_conduit=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
    include/linux/arm-smccc.h:313:8: error: =E2=80=98SMCCC_CONDUIT_HVC=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98PSCI_=
CONDUIT_HVC=E2=80=99?
    include/linux/arm-smccc.h:316:8: error: =E2=80=98SMCCC_CONDUIT_SMC=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98PSCI_=
CONDUIT_SMC=E2=80=99?
    include/linux/arm-smccc.h:321:13: error: =E2=80=98SMCCC_CONDUIT_NONE=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98PSCI_=
CONDUIT_NONE=E2=80=99?
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    cc1: some warnings being treated as errors
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
mv78xx0_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
mvebu_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
mvebu_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 se=
ction mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
mxs_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section =
mismatches

Warnings:
    arch/arm/mach-mxs/mach-mxs.c:285:26: warning: duplicate =E2=80=98const=
=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]

---------------------------------------------------------------------------=
-----
neponset_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
netwinder_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
netx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
nhk8815_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
nsim_hs_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
nsim_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

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
omap1_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/gpio/gpio-omap.c:1161:34: warning: array =E2=80=98omap_gpio_mat=
ch=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 s=
ection mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
orion5x_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
palmz72_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
pcm027_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
pleb_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
pnx8335_stb225_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
prima2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 sect=
ion mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

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
pxa3xx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
pxa910_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
qcom_defconfig (arm, gcc-10) =E2=80=94 FAIL, 3 errors, 1 warning, 0 section=
 mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/bpf.h:204:18: error: =E2=80=98EOPNOTSUPP=E2=80=99 undecla=
red (first use in this function)
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
qi_lb60_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
raumfeld_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
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
realview-smp_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
realview_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
rm200_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
rpc_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section=
 mismatches

Errors:
    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=
=E2=80=99

---------------------------------------------------------------------------=
-----
rt305x_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
s3c2410_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/tty/serial/samsung.c:1780:34: warning: array =E2=80=98s3c24xx_u=
art_dt_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
s3c6400_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sec=
tion mismatches

Warnings:
    drivers/mmc/host/sdhci-s3c.c:429:34: warning: array =E2=80=98sdhci_s3c_=
dt_match=E2=80=99 assumed to have one element
    drivers/tty/serial/samsung.c:1780:34: warning: array =E2=80=98s3c24xx_u=
art_dt_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
s5pv210_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
sama5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 secti=
on mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
sb1250_swarm_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
sead3_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
sead3micro_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
shannon_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
shmobile_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 se=
ction mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
simpad_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
socfpga_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 sec=
tion mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
spear13xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 s=
ection mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

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
spitz_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
stm32_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
sunxi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 6 errors, 3 warnings, 0 secti=
on mismatches

Errors:
    include/linux/arm-smccc.h:311:16: error: implicit declaration of functi=
on =E2=80=98arm_smccc_1_1_get_conduit=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
    include/linux/arm-smccc.h:313:8: error: =E2=80=98SMCCC_CONDUIT_HVC=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98PSCI_=
CONDUIT_HVC=E2=80=99?
    include/linux/arm-smccc.h:316:8: error: =E2=80=98SMCCC_CONDUIT_SMC=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98PSCI_=
CONDUIT_SMC=E2=80=99?
    include/linux/arm-smccc.h:321:13: error: =E2=80=98SMCCC_CONDUIT_NONE=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98PSCI_=
CONDUIT_NONE=E2=80=99?
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    cc1: some warnings being treated as errors
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

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
tegra_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 secti=
on mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
tinyconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

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
trizeps4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
u300_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
u8500_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 secti=
on mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

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
versatile_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 FAIL, 6 errors, 3 warnings, 0 se=
ction mismatches

Errors:
    include/linux/arm-smccc.h:311:16: error: implicit declaration of functi=
on =E2=80=98arm_smccc_1_1_get_conduit=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
    include/linux/arm-smccc.h:313:8: error: =E2=80=98SMCCC_CONDUIT_HVC=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98PSCI_=
CONDUIT_HVC=E2=80=99?
    include/linux/arm-smccc.h:316:8: error: =E2=80=98SMCCC_CONDUIT_SMC=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98PSCI_=
CONDUIT_SMC=E2=80=99?
    include/linux/arm-smccc.h:321:13: error: =E2=80=98SMCCC_CONDUIT_NONE=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98PSCI_=
CONDUIT_NONE=E2=80=99?
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    cc1: some warnings being treated as errors
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
vf610m4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
viper_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
vt8500_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, =
0 section mismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    include/linux/bpf.h:204:9: warning: returning =E2=80=98int=E2=80=99 fro=
m a function with return type =E2=80=98struct bpf_prog *=E2=80=99 makes poi=
nter from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
workpad_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 6 warnings, 0 s=
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
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
6 warnings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
xcep_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
xilfpga_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
xway_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
zeus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
zx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 3 errors, 1 warning, 0 section m=
ismatches

Errors:
    include/linux/bpf.h:204:9: error: implicit declaration of function =E2=
=80=98ERR_PTR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    include/linux/bpf.h:204:18: error: =E2=80=98EOPNOTSUPP=E2=80=99 undecla=
red (first use in this function)
    include/linux/err.h:23:35: error: conflicting types for =E2=80=98ERR_PT=
R=E2=80=99

Warnings:
    cc1: some warnings being treated as errors

---
For more info write to <info@kernelci.org>


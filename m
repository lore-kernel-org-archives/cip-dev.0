Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD10C43334
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 16:08:18 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.29986.1658765292801062209
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 09:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ps5eduMp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d3so2946550pls.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0SgdSN/oR6gG7Te/udg8tU1mragpwzLb7YyQAeq4iqY=;
        b=ps5eduMpu8Hsr/KDftIlHR2k0QipmCo5OLfCnBlIcRjQ7cAZh52ZyCCRPCX/EtKyba
         8Gk2oTJpAwFsWV/+MdzCYjdFrz7rn7D9x267uEffFcOXSzmPaNlLDc33VUSBQg9WxmBv
         mNRdmzgHesUNsrrkgA6VsQx17BPeJ9H9/JoFxNph6vE3QP5NXMNv7g9bPTJ4DEQFlCNT
         ACVSlD/iXJlhfZC0SsLAxrqQiVSvDi6cI+RSWYENWUWvxokSWNX4pFu5PqvYWOauWthm
         8eaVLXVFPQcH2snx7x8dhP8FI0EHJ3zWxtvr1wGkDg5vinK5xL2md/CqqSSmvWAdKNLb
         jMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0SgdSN/oR6gG7Te/udg8tU1mragpwzLb7YyQAeq4iqY=;
        b=HxUskXxOebL59q62IAd0IkBqygpH3Efnqf+jfoe1jB1AYWtFhgoyk5D8k/9uZ186Ob
         AmAWJHWl0CqvRHISUp08JN2OeVJ2b/98YqMrAu1jCJ4K82sX2ryfjxR9MqjtmZZFXO+7
         le0f0y1lYg8ucxv6MQ6ZjDD/CwYIjZLGKZ0duONBHreW9W75iK6PpmAzWjGHXAqvsfZT
         nmztpjirYVGKAya1rGW7U4FG3HJx+vOx7in2kcJ3/noH26jgjHVmOx4YFSTzrets2zlN
         DLtscBlEb6WujuruAuXVBfZHBQLeZBfyVCdyqxVZR7bSKgXv45lC3rBl9FsZZpXOOoPk
         PyMw==
X-Gm-Message-State: AJIora+N+Fr2t8+yf9UP8EEjkoVYGln9oKr6MFDE1gk1ul/lGtHRWooK
	zKydZBbomlOudsS4Mmyv9ihpFYzc1YPAjoKG
X-Google-Smtp-Source: 
 AGRyM1vSjlVLdUnwfJLGsysLL+l5v38F9Ig9hmArKc4UNej+D30oLAvJSFNmmIr5J1IbcmQDsWtmbA==
X-Received: by 2002:a17:90a:b782:b0:1f1:abb8:de1b with SMTP id
 m2-20020a17090ab78200b001f1abb8de1bmr33758593pjr.44.1658765288961;
        Mon, 25 Jul 2022 09:08:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 g10-20020a63e60a000000b0041a13b1d451sm8159265pgh.59.2022.07.25.09.08.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:08:08 -0700 (PDT)
Message-ID: <62debfe8.1c69fb81.9c281.c063@mx.google.com>
Date: Mon, 25 Jul 2022 09:08:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.4-st5-511-gca6ad42603895
Subject: cip-gitlab/ci/pavel/linux-test build: 189 builds: 164 failed,
 25 passed, 167 errors, 186 warnings (v4.4-st5-511-gca6ad42603895)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Jul 2022 16:08:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8903

cip-gitlab/ci/pavel/linux-test build: 189 builds: 164 failed, 25 passed, 16=
7 errors, 186 warnings (v4.4-st5-511-gca6ad42603895)

Full Build Summary: https://kernelci.org/build/cip-gitlab/branch/ci%2Fpavel=
%2Flinux-test/kernel/v4.4-st5-511-gca6ad42603895/

Tree: cip-gitlab
Branch: ci/pavel/linux-test
Git Describe: v4.4-st5-511-gca6ad42603895
Git Commit: ca6ad426038959bca25df3a9f34e4dc7f5234b9c
Git URL: https://gitlab.com/cip-project/cip-kernel/linux-cip.git
Built: 6 unique architectures

Build Failures Detected:

arc:
    axs103_defconfig: (gcc-10) FAIL
    axs103_smp_defconfig: (gcc-10) FAIL
    nsim_hs_defconfig: (gcc-10) FAIL
    nsim_hs_smp_defconfig: (gcc-10) FAIL
    nsimosci_hs_defconfig: (gcc-10) FAIL
    nsimosci_hs_smp_defconfig: (gcc-10) FAIL
    vdk_hs38_defconfig: (gcc-10) FAIL
    vdk_hs38_smp_defconfig: (gcc-10) FAIL

arm64:
    defconfig: (gcc-10) FAIL
    defconfig+arm64-chromebook: (gcc-10) FAIL

arm:
    acs5k_defconfig: (gcc-10) FAIL
    acs5k_tiny_defconfig: (gcc-10) FAIL
    am200epdkit_defconfig: (gcc-10) FAIL
    assabet_defconfig: (gcc-10) FAIL
    at91_dt_defconfig: (gcc-10) FAIL
    axm55xx_defconfig: (gcc-10) FAIL
    badge4_defconfig: (gcc-10) FAIL
    bcm2835_defconfig: (gcc-10) FAIL
    bcm_defconfig: (gcc-10) FAIL
    cerfcube_defconfig: (gcc-10) FAIL
    clps711x_defconfig: (gcc-10) FAIL
    cm_x2xx_defconfig: (gcc-10) FAIL
    cm_x300_defconfig: (gcc-10) FAIL
    colibri_pxa270_defconfig: (gcc-10) FAIL
    colibri_pxa300_defconfig: (gcc-10) FAIL
    collie_defconfig: (gcc-10) FAIL
    corgi_defconfig: (gcc-10) FAIL
    davinci_all_defconfig: (gcc-10) FAIL
    dove_defconfig: (gcc-10) FAIL
    ebsa110_defconfig: (gcc-10) FAIL
    efm32_defconfig: (gcc-10) FAIL
    em_x270_defconfig: (gcc-10) FAIL
    ep93xx_defconfig: (gcc-10) FAIL
    eseries_pxa_defconfig: (gcc-10) FAIL
    exynos_defconfig: (gcc-10) FAIL
    ezx_defconfig: (gcc-10) FAIL
    footbridge_defconfig: (gcc-10) FAIL
    h3600_defconfig: (gcc-10) FAIL
    h5000_defconfig: (gcc-10) FAIL
    hackkit_defconfig: (gcc-10) FAIL
    hisi_defconfig: (gcc-10) FAIL
    imote2_defconfig: (gcc-10) FAIL
    imx_v4_v5_defconfig: (gcc-10) FAIL
    imx_v6_v7_defconfig: (gcc-10) FAIL
    integrator_defconfig: (gcc-10) FAIL
    iop13xx_defconfig: (gcc-10) FAIL
    iop32x_defconfig: (gcc-10) FAIL
    iop33x_defconfig: (gcc-10) FAIL
    ixp4xx_defconfig: (gcc-10) FAIL
    jornada720_defconfig: (gcc-10) FAIL
    keystone_defconfig: (gcc-10) FAIL
    ks8695_defconfig: (gcc-10) FAIL
    lart_defconfig: (gcc-10) FAIL
    lpc18xx_defconfig: (gcc-10) FAIL
    lpc32xx_defconfig: (gcc-10) FAIL
    lpd270_defconfig: (gcc-10) FAIL
    lubbock_defconfig: (gcc-10) FAIL
    magician_defconfig: (gcc-10) FAIL
    mainstone_defconfig: (gcc-10) FAIL
    mini2440_defconfig: (gcc-10) FAIL
    mmp2_defconfig: (gcc-10) FAIL
    moxart_defconfig: (gcc-10) FAIL
    multi_v5_defconfig: (gcc-10) FAIL
    multi_v7_defconfig: (gcc-10) FAIL
    mv78xx0_defconfig: (gcc-10) FAIL
    mvebu_v5_defconfig: (gcc-10) FAIL
    mvebu_v7_defconfig: (gcc-10) FAIL
    mxs_defconfig: (gcc-10) FAIL
    neponset_defconfig: (gcc-10) FAIL
    netwinder_defconfig: (gcc-10) FAIL
    netx_defconfig: (gcc-10) FAIL
    nhk8815_defconfig: (gcc-10) FAIL
    omap1_defconfig: (gcc-10) FAIL
    omap2plus_defconfig: (gcc-10) FAIL
    orion5x_defconfig: (gcc-10) FAIL
    palmz72_defconfig: (gcc-10) FAIL
    pcm027_defconfig: (gcc-10) FAIL
    pleb_defconfig: (gcc-10) FAIL
    pxa168_defconfig: (gcc-10) FAIL
    pxa255-idp_defconfig: (gcc-10) FAIL
    pxa3xx_defconfig: (gcc-10) FAIL
    pxa910_defconfig: (gcc-10) FAIL
    qcom_defconfig: (gcc-10) FAIL
    raumfeld_defconfig: (gcc-10) FAIL
    realview-smp_defconfig: (gcc-10) FAIL
    realview_defconfig: (gcc-10) FAIL
    rpc_defconfig: (gcc-10) FAIL
    s3c2410_defconfig: (gcc-10) FAIL
    sama5_defconfig: (gcc-10) FAIL
    shannon_defconfig: (gcc-10) FAIL
    shmobile_defconfig: (gcc-10) FAIL
    simpad_defconfig: (gcc-10) FAIL
    socfpga_defconfig: (gcc-10) FAIL
    spear13xx_defconfig: (gcc-10) FAIL
    spitz_defconfig: (gcc-10) FAIL
    sunxi_defconfig: (gcc-10) FAIL
    tegra_defconfig: (gcc-10) FAIL
    trizeps4_defconfig: (gcc-10) FAIL
    u8500_defconfig: (gcc-10) FAIL
    versatile_defconfig: (gcc-10) FAIL
    vexpress_defconfig: (gcc-10) FAIL
    viper_defconfig: (gcc-10) FAIL
    vt8500_v6_v7_defconfig: (gcc-10) FAIL
    xcep_defconfig: (gcc-10) FAIL
    zeus_defconfig: (gcc-10) FAIL

i386:
    i386_defconfig: (gcc-10) FAIL

mips:
    ar7_defconfig: (gcc-10) FAIL
    ath79_defconfig: (gcc-10) FAIL
    bcm47xx_defconfig: (gcc-10) FAIL
    bcm63xx_defconfig: (gcc-10) FAIL
    bigsur_defconfig: (gcc-10) FAIL
    bmips_be_defconfig: (gcc-10) FAIL
    bmips_stb_defconfig: (gcc-10) FAIL
    capcella_defconfig: (gcc-10) FAIL
    cavium_octeon_defconfig: (gcc-10) FAIL
    ci20_defconfig: (gcc-10) FAIL
    cobalt_defconfig: (gcc-10) FAIL
    db1xxx_defconfig: (gcc-10) FAIL
    decstation_defconfig: (gcc-10) FAIL
    fuloong2e_defconfig: (gcc-10) FAIL
    gpr_defconfig: (gcc-10) FAIL
    ip22_defconfig: (gcc-10) FAIL
    ip27_defconfig: (gcc-10) FAIL
    ip28_defconfig: (gcc-10) FAIL
    ip32_defconfig: (gcc-10) FAIL
    jazz_defconfig: (gcc-10) FAIL
    jmr3927_defconfig: (gcc-10) FAIL
    lasat_defconfig: (gcc-10) FAIL
    lemote2f_defconfig: (gcc-10) FAIL
    loongson3_defconfig: (gcc-10) FAIL
    ls1b_defconfig: (gcc-10) FAIL
    malta_defconfig: (gcc-10) FAIL
    malta_kvm_defconfig: (gcc-10) FAIL
    malta_kvm_guest_defconfig: (gcc-10) FAIL
    malta_qemu_32r6_defconfig: (gcc-10) FAIL
    maltaaprp_defconfig: (gcc-10) FAIL
    maltasmvp_defconfig: (gcc-10) FAIL
    maltasmvp_eva_defconfig: (gcc-10) FAIL
    maltaup_defconfig: (gcc-10) FAIL
    maltaup_xpa_defconfig: (gcc-10) FAIL
    markeins_defconfig: (gcc-10) FAIL
    mips_paravirt_defconfig: (gcc-10) FAIL
    mpc30x_defconfig: (gcc-10) FAIL
    msp71xx_defconfig: (gcc-10) FAIL
    mtx1_defconfig: (gcc-10) FAIL
    nlm_xlp_defconfig: (gcc-10) FAIL
    nlm_xlr_defconfig: (gcc-10) FAIL
    pistachio_defconfig: (gcc-10) FAIL
    pnx8335_stb225_defconfig: (gcc-10) FAIL
    qi_lb60_defconfig: (gcc-10) FAIL
    rb532_defconfig: (gcc-10) FAIL
    rbtx49xx_defconfig: (gcc-10) FAIL
    rm200_defconfig: (gcc-10) FAIL
    rt305x_defconfig: (gcc-10) FAIL
    sb1250_swarm_defconfig: (gcc-10) FAIL
    sead3_defconfig: (gcc-10) FAIL
    sead3micro_defconfig: (gcc-10) FAIL
    tb0219_defconfig: (gcc-10) FAIL
    tb0226_defconfig: (gcc-10) FAIL
    tb0287_defconfig: (gcc-10) FAIL
    workpad_defconfig: (gcc-10) FAIL
    xway_defconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-chromebook: (gcc-10) FAIL

Errors and Warnings Detected:

arc:
    axs103_defconfig (gcc-10): 1 error, 1 warning
    axs103_smp_defconfig (gcc-10): 1 error, 1 warning
    nsim_hs_defconfig (gcc-10): 1 error, 1 warning
    nsim_hs_smp_defconfig (gcc-10): 1 error, 1 warning
    nsimosci_hs_defconfig (gcc-10): 1 error, 1 warning
    nsimosci_hs_smp_defconfig (gcc-10): 1 error, 1 warning
    vdk_hs38_defconfig (gcc-10): 1 error, 1 warning
    vdk_hs38_smp_defconfig (gcc-10): 1 error, 1 warning

arm64:
    defconfig (gcc-10): 1 error, 2 warnings
    defconfig+arm64-chromebook (gcc-10): 1 error, 2 warnings

arm:
    acs5k_defconfig (gcc-10): 1 error, 1 warning
    acs5k_tiny_defconfig (gcc-10): 1 error, 1 warning
    am200epdkit_defconfig (gcc-10): 1 error, 1 warning
    assabet_defconfig (gcc-10): 1 error, 1 warning
    at91_dt_defconfig (gcc-10): 1 error, 1 warning
    axm55xx_defconfig (gcc-10): 1 error, 1 warning
    badge4_defconfig (gcc-10): 1 error, 1 warning
    bcm2835_defconfig (gcc-10): 1 error, 1 warning
    bcm_defconfig (gcc-10): 1 error, 1 warning
    cerfcube_defconfig (gcc-10): 1 error, 1 warning
    clps711x_defconfig (gcc-10): 1 error, 2 warnings
    cm_x2xx_defconfig (gcc-10): 1 error, 1 warning
    cm_x300_defconfig (gcc-10): 1 error, 1 warning
    colibri_pxa270_defconfig (gcc-10): 1 error, 1 warning
    colibri_pxa300_defconfig (gcc-10): 1 error, 1 warning
    collie_defconfig (gcc-10): 1 error, 1 warning
    corgi_defconfig (gcc-10): 1 error, 1 warning
    davinci_all_defconfig (gcc-10): 1 error, 2 warnings
    dove_defconfig (gcc-10): 1 error, 1 warning
    ebsa110_defconfig (gcc-10): 1 error, 1 warning
    efm32_defconfig (gcc-10): 1 error, 1 warning
    em_x270_defconfig (gcc-10): 1 error, 1 warning
    ep93xx_defconfig (gcc-10): 1 error, 1 warning
    eseries_pxa_defconfig (gcc-10): 1 error, 1 warning
    exynos_defconfig (gcc-10): 1 error, 1 warning
    ezx_defconfig (gcc-10): 1 error, 1 warning
    footbridge_defconfig (gcc-10): 1 error, 1 warning
    h3600_defconfig (gcc-10): 1 error, 1 warning
    h5000_defconfig (gcc-10): 1 error, 1 warning
    hackkit_defconfig (gcc-10): 1 error, 1 warning
    hisi_defconfig (gcc-10): 1 error, 1 warning
    imote2_defconfig (gcc-10): 1 error, 1 warning
    imx_v4_v5_defconfig (gcc-10): 1 error, 1 warning
    imx_v6_v7_defconfig (gcc-10): 1 error, 1 warning
    integrator_defconfig (gcc-10): 1 error, 1 warning
    iop13xx_defconfig (gcc-10): 1 error, 1 warning
    iop32x_defconfig (gcc-10): 1 error, 1 warning
    iop33x_defconfig (gcc-10): 1 error, 1 warning
    ixp4xx_defconfig (gcc-10): 1 error, 1 warning
    jornada720_defconfig (gcc-10): 1 error, 1 warning
    keystone_defconfig (gcc-10): 1 error, 1 warning
    ks8695_defconfig (gcc-10): 1 error, 1 warning
    lart_defconfig (gcc-10): 1 error, 1 warning
    lpc18xx_defconfig (gcc-10): 1 error, 1 warning
    lpc32xx_defconfig (gcc-10): 1 error, 2 warnings
    lpd270_defconfig (gcc-10): 1 error, 1 warning
    lubbock_defconfig (gcc-10): 1 error, 1 warning
    magician_defconfig (gcc-10): 1 error, 1 warning
    mainstone_defconfig (gcc-10): 1 error, 1 warning
    mini2440_defconfig (gcc-10): 1 error, 2 warnings
    mmp2_defconfig (gcc-10): 1 error, 1 warning
    moxart_defconfig (gcc-10): 1 error, 1 warning
    multi_v5_defconfig (gcc-10): 1 error, 1 warning
    multi_v7_defconfig (gcc-10): 1 error, 1 warning
    mv78xx0_defconfig (gcc-10): 1 error, 1 warning
    mvebu_v5_defconfig (gcc-10): 1 error, 1 warning
    mvebu_v7_defconfig (gcc-10): 1 error, 1 warning
    mxs_defconfig (gcc-10): 1 error, 2 warnings
    neponset_defconfig (gcc-10): 1 error, 1 warning
    netwinder_defconfig (gcc-10): 1 error, 1 warning
    netx_defconfig (gcc-10): 1 error, 1 warning
    nhk8815_defconfig (gcc-10): 1 error, 1 warning
    omap1_defconfig (gcc-10): 1 error, 2 warnings
    omap2plus_defconfig (gcc-10): 1 error, 1 warning
    orion5x_defconfig (gcc-10): 1 error, 1 warning
    palmz72_defconfig (gcc-10): 1 error, 1 warning
    pcm027_defconfig (gcc-10): 1 error, 1 warning
    pleb_defconfig (gcc-10): 1 error, 1 warning
    pxa168_defconfig (gcc-10): 1 error, 1 warning
    pxa255-idp_defconfig (gcc-10): 1 error, 1 warning
    pxa3xx_defconfig (gcc-10): 1 error, 1 warning
    pxa910_defconfig (gcc-10): 1 error, 1 warning
    qcom_defconfig (gcc-10): 1 error, 1 warning
    raumfeld_defconfig (gcc-10): 1 error, 1 warning
    realview-smp_defconfig (gcc-10): 1 error, 1 warning
    realview_defconfig (gcc-10): 1 error, 1 warning
    rpc_defconfig (gcc-10): 4 errors
    s3c2410_defconfig (gcc-10): 1 error, 2 warnings
    s3c6400_defconfig (gcc-10): 2 warnings
    sama5_defconfig (gcc-10): 1 error, 1 warning
    shannon_defconfig (gcc-10): 1 error, 1 warning
    shmobile_defconfig (gcc-10): 1 error, 1 warning
    simpad_defconfig (gcc-10): 1 error, 1 warning
    socfpga_defconfig (gcc-10): 1 error, 1 warning
    spear13xx_defconfig (gcc-10): 1 error, 1 warning
    spitz_defconfig (gcc-10): 1 error, 1 warning
    sunxi_defconfig (gcc-10): 1 error, 1 warning
    tegra_defconfig (gcc-10): 1 error, 1 warning
    trizeps4_defconfig (gcc-10): 1 error, 1 warning
    u8500_defconfig (gcc-10): 1 error, 1 warning
    versatile_defconfig (gcc-10): 1 error, 1 warning
    vexpress_defconfig (gcc-10): 1 error, 1 warning
    viper_defconfig (gcc-10): 1 error, 1 warning
    vt8500_v6_v7_defconfig (gcc-10): 1 error, 1 warning
    xcep_defconfig (gcc-10): 1 error, 1 warning
    zeus_defconfig (gcc-10): 1 error, 1 warning

i386:
    i386_defconfig (gcc-10): 1 error, 1 warning

mips:
    ar7_defconfig (gcc-10): 1 error, 1 warning
    ath79_defconfig (gcc-10): 1 error, 1 warning
    bcm47xx_defconfig (gcc-10): 1 error, 1 warning
    bcm63xx_defconfig (gcc-10): 1 error, 1 warning
    bigsur_defconfig (gcc-10): 1 error, 1 warning
    bmips_be_defconfig (gcc-10): 1 error, 1 warning
    bmips_stb_defconfig (gcc-10): 1 error, 1 warning
    capcella_defconfig (gcc-10): 1 error, 1 warning
    cavium_octeon_defconfig (gcc-10): 1 error, 1 warning
    ci20_defconfig (gcc-10): 1 error, 1 warning
    cobalt_defconfig (gcc-10): 1 error, 1 warning
    db1xxx_defconfig (gcc-10): 1 error, 1 warning
    decstation_defconfig (gcc-10): 1 error, 1 warning
    fuloong2e_defconfig (gcc-10): 2 errors
    gpr_defconfig (gcc-10): 1 error, 1 warning
    ip22_defconfig (gcc-10): 1 error, 2 warnings
    ip32_defconfig (gcc-10): 1 error, 1 warning
    jazz_defconfig (gcc-10): 1 error, 1 warning
    jmr3927_defconfig (gcc-10): 1 error, 1 warning
    lasat_defconfig (gcc-10): 1 error, 1 warning
    lemote2f_defconfig (gcc-10): 2 errors
    loongson3_defconfig (gcc-10): 1 error, 1 warning
    ls1b_defconfig (gcc-10): 1 error, 1 warning
    malta_defconfig (gcc-10): 1 error, 1 warning
    malta_kvm_defconfig (gcc-10): 1 error, 1 warning
    malta_kvm_guest_defconfig (gcc-10): 1 error, 1 warning
    malta_qemu_32r6_defconfig (gcc-10): 1 error, 1 warning
    maltaaprp_defconfig (gcc-10): 1 error, 1 warning
    maltasmvp_defconfig (gcc-10): 1 error, 1 warning
    maltasmvp_eva_defconfig (gcc-10): 1 error, 1 warning
    maltaup_defconfig (gcc-10): 1 error, 1 warning
    maltaup_xpa_defconfig (gcc-10): 1 error, 1 warning
    markeins_defconfig (gcc-10): 1 error, 1 warning
    mips_paravirt_defconfig (gcc-10): 1 error, 1 warning
    mpc30x_defconfig (gcc-10): 1 error, 1 warning
    msp71xx_defconfig (gcc-10): 1 error, 1 warning
    mtx1_defconfig (gcc-10): 1 error, 1 warning
    nlm_xlp_defconfig (gcc-10): 1 error, 1 warning
    nlm_xlr_defconfig (gcc-10): 1 error, 1 warning
    pistachio_defconfig (gcc-10): 1 error, 1 warning
    pnx8335_stb225_defconfig (gcc-10): 1 error, 1 warning
    qi_lb60_defconfig (gcc-10): 1 error, 1 warning
    rb532_defconfig (gcc-10): 1 error, 1 warning
    rbtx49xx_defconfig (gcc-10): 1 error, 1 warning
    rm200_defconfig (gcc-10): 1 error, 1 warning
    rt305x_defconfig (gcc-10): 1 error, 1 warning
    sb1250_swarm_defconfig (gcc-10): 1 error, 1 warning
    sead3_defconfig (gcc-10): 1 error, 1 warning
    sead3micro_defconfig (gcc-10): 1 error, 1 warning
    tb0219_defconfig (gcc-10): 1 error, 1 warning
    tb0226_defconfig (gcc-10): 1 error, 1 warning
    tb0287_defconfig (gcc-10): 1 error, 1 warning
    workpad_defconfig (gcc-10): 1 error, 1 warning
    xway_defconfig (gcc-10): 1 error, 1 warning

x86_64:
    allnoconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 1 error, 5 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 1 error, 5 warnings

Errors summary:

    151  net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98raw_h=
ashinfo=E2=80=99?
    8    net/ipv4/inet_hashtables.c:669:12: error: 'tcp_hashinfo' undeclare=
d (first use in this function); did you mean 'raw_hashinfo'?
    4    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=
=80=98-mhard-float=E2=80=99
    2    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
    2    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-marc=
h=3D=E2=80=99

Warnings summary:

    151  net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses ar=
ound =E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    8    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses ar=
ound '+' in operand of '&' [-Wparentheses]
    7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    4    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    4    arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic s=
uffix given and no register operands; using default for `sysret'
    3    drivers/tty/serial/samsung.c:1777:34: warning: array =E2=80=98s3c2=
4xx_uart_dt_match=E2=80=99 assumed to have one element
    2    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: a=
rray =E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element
    1    drivers/net/ethernet/seeq/sgiseeq.c:804:26: warning: passing argum=
ent 5 of =E2=80=98dma_free_attrs=E2=80=99 makes pointer from integer withou=
t a cast [-Wint-conversion]
    1    drivers/mmc/host/sdhci-s3c.c:429:34: warning: array =E2=80=98sdhci=
_s3c_dt_match=E2=80=99 assumed to have one element
    1    drivers/gpio/gpio-omap.c:1161:34: warning: array =E2=80=98omap_gpi=
o_match=E2=80=99 assumed to have one element
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
acs5k_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
acs5k_tiny_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

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
allnoconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
am200epdkit_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 s=
ection mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ar7_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
assabet_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
at91_dt_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ath79_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
axm55xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
axs103_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: 'tcp_hashinfo' undeclared (fi=
rst use in this function); did you mean 'raw_hashinfo'?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
axs103_smp_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: 'tcp_hashinfo' undeclared (fi=
rst use in this function); did you mean 'raw_hashinfo'?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
badge4_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bcm2835_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bcm47xx_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bcm63xx_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bcm_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section m=
ismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bigsur_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bmips_be_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
bmips_stb_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
capcella_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
cavium_octeon_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, =
0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
cerfcube_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ci20_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
clps711x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    arch/arm/mach-clps711x/board-autcpu12.c:163:26: warning: duplicate =E2=
=80=98const=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
cm_x2xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
cm_x300_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
cobalt_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
colibri_pxa270_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, =
0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
colibri_pxa300_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, =
0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
collie_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
corgi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
davinci_all_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 =
section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    arch/arm/mach-davinci/da8xx-dt.c:23:34: warning: duplicate =E2=80=98con=
st=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
db1xxx_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
decstation_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 s=
ection mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 section mi=
smatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: array =
=E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 2 warni=
ngs, 0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: array =
=E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
dove_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
e55_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
ebsa110_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
efm32_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
em_x270_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ep93xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
eseries_pxa_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 s=
ection mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
exynos_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ezx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section m=
ismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
footbridge_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

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
gpr_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
h3600_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
h5000_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
hackkit_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
hisi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
imote2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
imx_v4_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
integrator_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
iop13xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
iop32x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
iop33x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ip22_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

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
ip32_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ixp4xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
jazz_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
jmr3927_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
jornada720_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
keystone_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ks8695_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lart_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lasat_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

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
loongson3_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lpc18xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lpc32xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    arch/arm/mach-lpc32xx/phy3250.c:215:36: warning: duplicate =E2=80=98con=
st=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lpd270_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
ls1b_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
lubbock_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
magician_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mainstone_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
malta_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
malta_kvm_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
malta_kvm_guest_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning=
, 0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
malta_qemu_32r6_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning=
, 0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
maltaaprp_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
maltasmvp_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
maltasmvp_eva_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, =
0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
maltaup_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
maltaup_xpa_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 =
section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
markeins_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mini2440_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
    drivers/tty/serial/samsung.c:1777:34: warning: array =E2=80=98s3c24xx_u=
art_dt_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
mips_paravirt_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, =
0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mmp2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
moxart_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mpc30x_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
msp71xx_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mtx1_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mv78xx0_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mvebu_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mvebu_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
mxs_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    arch/arm/mach-mxs/mach-mxs.c:285:26: warning: duplicate =E2=80=98const=
=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
neponset_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
netwinder_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
netx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
nhk8815_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
nlm_xlp_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
nlm_xlr_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
nsim_hs_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: 'tcp_hashinfo' undeclared (fi=
rst use in this function); did you mean 'raw_hashinfo'?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
nsim_hs_smp_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 s=
ection mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: 'tcp_hashinfo' undeclared (fi=
rst use in this function); did you mean 'raw_hashinfo'?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
nsimosci_hs_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 s=
ection mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: 'tcp_hashinfo' undeclared (fi=
rst use in this function); did you mean 'raw_hashinfo'?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
nsimosci_hs_smp_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning,=
 0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: 'tcp_hashinfo' undeclared (fi=
rst use in this function); did you mean 'raw_hashinfo'?

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
omap1_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    drivers/gpio/gpio-omap.c:1161:34: warning: array =E2=80=98omap_gpio_mat=
ch=E2=80=99 assumed to have one element
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
orion5x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
palmz72_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pcm027_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pistachio_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pleb_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pnx8335_stb225_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning,=
 0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
prima2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
pxa168_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pxa255-idp_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pxa3xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
pxa910_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
qcom_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
qi_lb60_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
raumfeld_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
rb532_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
rbtx49xx_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
realview-smp_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 =
section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
realview_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
rm200_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

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
rt305x_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
s3c2410_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    drivers/tty/serial/samsung.c:1777:34: warning: array =E2=80=98s3c24xx_u=
art_dt_match=E2=80=99 assumed to have one element
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
s3c6400_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sec=
tion mismatches

Warnings:
    drivers/mmc/host/sdhci-s3c.c:429:34: warning: array =E2=80=98sdhci_s3c_=
dt_match=E2=80=99 assumed to have one element
    drivers/tty/serial/samsung.c:1777:34: warning: array =E2=80=98s3c24xx_u=
art_dt_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
s5pv210_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
sama5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
sb1250_swarm_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0=
 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
sead3_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
sead3micro_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 s=
ection mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
shannon_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
shmobile_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
simpad_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sectio=
n mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
socfpga_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
spear13xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

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
spitz_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
stm32_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
sunxi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
tb0219_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
tb0226_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
tb0287_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
tct_hammer_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
tegra_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
tinyconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
tinyconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

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
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
tinyconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
trizeps4_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
u300_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
u8500_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
vdk_hs38_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: 'tcp_hashinfo' undeclared (fi=
rst use in this function); did you mean 'raw_hashinfo'?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
vdk_hs38_smp_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 =
section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: 'tcp_hashinfo' undeclared (fi=
rst use in this function); did you mean 'raw_hashinfo'?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
'+' in operand of '&' [-Wparentheses]

---------------------------------------------------------------------------=
-----
versatile_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
vf610m4_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
viper_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
vt8500_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 =
section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
workpad_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 5 warnings, 0 se=
ction mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

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

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 5=
 warnings, 0 section mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

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

---------------------------------------------------------------------------=
-----
xcep_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
xilfpga_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
xway_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
zeus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section =
mismatches

Errors:
    net/ipv4/inet_hashtables.c:669:12: error: =E2=80=98tcp_hashinfo=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98raw_hash=
info=E2=80=99?

Warnings:
    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses around =
=E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses]

---------------------------------------------------------------------------=
-----
zx_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---
For more info write to <info@kernelci.org>


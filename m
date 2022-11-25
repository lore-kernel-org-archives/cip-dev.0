Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD53C4332F
	for <webhook@archiver.kernel.org>; Fri, 25 Nov 2022 12:47:48 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.46271.1669380458675871747
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Nov 2022 04:47:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=td0ObExP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 130so3882543pgc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Nov 2022 04:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v6I2qA4n1EiZYD5jgJF5+u1vsFlBc4v+Q2P1Xkoyihs=;
        b=td0ObExP5l98naqHV43cp0DG1at7kFxsLvmfA+uNBv73nEAQ32IdFsuxu6FG3r4Fuk
         ymN84PoMel2zyTQAkoDk5PgLEHZh+0gOf6K0k3Nq3Oww2Fh1z6OI/wPoIBgoHbHvJaiN
         o7fm+pZu4xcNb+gh0NdjCOVEP5VL0OL8Hfd7tq+CkGbPp1yElZbcWSRseTvD8/wgmmCt
         oXm4KUDFAIzf8fiFjhv+o+jsyJnueLbnY4hEzMCTgbE0LM9VgN1OORtIZwKe0QblrDHp
         jde3ran9EQygnQ4dN0W9KcEtdeY2GrBiffSzuswcQd1DwY1SNbE+/wTkfhEIHiY+3gPM
         4EDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6I2qA4n1EiZYD5jgJF5+u1vsFlBc4v+Q2P1Xkoyihs=;
        b=UwELtn2lb/XwnZ36BS3m6Mx6cfln4UovnQC7uodtLVqxPZ2mvZTQIwazQiKdPFDb1T
         yKdB4qobe04t4sYUBtfGS5VRimAAXLbOYEr1J+fiLV4F4d0LvOENWeRzhMhVB9jlae1C
         CJ1+h089ZdNpf7o4wujBs6G69CwX3AShwXmhC/T/dUfImLiDT6P6qz3E0/+Gz8FWuYg5
         jwKQUtZGF4hfHxkHmRP+IEYRFvAEojQgbp4m0Hma19KwGf3rd9Ddd88+cV99lRToQeTm
         1VnNdsEjNGvJ6/x4X16OqP/7x19adAS7VfcHGx3ZtrAwyoouanI9JKHy9xYRu1/uUm9l
         xnQg==
X-Gm-Message-State: ANoB5pkC9mPNdFx0k+ZaVMT/Vtn1FP5vpV0jAdeI/OELycmtj4E+aWh9
	Hlwd+09ymld+fslOu7A13H1KiQx7v+/MqriJwRw=
X-Google-Smtp-Source: AA0mqf65/e2z0TfBf2BhE1uMkSFefJL7MTFhQ3rw3oQDsaFFWyYom8RcjHwv7PXxIaBTGDInC3zAlQ==
X-Received: by 2002:a63:5a62:0:b0:476:ed2a:6215 with SMTP id k34-20020a635a62000000b00476ed2a6215mr16343079pgm.559.1669380455593;
        Fri, 25 Nov 2022 04:47:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b0018957322953sm3375257plg.45.2022.11.25.04.47.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:47:34 -0800 (PST)
Message-ID: <6380b966.170a0220.c6e66.460a@mx.google.com>
Date: Fri, 25 Nov 2022 04:47:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-403-g4e071a8ecc76c
X-Kernelci-Report-Type: build
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test build: 188 builds: 188 failed, 0 passed,
 189 errors, 645 warnings (v4.4-st5-403-g4e071a8ecc76c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Nov 2022 12:47:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10108

cip-gitlab/ci/pavel/linux-test build: 188 builds: 188 failed, 0 passed, 189=
 errors, 645 warnings (v4.4-st5-403-g4e071a8ecc76c)

Full Build Summary: https://kernelci.org/build/cip-gitlab/branch/ci%2Fpavel=
%2Flinux-test/kernel/v4.4-st5-403-g4e071a8ecc76c/

Tree: cip-gitlab
Branch: ci/pavel/linux-test
Git Describe: v4.4-st5-403-g4e071a8ecc76c
Git Commit: 4e071a8ecc76c87924834c08cfc923819b5a2a59
Git URL: https://gitlab.com/cip-project/cip-kernel/linux-cip.git
Built: 5 unique architectures

Build Failures Detected:

arc:
    allnoconfig: (gcc-10) FAIL
    axs103_defconfig: (gcc-10) FAIL
    axs103_smp_defconfig: (gcc-10) FAIL
    nsim_hs_defconfig: (gcc-10) FAIL
    nsim_hs_smp_defconfig: (gcc-10) FAIL
    nsimosci_hs_defconfig: (gcc-10) FAIL
    nsimosci_hs_smp_defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL
    vdk_hs38_defconfig: (gcc-10) FAIL
    vdk_hs38_smp_defconfig: (gcc-10) FAIL

arm:
    acs5k_defconfig: (gcc-10) FAIL
    acs5k_tiny_defconfig: (gcc-10) FAIL
    allnoconfig: (gcc-10) FAIL
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
    cns3420vb_defconfig: (gcc-10) FAIL
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
    nuc910_defconfig: (gcc-10) FAIL
    nuc950_defconfig: (gcc-10) FAIL
    nuc960_defconfig: (gcc-10) FAIL
    omap1_defconfig: (gcc-10) FAIL
    omap2plus_defconfig: (gcc-10) FAIL
    orion5x_defconfig: (gcc-10) FAIL
    palmz72_defconfig: (gcc-10) FAIL
    pcm027_defconfig: (gcc-10) FAIL
    pleb_defconfig: (gcc-10) FAIL
    prima2_defconfig: (gcc-10) FAIL
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

i386:
    allnoconfig: (gcc-10) FAIL
    i386_defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

mips:
    allnoconfig: (gcc-10) FAIL
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
    e55_defconfig: (gcc-10) FAIL
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
    tinyconfig: (gcc-10) FAIL
    workpad_defconfig: (gcc-10) FAIL
    xilfpga_defconfig: (gcc-10) FAIL
    xway_defconfig: (gcc-10) FAIL

x86_64:
    allnoconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-chromebook: (gcc-10) FAIL

Errors and Warnings Detected:

arc:
    allnoconfig (gcc-10): 1 error, 4 warnings
    axs103_defconfig (gcc-10): 1 error, 4 warnings
    axs103_smp_defconfig (gcc-10): 1 error, 2 warnings
    nsim_hs_defconfig (gcc-10): 1 error, 4 warnings
    nsim_hs_smp_defconfig (gcc-10): 1 error, 2 warnings
    nsimosci_hs_defconfig (gcc-10): 1 error, 4 warnings
    nsimosci_hs_smp_defconfig (gcc-10): 1 error, 2 warnings
    tinyconfig (gcc-10): 1 error, 4 warnings
    vdk_hs38_defconfig (gcc-10): 1 error, 4 warnings
    vdk_hs38_smp_defconfig (gcc-10): 1 error, 2 warnings

arm:
    acs5k_defconfig (gcc-10): 1 error, 4 warnings
    acs5k_tiny_defconfig (gcc-10): 1 error, 4 warnings
    allnoconfig (gcc-10): 1 error, 4 warnings
    am200epdkit_defconfig (gcc-10): 1 error, 4 warnings
    assabet_defconfig (gcc-10): 1 error, 4 warnings
    at91_dt_defconfig (gcc-10): 1 error, 4 warnings
    axm55xx_defconfig (gcc-10): 1 error, 2 warnings
    badge4_defconfig (gcc-10): 1 error, 4 warnings
    bcm2835_defconfig (gcc-10): 1 error, 4 warnings
    bcm_defconfig (gcc-10): 1 error, 2 warnings
    cerfcube_defconfig (gcc-10): 1 error, 4 warnings
    clps711x_defconfig (gcc-10): 1 error, 5 warnings
    cm_x2xx_defconfig (gcc-10): 1 error, 4 warnings
    cm_x300_defconfig (gcc-10): 1 error, 4 warnings
    cns3420vb_defconfig (gcc-10): 1 error, 4 warnings
    colibri_pxa270_defconfig (gcc-10): 1 error, 4 warnings
    colibri_pxa300_defconfig (gcc-10): 1 error, 4 warnings
    collie_defconfig (gcc-10): 1 error, 4 warnings
    corgi_defconfig (gcc-10): 1 error, 4 warnings
    davinci_all_defconfig (gcc-10): 1 error, 5 warnings
    dove_defconfig (gcc-10): 1 error, 4 warnings
    ebsa110_defconfig (gcc-10): 1 error, 4 warnings
    efm32_defconfig (gcc-10): 1 error, 4 warnings
    em_x270_defconfig (gcc-10): 1 error, 4 warnings
    ep93xx_defconfig (gcc-10): 1 error, 2 warnings
    eseries_pxa_defconfig (gcc-10): 1 error, 4 warnings
    exynos_defconfig (gcc-10): 1 error, 2 warnings
    ezx_defconfig (gcc-10): 1 error, 2 warnings
    footbridge_defconfig (gcc-10): 1 error, 4 warnings
    h3600_defconfig (gcc-10): 1 error, 4 warnings
    h5000_defconfig (gcc-10): 1 error, 4 warnings
    hackkit_defconfig (gcc-10): 1 error, 2 warnings
    hisi_defconfig (gcc-10): 1 error, 2 warnings
    imote2_defconfig (gcc-10): 1 error, 2 warnings
    imx_v4_v5_defconfig (gcc-10): 1 error, 4 warnings
    imx_v6_v7_defconfig (gcc-10): 1 error, 2 warnings
    integrator_defconfig (gcc-10): 1 error, 4 warnings
    iop13xx_defconfig (gcc-10): 1 error, 4 warnings
    iop32x_defconfig (gcc-10): 1 error, 4 warnings
    iop33x_defconfig (gcc-10): 1 error, 4 warnings
    ixp4xx_defconfig (gcc-10): 1 error, 4 warnings
    jornada720_defconfig (gcc-10): 1 error, 4 warnings
    keystone_defconfig (gcc-10): 1 error, 2 warnings
    ks8695_defconfig (gcc-10): 1 error, 4 warnings
    lart_defconfig (gcc-10): 1 error, 4 warnings
    lpc18xx_defconfig (gcc-10): 1 error, 4 warnings
    lpc32xx_defconfig (gcc-10): 1 error, 5 warnings
    lpd270_defconfig (gcc-10): 1 error, 4 warnings
    lubbock_defconfig (gcc-10): 1 error, 4 warnings
    magician_defconfig (gcc-10): 1 error, 4 warnings
    mainstone_defconfig (gcc-10): 1 error, 4 warnings
    mini2440_defconfig (gcc-10): 1 error, 4 warnings
    mmp2_defconfig (gcc-10): 1 error, 4 warnings
    moxart_defconfig (gcc-10): 1 error, 2 warnings
    multi_v5_defconfig (gcc-10): 1 error, 4 warnings
    multi_v7_defconfig (gcc-10): 1 error, 2 warnings
    mv78xx0_defconfig (gcc-10): 1 error, 4 warnings
    mvebu_v5_defconfig (gcc-10): 1 error, 4 warnings
    mvebu_v7_defconfig (gcc-10): 1 error, 2 warnings
    mxs_defconfig (gcc-10): 1 error, 3 warnings
    neponset_defconfig (gcc-10): 1 error, 4 warnings
    netwinder_defconfig (gcc-10): 1 error, 4 warnings
    netx_defconfig (gcc-10): 1 error, 4 warnings
    nhk8815_defconfig (gcc-10): 1 error, 4 warnings
    nuc910_defconfig (gcc-10): 1 error, 4 warnings
    nuc950_defconfig (gcc-10): 1 error, 4 warnings
    nuc960_defconfig (gcc-10): 1 error, 4 warnings
    omap1_defconfig (gcc-10): 1 error, 2 warnings
    omap2plus_defconfig (gcc-10): 1 error, 2 warnings
    orion5x_defconfig (gcc-10): 1 error, 4 warnings
    palmz72_defconfig (gcc-10): 1 error, 4 warnings
    pcm027_defconfig (gcc-10): 1 error, 4 warnings
    pleb_defconfig (gcc-10): 1 error, 4 warnings
    prima2_defconfig (gcc-10): 1 error, 2 warnings
    pxa168_defconfig (gcc-10): 1 error, 4 warnings
    pxa255-idp_defconfig (gcc-10): 1 error, 4 warnings
    pxa3xx_defconfig (gcc-10): 1 error, 2 warnings
    pxa910_defconfig (gcc-10): 1 error, 4 warnings
    qcom_defconfig (gcc-10): 1 error, 2 warnings
    raumfeld_defconfig (gcc-10): 1 error, 4 warnings
    realview-smp_defconfig (gcc-10): 1 error, 2 warnings
    realview_defconfig (gcc-10): 1 error, 4 warnings
    rpc_defconfig (gcc-10): 2 errors
    s3c2410_defconfig (gcc-10): 1 error, 4 warnings
    s3c6400_defconfig (gcc-10): 1 error, 2 warnings
    s5pv210_defconfig (gcc-10): 1 error, 2 warnings
    sama5_defconfig (gcc-10): 1 error, 4 warnings
    shannon_defconfig (gcc-10): 1 error, 4 warnings
    shmobile_defconfig (gcc-10): 1 error, 2 warnings
    simpad_defconfig (gcc-10): 1 error, 4 warnings
    socfpga_defconfig (gcc-10): 1 error, 2 warnings
    spear13xx_defconfig (gcc-10): 1 error, 2 warnings
    spear3xx_defconfig (gcc-10): 1 error, 2 warnings
    spear6xx_defconfig (gcc-10): 1 error, 2 warnings
    spitz_defconfig (gcc-10): 1 error, 4 warnings
    stm32_defconfig (gcc-10): 1 error, 4 warnings
    sunxi_defconfig (gcc-10): 1 error, 2 warnings
    tct_hammer_defconfig (gcc-10): 1 error, 4 warnings
    tegra_defconfig (gcc-10): 1 error, 2 warnings
    tinyconfig (gcc-10): 1 error, 4 warnings
    trizeps4_defconfig (gcc-10): 1 error, 4 warnings
    u300_defconfig (gcc-10): 1 error, 4 warnings
    u8500_defconfig (gcc-10): 1 error, 2 warnings
    versatile_defconfig (gcc-10): 1 error, 4 warnings
    vexpress_defconfig (gcc-10): 1 error, 2 warnings
    vf610m4_defconfig (gcc-10): 1 error, 4 warnings
    viper_defconfig (gcc-10): 1 error, 4 warnings
    vt8500_v6_v7_defconfig (gcc-10): 1 error, 4 warnings
    xcep_defconfig (gcc-10): 1 error, 4 warnings
    zeus_defconfig (gcc-10): 1 error, 4 warnings
    zx_defconfig (gcc-10): 1 error, 2 warnings

i386:
    allnoconfig (gcc-10): 1 error, 4 warnings
    i386_defconfig (gcc-10): 1 error, 2 warnings
    tinyconfig (gcc-10): 1 error, 4 warnings

mips:
    allnoconfig (gcc-10): 1 error, 4 warnings
    ar7_defconfig (gcc-10): 1 error, 4 warnings
    ath79_defconfig (gcc-10): 1 error, 4 warnings
    bcm47xx_defconfig (gcc-10): 1 error, 4 warnings
    bcm63xx_defconfig (gcc-10): 1 error, 4 warnings
    bigsur_defconfig (gcc-10): 1 error, 2 warnings
    bmips_be_defconfig (gcc-10): 1 error, 2 warnings
    bmips_stb_defconfig (gcc-10): 1 error, 2 warnings
    capcella_defconfig (gcc-10): 1 error, 4 warnings
    cavium_octeon_defconfig (gcc-10): 1 error, 2 warnings
    ci20_defconfig (gcc-10): 1 error, 4 warnings
    cobalt_defconfig (gcc-10): 1 error, 4 warnings
    db1xxx_defconfig (gcc-10): 1 error, 4 warnings
    decstation_defconfig (gcc-10): 1 error, 4 warnings
    e55_defconfig (gcc-10): 1 error, 4 warnings
    fuloong2e_defconfig (gcc-10): 2 errors
    gpr_defconfig (gcc-10): 1 error, 4 warnings
    ip22_defconfig (gcc-10): 1 error, 4 warnings
    ip32_defconfig (gcc-10): 1 error, 4 warnings
    jazz_defconfig (gcc-10): 1 error, 4 warnings
    jmr3927_defconfig (gcc-10): 1 error, 4 warnings
    lasat_defconfig (gcc-10): 1 error, 4 warnings
    lemote2f_defconfig (gcc-10): 2 errors
    loongson3_defconfig (gcc-10): 1 error, 2 warnings
    ls1b_defconfig (gcc-10): 1 error, 4 warnings
    malta_defconfig (gcc-10): 1 error, 2 warnings
    malta_kvm_defconfig (gcc-10): 1 error, 2 warnings
    malta_kvm_guest_defconfig (gcc-10): 1 error, 4 warnings
    malta_qemu_32r6_defconfig (gcc-10): 1 error, 4 warnings
    maltaaprp_defconfig (gcc-10): 1 error, 4 warnings
    maltasmvp_defconfig (gcc-10): 1 error, 2 warnings
    maltasmvp_eva_defconfig (gcc-10): 1 error, 2 warnings
    maltaup_defconfig (gcc-10): 1 error, 4 warnings
    maltaup_xpa_defconfig (gcc-10): 1 error, 4 warnings
    markeins_defconfig (gcc-10): 1 error, 4 warnings
    mips_paravirt_defconfig (gcc-10): 1 error, 2 warnings
    mpc30x_defconfig (gcc-10): 1 error, 4 warnings
    msp71xx_defconfig (gcc-10): 1 error, 4 warnings
    mtx1_defconfig (gcc-10): 1 error, 4 warnings
    nlm_xlp_defconfig (gcc-10): 1 error, 2 warnings
    nlm_xlr_defconfig (gcc-10): 1 error, 2 warnings
    pistachio_defconfig (gcc-10): 1 error, 2 warnings
    pnx8335_stb225_defconfig (gcc-10): 1 error, 4 warnings
    qi_lb60_defconfig (gcc-10): 1 error, 4 warnings
    rb532_defconfig (gcc-10): 1 error, 4 warnings
    rbtx49xx_defconfig (gcc-10): 1 error, 4 warnings
    rm200_defconfig (gcc-10): 1 error, 4 warnings
    rt305x_defconfig (gcc-10): 1 error, 4 warnings
    sb1250_swarm_defconfig (gcc-10): 1 error, 2 warnings
    sead3_defconfig (gcc-10): 1 error, 4 warnings
    sead3micro_defconfig (gcc-10): 1 error, 4 warnings
    tb0219_defconfig (gcc-10): 1 error, 4 warnings
    tb0226_defconfig (gcc-10): 1 error, 4 warnings
    tb0287_defconfig (gcc-10): 1 error, 4 warnings
    tinyconfig (gcc-10): 1 error, 4 warnings
    workpad_defconfig (gcc-10): 1 error, 4 warnings
    xilfpga_defconfig (gcc-10): 1 error, 4 warnings
    xway_defconfig (gcc-10): 1 error, 4 warnings

x86_64:
    allnoconfig (gcc-10): 1 error, 8 warnings
    tinyconfig (gcc-10): 1 error, 7 warnings
    x86_64_defconfig (gcc-10): 1 error, 6 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 1 error, 6 warnings

Errors summary:

    173  kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undecla=
red (first use in this function)
    10   kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use i=
n this function)
    4    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=
=80=98-mhard-float=E2=80=99
    1    arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
    1    arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-marc=
h=3D=E2=80=99

Warnings summary:

    626  include/linux/typecheck.h:11:18: warning: comparison of distinct p=
ointer types lacks a cast
    7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    4    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    4    arch/x86/entry/entry_64.S:1660: Warning: no instruction mnemonic s=
uffix given and no register operands; using default for `sysret'
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
acs5k_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
acs5k_tiny_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section m=
ismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
allnoconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section m=
ismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 8 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/entry/entry_64.S:1660: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

---------------------------------------------------------------------------=
-----
allnoconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section mi=
smatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
allnoconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section mi=
smatches

Errors:
    kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use in thi=
s function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
am200epdkit_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 =
section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
ar7_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
assabet_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
at91_dt_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
ath79_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
axm55xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
axs103_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use in thi=
s function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
axs103_smp_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use in thi=
s function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
badge4_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
bcm2835_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
bcm47xx_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
bcm63xx_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
bcm_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 section =
mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
bigsur_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
bmips_be_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
bmips_stb_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
capcella_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
cavium_octeon_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings,=
 0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
cerfcube_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
ci20_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
clps711x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 5 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    arch/arm/mach-clps711x/board-autcpu12.c:163:26: warning: duplicate =E2=
=80=98const=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
cm_x2xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
cm_x300_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
cns3420vb_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
cobalt_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
colibri_pxa270_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings,=
 0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
colibri_pxa300_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings,=
 0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
collie_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
corgi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
davinci_all_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 5 warnings, 0 =
section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    arch/arm/mach-davinci/da8xx-dt.c:23:34: warning: duplicate =E2=80=98con=
st=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
db1xxx_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
decstation_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 =
section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
dove_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
e55_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
ebsa110_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
efm32_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
em_x270_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
ep93xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
eseries_pxa_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 =
section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
exynos_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
ezx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 section =
mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
footbridge_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

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
gpr_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
h3600_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
h5000_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
hackkit_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
hisi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
imote2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
imx_v4_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
integrator_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
iop13xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
iop32x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
iop33x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
ip22_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

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
ip32_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
ixp4xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
jazz_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
jmr3927_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
jornada720_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
keystone_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
ks8695_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
lart_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
lasat_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

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
loongson3_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
lpc18xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
lpc32xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 5 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    arch/arm/mach-lpc32xx/phy3250.c:215:36: warning: duplicate =E2=80=98con=
st=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
lpd270_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
ls1b_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
lubbock_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
magician_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
mainstone_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
malta_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
malta_kvm_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
malta_kvm_guest_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warning=
s, 0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
malta_qemu_32r6_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warning=
s, 0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
maltaaprp_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
maltasmvp_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
maltasmvp_eva_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings,=
 0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
maltaup_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
maltaup_xpa_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0=
 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
markeins_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
mini2440_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
mips_paravirt_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings,=
 0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
mmp2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
moxart_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
mpc30x_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
msp71xx_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
mtx1_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
mv78xx0_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
mvebu_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
mvebu_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
mxs_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 3 warnings, 0 section =
mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    arch/arm/mach-mxs/mach-mxs.c:285:26: warning: duplicate =E2=80=98const=
=E2=80=99 declaration specifier [-Wduplicate-decl-specifier]
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
neponset_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
netwinder_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
netx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
nhk8815_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
nlm_xlp_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
nlm_xlr_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
nsim_hs_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use in thi=
s function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
nsim_hs_smp_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 =
section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use in thi=
s function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
nsimosci_hs_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 =
section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use in thi=
s function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
nsimosci_hs_smp_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings=
, 0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use in thi=
s function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
nuc910_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
nuc950_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
nuc960_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
omap1_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
orion5x_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
palmz72_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
pcm027_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
pistachio_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
pleb_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
pnx8335_stb225_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings=
, 0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
prima2_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
pxa168_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
pxa255-idp_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
pxa3xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
pxa910_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
qcom_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
qi_lb60_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
raumfeld_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
rb532_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
rbtx49xx_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
realview-smp_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0=
 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
realview_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
rm200_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

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
rt305x_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
s3c2410_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
s3c6400_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
s5pv210_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
sama5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
sb1250_swarm_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, =
0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
sead3_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
sead3micro_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 =
section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
shannon_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
shmobile_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
simpad_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 secti=
on mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
socfpga_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
spear13xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
spear3xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
spear6xx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
spitz_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
stm32_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
sunxi_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
tb0219_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
tb0226_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
tb0287_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
tct_hammer_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 s=
ection mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
tegra_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 7 warnings, 0 section =
mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/entry/entry_64.S:1660: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

---------------------------------------------------------------------------=
-----
tinyconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section mis=
matches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
tinyconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section mis=
matches

Errors:
    kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use in thi=
s function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
tinyconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section mi=
smatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section mi=
smatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
trizeps4_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
u300_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
u8500_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
vdk_hs38_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use in thi=
s function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
vdk_hs38_smp_defconfig (arc, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0=
 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: 'flags' undeclared (first use in thi=
s function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
versatile_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
vf610m4_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sect=
ion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
viper_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
vt8500_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0=
 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
workpad_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 6 warnings, 0 se=
ction mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/entry/entry_64.S:1660: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 6=
 warnings, 0 section mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/entry/entry_64.S:1660: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

---------------------------------------------------------------------------=
-----
xcep_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
xilfpga_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sec=
tion mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
xway_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 sectio=
n mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
zeus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 section=
 mismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---------------------------------------------------------------------------=
-----
zx_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 section m=
ismatches

Errors:
    kernel/workqueue.c:3379:42: error: =E2=80=98flags=E2=80=99 undeclared (=
first use in this function)

Warnings:
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast
    include/linux/typecheck.h:11:18: warning: comparison of distinct pointe=
r types lacks a cast

---
For more info write to <info@kernelci.org>


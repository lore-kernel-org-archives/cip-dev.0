Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1785AC25B08
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 03:29:59 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web08.27602.1661225396664468680
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 20:29:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=NJkvCyMp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id z187so12217689pfb.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 20:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=eZoG5+nvBDwzEFHc/urWWGuzmINIXr/HnnCySnc6gAM=;
        b=NJkvCyMpSKZCvRen+fJyoMgKdSiI9uuUiUpzYEebJjFOpz1daP6K/OigC+qmASZwxA
         SZ1dBAnem4PCBvFaOJ2ayX4N/7ONBmp4yshPqXI0/dWYWjbO7Bc0r/pLbxU5kJZ/B4Ne
         Fx7jIhkCHLtj0cI49z65UqyVapp61GpGzWocODCQhiQVDptAu5m3cB/CmeegRrsjPiw0
         88BEaTh0k5YmlKytiE04XEjirDzXmVgG8kRxYH6Y/ZSaVmAOLaDMxiNbZRrotU8kQxFz
         nrqSDkcnsQ3+fpQx/EikNCPJQDF0erjBGBmvB50xH7kPEH2cBLiPcrhIGoIRsNLSd+hT
         QHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=eZoG5+nvBDwzEFHc/urWWGuzmINIXr/HnnCySnc6gAM=;
        b=x2d+E7vLPMYELwi3dt53Lxb61Eet5Pf7GMmpDO77F++EnVrLlCvOuzbGQUTa3a6+zV
         cnrKORgssnSNDCgQs6VlHFAzrCFD5hINTKP/iNRld28l30aNnhLaWU9pb9epK9OpCAyn
         sGBHH3TKjlW/n8caG4reCpL4KDIRgOTaLvyhHIkGbXHYaRqpViPoN3RF9VaRwVlUWTbd
         eR3zX06a6CzEq6Y5MHczz2oz6qKTX8q0Vejqc0ot0NpFCkM48APCBSQocJCwO313vul1
         buI5BbAnIOkZEYo+76WymoZLXu+tYwdW6FG6O7MKccvkFpCmB1qpvgDGGNv7on+oTiOj
         jBcA==
X-Gm-Message-State: ACgBeo28ICd9vBYN/OcCBOHxcuQfxjD3UyzQVWVratuW76OJtXHu6KOm
	2yFNLtJWbIiPsSg+lb+zl+qn1VwWo8kLM9Oi
X-Google-Smtp-Source: 
 AA6agR4GzgGvE88ezUtAMWF94TU5kM5Pw7hZnPK3ujY0EsrwEr/04oX3BDHUDbwYAXPbUba2tvRq6g==
X-Received: by 2002:a63:f24f:0:b0:42a:81ff:6e62 with SMTP id
 d15-20020a63f24f000000b0042a81ff6e62mr10348948pgk.154.1661225395803;
        Mon, 22 Aug 2022 20:29:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m14-20020a62a20e000000b0050dc7628183sm9648980pff.93.2022.08.22.20.29.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 20:29:55 -0700 (PDT)
Message-ID: <630449b3.620a0220.4592e.16ce@mx.google.com>
Date: Mon, 22 Aug 2022 20:29:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.136-cip14-542-g97767707d3d0
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 25 runs,
 2 regressions (v5.10.136-cip14-542-g97767707d3d0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 03:29:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9299

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 25 runs, 2 regress=
ions (v5.10.136-cip14-542-g97767707d3d0)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig       =
           | 1          =

rk3399-gru-kevin      | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.136-cip14-542-g97767707d3d0/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.136-cip14-542-g97767707d3d0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      97767707d3d0aa36cbf6620b216d0d19b9314417 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/63043f882c2deb7647355665

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63043f882c2deb764=
7355666
        failing since 19 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
rk3399-gru-kevin      | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63043f6052442397f935565e

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/63043f6052442397f9355684
        failing since 167 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-08-23T02:45:38.107785  /lava-7095480/1/../bin/lava-test-case
    2022-08-23T02:45:38.134550  [   99.473720] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20


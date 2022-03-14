X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web12.21821.1647222087516156193
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Mar 2022 18:41:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=QVM9Mw+3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id t14so12466513pgr.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Mar 2022 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=N4S4DiR3r22QHoLApsZwQiVe55zFHqMJR2Zb5b8Wpxg=;
        b=QVM9Mw+35bqmJYjzwK+S0xV9Tz/yAEuOWElvipjG5kyWkx1CrTIyZgZarrbYvi9tnz
         rgtEE9ToCAlwBQTjXrwL8kFQzWJ4mytWHtdp8bGg/vHa8xfrNQJnRZiLrE7hGRH2b5Xz
         dsCapC4dgiYtoW/ZVV/9N6RLxjODxspO5617cDo8aRMAvJktXbdV4XtRNoLaTuZsbe+S
         cy8OvtrbP9SslwGS8r7ezjSoehuyKYvi2LMd/yZMYyC3bx7h2aCyWLRiIcfAbiltUNpu
         HcAiIIW37WihrJjlMyZzYuzyoH/LnAyNE8V1FxvcjnOLxOH2l7salBVfwzabmgIBiQ93
         M7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=N4S4DiR3r22QHoLApsZwQiVe55zFHqMJR2Zb5b8Wpxg=;
        b=qmIK/jUcDEiTruYWz1zM3U0fkeVrOQos6qNkJcDUmCFBTNGAsCaNcmQxh+jg2pd1u8
         yyEiz/iFCagnQnCMogiYmJTx7hG4H3GPGOgLnDjgnSSFcsgYBTU7zrAbsRIRD3C5bnLM
         +DL1zVZIyXcsBHGNqK4yiimu0Bxp9urKBRQ1Nny3/Y9RD1SF6OoBJQw4QFteDMDpuQCG
         calBVj2GiyXscuXDqzZ2VGUx7knLpFI78wdnsm9M1/1Ap5HmI4eA2+1timgoKSxCN50+
         ZrGMTemk2AO4rGCdZuhFbSKFW+gfBzO6D53nJBwB9NZRUX50kdGvpE3VZtHQsTuhhagN
         znNw==
X-Gm-Message-State: AOAM531cJwXRTuTyoV4CVbF06pK1r6wNuE4LTZk3FaYz6LzCNGDqxbSU
	FITJW+O3VFrrhgwnVCHw7b1+eSPgQHgsrk0TuzY=
X-Google-Smtp-Source: ABdhPJzLyr/25ujKSKbTdzeWeMHT9cLe8tv0tEobR8TRb+KNiC1Zx57Xggksz9VqTkn+V6FOHSSKmA==
X-Received: by 2002:a63:d1e:0:b0:372:c1cd:9e16 with SMTP id c30-20020a630d1e000000b00372c1cd9e16mr17930502pgl.421.1647222086678;
        Sun, 13 Mar 2022 18:41:26 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a655609000000b0037589f4337dsm14883230pgs.78.2022.03.13.18.41.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 18:41:26 -0700 (PDT)
Message-ID: <622e9d46.1c69fb81.54284.67ef@mx.google.com>
Date: Sun, 13 Mar 2022 18:41:26 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-484-gede5006fb276
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 95 runs, 2 regressions (v5.10.100-cip2-484-gede5006fb276) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 95 runs, 2 regressions=
 (v5.10.100-cip2-484-gede5006fb276)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-484-gede5006fb276/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-484-gede5006fb276
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ede5006fb276670a43bd44dd184690177cf47408 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/622e945430ec5f6ba4c62977

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/622e945430ec5f6ba4c62=
978
        new failure (last pass: v5.10.100-cip2-425-g0a0d92194f39) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622e8ea3a03e183361c6298c

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/622e8ea3a03e183361c629b2
        failing since 4 days (last pass: v5.10.100-cip2-319-gcbff87047566, =
first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-03-14T00:38:47.808166  /lava-5873066/1/../bin/lava-test-case   =

 =20


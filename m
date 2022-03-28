X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.439.1648510320640127989
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Mar 2022 16:32:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=50NEftnP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id y10so10938776pfa.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Mar 2022 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Y3JT963cM4mNWwSVKXmrAirFo/RyiqmlBdUCux2ijuc=;
        b=50NEftnP2RdU7n6sbITIOurYP43qohI9dGDuZg8dNhlE7GaMAU5gMk0LVv1ruYHeuy
         eDOz4pjG5qAkYr60kOzCWWdIzEBtpcSn/n8rW5ybuuQYIl8+8+XLsU21zpJS37Gq2Q55
         Wznk0rYWDz952g8FVdglE3SYCF6rcgOYy7YanH2pbVdzDfYnm0FrHVRe4JTeVPytDF36
         kXxDZP1eissQc0yD+gQqVPRgBWql6GdXzwjEOQ+UMXGkNRi6jhq7KbSKQW5J80e4321I
         e/P5+vt/BoNhk6N0XDCzPVZ+o+mZ8xPwV0Pmeu/+zGn6wyAz1ZzeF8MfRQm4IF6Wy4ew
         b8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Y3JT963cM4mNWwSVKXmrAirFo/RyiqmlBdUCux2ijuc=;
        b=SD2oTNLW4A7hNnffj/ly9MG8GVY8nbDgM6QTGS3zM90TUl9tKXcY1t3lDTStICkvzO
         s90EX+dwoOJeYCH2+j0VS/Ms6Sok0J4vVk22u44CI35yAEiyAyt6lOJJHToiA9149D/U
         Coj0w8o2acZkXQQ8BY0uAbVUzaIrRSwt1aO5BW/gn+b4dvWFP3HyyfOB69wAane/uBO8
         Xn+/RTxtEQ5vr4lcqJpaoA46luKIjwajUZ7tEZ6Nn1RRY3zywEjJ9qi2K3113Msrmv37
         7WEPv+PYax3cIr28dlHZLu0P27DW/FYoOWyvpT4k1Jn7V/jNxzO7px2VICqdDAz8Qc0G
         z/VA==
X-Gm-Message-State: AOAM53299dq66nrpiVG+kY43LltOhhygljOvmfCxmUvQKzBqIQOZd+9Z
	Ym6DBBp3maeUCixWLFQPEffY65nrYn0PTzopMBg=
X-Google-Smtp-Source: ABdhPJwme5tP4ofQkUkovg29ciF1DXy95Le+WWdfu9y/GmieInHifi7r6WPgCu8b8CR1ht+f5WbWew==
X-Received: by 2002:a63:e545:0:b0:382:8dd9:a870 with SMTP id z5-20020a63e545000000b003828dd9a870mr11718501pgj.621.1648510319669;
        Mon, 28 Mar 2022 16:31:59 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a0010cb00b004e1b76b09c0sm17244428pfu.74.2022.03.28.16.31.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 16:31:59 -0700 (PDT)
Message-ID: <6242456f.1c69fb81.5621b.e060@mx.google.com>
Date: Mon, 28 Mar 2022 16:31:59 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.104-cip3-224-gbc5581d50c4e
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 100 runs, 3 regressions (v5.10.104-cip3-224-gbc5581d50c4e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 100 runs, 3 regression=
s (v5.10.104-cip3-224-gbc5581d50c4e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

r8a77950-salvator-x          | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-224-gbc5581d50c4e/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-224-gbc5581d50c4e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bc5581d50c4ebee1d73a29e0e3e0ce12e959112f =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6242411bfb7dd792e0ae0706

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6242411bfb7dd792e0ae0=
707
        new failure (last pass: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77950-salvator-x          | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62423b6f54482c2eacae0735

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-r8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-r8a77950-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62423b6f54482c2eacae0=
736
        new failure (last pass: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62423de7a6a7baf0ceae06a6

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/62423de7a6a7baf0ceae0700
        failing since 19 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-03-28T22:59:31.083307  <8>[   32.594550] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-03-28T22:59:32.105340  /lava-5964608/1/../bin/lava-test-case   =

 =20


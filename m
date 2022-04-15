X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web08.12162.1650054989779998699
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Apr 2022 13:36:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bpksvnWe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id j8so7886952pll.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 15 Apr 2022 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SMlkdXL8zfCfUJptlXogETqOTSEHHKdbFlmEQJpTX5s=;
        b=bpksvnWe0/beJzfIN/2kKAPDJXyKJsEj85kCxP8WYJtROhojI2SDrh4XSGEQPtdIms
         zyktjBZt5net8cgHwMsoYvt1lzUasxBFjI1IaMSRe5vHxFP9BqJhKITkodVGth/PwD2o
         xzK1HlNkAu3NYUDgsdPU9MaEiWLd/yE1OaJMqqWdNZG/dfehIxbWr7/VA1zLd8R5+5tz
         53/c1MgY63D4yBAGqt4YsLIKhSZBXgUKGzqeVJa4Gm839Fmlvzo2idEFfvRQqR9UL9SI
         wJS2NvgEuuNmBCspUKg5F61Qs2OPSFsbo/GC5l/1QaXePh7R//gMZriMhi9kjJ8e1fYn
         lmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SMlkdXL8zfCfUJptlXogETqOTSEHHKdbFlmEQJpTX5s=;
        b=5t86yhQn6gZBYCbXl5VvRNsUNo2eSoXk1S7CQ2Y76PIc70GJsCmPuE4yn/MtoUD1TD
         sx9q1WPJggkgmbVu6LrSlkkHdnyMMjo/aOF9eOAk0vD5gMc8y2sgIbyOKxtVkrKDBnag
         o02wbR1uDb1/nVGcfkhoYg7lxOqbrJ1/ypSilJSRIE8VXXdo/RL1olmOjW9Rs9hl40FP
         OmA4Faa73lWeyRTVOSR8YCvmWkelLDg9xWJYZKMex/sEHugcYa9KKv0nJAhcWf0XDLdh
         kItemCnqBiLzqMLqTj2dpTvi7pTd9OsKNcwU0isB2Rtojc6HJl7X2RQ/i2agyGCFRRf+
         mG8w==
X-Gm-Message-State: AOAM532i8UFxqPIBJEshrsxCLwqt1UGLv3KJVigOo7wtvc+wCNCJzDfI
	agr/5ZiZ5B2U+NQqyDqF83AjDb/tKlEVki6K
X-Google-Smtp-Source: ABdhPJwb+u+UiX6A3GG2g8SYhvSJSA+ktFiA22oX1gt2a9GdUTXt6UgnU7OG3cfusnA8AOr4W1EgQw==
X-Received: by 2002:a17:90a:fe05:b0:1cb:b98e:8c78 with SMTP id ck5-20020a17090afe0500b001cbb98e8c78mr5863318pjb.181.1650054989097;
        Fri, 15 Apr 2022 13:36:29 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x129-20020a627c87000000b00506e53ddd4fsm3424194pfc.114.2022.04.15.13.36.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 13:36:28 -0700 (PDT)
Message-ID: <6259d74c.1c69fb81.e59d8.93b1@mx.google.com>
Date: Fri, 15 Apr 2022 13:36:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.237-cip71-337-g1c3cfbe23f3d7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 112 runs, 5 regressions (v4.19.237-cip71-337-g1c3cfbe23f3d7) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 112 runs, 5 regression=
s (v4.19.237-cip71-337-g1c3cfbe23f3d7)

Regressions Summary
-------------------

platform             | arch  | lab           | compiler | defconfig        =
          | regressions
---------------------+-------+---------------+----------+------------------=
----------+------------
da850-lcdk           | arm   | lab-baylibre  | gcc-10   | davinci_all_defco=
nfig      | 2          =

meson-gxbb-p200      | arm64 | lab-baylibre  | gcc-10   | defconfig        =
          | 1          =

meson-gxl-s905d-p230 | arm64 | lab-baylibre  | gcc-10   | defconfig        =
          | 1          =

rk3399-gru-kevin     | arm64 | lab-collabora | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.237-cip71-337-g1c3cfbe23f3d7/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.237-cip71-337-g1c3cfbe23f3d7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1c3cfbe23f3d794216220a2a9fad32c5894a0f7c =



Test Regressions
---------------- =



platform             | arch  | lab           | compiler | defconfig        =
          | regressions
---------------------+-------+---------------+----------+------------------=
----------+------------
da850-lcdk           | arm   | lab-baylibre  | gcc-10   | davinci_all_defco=
nfig      | 2          =


  Details:     https://kernelci.org/test/plan/id/6259cf5afd799ebf99ae06a5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm/davinci_all_defconfig/g=
cc-10/lab-baylibre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm/davinci_all_defconfig/g=
cc-10/lab-baylibre/baseline-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6259cf5afd799eb=
f99ae06ac
        new failure (last pass: v4.19.233-cip69-142-g40322771bdc1)
        4 lines

    2022-04-15T20:02:11.280104  kern  :emerg : page:c6f51000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2022-04-15T20:02:11.280382  kern  :emerg : flags: 0x0()
    2022-04-15T20:02:11.280550  kern  :emerg : page:c6f59000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2022-04-15T20:02:11.280701  kern  :emerg : flags: 0x0()
    2022-04-15T20:02:11.349726  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deme=
rg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>
    2022-04-15T20:02:11.349931  + set +x
    2022-04-15T20:02:11.350095  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 1827204_1.5.=
2.4.1>   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/6259cf5afd799eb=
f99ae06ad
        new failure (last pass: v4.19.233-cip69-142-g40322771bdc1)
        6 lines

    2022-04-15T20:02:11.109535  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2022-04-15T20:02:11.109833  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2022-04-15T20:02:11.110005  kern  :alert : page dumped because: nonzero=
 mapcount
    2022-04-15T20:02:11.110157  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2022-04-15T20:02:11.110301  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2022-04-15T20:02:11.110445  kern  :alert : page dumped because: nonzero=
 mapcount
    2022-04-15T20:02:11.141120  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D6>   =

 =



platform             | arch  | lab           | compiler | defconfig        =
          | regressions
---------------------+-------+---------------+----------+------------------=
----------+------------
meson-gxbb-p200      | arm64 | lab-baylibre  | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6259d1ef646d49dc7dae06a2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6259d1ef646d49dc7dae0=
6a3
        failing since 30 days (last pass: v4.19.231-cip68-123-g92e3e7f3d4df=
, first fail: v4.19.233-cip69-62-g10346bfb0fd8) =

 =



platform             | arch  | lab           | compiler | defconfig        =
          | regressions
---------------------+-------+---------------+----------+------------------=
----------+------------
meson-gxl-s905d-p230 | arm64 | lab-baylibre  | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6259d25362a05e2136ae06df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6259d25362a05e2136ae0=
6e0
        new failure (last pass: v4.19.231-cip68-123-g92e3e7f3d4df) =

 =



platform             | arch  | lab           | compiler | defconfig        =
          | regressions
---------------------+-------+---------------+----------+------------------=
----------+------------
rk3399-gru-kevin     | arm64 | lab-collabora | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6259cfb59eef7abdceae06b9

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6259cfb59eef7abdceae06db
        failing since 33 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b=
, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-04-15T20:03:56.062013  <8>[   36.023683] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-04-15T20:03:57.077356  /lava-6100502/1/../bin/lava-test-case
    2022-04-15T20:03:57.086091  <8>[   37.047237] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20


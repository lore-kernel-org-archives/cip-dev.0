Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC2BC004C0
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 10:03:17 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
 by mx.groups.io with SMTP id smtpd.web10.50857.1697796193100467360
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 03:03:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vmMLxxQU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.43, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-581cb88f645so349658eaf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697796192; x=1698400992; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Jj76RAvR+VT6T0Fmxxzwhnt2ugWnlCxp03Niwc15hA=;
        b=vmMLxxQUnhBJeiuYZDx9V+npx6m1pdQu79AH81yVZOQuMsLW3ycviPh+M6u4mCSFit
         ZT5a4g+JjN9La2whMPDeVLNAGIRuF0YvVdcftCLC5uUVlr3kqu9DQtz5m1giLUjgw6WQ
         BKw09qTGXKaiFM2EtltfBkeyqP2b8x8TRAmrYV9nehojMiaTTN0dnqGnaUUpK2ZKdaiR
         MuSuncye6yJQzCK610VBpiwGCZ5iVep6N2t7BQ05tgXyAV0zynRVU74VKjbaVSRj6MjN
         UV2uWjnRmd+eUF+la0LsEHCuZkEgwjgAc551Kvh1REcB51JgSeYSbOU7xP+dViTOrtSA
         4DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697796192; x=1698400992;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Jj76RAvR+VT6T0Fmxxzwhnt2ugWnlCxp03Niwc15hA=;
        b=L80QctDpY5UxHtcapAQhHJR3nzvgAAsA0RjQJBQXA5oVG7mtywEQSO6eEDRVbXBWvt
         WXVlGCfTNQRLf+8DM3gdohLm5hsquLi8rIvUpSnhk7d+mbdTGB4ezMqObRvvOccqd+oE
         Ga3Vm/AodLV2ao7w6xDyBuUXcXK5uaB8ucEysGDEXlGvxhI0I6lI534zPykkm2/QfARJ
         3FSOGb2hKtbgjho4rvg9wwinhso/il7G1U5Jx+pwAURQ/9u/dbe0Ps76eU/k+Chs/UIy
         RGKM+H+4+drOlTwFYyn3noicA0tuYIGGLqpqjWfcJ7fCMHgWVsK5jRvNbwJChNgE54wn
         QVNQ==
X-Gm-Message-State: AOJu0Yzmxg0XvOucflzo+pLQMkucXslFASnRfiXP+1CZD3h7ryx8FIi7
	FxVpG/7zv/z1nt0zUkZA7cpGlUeUQansHY6UzMlf9A==
X-Google-Smtp-Source: AGHT+IHPXXVYiko3s7rj7y5W1xwawCVOjoO3hqJSO6hxCCt78ua4D5TablsZiyboy7QVHiCG/HYdrw==
X-Received: by 2002:a05:6358:e4a7:b0:166:a7ff:afbe with SMTP id by39-20020a056358e4a700b00166a7ffafbemr1345010rwb.0.1697796191849;
        Fri, 20 Oct 2023 03:03:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a13-20020a65640d000000b0057c25885fcfsm946156pgv.10.2023.10.20.03.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:03:10 -0700 (PDT)
Message-ID: <6532505e.650a0220.9b467.2e04@mx.google.com>
Date: Fri, 20 Oct 2023 03:03:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-cip7
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip baseline: 137 runs, 6 regressions (v6.1.58-cip7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 10:03:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13409

cip/linux-6.1.y-cip baseline: 137 runs, 6 regressions (v6.1.58-cip7)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | cip://6.1.y-c...64_=
defconfig | 2          =

kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig          =
          | 2          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.58-cip7/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.58-cip7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5608f0095a5ba83c76af0e5824c2e2d3f41231b5 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | cip://6.1.y-c...64_=
defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/6532496a7fce0da889efcf36

  Results:     55 PASS, 5 FAIL, 1 SKIP
  Full config: cip://6.1.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
6532496a7fce0da889efcf6c
        failing since 81 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-10-20T09:33:14.733083  /lava-180506/1/../bin/lava-test-case
    2023-10-20T09:33:14.772788  <8>[   35.112561] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>
    2023-10-20T09:33:14.773324  /lava-180506/1/../bin/lava-test-case   =


  * baseline.bootrr.ethernet-probed: https://kernelci.org/test/case/id/6532=
496a7fce0da889efcf6e
        failing since 81 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-10-20T09:33:13.722667  /lava-180506/1/../bin/lava-test-case
    2023-10-20T09:33:13.723578  <8>[   34.058298] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dethernet-probed RESULT=3Dfail>
    2023-10-20T09:33:13.724218  /lava-180506/1/../bin/lava-test-case   =

 =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig          =
          | 2          =


  Details:     https://kernelci.org/test/plan/id/653246f8878d7b7ecfefceff

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653246f8878d7b7ecfefcf06
        new failure (last pass: v6.1.54-cip6)

    2023-10-20T09:22:53.453630  / # #
    2023-10-20T09:22:53.555566  export SHELL=3D/bin/sh
    2023-10-20T09:22:53.556277  #
    2023-10-20T09:22:53.657602  / # export SHELL=3D/bin/sh. /lava-387209/en=
vironment
    2023-10-20T09:22:53.658310  =

    2023-10-20T09:22:53.759723  / # . /lava-387209/environment/lava-387209/=
bin/lava-test-runner /lava-387209/1
    2023-10-20T09:22:53.760841  =

    2023-10-20T09:22:53.781231  / # /lava-387209/bin/lava-test-runner /lava=
-387209/1
    2023-10-20T09:22:53.822713  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-20T09:22:53.831225  + cd /lava-387209/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/653=
246f8878d7b7ecfefcf16
        new failure (last pass: v6.1.54-cip6)

    2023-10-20T09:22:56.201091  /lava-387209/1/../bin/lava-test-case
    2023-10-20T09:22:56.201520  <8>[   17.059632] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-10-20T09:22:56.201883  /lava-387209/1/../bin/lava-test-case   =

 =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/653246ea9ae736bbcaefcf75

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653246ea9ae736bbcaefcf7e
        failing since 81 days (last pass: v6.1.31-46-g4cc1cc26e90f, first f=
ail: v6.1.42-cip2)

    2023-10-20T09:26:52.054133  / # #

    2023-10-20T09:26:52.156440  export SHELL=3D/bin/sh

    2023-10-20T09:26:52.157137  #

    2023-10-20T09:26:52.258523  / # export SHELL=3D/bin/sh. /lava-11826736/=
environment

    2023-10-20T09:26:52.259235  =


    2023-10-20T09:26:52.360638  / # . /lava-11826736/environment/lava-11826=
736/bin/lava-test-runner /lava-11826736/1

    2023-10-20T09:26:52.361748  =


    2023-10-20T09:26:52.378343  / # /lava-11826736/bin/lava-test-runner /la=
va-11826736/1

    2023-10-20T09:26:52.426966  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T09:26:52.427475  + cd /lav<8>[   19.072387] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11826736_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/653246eb9ae736bbcaefcf83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653246eb9ae736bbcaefcf8c
        failing since 81 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.42-cip2)

    2023-10-20T09:27:02.632032  / # #

    2023-10-20T09:27:02.734219  export SHELL=3D/bin/sh

    2023-10-20T09:27:02.734931  #

    2023-10-20T09:27:02.836411  / # export SHELL=3D/bin/sh. /lava-11826748/=
environment

    2023-10-20T09:27:02.837139  =


    2023-10-20T09:27:02.938646  / # . /lava-11826748/environment/lava-11826=
748/bin/lava-test-runner /lava-11826748/1

    2023-10-20T09:27:02.939834  =


    2023-10-20T09:27:02.956518  / # /lava-11826748/bin/lava-test-runner /la=
va-11826748/1

    2023-10-20T09:27:03.021354  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T09:27:03.021854  + cd /lava-1182674<8>[   18.739160] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11826748_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20


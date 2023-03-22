Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E129DC761AF
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:57:23 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.43292.1679493434051749442
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=sQ5vwimF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so19248359pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679493433;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zoFGTjyNgXSsS2uXW5wKHLYhv/RFpiY8j86eQG/q9RA=;
        b=sQ5vwimFvRxcDH0ec5EWR4vU7Ltl7gmrydO/5FF8kJrkviAHvnT0kD6+j37ZFHjR2P
         KfIWZZ479Fa4YksHfcSP5J1F2I3f6Nmbuy/HjDJ9SZxcdCtUhyD05jtoiPLkBXkMip5Z
         GzoNRKxLw+VNjQ0MFwmNYb3ZsMmhqbFWUWIcVOmwvg7WAFSmS1yr20qcS6ZKERIi1vrI
         HwEYl99uGnvHWg8RpWYTAObY09gPqge9kemwkLpsh44U6sUvjmhPmje9D7ov4PmU//C9
         SOrFU+KlkTKpdHidow90KPIwKqCWX+7kFarnjJ7sjvtjvKNOT1r/m6nI0jrJygZVr5Ie
         vvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493433;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoFGTjyNgXSsS2uXW5wKHLYhv/RFpiY8j86eQG/q9RA=;
        b=e8CGkFwbuzKHQjSRNvDATTQRR2xh3wLTTBkUnp97j0QO6ACWBE0LMXKa+AoHwcux36
         ba2dTEYT01UcNHBOdJ4kOp8As0vEowTsPLpAagl+t76Gr/WK58AIyIqbJksew31uomUq
         soEkw1kJm0agY01+IGMgapLlHKQfTOb8invqZmkPEyywRCJUXgvIyf3PO53kkbYoRRym
         XimRsCu2+q28kXSMDL4kwwPLJUM/TRxnTRhmYie3HIbcWH1dBJdisODvfBkhBoT58nDp
         FWXZ2SZ0Z3lucPxuMv1MthyXHzRoEg1ThZ5JSWK9TwFQtKPFn+/ValNnY2F/ubmna/39
         yY5w==
X-Gm-Message-State: AO0yUKUovr2GB/XCXa+3/o2L0yngAdZr+06B+1HfBOseHueNZ1n/vZ33
	yZ1NHKUiYa2vk6K4kcSZSHuqCee8HcrAR2SrOP9AnA==
X-Google-Smtp-Source: AK7set9mz3dly2vONRX0T5nqT3NqV5yEhmU5EI3yEFiMSljkrD5WzjkUClRa9ItKph2ysFefGY+Qpw==
X-Received: by 2002:a17:902:e887:b0:19e:65db:7ac3 with SMTP id w7-20020a170902e88700b0019e65db7ac3mr3696321plg.68.1679493433365;
        Wed, 22 Mar 2023 06:57:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902820700b0019462aa090bsm10528893pln.284.2023.03.22.06.57.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:57:13 -0700 (PDT)
Message-ID: <641b0939.170a0220.ce94e.2a8f@mx.google.com>
Date: Wed, 22 Mar 2023 06:57:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs,
 3 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:57:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11086

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs, 3 regressions =
(v5.10.175-cip29-rt12)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.175-cip29-rt12/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.175-cip29-rt12
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af982107dd8079c9c9522

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/641af98210=
7dd8079c9c9523
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641aff5f781077c7609c951b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktest=
s-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktest=
s-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/641aff5f78=
1077c7609c951c
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641b0169849db83ce99c9535

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-f=
cntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-f=
cntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/641b016984=
9db83ce99c9536
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =20


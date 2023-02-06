Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60184C05027
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 12:48:14 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.52252.1675687693618185817
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 04:48:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=o9imZBAQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id h15so4606022plk.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 04:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MciJiU2+ixL1td6rC6Kji7k1Jh1yQQak6FSbKOIghZ0=;
        b=o9imZBAQyei40WKqXyUbiGF2k9Wi1cGm361s6n1j4Enx5+aob9F2rcLYhbvfcmccFO
         9TprBSnKTZCr+/3ihOxcWDUIT4/yUHgUb+Y1SFSQiBaehxAm69ltqJ3L6/3ychBW9S/A
         ZN5gdH6YZhkQI4hjneTl6dxPrMQB87AOIQc1vwsdK4WoJsdd49unsRnfXKZ4nEOp663y
         LdHaU6xmaPVcbUJWNGG0sT6Zo7gBhRYM9oBjr59LRyJ3+nHAt3WRjEYtCk6uBFxwwMTS
         7kDu9EwX1pwX2HMENbn7ftDfw1kpImj4aBbGk7eotH5GzgAnMvZk9EeyB40AbB6A2YKO
         zfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MciJiU2+ixL1td6rC6Kji7k1Jh1yQQak6FSbKOIghZ0=;
        b=fu1qQ0YKn0FKvySa6BaxnLAlfInIr1rG4hQ/zoV9Zz4VITvUHdbwf+BZp8d2ho88eL
         m+zCKpER26nX1HP4EWAjIy41uANn79OoefnRbLceF40HGPshHDRvNlzAZV0Mvio5htpX
         riGndH019loylXax3Dr9az1SdeKoPfJ4hyz7VLYx2oTL4sf12VPLZMaPdrc87Kw+U0Kn
         4PWq1ir+xhKNm6qpfIwxo/51XDkeDVpY9VAZCqFacNcm6cfUtQagco+C/5Jc15TmjuUF
         WugSVwuTb2dvkgdwm3TigzRjWc+xigpUi39edrXnN9mTH93YT7mwd9XkZD6oQqR4fK24
         CMUg==
X-Gm-Message-State: AO0yUKXvyZ66fT8QZ0ZupMSDMtNdEDiEMlX3rFxuITRRisvRrtT3vYsQ
	z36CjRSaih6jK3SqyFkTVQbF8anZIc4uOmQH
X-Google-Smtp-Source: AK7set8nH7UQuAnStMvW9e4OWhK1jtEW8DPjyGn9tehN9DMwc+PeGBT/wDBuychiStKBHcRuihxlMQ==
X-Received: by 2002:a17:902:e5cb:b0:199:25d1:e54c with SMTP id u11-20020a170902e5cb00b0019925d1e54cmr484831plf.20.1675687692769;
        Mon, 06 Feb 2023 04:48:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a170902969300b00198e03c3ad4sm6595694plp.278.2023.02.06.04.48.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:48:12 -0800 (PST)
Message-ID: <63e0f70c.170a0220.5d50a.9fcd@mx.google.com>
Date: Mon, 06 Feb 2023 04:48:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.165-cip25-154-gb7e05ba4f61a2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 14 runs,
 8 regressions (v5.10.165-cip25-154-gb7e05ba4f61a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 12:48:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10605

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 14 runs, 8 regressio=
ns (v5.10.165-cip25-154-gb7e05ba4f61a2)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.165-cip25-154-gb7e05ba4f61a2/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.165-cip25-154-gb7e05ba4f61a2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b7e05ba4f61a238b39854406f0889bab2b4fb757 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63e0e762943b19f1f7916010

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e762943=
b19f1f7916015
        failing since 102 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e762943=
b19f1f7916015
        failing since 102 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63e0e70732aa11ff12915ec3

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e70732a=
a11ff12915ec8
        failing since 102 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e70732a=
a11ff12915ec8
        failing since 102 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63e0e8fc13988ccaa9915ed7

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e8fc139=
88ccaa9915edc
        failing since 102 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e8fc139=
88ccaa9915edc
        failing since 102 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63e0ebb82156b1857a915ec1

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0ebb8215=
6b1857a915ec6
        failing since 102 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0ebb8215=
6b1857a915ec6
        failing since 102 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20


X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.21597.1650549030279935744
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Apr 2022 06:50:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1xt6tkUY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id g3so4063058pgg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Apr 2022 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YrKTeIJOj8LzQEAiurfEjY1yMiLtBw5RUuA/AIZeIHg=;
        b=1xt6tkUYKJfMUl+LzgnCAin3t8LVmEG0VjnnyhxuEBuFrYgDSBFFO41NV41aUEUpNh
         hnt2ip5rJ57HzYtvzWgT02ZpD/vjwRRhbX1AGnl4HGgz0aG+CIXOxu8lfuAG4VELeP0/
         xYFA1x9nFrQVO1Dugz17yS4oUwdsEvXfjOVBqyXCidmmPFWGyJ4ozz57jIWDH5RyltzR
         LHxvxEn++AK9JxYJYgX5RDy3iy3lvjDrhexEqgg3XmnJdIiDO6PpwPtc7Cby+pEaUyZP
         tdBL8gy5EzcjiGA6sPLu8A0EK0phsyn/Z65kfGxfzFSx+DtRV870BPTVDJLmMxYZe0mh
         kRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YrKTeIJOj8LzQEAiurfEjY1yMiLtBw5RUuA/AIZeIHg=;
        b=X0hR7dA5iIZsgkon6bTsDn4+blRO3Y3ZXaeVtlqFL4Y4YHgRK6mPwZG2sAuvEz+RjF
         G1c5QePYpap4qwve0uyedV04m9adj69leCbATCzXkRHE0fctztCdeYj4urjjLOzARok3
         4R316eERx+2IHKTmCrruxyc14OQPXKUZsWSLtdp8vAtSSicJdlssRp9zq7H0jb9Zkr7x
         QZh17y/wOUSAL4TjKA6igVqj6QTv0GtphyrB5BbA6SmzvY508NNfzR19+Gm3YSmiRSX8
         T8jjjwLWeAkjUbnAcHd4Xc8kxk+IO7+TebqdUAAUxRLBsOJjtnRX3nhY0Iq2Imq2b1fy
         e/uw==
X-Gm-Message-State: AOAM533KFmGsOUWp/ngyWY9QJSyzaR8f/bFsr+l7crhqUwMxMIZQr+v6
	UfFdUYJl+kkxhF+Yg54dFZrPXGxqqE5bt4h8hVw=
X-Google-Smtp-Source: ABdhPJxWKlc2BdXmtB1ePKW64UrUqNQQXX54jKhIH8lSYILIMRKcSbSXxbi2e2ruNQ7pOrZOk61XFg==
X-Received: by 2002:a65:5b4b:0:b0:3a3:d8fb:6926 with SMTP id y11-20020a655b4b000000b003a3d8fb6926mr23623407pgr.76.1650549029391;
        Thu, 21 Apr 2022 06:50:29 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 189-20020a6217c6000000b0050aca6473e0sm6411314pfx.192.2022.04.21.06.50.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:50:28 -0700 (PDT)
Message-ID: <62616124.1c69fb81.24eb3.f374@mx.google.com>
Date: Thu, 21 Apr 2022 06:50:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.109-cip5-24-g4e205e4287c50
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 4 runs, 3 regressions (v5.10.109-cip5-24-g4e205e4287c50) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 4 runs, 3 regressions (=
v5.10.109-cip5-24-g4e205e4287c50)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-24-g4e205e4287c50/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-24-g4e205e4287c50
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4e205e4287c50edfe5c1d4c9775b0670bf9bafb4

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  91fd818dbff1aa3bcefae3747f83e1dd5c1586dd =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/62612120df7a2038f8ff9459

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/arm64/defconfig/gcc-10/lab-ci=
p/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/arm64/defconfig/gcc-10/lab-ci=
p/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62612120df7a2038f8ff94=
5a
        failing since 30 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62612aa31ae2aaf5c2ff946c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62612aa31ae2aaf5c2ff94=
6d
        failing since 30 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/626106e22602fb8ede8f7827

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/626106e22602fb8ede8f78=
28
        failing since 30 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20


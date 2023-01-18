Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BCEC38159
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 21:20:56 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.29549.1674076848176156908
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 13:20:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=lUWT3TQs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id 7-20020a17090a098700b002298931e366so3489860pjo.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 13:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a4b/ILehefm2+TUjBpAuTArmmQeD0wMkGe4UpJlseIM=;
        b=lUWT3TQsFdKjOl7X+whCWwz27zi6wWJwnyeWvkQ+B1PMQX1ZgJp9wjRxDLxisHIATY
         jQNdzBMIwOrCqkL0iVA1w5U1AHjPQMdhVnVTYYF/6M8mhNld0XHaeJfCTmLfBB4a5Xj9
         JcIjSeCkEYrcRufngAP40X354ncVHcY5xi8qAcRO0pJiyVpvmSukiGYEFJMEK3NXv9F2
         iAmNjbuvgJFdcvWHOXnjm8x/O7JIZeRv/PkwTfiGJ233ZU1jvROzZHTKOmpexvKRMQQt
         bc0HCnFcrJn+x77D8P4AjcXN2sGy7LJWfA1/g7QSruYCbhIj4IOmZRuFXTamOtHviy5H
         sjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4b/ILehefm2+TUjBpAuTArmmQeD0wMkGe4UpJlseIM=;
        b=PQVNv4zFmM9FTA1ZnFrDF9rMeHBkMJeMG+2jxCMdoBjhjiwDeUfM8j1fICJgUjbfCA
         ZNEgmCkwiolZuQ9OPHQCIS3B1Oa3obPj86WjJk0Bz1hrlQpdYEHANO95xYnkgba9iNN/
         ckaKVKcS7B/Okisul83ReBMXJCP/DVUL1TyXz5yVm64eSGsrg9z72BICeFkaxA3wthTw
         q7U2upszLf/erFUsGo7cLe45y4rSxs9PW8GcndyFfpyZMoEfto+fyRn8X2dgtFwcCC1U
         cnVo25HPTd2Qr8w3dKZWr2VFGqE3qFBsSrynZVWhef4Y8M1YEz9UDzLRgSVra0aLcTDO
         x0ng==
X-Gm-Message-State: AFqh2kqmP921Lqult1zxLDBOei1a7M8GwZCuAJOUm/vZuVJewfsel8mv
	yyEI7L9sLils34q1XatNnb2mHcHbZx2eE3qmPb9vHg==
X-Google-Smtp-Source: AMrXdXsf9btjO4v6AOQDV/77vJZrDZVtasa4gcvctV3ig87bBjtT+elQuYQKghHt0s43sF32z6qwGw==
X-Received: by 2002:a17:902:a3cc:b0:188:5e99:d84f with SMTP id q12-20020a170902a3cc00b001885e99d84fmr7032946plb.42.1674076847391;
        Wed, 18 Jan 2023 13:20:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001892af9472esm11213956plh.261.2023.01.18.13.20.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:20:47 -0800 (PST)
Message-ID: <63c862af.170a0220.50d45.23ba@mx.google.com>
Date: Wed, 18 Jan 2023 13:20:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-1495-gc851fb1e222f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 7 runs,
 5 regressions (v4.19.269-rt119-1495-gc851fb1e222f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 21:20:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10405

cip-gitlab/ci/pavel/linux-test ltp-timers: 7 runs, 5 regressions (v4.19.269=
-rt119-1495-gc851fb1e222f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-1495-gc851fb1e222f/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-1495-gc851fb1e222f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c851fb1e222f4acf955da1ad9b020f3fc8a51c4b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c854145221bfb501915ecd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63c854145221bfb5019=
15ece
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63c85b843627c9d346915eda

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c85b84362=
7c9d346915ee5
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c85b84362=
7c9d346915ee5
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63c8557cc6d47060a6915ebe

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c8557cc6d=
47060a6915ec3
        failing since 70 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c8557cc6d=
47060a6915ec3
        failing since 70 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20


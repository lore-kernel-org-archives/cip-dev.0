X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.24332.1647248222070015474
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 01:57:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XI+H0/5m;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id q29so12175464pgn.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8wz+/hNU3+kA7AsS+bVaQpX1jYg9uOhgUk6Fl4PAaH0=;
        b=XI+H0/5mQgdb+ET1XTj5d/dX5Uzqn7RmxhqwB7nSPl6q+AjiDDZxmCsPF9OEe6OSev
         +plxFmWtOkJGFpGtg7NUF6tMiXrD62aaJ1XuhonWnYpqVGG7tP5/eWviSHjnhoHZcyN8
         YvrM2TP1zn8838BWtZXpJQ8FSBgusnVahlum+JEIBlhZ3feLYpX1QRjbFY4dIxws6J+f
         kbF+Qmy1m6fQIGskGZyn+iiXsnSDJRJa/EWee1V7ikR59fB/Kib9leg6weAM9pOR8/6f
         DmZ86qGhgjEYkAVo8wha+WZe3NAu/TJqeqq3Ep8wXSUle00zjrA+n9WX8I8i/5kU4Xqa
         09Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8wz+/hNU3+kA7AsS+bVaQpX1jYg9uOhgUk6Fl4PAaH0=;
        b=ySuYr5Yw0GRbQscnEeZk/rVZ0W64pLJTDxzho0559nNy1hBV9nVLFptjbFiwjlzPHx
         g/sBWaxKBvuRMvN7qZ1yUayL+lmGYPajeRlOkFJhQd7V5Zg1j51JgmR/LPlGfJM2WrAV
         f7FQNVVJ9HEzW6MKytI/CBC//WZiuNw6gfIQKLIp3/oXm6QD7HWiud/pEyUODYOLyqO7
         VIgyZHjL5leNUuaBmPLJxuwobG+5B25p2/+aFE/FaO4+7TSTOQWpuZdG+RHnJ4VHzfuP
         Qsz82HChT/GDMm0jpqOT3zU1vX/QAkzJuAAyeBSrcTDvI7q4NR/9sTgho0msBsoJrWNM
         JcgQ==
X-Gm-Message-State: AOAM532w+cjm1ohybeORlD8qLYlmb74N27NuAwQXW0JOEI4kjVSoF9OW
	cj/nSyOkyh2Q7t9pFYN6zpjTdljYiHS9zUYiIj4=
X-Google-Smtp-Source: ABdhPJyTSR5LhgDwJForl/hq+vb9CQelSdpcK2bvpP2kmKZOoLnUuLTMAaUTcSTD+TlsNid+44gMzA==
X-Received: by 2002:a63:7c4e:0:b0:380:8ae9:c975 with SMTP id l14-20020a637c4e000000b003808ae9c975mr19660061pgn.25.1647248221453;
        Mon, 14 Mar 2022 01:57:01 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bi29-20020a056a00311d00b004f6fa51e70dsm17273274pfb.196.2022.03.14.01.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 01:57:01 -0700 (PDT)
Message-ID: <622f035d.1c69fb81.231ae.cace@mx.google.com>
Date: Mon, 14 Mar 2022 01:57:01 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.233-cip69
Subject: cip/linux-4.19.y-cip ltp-timers: 6 runs, 2 regressions (v4.19.233-cip69) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip ltp-timers: 6 runs, 2 regressions (v4.19.233-cip69)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 2      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.233-cip69/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.233-cip69
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      adce3ecbc12596b052ad50a96e765702abcbca8e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/622ef13411de210fefc6296d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.233=
-cip69/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.233=
-cip69/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622ef13411d=
e210fefc62978
        new failure (last pass: v4.19.231-cip68) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622ef13411d=
e210fefc62978
        new failure (last pass: v4.19.231-cip68) =

 =20


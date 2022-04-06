X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.4020.1649213188901412093
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Apr 2022 19:46:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=giHlg2EU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id h5so91076pgc.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Apr 2022 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=41RhNr7/xPGKLNGY1Bf0OMZYyZyu214RNTNcNCiSSVU=;
        b=giHlg2EUuRotyMycMMqy/jW3lrr2SlItLmOHqYqP/4aZvlTzEoaj2xi5hhMDGuWdvV
         ULC7Peevc1fLm8EFJixGXUBUIe5DzyPFekkUUdAR9Dj0wAcP9q6Oi0DuRC8wbJIElUP6
         RxVhT8ixD7l6BWE7KR8GPM+rU70Se7zj6PzB9BDPB+CoLdH5PNRsg7hv/7b8l9rbzXyZ
         3dQt/EC6Wid4jkMdFyxJtKqg3AhJKsNYXCvTdROWwe52DscwoeuhjBB7nL3scmG+ZgGZ
         Sp8W/bowDWCFo8HJtp7/eVbvTbmrKODnM6zl/R/p5pRCsp69zpBpK81YyIJa3sfXS3zi
         ub9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=41RhNr7/xPGKLNGY1Bf0OMZYyZyu214RNTNcNCiSSVU=;
        b=1hAEaZqJJFhJ28gVdtFdcyYq8yXa12qsWm07V9bmZVcZ4A9IzilH0BRqEGhYFukCu/
         RRqY8oXtOPBNTTaE8UhTX4+7pwnGjX6MlVOxLfAR0OCh5MhK6T4XPZwBaH5nEElwrvuL
         Out4Fa3tIX6olHc9xkm/7uY2BiRJhz/G6ISkwAXPdLjNdvCtGJk/jL3x6yFlykLJywIM
         xpiFYbWNYrLPXaML2lFs76Yp6uuS+o2zSrtOkmCXdUV5kGc2ibN0+5Oj5pwgQJQGtz6t
         NtyMA+Rr/bu5jbbud1EmDpVnH4gsrr5oHYljc6GTWIa96m0oD8StCOX0sGQ37ogolji/
         OiSQ==
X-Gm-Message-State: AOAM532NYlcaBvynciXwbdfDQKVsNXRADfHm90VCrsj+Sqqqw6dER2yK
	vDYfUqnXjqWCHfqpwvyh5qrBfVqvcSlgUUe/xbo=
X-Google-Smtp-Source: ABdhPJwJcMXz4tBR1pvkSwW7AClVhtkzEqnOrbjlYtULCCqnVXGtpI1uJwetusjyZdG0kVB8U23N4w==
X-Received: by 2002:a63:1061:0:b0:399:5cd:3ddf with SMTP id 33-20020a631061000000b0039905cd3ddfmr5188738pgq.271.1649213188214;
        Tue, 05 Apr 2022 19:46:28 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x29-20020aa79a5d000000b004f0ef1822d3sm16934022pfj.128.2022.04.05.19.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:46:27 -0700 (PDT)
Message-ID: <624cff03.1c69fb81.7a3e7.d8c7@mx.google.com>
Date: Tue, 05 Apr 2022 19:46:27 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4-66-gc8c4cc5cdb54c
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lib: 5 runs, 2 regressions (v5.10.106-cip4-66-gc8c4cc5cdb54c) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip kselftest-lib: 5 runs, 2 regressions (v5.10.106-cip4-6=
6-gc8c4cc5cdb54c)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4-66-gc8c4cc5cdb54c/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4-66-gc8c4cc5cdb54c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8c4cc5cdb54c5d2534c7533f0cd8a10adff3ba0 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/624cf76bd338548509ae067f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook+kselftest/gcc-10/l=
ab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook+kselftest/gcc-10/l=
ab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/624cf76bd3385485=
09ae0680
        new failure (last pass: v5.10.106-cip4) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/624cf7bbef2381d592ae06b0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/624cf7bbef2381d5=
92ae06b1
        new failure (last pass: v5.10.106-cip4) =

 =20


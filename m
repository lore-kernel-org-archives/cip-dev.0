X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.389.1649866702536909915
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 09:18:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XYdw85Fw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id cj5so2396550pfb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=I9dLv8Mgrv1/MYx2oCcVHeglz2MZE45R6rVbiUBjnSk=;
        b=XYdw85FwnsJTl5rnNrh/Te6uIe6dx7A5RGPGvJAWTEzwgjUxBRwYuBKh0pcm5zgLLL
         Ib5roA8Vhz+lBAAF5WH7s3K8WsNqeWRXB0z6hwFt1EXUrmRIMyqOzfSWYFIqhlvjqFzc
         +mjIh26BS57Cz1a70lzcdsNvq7Iikk2ef6fbCp4M2yuxWxHKIqXPV0TNWc5BjpmxS92X
         J18aLEMP1bpwj5DJFm78H8IaMYFhZJTEQ6DMRSYqcamGcRvLMw1ye/U54ylSAqbPyN9O
         CW5Voes/aItfA1RLJ53WA8n0XJ9CmgucoogOfLTjihGVDg/7fciE9SoT6JsMWKhm/OFu
         MkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=I9dLv8Mgrv1/MYx2oCcVHeglz2MZE45R6rVbiUBjnSk=;
        b=FYSaNzQ99csB/gT1dkLQ0tR3eCTyLmqYVhoUo7HBqFfua+l+UeFh4n1Tp5m5rXIhEQ
         YYdkfhFr5cRX6pZ3vsxum64PxQ4r2nZVSUMUqIO4YHYezTNZz84ENt4OqI9YzDliwfF2
         dC/nqSQKZSIGbtyJl8GCvEgRpH47Xtd3Dx47DkR5bVW05588aPgq5oAL/fK9jSLwIy0u
         Z/mFQT47qnGYvgpNeaflvDCUqCJFCCywzi3LW1EernZ/DUxkuHcReL97D3vrkmuFBIoA
         FDpRVpt5mHDDMUlIurlIUC1TtNzgtF2Dym/Sp0Yu2QRawxBwdkGWdz4Q/dIVE/uix8Mz
         efIw==
X-Gm-Message-State: AOAM533eeM2YeY+1nUp2CpQ7ADX+gyF9cK9mJ3nH754GMo17a7CX11gQ
	ADGTvVVu1gkU7YragSjC6qADwKznvk2zH7OH
X-Google-Smtp-Source: ABdhPJw5h+hdM7qHlr0NV/dNpJpVXeh8G28uG88yEHrLI9wwt3FN1+j7F9uMZ8i43mTcwC7bVX9AIg==
X-Received: by 2002:aa7:9255:0:b0:505:a44b:275c with SMTP id 21-20020aa79255000000b00505a44b275cmr21218306pfp.40.1649866701825;
        Wed, 13 Apr 2022 09:18:21 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a31cf00b001cb7c80616esm3422867pjf.57.2022.04.13.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:18:21 -0700 (PDT)
Message-ID: <6256f7cd.1c69fb81.5a689.8a59@mx.google.com>
Date: Wed, 13 Apr 2022 09:18:21 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.237-cip71
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-pty: 3 runs, 3 regressions (v4.19.237-cip71) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip ltp-pty: 3 runs, 3 regressions (v4.19.237-cip71)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.237-cip71/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.237-cip71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      281476f1d7ee9f59c39dc78e7adb7238cfa54bd0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  163cca9acb71d06492836a667a53554ceec37639 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6256ec5badc56de0daae068b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.237=
-cip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.237=
-cip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6256ec5badc56de0daae06=
8c
        failing since 15 days (last pass: v4.19.233-cip69, first fail: v4.1=
9.235-cip70) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6256f11cf5772f0ccaae06c8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.237=
-cip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.237=
-cip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6256f11cf5772f0ccaae06=
c9
        failing since 15 days (last pass: v4.19.233-cip69, first fail: v4.1=
9.235-cip70) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6256ed6011586fd1aaae06a8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.237=
-cip71/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.237=
-cip71/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6256ed6011586fd1aaae06=
a9
        failing since 15 days (last pass: v4.19.229-cip67, first fail: v4.1=
9.235-cip70) =

 =20


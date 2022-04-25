X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web12.31451.1650901719409317778
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 08:48:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cN9tuhIK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id fv2so290101pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=d53S9GW+7MFlSLxTb6gjdg+HgB5/ia0v0lq+xXaiX1c=;
        b=cN9tuhIK5wibHvgQhMtMU4oh02YqhPxtDN4mSaulUN7l+DARnRvXjaRVXZHPzyKygH
         O9Zf7ZJGNNtk6VSNsAWcFho3bOwYhkfSWM2fhjqs3hN0ML5McA4aJDymwSYnB0mZujWp
         dtusW043InU8a0lnRt7SXe0oVi85/0wXWKMdVI+yq4nMuEmVcfg0kZLSqNv+qAL8BnR3
         xzU5zJYLo50w1vCbsQfBpvElmicr0p7KHxbES7cb2YXOskiJBz0vR0aA29Wg9GTKZXTY
         BP9Z48vAyQGEOkga5aQrsQjecjaRVu5bC5dMl1rYfVAmFh/Yi+wFJGxZ54/fxmXePGor
         qCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=d53S9GW+7MFlSLxTb6gjdg+HgB5/ia0v0lq+xXaiX1c=;
        b=GbuIWSFA4q3CdLY1Tj8p5dRjb1GSUa03fYeIziNlaovlpnTzZNBJcBLMPqil6YGAXa
         gMty98IuaC5nuSYSVbNsccTwANFD4MF1T4s/FC9lA6hQ0b4IzQJg3e1JG4NHof0Iq5AH
         49bskQxqxkyTQ1XBjbqxAucVbtCAh16PEmO56LNxARp6QsYTCFpPZzeRM2HBaOEDPVal
         ZZFaV/blJ+ViNhlato0lhB1y05P3oBfzaKEHSDo9veajlKaDdlag/Jbr5/zhlfhtfN1C
         TULXBYSxe5NZ715G+c3HMivQSSciLgURIphB98KUUdnA7MVtCCkcMfLdyH7oUEabYsY4
         okPQ==
X-Gm-Message-State: AOAM532/dOIddCJtnf/JpBgpBnX+riqJDuXhisNLsQYKENapahFXbI+i
	9qnwxkFn170xmoYRo/qlMd4nWGYdRemHz3VPtH4=
X-Google-Smtp-Source: ABdhPJxxU3VAsHczXLo90C0YTrXPLOw5jkNmzoDIHvSKXFxkpyhndiZcNXtgTwyW5gaUuDlI4E4H2Q==
X-Received: by 2002:a17:90b:4c45:b0:1d2:abcd:be49 with SMTP id np5-20020a17090b4c4500b001d2abcdbe49mr21511970pjb.193.1650901718771;
        Mon, 25 Apr 2022 08:48:38 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 21-20020a630115000000b00382a0895661sm10217202pgb.11.2022.04.25.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:48:38 -0700 (PDT)
Message-ID: <6266c2d6.1c69fb81.e2673.80c3@mx.google.com>
Date: Mon, 25 Apr 2022 08:48:38 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.112-cip6
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-mm: 6 runs, 2 regressions (v5.10.112-cip6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-mm: 6 runs, 2 regressions (v5.10.112-cip6)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.112-cip6/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.112-cip6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8f6747dcd02a8f87731c324f4bc37bd120a8982

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  4e132c1f9e14f9eaeb4f9875eee3f97a4a1ac987 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266bb18dc91d89fa6ff9492

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6266bb18dc91d89fa6ff9493
        failing since 103 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6266c1063416784b3bff9467

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6266c1063416784b3bff9468
        failing since 103 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20


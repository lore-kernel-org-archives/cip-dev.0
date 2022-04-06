X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web12.4013.1649213191188847604
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Apr 2022 19:46:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=euubdsug;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id i11so764212plg.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Apr 2022 19:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=tExf3SULYKSqVhmXnxbdxT67kJn5ErsR57UwD0Dr1bA=;
        b=euubdsugzbV/2qOI8FgF2mFozmgLN0ATrXUYDq4rx2ROh8gLeCQ8ddXP2FnoZsGhqN
         sqLlMfKf9jz9h7RE7GWnyG2hiiZUgeUgx+AVqlElW68eWKzG8zY0d8wU32kO+vGrLBCz
         WASON1QLaL1bB7kcn4C7JimZ+Yzgt4vrANXeb1l1OQKsw4krF4fbBcH0Er7MQkAsThif
         IQmceN/CX5S7luJ3V2OQVwpu7JQxolq9v6zDT/slo4ApeCcTAWid+3RmZFuhRmIBZo66
         rWmfbQ3xEPPGRi5d2WEZyP0pRYiXRmdI4S7BujCqyynJah+Rj/HfHN08XkvOhlVfoOpq
         MOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=tExf3SULYKSqVhmXnxbdxT67kJn5ErsR57UwD0Dr1bA=;
        b=6pKr42+EQ/LIgwHaxFEsbaYK4T8Kw8ClRHnkqvqFwRUwP/lU5aZJ+UxKF/mS1FZexU
         Lwy8FCl0I1S9UWlTetEBiEUx6B6Z1DAVdKbWMA7xX8SGIs2wkLAUlwV5rxw7YY2wQgfC
         4i6J9ifNxYVGm5yqtTqT5+QOMb5VaTUEsGT3ckFUNwgzBUf6xXFU030x0U1PZggelxy9
         9qCv9j3tXLApl1XOy8ZUeaWnRycl8h4mCKu58Y4Jiwqx5/mISXxrRRq/cTuQiveD7a7l
         M+SfGmsX9NO/zai4glWIu08ONrcgCryooCQk4g2aW+dv2/YmWgK5zNjyc8rafp+LQS+B
         eojQ==
X-Gm-Message-State: AOAM532QbHHpaEcjSIg5i3+Fe65SdSj+p3wfeFJ06Gyp7eHHtPywuc5z
	xjsDTYpDs4PIhXEJYVV6cF45lMMLXahfo+EK8QU=
X-Google-Smtp-Source: ABdhPJzZb/MzmtuLw5MeOTclbpNR1nBsa8C9vUK74Z/Ig7UnWjOV0lxAzU5sjl3TLQCA+XA5DJLEKQ==
X-Received: by 2002:a17:90b:3b45:b0:1c7:5fbe:f503 with SMTP id ot5-20020a17090b3b4500b001c75fbef503mr7456167pjb.178.1649213190593;
        Tue, 05 Apr 2022 19:46:30 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 123-20020a620681000000b004fa7c20d732sm16636214pfg.133.2022.04.05.19.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:46:30 -0700 (PDT)
Message-ID: <624cff06.1c69fb81.9a2bc.d3ee@mx.google.com>
Date: Tue, 05 Apr 2022 19:46:30 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4-66-gc8c4cc5cdb54c
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 6 runs, 2 regressions (v5.10.106-cip4-66-gc8c4cc5cdb54c) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-mm: 6 runs, 2 regressions (v5.10.106-cip4-66-gc8c4=
cc5cdb54c)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4-66-gc8c4cc5cdb54c/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4-66-gc8c4cc5cdb54c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8c4cc5cdb54c5d2534c7533f0cd8a10adff3ba0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  163cca9acb71d06492836a667a53554ceec37639 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/624cf13f7bb7c7fe97ae067e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/624cf13f7bb7c7fe97ae067f
        failing since 84 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, f=
irst fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624cf53c2a12fe1949ae06ac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/624cf53c2a12fe1949ae06ad
        failing since 84 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, f=
irst fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20


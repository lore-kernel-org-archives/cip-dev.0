X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web09.31641.1650901718668757051
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 08:48:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=oMj+eU6X;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso6297750pjj.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7e+Kd2mvuvsvu9cZ5yuXuLAvdi8oysgUKHGm/KkKyuM=;
        b=oMj+eU6Xmmtnr7MHKDoeBZij7PV0OU6lBBPxgaqp79DEd+Mom3kn4HskR4NOOONmNt
         ZQQsYAXMiSKctyrBUJ4gu2Ls4q0XtERCK9ef8ztnoSFFosaHVGYeqpQLDFj+gta/0suZ
         2QTY1XIKPET+1pe+z9d3hmhh4yxcPT9Z3df5mOgz+bqUSnbfm+PKdXuPeFr+Jww8wpTL
         l6MugQFrSDkqqzEnKuk0KZeY/U5CxAyt/zg8VlsJP6vuD5Ug4vM3ZZvdUBnxKCGgwUjR
         A0DKLP3+vhfwI1amrIQvN97pUKPGHqx9UHzGXsv62wOH+c2M2JhmlK3eoPL9PoKivH77
         Yfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7e+Kd2mvuvsvu9cZ5yuXuLAvdi8oysgUKHGm/KkKyuM=;
        b=JgdX/kCR6G2xKONjGXHWQEclguy3aUrAjBQksLTL2RyPCC05IAHVlSpF8i05LIZsm3
         jonxPdRFejoqDh9r1b7oeND7dhL1duD4oL8mGwTs4NWUeJGZLK8Xw/WBXI1KVEM/LNVV
         m7kL+osjABvBOJNCkaQ/+lZYoOjmhmdjs39JgkHkzFeJNjc5LtDiriFn2dFjZOVjS0/O
         I6HFiwczYnKZhbLTLwZtgPlwxjzZDhxGNUpVilMBwtbLj3qDb4QEZ9d2vgUgmBsaRTC9
         Q2OuDvnbeOxesyadXnYQXQuUONSdCIURfYSTRt0cjWJXT6KyriV4HkYjnSBWwekiJprE
         SObQ==
X-Gm-Message-State: AOAM532TtL3qJY8vMpPP2pQ9qDjDHyi+rxZDHPGUxRC7aV/+heMDsg7D
	l0w3bGpkgw43j5g81ITraEEMxsP5NxYAgpmXJuM=
X-Google-Smtp-Source: ABdhPJzhOgn6fhlafYqCEIK8UV45zbLoKve6GMq9/FMd7T+/GQpbsPLPwz+eAah7eZJ05z4q971fZg==
X-Received: by 2002:a17:902:ec91:b0:15d:3125:5302 with SMTP id x17-20020a170902ec9100b0015d31255302mr372903plg.111.1650901717915;
        Mon, 25 Apr 2022 08:48:37 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a442000000b0039cc5a6af1csm10047005pgp.30.2022.04.25.08.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:48:37 -0700 (PDT)
Message-ID: <6266c2d5.1c69fb81.40db3.81e5@mx.google.com>
Date: Mon, 25 Apr 2022 08:48:37 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.112-cip6
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 6 runs, 1 regressions (v5.10.112-cip6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-fcntl-locktests: 6 runs, 1 regressions (v5.10.112-=
cip6)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.112-cip6/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
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



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266aee442532b7fdbff947d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-fcntl-lockt=
ests-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-fcntl-lockt=
ests-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6266aee442=
532b7fdbff947e
        new failure (last pass: v5.10.106-cip4-66-gc8c4cc5cdb54c) =

 =20


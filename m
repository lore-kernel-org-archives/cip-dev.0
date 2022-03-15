X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web08.5550.1647307799112102126
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 18:29:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0FvqqYH5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso629255pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=F38/E1UyRCBV+ugnjFC8DicQGO+dOO6XjXpdmQFNASM=;
        b=0FvqqYH5XbGQo4EASArhXkiw+RfW+u68KWowIDklCl5vyK2X4g/pmkEZmXLA/8Gcmb
         r45MEHq0r4oF32QtBfoZeHGGQfEGCqMZWYVwmTB5R9Jxi5bTusi8F0BaCa2fgK2MH3w1
         aX53qxbaI3tPFWLf4z9D3W5tDScBbjhacMIFDj/TEHl9qbq74rWzimPmE9lDtuyD2lqu
         Ltm3WVqZ2VD5agZWUBTM3GzDOoMGl/afsz3PecWeGAiQxCM6jHdP00zd0H+xZN4fz37b
         /v7s5qCCtdyY3jRX0YGaORHvsKMjTlZEaH9GSLchPjkRBkp/8OSBR+LX1BppunLeR7uz
         thRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=F38/E1UyRCBV+ugnjFC8DicQGO+dOO6XjXpdmQFNASM=;
        b=YMRnl+PYvW/JCFuZ7l0mNhU1HBJhW3/81rMFaz+SO6X+TXFXSat63kuN4as6PeI1Pl
         M0ruxdMiPYZ+lYhc1O57ntv83FmPmJlskurM5zF8h3cr/1a3Zj5S+Sn3wShBbTmBiEj9
         wQ/qup+0OpfM4sDXPwfcTyNLBOebh79EMzcKzY2SGdMzzPRXZJDy91oE1gGFbobsjZ8N
         tb2/ptO1MQflpiDAanJwASZGIz7l5OgffXqsm1JgcapcRHvJJjl71VC5ZcbeLnwAevcE
         d9aea42RVRnGGykT9XXVTSCowAvn9qXQmWei3d+g6yYFpw3qco0MZN1uGdbL2wL+W9fK
         0DkQ==
X-Gm-Message-State: AOAM532JXnTv2p11aXyNLnpjwgGU2SOutByknsBJv28OtqQahq8QgwTP
	J49T3vvQotHSjFU66iTx/ojJ/bq4lSTxsr8rwYg=
X-Google-Smtp-Source: ABdhPJyMXIknNqdCiStjuPJPKFVXb33simEKR/Axur0vl6H+B1txXRxSISLuAxLfr7+rkR2RcbBWfA==
X-Received: by 2002:a17:90b:1bc3:b0:1bf:68ec:a26d with SMTP id oa3-20020a17090b1bc300b001bf68eca26dmr1911094pjb.109.1647307798309;
        Mon, 14 Mar 2022 18:29:58 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x14-20020a17090ab00e00b001bf2d30ee9dsm755427pjq.3.2022.03.14.18.29.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:29:57 -0700 (PDT)
Message-ID: <622fec15.1c69fb81.aadc4.2f6e@mx.google.com>
Date: Mon, 14 Mar 2022 18:29:57 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.233-cip69-1019-g2e5815777e975
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 8 runs, 2 regressions (v4.19.233-cip69-1019-g2e5815777e975) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-ipc: 8 runs, 2 regressions (v4.19.233-ci=
p69-1019-g2e5815777e975)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.233-cip69-1019-g2e5815777e975/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.233-cip69-1019-g2e5815777e975
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2e5815777e975e9b2702739a96b2af41357c95fe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fd7567f3e137290c629a6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/622fd7567f3e137290c629=
a7
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fd76945c786faecc6296b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/622fd76945c786faecc629=
6c
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =20


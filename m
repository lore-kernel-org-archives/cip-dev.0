X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.22126.1647223890384188749
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Mar 2022 19:11:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=CgAW4K9s;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id s8so12965923pfk.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Mar 2022 19:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=cV5kFO2xb5g737KrekfIFAXZ76FX4A8d00eGwHxcVr8=;
        b=CgAW4K9s7f2Yatit+hvYN252nY5RATGLvn4t6Vd+oMV/PZtHBMWQBgEqOf6BGisIHY
         PGPpgwwZ7gp8fFBfFYIz6lPKb7LZcUFpdY3OVvje11NK1QJRFWKUZ/HSE0/2DlJMkV4h
         ALfqGGSBxQk63mvS8VPj6NB8pJwjXHStTLf1c6EYH2QqzKV/92PJ6xVxBBpu7fdg2a4c
         a9Hh6AkVXfbKzdGmtx+ESNmBnxUhRlPaGWK8HRlF9wBgpi4zCejNr9cT8sO7F+PxyJaB
         VZkpFivxsBJYbNOlvQDSo2JgC5mKDPHFW7djt8aVh/7khY8iQ2j24f6w3iX4RRKl43OL
         zNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=cV5kFO2xb5g737KrekfIFAXZ76FX4A8d00eGwHxcVr8=;
        b=AqV8MUZrKyWTsqAIjYVKNBVblf9viKQoxSxzcy9InLC/hKS2twgmLzPwg3QCO1hnqX
         yxy3AK4ZDen6cXkdnoDsJkCUEgnJ8H2YxDtpEIqHhmrw0MCavCFj1tXFzRcRgK294J08
         Zm3QC6eBUv+DPRihbLudyiqgaPs5VTqCzeqGuC2CfyWucCvMbMlCnxd504OOUqPqbcGN
         b6zg4hpVI5xUjXYtOzjZdJI2o0FWkLlEr7fmpathPWk/U4idcQ3cHEejhDBIOrw2F1Eq
         G6lCyCrne60RPyNlgHXOHMceAQUVr3c/33vLkKqiUxHzuqCo1bsi2eyskpj3v259UpF8
         08CA==
X-Gm-Message-State: AOAM5330NCb3L2iixJR4iCQ8njB0YF6a7hwMd1lMXkKHnn+XiJad+68P
	7/PJDNpqCSObgbEc3y2JsSYPsRlfdZ02HjgDnc4=
X-Google-Smtp-Source: ABdhPJwCRjRhvr5W4x2UNzvCfSD6cUiaNGJv4or9HWQx4hCA7wswsM1xNltwtx2rfsKsC2FhXWzvAw==
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id bj2-20020a056a02018200b003745a57cbf9mr17867414pgb.616.1647223889596;
        Sun, 13 Mar 2022 19:11:29 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s6-20020a056a0008c600b004f667b8a6b6sm17488476pfu.193.2022.03.13.19.11.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 19:11:29 -0700 (PDT)
Message-ID: <622ea451.1c69fb81.7b828.cd7b@mx.google.com>
Date: Sun, 13 Mar 2022 19:11:29 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-484-gede5006fb276
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 9 runs, 4 regressions (v5.10.100-cip2-484-gede5006fb276) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 9 runs, 4 regression=
s (v5.10.100-cip2-484-gede5006fb276)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-484-gede5006fb276/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-484-gede5006fb276
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ede5006fb276670a43bd44dd184690177cf47408

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/622e91a8796807eb74c62990

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622e91a8796=
807eb74c629a0
        failing since 4 days (last pass: v5.10.100-cip2-319-gcbff87047566, =
first fail: v5.10.100-cip2-425-g0a0d92194f39) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622e91a8796=
807eb74c629a0
        failing since 4 days (last pass: v5.10.100-cip2-319-gcbff87047566, =
first fail: v5.10.100-cip2-425-g0a0d92194f39) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/622e96a69203e2e013c6296a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622e96a6920=
3e2e013c62975
        new failure (last pass: v5.10.100-cip2-425-g0a0d92194f39) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622e96a6920=
3e2e013c62975
        new failure (last pass: v5.10.100-cip2-425-g0a0d92194f39) =

 =20


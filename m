X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web12.2253.1652348953583048428
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 12 May 2022 02:49:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ONFNKq0P;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id q76so4108089pgq.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 12 May 2022 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7wMyNgTHUQOYP6J8wk8xN/PCZ8GyKMlpnqHK+NMcoj8=;
        b=ONFNKq0PpLO2+v56x4LboMGG/DS6+KN5J7HYnYiRvDNjBalcANfHBE1b1JUJSEU4XN
         HhrutVqMc3nSCzWIR+kU51PPJFBp0TbHGzcZMV3rOmlr/YThSbqPD2soRQDIpcwd5rfi
         d0gar42e6eHer7y2uM2V50ZHM4IUFQMUQHVCmxH2U8sVPPS0e94rvtS/ARAgvtV0nH/W
         eao5Wx05N9xFA/JKRtB7WDU999mGRW1HVCedGRS4S1Y64YXwW9aHIFNhqzhiYb/l2XPN
         hYrrVED8OO211gsPXj7ZZ+3be5Qa7pM/iDGCGpBt/xKsKx/PZ/c3yxVygKBj8JLaxaAU
         3BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7wMyNgTHUQOYP6J8wk8xN/PCZ8GyKMlpnqHK+NMcoj8=;
        b=R6F/g8mziyll+Eql7C8fKdmXRVfA0dU5iJG6AzATjQPuQkjZ2GhlIfpRZgr4fs+i0O
         WRDF4XNCtfpPdI5ARccXdw+cYnmdtpmh9SglDxQ/3RFIsMIWHl35h0g9Cu6EtcXst6Fw
         A4DXeIee1GU6m1f5XDOt3SIB7niXTq9GP+l7xnDHbJvtqU/H2cCL00+Zd5qiWJhLxJ21
         rK4z3QOE1S88stdl0FFyxxXiVxibYHqmQoDgKcMx0wI+qGJVmw5Qe2v1n/1t4VseW7W1
         aatvbonMRWeKEEPBIQWLgcThYlELt3w7XOOoAlm4JPP7BKh7XFDg8HM6piy56LaWEvaZ
         hZjw==
X-Gm-Message-State: AOAM5331HceOKN85bgr78PqvirVgAIqTCa1NqhJAJ0bsdbHknVeT8nad
	IVcfOg4IoDsGGnd6mxh3oy5K9XVQkEC6Ga63Mfc=
X-Google-Smtp-Source: ABdhPJz6ggCITyPn2uzWqvgcOODyjOKxVgrmgzGVmeKa02YdItySwopt51JIfhqA77zqX5nNsRDhQg==
X-Received: by 2002:a63:5b01:0:b0:3c6:4935:589 with SMTP id p1-20020a635b01000000b003c649350589mr23295473pgb.314.1652348952907;
        Thu, 12 May 2022 02:49:12 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n24-20020a056a0007d800b0050dc7628150sm3312200pfu.42.2022.05.12.02.49.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:49:12 -0700 (PDT)
Message-ID: <627cd818.1c69fb81.cadd6.7c9c@mx.google.com>
Date: Thu, 12 May 2022 02:49:12 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-49-g02cbcd6511d4
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 3 regressions (v4.4-st5-49-g02cbcd6511d4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 3 regressions (v4.4-st5-=
49-g02cbcd6511d4)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-49-g02cbcd6511d4/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-49-g02cbcd6511d4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02cbcd6511d490bde09277489d0cd57e67cd1d77

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  0f67c9851a9043d0ad68cef4648d103ba7908480 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627ccfed6c4876e39b8f572e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/627ccfed6c4876e39b8=
f572f
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627cd0ef2bef47b9208f5719

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/627cd0ef2bef47b9208=
f571a
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627cce2e66523326a68f5730

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/627cce2e66523326a68=
f5731
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20


X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web12.3791.1647472424822766080
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 16:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=TuUe6875;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id z3so3016606plg.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=W2K9SHH37w6ohdkAMN+AfB0QMCtuHLOSrDLqml6wOGk=;
        b=TuUe68752VSgmayhdfLotqLfPoQKdoer/bUeQI4prK6MCQezesuVeA593BRUN7iUR5
         OQa1o3mZXXCC2IjNeJnq2bbe7tFXbRa7WLaHeG0cvbTSnxnuwCGd6yPJAdUVzGz5VpFK
         0aqOPW2Ry5Q5E71shztU0xswi49DkspkEswqPOBkanB0vj0e9dVQCpXtwV8oNSRQSEpd
         ywmdP3KTqucNc8O2JVXi5YvpPWSsIujTlmqneDodjt155nnONP4W0vTuEuHziBnq1YAR
         nipCQZjDZ5lN5SCtwGgCjsrtk9lWR41uoINvGrZRjVYwKvAPgVgtIDFkdoVdpwn+gl62
         G8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=W2K9SHH37w6ohdkAMN+AfB0QMCtuHLOSrDLqml6wOGk=;
        b=XqktHvPZu32XHLdOQeVOsr4ssFm8rbBIeKLRA89J2/942tZTdoqlZoTO1vfuTB9d3l
         RXIJGhY98qcFneeiAVEPtTpitxVztlVh2SlxaxBgrnhHgE51GLa05wuPUjfHvGl0xf+J
         EAHKsK3eH31FDcxDl5DrqOee0hf+MAX7bfLPNfwXDaehKnY7813/1bC03INqlu/XobwY
         3yjfY72eWc5mBZhjpTNVGgOitkSEmSggjr+mzTAX6RlPNkgkmaZDEx0B+AatY/5e7VUP
         HZM7ANweosPzqeLvGnAWyjPC6qlCsUMM/ay2yICUxQUAAxrVVbDHICblQNO+pcuYUWes
         BIhQ==
X-Gm-Message-State: AOAM5302OKz0dtl4mEuTMrJ6EXQCTg07XQXiGXswy0EE9ZazXCUBiYfh
	2mGku3ke15nK0PGulA6UaFSxTARiRwBDRMsbJQc=
X-Google-Smtp-Source: ABdhPJzNggLbygkh25nVH0hKnkS4f60Ad8JWtzdPOtLp7LGT45gM0tZDaU3whTIbVByM617dzbQhUw==
X-Received: by 2002:a17:90b:352:b0:1c6:77e:a4f7 with SMTP id fh18-20020a17090b035200b001c6077ea4f7mr12629685pjb.77.1647472424003;
        Wed, 16 Mar 2022 16:13:44 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z72-20020a627e4b000000b004f70cbcb06esm4140539pfc.49.2022.03.16.16.13.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:13:43 -0700 (PDT)
Message-ID: <62326f27.1c69fb81.336cc.b017@mx.google.com>
Date: Wed, 16 Mar 2022 16:13:43 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.104-cip3-132-g46c091c34fabb
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 5 runs, 4 regressions (v5.10.104-cip3-132-g46c091c34fabb) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 5 runs, 4 regression=
s (v5.10.104-cip3-132-g46c091c34fabb)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-132-g46c091c34fabb/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-132-g46c091c34fabb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      46c091c34fabba36aab030f3c3c0d43214e7806e

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


  Details:     https://kernelci.org/test/plan/id/62325a0fd072f3cf9cc62976

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62325a0fd07=
2f3cf9cc6297b
        failing since 7 days (last pass: v5.10.100-cip2-319-gcbff87047566, =
first fail: v5.10.100-cip2-425-g0a0d92194f39) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62325a0fd07=
2f3cf9cc6297b
        failing since 7 days (last pass: v5.10.100-cip2-319-gcbff87047566, =
first fail: v5.10.100-cip2-425-g0a0d92194f39) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/62325c442a00821bf6c6296f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62325c442a0=
0821bf6c6297a
        failing since 2 days (last pass: v5.10.100-cip2-425-g0a0d92194f39, =
first fail: v5.10.100-cip2-484-gede5006fb276) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62325c442a0=
0821bf6c6297a
        failing since 2 days (last pass: v5.10.100-cip2-425-g0a0d92194f39, =
first fail: v5.10.100-cip2-484-gede5006fb276) =

 =20


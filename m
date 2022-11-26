Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C20C43217
	for <webhook@archiver.kernel.org>; Sat, 26 Nov 2022 12:14:05 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.68942.1669464843938301449
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Nov 2022 04:14:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=loPu079p;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id f9so5928250pgf.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Nov 2022 04:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RXI4cW1PDi6qSv4qnLZy0f6wNz+EYf8aU8Ck7X7yN1k=;
        b=loPu079pDCh8ACKSa95oAnqfP+FE6lpDQypxnwY4u/8ga6kN0lyodHN8gjf2TzvWVC
         GP/poX+i2TA6eaZzHVovE2wPOIUnUY1G+Exe7+bDixjv7VUQAK3sTk3JJFqzeDO4xW4c
         9WxzJ+JY91vadX4UfZr6mjenHgJLnY02w37vDmpEZrgIdtToD/e2DzrOETbCUQBhxArY
         tAiCDyx9Cbxw2oz7tt37iH/YPSqc+ZOFZpIIta4F41tG5gCzgSkNmV89XJfASvdQF9KM
         WsSpZ1IuX5zhyehYdp5MLHY3gPPkk82rBEYc0/GL1vJs4Da+9TyVEhx65HFHTXLtc1M5
         Zugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXI4cW1PDi6qSv4qnLZy0f6wNz+EYf8aU8Ck7X7yN1k=;
        b=L0XgiqzUHMtF2CIBO67s8vWss6QPo5Pg4cfBbCiB9CDdWmzjEo3yPF/FNQ0QeCOL36
         7xsAXr8VRB6m2huDeglMXUaLXxOMaUfMMviXzms0C+zcaZenSqsJ3rRUZW0FThIBjPK0
         +PesisdJYsLgHgtH2TrjIIAlPW4yxBrksdITQH0pjJe+BpPKgWG1gXtAFR9PrrNjHzkL
         OX9woJZ9fbsTXGkhFvxXJHqJ1HCXC9Ga1T152lUqCDqxhFdLg6zYanWzhi3zxicc1W3t
         Vi68SRdTiwPn52eg1WjsYoR5BBlooyktDC7irXN+GYLck0AzzVxUBHI+cPXDtZJ4gjzq
         +xtA==
X-Gm-Message-State: ANoB5pk7Lnvmz5PUTUs+aVkJJSNyvSXtc2UqBtFb3is+6pvSJzfMEHzw
	fJsUd0QUxNLbObd11vVzUqfZiEjwJbrVc2swdsM=
X-Google-Smtp-Source: AA0mqf4wU4qcDrq1I3pT/YfyaxZwUeW1cDaRsR9xmvIvK1gVCRksTDo574OL+kjFMLvwPWCXTdMU+Q==
X-Received: by 2002:a05:6a00:1409:b0:56b:e1d8:e7a1 with SMTP id l9-20020a056a00140900b0056be1d8e7a1mr23199138pfu.28.1669464842762;
        Sat, 26 Nov 2022 04:14:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y24-20020aa79438000000b0057293b17c8bsm4638509pfo.22.2022.11.26.04.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 04:14:02 -0800 (PST)
Message-ID: <6382030a.a70a0220.17a4d.641b@mx.google.com>
Date: Sat, 26 Nov 2022 04:14:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.266-cip86
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-timers: 4 runs,
 6 regressions (v4.19.266-cip86)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Nov 2022 12:14:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10123

cip/linux-4.19.y-cip ltp-timers: 4 runs, 6 regressions (v4.19.266-cip86)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.266-cip86/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.266-cip86
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8c8d57a3cae5b94b0a26c176e2a32f260fc529ae

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6381f75c649e2f33372abd0a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f75c649=
e2f33372abd0f
        new failure (last pass: v4.19.259-cip82) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f75c649=
e2f33372abd0f
        new failure (last pass: v4.19.259-cip82) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6381f6de5b99001f222abd71

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f6de5b9=
9001f222abd76
        new failure (last pass: v4.19.259-cip82) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f6de5b9=
9001f222abd76
        new failure (last pass: v4.19.259-cip82) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6381f796c6604758792abd16

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f796c66=
04758792abd1b
        new failure (last pass: v4.19.259-cip82) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6381f796c66=
04758792abd1b
        new failure (last pass: v4.19.259-cip82) =

 =20


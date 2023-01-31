Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BD0C64EC6
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 14:11:34 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.13209.1675174289131427084
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 06:11:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=BkYYGE2Z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id a184so10286168pfa.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 06:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6t2mLyHxKCp5rM1PXMt+zZhbtF7xKYS6IVMiIJR67Po=;
        b=BkYYGE2Z/z8cbHQaJHX9MZRgwHrowkjphty8wXWVKd5L/Skh+A1jrQAZEhBeFGmOuI
         MhtkgzgjMBKkBD0wqV28I4Wc4xtxFbMPPOplX3YQHbcP+V71TSvFpwqpjUfq4B+jRMiU
         ORw3RwKTVhTrKBuWiYZEx1gLyoTN5+B1Gy+8EVfr91it+Do80rjFadsSieD7bJ12cbVL
         SJhMOm3pT2CihFOpGGP7FYBQsH9s4g8afngr0bEpO3IZkdgv+NKP5r1x4RyzQwz8fnCB
         DP1mN01kbhUirORMd/evhgyyZW55C+9AgLJun9aM+kis9YDL7/X44kwq29bKZFGYt3KA
         /zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6t2mLyHxKCp5rM1PXMt+zZhbtF7xKYS6IVMiIJR67Po=;
        b=XYr0ilAdktHVSCjYKurOKjjpNFJOVjKvpqgACVEQnUHPa/cSE8mKXo4OKR0RPhFh7o
         XqOCg1aFg/9ZJJHBqro3zPyaY8CzFDr6o8tth8NTKSLREjxe3fOjcNagf5k/VI/85C6W
         5eeG48bbLomELfMvPRRK79b2Hz4cAc92jRIUytfP4pJFb8gBCd0obj36V3U2gC9RHOyz
         iRqXtZK8go6SoStRweFh3/6rhWXIj/WhoBqaQP2WB5PgxUcD2AJ4neZXk2lhJZc9qGUA
         J46ngw/xja0YlChGgASNqtlc1vsOhRU2RYEX/JthyGmqj36VEA0QMpo+1RnfaS/iJjwt
         S2Hg==
X-Gm-Message-State: AO0yUKWUUDyNHiZcAWo80RSdzdOyWgbNFHcF1fWgPohm515FLQnGWbZc
	3ihpAEuruGqa/jlXmn/eGzyZDVIsXq8BMxAwJ+L6vQ==
X-Google-Smtp-Source: AK7set/E7OPeRzheapGfhMFtyOrK7VEgqWIGgs7Gv06kfl75cO7NQDCo+YWEIB8Nyt3fSM5g1TpgHg==
X-Received: by 2002:a05:6a00:e1a:b0:593:9d07:5fe with SMTP id bq26-20020a056a000e1a00b005939d0705femr11557156pfb.1.1675174288248;
        Tue, 31 Jan 2023 06:11:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n16-20020aa79850000000b005818d429d98sm9557128pfq.136.2023.01.31.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:11:27 -0800 (PST)
Message-ID: <63d9218f.a70a0220.a79e9.0441@mx.google.com>
Date: Tue, 31 Jan 2023 06:11:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.165-cip25
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 12 runs,
 8 regressions (v5.10.165-cip25)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 14:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10543

cip/linux-5.10.y-cip ltp-timers: 12 runs, 8 regressions (v5.10.165-cip25)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.165-cip25/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.165-cip25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52aae1dc6afe62fedb14c89fd4feca1d8bb13416 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63d90e5c7d3cd5b322915ec2

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d90e5c7d3=
cd5b322915ec7
        failing since 45 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.158-cip22-7-g92462fd9830b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d90e5c7d3=
cd5b322915ec7
        failing since 45 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.158-cip22-7-g92462fd9830b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63d90dca63a98e5f6f915f08

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d90dca63a=
98e5f6f915f0d
        new failure (last pass: v5.10.162-cip24) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d90dca63a=
98e5f6f915f0d
        new failure (last pass: v5.10.162-cip24) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63d91a14258f0a02ab915ebd

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d91a14258=
f0a02ab915ec2
        failing since 88 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d91a14258=
f0a02ab915ec2
        failing since 88 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63d9113ab957c8c75a915ed1

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d9113ab95=
7c8c75a915ed6
        failing since 88 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d9113ab95=
7c8c75a915ed6
        failing since 88 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =20


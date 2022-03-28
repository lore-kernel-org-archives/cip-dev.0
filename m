X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web08.580.1648504687077764165
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Mar 2022 14:58:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=z30h5eJh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id t2so14053283pfj.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Mar 2022 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xjj/dhkRU/5yEe4+9YikS1J5sv5Ix0rDb9ZV+/zT1qg=;
        b=z30h5eJh0vDsnGYIqKRhyrga+t7wwSwahDeA+a3hXEWAK0wrTxQ05AMS23zj+szljI
         HAQo9MJLvqK+333uGBuTqPfROO5Kv2TOKu0EcmaHujQ+RLka4fjplRvlOyURz/4a/HGQ
         Pj/bTj4qRbFVVdb+duljt6XMtxHtzPlq+bSSqWERLjVyY4NYVrsf0/WySbt6t4IVRIBU
         erEFNJXY3bf3N0fzLr33HfmPP60HxT5AYqzDWUajEt/mXT4UmmOTqjtFItxqRTo9wz2p
         E35uBl2e5SUUc+4wudVC0bMc8fQy57rlGpWIQIuD5slu4dP/eeUUIk6j5QYYsNRzh9od
         XdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xjj/dhkRU/5yEe4+9YikS1J5sv5Ix0rDb9ZV+/zT1qg=;
        b=Mvr+SsMvLJXwvi5isAWEpo9Gi9z1cdo1ZKCQYkbLcNi7Hf4ZYnnDKf1fW8Rl5NqFPW
         /DLK2fzID5kpEHLVQGcfi7xeqh1eQGQqqWLAZTaVDxLMjQv8VsrWcTSZ+FV8ECrZ9Eig
         DN/4D2znG/ohEOWNG48GeVr+7CwIb4HFC0wmEbXE30KkHwmybEsFVnWvaUqGK52Cm+fV
         sPiUZCoH786DKARWxpjmxYA1SJLEXusrFqt/C8dAFbQC9VByyedfqFvn23HFRi5g3bCi
         OOE/jd7FezmS53XeggW0HycDHshfKQVT6FhOwgB7+bBKXbbjkSgPwBkwoga2zIMmwYpz
         v/dg==
X-Gm-Message-State: AOAM531FxZ+gPMm+C/ydcSuf+ueuYTzYgU31bD5+fWGoMp193VTTTt8E
	BQPSko5g+qh0lgkVMSbLTQLq1A2HJvK/KSnlxH0=
X-Google-Smtp-Source: ABdhPJzP+mLHZ21fyfwOSl0/xCmBH5ZhM4v1KwAolnarUHMhLztZXVEuacS0PHK2DFMokfuHttvInw==
X-Received: by 2002:a63:6c04:0:b0:398:54fb:5632 with SMTP id h4-20020a636c04000000b0039854fb5632mr4444175pgc.78.1648504686420;
        Mon, 28 Mar 2022 14:58:06 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090aa40800b001c6ccb2c395sm433910pjp.9.2022.03.28.14.58.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 14:58:05 -0700 (PDT)
Message-ID: <62422f6d.1c69fb81.c472f.19e7@mx.google.com>
Date: Mon, 28 Mar 2022 14:58:05 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.233-cip69-142-g40322771bdc1
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 82 runs, 1 regressions (v4.19.233-cip69-142-g40322771bdc1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 82 runs, 1 regressions=
 (v4.19.233-cip69-142-g40322771bdc1)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.233-cip69-142-g40322771bdc1/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.233-cip69-142-g40322771bdc1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      40322771bdc1d32499c228464c031d6a0779e3ca =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242277ef1002f1325ae06a7

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6242277ef1002f1325ae06c9
        failing since 15 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b=
, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-03-28T21:24:00.259339  /lava-5964147/1/../bin/lava-test-case<8>[  =
 34.770110] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-i2s0-probed RESUL=
T=3Dpass>
    2022-03-28T21:24:00.259415  =

    2022-03-28T21:24:01.270489  /lava-5964147/1/../bin/lava-test-case
    2022-03-28T21:24:01.278514  <8>[   35.790063] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20


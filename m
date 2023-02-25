Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22365C64EC7
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 19:51:10 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.51833.1677354669002599964
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 11:51:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=a+/b+j+t;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so6206064pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 11:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EYhvqZF+tV7xrd2M3humFMcIM+iHK4TCwiLbsNglqNU=;
        b=a+/b+j+tvF7aEU3fI3ZsFEdLgeCbJPgczvOXqOBrjg7JSgghtDa9C45HQ0YqSYao+A
         n3Xd/GMhn/skDslJKxyapm/qAKFkK8SNLixpeU2hzi+4xLmX0iQvwT5k6joY6OYrtUoz
         8VBsJXPgWu1/rZGMyx6btsHA22Bnlv48n1Ahj357h4yG+UKgxG6a/FOL0Tafp/fOAWyn
         fhjkocBJ0j8G0voo2bd4TGLwOLF7NlnbsciBF36+Mw5IE25FEvSkckFP6fzMxFKItxvh
         GHklBpWH9A1tWSPo9A1HmQhcEHDKTvj5ldW2bfUsHHE2DSAo/bLIVn8QvzUnxkUSWFOR
         LUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYhvqZF+tV7xrd2M3humFMcIM+iHK4TCwiLbsNglqNU=;
        b=2i+4t4mPb1D/fkSLmKtnQ5yjRPKQwu6Ls7V44E/FUvQIr+VPgZffnjOeTTka87AWZp
         nP/WZuwgLT5XxB9mOUiThdL4do7nbYPIu6z932bTuSAI+mz5KAkvelnsqeKICGezCOX4
         fkLvHz3xVBrp80usIRrQceB57FQsrhsrqW6s9dQURb1BK4tx/7QxxZDydeKbA/wxwPi+
         FCxW2hXz1Nkw1bv38utKhlOVH9dLm+thtlU3lMHvX84x/A0fp9HT2qpZDO/sDhL9t2om
         zyzSBxSvfuHMDn5e27YR39ORkIX3D4NfIp2VBVKQMZN23SaNxY+jA2aFM3MUbPxDJ6bk
         /jsQ==
X-Gm-Message-State: AO0yUKVNw1jvmY6xijryBMoRKyoPyB10cFxiNc7KHBpGLL/Y7XPI0REJ
	nWUDpswJdsS++KDB+bALnK2uuv3ogm87VmkXwfY=
X-Google-Smtp-Source: AK7set+AWUwx93fzgFWQwmxiOfEPdREW5no1PRRKetpBOFUmeR3G8DoPNeyEpP+Iz8yvYZq2+dkxcQ==
X-Received: by 2002:a17:903:24c:b0:19c:b3c9:5b16 with SMTP id j12-20020a170903024c00b0019cb3c95b16mr13587591plh.12.1677354668100;
        Sat, 25 Feb 2023 11:51:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jg15-20020a17090326cf00b0019c90f8c831sm1612009plb.242.2023.02.25.11.51.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:51:07 -0800 (PST)
Message-ID: <63fa66ab.170a0220.7b3a6.245f@mx.google.com>
Date: Sat, 25 Feb 2023 11:51:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.273-cip92-14-ga8d1f73f2a28
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs,
 4 regressions (v4.19.273-cip92-14-ga8d1f73f2a28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 19:51:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10848

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs, 4 regression=
s (v4.19.273-cip92-14-ga8d1f73f2a28)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.273-cip92-14-ga8d1f73f2a28/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.273-cip92-14-ga8d1f73f2a28
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a8d1f73f2a28c0a328e74bee5d79d0e91de0df9f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63fa591251c6d32c4a8c86ad

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa591251c=
6d32c4a8c86b2
        failing since 113 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa591251c=
6d32c4a8c86b2
        failing since 113 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63fa5ac421ad93c2788c8640

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa5ac421a=
d93c2788c8645
        failing since 113 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63fa5ac421a=
d93c2788c8645
        failing since 113 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =20


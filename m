Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E24C4332F
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 07:33:32 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web12.3056.1668152007704233363
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 10 Nov 2022 23:33:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UcLJg/1+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id p12so3620047plq.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 10 Nov 2022 23:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=69f7NbQ4gh+UYrkHbfsS6BUWCW2jhAS58rlXXdOi/q4=;
        b=UcLJg/1+kGrSBiGDiB6PUZQOjtW8GH0/Sgl9BRjGMwa4ZpUb/niXMLdaWq9nvgvIIv
         pxfwCCt/B/mrLyTJif616/ccMm/MCeU9hMtn47tLP/2AE0WLl8eQr7jgJ9jYuRVIC1C1
         0yMPOeqrnbZ90iypBWAIhwfoxqHc3fSbqpREglrOkvEgEgO+hB4U4pWkUxwKCP4SN0Ga
         BEymXNtWUZzW5VXzztMpWBpcval6ja1R1olxx+RTXCn0+/HzavKey6+/5Nf+gwRxV1YG
         7vNC8X5Obm3Ykw4RqfsLx7Aij513f1tBlFhoLRXkNIn3K8qRvmS08IOSdPSypcLUwFEW
         sEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69f7NbQ4gh+UYrkHbfsS6BUWCW2jhAS58rlXXdOi/q4=;
        b=FgJXOurFfv5PDONnC9J8l+YoARiun3xZCAzfQDHCYjGGdTMo9N49zk1YjH9k81VZlH
         mfi/Gna8dP5n9Jt+nxQUKcF8z3GSiyhD0jsJbIbwgCNqhS65AVGdLKjtOm9Tv7rf97za
         AfV1c8aUwLy27fadUmwMBVEssbT4TSkyUqPkmO0DUW7kH/DJW7tSaYXM7jVA8oz5SnA8
         Wnh0W/ePK6dCbBm3Pv0DymT+5L1D8IC2BC0tmlBJUUrxrbIECR39dv+LQKVpcjfeq+jy
         ADlmMd+n6uSpJ/ZxmDECOwASEADli8hiUbbz1grvpUHJ9f61ilVWsvexdpVhayeMwPSI
         Bl0w==
X-Gm-Message-State: ANoB5pmBkm889TmzT1fp02l0eKFRobhi1FZYkfsV2pM2ol6ot9LcwWlT
	D+PLFZjrFUUkegCTfoF0xrlj5Rki1/Q1g7MeIX8=
X-Google-Smtp-Source: AA0mqf542YxixoxzaabiIvq62rtU1ibkugc1GLLoRXPSj1zdAZ8qopNOnRg2lymwxMoyLWNh+lpqGQ==
X-Received: by 2002:a17:902:e0d1:b0:186:85a0:550 with SMTP id e17-20020a170902e0d100b0018685a00550mr1043751pla.144.1668152006767;
        Thu, 10 Nov 2022 23:33:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id oa16-20020a17090b1bd000b00212daa68b7csm1227183pjb.44.2022.11.10.23.33.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 23:33:26 -0800 (PST)
Message-ID: <636dfac6.170a0220.3bd0f.29a5@mx.google.com>
Date: Thu, 10 Nov 2022 23:33:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.264-cip84-50-g1e56b70eaf66
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs,
 6 regressions (v4.19.264-cip84-50-g1e56b70eaf66)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Nov 2022 07:33:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10022

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs, 6 regression=
s (v4.19.264-cip84-50-g1e56b70eaf66)

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

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.264-cip84-50-g1e56b70eaf66/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.264-cip84-50-g1e56b70eaf66
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1e56b70eaf6611ac813c4ddded7645468a027eb7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636ded164ccf176e62e7db90

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.264-cip84-50-g1e56b70eaf66/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.264-cip84-50-g1e56b70eaf66/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636ded164cc=
f176e62e7db95
        failing since 7 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0, =
first fail: v4.19.261-cip83-311-g41979a0fec1a)

    2022-11-11T06:34:48.322347     =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636ded164cc=
f176e62e7db95
        failing since 7 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0, =
first fail: v4.19.261-cip83-311-g41979a0fec1a)

    2022-11-11T06:34:48.322347     =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636deda121473beb72e7db70

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.264-cip84-50-g1e56b70eaf66/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.264-cip84-50-g1e56b70eaf66/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636deda1214=
73beb72e7db75
        failing since 7 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0, =
first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636deda1214=
73beb72e7db75
        failing since 7 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0, =
first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636dec5a8899ee2585e7db71

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.264-cip84-50-g1e56b70eaf66/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.264-cip84-50-g1e56b70eaf66/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636dec5a889=
9ee2585e7db76
        failing since 7 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0, =
first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636dec5a889=
9ee2585e7db76
        failing since 7 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0, =
first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =20


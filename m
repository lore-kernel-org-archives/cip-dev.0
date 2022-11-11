Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C165C43217
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 04:57:21 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.2120.1668142631365106858
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 10 Nov 2022 20:57:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=jkk4NyaJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id e129so3519402pgc.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 10 Nov 2022 20:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kv0FEVGx3uKk1unYmg+wasiV+HfiJv0KzhBlecBzwrU=;
        b=jkk4NyaJI22xjk9ek1WHVwVuA/1h51P1rIS1lS8hvpFfVOHYSjHZC4+apzt9IB4Z19
         UyHyeIx1LofdrZj7JWsdPMwbHP2gSmp92f0Pt8OqZ5x1GHpRffcL+35FCj+dIXivyIB3
         eo+r1MaGatatRCHyph37oHReHFCVrsKXd8kkxroS5865x4Zp4pllzdVerdmp7FRq1dw3
         r3XvIZooz31qgda3+CAd9zpOVeXHKX9GSZlPh7tJKSb4B3aH3GKh9Z3D22ufzv2Gt+Y4
         nb++Cpt2BpdGdRDpfYUBsLQNXStvozDC6xK5vIqIkTVxhHafDsdc4SsFBLCjbWg3N4Ks
         6O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kv0FEVGx3uKk1unYmg+wasiV+HfiJv0KzhBlecBzwrU=;
        b=0uEemZEyWmPiE02dOxbdKrgoBMQxe33pMrpWqMoJHVpEdrW48Kf3ye9Y8D8ytHSu14
         cJVp9pVBI+z9GtfkUBOFdU90EpMt9Yduar2gAwDwjrAKI6YXTJUUXXR7gZ+c1e2rkBxr
         7/RM0cpcuzp3+Slj8vU7JOrzHm5GoV1UW3efeZtG6tiJYE6J296PPF8awbZHCuMwa4+e
         cfMzI2mZG7CgUrstPed4oGG//Tsg0GSz62MXnkxbXupf8uMbo3Swo05NgHxx0R107E93
         zQtaWU2YAwpSqImLsp3Lbh/et3Di+mA5N+fxnPAKEkzH0ya+5k4C4bqrszs8GPw4g+U/
         4qFA==
X-Gm-Message-State: ANoB5plFL5Rkx1CqTOfvOVeKRV3kcXKe7CEclxAcgKEJ44/V8QMIn+TM
	h/6RAx0TSCe29KOTW8DkHwkmwL8NafUcLrHM5no=
X-Google-Smtp-Source: AA0mqf45WqSClIpfLDYvMu7TFE78TiEoL6l0W9C8EInqnrBpXmkuMBaZFFUSNsVwwHJRVEkP8ZyLyw==
X-Received: by 2002:a05:6a00:194f:b0:571:826f:aace with SMTP id s15-20020a056a00194f00b00571826faacemr912026pfk.57.1668142630701;
        Thu, 10 Nov 2022 20:57:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n1-20020a654cc1000000b0046ae5cfc3d5sm477385pgt.61.2022.11.10.20.57.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:57:10 -0800 (PST)
Message-ID: <636dd626.650a0220.d7ca0.0fc1@mx.google.com>
Date: Thu, 10 Nov 2022 20:57:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-122-g149fbc7cd21d
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 3 runs,
 1 regressions (v5.10.153-cip19-122-g149fbc7cd21d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Nov 2022 04:57:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10017

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 3 runs, 1 regre=
ssions (v5.10.153-cip19-122-g149fbc7cd21d)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.153-cip19-122-g149fbc7cd21d/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.153-cip19-122-g149fbc7cd21d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      149fbc7cd21d7e3a412f88c0e29d060f55e237f6 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/636dcc507efefda510e7db50

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/636dcc507efefda510e7db56
        failing since 139 days (last pass: v5.10.118-465-g0af29783a3c9, fir=
st fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20


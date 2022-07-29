Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6341C00144
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 23:04:58 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web12.704.1659135895240497687
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 29 Jul 2022 16:04:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=uqWM9MRe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id e16so5804926pfm.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 29 Jul 2022 16:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8VjbWVEhQBvg53Pvk3VCVNNzQ0J1z57yXjcV3Youd1w=;
        b=uqWM9MReDIpYex+MW5EDHnblQ7ESbaJH5Ms4eFGBVImkBtkp+tsZMsu24NI+9ja16c
         7+QZ9yWdqEpoxx16wQBAArcT6cN3pCMDxoRXNRTbmznphsXhQlFF5NYwtg8MFwOg2DBn
         sF3fiykrjsEACDXVZr8yKX0MkSVAyML6h8IO4OTG6Pr5iqouCrJw40+6xlvqSg1SKCXs
         MrHsI7mSmJIw8+xFNI+WwFCXLXtdFlcJyB6za3QA9NNSLsf6MjypUUMKVQEO4oVLBZ0R
         UuDybbuQp8rqNVVtY9zfRVGIv7hqz9I23Cn4imKvoRLpHFRpugp0bTRZHAm2TcMHXXGp
         XG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8VjbWVEhQBvg53Pvk3VCVNNzQ0J1z57yXjcV3Youd1w=;
        b=JTuLnG1nYrffK58MZRLiqEdcc3iD/CSPfTYVklTuBUZvdcoJFgu4Pg0FN70eAtZ6Hu
         QmKeBWw5uBxhxL9OXbr75HFhvICdc1bRSXrAlkWRWAuD+n2X2kWhfyYO8mzYC+KiU5di
         zgeMQXVRolzrByv4N3pqCJQu2a5bwALFEChXWZfbmXmg9TA/4MSolN/GTUnhVYjWfWsw
         QEJuvNb6GKl2K+95nICtHCLgJnBj3idSgucShc2oJKiLo8VEZ3SqaAAsPWid0uKs/Bpt
         7tVkOvZaAtyMsKv6PuwA3yGaSDb3pEz3mIICPXywUzwxe7crWlr/x2mHJQiZ4Yk7twNi
         /urg==
X-Gm-Message-State: AJIora/akbOk+YaocPSctMClrHGDuqhSHrcDsyPGv+9goDh/0PKfE8Ao
	PFEhrn5LEolpehBhakcq6+EEyRa5V77lBixLCWE=
X-Google-Smtp-Source: 
 AGRyM1sCpu1YastmxHQewV3M+La68SbwqnQflL2iU+6854N30Cct3AmnXdUWzC4i8yJKP4X3Gpwkkw==
X-Received: by 2002:a63:4d4f:0:b0:412:a02e:2896 with SMTP id
 n15-20020a634d4f000000b00412a02e2896mr4631519pgl.337.1659135894312;
        Fri, 29 Jul 2022 16:04:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 r32-20020a635d20000000b0041b425b6962sm3072390pgb.28.2022.07.29.16.04.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:04:53 -0700 (PDT)
Message-ID: <62e46795.630a0220.8a2c5.498e@mx.google.com>
Date: Fri, 29 Jul 2022 16:04:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.252-cip78-113-gb7034e0f773f8
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-filesystems: 4
 runs, 1 regressions (v4.19.252-cip78-113-gb7034e0f773f8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 23:04:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8987

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-filesystems: 4 runs, 1=
 regressions (v4.19.252-cip78-113-gb7034e0f773f8)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.252-cip78-113-gb7034e0f773f8/plan/kselfte=
st-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.252-cip78-113-gb7034e0f773f8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b7034e0f773f811f76bd4c5795f4eafe7e1dede9 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62e4544f0950919f2bdaf0e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-113-gb7034e0f773f8/arm64/defconfig/gcc-10/lab-=
cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-113-gb7034e0f773f8/arm64/defconfig/gcc-10/lab-=
cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62e4544f=
0950919f2bdaf0e4
        failing since 7 days (last pass: v4.19.249-cip76-57-gef3cc1b9e556, =
first fail: v4.19.251-cip77-82-g10c370b53152) =

 =20


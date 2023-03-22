Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD18C6FD1C
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 10:38:33 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.39373.1679481507265259769
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 03:38:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=DqEwR5fA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so23171988pjt.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679481509;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6aa81ubgDHmo58hsek2KZ1OEIE5KWvvVQsDR8/i9TGM=;
        b=DqEwR5fAvN8+JdG0USu7ieebFI1J6jUnpdEReEXJEBaj1r3H3d1l1aGD7D2nwAnmhD
         16wtLZT1F62xLU3pceafDvePBAaTaKKcK1xn8bt8sbxWc1gRhygxrABq00vnwkHz+bFM
         ikuvCchQ8QXNL2hn1u+hjgSGEe0FMLBtatOmIndj5n45UPS8QYl5jNx80+wGSn5qvKtP
         yo9OYrPtYpHcBTbmUTwIVC2UXx27gBqaHL4Lac/IdctTMQKm3Iv9Z0wVEj7M5qisMG+r
         f8IYWrbjfdiYHSRTlOFCBtBP6mHACMRNLwZ53px55JTNeS1XoNSSIosngXRX3Q6Rrs9h
         48Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481509;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aa81ubgDHmo58hsek2KZ1OEIE5KWvvVQsDR8/i9TGM=;
        b=jVZpQnWM5gj6Wic52th3OFgUMLKZEtvJ0HqdEV4qHXN0hr2AQgOeFCIpZmO/ymHbxc
         ZOZ9ZjwdT/j4KQeUdff6n7ZXi7tPKZ/FQ5QBcP12rnpTkH3yHZSJtPsFHn79fyFEnvSu
         BBBdYrwCu/Ofatbd1XWwd/vx4YoRhO3pg4BFpwblmfrWPbk4OOgq+LHbdgd2CLs+KPHV
         y648v5c3tyumIvjQYuj8wjHFNrLteJlYNUQirdCTKdL/bOLBWvWtKJ98TNedTxWTeVay
         tIiV9k11wkXqvWigdjU4G106+bnOwEww4j2lPO3T6tpbHwn5quXwarfAtRtvfkS92xfK
         On6Q==
X-Gm-Message-State: AO0yUKWuJWWdh6mDduZzZ6aKW1OlZ1GyTkyBGOj+Ag80yBJCL62AiBqc
	KJO3aXjKZUYWvYlF4s6QK7YaRE7StE6JeuZ6Hv8WHg==
X-Google-Smtp-Source: AK7set8S7orzT5hViK8q2AEX/+Pnrs19ab/8J0JKujwu/RA5+WGUv8up4bHbpX29Y9+40SsDWaXjXw==
X-Received: by 2002:a05:6a20:47e0:b0:db:13b2:6079 with SMTP id ey32-20020a056a2047e000b000db13b26079mr2460436pzb.45.1679481508783;
        Wed, 22 Mar 2023 03:38:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78dd7000000b0058bf2ae9694sm9820600pfr.156.2023.03.22.03.38.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:38:28 -0700 (PDT)
Message-ID: <641adaa4.a70a0220.72bbe.1853@mx.google.com>
Date: Wed, 22 Mar 2023 03:38:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-1098-g26d9f86d942d
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 6 runs,
 1 regressions (v4.19.277-cip94-1098-g26d9f86d942d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 10:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11069

cip-gitlab/ci/pavel/linux-test ltp-mm: 6 runs, 1 regressions (v4.19.277-cip=
94-1098-g26d9f86d942d)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.277-cip94-1098-g26d9f86d942d/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.277-cip94-1098-g26d9f86d942d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641acda9535729e7e99c950b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641acda9535729e7e99c950c
        failing since 25 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.168-cip27-456-g42a59c4e5329) =

 =20


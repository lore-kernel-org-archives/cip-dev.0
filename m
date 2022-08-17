Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE2EC32772
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 12:08:14 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web09.28226.1660738085800688314
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 05:08:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=pCfKbxZz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 s4-20020a17090a5d0400b001fabc6bb0baso528659pji.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=6+dlEj8pKF435WFKP3SgYSLsKg8Ey3esgs7fZtnMbpU=;
        b=pCfKbxZzHBR3KlVa8eMGdxvzVCefc5763kNsP2K87yvT20QOWI3Sy77GzQ7rQAmzT5
         hasklgBCLrtjlzODscj/s9tAorahG1XCpAejV58tq0UjQ8N8UOnw6GZXKqcFwpbUaukY
         bD0nEvXL87nob2+xYCDaZ7VEmkQZ3BhsZwz06UjBpCR4UuEVFORAahwq6buFqToTiTAW
         36VqGxOZf2OWi3Gu7729v34h+2LOTJplaC/7VKQfSul8BIH3/Dk1pzbbOPZvR5Nv9WsV
         r7JdaVpsOm25nBcx306fl831xgxx1+LckOegGVGrkBIZangx4myXrXUersOrsP2usgsH
         F1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=6+dlEj8pKF435WFKP3SgYSLsKg8Ey3esgs7fZtnMbpU=;
        b=0c6JmrICMVDggjPKkj0gW9Rq7T+Sa3ghQbMCPaJgQTacv9k2YDF9RIdWojIte/4w4d
         kF7wkwlZPUqx8cjcKUQWeOnG6wWgt9jRPbanNvWpbcA2A+UqCTNepHQv8FnLvT/nKO0a
         e93CHn5bW6xJr66uAjsGOp+Gp4K6vTWJIzE3AdJm+fNmBtSCrTFdA1Of5PAUurmvmRft
         /a19/Z4Y8lIbdPazOstPZI91iPeD4VxYbBfPC/sEXQ1b4uDpYXP5mhTcZ/T0XZwM/1qB
         /j5UNao4SmWSLqwpqILrdbuI8iJ2LOm1NSbC0EcsVzMY4+INRVWlWbVeuMzKco41QIjM
         rn0g==
X-Gm-Message-State: ACgBeo2GBMRlYZaUuQxAILgoe8hJYde3dhG7ALAj+y5VNE9VLyR8yXO0
	RWX+R9mMpxS4ZffVCREr6JwxS1S9iTV1Q5av
X-Google-Smtp-Source: 
 AA6agR58qAPi70y5hKra/JH9XAgO5GFuwLsl4eQzklkyYSG2erXjBo8xv3UH17O02g5yZll18RKEAg==
X-Received: by 2002:a17:902:c945:b0:16d:c318:4480 with SMTP id
 i5-20020a170902c94500b0016dc3184480mr26685934pla.147.1660738085002;
        Wed, 17 Aug 2022 05:08:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c7-20020a17090a1d0700b001eee8998f2esm1355550pjd.17.2022.08.17.05.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:08:04 -0700 (PDT)
Message-ID: <62fcda24.170a0220.eb2e6.2303@mx.google.com>
Date: Wed, 17 Aug 2022 05:08:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g3b53e4dbd9f41
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 3 runs,
 2 regressions (v5.10.131-cip13-84-g3b53e4dbd9f41)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 12:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9277

cip/linux-5.10.y-cip kselftest-lkdtm: 3 runs, 2 regressions (v5.10.131-cip1=
3-84-g3b53e4dbd9f41)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-84-g3b53e4dbd9f41/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-84-g3b53e4dbd9f41
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b53e4dbd9f41171cf639b3ba0b107f6d6f444ac =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62fccae19c16ef7fdf35565a

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62fccae19c16ef7fdf355660
        failing since 50 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62fcd1105d8d8474a8355647

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62fcd1105d8d8474a835564d
        failing since 50 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =20


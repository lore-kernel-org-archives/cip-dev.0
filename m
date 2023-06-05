Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219DC7EE2E
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 23:40:48 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.144.1686008442629275918
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 16:40:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=OH8LldKz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.54, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6af6fe73f11so5114795a34.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 16:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686008441; x=1688600441;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FJeHnYowd+/4HkQQHl0cIZ8CZhaAW2/8JeeKzIBcrLs=;
        b=OH8LldKzoUe9YLoNXefZlM0kY+/mXgm9rf1F4Xse+kXD4JhJhr/68qrE2L+XgLGXoM
         ytE7rsh4xB5KTGe6o1ciH21NKpcuSeqjJu/lrS1ZeK6t8W2WkzrPGkcUs1/JrpFWVgjK
         YntDe9nCAnIdMeepNKy5iyOoD3Wt5Y8Clg+yBF0Oh4NUPquh+aX2xlVvJqjM5HY0lr/n
         LA3seDr/mtzmlldVEhQXDC6yYZOkM2ZRVrnkH7UvEyqoc4qfshyBI1tyTb2cPfwcGPfy
         q5AtbtnZjhaejyhJK6+cricVWwfiwZGKfuQ9VIXw2C1kqvFKf3Oo7MpFJKA2z2C9mSII
         qTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686008441; x=1688600441;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJeHnYowd+/4HkQQHl0cIZ8CZhaAW2/8JeeKzIBcrLs=;
        b=HpEyTm3ivCqAuYTBOjIg6cQscXY/K3HY9N5s5iUCnH6+BVHhMZGE8sdnxP79e/xWLK
         CBdN7S246kX2Dr1k3vV58tekut2kJsFfL05b0l5IvRmr49HLvRPV/7mMT/H5uCu8inUN
         w+8vyEaeBQ7scurTVe/JWJrsyCeMG6ebqqu+uoj1ybZbSybiPvq2mUjI+fxJn2Gkb/qE
         OtrDZcWPr+C0AzA4EPW7N3CrSdiHOJHCjr40JdgYKyWt6aBMYxFEO/yPoWsGys0W9/TX
         q0hRrKOtHnu/rgderECadsv7Kgo1Pzm2uS4ZehuNCsnzFjYAXn1fvNyawnALdcvoFqEA
         D1MQ==
X-Gm-Message-State: AC+VfDzI0BROggdKA8gLMnvx3bUQJwSGN08CYiyKo7nzld4hVo22jpPA
	b8EGCHlCNqeI72MbN9PhdmSRxdQYX4SyAzGhRtjoQQ==
X-Google-Smtp-Source: ACHHUZ4XmYxmscq6wRT7749XgThEkvbubzY/VwBJIGNs2MWV0B1r+T4gmFWnPXzoQj0NH+f1G6iHhg==
X-Received: by 2002:a9d:6a45:0:b0:6af:9f36:fae4 with SMTP id h5-20020a9d6a45000000b006af9f36fae4mr274223otn.10.1686008441621;
        Mon, 05 Jun 2023 16:40:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78294000000b00571cdbd0771sm5671537pfm.102.2023.06.05.16.40.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:40:41 -0700 (PDT)
Message-ID: <647e7279.a70a0220.e5a2e.a023@mx.google.com>
Date: Mon, 05 Jun 2023 16:40:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1314-g1ab0ac1d7e2e3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs,
 4 regressions (v6.1.26-1314-g1ab0ac1d7e2e3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 23:40:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11833

cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs, 4 regressions (v6.1.26-=
1314-g1ab0ac1d7e2e3)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64              | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1314-g1ab0ac1d7e2e3/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1314-g1ab0ac1d7e2e3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ab0ac1d7e2e3aeca50f8616b469772a5f010acc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64              | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647e6219ef4237796cf5de47

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e6219ef4=
237796cf5de4c
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:30:31.353958  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e6219ef4=
237796cf5de4c
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:30:31.353958  =

   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647e6371e692e0ead1f5de31

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig+arm64-chromebook/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig+arm64-chromebook/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e6371e69=
2e0ead1f5de3c
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e6371e69=
2e0ead1f5de3c
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a) =

 =20


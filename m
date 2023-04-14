Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC68EC77B72
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:23:10 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.6707.1681471384847892691
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 04:23:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=0y70JCvG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id w11so17982717plp.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681471384; x=1684063384;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xRThRSZk/hMHPukEZZddReYtOVWWBoEyo75GfHXkeDc=;
        b=0y70JCvGYYZ/Q1/eDYznt4fwmXnrK3NdOe3JXDwOwbNoYFGESmZNiMgntzMu7LhV6o
         k5xtaUihiisWt0WpFPEGrh2kUZvFn4n4JuvlkUV3kbK3zNpqFWxbsmyjkNWIvb8J74E9
         ydixf79w0q7hz5LcoR/QmlI/P6r6yCYy2y0HZ8xYNFTzE1wespXJkPkt+FBGwCoqR563
         htf4+bnnH7cMDW7BsBUpCvPiE2M+LG8RrBb07Y0Ib9lknGOUlgQ93wLLPyj6hz74R1z4
         uUFkji3+XNtl0Z8xYXB84NDZAiPqV56f4V0QT/HHl89OLGi6R6JbTWlb9ZkUnBzTVi8w
         Ngvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471384; x=1684063384;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRThRSZk/hMHPukEZZddReYtOVWWBoEyo75GfHXkeDc=;
        b=jJMZT0OabULjGery4zY7+G9BeP6d3gYYxOEU5H6UnPBFOqdMvbn4ySik1IZBJjDzXY
         ZwRCDHwzxfnb8aBLjeZk8pAVPasphONqe44nAQgJRBL9xCh4wOghUgo4tLd+3ZksrYP5
         NCbMIKhEq8I/cUfDdneyMpMsXDdQSn9mWIhPk9nWK2dC9Zp9ItDKgX/r0D7yjjic9xxz
         gAsvXAuO7SzdpQkxckt0EqF+ceWyrqFTSInPwZhi8tztd5Y4tw5euJe1TDycI3ePY7AA
         f0/NdHJuv1Y9ENgM93EoYJyGk2MRv/ZY+7Im94stgjyxK+TLvAanHZY3MFd5VfO5KcQy
         k/gw==
X-Gm-Message-State: AAQBX9dRC7A4CXsOJHKzwyaXL8P9LIOUUZcBnACtv47DlO1tUu9aR144
	zD7rATzldelP9k4JHzCH0JsXxiHvQCLFb/N5r0J2kFH4
X-Google-Smtp-Source: AKy350bViCFaxvBx3oDkUpEb7hFCaovC4YGLU94SE5OA10xSSBd/gQNmBctoaH7mmFd3utDyIR6lkw==
X-Received: by 2002:a17:90a:17ce:b0:244:afcd:f5d4 with SMTP id q72-20020a17090a17ce00b00244afcdf5d4mr4713690pja.30.1681471384046;
        Fri, 14 Apr 2023 04:23:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090aec1300b00240aff612f0sm2729290pjy.5.2023.04.14.04.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:23:03 -0700 (PDT)
Message-ID: <64393797.170a0220.6b4a7.6e81@mx.google.com>
Date: Fri, 14 Apr 2023 04:23:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.177-cip31
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.177-cip31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:23:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11213

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.177-cip3=
1)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.177-cip31/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.177-cip31
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      deb75c99ed78d677587a345854b8a00fb2cac68c =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6439303a3685d590402e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230407.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6439303a3685d5=
90402e85ea
        new failure (last pass: v5.10.176-cip30) =

 =20


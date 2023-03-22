Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307C2C6FD1C
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 14:26:24 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.44461.1679495176497877623
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 07:26:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=K2kpuIET;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id ja10so19437127plb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679495176;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i8pYK+v1V1zihRt3Z2zk7Tj96vwZRCwZHTVOBDoY+Xw=;
        b=K2kpuIETz4nC80CX3WNIDEumD5zG1aHxv/QOsybG20tVw4ebCkN3WUkl4QlyE/cXON
         xW2AodtI5VZYHX/Mi/QhsYwJE2yni3vg3uAlJa3zAqxPrae4ba//ZFlqC01Dh3B44N30
         Ybc+bl6mQeTssyoGYzpwPo5sZ3By0Bg6iZmLzjNa4+QUfZZkfGL1NQVuNNmkaooKdORo
         e7OoEnKFtg58vwvQoR3k79BgyxMCxOV8ikoHTbbeqHoihQolX3uYUbERpmG7tXB3pdoN
         2rzq9gPCD/AbBopvlSORa/hxnqNG/A3u6LBkNvuvR8RdYldDiLxxwp6/jKpAo7L9fNlJ
         j9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495176;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8pYK+v1V1zihRt3Z2zk7Tj96vwZRCwZHTVOBDoY+Xw=;
        b=5DD4+0AfR8Ztj8WLSHq77lXvEm1jt4xvhNIU+UB8sbXT+V20O2jS9yfcf9aeuxiFpF
         mjt+gadeaa/eTALJk8DYC/naw8bmzJUVkCxOrgM7OcRZqUdsr9giRO/iZaH0jRWkVxYr
         ibiCxtmQfpnsX3Df1T+1cTdd8WBsTIHuaA4hdBzUU7vJ1Ge3ZOMhfrneO+JmKEwlbYNI
         k5posFCLaKAgmlwBoN2dLqSvTTVlki6CNMaAC0HXP9eQ4P6r11JliZQ4o9mU8jXBxxga
         g7eRQ2fgDPutpnkwWJjfuz6ceC2IpraF3A/Jsj20JGaJnYU4AeH6b2uKC4ozedqZhlxY
         984w==
X-Gm-Message-State: AO0yUKU1UMEwPc1r1O+NOLxsIpvvXxHpN5xh8YNZ47KD6E11d4hYw6K+
	lpcmyT2IcefRT3DgxbvbOOt1LiDq54ptE9Qf7xFcCg==
X-Google-Smtp-Source: AK7set+U6O9/EF9Jhqy+0an7nV058O5Q/kOXrPenEYA9g64WTMocCw4pJOGAjqH9tJ/Y6flkL1ggmw==
X-Received: by 2002:a05:6a20:65a9:b0:d9:49a9:fe6c with SMTP id p41-20020a056a2065a900b000d949a9fe6cmr6566879pzh.11.1679495175861;
        Wed, 22 Mar 2023 07:26:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78105000000b005938f5b7231sm10076474pfi.201.2023.03.22.07.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:26:15 -0700 (PDT)
Message-ID: <641b1007.a70a0220.70bd2.18ee@mx.google.com>
Date: Wed, 22 Mar 2023 07:26:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip/linux-5.10.y-cip-rt ltp-pty: 9 runs,
 2 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 14:26:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11094

cip/linux-5.10.y-cip-rt ltp-pty: 9 runs, 2 regressions (v5.10.175-cip29-rt1=
2)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.175-cip29-rt12/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.175-cip29-rt12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd5716f4cb62ea9c952c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty=
-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty=
-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/641afd5716f4cb62ea9c95=
2d
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb127b31187cc49c952a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/641afb127b31187cc49c95=
2b
        new failure (last pass: v5.10.162-cip24-rt10) =

 =20


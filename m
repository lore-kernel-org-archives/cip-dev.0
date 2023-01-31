Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D84EC64EC3
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 14:11:34 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.13204.1675174288609202845
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 06:11:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ARa43SXv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id ha3-20020a17090af3c300b00230222051a6so882146pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TWwW0Kck9cJCuzvHmqsUcXMZwARB4pNxAa2ub8W7hhg=;
        b=ARa43SXvTSo5BhXjcza86RtArSun1zwGUV+u+GZL7ym8hbL/5sUQDX6Euiefxc3+/o
         DNBBpWmjrWKK9rBtWJn9MVDSxIimy3X09ISZAZmDUo8JbOs2Gmx2LU9OWx9VwIt3Ba5O
         NfFyoMK9+5qVmaOUf2MqDKb29pmtKNasUqaNdbYxg4VhWYjOerm5X6zdml4pDtqOTsk0
         lJH3M54b6L5ojwgNrmFEDmj0EIzJuvOKLO86AN23fM/xu+IZt/T0Cyw24zI68FceXej2
         Qv1FDy7ie0t9hGX0/CI+eboo57XEsphSzErlyZ6ZSR426QXW8QnrdM7cSR1qURQBHbVi
         kkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWwW0Kck9cJCuzvHmqsUcXMZwARB4pNxAa2ub8W7hhg=;
        b=TST932LFJLWvM8FRJu5faWzAwTZMk7KlSAvXRLnROt/yBrpCQP63dROsbe3znChXqp
         heCc7Rp8fTgPSzz3GCwcnC36FJ6UbKQaqP2ZtXBO9aCqOxXUIZ2Hwuly52/kWTlSKDqX
         PN+4rUt8y3zBuJ90Uj7va4lkl1uZMsNx93fcDG0vDqLt87nv4xN0XLhK5BV2I7MHWPUy
         3gS6g6hWM6tYHk486tUq4l2q2z8q/IfV+fTEV5V95g5fIvhUO+2LXeU4dG6KVZ9dX1Uj
         UIqiy/dcufE50/CaLGXGG+U72WZmwoV5CLnB62GstDYQz+i8uJpvP0zWr/rdt7RPNulD
         3AyQ==
X-Gm-Message-State: AO0yUKWTy1/T42BK6Hs1LttbEQYDhk9ZJF0J0FmBWVoNl9HDYaQhtN0u
	FTBMA8iHbLaueMfJx4vhuiw1Zu77d2o052kKOS1MYw==
X-Google-Smtp-Source: AK7set+3kPs/G2WznUbEk949tt7rwtb3yeDpNqPa+S9ALAQLh2Iln9WLmubH4z0rgSZ4ylxfccS9qQ==
X-Received: by 2002:a17:903:ca:b0:196:4e75:c933 with SMTP id x10-20020a17090300ca00b001964e75c933mr13764388plc.13.1675174287278;
        Tue, 31 Jan 2023 06:11:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f7cb00b001926392adf9sm9835229plw.271.2023.01.31.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:11:25 -0800 (PST)
Message-ID: <63d9218d.170a0220.bb2e3.0c94@mx.google.com>
Date: Tue, 31 Jan 2023 06:11:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.165-cip25
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 7 runs,
 2 regressions (v5.10.165-cip25)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 14:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10540

cip/linux-5.10.y-cip kselftest-seccomp: 7 runs, 2 regressions (v5.10.165-ci=
p25)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.165-cip25/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.165-cip25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52aae1dc6afe62fedb14c89fd4feca1d8bb13416 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90d6a3a5344cf50915f0d

  Results:     87 PASS, 3 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/63d90d6a3a5344cf50915f0f
        failing since 82 days (last pass: v5.10.153-cip19, first fail: v5.1=
0.153-cip19-3-gc76f4e7e5c71) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90ead1131f79c22915ebe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63d90ead1131=
f79c22915ebf
        new failure (last pass: v5.10.162-cip24) =

 =20


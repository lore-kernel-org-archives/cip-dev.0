Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E1BC47422
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 21:08:58 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.web11.35005.1704488937956022424
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 05 Jan 2024 13:08:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wJHV/+Ai;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.47, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-595d24ad466so12042eaf.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 05 Jan 2024 13:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704488936; x=1705093736; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=btHnhBY6Gdo30miqKJpxWq2UU4pzXJBv7Ai6upI+x7Y=;
        b=wJHV/+AiMaAO261V+0H9LKMnbsGDJix8z3Rj81/u/Z7jfS5LffbY34SUN1RZzOHACy
         0pBtKBzz015mldLCyB7AZZJX6cG70jE9xfNHK7Fi5NfaIhYdyBOK31rADISfDR8QAjvB
         ieAyY0/GCx+aaLreXp99a+CfiQaTaYCFOoPacPSuywL4spS8KlOMvXWIlBpyNLnlUv9N
         ySkWbKoLGCpq0Hh5R9IogSJr0m5b22rTRGSxH7G2F51gnlm9BwvWCiby1FXnuLVS1UHE
         LydXK8sUwGu3svNCZDY5vPcO2awLeUPW5MMJeXEXU6jmXLIQANe6EYWHHJTK1iqC+8pi
         PjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704488936; x=1705093736;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btHnhBY6Gdo30miqKJpxWq2UU4pzXJBv7Ai6upI+x7Y=;
        b=VHMYctxpwAzU+k9OnzWoaGcujZjibvMV3pMQycokxnXr4L2MZqBRoqCciSQgKIrRGu
         +NMyFYz2zXFlihHk3hM+ZVfbpwy/JzCZzc1+xkhraofkxuTQrlNH8kf4HCaHJzjierlS
         PmxH1akM9iFtY9RGGY4PJRtBoVxPvp6mET1zdNCU3h3Q/uNa7vLZyYQBdzwHO8PbkGw0
         gUYYpHbiuiRP2OhpF0YPKuZfrlp2F/FRDvzJuNfMZxN+SJE+qV2cOOH1HWuAsSO80ENm
         RnBMZRHDvj9xyRPln6ZUztHFzPfn6A1BqhJrkzlo1mghbcgRhsCQrJFL3OZ/b7AwWffO
         RnVw==
X-Gm-Message-State: AOJu0Yxxfqmu5Ie/sculV8CNCKIDM+68CEtzt7TCrWaLuy4lOJJfs6F8
	Nt1gwtZwrhqGcokWFdDaiGW8mMIbMfkaKD6zT0hlo/qA5zo=
X-Google-Smtp-Source: AGHT+IG5B5Dn8Tq13YmwLqmmfhZo8Ss0qopewkPoo6gR0RREgBk1p6pZb2kDOMxaFoxixPTm8Jg1vw==
X-Received: by 2002:a05:6358:7241:b0:175:5d72:5f71 with SMTP id i1-20020a056358724100b001755d725f71mr132885rwa.25.1704488936002;
        Fri, 05 Jan 2024 13:08:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e32-20020a631e20000000b005cda4d88933sm1826290pge.43.2024.01.05.13.08.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Message-ID: <65986fe3.630a0220.b8462.42ff@mx.google.com>
Date: Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-897-gcc9858ae2881
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 12 runs,
 3 regressions (v5.10.205-897-gcc9858ae2881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jan 2024 21:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14267

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 12 runs, 3 regressio=
ns (v5.10.205-897-gcc9858ae2881)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-897-gcc9858ae2881/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-897-gcc9858ae2881
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cc9858ae2881ce2dd7cb1eab9e7038ce843f1bfe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65985f13b65bf4f08252a403

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65985f13b65bf4f0825=
2a404
        new failure (last pass: v5.10.201-cip41-540-g3640150b3b169) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6598611a58ac499a8952a3f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/ltp=
-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/ltp=
-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6598611a58ac499a895=
2a3f6
        failing since 64 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65986c9c3dec0fa4e352a3fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65986c9c3dec0fa4e35=
2a3fd
        failing since 15 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83=
a, first fail: v5.10.201-cip41-540-g3640150b3b169) =

 =20


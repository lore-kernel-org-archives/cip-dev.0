Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFADC6379F
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 14:11:34 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.13208.1675174288954305320
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 06:11:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ASNXKozr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so4213552pjd.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/kVa0YL9de9OvbUCYZDSEi+d2D7EaPjGmIhmCyKWmhE=;
        b=ASNXKozrsfgjl1xIf91cQsTmu9H+OeIC0i5AyJkWJfP0TdY8AKSpbAhNRmQQrD6SbW
         Narbpcs0mltQxmt0bXgofO9Ssf30lTU1+1ZoKuszysLQvcVc4DvBuvts5vDPQ/wgNQIm
         OklPCqcwr2Ie/2W7HF+J/uDkvNyJ/nDOn2IddDqQvvF59saHmToTtaCi9hJeCWvWzIAJ
         HZ0qSUh0oegrqb39KkFmULqlikFT7HpX4QzFRbQINF2fVrsyN1GIV1vpdGwuj+PCLzoU
         Inh1AxEG3OM3KC2PoWbFSxzJKv+cUdErQ/3cqVh3LjSjom69lq9KpCmgTrHE0t9JReIT
         ICQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kVa0YL9de9OvbUCYZDSEi+d2D7EaPjGmIhmCyKWmhE=;
        b=c/jQP1cE3ikIpk9ozhHYR9/CehfYDBvByZqj8xxU3WEN+25dNtUILDc9lU2F/lyqpf
         chu40tP1SvRBCv7oqWA6T0BSybHP4XjmY9vmu5Hz/WpLeCEoApj22kW5oAd5mkF6L2O5
         JUppTTXq31CBKmROC3bBLaMjCE1NaeTLlpXHsNHCfGXQRnyFTivX0jn3SSOi9ha3v3oi
         dFRWljlsrNdTu8LHoZOP+Ndp1VZjznxkDPVlR1q1eX2QZ4K70ovh2LksEqWrFvkwCcEX
         GD1ZtLDhkgFEqOeHjfNx5lODiwWly7v8u6UNcSPNcN60/BgKF2u/XIprKaP3CMlPVocy
         m0ig==
X-Gm-Message-State: AO0yUKVpZgX4M6hvkoT87blCISUYho8Y0CZRAZTizxDc/jsbzluQPWSj
	00KNtPqW5VQ5HbKrae580KeWqrVnItN7EC+Q9TMZDg==
X-Google-Smtp-Source: AK7set/oazySc+R/jiFnOIxTtnhtaqMYBBfaXy5afdSxHlN/f6bJOw/8aXla7WEU8AxBYU++6WYwhg==
X-Received: by 2002:a17:902:ce82:b0:196:1d91:7b26 with SMTP id f2-20020a170902ce8200b001961d917b26mr30586494plg.43.1675174287854;
        Tue, 31 Jan 2023 06:11:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g23-20020a170902869700b00195f0f318b0sm8332266plo.91.2023.01.31.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:11:27 -0800 (PST)
Message-ID: <63d9218f.170a0220.870d2.defe@mx.google.com>
Date: Tue, 31 Jan 2023 06:11:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.165-cip25
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.165-cip25)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 14:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10542

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.165-cip25)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.165-cip25/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.165-cip25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52aae1dc6afe62fedb14c89fd4feca1d8bb13416

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d9147f4e4367b62c915f21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63d9147f4e4367b62c915f22
        failing since 384 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/63d91a8dda506e76a8915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63d91a8dda506e76a8915ebb
        failing since 384 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20


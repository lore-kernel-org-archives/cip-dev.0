Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97238CD691F
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 14:13:19 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.92724.1696947198478382751
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 07:13:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=uiJaN1QB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c894e4573bso22057375ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696947197; x=1697551997; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ezszSrSFlKayYUi8hXwXbKw5+cXO9dPJEiYaoss0Rn8=;
        b=uiJaN1QBw0amp535uKZDKfty53ospsBM8fMXs0RS7si8//VyK+bb0HJUdqu0sj7PV5
         84tb3uHjX40VkeBNyR/OkYv1j40Ue299R9FgKIwAetsl4e2GXz0EYNKlU/lVnPYLBzT0
         1iEhbn/phiI1JX1qAHZqB+fHXpaHFsFRdwW8SXCB6QQ+CM6d+Z5wdyGz3eQ1lV2C+TUb
         14cVTPRalkwoVVJHWSPH3WPcMfadYFEyEinMzCPoJJLBiNIiOP3uJQCFtxEiZGH2816P
         BR1pJHRIsOa0plaVDxylRlaBI5lSl51BR1nc5+yQ2ok977AuPvpFf2209p99MBE413zn
         lq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696947197; x=1697551997;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezszSrSFlKayYUi8hXwXbKw5+cXO9dPJEiYaoss0Rn8=;
        b=bf8nP79rrGQVIbWgtZABA2YDkx6sfZrc+2Y+ljvjGvsOcMqkUCYN/vTH3nMrlZzFM0
         XBvtBbDJ0BNLOBZOVXbpi+jFaSjBlmH7LRIhjfzMYxgSVrp+JbBcoX21kDPsvXbru99m
         EP/08INJjBfsLgLiq31Ar4duP5GB+oWPuF4+aL9jv4sWgOK1h6kFLAcyvVagNs0S7Ak8
         cwphBCduqrdHO0DDwKxmWegLgIAOl+3HPlHrrOSSkPJ0sEFustUpRljWECd7n2NLQiQw
         toOkBjB8/RyWHjRacnGGRXt8CH0BiXbpe8oCyHAl8WUemMzDpToKtyBbFryg9+B2JDR5
         1P+Q==
X-Gm-Message-State: AOJu0YzLMX1EVVrk6jPcafLFiofdn+GruOPR3CHnWupWUlUjBJorz4IJ
	CxAZdS1E0VSQxTXEGLo04PDir4NVBuTCLyfcKJqYQQ==
X-Google-Smtp-Source: AGHT+IEqkXDDe7dLKSPOuNTJR/MypLiJRX09GnWu23MOB/DmCjxl3Y+BLJeDjyUTDMykDigaryGWeg==
X-Received: by 2002:a17:902:d502:b0:1c9:b2c1:13aa with SMTP id b2-20020a170902d50200b001c9b2c113aamr1838419plg.68.1696947197371;
        Tue, 10 Oct 2023 07:13:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b001c613091aeasm11822448plf.297.2023.10.10.07.13.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:13:13 -0700 (PDT)
Message-ID: <65255bf9.170a0220.e1370.ebce@mx.google.com>
Date: Tue, 10 Oct 2023 07:13:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-557-g2932db67f070a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs,
 3 regressions (v5.10.194-557-g2932db67f070a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 14:13:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13380

cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs, 3 regressions (v5.=
10.194-557-g2932db67f070a)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-557-g2932db67f070a/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-557-g2932db67f070a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2932db67f070a3c9076db35b5abbabb867b599cd =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65254d8858bd29dc10efcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/kselftest-futex-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/kselftest-futex-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65254d8858bd29=
dc10efcf0c
        failing since 118 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65254e7cd7788d1f73efd075

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65254e7cd7788d=
1f73efd076
        failing since 6 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/652552cd0eb9ed2c3eefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-cip/kselftest-fute=
x-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-cip/kselftest-fute=
x-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/652552cd0eb9ed=
2c3eefcef4
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20


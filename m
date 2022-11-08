Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898BFC4321E
	for <webhook@archiver.kernel.org>; Tue,  8 Nov 2022 21:07:34 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web08.2666.1667941650170641369
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Nov 2022 13:07:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=CD9K7CB9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso37355pjc.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Nov 2022 13:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EKYPuvsBscj24mDftzPnevNqqx4r4EkxqlWDohfVnWU=;
        b=CD9K7CB9y9kL0bqdduU4yq2hN9C+kAKurHoMvM+UzY5cqAAs9Kv3kbgwIr8tg/pf4g
         JqQgwkJr1/+1FQ9sMAL2ACt4/hFxzTb1nZ7OdNYKzezmMCorQURcgStyZsZAM92i+YSb
         NBAYX4mreWf43ky01ae9xiELg9CleHWGVADUh58rbP+t73OPuV69iZpyf3A4ScCRFdgO
         w6rGGsuN46KCR7cIw0R5CGvE5OLEieyMZ3VBATT7GjP3JDu6wuVu6O2Kq/BveBvTnuGw
         VXUciOZ84INOBYpLEVbcU7MKO5kcTAhLRo+QILE987AMUIyQeW4uXEFAzbyz3Eh9Q3xa
         l1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKYPuvsBscj24mDftzPnevNqqx4r4EkxqlWDohfVnWU=;
        b=E4ZTTNhnGg+mVwv/1SUDj/e5OAWFW8xHmi59CcZVH5h7ixGDkR6YaVcQyf1BVw+OCi
         l8tk/Hg55KH8U/gOrFTmTlGOYubmRr/iTXw2cHbtCvjnzwDIeZWGS9xeduGQIxU65918
         qqB+gEfgf/jogs07PaE114Ht2bxvsjFZYSx6tSbHhwQODiYIs8bxZwUELWluHypwAshp
         a3KEUPD2o7g8K3xEZ2ToAJL5l1z2sXxLx23swV1gBjmQCEctB0e8UQXl+bYooV61V75M
         4eQ1VPjvDNIOV0MP7mOO+w5eppamB+eFBApOmiETZ5JZ5cZT4N45LMRW9xPpY7so6mPb
         6R1A==
X-Gm-Message-State: ACrzQf3//Wue3T5kldEt80xNqTC005xB637DkbwaXBmi7SRt4/2UbLBt
	n5OYGWOtBk1jQxCrD8yvW7VUFVpmmdpqUVbW
X-Google-Smtp-Source: AMsMyM4yvP0KqyFq/3cH7GYCwiRXK4auqucEr3UVLBnAwL6S0FdRP5oaTcmjvBod46POAoovhfdgqg==
X-Received: by 2002:a17:90a:748c:b0:213:854f:f78a with SMTP id p12-20020a17090a748c00b00213854ff78amr57601728pjk.41.1667941649493;
        Tue, 08 Nov 2022 13:07:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b29-20020aa7951d000000b0056d98e31439sm6998193pfp.140.2022.11.08.13.07.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:07:29 -0800 (PST)
Message-ID: <636ac511.a70a0220.7424c.b85a@mx.google.com>
Date: Tue, 08 Nov 2022 13:07:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-15-gef247a3cd0ad
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs,
 2 regressions (v5.10.147-cip18-15-gef247a3cd0ad)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Nov 2022 21:07:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9953

cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs, 2 regressions (v5.=
10.147-cip18-15-gef247a3cd0ad)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
                 | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-15-gef247a3cd0ad/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-15-gef247a3cd0ad
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef247a3cd0adc25a8015590a0e7652ad30c2b2f7 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/636ab975fb185842cbe7db5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig/gcc-10/lab-baylibre/kself=
test-futex-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig/gcc-10/lab-baylibre/kself=
test-futex-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/636ab975fb1858=
42cbe7db5c
        failing since 5 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636abdba61e629adcae7db53

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/636abdba61e629=
adcae7db54
        new failure (last pass: v5.10.145-518-gc75907dbbb95a) =

 =20


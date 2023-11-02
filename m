Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0143FC0018C
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 17:49:20 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.38687.1698947358075489342
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 02 Nov 2023 10:49:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=hlRM7m9q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1cc5b6d6228so9453435ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 02 Nov 2023 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698947357; x=1699552157; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z4SCVymljkJD++YkEN86SbVon/EjEdxjYM5YoK4yuf8=;
        b=hlRM7m9qFKXVIGMeOtqTd6aIC3e/mBegIKpSdq/cBG38KXoVTwkdau+KIOR9iccVjm
         2eFsuiU8WiibjU58ss8D0qfPvLmMFssTYcIpIXLG6Rh2nbcpaF9xxQffhWzS06+udSrB
         nm1NRYnX4AhC3gzjcGzkD1IPsUgroSuO6XuK/hknKOO+HEy7Kj8D2DvsijaxH0KjFP4C
         K2a/I31OEYo71fXgZK+5AGMuZXccDWiTbb29FXweBq4Cm1l474pky5uC+VJGH8iHBu4E
         c5naN/kjaFl08I25h9WwzO0V/xAzKY2j2qm6+0mnZjN558m+K9LKVJ7TMyuQZh0WUHVf
         Hd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947357; x=1699552157;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4SCVymljkJD++YkEN86SbVon/EjEdxjYM5YoK4yuf8=;
        b=R47fxNQgAthxy/8h3B89mGM0wRlwjPKTGQxHSkZ+uhAP4wdRvZL9ORkZNJI2bkQ5Ju
         80dhE4ua1OQfdE2ytx1Y+3U2inakSrR2mt0s6YjNffTP10+G7C+zo6tixST1BW8OKLXJ
         Mnq92KYvA8lc+ul1dK6KchILuFZecLoZCWYRFc6v9ock6oduWvTJc41lobdMG/ccMxLn
         ItodaCE4HSwcWQrUVg3hJRPCRM7YsfzA35rfM92ropbGGpekoa1DS2Wvt7PKLYQqHWV/
         hBJgkiQd0r7lzrRQfA2XCZI1KU2m9oJy9y56mEo7huRPtNuduR6VzrJSu1ZiL9/4EZUA
         YMZw==
X-Gm-Message-State: AOJu0YyuZ5yoeErxx1Nr9P1Ojl7bNU/+x2zcjB5Q9/8aZxwYxsFDdNKz
	QrRThv69Z2eYV2zJg3DxeCzb6lXjto4Ivv7O09UAXg==
X-Google-Smtp-Source: AGHT+IGy0icY4tWvQXRm40RAzM/EuE0eomEN3AM7e0gNvxFhIMRjG7GPyCm4w7z4q3E4VL7BhN6B9g==
X-Received: by 2002:a17:903:1053:b0:1cc:31a7:88cf with SMTP id f19-20020a170903105300b001cc31a788cfmr11640536plc.40.1698947357059;
        Thu, 02 Nov 2023 10:49:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001cc2c7a30f2sm20836plg.155.2023.11.02.10.49.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:49:15 -0700 (PDT)
Message-ID: <6543e11b.170a0220.38686.025e@mx.google.com>
Date: Thu, 02 Nov 2023 10:49:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-915-g96fa7f16cf02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 2 regressions (v5.10.194-cip39-915-g96fa7f16cf02)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 17:49:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13528

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 2 regre=
ssions (v5.10.194-cip39-915-g96fa7f16cf02)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-915-g96fa7f16cf02/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-915-g96fa7f16cf02
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      96fa7f16cf0228e65eeaeaeef1b73f242f4e169e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543ccfe6d17543a92efcf81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6543ccfe6d1754=
3a92efcf82
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6543d50a45117b2ad7efcefa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6543d50a45117b=
2ad7efcefb
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =20


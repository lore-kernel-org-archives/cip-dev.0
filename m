Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E270DC6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:57:13 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.43291.1679493432571253720
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:57:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=4wbk2vEl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id x15so8229547pjk.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679493432;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oI4FkqZfLhMPGKEnVKAg7gSJAKp2T7cHC7ExPeePJqE=;
        b=4wbk2vEltcU+VqjbdTwoE5XHNN56moVYVyZO7v9EixnXjb6w8+y3EOKO9JKJ4tSTop
         HQgrpzpCvVW2hlnNR+PxwtNvTqyl6m9zfc/lRJF6aGQsZvb8mEhrhA/7xOddKvvxttZN
         kuXrqf1eGYDUngUYQcEIUpvZbv8q6k5NbGCZD16nhR9rIbu7UKVXiDgaual1gur/omdL
         raXGu3mqfL66kLPR94OChBpIMc/6IvkOZt3EIxdpW/3/3ZRyXBgODyuQHAt8UXn0Qh3i
         uIwKd7qKR6bI/BUomMdvY0y7yXwh10BzPtqZk4XZC0nWP6g5Brd0qY1ccZlLCNvJ8ztI
         14gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493432;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oI4FkqZfLhMPGKEnVKAg7gSJAKp2T7cHC7ExPeePJqE=;
        b=2SQvW/uyj/MFBEGFcKQHMMP9HoCIIbkyNyDGPjwEUiLmKFa16nUuj8qu2RkPC91vUq
         vRCYRIXSxccSqPGAxRzQcDM8+PlZnghVxp5dPcuuS8h7VNIV7BC97OPsYz5jayX38xGI
         JX2NjMWdshkcUDXaLi4E/4Ir4lA57oIvb+9QaxjKp69ZN6keMWyT2rkpCngUmKc7RZHu
         ThlgJ+e7fqualx1r+c5AS1+FBPdxwDwMkoiem6wDOreo2uEDxtCUlBMqyblqc/wo74F6
         pHxv7V0o94PFKQmLpCD8IyCK89jw4BG4bXWEOp1ZgXngd0cOrNBQHk5mCUtzOyAwWvok
         gweA==
X-Gm-Message-State: AO0yUKWCH1arvDtlvd/sjArl+po4Cw2QQx47qBhXSrSTOtzk9NAJTZLC
	pDEInIXyQiF/x40OxZPadEkRWXyCHige4L9g1KZl0w==
X-Google-Smtp-Source: AK7set9MlRfi1YMp5maUzKFFLWgDD7rEi+/+eeXM1Rclhal7dObUYJvXfk0KdKyyRR845d39UwIfLg==
X-Received: by 2002:a17:90b:4d0d:b0:23a:87d1:9586 with SMTP id mw13-20020a17090b4d0d00b0023a87d19586mr3501445pjb.23.1679493431771;
        Wed, 22 Mar 2023 06:57:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bc11-20020a170902930b00b001a1a0db7f50sm10565112plb.90.2023.03.22.06.57.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:57:11 -0700 (PDT)
Message-ID: <641b0937.170a0220.d912e.3086@mx.google.com>
Date: Wed, 22 Mar 2023 06:57:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs,
 2 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:57:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11085

cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs, 2 regressions (v5.1=
0.175-cip29-rt12)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.175-cip29-rt12/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.175-cip29-rt12
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af9703f3a9840919c9540

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/641af9703f3a98=
40919c9541
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641aff5a72f1350adb9c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/641aff5a72f135=
0adb9c9506
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0574EB64DD
	for <webhook@archiver.kernel.org>; Sun,  9 Jul 2023 13:30:03 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.17341.1688909397961096332
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 09 Jul 2023 06:29:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Rw5WRTCf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-668711086f4so2262698b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 09 Jul 2023 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688909397; x=1691501397;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Ov+999rwULZMbr95ydv8/ZhvkhzmrYIoXaEf6Dg1M=;
        b=Rw5WRTCfqvf7MonlBQBumaZoAXAFh9FMEnl0NuM+3OVFQFvU34KXe98rnVSPQsduWM
         fYVmr/CgDtm3jpav6COSBIHy+Hz31rFDXEQNTZfKmsN7+hxCkzwS6HwNrzFoOxEBqzu7
         OHY+aXgbdkqW6yGmCRedyH8T9OUHFMUBCKWODcUIKh89ps/ZFzhP1FQrB4/4xTzHQUKx
         fMfWS1PC7e2R/AsPYCcRg03TNUoGeJM4yMMjNY5WZ5bj+jsmYWd4zTud3wkAKsjwTCP8
         S2+bBh+R50yAmARJtaRUKKDfolBTwZLStlVX76KpBuTyIwPwjdDrfPzuAGwRDzrizWom
         4fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688909397; x=1691501397;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+Ov+999rwULZMbr95ydv8/ZhvkhzmrYIoXaEf6Dg1M=;
        b=BH58rJxr3RlIN9/8andgYqmf6cerAgVOav1xNE3MnSMV9Z2QpxD2uFPlWWEojBSAQ+
         DWUYrKWGm0XezswuZlErw11RmpwHf1DydN6lv4Xr+2KHwGCIXSb8EdaPk+LzOGFZZ+xX
         e+0QzQQfPF7RjSsIE2NFMZr5uNUGIrYHM7HVjgVmaTrBW92qJjxlXpJk+gsm1AbPhzZq
         46tf2FgPL5saQjEe+kw1OIUQXhTZ9T3BwLsW4phkzKQeAY4FhLQOUqHV0I5b+hgSfqXi
         exsZ6B9TlFCAvfU0CT9RoyixvnqAM+ZCwSBIVGu66moD0P6TdZbjSRmlTpCYW9o/DdIp
         rUbw==
X-Gm-Message-State: ABy/qLay5BwgwaBtBV1W9+r8WAgCrlm3OlA8awAo/4uhs9F36kvM1LbI
	uYtrzd+srzyLVEldAGl2ZgMvLVwBSLl6RnUg2j4=
X-Google-Smtp-Source: APBJJlH9Cs3BI5wq9K6kgRwuPqxNfI9OPhgIT/1xOJAsIuMsNbQmfCFu794K1EHTZo4Kf+PZOZ+IKw==
X-Received: by 2002:a62:e10e:0:b0:67a:8ed:cec with SMTP id q14-20020a62e10e000000b0067a08ed0cecmr17765107pfh.2.1688909396758;
        Sun, 09 Jul 2023 06:29:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b0067777e960d9sm5513199pfm.155.2023.07.09.06.29.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 06:29:55 -0700 (PDT)
Message-ID: <64aab653.a70a0220.2008.acf3@mx.google.com>
Date: Sun, 09 Jul 2023 06:29:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.31-65-geef5a19d48f6
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 7 runs,
 2 regressions (v6.1.31-65-geef5a19d48f6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 09 Jul 2023 13:30:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12284

cip-gitlab/ci/pavel/linux-test ltp-timers: 7 runs, 2 regressions (v6.1.31-6=
5-geef5a19d48f6)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig                =
    | regressions
------------+--------+---------------+----------+--------------------------=
----+------------
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-chromeb=
ook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.31-65-geef5a19d48f6/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.31-65-geef5a19d48f6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      eef5a19d48f6fa603cebb6b0341962fd9acc0e3b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig                =
    | regressions
------------+--------+---------------+----------+--------------------------=
----+------------
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-chromeb=
ook | 2          =


  Details:     https://kernelci.org/test/plan/id/64aaa7433270611535bb2abd

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/ltp-timers-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/ltp-timers-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64aaa743327=
0611535bb2ac2
        new failure (last pass: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:25:18.958218  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64aaa743327=
0611535bb2ac2
        new failure (last pass: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:25:18.958218  =

   =

 =20


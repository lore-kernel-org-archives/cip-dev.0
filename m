Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6905FC46CA3
	for <webhook@archiver.kernel.org>; Sat,  2 Dec 2023 00:36:53 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web10.8682.1701477411310662398
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Dec 2023 16:36:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=f8kIHHUg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.54, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58cdc801f69so1698007eaf.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Dec 2023 16:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701477408; x=1702082208; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RWK0yNG1xTsBGApuedMYP6ypVEIJMGEch/KsGgzw3YM=;
        b=f8kIHHUgQxDeP4VvST8NN2KELPCkWjcd/yl7CSX9UtKTxh7qwEGnlZVOQ3Ik4ZLuxY
         0b7QbE5aVav9kwjIu1m2KZCVhRdnEdbK52Ob4vD0oLl+Nmn8LrhoQhqsuQ88603WhE58
         fBu4wsg7uQJpasVnEufg96zv0wvJX561Nhv4BRToueFrSGqcghPWH4O4DEzRQGx/LuON
         OwVCrmevKmT6kSCO4TG7cy11AZ3wwbc1E112r9ArCw3EbvCm6KGv81N3kTI6woVzkoUI
         E+v4GjnVKsmu4+bkmTZ0jffP0wIoaXaufmmQ6f0D1Fc/Oyf16YT0RobnviwuTGiag/NX
         fFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701477408; x=1702082208;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWK0yNG1xTsBGApuedMYP6ypVEIJMGEch/KsGgzw3YM=;
        b=YDXuTRdoyOaVTi9Vyn15wCl35mJSJ9TTM9rD6ckBCaJvtQT6OXxQLsrLSYq2Ae0QC/
         HlR4x0xH0XvmJFL27D7MY/rKkvhmzMswUi9Gx+dj77uB3a7r1cBt8thuE2e3f06/xD/i
         FffHunZSXX6GU+73L6BCgBDQCc2UYx6B1TlvbVgjURpNoVUzDWk/XE37u+lv5CIr7G8S
         dxFIhr+pb54i1dRliwiBB/9aEGZcvXaC6MpAzD86B3EPpnUdOG5SyiJQEmVl7XyKdHof
         GP2jQw8WaavfBvBprXNkYoruwgg7t+aiLt5Bq95GAcPMVM4CJ4NIkldBg6C8c3UDPh1e
         fFMQ==
X-Gm-Message-State: AOJu0YwlIfLyoSAke0eVrWSHV8cppKvbKrIbIVP4mULr8+6PJmR12/gi
	ziCElv5audIwfMGZlIRmR0osTvmkAXsWkjmhUmd1jw==
X-Google-Smtp-Source: AGHT+IEAzstBbun2d9eUoWNV9q/Puh+glgYFmK1FnyBP9RIkTuHbOTimzoQjnc6lu1afcF/Rrm44sw==
X-Received: by 2002:a05:6358:e49b:b0:16e:1e6b:96b8 with SMTP id by27-20020a056358e49b00b0016e1e6b96b8mr585172rwb.3.1701477408438;
        Fri, 01 Dec 2023 16:36:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b0028066f3c373sm5530007pjb.17.2023.12.01.16.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 16:36:47 -0800 (PST)
Message-ID: <656a7c1f.170a0220.e037.21f4@mx.google.com>
Date: Fri, 01 Dec 2023 16:36:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10
Subject: cip/linux-6.1.y-cip ltp-pty: 9 runs, 1 regressions (v6.1.64-cip10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Dec 2023 00:36:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13774

cip/linux-6.1.y-cip ltp-pty: 9 runs, 1 regressions (v6.1.64-cip10)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.64-cip10/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.64-cip10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6eab166db6d4f9b10eb2993de0fcd289a09024bd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656a72740099104868e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-pty-hp-11A-G=
6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-pty-hp-11A-G=
6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/656a72740099104868e134=
76
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =20


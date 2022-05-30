X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web12.38094.1653923213525496501
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 May 2022 08:06:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=liuPr6EQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so4867557pjo.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 May 2022 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4EGzGIFjyFmZ+y1+Daislq2ea65qr4JnRSf5D4oujWw=;
        b=liuPr6EQr0WQv/UZRvw2q7zeiyLIeznymrQQp3oVOkxXPWBR/rBU7dwXwhOp4TCnnj
         AAE7P+CdAQqYU9Iy8SCZPNPdEByxYC0k3ggpZfhOIUqQs/RMIoC8b+r6RgOoTQMlHHpX
         u7zW9xQQNXttdCfSxRyDWhtpAwBKQq0SUYGU5nBymarSDkgqwWX/R1KnWkh1iiqdcoem
         j5mnLRYkBIyqBE6Il/CCjWWtoddh9qFgtmyeO5DZQxBImTkp7MMOS96wnhTZ/Zqzw/9e
         ywpyKf8GzFpbUG0+sw9P3qy/qbA79coroUFIXdbV2BtmMdbFDccMjs8v2eFn+b9EChiI
         q3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4EGzGIFjyFmZ+y1+Daislq2ea65qr4JnRSf5D4oujWw=;
        b=GIhwN1f/MU9iA5wMqEwqzKeCwNBBUpoQqfEpUvO7rnEUIHuUrpnXgQhoE2BL2vlf6j
         7wbvDiPdxB/+sp2D2H/xMtFJBOKTcais3kid9W0BISAItbIZ168NFVds+uHR5vPic2Kh
         gD7tchtVVhNjpxciW9ypAnJmqrly/4AjRKy31jtI8wUVyUs0jRIvgpH0uAmNr+opoBDm
         qsnejvTR0/8U136vll1Pjs/Rou9hoM+7t3aHixw6i6MaZVDlGOHUyDqwD+H3J4l5EXZo
         qWy0gLwkNwMSI3cPgZtQttaPimI3fGQM6wkwRj5j0jI37fe7iTq5SNkR+kMZnhSmU3OC
         ADAg==
X-Gm-Message-State: AOAM532HoqYkqG9UGaaumpjKWaIqrbXzOUIHRxawUoBV2Meg1YitEXo1
	5Ku2H2YySOZDYjXDWT01vHc5cYb/C18s96N8tQ4=
X-Google-Smtp-Source: ABdhPJxP1VXwfLudk+Dmm2q/ven01E8Dr21VFWOrMOm7aSe8Pm/TCBEUSSrx00E4Yyom6c5Xg1243Q==
X-Received: by 2002:a17:902:cf05:b0:156:2aa:6e13 with SMTP id i5-20020a170902cf0500b0015602aa6e13mr56895582plg.137.1653923212574;
        Mon, 30 May 2022 08:06:52 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7870e000000b0050dc762812csm8912766pfo.6.2022.05.30.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 08:06:51 -0700 (PDT)
Message-ID: <6294dd8b.1c69fb81.6860.3d21@mx.google.com>
Date: Mon, 30 May 2022 08:06:51 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.245-cip74
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-mm: 5 runs, 1 regressions (v4.19.245-cip74) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip ltp-mm: 5 runs, 1 regressions (v4.19.245-cip74)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.245-cip74/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.245-cip74
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0be9d6774be9b192bcea6fddada917ae3d22f22e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  83978df41846c88a0d491b9cef3e8cecae02bef4 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6294cc2979bc285cc3a39c49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.245=
-cip74/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.245=
-cip74/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220527.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6294cc2979bc285cc3a39c4a
        failing since 135 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20


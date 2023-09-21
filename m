Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E3EE7071F
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 11:28:54 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.14102.1695295729389157969
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Sep 2023 04:28:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lngJ4Yvk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so616966b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Sep 2023 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695295728; x=1695900528; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dSkt+Xj6Vv4jdBCcEqhtdfrJiavi29eDpdzadgu5PcE=;
        b=lngJ4YvkCqNgs7PZtDrVXx+rIUonZnbBl6JMJ/qb5aA/lb7ssKs7kxS2KuCcyW+hbx
         xWI2XER9iL5sJwTdxTg6VIca8XR/X0awotBFwr6BQpnzN3p3iUW6+AeOvrw/yXCGU3mD
         /5UdZKKi5L20vOF8LMOWa6l/6+AMxqwUASGi9oipgDtSa8kEDlv+UC9jLC+oxIXa0xxi
         adCTXNzIMAhybyjrL8lECrM3qspKWyMzPr++OSI4VZknVP9hYaP4JoALWo2mhwFhJ1Dg
         xeHd0JvVh5Bn/qOg31PqBFHf7MGVDmdvoA6idBZMmUuYvXT4MXr6lXF/YuuIOzi9Hayg
         TimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695295728; x=1695900528;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSkt+Xj6Vv4jdBCcEqhtdfrJiavi29eDpdzadgu5PcE=;
        b=DxTTNtl/PQ0NAHd4g50aUpr5Fqeu9sUWuOLXXkgcSi06Mn5Xf0kFUsTE2GMH9JNaEq
         6aPFUjpYpXdSUmDtLza0b/tXiUOLrq/zFmTh2CsXCrt3qLY9e1xqlnPKWRpfHuJ4jW3X
         N4DkCE7IHkQWKtIM7lFuQ7sW0fNDOLn56Nv7JffflLx+R7bPENAbgtpHoSSMEE5XBY/v
         M3fwh+gAkXMHLm93EAcFtF2MrH1wdyplTuzmONcV6fSDlSfOfuF0DoHlAHHaJ83LeaZr
         yRlTwJxvPUN8WZdY56Ipk+bn+elQshmondlENxSZZT1NUjLfDPv8dDD2Osat1mBQ3FCP
         RKjw==
X-Gm-Message-State: AOJu0Yw2pfVom+IN6oxSR84XnIm0t0gV6OrDdBl26+3W2HNdvOGZU1+t
	Vvdv/do3mG0uZAU5cjM8FLTRO41vIq1zXpifwSbKcw==
X-Google-Smtp-Source: AGHT+IG5S7cg5U0/hpGjTMvDLx4JWvT+NXGcE0QkyaORAbg1xvYR8jW1RB54UqZuhRG6PRkX4zlKvw==
X-Received: by 2002:a05:6a00:13a2:b0:68f:ece2:ac3b with SMTP id t34-20020a056a0013a200b0068fece2ac3bmr6033125pfg.5.1695295727758;
        Thu, 21 Sep 2023 04:28:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j9-20020a62b609000000b0068890c19c49sm1133269pff.180.2023.09.21.04.28.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 04:28:45 -0700 (PDT)
Message-ID: <650c28ed.620a0220.e6564.2e9b@mx.google.com>
Date: Thu, 21 Sep 2023 04:28:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-407-g664623343843d
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs,
 3 regressions (v5.10.194-cip39-407-g664623343843d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 11:28:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13200

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs, 3 regression=
s (v5.10.194-cip39-407-g664623343843d)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_riscv64      | riscv | lab-broonie | gcc-10   | defconfig | 2          =

qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-407-g664623343843d/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-407-g664623343843d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      664623343843d7956ac33fe2f98d9903fdd5ebec

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_riscv64      | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/650c1a1be87f22730c8a0a7a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/650c1a1be87=
f22730c8a0a7f
        failing since 25 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/650c1a1be87=
f22730c8a0a7f
        failing since 25 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1cff737318a8148a0a45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/650c1cff737318a8148=
a0a46
        new failure (last pass: v5.10.191-cip38-661-g112a3073ff26) =

 =20


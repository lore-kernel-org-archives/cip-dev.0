Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B084C4828F
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 05:40:26 +0000 (UTC)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
 by mx.groups.io with SMTP id smtpd.web11.33492.1707025225202252993
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Feb 2024 21:40:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=i5KCLmyN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.170, mailfrom: bot@kernelci.org)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-363b6848f95so6457585ab.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Feb 2024 21:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707025224; x=1707630024; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lj5SPFIB6c+9UbGvJ/bQNsGZjOIJd/+tgKk6ebEhGRw=;
        b=i5KCLmyNh1M7PndobZVUrwf90ZmfWTbjHkp7GDuJ4xKOVujlhL+WCfLXaC5S4PyokX
         JMTr4Y+Pz+f4Hesw0OgrIDRLbcRaK/yWEUx+K6U4cRONCisdEZ63dRZx6Zx70iKUgeyW
         r0OIVML72e4F0p9ImGyy9PMgNnpXTr1tpGBzB3XqIk5Rg15JtojJ0wj6mjhOXOt7sQj8
         8MCuIPMnjaaeK2yU1ZynDRMhr4YTgP4DSLZIiJg5atwvP18DumRCfd7d3R72IatKgVs5
         0B7p0BcRxp/Pl0cgHYBzeLTmyO/GqZEDVITuApzKsblh5OkCOqMybnwKZw2OofmrHMfa
         HEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707025224; x=1707630024;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lj5SPFIB6c+9UbGvJ/bQNsGZjOIJd/+tgKk6ebEhGRw=;
        b=mwUhiCtuU1rCX9yK9Y6ZDiGQJGD3PBnDnSfxvlhRWSMbxbEHbFA8mr02C6bQgirNHc
         wyJeoaen0mfX88OiqlRuocqctNQPHfhYNm25+j1e3VsqB8PaEkR3NnrFS3XEV+jAUwir
         y2Iym6mlKB/si5DUAG+/UAc1aMyaeGW4CCWqFuZ4vkRUTTzUOR2VAonsoSY8aLgjNgth
         29gVPD9sK3hnTMBK9sQb+cTEgleD3jTmd/MUWPzkY2fmNyDbw0He+m/hln/KAlHaL1QB
         YLEX/BqFmcYVvIvHmVJbcAYLb+ZsjCO7JPN9z4CXx74Po4VHDmugXC87JOSwX0EDzCYE
         f+Aw==
X-Gm-Message-State: AOJu0YzHcvv254B+d6aVPYeZBH79oV8Trb9LW2U7RX4RWxeAWe9zlcar
	OFkoMXzmJSzNfTyna8zYzINKG3H2PD2pH430Xq3B/wVd9NNVQEOC9zUBuf9JDI86VUzFbU8Uj8M
	emus=
X-Google-Smtp-Source: AGHT+IF6FwF9A5nTA008FIH1uEjO8GTYWxKNa28PLIAI7phyNT5p6x6gBWQrJ3kCdwYRJLKMNK/2Gg==
X-Received: by 2002:a05:6e02:1c44:b0:363:ba45:c581 with SMTP id d4-20020a056e021c4400b00363ba45c581mr6196496ilg.15.1707025223869;
        Sat, 03 Feb 2024 21:40:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001d7222d8caasm4040589plc.50.2024.02.03.21.40.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:40:23 -0800 (PST)
Message-ID: <65bf2347.170a0220.9e837.e6e4@mx.google.com>
Date: Sat, 03 Feb 2024 21:40:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-132-g6e54756fbd6c2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs,
 2 regressions (v6.1.75-cip14-132-g6e54756fbd6c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 05:40:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14647

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs, 2 regression=
s (v6.1.75-cip14-132-g6e54756fbd6c2)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig =
| 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-132-g6e54756fbd6c2/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-132-g6e54756fbd6c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6e54756fbd6c2a85eb65a7be04700955d2e49b68 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65bf17020c1b3784d400b9d2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v7_defconfig/gcc-10/lab-cip/kse=
lftest-filesystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v7_defconfig/gcc-10/lab-cip/kse=
lftest-filesystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65bf1702=
0c1b3784d400b9d3
        new failure (last pass: v6.1.72-cip13-30-g79e2886a5da69) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65bf135062977733c900a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/kselftest-=
filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/kselftest-=
filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65bf1350=
62977733c900a03a
        failing since 3 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20


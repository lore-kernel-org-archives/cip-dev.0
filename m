Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E36C05027
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 02:26:17 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.93706.1674786367416680820
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Jan 2023 18:26:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bMJaNrQ0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id o13so3295539pjg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Jan 2023 18:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QcGqVNWoW9Frxrp9w3A8cEhRd4e5qAYeRWeao703jRw=;
        b=bMJaNrQ0jRNUPp9dH/DWFuGvInpon4ULUifzjJZtC0oKacPiThK1WEwpYCir54MWVb
         2fxU46exPJzy7FnclUaBmTK6J+q6Bt+NDf6VjmXeuufB1C3vHEU/UOxlE912m5wkl8pp
         G1TMhE4fZYgQyMANiXBBS7zl5XUlEqyVJ7TDEMvABnA3kMqL1Wzba2PwMjXiskUKn/Nt
         xfJT6fI0nSK+EKXYonU4Q3SA8cxVOVc9BFZxHRNKOuco9PRCNm6hNremMKUk/XibPOXg
         k4AEDwE8nAdMA9+T5paKPj47bYQQpUb2TYEbpz5J8LbpEAp2PcGNh4m0TZg43UqFbb6N
         7qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcGqVNWoW9Frxrp9w3A8cEhRd4e5qAYeRWeao703jRw=;
        b=TU7b9abc8lVnw1TitNcfSBCecWAqTiPl2aiT/pmCQTNkEMvQt2SyPrysGHZdqGJ/U2
         YUkLDXueHgmfbkkZfwmOvpWPVKyYBOLCUiXRiV+6wWGWck6GebsFkfoB0ujTDNecE2eQ
         b/7z9ZPlMeIjESylBkUtdOuUYsm82jtzsAAAQgph93EuUDg5D23LbFCzQ+L93aJjyms1
         Pdayf01WVv4b9eZ9YWgwiZaq/p7tAtgcJNG3NCELuvKcpigRPcIKHn0+xl/yV7BI0Rii
         t60az0g+dwTMecd7UR32lVURi18qIrazSlYDyJovD1x7FSOu59rnmu/TIVZ0k7vlI50E
         mvDg==
X-Gm-Message-State: AO0yUKUqIiMdGkMNd7fibPsloYKMM1ZV1b4ZIn80snO5yq45Ty0I/Dag
	N6M9jG6yXSv6AmutAm+WS1423dqAoL2PoLonimenYQ==
X-Google-Smtp-Source: AK7set/EVlMfnFm5WlCFGFlQ9j5QOZuMHAYEllS2zjfEi2xz0qHPAszx4AhW7wBlSWu1/vqPVeqq2g==
X-Received: by 2002:a17:902:d490:b0:196:fdc:4b20 with SMTP id c16-20020a170902d49000b001960fdc4b20mr15186934plg.52.1674786366663;
        Thu, 26 Jan 2023 18:26:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b001929dff50a9sm1659686plb.87.2023.01.26.18.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:26:06 -0800 (PST)
Message-ID: <63d3363e.170a0220.775e.2f21@mx.google.com>
Date: Thu, 26 Jan 2023 18:26:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.162-cip24-rt10
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-mm: 8 runs,
 4 regressions (v5.10.162-cip24-rt10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 02:26:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10494

cip/linux-5.10.y-cip-rt ltp-mm: 8 runs, 4 regressions (v5.10.162-cip24-rt10)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.162-cip24-rt10/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.162-cip24-rt10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      55fa0afa2bb00f24b1721b532102d34eb18be47e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  d042c168dd037bb0128b86ee4ac4f5c526eddc7b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32ee15f7a92e5ec915ebe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63d32ee15f7a92e5ec915ebf
        new failure (last pass: v5.10.158-cip22-rt9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32a839cff29b6f3915ed7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63d32a839cff29b6f3915ed8
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32abc068510f607915ed5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63d32abc068510f607915ed6
        failing since 46 days (last pass: v5.10.153-cip19-rt8, first fail: =
v5.10.158-cip22-rt9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32802494adc2fa7915ec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63d32802494adc2fa7915ec8
        new failure (last pass: v5.10.158-cip22-rt9) =

 =20


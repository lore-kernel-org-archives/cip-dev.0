X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web08.33354.1649066565712369813
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Apr 2022 03:02:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=o3ToeTRF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id n9so3021769plc.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 04 Apr 2022 03:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ESwNdr/w4VfBoK4uSJtFxxthbjURQe3dedoeYtj4kpY=;
        b=o3ToeTRFPi6tV+UBn5XRcNsHQCRCknoIMetaHw4QxPuhUdK/M3e0j5gO4VZF8i1Mav
         rpTJbHVlLsZlJhNnZUyIGSAD1ZBcg+g/a2shyaY4fNdNVkmxSOZzG/luJfR8+vmtMnoW
         mL9lQuOLhCI5/QO9F7/ahKCNVmICCeYeVxGPV/a55sQTox4eqpBnEXxzQrfmZZziYYqo
         XDBWGRO0vwg+t0SIsnHNxHBvonLlHsw0YbAHO0SUCs5iN5hFUvexPQWEuc5k+8c8SLI3
         O9BT+SrkxbGJfi5yMmN6uMIb/egnhEnkZud2dJmfQL4ehLJn6T4czRcXaq8i3GP3O58v
         fZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ESwNdr/w4VfBoK4uSJtFxxthbjURQe3dedoeYtj4kpY=;
        b=NLK4Kw9Ykn5SbERE8sWYkLCUiF+PRzxfb4QO5rT8+Tsr+sFkA+Xb/DLtBKqgzMcpr2
         dPpeV09ZVUzmaLkOE0fBmiXQddFz/8u38x/Ms3mdsz3Nqc4ziT5KaKOq6dQi+kIj1hcn
         A+GPgofyEreqMeEBZLWgDc8f/pYfgE4PCy7YmO9wip8fqHLXpBZyZMMn2MjpO94L0XQl
         FWTL7ceIiUovRkuw8Z+LS9z4aZqxPSvk3e5snOzC8rC6b/BdmDCYwRIBzxsSBImE3Spi
         epO0BgzEddHheHXH6agfLnfRo3PoGIGP9Zu7KZhgwXzDbCFNZjnlSt7xCwnwQktvAsGi
         QNkw==
X-Gm-Message-State: AOAM532CDlVZ12qp60F18nDI681YNtdajE01OpNQH5slewBnd0xJWiJG
	GpItpZ6A9+rVJzNmBTYps86ON9aBOdxXSnJo3Aw=
X-Google-Smtp-Source: ABdhPJw8xSEtFgRTV2oTwkzm2OYJ6zKUgswSt184wzEZBAT5R9xS/5X2Mh/yXrLenOuFcjiexdyqrQ==
X-Received: by 2002:a17:903:40c7:b0:156:8b56:5fa1 with SMTP id t7-20020a17090340c700b001568b565fa1mr8121584pld.108.1649066564888;
        Mon, 04 Apr 2022 03:02:44 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm11637092pfv.123.2022.04.04.03.02.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 03:02:44 -0700 (PDT)
Message-ID: <624ac244.1c69fb81.2e9b7.db4d@mx.google.com>
Date: Mon, 04 Apr 2022 03:02:44 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-1479-ga84d0db6dfc6
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 4 regressions (v4.4-st5-1479-ga84d0db6dfc6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 4 regressions (v4.4-st5-=
1479-ga84d0db6dfc6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-1479-ga84d0db6dfc6/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-1479-ga84d0db6dfc6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a84d0db6dfc604c5de8b5446ea27ac9a039ae378

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62444c934179fdedc7ae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62444c944179fdedc7a=
e067d
        failing since 13 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62444e161422445cd4ae06ac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62444e161422445cd4a=
e06ad
        failing since 15 days (last pass: v5.10.100-cip2-319-g7182f5032311,=
 first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62449b16cb4e584977ae0695

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62449b16cb4e584977a=
e0696
        failing since 14 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62445044dccbf70f43ae0697

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62445044dccbf70f43a=
e0698
        failing since 13 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =20


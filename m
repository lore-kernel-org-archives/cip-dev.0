Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97C1C77B72
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 14:53:38 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.10207.1682002409959275137
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 07:53:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=uliil0Vn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso962154b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682002409; x=1684594409;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=THgmJCZuybYBm1yMw5Vg47H4FlboL5UQ0WHYT+Gc3Qw=;
        b=uliil0VnMjY6Yd7xuj3O2fTLbpwVXnp0zIre9FDKTGmQ4+O50lKqREl3tTokc3J+8b
         DYYQd6VRlUf0YkAPoI/yDeaLnvlzJt89heYr6LATbftijWP3EtUgiAxI1dmiHN6AdIfw
         kCykC3izYFz6dqufcck62tWxeXoJJ8ZUOS/RPwE88Lew99Cid6JAw6tr+sXMpaiv47rj
         RPqvTEJdW69SaLnJP1tzAOen4xurrI3+TEgR6sJQR/uJmZqr0ZcIVcffJZ4AJTAWkO0D
         ykJLRb9VDQz/G2BbcdK8PLsI75hArG8RA1dgPWaQHCaiDqUdmF+eTEZzFXnRveRzzGQc
         WWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002409; x=1684594409;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THgmJCZuybYBm1yMw5Vg47H4FlboL5UQ0WHYT+Gc3Qw=;
        b=eKok4zJZV/ECvFlvnKTHKvYmY+rXjyVhOtjG+zG1JTkWE2+LJ+TiOCqKDO9bbrc9w0
         qHFKa+MpcUIGJY9Gvfe7GiJDbR5sMIxPYysohk9Fb5Tvxs+TT9XU2Qg7oLpvU8t5shr3
         jy3a6k1g9IISbdHVPkxYJUTQc9+Xn5AsWdPXZ4tJ5LUSwav4DABvbvH1jBZdQcYxVYxD
         ahlvxiSAJfF5SyDnZFiJ7P+dTo0ZME4MwsBIvIEkt0Wa6Yx9/m5MwGzA2K8Rkoz2cXnZ
         y/n+aeRuSUXRXCeqEq2AabMRdn/fSbO/cxFLuPpRQCd4G+8eNlBz1lO9HkuiUvw6mCZz
         ST+g==
X-Gm-Message-State: AAQBX9fIl3OVTfyX4m9pX9wxSWXocn/K/dWcMzIK5Ybx4h4DdyYg9I3n
	XC/72WAzGtHynaenByoYZP4X6wTodxBPqvqpzp1NpaR4
X-Google-Smtp-Source: AKy350aWzLyDiHGFJecR20+hpB7/BlLICLZIkSo63wFXrssRsRDQ7VF+oignHPxkfQvlamfFuEaxfA==
X-Received: by 2002:a17:902:e892:b0:1a2:8c7e:f310 with SMTP id w18-20020a170902e89200b001a28c7ef310mr2219653plg.35.1682002408634;
        Thu, 20 Apr 2023 07:53:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b0019cb6222691sm1277024plo.133.2023.04.20.07.53.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:53:28 -0700 (PDT)
Message-ID: <644151e8.170a0220.91f39.25bc@mx.google.com>
Date: Thu, 20 Apr 2023 07:53:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip96-59-g4b02e7efb967d
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 8 runs,
 8 regressions (v4.19.280-cip96-59-g4b02e7efb967d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 14:53:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11244

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 8 runs, 8 regression=
s (v4.19.280-cip96-59-g4b02e7efb967d)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.280-cip96-59-g4b02e7efb967d/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.280-cip96-59-g4b02e7efb967d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4b02e7efb967d05ce70d86cf0c7bdfaba7678818

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/644146eeab504cbf842e860a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/644146eeab5=
04cbf842e860f
        failing since 167 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/644146eeab5=
04cbf842e860f
        failing since 167 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6441486194fb9e11bd2e85ed

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6441486194f=
b9e11bd2e85f2
        failing since 167 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6441486194f=
b9e11bd2e85f2
        failing since 167 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/644147ad0055888bff2e864c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/644147ad005=
5888bff2e8651
        failing since 167 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/644147ad005=
5888bff2e8651
        failing since 167 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/6441460f850fcbcd4e2e85f0

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6441460f850=
fcbcd4e2e85fb
        failing since 15 days (last pass: v4.19.276-cip93-5-g2eb2a953ab59, =
first fail: v4.19.279-cip95-86-g16c082d0be46) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6441460f850=
fcbcd4e2e85fb
        failing since 15 days (last pass: v4.19.276-cip93-5-g2eb2a953ab59, =
first fail: v4.19.279-cip95-86-g16c082d0be46) =

 =20


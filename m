Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B40C4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:37:57 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web10.299.1668033471792548473
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:37:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=5ZMkk3zn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id q1so17416796pgl.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CfNKoGYOmG35PF0eu0qyRbcViiXxaMwFHAnunldsQg8=;
        b=5ZMkk3znY9/9hSrEKEoWX1jAoEzAuXnUBgeovp/3RJc1EPJtVTYAx/pYWlBm7lw77X
         TZpUEn60hMc6ZJZlsCT/dIdB+osTpCWci44qQk47y514RBxO75q2DNe4YpgV3KOrv9f8
         VSrCWtebGqWu2+3HOZVtJRnRMxh79fC0uLQAkmjTyDWv7ra9zK6vv4mH6MTZ2iSXCggs
         ojr04CDbaGs3Ok5/bKRHknla9Rn5lxkFNhsQh8++MLrbIoQp91qaigQJBeVo1WbRB7tP
         uE0isze12n/YA+MhkPMiSJxBUAm0nORi0vUZHrNCZqfjSI8Zuya1v8p0QaLH8g7GvNRJ
         YdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfNKoGYOmG35PF0eu0qyRbcViiXxaMwFHAnunldsQg8=;
        b=REokCkuthhXyVsVpKn6cTvOANIXQTKVZVo1Q13W3Jn8LLcc7G41+AmHdVZW/6q3VaJ
         Dk26Sbzda+TAxdMUzI0jPcQhx166XK+aAQADMUyWLKEgFN76ITOKQ04reXUx2v6fAuj3
         iPiRQn3rilY5oosHTtWO6985jtZx7x3eY7qL+cqSF4YZOUBzRkw4Trng8CglA/30S7M/
         Nlt6aIh1XyaVlRvGCHYqJ4YbWbmzHX0KOBA5ttGkc6UrBQP7eOwifyYmAJ7WdpxrVoz7
         mkES2ETbkB+3NrMxsSDjvBAOHz3mbHByxnhNubrA8iUbzhQ8vh/nt4V+q26wBa/NvRgC
         qc1A==
X-Gm-Message-State: ACrzQf36+AjBE0l00aEuYErqkPqqjGHTUUnr6Uo3MamCzzhexkLSjxvU
	7IJctltI1bieiZsDEHdQoy3vJpTdV+gZmSujg8Y=
X-Google-Smtp-Source: AMsMyM7D/LtFzdwzh+IVeEXxVM2tua2E4qYKwVbBOvMsX/jSEoeFx3CzNjwOt0G4/7LIOMp+s4TbwQ==
X-Received: by 2002:a63:e153:0:b0:439:2fa3:74d1 with SMTP id h19-20020a63e153000000b004392fa374d1mr53017775pgk.85.1668033470845;
        Wed, 09 Nov 2022 14:37:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902a40100b00177f4ef7970sm9634496plq.11.2022.11.09.14.37.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:37:50 -0800 (PST)
Message-ID: <636c2bbe.170a0220.56a13.0f59@mx.google.com>
Date: Wed, 09 Nov 2022 14:37:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-rt74-1329-ga59fc50f38f6
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 10 regressions (v5.10.145-rt74-1329-ga59fc50f38f6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:37:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9984

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 10 regressions (v5.10.14=
5-rt74-1329-ga59fc50f38f6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-rt74-1329-ga59fc50f38f6/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-rt74-1329-ga59fc50f38f6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a59fc50f38f6208d7d36629eb501bf5191bde812

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636c1e658b25287ba5e7db53

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c1e658b2=
5287ba5e7db58
        failing since 6 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c1e658b2=
5287ba5e7db58
        failing since 6 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636c1da145bc3c1e04e7dbaf

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c1da145b=
c3c1e04e7dbb4
        failing since 6 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c1da145b=
c3c1e04e7dbb4
        failing since 6 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636c1ef10a92c21886e7db64

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c1ef10a9=
2c21886e7db69
        failing since 6 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c1ef10a9=
2c21886e7db69
        failing since 6 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636c1d5a6aa3d62888e7db4e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c1d5a6aa=
3d62888e7db53
        failing since 6 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c1d5a6aa=
3d62888e7db53
        failing since 6 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b,=
 first fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/636c23c821a3fe165ae7db6b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c23c821a=
3fe165ae7db70
        failing since 1 day (last pass: v5.10.147-cip18-11-ge6d27ea102c3b, =
first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c23c821a=
3fe165ae7db70
        failing since 1 day (last pass: v5.10.147-cip18-11-ge6d27ea102c3b, =
first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20


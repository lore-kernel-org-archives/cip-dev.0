Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0D3C6FD1C
	for <webhook@archiver.kernel.org>; Sun, 12 Mar 2023 08:20:11 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.62829.1678609205454946674
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Mar 2023 00:20:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=SpXt8KOn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so14086351pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Mar 2023 00:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678609205;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oREf9vjISHLKjycklzv+7MO+ZE+HZYWEJwv4x7jOpAo=;
        b=SpXt8KOnFOpet4sJjT06lDB8KZ1rZ8c000surh3kEExc2L9adCog374D8FD6kAfHap
         9ymQtENaoe8Xn2n5icCErDnMFO+gEW49LScmAAx52ODh5BBcHPMHYJMpP+UhAopZ63CU
         eMtSh5SQcYR+m7pzwbzviYhjo8Y/BziaXnwee7pBdbj2ClN31kDOCs7cqY/9TXVwLl5q
         HPenFb0s+uAHqdXYtg5oEal50e3KpPu+UiLhA7iYSTZrf09JTKDEG1x28IneQNXDHP9/
         jKkJXbjG5iXD7ttxJAyEhK9oseBYTjhXPU1AOl6Hnoy1uFNmvONlwbsaXUuZnfqP3gUh
         kopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678609205;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oREf9vjISHLKjycklzv+7MO+ZE+HZYWEJwv4x7jOpAo=;
        b=oTPj+EaJ8MULunZS+VUde5Ak8j/1zDXaQ84r/HD5Hqh2e6/MNmwH+k4/osPUANIju9
         sX9lF3nB1z6n76HVnOL2ndV4jQ7xUqNTtUCrl6RWZJsxkbMn/7JdwbYFoIOFBXpzhllU
         R1+7ap6VoRZGxJ5rSoIUOOBhhpuiUyegreeSuyrQVMqzg40Iwwdbbpf+EgsjVMS528nL
         oZhMGJgp7g2jWkGgqACYaEHlIWeJoHqx7ILEr6tUtUG8q0gOHfMLHBnvNTH2kOXeizf/
         PGSJi9Kp22nig8iKzvC9nFqJU6B47NswKlSDv3W4HxW2/UfTeZvckN6ThloZoQ8GX7r+
         duyQ==
X-Gm-Message-State: AO0yUKVwKlMck8YtLqUp6lm2OwhXOwKvJ4CyCOl+Yb/OguyJXwPepU4I
	GZ1TQWAod3OWTZP6U7mYpwHFANr+vFbks70oOyg=
X-Google-Smtp-Source: AK7set/uy6AzaS3mzBG8TSXGXRDeDGBzju54SSpDMhNjJomOzz5KBgr82TA1dpOtNRaS5RRRNtE7uA==
X-Received: by 2002:a17:90a:19d3:b0:233:b849:7e8f with SMTP id 19-20020a17090a19d300b00233b8497e8fmr33539868pjj.47.1678609204617;
        Sun, 12 Mar 2023 00:20:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c12-20020a170903234c00b0019e5fc21663sm2479238plh.218.2023.03.12.00.20.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 00:20:04 -0800 (PST)
Message-ID: <640d8b34.170a0220.13175.4c06@mx.google.com>
Date: Sun, 12 Mar 2023 00:20:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.273-cip92-277-g507c8d80b9e20
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 11 runs,
 8 regressions (v4.19.273-cip92-277-g507c8d80b9e20)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Mar 2023 08:20:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10985

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 11 runs, 8 regressio=
ns (v4.19.273-cip92-277-g507c8d80b9e20)

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

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.273-cip92-277-g507c8d80b9e20/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.273-cip92-277-g507c8d80b9e20
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      507c8d80b9e20db87bb0fbf5ce478b7f2c81093a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3cbaaddf6f785d91aeb370beb75d0623f8c48624 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640d7f2212213c0c688c862f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d7f22122=
13c0c688c8634
        failing since 128 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d7f22122=
13c0c688c8634
        failing since 128 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640d7fe47ec36a1b978c862f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d7fe47ec=
36a1b978c8634
        failing since 128 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d7fe47ec=
36a1b978c8634
        failing since 128 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640d8083ae2c1967378c8635

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8083ae2=
c1967378c863a
        failing since 128 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8083ae2=
c1967378c863a
        failing since 128 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/640d810d28f5d91ce58c8638

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d810d28f=
5d91ce58c863d
        failing since 8 days (last pass: v4.19.273-cip92-14-ga8d1f73f2a28, =
first fail: v4.19.273-cip92-24-g2070ce514972) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d810d28f=
5d91ce58c863d
        failing since 8 days (last pass: v4.19.273-cip92-14-ga8d1f73f2a28, =
first fail: v4.19.273-cip92-24-g2070ce514972) =

 =20


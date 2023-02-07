Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F778C64EC7
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 08:16:00 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.78719.1675757758288289807
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 07 Feb 2023 00:15:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ZRt/ZzqM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id w5so4836675plg.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 07 Feb 2023 00:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XalMDNMTZi3umqOS44nIfhnwEo8lFx0wp3S73dMRsJU=;
        b=ZRt/ZzqMlb6lOpTD6McFbpFY1ra7bwbRwZF0YUp54DrCBESiOUqCjSBzmpx8pxz6Ex
         IfnzijryPS/cLlfuNocN6wY0bgv/ZmFaPhCgkncXoZn0KooZaEdZRw7d7OZX4nBXLqkQ
         PJjIx+KeQAOY0iKUxXywH4tBLDTCaCOdDo/wE1U2YZdcsK7Dy51/86ox2ditkvHY02jX
         2Sn4qz17dY9P09lkMEiApCsqOK88FzGWB3JcQMvh9anlWHMA0RtF/Df8cM56VXFdqEkj
         0mQIqaA1oSNdLV2AFqlhWrrme20AftCG/IYVVWAdcie+YCTTQDBu7djSHA3YxK5EpiWI
         qnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XalMDNMTZi3umqOS44nIfhnwEo8lFx0wp3S73dMRsJU=;
        b=thrBRMzOXgbii888TPP4mMeqotGxA7S7J5lSqVHi+yh36XNX+DgnVq297szzqc5/FU
         1ZcMm1o7pjGWOL3YbveZF+//yX78uAuyZBCivS/r/pCb/oxKqGTmzjx6ilaBD2WdAzpa
         oiJmXIzz5LfR5eTRwQnBWOqb2qB27JARq1ryujcaPTXURkYPWQ4cO5iMRrTV+S5qEnTL
         uhHmPShIm5ZAq/XKiFfM6aRXnHfOyYx0qQvOd7Qe9gaKGnf9EdkKoC71ZXIsA+Wtl79r
         72SJFHaH8W8sOLue0xK4ChZEGP0ltFMnsVkj44WPJcdkbwDwaM9IkU3wsroa/jNl+wTk
         dQ5Q==
X-Gm-Message-State: AO0yUKVS0jmKruREusGeOrsmpXsApdnh7ax4N1x67msjT+785ZvhDrzw
	jit1yxjYLrTSrUcm97g6Rny+Wh8+rYP2lqxu9Npk9g==
X-Google-Smtp-Source: AK7set93V+xhOf9gIDgq3TM/CGTQZFxUeEVq7hGpA9kd0YuMZ4qqJb/NykuamQAHFaz7HgRMy/npHg==
X-Received: by 2002:a05:6a20:e412:b0:be:96d4:83af with SMTP id nh18-20020a056a20e41200b000be96d483afmr1902993pzb.50.1675757757546;
        Tue, 07 Feb 2023 00:15:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x7-20020a056a000bc700b0059416691b64sm8793519pfu.19.2023.02.07.00.15.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:15:56 -0800 (PST)
Message-ID: <63e208bc.050a0220.f7c53.edff@mx.google.com>
Date: Tue, 07 Feb 2023 00:15:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4.302-cip72-rt42
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 5 runs,
 4 regressions (v4.4.302-cip72-rt42)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 08:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10623

cip-gitlab/ci/pavel/linux-test ltp-timers: 5 runs, 4 regressions (v4.4.302-=
cip72-rt42)

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
nux-test/kernel/v4.4.302-cip72-rt42/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-rt42
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fe1cf8ef6e9d76107c4a6e1bf8cc27263abe6698

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  7b5ee038995273bcb614321dd1112311e3b7e8eb =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f9a8e4ee2e009c8c8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63e1f9a8e4ee2e009c8=
c8636
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fbdc1bb72b94c58c8651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63e1fbdc1bb72b94c58=
c8652
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fd03a26f86f2468c865d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63e1fd03a26f86f2468=
c865e
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e200eb6727c0dca48c8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63e200eb6727c0dca48=
c8639
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =20


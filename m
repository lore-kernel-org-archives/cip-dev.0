Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD748C3F6B0
	for <webhook@archiver.kernel.org>; Thu, 28 Jul 2022 10:40:26 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web08.31116.1659004823522310453
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=WiJ8vn7r;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id p8so1429327plq.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0jCn8fBj57L9twdXX4h/zPEwxQTjCVhPFs7qnx2/9PE=;
        b=WiJ8vn7rRfO6WfKb1sOK/oPMjuI98QRSSitdYzs/s0wZgZYcsBC+o0EqQEmSmN2Gie
         wu9z2mZrsSUzgQqLrWsm8ttTtNDD4ujD+SaVK8+Hpl75HYnhtfE3upt8bjBD+cqvnNDE
         0KOl91ZED433MWZBDeTl8IQlLlFsVnJ6CtWGKpBJe25rcYbtJrWAhEhdrI7X4k/3/aVd
         4iboN8n6GpuRt/Ckmvwqa2zikP2DxprMSwsUd3e2MrSWPy/20Ohmqhw52sdjIfdxtUal
         ojzlp+PDPxIouN+RvsjmSpogeFEoRVKS687BjwH8VueaziwqrcJzdfZJoDfUKWAMY60n
         GqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0jCn8fBj57L9twdXX4h/zPEwxQTjCVhPFs7qnx2/9PE=;
        b=z6/IgIzRF9W8/+YFvfNOLjvjvNaNN/vIf5ATsT9K4Aj7kOGx2xawrpzxKnHM5olZJG
         aQdP8IvL/JsQwa2R1g2SnZ5W71AAo0QWJEQO2zrN7xMv1ZHZIM7+9+WsC6VlrZ1XtgxN
         mpMYUwinZfZxgJtrRqgqZ4l/VDrb7wtxUwJ0vmW7FQ/b8qtNkBL6Az7FN+AFWaRxU7CJ
         0ooa3VtoDdNBWaB5t1l3kWpo19+hiP2JNRXZuy3HLFBUPa+QVqUbl8/KeaWT5q8sjJUT
         FEN5EjU3QnBGSGX9ps+86hKcTEuVnsysSK4yX20nGCkB0hrPP481XPGlu2YWEvsLz8E7
         Q7lw==
X-Gm-Message-State: AJIora8tTqOlSQogsvXj2Af0SWF3jR4dU+0byy1Zo4of0H4qWZOu1+iF
	60VXtcV44BGTE0rlyAwqKRr8zfWhq3w3RIFBUqo=
X-Google-Smtp-Source: 
 AGRyM1vwxGGCMt2wfB1yw32Eo5QheO9eGR9AyVZcifKDAY01B19DiWcWq/WuPkg4JuSWWmnnDqG/vA==
X-Received: by 2002:a17:90b:278c:b0:1f2:ec37:52ee with SMTP id
 pw12-20020a17090b278c00b001f2ec3752eemr9634676pjb.236.1659004822780;
        Thu, 28 Jul 2022 03:40:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 r17-20020aa79ed1000000b00528c26c84a3sm395183pfq.64.2022.07.28.03.40.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 03:40:22 -0700 (PDT)
Message-ID: <62e26796.a70a0220.e600e.07a1@mx.google.com>
Date: Thu, 28 Jul 2022 03:40:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-585-gc99f2b257bde
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs,
 4 regressions (v4.4-st5-585-gc99f2b257bde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Jul 2022 10:40:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8969

cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs, 4 regressions (v4.4-st5-=
585-gc99f2b257bde)

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

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-585-gc99f2b257bde/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-585-gc99f2b257bde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b0d9d351fa0553daf068

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62e0b0d9d351fa0553d=
af069
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b325eabb58f740daf073

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62e0b325eabb58f740d=
af074
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b14c0fd9fd6aa7daf066

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62e0b14c0fd9fd6aa7d=
af067
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0d6cb3e2170e6f5daf06a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-collabora/ltp=
-timers-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-collabora/ltp=
-timers-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/armhf/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62e0d6cb3e2170e6f5d=
af06b
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =20


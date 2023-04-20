Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4B2C7EE20
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 15:30:19 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.11376.1682004617002145320
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 08:30:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=tUsuYNG/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1a9253d4551so10932025ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682004616; x=1684596616;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DUo9bljzX7B1VYEhIbhljcVqIhpRClXgEsS+GqrN7zE=;
        b=tUsuYNG/C3PPpCXRJzCLv5AqlJ14oHAzUCeG0spSRG1rifUCxdxN8F2wogh1wiydJE
         6lU65V+Xfc+YAPhfRBxDTzJhMG33TI2qIkxbUS1H+ghigS96CjUpLhOapDR2nn0gDUXz
         xHEebH3Xc/gM+DrveARWMqSt7aYLkrAhFc8SeZ8crhZQ/uxA4WGwFQk8EU3zsfD7xQyS
         M4RR4ykPnyUrrIlZY7pkay4MNC7OQtC+OoRKWUrarUZAXzViFnl6hzXsT8ReBrxnXk9j
         T1rNSJwD3PZORng2XwTqcB6JME4BwjD2IYcUU2vlOLbvyP+AdqjsNeD4kASRIgcFHk5A
         3CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004616; x=1684596616;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUo9bljzX7B1VYEhIbhljcVqIhpRClXgEsS+GqrN7zE=;
        b=aQiedCFdsFZ+XQA/imOKklJR7WK8YE0DX2tRi/HvJBLT6vzOWI+2qCXRBuCpE1RyUt
         +1t9fzs1Q8h0z/hgDAB53W6gT/pcf2iue/Y27ElqKifihp5LyzxDMjZduOZ3V/Y8kgU2
         TzD9VBrupSBXq4BfXeH+VvcyxMhY+Fq/VIlCQWdp6R6T2ukaOHRcH1jkC550OYujrfaK
         +zh4iC5qa9rHfEQWGf/Luhl7cIe957K5Ni7rGQt+5ILFY888W22dM/92BwH8ZDvFQNqk
         ZM+Y67IHp6vXzjFC05eSgFItrvIZ/YIVRWJao8rwmGuQ/Pr7T3oacRCrIGN7OGULr6DT
         8GAA==
X-Gm-Message-State: AAQBX9ejSgSlQgj3McsiNklOMFRT7IX6ZIvNpAratdCHlm7HnjWuVRZV
	hxNQY45oue7FNCQoxBmkdrMJwRf21AzbNXHi/nWMI6hJ
X-Google-Smtp-Source: AKy350bBtMm7TaiAq89fjvDGGATqNCb53AxNsXl1yq3qK/8djep3OkPKaSoEYvJ/CfL6VYYdTjyo2Q==
X-Received: by 2002:a17:902:c40d:b0:1a9:2823:dac2 with SMTP id k13-20020a170902c40d00b001a92823dac2mr2810999plk.57.1682004616302;
        Thu, 20 Apr 2023 08:30:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ji9-20020a170903324900b001a1d4a985eesm1296666plb.228.2023.04.20.08.30.15
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:30:15 -0700 (PDT)
Message-ID: <64415a87.170a0220.89db4.27fd@mx.google.com>
Date: Thu, 20 Apr 2023 08:30:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1099-g7b2580e1565dd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs,
 4 regressions (v4.4-st20-1099-g7b2580e1565dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 15:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11259

cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 4 regressions (v4.4-st20=
-1099-g7b2580e1565dd)

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
nux-test/kernel/v4.4-st20-1099-g7b2580e1565dd/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1099-g7b2580e1565dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2580e1565ddf95b5123aaa9a1f4c33e354e397

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
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414eafa41f81c8022e8674

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64414eafa41f81c8022=
e8675
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414f428ca6b2dd562e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64414f428ca6b2dd562=
e85e7
        failing since 29 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414f5346030dc1172e8620

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64414f5346030dc1172=
e8621
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644152100127e7c1cf2e85f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/644152100127e7c1cf2=
e85f9
        failing since 15 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3AEC25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:42:57 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.202202.1698331367507017412
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Oct 2023 07:42:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JYsieCJi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ca052ec63bso8473185ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Oct 2023 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698331366; x=1698936166; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bHrp72Tk6XQQkRM35amXLn4EMOjizzhs22SyQQNMkW4=;
        b=JYsieCJiBB5CwoCgz9yZTrhH3XTJb9T4V8Hc3BmSObtFKczARcnnNbxGsR1oBMNLDz
         S0mDBnFSb5e4DJ8g8d9/kdmKywS2P+wh5HHFTw1Cukm6lUzHK7B2qPVwIhEzO+7IzfyH
         FrTa/pFE04cI/xjbl1lvtn6YKTTIT76F+Pj83jB6yTJPlmclSxPnb3EmWpD+OMxrcZlh
         dghHt8CE4nDpc893E6rLh4cxMEaZUsDBbq+JjhxQuKgQ/RKvcLfsMrR18jbj2sBvufv/
         x3vpxgliDzE/oFNEdXzpglK+OEN46Mwo9XN52RsegHKaYuyOdJlGrAmEtrmoofItO/15
         dK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331366; x=1698936166;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHrp72Tk6XQQkRM35amXLn4EMOjizzhs22SyQQNMkW4=;
        b=VEaeBaPrNJ01Ff8rG+P5Svd4l1pM4BIw/lw/2276p+E3GY2ILPRpozLYbIMLqHlywr
         3eubc4/bzyF+vNREr7dXbBkSM08JtmVut3Zs6XiFD3Oxhuy+s3uSEjdDSMOWyqw1GDqj
         daGxaVjDtgx3BzJGPCBkxgy6WAF9MdpblZtA6mz59bmV8ufYr3t7fjbPnCb4D59ZaSjY
         /w0KUJMa6JPrLBeSkM81/EdwzUJbqiY1sPPVbq+1psyg7SN5Lzd/tUxeHsgZs7a0Tdvi
         0XVXYHOMwT2WTZdGtj0ExFAcHrxMkcluMEI99S8a/Ja/q+IGuyOolB4N4Zssb1BDxCPu
         kmXA==
X-Gm-Message-State: AOJu0Yz4lA0KUwhy9FqjEFjWSu4/NiEErZwhoJZiD/DqaPPEKHmVVysC
	+FwN3oJ0+sMXNyYSNUO/c068WYtHvRzDy2gag44=
X-Google-Smtp-Source: AGHT+IEzpa1NYadXzM7kp3fLOkOAz3aNUGGZeZm7heyGNlu0+Jwr3SHoen68AXHETFyNti+yWHnjKg==
X-Received: by 2002:a17:902:f2c5:b0:1bf:27a2:b52b with SMTP id h5-20020a170902f2c500b001bf27a2b52bmr16469765plc.58.1698331366342;
        Thu, 26 Oct 2023 07:42:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902bd4b00b001c9d6923e7dsm11065854plx.222.2023.10.26.07.42.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:42:42 -0700 (PDT)
Message-ID: <653a7ae2.170a0220.269d6.50da@mx.google.com>
Date: Thu, 26 Oct 2023 07:42:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-3596-g73e7f2b880d98
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs,
 4 regressions (v4.4-st20-3596-g73e7f2b880d98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 14:42:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13471

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4-st20-359=
6-g73e7f2b880d98)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3596-g73e7f2b880d98/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3596-g73e7f2b880d98
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      73e7f2b880d98bcbacb997959b6c7b220f7fe382

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e2a57301d2c8eefcf14

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/653a6e2a57301d2c8eefcf15
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6ddb868d7366aeefcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/653a6ddb868d7366aeefcef6
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6df1797b85123cefcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/653a6df1797b85123cefcef6
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a76774abe63ba19efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/653a76774abe63ba19efcef6
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =20


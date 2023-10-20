Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75B8C25B42
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 18:39:20 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web10.62363.1697827153327726040
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 11:39:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=FvvrcUox;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ac88d2cfaaso871618a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 11:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697827151; x=1698431951; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r+cGOQv/uaBMxjOTgYOR+4Cs0ieCyGNoo07FvkTC0wc=;
        b=FvvrcUox63Jtb/MdB4jddDbtqlLgwZ+ZG4I/lqm4KfZr5xfWo6QyEuQXQ/au3/DcNo
         IUwXLl9q108zdg66FuJ4IYpB/wudaVsstngTM20SYltkmWiu5v0EvZC5VbmBLQUu8T2K
         xrnumR1tpUkSllqTgpjpLGGkxc3yZNrqC5faf2404hwFtK+U0kx0grcpni+CyFfPbSm6
         T2CUM8o0EGNQSKFxP1EbehJz1izjQCO5eu/QTmZ/Pgc2rQ9LWk8JVCKyPE8Z2hFaazHX
         tLQ5kGDRBmZEv2yZr317MurvUPKEfD/wSgjOLaSzdDKPCxAMLye7bYtPF0HuU0zq2t6M
         t8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827151; x=1698431951;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+cGOQv/uaBMxjOTgYOR+4Cs0ieCyGNoo07FvkTC0wc=;
        b=S2Z5omFl/eiRvk7BjtHf2zS/p6gx38nxyh7L2mG/nafTIjsiQl/8uGDZ3bVZKT89Aw
         WPrLXubLqBZhGIvV1yU9WEdiFmb6482geLUFF/zoaBjcxPMjmUnildpJmAZpQdBM63eE
         u5SY1vu/DlDiacSdBDAhkP5TdY69JCp9l2gAGZdw82xZgkjQc8BXupb3y5PvDekCVBms
         hMq4aXYdXVd0mQquRdwVKs4pPsVUTJak6b6ntPKZtgM7PND+n5h3uhNjgREd4f7AiNxY
         Z1OuHNQQ5WwqvYe4md6ef9c/lNEJRqq/T7lxKUI6ZiMHMWSWReay2hKJ+FjADFVcVx4+
         9zwg==
X-Gm-Message-State: AOJu0YwHWH6jTV6MmKhp1MpsuDPIQQxYyASYNRvZmJiHLu9csv6rTAQF
	lVCGR2rf4kPEmjKD565sPloGRuKazn/a/SdQQDc8HQ==
X-Google-Smtp-Source: AGHT+IEHIrN6Hr9u9jpBGNQ43c8TAzDcBkyXJo9eBecQ7Xzps2gQ4eJCx6GUog2qfy053wYOv3nv/w==
X-Received: by 2002:a05:6a21:3d85:b0:154:e887:f581 with SMTP id bj5-20020a056a213d8500b00154e887f581mr2663999pzc.58.1697827151232;
        Fri, 20 Oct 2023 11:39:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001b86dd825e7sm1835284plg.108.2023.10.20.11.39.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:39:10 -0700 (PDT)
Message-ID: <6532c94e.170a0220.556b4.6c54@mx.google.com>
Date: Fri, 20 Oct 2023 11:39:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip78-rt45-338-gf468de833aa13
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs,
 4 regressions (v4.4.302-cip78-rt45-338-gf468de833aa13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 18:39:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13426

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4.302-cip7=
8-rt45-338-gf468de833aa13)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip78-rt45-338-gf468de833aa13/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip78-rt45-338-gf468de833aa13
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f468de833aa13aa639d147055db4edf9931b6811

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532c05ed5e2d8dbabefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6532c05ed5e2d8dbabefcef4
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532c19b48dbb70634efcefd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6532c19b48dbb70634efcefe
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bcbad95131e779efcf37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6532bcbad95131e779efcf38
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532c82dfe4c680da4efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6532c82dfe4c680da4efcef4
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =20


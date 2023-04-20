Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389C4C77B7E
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 20:26:26 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.2105.1682022384434165614
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 13:26:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=M1uaiggc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so1884838b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682022383; x=1684614383;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v4XXGpERVZ/4235aVsFmTdGrWPs3t4mZ6gzUFTTqKPo=;
        b=M1uaiggctOOM7ilrjn69/lBxIsEZzY5N8YvVbXo58o0I4BK0AbVzm4JBUrZLR1cXot
         UBeM8sp0fqSBij7rN2Knp02H+o9gl+T53BAFiLQaBTzncqND91XOnJ38hCb4D+pncyQC
         fLZexHgPLF9DwsIxLjLMe762zBbnJ4/eInlXtoFz/vCPTnsluJXy855uayP/HSImEzqU
         AhqZNbBC2EiPvI13FVxu7BsScqc8ySymwgA6VeKU8gYdK34JCvpwOXJ4zZeH2ZqvpG6K
         DiKkilQEW0E1yQ7JL7oMbxdMSJta7qB1kp7hWc0CwTC3SYD44O7OLkVZbkbJIFp1HVXg
         ev0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022383; x=1684614383;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4XXGpERVZ/4235aVsFmTdGrWPs3t4mZ6gzUFTTqKPo=;
        b=IKAEIYQU37h1OUpBWOrXED3gb4YLmDrDYPIbUck3qdQzEtYre0Di+krzXT2au9VwAP
         fuYb93QoC/BjcfZeWsEZ6PecBDwtFloxANbfntqaeqfGLJCezjYjG1scoGD+hOMOr1/e
         hpv71iVqtXX/wOa64kFk/AAkV7n/Q5PsceHVfEG+N3zyD6fUBL4sSpsjD5FOaROPEz/T
         4eSzXJph6a9mEgFWbb+BodN0Q0RYiwi8qiD9fyDAU/2dEDAGqo9xg3vSFUxglQMN1zMD
         FLWnMdffwjzkXjxfW6hu7u5YqgoRrXcf4ha/AISIoZKrkv1M3TZVo9atuLE0VELY5jZp
         4Trg==
X-Gm-Message-State: AAQBX9fcb42bBebOJXdewszZ6nd6NOwvAceF03PDT12vHUAix1U7bdFf
	HvEpJxtQp+Zf09Cnav87xcCGreFLG8aCIpiY3tiJFM+H
X-Google-Smtp-Source: AKy350abFSREEqpwW1eIN/PAqtBNUZCImxMc0gIKGFLfO267uEmZo45+MMJaAu6vvsXAscj6KGI4lg==
X-Received: by 2002:a05:6a00:248f:b0:63b:6933:a30d with SMTP id c15-20020a056a00248f00b0063b6933a30dmr3033262pfv.25.1682022383580;
        Thu, 20 Apr 2023 13:26:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i24-20020aa78d98000000b005a9ea5d43ddsm1675049pfr.174.2023.04.20.13.26.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:26:23 -0700 (PDT)
Message-ID: <64419fef.a70a0220.f2b87.3c18@mx.google.com>
Date: Thu, 20 Apr 2023 13:26:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1100-ga8cadce4b9649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 5 runs,
 5 regressions (v4.4-st20-1100-ga8cadce4b9649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 20:26:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11268

cip-gitlab/ci/pavel/linux-test ltp-ipc: 5 runs, 5 regressions (v4.4-st20-11=
00-ga8cadce4b9649)

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

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-1100-ga8cadce4b9649/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1100-ga8cadce4b9649
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a8cadce4b9649177791a9adf0eef53ef0c90de78

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441932e3f6f5134422e8647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6441932e3f6f5134422e86=
48
        failing since 29 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644193b2f033dde6932e8643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/644193b2f033dde6932e86=
44
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441932d899ef308222e85f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6441932d899ef308222e85=
f9
        failing since 29 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441962904e5d3596d2e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6441962904e5d3596d2e85=
e9
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441977ba783c1ca582e864c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-ipc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-ipc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6441977ba783c1ca582e86=
4d
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE0AC19F21
	for <webhook@archiver.kernel.org>; Thu, 28 Jul 2022 10:40:26 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web08.31115.1659004821942117272
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:40:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=2/dSlS+s;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 o14-20020a17090a4b4e00b001f2f2b61be5so1724654pjl.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=n2/UnqbpGXs+1VC4pVw7VSh0eWUp3CJTr3LJXRbEM1k=;
        b=2/dSlS+s+ipYEJ+/kTkkUKL+zXhIKvuC9I2FJvHNFK78nMOzXkdByGuHfemVYL6T4f
         GyAasQo2E+uEMFq/zagMIi1/Cmm2gT8Ygrj2IaTAqbXmU7pIPvdj3fcmbajB4+QjZxuD
         R3cJUfDr6DPtCduIxAFIByuQy5GHgK+DoTOQsdniAEKjIaKjII5WsQ4+r0q5o+CIHxOt
         pe9Ujy/Qq9OQueqzDPES/kbvLVdqctFBSjHPG5fLJxNZTUPuhcLtss96h84hARBK2bDw
         vvTIAv2e3/MkDHWXFXn5KithL0lOQFcqtfj1uNYiM/CZ2YiytLWLtQ9p5Yi6IuV6LWI2
         bcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=n2/UnqbpGXs+1VC4pVw7VSh0eWUp3CJTr3LJXRbEM1k=;
        b=eDzdeEn7BnBb9wEXvDWyDLJk73XntIcG7XNm9ApPuczTYcruaSgmPTxcu54lFtDAN7
         7yDsZsfMPHQORrxQgmSGZnULQ65f7WbTzOx19lwgnQlZLD2DQTPbFxrx4o4yfLK5Nna9
         JkEyIkE1OoFCHL8+BriVzZbuXvTeNavwSKNszuw5YH3Vqwk6bdM9uwHu6ZpOdcmfHcBR
         xIE7NLLMtO8zVZtGG6aRjpLAcGwI0JYtRMAt2+KD5SPhMtU/rhfdDHtqiPfT39QXj/ZF
         52OYAw/oeqVTUi/CrSoBfLC/TK0NJDL1RP7pW4+/XLWvor9eFGqLxD5y/9eNk6RFH3P6
         vbhQ==
X-Gm-Message-State: AJIora8WuCxIm5UWdAffDBrhy/s6JqL4r3qNeLqpg1RVXiOAb+TWPQ+W
	CU0G6RbOSpVWtlChQROtmOiFk54q5+pK2cnZde4=
X-Google-Smtp-Source: 
 AGRyM1ugg5+0ozmpuXNFktFjNeSIhX8VnNcH+fy7N26PpSL36+y6IAdbDlJr46ww1svf985QRzNr4A==
X-Received: by 2002:a17:90b:3846:b0:1f2:8799:87e0 with SMTP id
 nl6-20020a17090b384600b001f2879987e0mr9765510pjb.130.1659004821243;
        Thu, 28 Jul 2022 03:40:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 22-20020a630b16000000b0040ca587fe0fsm657123pgl.63.2022.07.28.03.40.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 03:40:20 -0700 (PDT)
Message-ID: <62e26794.630a0220.ca4ee.0cc0@mx.google.com>
Date: Thu, 28 Jul 2022 03:40:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-585-gc99f2b257bde
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 8 runs,
 6 regressions (v4.4-st5-585-gc99f2b257bde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Jul 2022 10:40:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8966

cip-gitlab/ci/pavel/linux-test ltp-ipc: 8 runs, 6 regressions (v4.4-st5-585=
-gc99f2b257bde)

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

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-585-gc99f2b257bde/plan/ltp-ipc/

  Test:     ltp-ipc
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



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b1db53de665417daf06f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62e0b1db53de665417daf0=
70
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b0cbfd8baa0417daf059

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62e0b0cbfd8baa0417daf0=
5a
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b1ddb27451e36cdaf080

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62e0b1ddb27451e36cdaf0=
81
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b1905bba492157daf065

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62e0b1905bba492157daf0=
66
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b1d5b27451e36cdaf06e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62e0b1d5b27451e36cdaf0=
6f
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62e1cb50b67a701246daf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-juno=
-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-juno=
-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62e1cb50b67a701246daf0=
57
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =20


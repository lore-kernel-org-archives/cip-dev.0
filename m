Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935D5C4332F
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 11:49:58 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.4663.1664538596208438707
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:49:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=qh5R4w+2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id x1so3772392plv.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Bu/bjcxqosVbY/n9L1rgB+4gOo2YiVF89RYw1+89KT0=;
        b=qh5R4w+2q4UdKOK8b+dLS2zivU/85d7fPQizKwGivCbp32HGKz0Akqd4G4GtJs8HbZ
         SMmVFgod0toI6eZakMdtcth1h+ZDWv0brEQxyw1C2g2HvSCwnNlt0NgkHGg8vqr/X7Ov
         tVOP5bQwLBOAClxSUdqKmFnN41e6mHDnHyy+FyCDPNc0hzW0Kg5HAnBnfEArXpAOD7gk
         /TWmgBQ2M1YmtYrMMBtWv8OX5v6g2ggZFtV7q58IYt3iQxA0Usxz/RXiNEeGO+XzKXRI
         EaxLY8SQL1WZWYH3w+dqLid0aH3raSVkZPGg/WBwYFbycObig/qp2NbRnDrUHk5DMN47
         NTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Bu/bjcxqosVbY/n9L1rgB+4gOo2YiVF89RYw1+89KT0=;
        b=egPmg5ej0NikqHK6f2Yc8wjRZO/F1lpPa7M2JQjlaEQWN6AWWFdrPq3N/NUlsJs9Ig
         9DodUG/2s+EZDBj3Op1gI+xI0EyUguqNAr/SMA2py8uUsiz80b3j7VoXCzOYfcF3N4QM
         Ni7hMKr5CFceiXV3kAgJ1THCj6TOKs3rLiWeIPi04awoOwO7124rvXoLLd8woKM8MQ0p
         Jb7NE/ryZazzltPSlUq6H/RWSLhHhSbTot7D6pwsf6U8HH4eLWM9PtINh8Hv4vHkpJcU
         7nVkkriUjMJiUGinoPJWrDpJC6nrfjRb2KrpbHKTrK+J9adaoRj0PU6auerrbZYd9L/m
         DUeQ==
X-Gm-Message-State: ACrzQf1lj4HmvPp6h3oQwDN/q/TXz/EOx2IFjXXaAI9Md03FY0Wt1sin
	522HnoRNFTTZQRd77vmQOmJzy3Rb8PBhOQ30Qog=
X-Google-Smtp-Source: 
 AMsMyM5CsNf2dzCSLnfhKNfimnbdx0Qqi1WPCp1/3GpEov+EFTqWzCVTltFxBumm4XAxgykxDI7bZw==
X-Received: by 2002:a17:902:f687:b0:17b:546a:10 with SMTP id
 l7-20020a170902f68700b0017b546a0010mr7067644plg.136.1664538595459;
        Fri, 30 Sep 2022 04:49:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p26-20020aa79e9a000000b005385e2e86eesm1611657pfq.18.2022.09.30.04.49.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:49:54 -0700 (PDT)
Message-ID: <6336d7e2.a70a0220.16429.3112@mx.google.com>
Date: Fri, 30 Sep 2022 04:49:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-422-g411cd76b5afe8
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs,
 3 regressions (v5.10.145-cip17-422-g411cd76b5afe8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 11:49:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9585

cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs, 3 regressions (v5.10.145-cip=
17-422-g411cd76b5afe8)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-422-g411cd76b5afe8/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-422-g411cd76b5afe8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6336d632bfcdc0d832ec4ea7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6336d632bfcdc0d832ec4ea8
        failing since 12 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6336d6166bc1718e1dec4ecf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6336d6166bc1718e1dec4ed0
        failing since 12 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6336d630471d5bab51ec4ee1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6336d630471d5bab51ec4ee2
        failing since 12 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v4.4-st20-229-gb433f12afe250) =

 =20


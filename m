Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243FCC6FA90
	for <webhook@archiver.kernel.org>; Sun, 18 Sep 2022 15:47:02 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web12.9936.1663516012324236184
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:46:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MSr5Pe7j;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id s206so24712486pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=62bymg5lgp0RJZ+bc7+hdckzxqJYjWuVLdoCJYfQOuY=;
        b=MSr5Pe7j2KbINddG8mfXBgsNyr1QYzfdD8npHulze/IwYoWMsq4cbPPPG0LwZLC9Nk
         69srs6ydzg2w7o8uhKM0K8D18BjV2HvHI89KLEXKWcwSh8dgl3+DVDh9NBHeUhKAZ/gS
         wLtGg3HJDRolVPCZ4YBwSkrDD0fsnS9huOHBn1+bVhfm8U6XifAUpJN1nCTlEkc6FftK
         WnI5+tVz2qILC5Q3bUA03odwDbCCocI3otlBNIUzYeX0uSd0fJ1PdfLFrBOkDN0ElRDT
         jYsISwTNpWN1EGqqZ1b/fbnYPFishQZSfZVFHUz+cc8MTZwGmlFml3rGJvT7kS/bXBd/
         VHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=62bymg5lgp0RJZ+bc7+hdckzxqJYjWuVLdoCJYfQOuY=;
        b=lpxBZjWCEYQ7WO22CywtY7k68gTpjjptlB2aBPFpElxnbbx6sYwtOIJIJla8oJwfFw
         y+MJp1OKRajbxLI/vhv363mNTAYYqvQwaiauc/Dt5JBCsBxUETgH1T0Z1f9mdlzYTQ8t
         RHNdzWuoEhK1n5Wk2S+/xPLL/dcvCzbAGvxxrsPN2O6XCCxpJMvq2TQ0fijegxCl3B3o
         vRKaP5lX2hsdu4kKkuUwbaohjmuEdsHXb35iANHvorrL9rOqZnkSojqNurJUJfKPVqhG
         gf/LzQKx/niX7lgX9xFsVJJ/VrQmn4C+YxJ6XFwCgvpuEYiBBEta+Xt70+X4Kvmj084F
         0p8Q==
X-Gm-Message-State: ACrzQf3uEWoMI6w/ujOngGk3Zcp1O1PMKRVlQ5xw41gjAqTLI037V+cY
	5NPwQOD6NLNgVvsN9G+mx7QflAGSKMfrR1V3ZG4=
X-Google-Smtp-Source: 
 AMsMyM7EadRwLZIKDWMPDiW+rHVMwrymPEmDk765lEmaCz+iUnoHFqDc1zXD93odjkOpUNMtINQumQ==
X-Received: by 2002:a05:6a02:186:b0:431:25fb:f1fe with SMTP id
 bj6-20020a056a02018600b0043125fbf1femr12700377pgb.130.1663516011512;
        Sun, 18 Sep 2022 08:46:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 l5-20020a170903244500b00177f32b1a32sm18616299pls.271.2022.09.18.08.46.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 08:46:50 -0700 (PDT)
Message-ID: <63273d6a.170a0220.1e581.0970@mx.google.com>
Date: Sun, 18 Sep 2022 08:46:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-231-g7349cef09ddd2
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs,
 4 regressions (v4.4-st20-231-g7349cef09ddd2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 18 Sep 2022 15:47:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9515

cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs, 4 regressions (v4.4=
-st20-231-g7349cef09ddd2)

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
nux-test/kernel/v4.4-st20-231-g7349cef09ddd2/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-231-g7349cef09ddd2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7349cef09ddd27c4d55cc11d23fdf232c9184ccc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63273004b3730f4785355658

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63273004b3730f=
4785355659
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f03b34dab689935569f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63272f03b34dab=
68993556a0
        new failure (last pass: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f01b34dab689935569c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63272f01b34dab=
689935569d
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/632732c4a668bdc45d355672

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/632732c4a668bd=
c45d355673
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =20


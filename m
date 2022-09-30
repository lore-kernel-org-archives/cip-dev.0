Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B925C4167B
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 15:52:08 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web08.585.1664553123577586485
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:52:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=4gmaKQi5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id e68so4610773pfe.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=kOBZt1vnT1GzO2e2fzZuM0qJUvo9gVhf8FxowdATun0=;
        b=4gmaKQi5DBm9WaHLhjp7LSglmWevj5MO5JawqdiwMebq6OVbVCHCJF/bT2Vuo9k93W
         uFf6MguZPoNXfHnmOsVed+DoOWX2F3aw5udv4fXZ9MSpRm57TOBGq3mQQYyHP6N4Hf6/
         ImESySl/2DFdBlHhWK+m//v5MbwKo7g6kFy/jMEo7dZwfnLjCiNTdVV3nPnMPd2DFV0x
         nZcHuYN5/B21MTc+op6hD6KhgWEs7UwMDgiuQ4+Gen7NwrrXOMRu6DMhD8Eze/LDEPNO
         KN4QuzuRtCTyOy9aUKt5krO76G83GQOTyPnGjAboftxUS8nqZtvBBp5ZIDjSynzTvVTA
         GOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=kOBZt1vnT1GzO2e2fzZuM0qJUvo9gVhf8FxowdATun0=;
        b=bL+PvrRuvh8iu7GTet+mxVJl14NJA/8fXDrt42w1tGqA96xmvqpGuKbIKdJxPqg3ms
         dZm4vRhFMR6dBqLNnXlzuXNqnau1C3+3juat8TIj5l8IPXZss80xtPh0VxrjmVLyXYbq
         1z1Qrz8GdJa9ZPZNWiYuK6aSa0MAKnsE4Xz94mWKUyoitSptoKHANXIyOaOQTxr1IWuX
         co9KfvLrnsg8YeBkcqXSw08O+R5cxZy40/mdeaP2pKtT6SbKuXmEp9VQIwsb/LGhtK82
         5q0oSQQeI3gCZ5BADGNDoCHel5xEA4Bt4rfYWCEpCAkCmzpNgL6AKbMNPCGfYgBfLId8
         LaNg==
X-Gm-Message-State: ACrzQf0xv0TF8sDL1oDG0Yaba4oUDm0xhaEv/TQqDM3+XJOTWb7ArzdQ
	L60L93ud7gwmcInSjfwn23wq804J4/IwdwVv9tc=
X-Google-Smtp-Source: 
 AMsMyM7HzsvU+ni8u9g4IgqMM10SKIuvR2KIbN8bDj+RAzBX9xwQsPzu2FeiwLJciImphFkah4noog==
X-Received: by 2002:a05:6a00:e8f:b0:536:c98e:8307 with SMTP id
 bo15-20020a056a000e8f00b00536c98e8307mr9795180pfb.73.1664553122852;
        Fri, 30 Sep 2022 08:52:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m7-20020a170902768700b001788ccecbf5sm2062112pll.31.2022.09.30.08.52.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:52:02 -0700 (PDT)
Message-ID: <633710a2.170a0220.1a9d9.4027@mx.google.com>
Date: Fri, 30 Sep 2022 08:52:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-98-gb2bfffe124dae
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs,
 3 regressions (v4.4.302-cip70-98-gb2bfffe124dae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 15:52:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9593

cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs, 3 regressions (v4.4=
.302-cip70-98-gb2bfffe124dae)

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
nux-test/kernel/v4.4.302-cip70-98-gb2bfffe124dae/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-98-gb2bfffe124dae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2bfffe124dae9fd793da3a9d45f286a98412d6b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633708496744e02b82ec4ec0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/633708496744e0=
2b82ec4ec1
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63370676ef83e0c30aec4ede

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63370676ef83e0=
c30aec4edf
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633706384f1b54035cec4ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/633706384f1b54=
035cec4ebc
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =20


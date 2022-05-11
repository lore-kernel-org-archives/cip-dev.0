X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web08.11829.1652278177953565739
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 07:09:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=JbjaBWz5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d17so2043951plg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HA3ePB1wVtBMMHImEcctOqn0JZflVy6jTDYyojEjhRM=;
        b=JbjaBWz54uBzIzE0DlF+mHA7YGKLMGVcU+9kouKJ04WP4/urdo0WSZzG3Nxme4oijA
         1WT/+rYxdDcuFvJiq0Jr3hnGxRYb+GM0bvPiuPiU6tacPb8jWgJ5UjL8wAjfTUJSjkLG
         D1nC1OgaatzEXum4pe656AbJ98oLp8qDQKWee1Dw96wdZzUHTce4ThSGZcaeSG/O0mYP
         hAFF97W8oyfNPEBu4ZcSOwWGuFSjK8xwz/Ca6rAH026RjWKlm4kJKn2nA7s2YKdHLlJ8
         5JODFdtOhsv57tYpy3GMaxE/DWxvsagS7YUvXvB3DwvZflR/Z+2fF65L/ykwUTw1wfP5
         jzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HA3ePB1wVtBMMHImEcctOqn0JZflVy6jTDYyojEjhRM=;
        b=lSvS0sY4RnQOZoCTVo2lmhNQvfgPo2SqJsUcQWPX4NM+AZSzGcqaYwJFh8ihpcC51G
         md3DQcMSgmdSUZPFuu60g+F8kSD85pXgfPLZzkY9HWDnUOR5HkTNYuWjjBoSrV+1vKr5
         mSZ244fZJxzq+Q8qrqFIzzJnm5H8dhmLZJT/h0BKLTq2p3x4EV8EJteM0xiWvQv6LZ7k
         yFxxcsLJm327puuU4LnrVME5CrplCmsl6OWVlIb6NSrOtKMyBeuBjwotX7Fi75D96WDs
         uHpaVjjNDQIDneE1+gqpevNaos0ECT+ovjT/rj9aIiJaMXmYojDHgXWpgMf26ThRyuY9
         olNQ==
X-Gm-Message-State: AOAM532pgGAbXvyu3Qx+JADArphJJ9LW6ClwiPPLOtd0XSuv+4JEt0/I
	GSzfcvZSm7vJgwWHU56FuGzzaojGukGKIC6pI30=
X-Google-Smtp-Source: ABdhPJx6jbNznGw5nYtXfTQQNFJZ5QdUW8I3SRjN42HLu20FH7wGNVYt4iYiAFTBrH35BwmYDHZiNA==
X-Received: by 2002:a17:902:b18e:b0:15e:c6ac:440a with SMTP id s14-20020a170902b18e00b0015ec6ac440amr26019530plr.152.1652278177301;
        Wed, 11 May 2022 07:09:37 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y64-20020a623243000000b0050dc7628195sm1800104pfy.111.2022.05.11.07.09.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:09:36 -0700 (PDT)
Message-ID: <627bc3a0.1c69fb81.856a.397b@mx.google.com>
Date: Wed, 11 May 2022 07:09:36 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-17-g04a3c17cb526f
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 2 regressions (v4.4-st5-17-g04a3c17cb526f) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 2 regressions (=
v4.4-st5-17-g04a3c17cb526f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-17-g04a3c17cb526f/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-17-g04a3c17cb526f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      04a3c17cb526ff31d466407f119fa9692b4cee08

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  0f67c9851a9043d0ad68cef4648d103ba7908480 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb689c31fd6ccdb8f5748

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/627bb689c3=
1fd6ccdb8f5749
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb95305225400e68f5724

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/627bb95305=
225400e68f5725
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20


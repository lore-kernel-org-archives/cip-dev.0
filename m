Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C0FC4829D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 17:49:29 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.4334.1707328161613633611
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 09:49:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=XZ2nSjML;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e06d2180b0so478215b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 09:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707328160; x=1707932960; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JrbL5CTuhJNqGmtxY7YxX4j2AEWi9f680eOk8eyFROo=;
        b=XZ2nSjML8DFIt336OtdxKRJftNkh7wYsvJLiyQ/uELDbIFBE8SshC+lAON+k9J8/SB
         IjJ+vf3VOLE7WYI8VIOoPIghfVr8wMmO6R2Oe5U1cpmACsDOxMyX6gnp1/WqGqd+/ucP
         iLrmxUSzZd07S9IPbzV7JmMoovK28w6rflh5P6uf6bG4w56+9AOYQ5K4TC9EbpfkyVEl
         tkmp3/h2KdeVfeMof6+SX38bA8gx/2MEuQvZrj/q+270sLVgjFAUlp8cYfeN2moOEnNh
         O2+NxrWZBI5MjepHryFZm2HK/izwPkocG5YO+3ZkLVes2KE3cZhFsseckARjFUD//vO0
         we8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328160; x=1707932960;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrbL5CTuhJNqGmtxY7YxX4j2AEWi9f680eOk8eyFROo=;
        b=quFa9qpYA/YY6ItgpDsY7PJzqU1kMjQK7/i++cdI//mZdqHvLHkdv1zM4s7RK7FIWF
         lgBkgIxBws4lEp68nfLa+UkLunXp/1KKdQJpC69+dBGNlO2r9eUnQY66WD9gIUpc9NCb
         4sKUDPkNA+eOpfKbtd8qWy3oq/lhujRTnFdctM+alJUoO1pvpI8kNiZ3GFP4m1LQADbU
         0iRaXbyVbsUaWBFdugfiHN7JTZKXB5XVxixczRVTDN2/I+JAW2rSD8JHYGHiTuDN86BZ
         tvtxQ/knRcRk2OeguNH9iRStKw2JbzI/MAIi9VunYrQRl4VPz/8Fdl5yuqlP2tnh3yA0
         N/nA==
X-Gm-Message-State: AOJu0Yxd4Yl+9TAw1rbKGS5/9u2yZCMyblcLRQIj2YoBvF0ptY4QD7Ae
	d9/Apu9llHdDmu+YldLLO6pFxxSsLEog3P8XzIof76dRsyuHk9cRGSB2ALcPQNBVjk5w1dHuI+t
	TSxs=
X-Google-Smtp-Source: AGHT+IF1eY5bYxDJqohsR5KDxdLQ93MckybMyVMBdgp9nhxzrUdRmnIRPscevvTS13rIVnBniXuhHA==
X-Received: by 2002:a05:6a00:44c5:b0:6e0:6c89:e308 with SMTP id cv5-20020a056a0044c500b006e06c89e308mr1995657pfb.3.1707328160288;
        Wed, 07 Feb 2024 09:49:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b006ddc75edd55sm1886515pfo.152.2024.02.07.09.49.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:49:16 -0800 (PST)
Message-ID: <65c3c29c.a70a0220.5972d.6351@mx.google.com>
Date: Wed, 07 Feb 2024 09:49:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g57b839f015944
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 3 regressions (v4.4.302-cip72-1251-g57b839f015944)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 17:49:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14895

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4.302-cip72-1251-g57b839f015944)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1251-g57b839f015944/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1251-g57b839f015944
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      57b839f0159440df3a9c4b22dccee20e801350a7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ac39bbd0d2d0168e1e99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c3ac39bb=
d0d2d0168e1e9a
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ac96f7e61908488e1e7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c3ac96f7=
e61908488e1e80
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ad2248197d63d48e1ea3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c3ad2248=
197d63d48e1ea4
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =20


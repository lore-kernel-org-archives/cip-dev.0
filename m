Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79229C433F5
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 15:52:08 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web12.563.1664553124848823897
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:52:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=swoKE9nL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id e129so4499057pgc.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=8OgM6MaYDf1YFBxc+w/pqQUIySpLFaaRzs7ZURyJUtM=;
        b=swoKE9nLyBR7pIyWedpCoxBcYDsw/BcEvhhDrwWIjpJ+hcMRgzxIIPxgTm5KJ7HFdE
         bXiGf9ElUWMHWGVQPAphLO4NpnlBF9DW2imQJfOZ56KOmEpmPnbsoHZR5xCyOp70dL2E
         6jqU/YAmGIHrXl3HGgEtSFgMW2C08ocWc3M+UyhfOqhrOz3fjOaKLYRIaKi1pALDwnLD
         xS0lY3smlFofKfm0IXEW2jtQnF5l+TOErQ5qCqbPxNBXafgb/n2SdZW0nt7GbyTeek0m
         2nKvdjUtS74+3NPrOlnggIgoYZyT2BaNlLbv1iT9B9YFBHdgx8+IjIc2Oh3J+nI2Qo9s
         z1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=8OgM6MaYDf1YFBxc+w/pqQUIySpLFaaRzs7ZURyJUtM=;
        b=rAMEs9PeihUWnT6Yxsu3kPTN4MFBo5bylE9sn/YisScGY8UZLSOjgGDvS7TnjwGA7o
         kOdoheb9Avm30ydNfy3ZkcHNR2svf2dpO5T9ZJvSKdGs13MMKYPmbhIOwRDzdHoE0vE9
         c/1Ig0rv3Zy4riX0weWCBz1MexhN/LswV3EiTztL3XEjIMyBSKYgtMgvonuc/vmI+KXM
         EfQfLyvqp8xeUN/EPRzPiwAR3FBp/3ux9hbfKHjkg8BlguVMawwsV1xHANzJe2mw05Jb
         OlUbKS7jGNPntNKo+15b/ogL3TNTt2s32fkCTSkapZk6EnfzTTtebzDTOwQx0+exlDzs
         FFXQ==
X-Gm-Message-State: ACrzQf2P8Ac6r9sHxEXVICawFu7U5hAl9Y/yA1Q6IOkoVMfkVgbE0a08
	NJMuKiYge2KOk3HNnuaDOyan57E31SufmMiGCsY=
X-Google-Smtp-Source: 
 AMsMyM6RIUv//fFlP9EmDBJxdVq868CwIh8BN0jAf2WDSnZoSRYH0tSVKvnkAesiQjcIDQK5V5xQhg==
X-Received: by 2002:aa7:9e12:0:b0:55a:fd89:c057 with SMTP id
 y18-20020aa79e12000000b0055afd89c057mr7890628pfq.22.1664553124155;
        Fri, 30 Sep 2022 08:52:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y3-20020aa79ae3000000b005383988ec0fsm1938777pfp.162.2022.09.30.08.52.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:52:03 -0700 (PDT)
Message-ID: <633710a3.a70a0220.fd5f3.361f@mx.google.com>
Date: Fri, 30 Sep 2022 08:52:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-98-gb2bfffe124dae
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 3 regressions (v4.4.302-cip70-98-gb2bfffe124dae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 15:52:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9594

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4.302-cip70-98-gb2bfffe124dae)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-98-gb2bfffe124dae/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-98-gb2bfffe124dae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2bfffe124dae9fd793da3a9d45f286a98412d6b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633705a9eb0f4efc8dec4ea9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/633705a9eb=
0f4efc8dec4eaa
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63370756866e422d9dec4ebf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6337075686=
6e422d9dec4ec0
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63370c2802e76b80feec4ef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/63370c2802=
e76b80feec4ef5
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =20


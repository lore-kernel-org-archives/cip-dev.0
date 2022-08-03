Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08109C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 17:55:30 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web12.1010.1659549326991827033
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:55:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=AyY5GHUu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id f192so7675090pfa.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=vjqoVIXk6BhVS2o0ElCvYbDe87gR0jGHuUug6gyEbKk=;
        b=AyY5GHUuvGZzxzRKFbPaxfq1mOMwvfaG0Adts68XIcc3lMBQ1bUjXEV9SOlyS+5Mq3
         X0BSo5ugo+KYx0jIgDsSKWhcghYdzwv9LPJihTw265KNAIwtCO1MBTwh4mSuHpBcRCPF
         k/riYg6eE2m6X05PGmHp3TD8ggZTs/5oJdg6YPgdbeMuv4dkBT2CWUcSYEE4RFq/QLeB
         J6w0ayHAzhFFxXiXd6Wsyvjm5YVRB/yfSFannYVq5Ha/h4f4DaOzJBBYxROv6ELtgD48
         ctpEc2dw6kccRObWT/a7sUmm7rNEyLIbBxkyq5RrC+im+36sVa5OQLHq9JXxEF03HOVL
         EmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=vjqoVIXk6BhVS2o0ElCvYbDe87gR0jGHuUug6gyEbKk=;
        b=EhmvOHGq7XsuZgFwNcDake4Gu+veuX0pYD0BHwI89SL+fpTfGjhlQUPMPVzRV41N7u
         4cTgFgPImIa/szo/xwA+YN7tjvZRUzvc0DqNtsNDTmCnITznDzIK9R4IbfqZpuksbcz1
         oVSFuDc8XF+jRGgQN0eX9iE2wCx958LxDUzVL+rP38i+2qX49lmMc1I5UjYdvOeKtPGp
         qqSv9R9sdJCAiZg57J8mg8r2K19Hl+QgnNQE0IfOKkmOcVVG1Tgppk1vpSFB5d7eInrd
         tOIkFGJyRLd+MXF6M/12/+bbLmvN5LNtc6J/YzRt4wgb8GqFol7onF6ASArVD7lUjnjO
         1DLg==
X-Gm-Message-State: AJIora/k0JEgjiyAHaP7lKNBivG3dNONWYI6Dq0pnAxR4WiHeSQJsPa6
	RPfNLV1+SUdvVsWvEVoD5o0lH7LfmYnhjfB0IGM=
X-Google-Smtp-Source: 
 AGRyM1uowVL3cCq20fCuFgMEFJ3mZwQdQV/HYIorS2ssRVLjvKoOu6I4CuPv22Aw22ZeOS8d6/k4cQ==
X-Received: by 2002:a05:6a00:22c7:b0:52b:af2:903f with SMTP id
 f7-20020a056a0022c700b0052b0af2903fmr26721861pfj.3.1659549326130;
        Wed, 03 Aug 2022 10:55:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n12-20020a170903404c00b0016efc27ca98sm2201673pla.169.2022.08.03.10.55.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:55:25 -0700 (PDT)
Message-ID: <62eab68d.170a0220.9215.3c7a@mx.google.com>
Date: Wed, 03 Aug 2022 10:55:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-74-gc99f2b257bde3
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 4 runs,
 3 regressions (v4.4-st20-74-gc99f2b257bde3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 17:55:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9092

cip-gitlab/ci/pavel/linux-test kselftest-futex: 4 runs, 3 regressions (v4.4=
-st20-74-gc99f2b257bde3)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-74-gc99f2b257bde3/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-74-gc99f2b257bde3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eab11c3a3df6cebadaf05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62eab11c3a3df6=
cebadaf060
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa9d87ab83b1794daf059

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62eaa9d87ab83b=
1794daf05a
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eab5a62192f3766cdaf08d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62eab5a62192f3=
766cdaf08e
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =20


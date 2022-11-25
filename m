Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EB6C4321E
	for <webhook@archiver.kernel.org>; Fri, 25 Nov 2022 08:52:26 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.42966.1669366340192061421
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Nov 2022 00:52:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=rjTO+GOQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id a16so3175004pfg.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Nov 2022 00:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HI4K/N3U/GWPNE8/U4Bhvcy93vRFJITHy4bfpp3DPys=;
        b=rjTO+GOQsM6FX4VchBlNrNCsNngBdT0g5Qh+q+db3JMFvWHpSBUViq1anFOqMU7P8m
         HYBOVSOAzboR8jI6khu3GocHKzVZ4FJzHZG4eqmZINNqTws2IpxpU/SiDkQZXmbM1ngH
         /fLMnVX1vc03KypI8RhfeXEamOfGBKfGEVEK3Rdfs47oqRP/o2E5syBSoF0odXF4yZhD
         yA20aC4RH42rbO0d/rX2o006u4wGHs6ziEvXIiywP9f6M+nM0RqQZmntzhyKLJhQkZlQ
         k8vYnFRtsPVov8Qv/PA2Lr+1bJGID1+f1RNs8kSmW7ddz2z2+1pDj2c32QXuHx5P+gGz
         Yz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HI4K/N3U/GWPNE8/U4Bhvcy93vRFJITHy4bfpp3DPys=;
        b=a9p4dokrarJYJEhh7E9CeMj/TTqlrDEDJYp1mtv9PZtxKGBw935SpLFsMGbyFLIerm
         uempiJ6NhqKICPJJd5JQZ5gn9MLFJL6/h6BnHcnCStWwIxVC5AiMN4sHSbdtbFO5Pd48
         1chd+QSWydsALzTuhkn+po1buujQXfn5jLRduOnELaoD/vzWFAvKN9HThK074T8HlOHE
         OIYTtb0S7IqhSdKVCLnlbLnfU/Rxa121EZdXvVBbCQL3yLAVxIskXi17T6HEqiNQbpxT
         1JNdjwxAukNl4KFl3cCaVOFkj6HwLebh4Ob6e6WZappAHkhvis/2Y5YBbTGETHCp14nI
         ni9w==
X-Gm-Message-State: ANoB5plTH4S3eLqcsx0Uk+LJHqZ8G51P+dfyYKTCnQN8u4gK5sg3n4T3
	raNK5xFk9EDIgBZkDbn4WBsJFbnA7FmH3AI7/Zk=
X-Google-Smtp-Source: AA0mqf6/llAoazb6citMzVhSsI4Vg7cJ/lIRwMFrGYuPGicuA1OxQHIgNb7fd+7vJVk8Cab5/yasxg==
X-Received: by 2002:a62:1582:0:b0:563:f32:2c9d with SMTP id 124-20020a621582000000b005630f322c9dmr17200428pfv.32.1669366339163;
        Fri, 25 Nov 2022 00:52:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d6-20020a621d06000000b0056283e2bdbdsm2545685pfd.138.2022.11.25.00.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 00:52:18 -0800 (PST)
Message-ID: <63808242.620a0220.4385c.3465@mx.google.com>
Date: Fri, 25 Nov 2022 00:52:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-98-g7f7838c92740
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4.302-cip70-98-g7f7838c92740)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Nov 2022 08:52:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10102

cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4.302-ci=
p70-98-g7f7838c92740)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-98-g7f7838c92740/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-98-g7f7838c92740
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f7838c92740fa423a5a3f12c00ed02d92851254

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6380743133640e038b2abd07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6380743133=
640e038b2abd08
        failing since 2 days (last pass: v4.4.302-cip70-98-g7f7838c92740f, =
first fail: v4.4.302-cip70-236-g69445bc0d4209) =

 =20


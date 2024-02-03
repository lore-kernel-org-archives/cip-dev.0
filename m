Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AC1C4828D
	for <webhook@archiver.kernel.org>; Sat,  3 Feb 2024 07:41:20 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.13390.1706946069725629956
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 02 Feb 2024 23:41:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ouR18kRi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-296043e44caso2341243a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 02 Feb 2024 23:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706946069; x=1707550869; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PRgRwDjQSMHZApfDqdZ1sBEczhun42N3qmJrJxkbgoU=;
        b=ouR18kRiwah3ClQ0ByxkYoGfKGSp7Pl4km0HCr+Q5JR6jmNVV7q5P6NsbwF/NaSif4
         1iEYMlhJHNOC5DInKODwbR8LXp6kdyGJRPJTPePLJHfEmrNVjt5W0KhdN+asADNfUH3g
         F9Ee9gTI+IGhG1k6iDkITDN9tp4+sT0tt3U0H8sVCv0daAURmz7KbBZDRbZdaNpIHvoU
         yEwR3/kthGqud/RZhpw7XZEXf3e6WUUZPk0QZ0yMVWJQCE5p3xMnavxHIW+lj6YumO2M
         RXtbvTR6aCmACRO5znzY0szBj4CA2MSGq030C0m8Mnopiqo6KZX+N2EawE740W0vwykd
         iPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706946069; x=1707550869;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRgRwDjQSMHZApfDqdZ1sBEczhun42N3qmJrJxkbgoU=;
        b=imFsw50ShCZRJhMxxX7MurXJT+MVYagNOOsxQwZmPszZcGZJCUiZFQnX90AcugDVeF
         C19rZ4A0i12mwuudUmf1REtmFHn1SGpln55J2m5LlWf7QJaargslE72fwNP22z53Hj8B
         fzUJfgB6zgWpRaMtDdivi9lErwNljiu6EdLyzLP2zDa4Jzwm7rLCoYdAPlKw3gP9eGuh
         jBgjuCWdLdmWnv7CMCNImBrZSon/9Y29/fctlmz7tLl7hx0W8qK8O16tmPyf9TKzgztP
         zkUFWAhObjtKkFYYuFK2VEwXwane5taJcqM8xlgfY7Vc2s/1WQmDrSxWpL5JTNRUYJOi
         TUyQ==
X-Gm-Message-State: AOJu0YyOBC+1by+mBk8GJvQHcKaY96lfcdyvsceIDtY5g2x3O0K832j7
	5bpXlCybtiFiTvv2/5vvhmQoIP/ROA2e2XzzpPoHAEaq1vaTS/UCVICM+ljr+/kLXBo1z0S0gZv
	xdaDfCw==
X-Google-Smtp-Source: AGHT+IGfJg7i3U8WXBfpIj/wamz1t2zdyDOTpcc6qAEJMxYYz2xBMEdD1cqAluGX1DMVByvIFv+lJg==
X-Received: by 2002:a17:90b:438d:b0:296:6a37:c528 with SMTP id in13-20020a17090b438d00b002966a37c528mr231583pjb.24.1706946068598;
        Fri, 02 Feb 2024 23:41:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXfFpMYbnZ3bU5MqK6f5DDsYP9CI/0Imj2bHsxnd6PkLrOXrNzaMN05ptfp8CHemHQ2/bv4FtISnGBFQsXXlrgx1fNU1IZYb4fgwUPjf0QxbhdsH1mbGjwUxh8iuI0eUusp14vhPqd0oxdN8rwbPKDH4A==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fr9-20020a17090ae2c900b0028d70a8d854sm1225585pjb.54.2024.02.02.23.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 23:41:08 -0800 (PST)
Message-ID: <65bdee14.170a0220.36318.572b@mx.google.com>
Date: Fri, 02 Feb 2024 23:41:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.75-cip14
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline-nfs: 67 runs,
 2 regressions (v6.1.75-cip14)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Feb 2024 07:41:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14640

cip/linux-6.1.y-cip baseline-nfs: 67 runs, 2 regressions (v6.1.75-cip14)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sc7180-trogdor-kingoftown-r1 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =

sc7180-trogdo...zor-limozeen | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.75-cip14/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.75-cip14
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f555c0a7ff8af9ddf857352bab79675e17c358ec =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sc7180-trogdor-kingoftown-r1 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bde213a4a7e6988b00a04d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-sc71=
80-trogdor-kingoftown-r1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-sc71=
80-trogdor-kingoftown-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bde213a4a7e6988b00a056
        new failure (last pass: v6.1.72-cip13-31-g9539320ac89dc)

    2024-02-03T06:49:42.614832  + set +x

    2024-02-03T06:49:42.621354  <8>[   28.500411] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12694805_1.6.2.3.1>

    2024-02-03T06:49:42.728060  / # #

    2024-02-03T06:49:42.828657  export SHELL=3D/bin/sh

    2024-02-03T06:49:42.828812  #

    2024-02-03T06:49:42.929308  / # export SHELL=3D/bin/sh. /lava-12694805/=
environment

    2024-02-03T06:49:42.929458  =


    2024-02-03T06:49:43.029989  / # . /lava-12694805/environment/lava-12694=
805/bin/lava-test-runner /lava-12694805/1

    2024-02-03T06:49:43.030241  =


    2024-02-03T06:49:43.036402  / # /lava-12694805/bin/lava-test-runner /la=
va-12694805/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sc7180-trogdo...zor-limozeen | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bde2004af33e76d300a196

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-sc71=
80-trogdor-lazor-limozeen.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-sc71=
80-trogdor-lazor-limozeen.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bde2004af33e76d300a19f
        new failure (last pass: v6.1.72-cip13-31-g9539320ac89dc)

    2024-02-03T06:49:23.649183  + set +x

    2024-02-03T06:49:23.655149  <8>[   31.072897] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12694789_1.6.2.3.1>

    2024-02-03T06:49:23.765821  / # #

    2024-02-03T06:49:23.868410  export SHELL=3D/bin/sh

    2024-02-03T06:49:23.869181  #

    2024-02-03T06:49:23.970742  / # export SHELL=3D/bin/sh. /lava-12694789/=
environment

    2024-02-03T06:49:23.971532  =


    2024-02-03T06:49:24.073598  / # . /lava-12694789/environment/lava-12694=
789/bin/lava-test-runner /lava-12694789/1

    2024-02-03T06:49:24.075231  =


    2024-02-03T06:49:24.082842  / # /lava-12694789/bin/lava-test-runner /la=
va-12694789/1
 =

    ... (14 line(s) more)  =

 =20


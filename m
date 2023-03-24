Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125F4C76196
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 10:23:46 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.97943.1679653422596590079
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Mar 2023 03:23:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0WkQjmLO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id o11so1420623ple.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Mar 2023 03:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679653422;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9bh+4i2SOM3LyLkT8l3Cd818Pm5gvSNlqj11oxhYNDQ=;
        b=0WkQjmLOMWLkbrR6cFK3sIpEIx+jx71VxExH/yRwP//nGzI2ftclKx0fOxn5ozAdkX
         hLo+SJ2yvNq77fXQ+dZXaio+C7q5JoU2vVlD6/6GpQXxzvtUBBmGiPkKZVkgtrbIeNnm
         EFZ+vjLDv8y6H2IKpUoZk7MfHTVDiCg9M4CBfTpjYs6gjDiZmMF5SPpU0cTM19BBx1c4
         xRNkN9/9BsynzszJfCf3Jd+NbwMs4WKvY6dyRNp5AGHrunhS1DYkYvOOoySaibUy/VrC
         WAtfEK3mOpOXohPw4aMOcrQ8+I8TJeQhUSNIJV+YSmpQHn7K+H1Dd3XfwR39gy5qLynf
         +65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679653422;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bh+4i2SOM3LyLkT8l3Cd818Pm5gvSNlqj11oxhYNDQ=;
        b=rDmT3CHH2KgRJwoY/GIKl9r48yddjuO76QfWmw9FTGb1u98xrFmEv2MipM+MZgCBbO
         OdJkXeiUrvQxxlIrK8+vYq2MzMtkue6WAWcf8hbnKp+hYqOfM7AFtUbNI/R/WzTpjmOi
         HgIrL2h98nj4/o/Obe9L55cPLJYbhMkkd9u9dx/nqRVFLaF9kMYdlQlgwtbKOqNx/Fkv
         EBsDy7mqIxOtEVclC0zqf4df5CbZ+CqxoJMDYGYHTAvwctFoX3x1nv+KOXfoYjHIEHkf
         oYc2bh7IAsPBIkUReaE0MkPBvT/YQItCiK8pwGAAtR3OqkhAN/tW6jDCSsXUFFrZWwnZ
         io7w==
X-Gm-Message-State: AAQBX9eLibInAs4zqiSvx3kzQfx3Fjaq9ofA9glAKIRkr+wwEbyul15m
	GyCeNkVUPS/lUo3U8AlT+Olxbxr+fn90WHGtjaayGg==
X-Google-Smtp-Source: AKy350ZYlXsPx9L3KFVCgQ5G8pf/Yqttw5HdN6kKC/zxbH2z2558d8E3fN3niCNDc/RLdAtKyDCL+Q==
X-Received: by 2002:a17:90b:3b44:b0:23d:39d5:f81e with SMTP id ot4-20020a17090b3b4400b0023d39d5f81emr2455776pjb.11.1679653421903;
        Fri, 24 Mar 2023 03:23:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090ab88a00b0023cfa3f7c9fsm2696826pjr.10.2023.03.24.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 03:23:41 -0700 (PDT)
Message-ID: <641d7a2d.170a0220.3aa6.51f5@mx.google.com>
Date: Fri, 24 Mar 2023 03:23:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.176-cip30
Subject: cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.176-cip30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 10:23:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11115

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.176-cip30)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.176-cip30/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.176-cip30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      530cf8a4dace471f6e04e5887f4993ba1fcd3109 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641d68b099481477869c9585

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/641d68b09948147786=
9c9591
        failing since 263 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-03-24T09:08:55.729874  <8>[   10.376767] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/641d68b09948147786=
9c9592
        failing since 263 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-03-24T09:08:55.716409  <8>[   10.363178] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20


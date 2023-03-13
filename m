Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EB8C61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:35:55 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.19506.1678714551758474832
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:35:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=2Lf9yGtN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id h8so12924589plf.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678714551;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uA/yTaqk05RCPbxGVU9/HjCRvnEFXU/8IsOJugi2YR0=;
        b=2Lf9yGtNAQwJleTVeJjQCbcHPLlkbBBok6gVQRPHD1WRYoR7b0eXdOF1teyjO5rN+w
         5nNU/FYBs7zw44B5YkhAWn1E+EwDnG0UOzQessoMVzBM8bqMhAjv5eE0/fJUVZDxaVCr
         ySfAnSOFTB5c7swnesEy4k4QX9akOmv1cYDc78kVH1cZTQzYrskvdhMJQXmg05oPExOP
         ANvQosUT+PEjAhzU5au+QFOVn9PIC9eS2Xgx/0XpefVtTMxh7UR3KEi/vCag9XdyYRoN
         rAFJ4/JCSExCogFyAUciDBDGEFqT9IGiz3+8lPYkilZMwWgqeVYIXDMVyQgN1E2p9J8c
         DLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714551;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uA/yTaqk05RCPbxGVU9/HjCRvnEFXU/8IsOJugi2YR0=;
        b=FydvfZphZwv5Hh4y105u+51GteLOA5/nCXGCNOvpNGJMj+TFqVIaX9CKCw3CWw77AZ
         2vCkskoyJ1tNSZ8llbR4xepoHPPPcz11/FiqVORB/mUYUs7gTWKWVK6+rowiPpPEkb8P
         p5DQgedgdgbsSgQ88nR+tpXd0TlGEtEEZ2T//bNmjFuvnc8DQFe8O6Zjk3fFQfAiu7CV
         LJCxUTXPqW/EmSqonfGF4sb3ACiMFNzzgkj0BpqAPp8TY0Dt0Ie+ZmdWfETbTH5/8/gD
         cnKF+AoQ0uhgvlbxAHP7XnB7ApYjSucDwYBvNwSrKDtnNF5m60MSikWONQ+JEy/qVuKU
         hHmQ==
X-Gm-Message-State: AO0yUKVh/XjdgVhtctSXA98Q00VNGdMEKoDeRTfY+5CgAudNNe+i39hq
	DklvprAJ194crUasnDgulqHsdMbmGEOLOD2zbSU0N1sb
X-Google-Smtp-Source: AK7set9KIbB3iigX3tVh60wFXa1oOgo5GqVGCE64hnvaqSXYex610U1TARmWC6y+f1ndgXQ7q1d4ZQ==
X-Received: by 2002:a05:6a20:7f8e:b0:d3:6ee5:5a31 with SMTP id d14-20020a056a207f8e00b000d36ee55a31mr9045941pzj.49.1678714551066;
        Mon, 13 Mar 2023 06:35:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7920f000000b00593e5a45ce7sm4545736pfo.173.2023.03.13.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:35:50 -0700 (PDT)
Message-ID: <640f26b6.a70a0220.85a1c.71c2@mx.google.com>
Date: Mon, 13 Mar 2023 06:35:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.276-cip93
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.276-cip93)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:35:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11012

cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.276-cip93)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.276-cip93/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.276-cip93
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      849e6920f9039d78588d7ab644573c58cca7e64e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640f1603e23f90b1f38c8643

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/640f1604e23f90b1f3=
8c864f
        failing since 247 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-03-13T12:24:18.822828  <8>[   12.215036] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/640f1604e23f90b1f3=
8c8650
        failing since 247 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-03-13T12:24:18.812465  <8>[   12.205139] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20


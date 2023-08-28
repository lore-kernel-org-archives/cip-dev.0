Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB3FC83F10
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 02:23:36 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.5654.1693189414115529858
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 19:23:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=dGuiFtHa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-68bed286169so2422337b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 19:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693189413; x=1693794213;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=waWFyvNwZcrhF+AVxjSvX/YJYUHfjPA4TAlY9GqQcE4=;
        b=dGuiFtHapIiCT8QHSPMqSbKI27vLU5IBazXHfxy3bb1SquNkNH1nUyF3TnXNAWM3Uv
         8JZdYKcSBGg/YwOQkwUXw/jhoVqkB8NS+e7k/O+GtdYmKMSyj2sP3UdTz/su9/qUBVrn
         u2Epom9IIhbbwrDGWBiKiaEsXjVk/a7DumnE7a+p3b7Ga2bCOYjsQ2WeXCT9D8SQc1Kt
         WKniVwdea0nAMviJQH8lqYX6AnIERtoPc6++fevS+LiNvbQFKmRDr67Hv1JejONZ+HZM
         qq2BcsqquWWpsoDmHLReGyQGPmpUAhgVVWKKxgvlt5aVJZaItxVsg6vZbzmSGGbXZ1Nu
         BPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693189413; x=1693794213;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waWFyvNwZcrhF+AVxjSvX/YJYUHfjPA4TAlY9GqQcE4=;
        b=TonaTAn0U4fnBnc4XBixj1P8+o7byp0agclrL/pqzaRLZem5AAKbi9Tw0PXgQkEGcp
         CuDCUAxPv1hOZG5/i7Bb6relfUt6/BOI+gZa68XBhwGYhndrkS3bKJbsOuOR3Vxw+0sd
         BdK2OAqPIW9ELmTdC7+G8th8BxY3GxbAuaLwVUVnCVzv7grVVCCyegIIoMUQRJfrn6Aw
         DMKgucJm9Mia0ZdVvGv/BUPggaSxQkJ3fLOHtRbEPpk2JOFmBM4hiHwbw0t42u7osReG
         fgOhq0goMx77DGNGYWU5a1BAPR2PfbNTAFsll32w4Y+r4Ffc4UsQYVvK+C6VS5Uoqsnk
         EFzA==
X-Gm-Message-State: AOJu0YxJBbxyoSUAMSh/O7BtzVoF+VWs5Ap+nbXdQOQoRQbS+pwqT/+w
	VVKJY5bUaRvZLFjQIW+k3AYAWiNEeNkW9Q17DD8=
X-Google-Smtp-Source: AGHT+IGgZd6N8U3TJ6OJCGWTVE/V92s/vmuOweFlEm4LSy+HIxSZqqYmWiCVdHisMG1aItmb9AUmqQ==
X-Received: by 2002:a05:6a20:26a5:b0:142:952d:3e61 with SMTP id h37-20020a056a2026a500b00142952d3e61mr20146097pze.7.1693189413109;
        Sun, 27 Aug 2023 19:23:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b00686a80f431dsm5441291pfa.126.2023.08.27.19.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 19:23:32 -0700 (PDT)
Message-ID: <64ec0524.a70a0220.1b073.8362@mx.google.com>
Date: Sun, 27 Aug 2023 19:23:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4
Subject: cip/linux-6.1.y-cip smc: 3 runs, 1 regressions (v6.1.46-cip4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 02:23:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12871

cip/linux-6.1.y-cip smc: 3 runs, 1 regressions (v6.1.46-cip4)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.46-cip4/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.46-cip4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      58f7d1bf36cb697e7cab922b71d04f7d925e3b1f =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebef52bd2d814d09286d7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-asus-C52=
3NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-asus-C52=
3NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/64ebef52bd2d814d09286d7d
        new failure (last pass: v6.1.45-cip3-31-gc9451d303f3d) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034DFC4332F
	for <webhook@archiver.kernel.org>; Fri, 23 Dec 2022 23:47:11 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.86261.1671839226876366950
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Dec 2022 15:47:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=4ud3JjSd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id t2so6192333ply.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Dec 2022 15:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EKXeC3KROSJb1Xz7gp3kZFqamngNCjVqVydQnFDdvpk=;
        b=4ud3JjSdeDt5abVCzf4Mm5536V2Teu8FDp1AXWcomyRam3OUv8cR69S1eaHqwdyRoi
         oAcwfGwmgVIW4LGRdv8LRsyhQ07C5qUUaiYeiZsVWo5dYcMj3C9k7OsmHlMSqybzFqFR
         DujibKlmweVi5wNVWUJOCJNE6c7SHpYUp7fjCNeiIhO40+3RDgR7m5QQvBR52VBDFQVI
         dSnr94d038P7ulTIo+5QPyItWy+FOjqYQRzOlqPBk9CKACH2PEThNZ6EHsb1xpcY/moi
         4E/sUVbd0sSbA79lNZDRF1LPC9Ut0LQoj7IaJgMwsJc7/iQUKVrm+jOopeg4Qi3347Sd
         cbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKXeC3KROSJb1Xz7gp3kZFqamngNCjVqVydQnFDdvpk=;
        b=20+AxtW+bOHfGeoQQy7hkE9qMWWUIMaybacBhxD3hRuD61IdFYKdbOWI8WZGsUPWD1
         YYLY7hwEqSiA/p+VcxwQdMy/8ViQggXVUwG+Y4zK279xtG+Fq4jOgP8Z11bgTtSF5CzB
         lWCvUeO6Ez0grUzl68yuOw5Bidr0zoymW/LvoQdE4yIudTHZpNja5hOrbYkxqkpjmvr8
         psOlqTUeN/+Ro4dlBnGp7xRGtEpq7N6oMHL6FwWrQqikjuY6n0cscAcvHEydABRxIDIE
         vl7xDKdcYKMgo5m3o3NdtNO0QqMm919uQzVxQay6ZKqiEFyB88OgylnoE+4U7k4/V37M
         +FqQ==
X-Gm-Message-State: AFqh2koQ3NbOH1N3KBuVDGOjK+YtLGyQnQRbx3AJEgs1PuComXjva3yb
	NT3K0S9UJo4BzkVs9U1rfcx1qWclI5UTLoSQJ38=
X-Google-Smtp-Source: AMrXdXuTmS7gwZTsZAQJOOEc9g3EmKfOT1uggPQWbNwPpbfeLcGpocr05WgH3EuV2CCVzLjLAqweIg==
X-Received: by 2002:a17:902:748b:b0:191:3c8:b2ab with SMTP id h11-20020a170902748b00b0019103c8b2abmr12155833pll.31.1671839226050;
        Fri, 23 Dec 2022 15:47:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y16-20020a170902b49000b001899c2a0ae0sm2933904plr.40.2022.12.23.15.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 15:47:05 -0800 (PST)
Message-ID: <63a63df9.170a0220.51209.5a81@mx.google.com>
Date: Fri, 23 Dec 2022 15:47:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.269-cip88
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-nfs: 30 runs,
 1 regressions (v4.19.269-cip88)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Dec 2022 23:47:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10266

cip/linux-4.19.y-cip baseline-nfs: 30 runs, 1 regressions (v4.19.269-cip88)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.269-cip88/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.269-cip88
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      68472fb565eddeb233132b8be94440d06330ffbb =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/63a637ccad0c882acd4eee5c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221216.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63a637ccad0c882ac=
d4eee5d
        new failure (last pass: v4.19.268-cip87) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D370DC6FA90
	for <webhook@archiver.kernel.org>; Wed, 28 Sep 2022 15:12:49 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.9208.1664377967511178967
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 08:12:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=0LuPsUpH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 q35-20020a17090a752600b002038d8a68fbso2729426pjk.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=L+3qJD5l+ZCrCb+cNyfHRUChe3L0wz/VAojKu6JZDoM=;
        b=0LuPsUpHjfdgUJgrY1arMb+SUZ7rEWPG8h2kVk1CS+hzJ78mb78QJqEcy+paTrTd9L
         uyH2gG+jjTyKYcTov2B7sV8KQaJ6HgSffp+VhY8VYsx4qMOcJ2fQQ8LbIuJhCTeEne5x
         ovNYH1ZN9RIMLN5fju3J7v1hPTkcHoIzHWi+ZMcctNOTU0PdVvg1wtFEDxAuZE9+121c
         Q7q4L644rMWKvFZBQ3OJ2QtfS+brzeRnHr3J5WtfadHfp3XMOEEOR+PdmKCYPEE8K6mu
         SUAbDJLgb7fL/FC1JYXynhIKKid40SCniFcbzoY/rvNNQypPR3n1EkYDgV+oqm6kVyn+
         EGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=L+3qJD5l+ZCrCb+cNyfHRUChe3L0wz/VAojKu6JZDoM=;
        b=3cSyQHxEp91O9mAm/BFfyxTrVJVU8rhQ7tefto+eBwiXL/YgCTHFpxe7mdBaBlvmN9
         izHMMQxegXX0UovU5duuV29QiZODMd1StvZ5JAfwKshiJYtYv1pN27F774UAPG+m7v+8
         FtcNlIkSUm1hAn93w1tgXbY+hsjH0FjfZdIg78/FmpOgItAK7oOGwvHoCN6FvdP/uQh1
         MHQ51ZkvDD9y5E+JynbEryzfut2HwyIh26Oihn8nwMbcPHuPfKI/xHfZPvqb6i834shX
         Ebtcs4Q391Z7R2jAb32jbZ5TsunpJ3PSUy73tXWK/C7d3uQUrvRGADONPTCRtYKpNI+m
         H6uQ==
X-Gm-Message-State: ACrzQf1VDbcUotg9OJPDabYOUTGyPVIA/rDdhTvHLgqlo6z8MZ2PJdMY
	wrz6mL80DGCkWdk93SJHWobG2fhYhgrYurZ+
X-Google-Smtp-Source: 
 AMsMyM41n7TYFLRcgvjQk2ToeYF46Rsz5hULA2ZWhYYGV5pIoAlQq2WmVDD/2jyNmmgId01waCnshw==
X-Received: by 2002:a17:90b:3147:b0:203:6eaa:4894 with SMTP id
 ip7-20020a17090b314700b002036eaa4894mr11305944pjb.230.1664377966828;
        Wed, 28 Sep 2022 08:12:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i28-20020a056a00005c00b0053e72ed5252sm4180855pfk.42.2022.09.28.08.12.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:12:45 -0700 (PDT)
Message-ID: <6334646d.050a0220.3def5.7761@mx.google.com>
Date: Wed, 28 Sep 2022 08:12:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-140-g62223aebb3a92
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 3 runs,
 2 regressions (v5.10.145-cip17-140-g62223aebb3a92)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Sep 2022 15:12:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9572

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 3 runs, 2 regre=
ssions (v5.10.145-cip17-140-g62223aebb3a92)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-140-g62223aebb3a92/plan/kselfte=
st-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-140-g62223aebb3a92
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      62223aebb3a921dd8f6ae0008df527bf6bd30935 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63345389d4cfe0c165ec4ec0

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ00=
05-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ00=
05-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63345389d4cfe0c165ec4ec6
        failing since 95 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6334537c8316a43383ec4eb5

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-gru=
nt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-gru=
nt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6334537c8316a43383ec4ebb
        failing since 95 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20


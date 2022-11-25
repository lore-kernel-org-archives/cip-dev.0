Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E126C4332F
	for <webhook@archiver.kernel.org>; Fri, 25 Nov 2022 08:22:26 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.42571.1669364538945186559
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Nov 2022 00:22:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=r7xPsDeb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id jn7so3351927plb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Nov 2022 00:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5CeI0PLgBu4T0yeeY0in1ayeLTL49YMWtSc4WcVp+dw=;
        b=r7xPsDeb3+2WAv97N5cvulEs1DMT9ey6FssvqorxHcC7abxx0fDgFpT2iEl8gflslv
         bCvImPVSNFon0VT4EB23Qi6izOe/d0e1VH/4Y7xQ26gWS3tIb4+Arx4XilEkQoV8JG4A
         GFn0Ji8W226JN5wsWcDBL4Odi3Jk0qr4+1rS4fMCVphlsSRDyQm6hTw0AENHNJ03RRTp
         CeQzjd8gE244VGxEAJmmJmcODOKDWSd3OM2SBnqh93RlCQRH1YZJqdhLzoQvaHwQqzq0
         Muv8WJZYjdi8Px7yyBAqLFNb5NS5wex3YyA9F8faRsurb6Ka4umX1S7c1HeOIVrAwT97
         Eb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CeI0PLgBu4T0yeeY0in1ayeLTL49YMWtSc4WcVp+dw=;
        b=zHt6d3cnXFR7jVXe8qkBCS2jcm3ClQj3GyUOeGGm8Mx/wyizVyZXXYVyfGem8hT204
         fCfYk/dlHugPZeAOsDXJpHdzOQvcb3FqJWSi8I1xbM1+IkIZsCGmq0C9OM+rk5wmKrzD
         RfLjObd8HXN0lGp0NvLOw5dLsyRo+Jk0HZ1IrlogLvDrEdCLeorHnww27mf7DCb/1Q4I
         93YASo0ycvm/4ef5FTGhWUfrLdSoqa2iVsZNYQtS/znVPfGF87a+1PZIcksQD707S1QR
         RpvnjGnEmYEP/5UpX6s2Ak1fqE5Jp+yUgLl8EB8c4E+BPE9WZ8OWnUgJ9BTQms1a+HPh
         7E2Q==
X-Gm-Message-State: ANoB5pl2MhxASHlXyzXSLDNRlM/loeETdzxOB2R55l3g/hmYsyJqUjTb
	1vJeMl4UByyiih4M8mr6Y6zr889ZVf2r3585b+o=
X-Google-Smtp-Source: AA0mqf6oCmdkDn3ZtnWJfOZznar7IYtz66elc7w/FU6Auzt1e/Ux4/A1Tvlu2W036G6JiiCNejOR3g==
X-Received: by 2002:a17:90a:2904:b0:218:d7d0:4b61 with SMTP id g4-20020a17090a290400b00218d7d04b61mr14495953pjd.242.1669364537943;
        Fri, 25 Nov 2022 00:22:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 125-20020a620683000000b0056be1581126sm2566993pfg.143.2022.11.25.00.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 00:22:17 -0800 (PST)
Message-ID: <63807b39.620a0220.8cc5d.34be@mx.google.com>
Date: Fri, 25 Nov 2022 00:22:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-98-g7f7838c92740
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline-nfs: 23 runs,
 1 regressions (v4.4.302-cip70-98-g7f7838c92740)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Nov 2022 08:22:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10101

cip/linux-4.4.y-cip baseline-nfs: 23 runs, 1 regressions (v4.4.302-cip70-98=
-g7f7838c92740)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-98-g7f7838c92740/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-98-g7f7838c92740
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f7838c92740fa423a5a3f12c00ed02d92851254 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63807399a56baaa0cf2abd08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63807399a56baaa0c=
f2abd09
        new failure (last pass: v4.4.302-cip70-236-g69445bc0d4209) =

 =20


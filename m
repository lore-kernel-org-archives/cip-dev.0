Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6F6C636CD
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 05:37:49 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.77101.1675748265589377424
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 21:37:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AJ979pJn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so305292pjy.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 21:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TskQqFbEbR2SxeM098FGN3hhozuDwp7XNqGQ0gl6QYQ=;
        b=AJ979pJn0P+POeOlDmNfDctWqZm9oTaAtu7OROHotsnNxZaAPCUYmmeNpFKDsqU+WB
         zyspjlX4fElLelr56KF4UBMPBixAkXoaIseZf/HHfSCDS1zFcLFyJivkAAzvSHv62uoj
         M0mBLk5F+GWhMW6eX3JilZawMCpfrjafOl6/pgJaPF3d9M2sm+0nSkNOvcIXug1KhcKv
         2+kYwEvuFIGRFYi03Ax5fEZUPB4vCxXl0dWR2Xy+gzLxc31Q4fk+2G1Jwc5MzJCxgVSN
         USDYX+y36SWbVnTOmO2Bu2zYTXICbEBEd6ZfvnUDGGsSzraox5u7v9QQmQI5n10SQ4tw
         crNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TskQqFbEbR2SxeM098FGN3hhozuDwp7XNqGQ0gl6QYQ=;
        b=GEPREG2XkH5xb/K2Xfmi4vj/OTpLYqIAjPIn+OPXgHVRwgi9HsADX6oPUVGYaw8AuG
         3C/tjrtLbTkpnMDwt0fQWxye4N9kMsPmcWVX/4KrvdxOjbCF1k/gLP338sZLvP8/Mfar
         PEj3J6F+vb2n6NyE0FSIVFY9Tus9QloXrM5IBeZawJqHDGRcbmxk+STQ6WK6PHXY8ibM
         LGW0n/Nq6bCZvE4QGyx3gjPVfQq8eTQ7Z78Bb1YohaJxRFT0/OepCmn+NcnRLKOHoSUL
         le7uTVhYMtVb1f/KyDYNBZ/tXR19OwECVWq7RbnxJksRmt8ttG3I4PQHPVd5BQyjX2yq
         QeYg==
X-Gm-Message-State: AO0yUKXmKIRbbfWJdYT3iGn6YJw5wNPT6irHA6xPVEHRlQnP2DEsEpxl
	M48Z2JE3sBv42eq//9WFzNND7RUIk4YiH6jmZ90RnQ==
X-Google-Smtp-Source: AK7set+s8z4XqY8ExYxHUgc2m9xQ7VhidMuoTNvhBy40z+Ltnp6tNQ8vMJqzdX9h8Zx0oHPJSrUWmg==
X-Received: by 2002:a05:6a21:3889:b0:b9:92c2:7ecd with SMTP id yj9-20020a056a21388900b000b992c27ecdmr1626605pzb.3.1675748264811;
        Mon, 06 Feb 2023 21:37:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p18-20020a62ab12000000b005a7135a0290sm741913pff.161.2023.02.06.21.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 21:37:44 -0800 (PST)
Message-ID: <63e1e3a8.620a0220.1d4ab.2246@mx.google.com>
Date: Mon, 06 Feb 2023 21:37:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.302-cip72-rt42
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip-rt baseline-nfs: 21 runs,
 1 regressions (v4.4.302-cip72-rt42)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 05:37:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10612

cip/linux-4.4.y-cip-rt baseline-nfs: 21 runs, 1 regressions (v4.4.302-cip72=
-rt42)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip72-rt42/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip72-rt42
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fe1cf8ef6e9d76107c4a6e1bf8cc27263abe6698 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1dccd660f35bf7e8c865a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e1dccd660f35bf7=
e8c865b
        new failure (last pass: v4.4.302-cip71-rt41) =

 =20


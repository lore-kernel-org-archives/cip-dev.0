Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26666C4332F
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 01:49:39 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.5636.1670636969464919292
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 17:49:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=3tLh48H2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id fy4so6282323pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 17:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DNM7hxN8RotNUttzi05S56INgboiUkt+43mrp+/Xwvk=;
        b=3tLh48H2pCmLjZPmtJTtwtgQd6Em9M6QteaKgws0GbJ3KuMcBkqnV97Hdc3GCXH4lS
         nY/tGMnpqDrIuNYpHikAyKgksZNXkUp+DqrCKU+Iccb0M1fQfRWf6duA5lOson/X8gGf
         oJ3uDjgxw7EvEThoNgEEymYOw+syZq7AxRFAu4lV1M5xYZYbT4Zr3Dei8l1KCMDRLAcg
         0cj3nHHkfv0eGSKLzVEOTKlS4zcMhmcGhKjqFTDh4Cb5idenWBIOxis1IsYbyQh93Q3t
         hhpkXgwzJsPEwH9QeGX7eLREcf/4Lk6LH+XP8ztODidwRKCiO305J2tww0GbNYfDu6PY
         H/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNM7hxN8RotNUttzi05S56INgboiUkt+43mrp+/Xwvk=;
        b=3vabrGu+LgB3ILKIyaGOa0TUTBC/CZYu2FGVWBgEaCPq08TOG7xB/1SB02rYSpzsPV
         iTp5SrSa1HWzTh+kZ9ALpbMyWCRCwu+kmZvvyh7tnxopdw9NvK2x/ENmpgB+/EAyNHfs
         27bnPfrxtjJfRa4BV76QpfGstlkLVQ3di+opX0GCDEnkT0c+Lujp9vScP383MBfe9RFd
         MKnnpFS4UYe3TJOvuNhtdVk3/r1wOwMxfqUgS/FBw0CTpaZNvHwSa4zpCUG/tFzyoxq5
         3NPkL1yPplafrwO0odaPb33sMbqA6Qfr+CAgJ3Of3JU6yTFor+/NQJ9j8yYlTrHydxvv
         kk7A==
X-Gm-Message-State: ANoB5pkMPRLXdoUicttjp5Ycq6n0ltGCIyel1ktUiRpnwHdfRHgXKfRd
	dhaAF1EhE/jPbc30iU//cnnS7ooahhIcBiXP+xE=
X-Google-Smtp-Source: AA0mqf7A0iBUpYzldresSURwS9sfExD6ZNBxiUuHX5N70zQL0HrA6an1jroYxeBL6KJh8vPnsAGaMg==
X-Received: by 2002:a17:902:ce8c:b0:189:97e9:c92 with SMTP id f12-20020a170902ce8c00b0018997e90c92mr13890861plg.35.1670636968487;
        Fri, 09 Dec 2022 17:49:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jj18-20020a170903049200b001896040022asm1900094plb.190.2022.12.09.17.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 17:49:27 -0800 (PST)
Message-ID: <6393e5a7.170a0220.96547.419d@mx.google.com>
Date: Fri, 09 Dec 2022 17:49:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 40 runs,
 1 regressions (v5.10.158-cip22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 01:49:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10183

cip/linux-5.10.y-cip baseline-nfs: 40 runs, 1 regressions (v5.10.158-cip22)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f37e570b7c4ab8bcfacf36780a9e204878f2c181 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6393e1add37d3f772a2abd13

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6393e1add37d3f772a2abd35
        failing since 255 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-12-10T01:32:19.825624  =

    2022-12-10T01:32:20.147088  <4>[   37.989695] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-12-10T01:32:20.155532  <4>[   38.000122] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-12-10T01:32:20.155817  =

    2022-12-10T01:32:20.866840  /lava-8315166/1/../bin/lava-test-case   =

 =20


X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web12.4927.1648549214156940596
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Mar 2022 03:20:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6StUIwSd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id i11so17235613plr.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Mar 2022 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xm2GUNgnwzEwXYxznMbDENxR0JUr6DOMKCV4z0xfeRU=;
        b=6StUIwSd8sE7mBfMcvxXkac/zqgtG1HGI83jzLPsYqaSOIq1QtIC1tOc9zfnOPjRmZ
         tVY6lyKbH+u6hojwu7JlsegItoeUIW61tNKSqz5nVr+u0vUEdYaXouGrO0i+wGzEcFbi
         lFfIy6mdz/8fiZU3siZz15Xl6b4SbyYJXAO/QQx1gOfITyVNy5zEs62XqvhOXdEtw4vL
         GmrwtXYqwMCfou87NIh7CZApxRYKepbG/FoXWl/tmXSDHOTBWKu3czZrFtgy9FqoT3Tj
         bH4JeD2tmZ6FX4MzvZCmow35eMjf/EahzGvQs05aK1SmwGrH8A8fZUkRrIbELZl5qvy9
         h60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xm2GUNgnwzEwXYxznMbDENxR0JUr6DOMKCV4z0xfeRU=;
        b=auQDuKK8AZ3wroW19yGKHknLG9MjVHLTcCEeOXNxZ1GWGFaqHenDzSPbKp34n3Ye4F
         Lc8jCw4epwkVUNfjiAqHmK6jPiZEcBr6zPk4+a+V3lVGJqENXgej29/Skw6SeqwTZrSq
         ZXoevkBeCXXyIhmteM88JTd9Ex6HVNNFBqIZmgdY0ew1FP+0hGMo4mgN+6bbj2fTMvUj
         UsklgaY5t5lYziu7N4MMIlYg2YPg+gfmG9tAoop+eqJQRJJLbgKuhrFmfulEbQIuLwBa
         4BOr3xUopHkVTpXz3wWteQJYl06tnRu3pdQ+pVYM+73rpVYZHufBqur8yjq5dkz7TZN4
         OA2g==
X-Gm-Message-State: AOAM5309LFf3Gh7utEyi5hdAEwDvbocn5ITXHdvWVdm9dW5w6cihpZpq
	CDDD9ZnfY6UkPJGsk3asMgUWPeqkmy6dGzYTslI=
X-Google-Smtp-Source: ABdhPJzaXWfM9DDuJn9dMVpwshvYfiRRSnYX9onLDp644gXaKjp+Zr+srvcDN7d1lCEzK5kNdPDQTA==
X-Received: by 2002:a17:902:ca13:b0:155:cea6:65b3 with SMTP id w19-20020a170902ca1300b00155cea665b3mr24050057pld.144.1648549213536;
        Tue, 29 Mar 2022 03:20:13 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s35-20020a056a001c6300b004fb20b5d6c1sm13088184pfw.40.2022.03.29.03.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:20:13 -0700 (PDT)
Message-ID: <6242dd5d.1c69fb81.8d704.0f46@mx.google.com>
Date: Tue, 29 Mar 2022 03:20:13 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.235-cip70
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-nfs: 8 runs, 1 regressions (v4.19.235-cip70) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline-nfs: 8 runs, 1 regressions (v4.19.235-cip70)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.235-cip70/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.235-cip70
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91567a6adc2cb5217b6d7aabf7da3ac9ae6f1a79 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242d81a06bdf7f640ae0694

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220311.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6242d81b06bdf7f640ae06b5
        new failure (last pass: v4.19.229-cip67)

    2022-03-29T09:57:22.749317  <8>[   37.456083] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-03-29T09:57:23.773892  /lava-5968685/1/../bin/lava-test-case
    2022-03-29T09:57:23.800683  <8>[   38.507222] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B57C25B0C
	for <webhook@archiver.kernel.org>; Thu, 11 Aug 2022 14:57:30 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web08.7477.1660229842668488485
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 07:57:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=lyAUSbd1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id gj1so17941179pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=mCDP5IY5RVmRybE4W8FS6gGW6dNNCU15qEZBbVA/8hg=;
        b=lyAUSbd1Np3zFdIOmdNuf2jXmdazQSJ4ZZaYJKtMkGpL+eh/bYzkEjxHa450vBOd1Q
         CvmhZn8MVFKUyTbr40OmeqwzNybh6yUr8QoB91cyKa8ZIuXTQjLUPdv5fXiwkY17BN5h
         NP0b6NycwS3fnzy1Z2+4jy5zSsT29OaFOkqw7goJL2Mh1+q1rZ61Q+pSAlm+N2tcFux8
         5lExZN6fptMYiIiq4UgN5QxUoqCzIxzT80wxU3j+y8mwwPrmjz3s5vug32D/18STUEze
         AGdkmrI4GvOeLNvg5FfOT02vsWbA8AvhZFMhJH8hs3Omjaph04zsmCMe7RvjfYEQxR6Z
         5ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=mCDP5IY5RVmRybE4W8FS6gGW6dNNCU15qEZBbVA/8hg=;
        b=D0grF6ciSKz4TvCSoKRBKKA9A3ITuJKd/thznFJUc/YjJUsG/2/s7tfQC/hYkBUXeX
         ctdq1pfOJukLxtkgcnnfyKT/aSNqpNPEZ0nGGYerDEQTpcLidtYW90XSXLyZYY1zRMZm
         boeK5xzpllnW9QZdwe1TBILx2t/aiyNaq5sOePjg3x+2GXkHgMRM6lmRLhGqGmSTe55M
         DxTNyTkjLPt5TYl3U5zM5L0taK1PVpWvafYYPToVQnImQsHPWsgUARqgqHJE6RqnUBVb
         eRiBHnvwNlUSJ/X0ZuT2/j3WEY3dbSAjtBYR/2uKnjUuOXFFIRBX9miFnkeRv43xUhjT
         twFw==
X-Gm-Message-State: ACgBeo0Wdb3RuwG6N0V7E8U1B5DSZ1hnSKKT375ffJ/Z1G6uvpeZNT1Q
	RAKyIs0tn3l28Klb4pZV0A3SWkWBRkWAs2YSkcA=
X-Google-Smtp-Source: 
 AA6agR5kHUvs/yIGl4VU0nqkwfuOc5wSAYOejLVYP/si0FYiIiFBZSUqBPOvsN2i2HJKuCQsHdygTQ==
X-Received: by 2002:a17:90b:681:b0:1f2:147a:5e55 with SMTP id
 m1-20020a17090b068100b001f2147a5e55mr9212194pjz.159.1660229841977;
        Thu, 11 Aug 2022 07:57:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t13-20020a17090340cd00b0016dc6279ab8sm14816143pld.159.2022.08.11.07.57.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 07:57:18 -0700 (PDT)
Message-ID: <62f518ce.170a0220.3acaa.92c6@mx.google.com>
Date: Thu, 11 Aug 2022 07:57:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.252-cip78-146-g6acc38498265c
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 30 runs,
 1 regressions (v4.19.252-cip78-146-g6acc38498265c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Aug 2022 14:57:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9158

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 30 runs, 1 regress=
ions (v4.19.252-cip78-146-g6acc38498265c)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.252-cip78-146-g6acc38498265c/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.252-cip78-146-g6acc38498265c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6acc38498265c7429063eae4888e1bc9fd68ccd4 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/62f51230bc8f427319daf05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-146-g6acc38498265c/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-146-g6acc38498265c/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220805.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62f51230bc8f42731=
9daf060
        new failure (last pass: v4.19.231-cip68-123-g92e3e7f3d4df) =

 =20


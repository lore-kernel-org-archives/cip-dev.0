Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6231C433FE
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 08:49:12 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.959.1668329349940525947
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Nov 2022 00:49:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=GzYr6OYw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id b29so8456996pfp.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Nov 2022 00:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k28dF8kjY+kroLeBkIRfg4nraPb+dN8a+cGZcT5zzIg=;
        b=GzYr6OYwOZm6Yj9kVriivTvzNr0xe4+wgx+zzC7jaRaN9ZJFj3dXawkId9pcAdjngh
         9nWS9bL8MAI/7VbNzBU9qRftC+wIpD87047+s8Gv36oaN8b3/+3LzsWvSLaqPVvScDMV
         BS/I4AvFdxZvyJFMV9uPLOTwep3w4+NP7L8cL4w9/OOWrsi7VJllSdnILQxrWNoIhzTg
         bj2ZBj/qJfilvuZ3fwbkl3ZQrmndPuHDdy358S1fs6xJ8FQ+PlnYO/PZ987Pqe8DAsDH
         2x0T/xEC6rOH8UrGhFoN8VvD6nhMjtkBt1Tnyb3ZqFU0qSStL14enzWcuOHG3C68+lXg
         RuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k28dF8kjY+kroLeBkIRfg4nraPb+dN8a+cGZcT5zzIg=;
        b=JhbmXmFFUzDp7d0wD+l4+SK2RZgBJiKrkhTlLBsTudTrJjxlUYe5fH17KkxnkCNJ1I
         PqzeRhHjvKQFZlmr1Kjrw6ai7rkBS5IdZFyqW6C9wksaGNr+ihrp+iovR25HMdO37jF3
         5hsTcg7cMXkPMw/HWYoKkLE8274lhQB+qgaBzx/xXCKWwajGYc9bqLFJch/ae6dQ3LB2
         Gh1x6wsnE1J96vz1k0eUGE2OXMfsRSCTW/fefjyXLgE+VgVOxr+7S9PZdkE4wCR+T+U5
         pq+cgtZUtVMIO28WvUNYYVd9FwYV3y5h0haL19q/PjMIPqOY+DNJx1q4EOBnkZMsOUGj
         z7EA==
X-Gm-Message-State: ANoB5pmtmGCn3EwrHbZW4X2YURqw1WtP5ZxUvBHJlH2UEB3hTPvAhCaz
	zLW364kr2UhJuc45IEra/GC8mB+ZuhBlMjgkzz8=
X-Google-Smtp-Source: AA0mqf65b7NGPVyr/Sc3KtTkM8lYOr/5ArfadBg87D0+xKfY72Tk2+DJbyQjWVMxlTPKt8MlYRZ4vQ==
X-Received: by 2002:a62:e806:0:b0:563:8011:e9e4 with SMTP id c6-20020a62e806000000b005638011e9e4mr9586836pfi.76.1668329349210;
        Sun, 13 Nov 2022 00:49:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c27-20020aa7953b000000b00550724f8ea0sm4342227pfp.128.2022.11.13.00.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:49:08 -0800 (PST)
Message-ID: <6370af84.a70a0220.e7239.6140@mx.google.com>
Date: Sun, 13 Nov 2022 00:49:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.154-cip20
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 30 runs,
 1 regressions (v5.10.154-cip20)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Nov 2022 08:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10027

cip/linux-5.10.y-cip baseline-nfs: 30 runs, 1 regressions (v5.10.154-cip20)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.154-cip20/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.154-cip20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      efa0ded8f5c8a9e3835e4aea63caa6cffb0ccda8 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6370a68db1a93ec985e7db51

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6370a68db1a93ec985e7db73
        failing since 228 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-11-13T08:10:34.164127  /lava-7961931/1/../bin/lava-test-case
    2022-11-13T08:10:34.200833  <8>[   97.206221] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20


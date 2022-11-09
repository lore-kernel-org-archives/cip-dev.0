Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB5C4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 23:17:56 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web09.442.1668035872220983736
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 15:17:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ZQgiScVF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id 4so149784pli.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 15:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab6cwCcwtEw8ufvOIFl42uMDgws9LrivO9b42kbZlVE=;
        b=ZQgiScVFvZqwPc5fL8n2iCthTtW7HQa41HpWvzGRNv050qyE6XVWftE0V6ASfPn/qx
         l6c3frVMwrakei41G7VEOMqMppB3WQfE7JtKDDLcXKi6qqQcnX45ILFOQI3oei0RVppR
         aP136yiuXNSZndiDriHH8GkTNfVsdxZZE5aMKuDPifVvGMu7AnFKwglLy5xMsbzjO/Hj
         zIz8ZO6X6Vt+myxv2DsZ7mtpRG+VNXRp56syAFuIlcH/aWq86eli7+c6GGz8hWTNFtuA
         KYaXTURcJcgS+CwxwwlQqLYzq6PfRdDE9MPlhOCY8giq8kTmSUoQrHMt0Xux+KWTaPvv
         M6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab6cwCcwtEw8ufvOIFl42uMDgws9LrivO9b42kbZlVE=;
        b=H+bK8jPz83gRaVPaOGEQdBQAZJztwhXipOqOFoHa4Ju2/XnWPyqkyxuPcLnLIzBSQa
         ST2Gw6vztJ0FaXU/uaF6xc2M9b609wm+AEB4CmAgflwY0BHJZqZLsLj4lcwayUFO9pF/
         RxuNaPZD4qoSXwjKfjp9STmfSUJ4PoClnnU4zrOji47FjCx9a4F9kVJMGnyuDmSV5dn1
         3KPgjG4pN3G5u3xXaQ/phU7B1dUew/TkriY3DnMc6VVoPjDotsIMvICu2I8oEwe7zl+0
         gRPod3lNVAZvpgUohb2UkNDxY7I4DhRtXDFvRgtMEwennksFJITVfqkk3Ft/eaU58MQM
         LZ7Q==
X-Gm-Message-State: ACrzQf1/OErQUHPaNqZD30Xc+q/qAsPQSXxvuV0xHqxi0pAhDYqUP/bV
	DRgnHu9I0MXkkzuj42QXOjDKnnfYg2BoOZu3aoc=
X-Google-Smtp-Source: AMsMyM6RMWm4iNYwVame7VrO/vwrp0y6WisrYa9bVXVwT58+++aLE1i0nXLyLaTdU2yBYdyrw5wn1g==
X-Received: by 2002:a17:902:ef52:b0:17c:f072:95bc with SMTP id e18-20020a170902ef5200b0017cf07295bcmr62414242plx.28.1668035871406;
        Wed, 09 Nov 2022 15:17:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d1-20020a63f241000000b0043ae1797e2bsm7893721pgk.63.2022.11.09.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:17:51 -0800 (PST)
Message-ID: <636c351f.630a0220.df604.d885@mx.google.com>
Date: Wed, 09 Nov 2022 15:17:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-rt8
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt kselftest-filesystems: 4 runs,
 1 regressions (v5.10.153-cip19-rt8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 23:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9988

cip/linux-5.10.y-cip-rt kselftest-filesystems: 4 runs, 1 regressions (v5.10=
.153-cip19-rt8)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.153-cip19-rt8/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.153-cip19-rt8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4b5bf35ef58ec8f9f73fd6fec577de2f6710955f =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/636c263e7ade281487e7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/636c263e=
7ade281487e7db4f
        failing since 39 days (last pass: v5.10.109-cip5-rt4, first fail: v=
5.10.145-cip17-rt7) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556C9C3DA6E
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 13:41:05 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.6669.1704721258727125310
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 08 Jan 2024 05:40:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=BmkStEHQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d426ad4433so5518465ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 08 Jan 2024 05:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704721258; x=1705326058; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I57DPzclBGRrNZr9QBMUs171wCwbL69KS90T4Fq658c=;
        b=BmkStEHQwnjw3530xGNBJzFIOIejyJ5tylGqA6U1QsiBjJlVsXowyoZPwQVCbhk1zb
         d5qL/olxJjdIOgKiLk1catXcgGI4xqQUvEFReJM4IpIAmGDOOR8+2px5fJv+sh34yoMI
         1IjWMFBL5EBiHsma394dj73Q1+SdqoNIpIwuIkSNQJh5J1QHZvG+LrIv9tkJ0cp7E2GY
         l/KZVkKHBlkxPe9SFbbrrbAknMjWkLiCH6auxuh/7PyNA8+4VFHshVNUhSCqZb00e4MS
         A41wVsIGeLtUb8z4Rwr4fS9GYVFTM/ndZlwKOwVRC61v7GhDVn6Y+JdDOaEhK0UNG0Ft
         D5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721258; x=1705326058;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I57DPzclBGRrNZr9QBMUs171wCwbL69KS90T4Fq658c=;
        b=vXDf8buCacU/TJG1307oUpwgfMwzE5xeqZxLBGZHsEr/FIFfKqbEe7+efs6iIt1zOL
         dcJ0icaJvqHwTd/tbbIjc4hbTdzZKPx9B8wGv2kM3r2Yc0qSdmpmangNY7gsBSnjoGao
         3XmXtZnIFlsNYl0r89f29JkryICyM7C4T3w0DIHDKwdhP5GDd3veQ2/L3ZVqvApq8FPr
         O9CwMNCxc3phpd7OlAICR0pybdUZlz6yHFg+0Zfhalx9+FzVi+Zs8kHuAwsmuh/uje4Y
         QJLKFjSDBOlkw/l5E+WLxolCg2hotnUdsjlCmpImlHoSTCqK6TqHhTS09OpY4S8LYuIW
         M6kw==
X-Gm-Message-State: AOJu0YxvfXajjw1aTCLV2nDDHa3UVSImBn2KwJtGGNmQ0KqSsfdbiGpB
	CFZKVmgGNVPWedsovYrab/BDJfmVRhUbHKQyzWkq9bDAXzo=
X-Google-Smtp-Source: AGHT+IGwswQaLljOqXC2N2ZZ6wJTkldHJncMiL3JORzu+v58zFhKa3xF4bFi9p0utcGZrMSr5kfotQ==
X-Received: by 2002:a17:903:2342:b0:1d3:d0da:2551 with SMTP id c2-20020a170903234200b001d3d0da2551mr1574156plh.90.1704721257860;
        Mon, 08 Jan 2024 05:40:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902821100b001d4abf0a28csm6224845pln.132.2024.01.08.05.40.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:40:57 -0800 (PST)
Message-ID: <659bfb69.170a0220.6701a.dc6c@mx.google.com>
Date: Mon, 08 Jan 2024 05:40:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.299-cip105-289-gad0914f265af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 32 runs,
 1 regressions (v4.19.299-cip105-289-gad0914f265af)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 13:41:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14279

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 32 runs, 1 regress=
ions (v4.19.299-cip105-289-gad0914f265af)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-289-gad0914f265af/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.299-cip105-289-gad0914f265af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ad0914f265af139fd53d721f0db787b707de20ef =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/659bf856ee39d0048e52a3f1

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/659bf856ee39d0048e52a425
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342)

    2024-01-08T13:27:13.434273  + set +x
    2024-01-08T13:27:13.437162  <8>[   53.364329] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 435023_1.6.2.4.1>
    2024-01-08T13:27:13.554690  #
    2024-01-08T13:27:13.656469  / # #export SHELL=3D/bin/sh
    2024-01-08T13:27:13.656877  =

    2024-01-08T13:27:13.758013  / # export SHELL=3D/bin/sh. /lava-435023/en=
vironment
    2024-01-08T13:27:13.758418  =

    2024-01-08T13:27:13.859619  / # . /lava-435023/environment/lava-435023/=
bin/lava-test-runner /lava-435023/1
    2024-01-08T13:27:13.860174  =

    2024-01-08T13:27:13.863827  / # /lava-435023/bin/lava-test-runner /lava=
-435023/1 =

    ... (12 line(s) more)  =

 =20


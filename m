Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D5ECAAD1
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 05:49:11 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web08.8880.1662011345400288709
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 22:49:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=1JMdLD48;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id y29so12457491pfq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 22:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=7hxDOCjEf4o/hGt3e7farBXEmTjT3qVFP3zID5ZGbJA=;
        b=1JMdLD48f75GmyAk8wSNEuWShYn5UHQjOYyO0d+hScOHELavJjdM/4+ZmWwO5INBNY
         bbZUKJgeyup4B084lAvrcLrYSpaCEFTYDY4PogR63ldB7UVhmdDg9Uy9ZDd2y3CITXB7
         B3aJ73Ugyj2dFROB+WmBYQbJioDWX9e8I93j27W8asnskr+mEm+R+SB4z4eJwVln5ocL
         3Ncqqw8HfR7YxjX6pKwM7eq3ud9ym7GEyNt53siT5EjAPUVqZl8sgFINmIb10kS8PWrx
         VL7tJF5h466FwAkwVxKzmEAE0OA8IG4FIvurUCb8NJw/QI5FocqAAmfl2wZzoOlrTT1/
         r1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=7hxDOCjEf4o/hGt3e7farBXEmTjT3qVFP3zID5ZGbJA=;
        b=bThY7KF2Bqboersk0nLpct+8+u7/X5s/3c22ph9BKkg2Py6c6sOC+37FPF9FwdZJDA
         YTkuptg0Uak8baABV0wWJcwCJalX6Ug02cnElC6kuYd82nbdx9IUqvI8SZkl+FEx6Rfi
         LkI2ZgyQlrCr682FaPe3TRJu8cJy3Cu8pa5lxn18w/B0VnurMsuPwKnPO3eCPGESwwK6
         9avIROuzKi6IdCI50/hN4xan/Wo94jT2nq9dEvZHwghoS9ekNEwRpQRpOHAC1kk6yrIm
         gPnmE3PEFd1IRZeXdb8HAdYIbZkbvXEaRzM1S+HrwcaXqUC+Ne/KTCRnhsQI96L6xAZw
         c6GA==
X-Gm-Message-State: ACgBeo2PpnCQRg14UdbSrRYIIYBPhGMHnK3Yx6VydGUrGLwP1rBE1hxd
	5Ko+SqFBONTAhA839KixtSwTkGVOrwO6q6ueg+A=
X-Google-Smtp-Source: 
 AA6agR7x6TzIh9/dyvvWoR2PUvczkUQU17SUCwkM1la1QXBlZbQGFBahCNpMXzVVYBexP7g7HFvvyg==
X-Received: by 2002:a05:6a00:170c:b0:537:27b4:ebfe with SMTP id
 h12-20020a056a00170c00b0053727b4ebfemr29552562pfc.19.1662011344722;
        Wed, 31 Aug 2022 22:49:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x8-20020aa79ac8000000b00518285976cdsm12433377pfp.9.2022.08.31.22.49.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 22:49:04 -0700 (PDT)
Message-ID: <631047d0.a70a0220.1a4c1.6bc7@mx.google.com>
Date: Wed, 31 Aug 2022 22:49:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.256-cip80-1-g68250b8eafbe0
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 22 runs,
 1 regressions (v4.19.256-cip80-1-g68250b8eafbe0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 05:49:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9401

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 22 runs, 1 regress=
ions (v4.19.256-cip80-1-g68250b8eafbe0)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.256-cip80-1-g68250b8eafbe0/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.256-cip80-1-g68250b8eafbe0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      68250b8eafbe07c581320a9a33cdfd6217030bb8 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/631040c908dba5e157355669

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.256-cip80-1-g68250b8eafbe0/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.256-cip80-1-g68250b8eafbe0/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/631040c908dba5e15=
735566a
        failing since 20 days (last pass: v4.19.231-cip68-123-g92e3e7f3d4df=
, first fail: v4.19.252-cip78-146-g6acc38498265c) =

 =20


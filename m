Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E815CC3DA78
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 14:17:22 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.116530.1673705840908874131
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 Jan 2023 06:17:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OAttAshO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d15so26177308pls.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 Jan 2023 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PK0ZVIK7BNKQKpFhaEziwJ59TwCEZXj9NRKu0tShsO0=;
        b=OAttAshO8jcA8H37XKCoVVBT9ba46npyrbVlWKQtBv71p7RvuNulnHq2xrXRNr3q8Y
         9IYTdInWoOZ3u7uCoMBbvIc7WETIcqGRLbpYBe8+DELn//MaTU0yRKd+CYmvytZ7s4MF
         KXVyFrWY/oBNl9ZOg+wVo8m7HRSvRlqHSDXJVhFF+NWJTqnCVb2Ahs1w425hBpvBpnQz
         24118CCPDGnSuUiopodquHHUyZIE1t0lMD+94mzml7HDaaSi9V3SKbvcTfTKO9ty+VT/
         i13goWgXTkqB7xfQ/Wj0QgrV9t4KcEb8EcrTZZr4qJl6dnr5DDP3U4C3fcPqK3rGO2Tk
         rzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PK0ZVIK7BNKQKpFhaEziwJ59TwCEZXj9NRKu0tShsO0=;
        b=br4x1XXL4tTVe0mm3qj6KzMm+iefCEPdVRpwjVUJvHpexhWAO9oKtiNV3ZTrl1G55O
         lXiE6Ak8wMnIbMquWkJ2aqyyy+0CB4Rr7V2PU57x9D6ZhMNPbamiFNnU3GiVPnj+9Hl2
         XhLE5HO02Ip2yL0U+O2d4sUE5DA1SLDC4Qp4iviPONOxgJnylDBpUsVHP8CowkOlVcAS
         QzJXX/hHKwGKnfj5srOmeIeZVLmDTDxmZJTi54APxBOoKXQVD3IPFvs7Whk4pNZNitMY
         Uanx0y3UkCAh9tPbtVcesU//rTk1Gqe3ZlJCdquHe6hguXTiCOiejgNJdyFiJ+qNc5wT
         pRDg==
X-Gm-Message-State: AFqh2kraNpeK2lv2ljMY0rtrF/Vfnh9Q1esqqGjA82FAusaQY4OaD3GL
	6/jk41Q5mxFiPDbafYQCkXLFBdd2qfkPPlV1rasCig==
X-Google-Smtp-Source: AMrXdXvxaQeAwP0aFnYmzHwCHHcOjAwC2QNNPrFIcBBsq1XhxG3VOswg6u46tEUxlCDBeqST5kjmzw==
X-Received: by 2002:a05:6a20:7f96:b0:b6:8f0e:11fe with SMTP id d22-20020a056a207f9600b000b68f0e11femr8781476pzj.16.1673705840164;
        Sat, 14 Jan 2023 06:17:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ik9-20020a170902ab0900b00189743ed3b6sm16090906plb.64.2023.01.14.06.17.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 06:17:19 -0800 (PST)
Message-ID: <63c2b96f.170a0220.ea8cf.a340@mx.google.com>
Date: Sat, 14 Jan 2023 06:17:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24-788-g63c30712099cf
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 12 runs,
 1 regressions (v5.10.162-cip24-788-g63c30712099cf)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 14:17:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10365

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 12 runs, 1 regressions =
(v5.10.162-cip24-788-g63c30712099cf)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-788-g63c30712099cf/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-788-g63c30712099cf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      63c30712099cff890a9fa023533c2971e6a4f87e =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/63c2abcaf8ae67111f1d39e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm/omap2plus_defconfig/gcc=
-10/lab-cip/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm/omap2plus_defconfig/gcc=
-10/lab-cip/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/armhf/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63c2abcaf8ae67111f1d39=
e4
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20


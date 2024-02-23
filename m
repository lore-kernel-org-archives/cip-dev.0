Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786AEC5478C
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:22:27 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.9349.1708690946123991125
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:22:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=2VQkoRji;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7232dcb3eso4926755ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708690945; x=1709295745; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zSFwh32bBv4OJT7b8NPMi5PAp2yYYuwgxwBlLG3Rn3A=;
        b=2VQkoRji5Cd522S90W+dPT6uH3MNF/LFSjIUsvFrMezy3jpeudOaXAUrJEBj6bGEkU
         GfSaUr8eof+f/yr78RVKrw3BzzzuVZt2CxG5P7h5OeMCS/OAGOVVuZP/11cKn0emBn+H
         WdXEFlETi64kObZRVPwVbTFqUPIz8xKzI3/4Ax8XTtSr00la1/IDBuc9fSkWPwWK/h4Q
         fSqKylZLcxpPAOiW0rcRMdK6BxUdXQVt39OHwbuD1jCHj8rvgeYCr13p47ts21qp09LR
         lBNkoUoOjcuHtEmfcogbcwJe8gDOUpSOhO1cXRm/7zr7Tsr1gtH9ENMnRtwJOXPGBdAM
         3H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690945; x=1709295745;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSFwh32bBv4OJT7b8NPMi5PAp2yYYuwgxwBlLG3Rn3A=;
        b=m+Ngd2zqEvx/9fWrB4k6JQgMXfAl39fNIjB3FbEaN6+MmWmvEyEQyeKa3oURn2PJfh
         Tzhs84lUkkuQpiZg06yqA/VM7BUkyNwK8jJDZSfSCfSXkV1xBrIk/6g9Fp7uVBZESRje
         AKeUb0lvMLd08DFVD6H5GT8A/rJaggWf2KSbe9nAs5Zlu4Z82hbmtyd4/8DNbqvy20PH
         y8u63ilFRqQLChl66tS7eUdtJ94vzaPI7mYRt6jUZbwc6scxYg0pZsuKkWhz+RSZPNHP
         NFN465AV1J1kwj7ye5VvDx7tfMj7O5WQmhvL1FvNRhXj7r+PEkE1oOBzw48D+o5SCSrD
         k7kQ==
X-Gm-Message-State: AOJu0Yz75K8F/1KawuKaSTn73fGKiaGb1JIj13Lca+mQnb1sKnuGwq8P
	k9ViW98zfqVVNN/BpBftNCXippm07amUaBfNYQHcvcXCF5KA7i+iIkesZIOwERAVXWC1JdpJwxy
	s+Xk=
X-Google-Smtp-Source: AGHT+IFPTPW13arGD3tO3EKY7b9psKsLghnL3njVe0N8YeKr6cu9R1pakWn1UOr7u7OtOjyP9UMUxA==
X-Received: by 2002:a17:902:6bcb:b0:1d9:4ede:66b5 with SMTP id m11-20020a1709026bcb00b001d94ede66b5mr1455085plt.15.1708690945142;
        Fri, 23 Feb 2024 04:22:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id li8-20020a170903294800b001dc3c3be4a4sm4025877plb.304.2024.02.23.04.22.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:22:24 -0800 (PST)
Message-ID: <65d88e00.170a0220.edcfc.fd87@mx.google.com>
Date: Fri, 23 Feb 2024 04:22:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.306-cip107-201-gc2afc54e2d6bb
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 41 runs,
 1 regressions (v4.19.306-cip107-201-gc2afc54e2d6bb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:22:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15080

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 41 runs, 1 regress=
ions (v4.19.306-cip107-201-gc2afc54e2d6bb)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.306-cip107-201-gc2afc54e2d6bb/plan/baseli=
ne-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.306-cip107-201-gc2afc54e2d6bb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c2afc54e2d6bb0bb2a9214444545a17298928975 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65d87f4a541d86c223637012

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65d87f4a541d86c223637043
        new failure (last pass: v4.19.304-cip106-176-g770d0422c72e9)

    2024-02-23T11:19:06.516091  + set +x
    2024-02-23T11:19:06.520228  <8>[   51.373152] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 621556_1.6.2.4.1>
    2024-02-23T11:19:06.659773  #
    2024-02-23T11:19:06.761391  / # #export SHELL=3D/bin/sh
    2024-02-23T11:19:06.761684  =

    2024-02-23T11:19:06.862780  / # export SHELL=3D/bin/sh. /lava-621556/en=
vironment
    2024-02-23T11:19:06.863068  =

    2024-02-23T11:19:06.964191  / # . /lava-621556/environment/lava-621556/=
bin/lava-test-runner /lava-621556/1
    2024-02-23T11:19:06.964662  =

    2024-02-23T11:19:06.967979  / # /lava-621556/bin/lava-test-runner /lava=
-621556/1 =

    ... (12 line(s) more)  =

 =20


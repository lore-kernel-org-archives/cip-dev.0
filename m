Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7924FC4332F
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 11:50:08 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web09.4613.1664538595560118725
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:49:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=FKoaD3d9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id y136so4037626pfb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=99/YQlq2YtK1A7jK/ucKKgboa+YIC64ZvQ7G+VmMLxc=;
        b=FKoaD3d9z9EYtt62zgWu6czKm9HcqWyKKWFh+XRmZZUJKiAG64NvzscS2tfnk+3jU/
         tquQDhKpUz1TqjZMUNkcKpoNRfqCFebrCbYhg/hf1/f4RG00gLoUGFPfDHfowrYg2Myd
         Gqj8QYNCjGfXgVG4aqOqCg/xXMVoth8AXx6d6zmMaZCwEolqkgvGRkZkdZHvnq/szj4T
         3cfCskAfiEBkxTTLTYWnWrh8KDtV9I75PlpnTuJm5t6Uyyv8wi4MqDXrNFLuec8W+USc
         xul3wL51QmiVBQZTY1/WAPVdjhyDHAZ/BjjjfRvapJ1x6GM98D20ununmFYKTjxb5j/4
         sG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=99/YQlq2YtK1A7jK/ucKKgboa+YIC64ZvQ7G+VmMLxc=;
        b=zDXN8eGBVzEAkvXS2IPsEcQn3PxuGBAw7aYqg2zCuki3esdJy1fpA5ZHiCchVXMQsB
         1/mD3NPZnqe5OlrB5VGUpbxOn/SISKmCGAj5yUE04ZmfFpfCE3uv8BwAu7KQL+c1hla9
         qg7+JrVh0z/15vv0dwv63XPdQLvl1HHfrmeYwjlewmTlehLiEabPogPU1ShmDcc2egT1
         PVJ/++buyBua3785wrsVCQ1thA/kUckUi0JJUKJg/hMYp88lQIUP64gVeEZG34id6fQe
         +fsVOQsz7HQzqmjEA68+1oHxuOUwo78cu+rvKoHwZrRscCqD1Fku3iqk4yg7rxqTQAmK
         O0OQ==
X-Gm-Message-State: ACrzQf0Yrf18+K4i2C0rdvB6H/V00oB0gBge3Ve+zeoCGMBngWLlHRY3
	uv+dsjAMOgEpvAztZ/8ia/y4nZtJiw0WAbpPeqg=
X-Google-Smtp-Source: 
 AMsMyM5huLA2p0o4WmhrV/Y4YED3PbIh6X0aStoLOXJjVqJxOQHhRJk9JoSbMwGURFvE220QB/pYBA==
X-Received: by 2002:a05:6a00:acb:b0:555:ac02:433e with SMTP id
 c11-20020a056a000acb00b00555ac02433emr8754763pfl.3.1664538594419;
        Fri, 30 Sep 2022 04:49:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 f13-20020a170902ce8d00b00172f4835f60sm1729673plg.189.2022.09.30.04.49.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:49:54 -0700 (PDT)
Message-ID: <6336d7e2.170a0220.ca9c0.328d@mx.google.com>
Date: Fri, 30 Sep 2022 04:49:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-422-g411cd76b5afe8
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 10 runs,
 1 regressions (v5.10.145-cip17-422-g411cd76b5afe8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 11:50:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9584

cip-gitlab/ci/pavel/linux-test ltp-ipc: 10 runs, 1 regressions (v5.10.145-c=
ip17-422-g411cd76b5afe8)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-422-g411cd76b5afe8/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-422-g411cd76b5afe8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6336ce2c85386ab940ec4ea6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6336ce2c85386ab940ec4e=
a7
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20


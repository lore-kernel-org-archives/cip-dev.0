Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B514FC43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 05:05:35 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.81013.1656997530134680735
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 22:05:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=IGWH//J3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id ju17so5937635pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 22:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=v95vtBctf9NLdX8iuAAdTgeauvmKdyQPxD9H0PCl3SI=;
        b=IGWH//J3uMG1+OMryDN/bcEBW2sZQc15+XobN1fAYNjzTOzxHteHbDzmy8CCc/EVtZ
         TlFv+QUSjLRVJUfVGEZrs5HeKgLHYiFb2XloQpcxcJz6s16FH9YrXPmlumdZKU6K73Er
         e+cr6kEb3n6vzJhWsoUOnFko1ciGmvo5hsjevUTwFHIVT0iEmtLSrsXcBoM9hbZYSfHt
         hUvr7gIR6r9uxkTogKGZpMGi/O6z4sUBOQzpHLOMcfKwxLPC5G78tznLuATBX85LLc5y
         U75ra7EBauKrTuEri4fZzzLo62atUO7byHSl3YsHp1KPo65MnHa4/5xzXg1DEUDLLUgV
         LQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=v95vtBctf9NLdX8iuAAdTgeauvmKdyQPxD9H0PCl3SI=;
        b=rdowD4dW2oGo0Sd7QWPlRtxdQvf0SbjPSdLx7t6+h7CjpflbBwLxnZwh97KSSxTO1C
         eQU+ttl0Qp5bzxu15xLqCVUia3Yc1CYppzgXFRzUlYplQzqEllpMY11SdIh7PdoYqCLc
         KvCtj/AsdL7u/nmVTRIotvAKAjWKJbwD0+RCoUJvfn4NKL8IKnBW6YpF0NOaJCZXysRt
         kVflp5P4mt/pIfBXMQUvui+8crxAV+oSVv1QoVpYvq8cKr2RrwjRXbfhFJupubsuQauv
         Sri8/RdfH6ozFWqfey/HUURXrJaNOcokzzhK+by+PqRo2pSvqPVVtB9b67TINYCMuGrM
         y61Q==
X-Gm-Message-State: AJIora93jfyWsE0Y3WxgiI1QsH0CQMg/+P6Oh2Ko74SEE8LLYmkoHcdK
	vDgJijcEZ52Z80SFKXufw5RgwqjRK2NKDCEx
X-Google-Smtp-Source: 
 AGRyM1ueD1xG1BWR7M/Mn8rQ0n06oxQga9vrv9mn2lkDDUASvb4evK6LS5bcgQpDfFBeDy4XFsoWnw==
X-Received: by 2002:a17:903:18f:b0:16a:5c43:9a85 with SMTP id
 z15-20020a170903018f00b0016a5c439a85mr39832522plg.122.1656997529291;
        Mon, 04 Jul 2022 22:05:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z3-20020a170902ccc300b0016be368fb30sm3307138ple.212.2022.07.04.22.05.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 22:05:28 -0700 (PDT)
Message-ID: <62c3c698.1c69fb81.4e17.4b30@mx.google.com>
Date: Mon, 04 Jul 2022 22:05:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-1083-g94e3113365c2
X-Kernelci-Branch: ci/iwamatsu/linux-4.4.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.4.y-cip-rc baseline: 76 runs,
 4 regressions (v4.4.302-1083-g94e3113365c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 05:05:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8675

cip-gitlab/ci/iwamatsu/linux-4.4.y-cip-rc baseline: 76 runs, 4 regressions =
(v4.4.302-1083-g94e3113365c2)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig | 1    =
      =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.4.y-cip-rc/kernel/v4.4.302-1083-g94e3113365c2/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.4.y-cip-rc
  Describe: v4.4.302-1083-g94e3113365c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      94e3113365c2fd3bb6050308d809a5d12b4f042a =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/62c3b7ad620443d4aca39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1083-g94e3113365c2/arm64/defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1083-g94e3113365c2/arm64/defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c3b7ad620443d4aca39=
bd0
        new failure (last pass: v4.4.302-1082-g00b9de85d40e) =

 =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/62c3b897be27da01f1a39bd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1083-g94e3113365c2/arm64/defconfig/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1083-g94e3113365c2/arm64/defconfig/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c3b897be27da01f1a39=
bd1
        new failure (last pass: v4.4.302-1082-g00b9de85d40e) =

 =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/62c3b6fb2afccfb1e5a39bf6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1083-g94e3113365c2/arm64/defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1083-g94e3113365c2/arm64/defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c3b6fb2afccfb1e5a39=
bf7
        new failure (last pass: v4.4.302-1082-g00b9de85d40e) =

 =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/62c3b847684eed3a6ea39bfc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1083-g94e3113365c2/arm64/defconfig/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1083-g94e3113365c2/arm64/defconfig/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c3b847684eed3a6ea39=
bfd
        new failure (last pass: v4.4.302-1082-g00b9de85d40e) =

 =20


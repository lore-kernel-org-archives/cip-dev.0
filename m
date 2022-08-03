Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C72C19F2C
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 12:13:23 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web09.7740.1659528802764617917
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 05:13:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=tjxHlyqN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id z19so16232313plb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 05:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=isuVUv6t/M4sPmgYOZ02sUAtXMJx0zt+ZQ5D/wAulSQ=;
        b=tjxHlyqNtne7q3/iLPJDp8WHFso8sIRaqg3w4OZ/wODD58NXvw8AUBXYSwMc/AcnK4
         NCsRqh4/jsDk4aGLKHMjDqt0ghuzfRcAkY0xl6dFFkFzXmkYkGh/HRea1cldoSQfaAkS
         RmJ5HNvrXAZTKqIFKDWeMhq/G54DBm7rQ77j6KyBLBiu04yk0jecJZbxtDqZQcqfUCBu
         jxDo7jBgcja5gnxt4rfHzIacOb1S0prA4b5NbXQmuEgoqWuN2AuSyCD2eq8Kw2M+1ijU
         jr3j9oxr2ku6i9FSlMcsI/fuvNv1BPysStDAu6itI34glv1+rAcW6XbJ6SaSDTcXDCQ7
         RRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=isuVUv6t/M4sPmgYOZ02sUAtXMJx0zt+ZQ5D/wAulSQ=;
        b=1W6pcMt9KsKFI0xhTRoqmtEbpC1KBsPkrmgd7F6G+y4O8umbB3ABJqoPhgVof2vcnP
         D+5tGPApZZgBmqYSmphmHN3x4n9BL6mvbuxJPx9QFUWk6WGX0AdyncfGgrFWNB879/KA
         Lij94lIPWdtOdylV+VDIVvUVweex0IlzUak5MWIupOfCA+8OHzMJvsjEypJtB4zwwGzb
         3JS15PXQYuCC8HjHky0xhelpa1notOt3c8bcUAXkNOiV0tWYgBr0nSJSCDwrDzcyXCEW
         4qq9dibgX6ZOQmHXi9404RWDXYYEqaIn7aARmGKOwfmnNTqPX7fC7JrXLp+mzXgV/hvo
         3aEA==
X-Gm-Message-State: ACgBeo2gw6NUXUHTbgMvpg89dhw7sic9CL6s2gpe0Lli/KtRUVhEIQsT
	nUU2RQdyMS7QY28o/Szsc5adyPHSHdkSyx1XoHg=
X-Google-Smtp-Source: 
 AA6agR5H8stCJW4zdzmbfP1I7WZINAmMkzwNiaXuDbDMf4Al3qSRweKEHoRpZfxN2rEHwPZfd7Rm/w==
X-Received: by 2002:a17:90b:3842:b0:1f5:32be:8a1a with SMTP id
 nl2-20020a17090b384200b001f532be8a1amr4719897pjb.130.1659528801946;
        Wed, 03 Aug 2022 05:13:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 d2-20020a170903230200b0016c454598b5sm1796773plh.167.2022.08.03.05.13.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 05:13:21 -0700 (PDT)
Message-ID: <62ea6661.170a0220.9b91e.2cd3@mx.google.com>
Date: Wed, 03 Aug 2022 05:13:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-24-ga6f4ea41fe167
Subject: cip-gitlab/ci/pavel/linux-test smc: 13 runs,
 2 regressions (v5.10.131-cip13-24-ga6f4ea41fe167)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 12:13:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9044

cip-gitlab/ci/pavel/linux-test smc: 13 runs, 2 regressions (v5.10.131-cip13=
-24-ga6f4ea41fe167)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-24-ga6f4ea41fe167/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-24-ga6f4ea41fe167
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a6f4ea41fe167f956d4000eaf276a1e383603071 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea5a700c65b35c96daf071

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ea5a700c65b35c96daf072
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea564d2b42b15a58daf057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ea564d2b42b15a58daf058
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =20


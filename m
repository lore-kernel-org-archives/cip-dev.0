Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C1C38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 13:24:54 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.11504.1675171491213175409
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 05:24:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=T+sqKwTI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id h9so6445300plf.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 05:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5saiti18QMc6sSUZmUCAJv9IQx/ybqW8HA/NG26jiP0=;
        b=T+sqKwTI2iUeOx0AvPe3mHUer6W7teatNO+nabVUemaZYBvBF8cCp5mydYsxN7ORJ3
         LKdjLVq2ld18dqHHxFgY+Z+LgKdN4F2LL1UtEoVviV7VNjdOno41yISDbCg/xu33EBme
         WyDnRnbxBganK7vX3/iXSWlSQ8ipZLelBNYJvnOX5nuaZI6tJMDb5uzgG5Zd9Xcl4iRU
         PN2RtrUMxk1U4ZTIcjBkBPaZtTznBoJnpiTnVH6H5yRibku504e+edbJZXJKjqhdnsYt
         hia4yIvpp/WOMX/+k7ikJ5UAdmFYs3ZDPU5vHl6B+CLWugZCmzX+eaPf41zkYkXPqrzl
         voJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5saiti18QMc6sSUZmUCAJv9IQx/ybqW8HA/NG26jiP0=;
        b=a4UY8CrIPJmTyl5whwxHg+CeaV8x3AjqcLYuFp/YI2bhLTjQ1Bpe2xAO2kI+yGQGY/
         IiykJzheJ6hCvXZe+PpHGZ+17CuiWJBN5OSiKXF9rEv+dd8f+WFjy29dhnDtN0K3rrC7
         f3QaMDxXhgmNeU05T7W67UQLIvrX6VUMHcZbo/q4EhTPajvZoUiQcJfL6rK/ejCgknpQ
         Yd4HO/NEE6h7Xuu0zA1A9xq3u8Hyz4A5gMkVxFxTU/o4Mh2IZVLCUxMbiGgs7YzFtaO+
         UU52mx/muXHfBOToqw9NyRtHfEOk0BqAkQSvdY+LaozO9v5PjR82PoFRL+7JjWiLr5D2
         aJTg==
X-Gm-Message-State: AO0yUKXSzv+8fQZRQhfiO41PAYropZ4NRsTE4fSGCO9fBXuzZfnjugGI
	HTiqC+dr4SJ7gB8V2s0eHycARYBwCCNdRI2eyXmhZw==
X-Google-Smtp-Source: AK7set+ZHzK97PXsFw7Ko917xWQqigOlAUee4wvQPElhlywp6aiIHKUAAyUUsUmgwTrlkEPD6sTIkw==
X-Received: by 2002:a17:902:f1ca:b0:198:94cb:82a5 with SMTP id e10-20020a170902f1ca00b0019894cb82a5mr2821728plc.4.1675171490303;
        Tue, 31 Jan 2023 05:24:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709026a8c00b0019603cb63d4sm9727875plk.280.2023.01.31.05.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:24:50 -0800 (PST)
Message-ID: <63d916a2.170a0220.79e96.04dd@mx.google.com>
Date: Tue, 31 Jan 2023 05:24:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip72
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip ltp-ipc: 5 runs, 1 regressions (v4.4.302-cip72)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 13:24:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10531

cip/linux-4.4.y-cip ltp-ipc: 5 runs, 1 regressions (v4.4.302-cip72)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0af99ca381ce97af181eab7f6fc808b1e039ac3d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d9086cecf27309b8915ee0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc-as=
us-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc-as=
us-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63d9086cecf27309b8915e=
e1
        new failure (last pass: v4.4.302-cip71-590-g22fc523bf881) =

 =20


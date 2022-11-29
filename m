Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9D5C4167B
	for <webhook@archiver.kernel.org>; Tue, 29 Nov 2022 11:23:27 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.147065.1669720998321350610
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Nov 2022 03:23:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=aXvyruFK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id y4so13093064plb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Nov 2022 03:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PesR95In66o77kySaPoOSsnKlRCaRyXH4CipwKyWFuQ=;
        b=aXvyruFKz1mIJ99taMkN/dHYM7HHQ+ca5YmIU+FjZfNP48QKTi7mJEBrNzK1iIcFcF
         TlSCrLFaU1Huzx3l/3+ryophtfdNAgTqEAzXAIRVWgW18nSLCykV+LXMQOhD7c9cs7UQ
         p1CA/GwxCwU/kDwrDzWyVHGlQmheEp1sND7wM73VRmcf9R2pvlHwhiE36e+O6H3ohqtj
         G1QHu0zgv0mKNo9kK0LnJUy2BmpXuAkf3uelCiBQXVGa23zqX5e+vZLpqyZDWu3d8SDe
         rsvWUblTaJgFG5YUE6G01/+dUKNCg00kpfE5r4lQ7c+zdGM6VMBzE6tv0qH5Q8VkNizK
         MAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PesR95In66o77kySaPoOSsnKlRCaRyXH4CipwKyWFuQ=;
        b=8Bxl7WMRByhEVadJbYRLsBeGlxFRizM8yRvSHDMHU1khjyrlQ2GgzG3F3//mrQYcL9
         RhKkrFFtTXeDBErTui0e6RtTcoG3dMw/F5zT/0HXAgk0Mp0sByVZse4mzXcVnIUcgvts
         NYGqkkoiJojUQt5+PXU8jbQM7KkMIhQ3XTNkzYvEscNW2iXDqQhFICpOtCBJO0Xn6zMc
         cvtSoTlxS6wYcYHU/DgXB2n5FPO+osFy1pSVSvQVWrTmu//kk82edqrMAi8c9kDInkbN
         P4sCPne098xae78ZbsKLiPwVIIhqt2xeZtOzE+GbfWN9tSzoyPYfvhB+QibUZQQkDC28
         WH0w==
X-Gm-Message-State: ANoB5pnncTGTcs5jB1Rapq7K70EkDu1Uc66zZf3RyN1PrVKYCk0cWlij
	MDnp/5FRJpXyBNQ1wN82J7kLSty2mQYdZeDmio0=
X-Google-Smtp-Source: AA0mqf4uUNCmMdmjKWADOFPvtEGlBMQBBrh97jq0j+tIYHCxx0VV2YWaXh/q/nWL/q3hiwwrex9z2g==
X-Received: by 2002:a17:90a:d38c:b0:214:ba3:4eb1 with SMTP id q12-20020a17090ad38c00b002140ba34eb1mr66976263pju.161.1669720997340;
        Tue, 29 Nov 2022 03:23:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cv18-20020a17090afd1200b00212e5fe09d7sm1154832pjb.10.2022.11.29.03.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:23:16 -0800 (PST)
Message-ID: <6385eba4.170a0220.370c6.1dd4@mx.google.com>
Date: Tue, 29 Nov 2022 03:23:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4.302-cip71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Nov 2022 11:23:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10131

cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4.302-ci=
p71)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c727b8f0ca6857a9782a1ee857a57e4f563b34fe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  498247917f40b0a82cb149e2ec1cb518acd7b632 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6385e19a1fcc09aa1a2abd0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-fcntl-=
locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-fcntl-=
locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221125.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6385e19a1f=
cc09aa1a2abd0d
        failing since 6 days (last pass: v4.4.302-cip70-98-g7f7838c92740f, =
first fail: v4.4.302-cip70-236-g69445bc0d4209) =

 =20


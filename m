Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2877C7EE23
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 15:52:30 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.23511.1683129149116674171
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 08:52:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Y4dMld0o;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-24df758db1cso2803522a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683129148; x=1685721148;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0kobHanmcBwQrcxq7CinzaxYySW7cW7hbtDdIqNvMpI=;
        b=Y4dMld0oCSRorItQfDFtvv8QAxeYuYZzaP/yTTowBkmFC1fHx+C2Bn2HbyaYj4NhMG
         gpZ1PXF5g2ko2yOpYpJs5fFv4eW2Vq7C2rYWOOFv/s5x2vGNq4hHdEiCYh/wsF70LXpQ
         EN1gKCs9DniFLm6dLUvk8kie4JAnMY0OYF2QRu6mHGEZo6QpO3xnC9hwCSqeItb+R3iv
         8Brfa+SrVD8kQ6zD0ByoEWu6bK8URNr/rfh+FaEtr7kH+MLahUiaehP3sJIJW6xqHIVO
         KHILcUhN7Eh3S4QYPDojHYFo7irej92B06jvL/eRC9sMqLSxQHmvqJbCsrbE2BMgmFS7
         otSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683129148; x=1685721148;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kobHanmcBwQrcxq7CinzaxYySW7cW7hbtDdIqNvMpI=;
        b=FI2m4Cxwon2n0NT5yLoaESQgnjGmcOV/LfkrVaeazX2syEwc1Dj7KZnunT9WL0zXDH
         4Fc4VWOF3BaOxdtFTcdpQ8dx8f1WoT82vw2tl41Lz5/jbsP7LNcBWnfQi5aOwkYbKBP2
         G2r3ng1CmKmFyQr6pFjTz3mXQxwgcXzszg8WGOP+oVRPKkc3n3tS1PFpvlG6sDhfGpDM
         bg9Xd4p5d8LWXuQbXfDXjQ8ml2Es0aKI8BY3zEXBfQA/U+ZVNyso17woSI43nddZnlKf
         KeTk7cHeZLeEBddsvrDEjVA1pihUndCkU2wlFJaFE5kftwNGsIj7MbNbMDxe+Tm5BrK5
         pfpA==
X-Gm-Message-State: AC+VfDwJ1ssnTrqWsG3955Nhd4LhS4HWP8N+KYM52HYdDbtvmZV3jqle
	WJMw5xaRlTXteewyrc+L/18Zwk31sGq54ZPj/i5QOQ==
X-Google-Smtp-Source: ACHHUZ4Wujb/lYkniTKdlHbldQbyWgA8uFc2VjG4CEulpUhpnXc5c7bDmHpVbciNvnmc+j5santmNw==
X-Received: by 2002:a17:90b:3e8d:b0:23b:d506:226e with SMTP id rj13-20020a17090b3e8d00b0023bd506226emr21787623pjb.42.1683129148219;
        Wed, 03 May 2023 08:52:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a63c002000000b004fc1d91e695sm20404725pgg.79.2023.05.03.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:52:26 -0700 (PDT)
Message-ID: <6452833a.630a0220.6f7ec.9403@mx.google.com>
Date: Wed, 03 May 2023 08:52:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.302-cip72-372-ga3bc58e64f55
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip ltp-ipc: 7 runs,
 1 regressions (v4.4.302-cip72-372-ga3bc58e64f55)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 15:52:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11407

cip/linux-4.4.y-cip ltp-ipc: 7 runs, 1 regressions (v4.4.302-cip72-372-ga3b=
c58e64f55)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-372-ga3bc58e64f55/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-372-ga3bc58e64f55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a3bc58e64f55aa72a4c70a5e27ee369c025756dd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ec58cf9bfb5588e6f831ee55aa6b10ebd790a826 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645275e1765144d2422e8600

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230421.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/645275e1765144d2422e86=
01
        failing since 92 days (last pass: v4.4.302-cip71-590-g22fc523bf881,=
 first fail: v4.4.302-cip72) =

 =20


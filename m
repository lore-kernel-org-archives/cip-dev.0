Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B186C4708E
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 22:23:37 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.59381.1669933414665371781
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Dec 2022 14:23:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=U40KDcSW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so5073007pjt.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Dec 2022 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AosIQpiPDR+7nPkeJEWrh9lG4zuHpYIfhz3bs/8AgTA=;
        b=U40KDcSWHbVGw9qbELHDuxWjBKNY3ZYvUtqaXh8MgEy9ruYsjwvHIaJ1Rmh6/Pkfhd
         ALQ/vXxtMjXRP0RCSELU6wGbj2bryQMCFVDSIq725wc8AFL6w9cnrEbh5+9F14hVyCoE
         jIy632x5msRnsq/VsxUg69Tvk6+Phr90QxM/L/p1a2Hrs6PsdF7pg222lqJm/hDlMQd2
         cTGPxhOHgFofza9FyKXvax04EJcz+6PnPJzwsA4e+G7rkMjep29hXzjfsXXnMOZz20nv
         RexKEM6siGnojNcHmRs0ANUvNkRCgsO5oBHIKKwD5vl3tKkbgdJNqTupOTjdGGLSm6qZ
         PG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AosIQpiPDR+7nPkeJEWrh9lG4zuHpYIfhz3bs/8AgTA=;
        b=H7dIaRFeb2MNZGXq8SA3X7P+buWSqORATvd5nDCJx8sLVx9ws9w4TV9ToC3WIZwCxw
         +jc8vc291/oTKMVblYJ7HgbRZ2I+Lyzqu5sXsuuYyCz3GcP7YSZDO0gRDblEK8/U0vMa
         V6eRRKPCF0U/FzprhbwfnFPejn/qL8j1FDwvrBtVU9QR855N+DvL/bJyw9HY87xL5g8W
         G5XjCNK1REcc61iNJV/zA2TI3KiZXCLlZUowZx+pdqY4xsJIpAIDIGKapF0t5QvnTAwx
         aRcKaZTpanfPLTCXQtdgK9YP3hdJgBNasvaRvqoJ/IIcZ3ZB0I58uQNfHRF0uiGhG757
         uKgA==
X-Gm-Message-State: ANoB5pmyEpkuwbEz/IywOGvg3VsGccfbITQ4pJ4agZKnD/RCnxvP9ftK
	xMzXVFdQvK6rkAKbR+5ag+VaVwAUGu/7hDdmiho=
X-Google-Smtp-Source: AA0mqf7mnwF49a0me8m/h8VkokbG1oie92DX8wyxpPjZpVGDZcDeTmU4fpLHL7ETj0PjIsDfzPN7KA==
X-Received: by 2002:a17:902:d4cf:b0:186:80e7:1e1 with SMTP id o15-20020a170902d4cf00b0018680e701e1mr49624792plg.135.1669933413816;
        Thu, 01 Dec 2022 14:23:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c7-20020aa79527000000b00575a74d84dbsm3737070pfp.63.2022.12.01.14.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:23:33 -0800 (PST)
Message-ID: <63892965.a70a0220.c9693.772a@mx.google.com>
Date: Thu, 01 Dec 2022 14:23:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71-1-g61333eee4869
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-ipc: 6 runs,
 1 regressions (v4.4.302-cip71-1-g61333eee4869)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 22:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10158

cip/linux-4.4.y-cip ltp-ipc: 6 runs, 1 regressions (v4.4.302-cip71-1-g61333=
eee4869)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71-1-g61333eee4869/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71-1-g61333eee4869
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      61333eee4869050c46b5f75ae6d337998d39f2a0

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


  Details:     https://kernelci.org/test/plan/id/6389178add3c0990182abd47

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-1-g61333eee4869/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-1-g61333eee4869/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221125.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6389178add3c0990182abd=
48
        failing since 6 days (last pass: v4.4.302-cip70-98-g7f7838c92740, f=
irst fail: v4.4.302-cip70-236-g69445bc0d420) =

 =20


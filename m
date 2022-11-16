Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BB1C4332F
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 14:44:55 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web09.8026.1668609891649128837
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Nov 2022 06:44:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fnvIfkBH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id h193so16825238pgc.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Nov 2022 06:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tbyWsdtSFeod3WHHTWv2P4uQkLbXDMy8ESvy0UZqaUs=;
        b=fnvIfkBHZUbWyDy+VZz5n23vnSpYXwc723c9K2EmDerIt5uIYL6byJD4r0UQ6dFjG7
         6+1wigka2Ml9EZcpBmNGw9KUkDHizNLrXOvzj/2ZLwwClo2DsfXL9RATZKbxNOh0QoUa
         /MT0rhZJRr+9qAcCkkFQYRjbg+6+EuAW4oIqfjw8ArmPbE2AFDBdl0GwC+foOAAlG5Ed
         fJlwVQ+f/KgQRa242/LI4yq92+128oCT62tgH52yZc55TJbb/C1OtwdqWdNSDNGRPWD+
         kNt8cfHHCpFSaYOy398XBfiBu6WrXfIp+vS2eQlCm5AMNyBRdeEH+MSeNHoeZA8ZgCh4
         SGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbyWsdtSFeod3WHHTWv2P4uQkLbXDMy8ESvy0UZqaUs=;
        b=HJMgHRV7vOL5XuUz5Qo8L6r63WCIeF95FoeK86WrKhjizBFFFIAHGOT67UPrhScW+e
         BUOKQWPisbK7hekK4svVNTwfiklt8njyEjwNmpbh9ShoxQbJDv39sTBZsBTqfvuH8aRS
         4Ay0NwkONL1nJiJWq1TmCqLbPHXTiXhY7xuKGpLKMb57mA383/qJ5dHZxVS2UOcC6Y/I
         GPGcQPXjbVu33nr7rOwz9zoUv5XgPusJMpOW7kI3tWu1+sCkgupjzcmIA2YHOMLhdbWo
         laAtngG+lBIqDstIhbAnVAwW1JTYqN8DGn7LRiB7TwJL6yj79JKlYncJZywFYpjDiPPe
         lp5g==
X-Gm-Message-State: ANoB5pkzPzouWzPjtQLlJUbC0+PamyjC6k9ZpTO4neP0AKFZnGxbLFHM
	jojQWJPXj4XI8gc3YmNnmDBLgyu3hH0X7PtN0Qc=
X-Google-Smtp-Source: AA0mqf65R/ohepbRwxpn+DtMJMaA6WHJOZ582+bkfZAgDN8JZ7HwIXM94EfrEDk0BixF1eTBzj4Xzw==
X-Received: by 2002:a05:6a00:1d85:b0:56c:b1e6:83fa with SMTP id z5-20020a056a001d8500b0056cb1e683famr23499345pfw.63.1668609890712;
        Wed, 16 Nov 2022 06:44:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b00180cf894b67sm12282456plk.130.2022.11.16.06.44.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:44:50 -0800 (PST)
Message-ID: <6374f762.170a0220.3777c.224f@mx.google.com>
Date: Wed, 16 Nov 2022 06:44:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.154-cip20-99-g0e320e4d37e4
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs,
 1 regressions (v5.10.154-cip20-99-g0e320e4d37e4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 14:44:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10048

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs, 1 regre=
ssions (v5.10.154-cip20-99-g0e320e4d37e4)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.154-cip20-99-g0e320e4d37e4/plan/kselftest=
-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.154-cip20-99-g0e320e4d37e4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0e320e4d37e4f142f91e122ae645a9aea854c7a1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6374e2d015cfdfbcc42abd5a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005=
-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005=
-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6374e2d015cfdf=
bcc42abd5b
        new failure (last pass: v5.10.153-cip19-122-g149fbc7cd21d) =

 =20


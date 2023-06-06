Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22954C7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 15:21:50 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.1490.1686064903607979329
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 08:21:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=0XnNKzRh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-652a6cf1918so3019904b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686064903; x=1688656903;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t65MCEn+lYl4OAlWPYAcoEpEmW3/BTmGMaVI9EHm1Ws=;
        b=0XnNKzRhkkfJSoDFj8rF6CHKcDXiZYLvU4iis54CsuVjhzuVhNAj3FuokRLC3uSicl
         aSHC4TQxtlFvgXSiIwNg6ZLm669p33GUo2+364q17rXijgSeNCJMmhd0P9EUm+/RrJSg
         76FH/J8OMoTSAFNSBNwewCg0ERDZWKMoc34fpoKq7hN37drY1i0ydDNNhLzz2uC7zfzQ
         0YQITBPftj/eTfnB64ACPdGZKvg57usFHP+AcnXPG4nTWaUU3pib52c4VAnJBDx5yRL6
         MSXrl+Pe//P3wzHwq+9mXWcO3cLwSet0yoXLGMp5EjQd4LwMpqlRJJ20voS+JOx5f9ty
         lntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686064903; x=1688656903;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t65MCEn+lYl4OAlWPYAcoEpEmW3/BTmGMaVI9EHm1Ws=;
        b=P2YNJNhjyQlftkJbzOryBbIuNf00QbbXnCn3T2Ut3KuklytNU5+hSvsB1AzYneWo9t
         a1R35QSMcatae1KCGwaTRz4fSThyUYsBtxvEgc/9EHcUy3pO/7lFQ9qa5VFIaJqBesH+
         EqflxdhIuapMTGoAT9gsl3Mgm/Lbq3ckOjI2DKAwDYaX87mgdrHtTLc5W2G6w5uWN8Bw
         4KnhGRD8rd1MY46+5ca+XwgA+SDhH1FN2+4p0AQZmdL68UT96FH9+WmqRnBX2v1Ijlz4
         f3dI9pExikfYGf+HwRsbWkFJAnBgruJd8JEqwqFp1jSN1x7huFFsthlkMPIjEt4E0YLb
         TDgQ==
X-Gm-Message-State: AC+VfDynDb1foDKE8UMKT5fAfn9qPyyEqF4RYMO7KBZSsc8hJP0rugN6
	cWXIa9K7SfrKOqC4gVftN/+h6T2a5QGJKP/Qx+XK1g==
X-Google-Smtp-Source: ACHHUZ5cFjIYGYhn5aTjDL6NUQ0B2ge93IWC7EIBdC+VVIznvvN7AOYNSXNTYoCq5ia8sW/ehlvy0Q==
X-Received: by 2002:a05:6a00:b81:b0:643:96e:666b with SMTP id g1-20020a056a000b8100b00643096e666bmr1586838pfj.34.1686064902727;
        Tue, 06 Jun 2023 08:21:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a63f20f000000b0051b8172fa68sm7626247pgh.38.2023.06.06.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:21:42 -0700 (PDT)
Message-ID: <647f4f06.630a0220.df42b.e149@mx.google.com>
Date: Tue, 06 Jun 2023 08:21:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip72-495-ga0a97337aff8d
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-ipc: 7 runs,
 1 regressions (v4.4.302-cip72-495-ga0a97337aff8d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 15:21:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11897

cip/linux-4.4.y-cip ltp-ipc: 7 runs, 1 regressions (v4.4.302-cip72-495-ga0a=
97337aff8d)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-495-ga0a97337aff8d/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-495-ga0a97337aff8d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a0a97337aff8d76931b459e84792717c3bf6d6b4

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f3d3ca74e8f6d10f5de45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/647f3d3ca74e8f6d10f5de=
46
        failing since 126 days (last pass: v4.4.302-cip71-590-g22fc523bf881=
, first fail: v4.4.302-cip72) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC22C7EE26
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 02:11:26 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.11740.1684807882820020110
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 19:11:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=y26D4vCU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ae52ce3205so46799535ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 19:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684807882; x=1687399882;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TISd35arXbE1N9FNXoQgYaS9iLdQn1GMwoQEpzzWznA=;
        b=y26D4vCUqZfP2Ci7ymlQY5s+youVffMmDjFq2eXeQ4ctcjVZQogm6jTjpfVXcIrI5z
         O98vTyMwtL15cPePtB5trVTl/1Rhw7lP7eIi5cElZCyFqMLPUilSAA17t0haxp2U6N8M
         tQAYGlvHtojuH9Qq2iaW7BFaubpMG7sCN38COlEPfZ5E68QsrKR1CwqVNNwuekncK70g
         Ip3Z3LNFIBIRMrmp6+DswNEOO3ri4wyQpFbFE6j3iHA3oHQ5Jvhxf/0QWb2/fTjJT/mZ
         OTfkv1NYfwXERxqV5dGcOkFudlq4H4+Cy6nL2I6PrDyd7bTOGJ2cbN2lu2WWjzJakdCf
         7F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807882; x=1687399882;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TISd35arXbE1N9FNXoQgYaS9iLdQn1GMwoQEpzzWznA=;
        b=iuHM3OSLoalU44Doztn8BxhPRBFl8JgmnIF2DDLRd8BcGIfkwvnegqxjBbEg+kvhjr
         6bC49OP+UM9RNQEteRY/i31C0JGk4u8ZBSKFyd8HIS4h3gq2uzQF6SgchSejvHTx1Ynd
         T+WxdYE0WHN7tQ2ANL2z0cPnpCgyMNM+3C1ajwHp+bHNMGXmQNaH2PU9gPOidKaHnh0V
         636gRUaH/m/YTvrGEoZvfCvyAj6PIZPOa1xLob7l8uMA7UM99DzqZ0A9o+nC+scXEFWv
         wcbJeUFRKcpKmHWLWPZsCVOVa11mznxOrdVjN7d/bYDmExKJ7JeAdA4aSYbZ3vBZt7mG
         gzJw==
X-Gm-Message-State: AC+VfDxKxp9KnMRtR0SXxRAnMSMRaCTCQuSDEeZ5iJZbl4I/V2nx6l8M
	P8ijZBBZOzYEwYyZDqMJORV6wBdGhpYyMhyXe6BkCg==
X-Google-Smtp-Source: ACHHUZ7guSA6kDtguScaNWwBmttMa79X81dspiaqALYZGhf+NUsiUI/22dRCdPEntN9F2dPD4htYTQ==
X-Received: by 2002:a17:903:230b:b0:1af:b97c:2353 with SMTP id d11-20020a170903230b00b001afb97c2353mr5304766plh.15.1684807881821;
        Mon, 22 May 2023 19:11:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001aaed524541sm5451732plb.227.2023.05.22.19.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:11:21 -0700 (PDT)
Message-ID: <646c20c9.170a0220.e6442.9a34@mx.google.com>
Date: Mon, 22 May 2023 19:11:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt ltp-mm: 9 runs,
 1 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 02:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11607

cip/linux-4.19.y-cip-rt ltp-mm: 9 runs, 1 regressions (v4.19.280-cip95-rt30)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.280-cip95-rt30/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.280-cip95-rt30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/646c1578e5ffb63f4c2e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/646c1578e5ffb63f4c2e85fe
        new failure (last pass: v4.19.277-cip94-rt29) =

 =20


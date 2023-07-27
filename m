Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB57EC04A6A
	for <webhook@archiver.kernel.org>; Thu, 27 Jul 2023 12:16:29 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.5802.1690460184786856720
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Jul 2023 05:16:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=D5XxZDRX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bb8e45185bso5392165ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Jul 2023 05:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690460184; x=1691064984;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XA2UKPeM/MoPpqiRPQEvBBfrxADqd1AVfuDwgCSXics=;
        b=D5XxZDRXW5/3CeOOUiEAZgMBDwkc4OFSa0ArDocXiFA1PMqgPUFgoLM9BHvvmMkYDa
         zQIZxsynWUP7WNj4YkWLMcjbvpz/WBC63UZvhFbK4xb8rIxpOzdDLFiFS/GYWf4v8dv9
         WpFsPyQxcqI8YqccPximD88rwrtEurMd/C5Q2rb2BrjCOCcyva5gCruyFKIKR9APv7TM
         p+D2oLU4CQ0geW+TRPgyUNJG9XGIe/0cm2TYojbz5CX9lQpHmrpiLs58Y5f9eZ7/Vfyn
         E7uKWrvOGbTcJh76PV2xtHVtQuR+8k72ElrWmwCiOP+oFSs2E7y4X4dWEIK7ENEbL9w5
         9Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460184; x=1691064984;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XA2UKPeM/MoPpqiRPQEvBBfrxADqd1AVfuDwgCSXics=;
        b=SiAx1iuenRf17f/55snskdcfWV1I//I8I1IC5jl+xHPgjtxcMqOrzivhOdpQpYv8Xa
         JpCbC5q7Z3Oq36U+Yp0buZN9iBYAT5k6LGzeM5Uf7IaGxow8FgvsvI388eUcofiYSsPL
         YIMw6BIIpe91AQl0hvT6KUuAtWrpwAsJJ1wK5hqspaT7pcDB8pOYtRDKOiNC4yDkggnR
         Uke/5SDsJD88QsQP4OQXP+2gdwk2OOHfPGJ3fQpkVrOoRg1wRg7fforf+rU9lb7Y5Ram
         jkiUVpbYWi2MwR/ja0A+UkVh4PxYMAE2lNQU/9cTMhDevAWMCPNl4CD1X78ndD5ylF8G
         vzZg==
X-Gm-Message-State: ABy/qLZt7RC9HxJkNbkKPzf7gA3PmO61yaNX0QoTRbODHvO525jpV922
	te5gkFVZXeQ7UmNUA+5FHI3tqRcuMxXBWQDrm3sTwg==
X-Google-Smtp-Source: APBJJlENLiEOfguDzMihXkeZg7btyP5dWswaGJuCc8WI9vXAbw8OjWcWOrhX+ksNakh4rvZhblVSYg==
X-Received: by 2002:a17:903:18c:b0:1bb:79b4:d45e with SMTP id z12-20020a170903018c00b001bb79b4d45emr4628206plg.69.1690460183657;
        Thu, 27 Jul 2023 05:16:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001ab39cd875csm1487923plb.133.2023.07.27.05.16.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:16:23 -0700 (PDT)
Message-ID: <64c26017.170a0220.a473c.2400@mx.google.com>
Date: Thu, 27 Jul 2023 05:16:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.186-cip37-526-g7640d76efb649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 1
 runs, 1 regressions (v5.10.186-cip37-526-g7640d76efb649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jul 2023 12:16:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12513

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 1 runs, 1=
 regressions (v5.10.186-cip37-526-g7640d76efb649)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-526-g7640d76efb649/plan/kselfte=
st-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-526-g7640d76efb649
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7640d76efb649f3c7f8a243e5a966ef7bd8bda13 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24cd618fc53b82f8ace2e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hat=
ch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hat=
ch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64c24cd6=
18fc53b82f8ace2f
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =20


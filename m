Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA9FC7EE33
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 08:06:42 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.45180.1685347597217541880
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 29 May 2023 01:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=S8Arx4kK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5341737d7aeso2667734a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 29 May 2023 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685347596; x=1687939596;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ATRnTiUzVw9aZJT8gyzzXXdDWJsio82oQP6kfhHHy1s=;
        b=S8Arx4kKUyvpE7nfndUXyyGKn/5+1aPeCFFSCYREPC0HDLeyl7ieBX+X4afg3Li5pb
         ClqWLEhk4qkRM5XIC4v+qgpeU5sJ8Zf3fKAvSdSiA144/JM3XJ9Yfm79otxsL9JIpGoG
         OpH4uVrVTdO2pctIzAfOuo5a98lXI3Da7jGJvmOHx94p1vicL5rYUGRVGwQjXQJ7j6OX
         sXULWGyAEntnnTU8/wkpgn9IZBNrv0KMofBCEPo4XugqoMpyuRZ8WAgNyuNSxaGBXmGt
         l4fOgwUR8+TPe0v9dENMD5AP62yPKB8U/hXuhcw5vAWJT+E/FhxDUhCXiZzEstU5Pq+9
         vYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347596; x=1687939596;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATRnTiUzVw9aZJT8gyzzXXdDWJsio82oQP6kfhHHy1s=;
        b=IiGMjrI9Y+2dwHEG719+kiybkh5K4nBS/NPeLCtEo8OfKX6ooY7fCQ/sfz59B8uFte
         Bqtx2INEYTZyNO3nkAw6/g7dXO3OSqg8Ou55HGgE0lc5uH3Q3X6Qz45M15YJw1P/CWbB
         FtYykG2NPOncjJQ6If4UkYZ5U8A/YypYTjDiTpoQjUO+VE6pGDUcU28EWLUn7KSSBqYm
         DCnA+GjkDwF/M2RWGvWufGBzuJO+HdN4AejRGaRy0C1P2OhmV0/wLaJluJWXmQFnhGxC
         cgw5nCAnKCNSsowY+6CqMVDQhmyXprWbYktBevOaYT+AfPca/IUnbpJLFRnYgH4aORcX
         yNOw==
X-Gm-Message-State: AC+VfDwJa4FayPVJyNEtR2xsch8uNgjYLDn2dom8lHikiBUAP/09XEFH
	6fRT4r3W8Dtnx+YWJwlb9JCi6VMBq4qOvCM6ALLcMw==
X-Google-Smtp-Source: ACHHUZ60fh/Js/AixQGsl0INrRxCcDVkEBUemVAx54c3fhzdZXJVlLcqCoGS3Wcq20YlEDmLyqZKHw==
X-Received: by 2002:a17:90a:748b:b0:255:8a12:241b with SMTP id p11-20020a17090a748b00b002558a12241bmr8708059pjk.22.1685347596299;
        Mon, 29 May 2023 01:06:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ch9-20020a17090af40900b002555689006esm3681627pjb.47.2023.05.29.01.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:06:35 -0700 (PDT)
Message-ID: <64745d0b.170a0220.a438b.6a58@mx.google.com>
Date: Mon, 29 May 2023 01:06:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip34
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 1 regressions (v5.10.180-cip34)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 08:06:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11688

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 1 regressions (v5.10.180-cip34)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      aa80091745d6b40c944d419c12ba8cb65b1a57a5 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64745c01ec12349ca42e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-gxl=
-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-gxl=
-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230519.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64745c01ec12349c=
a42e85e7
        new failure (last pass: v5.10.180-cip33-21-g8eb0cdf459a2) =

 =20


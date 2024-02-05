Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64092C4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 18:21:28 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.1293.1707157278898135359
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 10:21:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Wc1AeLZt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29080973530so3858657a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 10:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707157278; x=1707762078; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=huYh7gk0UvOMWaVZoBHL+idkuQ9G1TDoWDWCuu0Z3EI=;
        b=Wc1AeLZthxmZ1eTr/NzOijJuwvJom664EfWewYps0zryy6IiZuTv7OP7/hjTGSCVId
         PsdZjG/uI2tNr4cbmIyaoctZF4a6m7c7HTaENNBx2Nycbi7ibr9if8ErzD0c13IaF9q1
         hnU8f865ggrknn40hCNjrd5gSSnHjwjRFI3t9i7CIjV53Yk2XZPTXl542WGD4W9Hg+l6
         vTk7dNgsp1gcvDTSVFfB8H5h9KrSZe8gH3ib0KcLzn/29ND8fKS6ceUViI1zF7Mrz8P4
         4UFqJ6WqLzlyrn7eyYIwKcd7WS8JrNyxXtxz2GFvhj4t6nv7u0FmsuXALe7gf32zjHSL
         oCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157278; x=1707762078;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huYh7gk0UvOMWaVZoBHL+idkuQ9G1TDoWDWCuu0Z3EI=;
        b=VgvUHnfGxPTKgpCFwKzrZlZMksAAz2bZubNcY2Civv20TZfBOe2nIsNiOHndV2g4ve
         nK7E5IYdqTsTQvpudtsMwUtnLAZ+8SOAcxYIAiwmvO9uUQRtO90X6zUT5/qQeS1x2xI6
         uvaS7MK0b2OdwKtxLJ8MFYrtdrrLcDVftLgG5r0iRZIjJBsh1WnETtM5wqc2v44QJ7vB
         GQU0CJmBS9QUE3Ue9dJeb/mgbj6XV8rp9kEuy0qZASdUYEhU+SXaQEkqjNlc0uO8WYfL
         /tm33+htDCnm9wnljYDykAoWyQHlJ23DYkhqdCKl9odxBEeNczy8rU5oZQOGjMxbFRCG
         B87Q==
X-Gm-Message-State: AOJu0YzaNeCVTBd/yMcfNW0Lzv5UqwG+RwDjrJ2NeYyMp2tTedAnFFJQ
	81yVDHMYxM8gDlRffY2rq8vn3/RmWL4TpdngnT1OyGAcwcJNv5Gz5CXsDVIIwJzMbIzbOUrfjXS
	w
X-Google-Smtp-Source: AGHT+IGUq5g2zT4PG6bCZ7oWhYV6MkCYqsU6SGLLvPaURYlY5rjYOLFiIlo9mKXMmQZGybDk8lyb6Q==
X-Received: by 2002:a17:90a:f018:b0:295:b2e5:f907 with SMTP id bt24-20020a17090af01800b00295b2e5f907mr264266pjb.4.1707157277620;
        Mon, 05 Feb 2024 10:21:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU0I9yZ822N3YT9h7zwABN2ydxrBu4j8y0O+N+r04wyyOpSqT9p9jDy3PuCzKAl4jXWl1vJpMK2vARjolS4D5gagOzlGmKfI6Aw03fizT1UKLoUD6iVkNuMGfaVkfRT1wqkG9aLEEld9YCigDbXQ/M6Mw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090abe0f00b0029659674bbesm285280pjs.43.2024.02.05.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:21:17 -0800 (PST)
Message-ID: <65c1271d.170a0220.7eed.20f6@mx.google.com>
Date: Mon, 05 Feb 2024 10:21:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 2 runs,
 1 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 18:21:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14746

cip/linux-5.10.y-cip kselftest-lkdtm: 2 runs, 1 regressions (v5.10.209-cip4=
4)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fa4c25ee66abaa707e8d165c790bb96e883cca4 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1152aead548d3ca00a03a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65c1152aead548=
d3ca00a03b
        failing since 124 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20


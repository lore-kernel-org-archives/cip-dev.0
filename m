Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793B2C4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 23:41:07 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web10.8586.1707262866787212526
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 15:41:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vi9DgWgm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.180, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bd884146e9so77495b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 15:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707262865; x=1707867665; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BM9oOmZkA/6k/IrWLHJC8t0igI5Tgddh39Q4HZholfU=;
        b=vi9DgWgmeRaY6H+CqEZ77uM94xcDKHAvRclhT3TSBrIwTKnKWfBDVfedxS6z1M3ZlS
         MXgQJoTTN7VtVp6iSi7yIQPg09iVJadc6NybTxZcxN+NeoP0NuY1rFDI4+qkaXDjkVUh
         zMGC2iEopNjrv/SVTDcTNGVNuo2aLM6HMQFxDSLp0llg6XTYDsOghEyJCm8ZNFu3Aed3
         N3lLoXJEj63MwVXE+HxlTxOaGBpTTG2mr6hHkZTFstU7F9D80BVLTkPJMcZmFKGzw9PT
         t0RigH2HaXUfcb6T01UmzPtk8GeA1bT+cKnHdH9WL61JiPDtc4a18EUQqCF3BXtLnMlK
         ta/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707262865; x=1707867665;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BM9oOmZkA/6k/IrWLHJC8t0igI5Tgddh39Q4HZholfU=;
        b=Nd1Ki5x/1+5FA+z6DEskvsPG6ywBbV6misLCZkPkg+4oPaDxFrSCr/nyUJ6uHEB2TJ
         pRrmRiZLIr4CCnk4V3oHpIqpUD/bA0DMneHHOrjLKWsLOc/+gO/hkXff3J3qjRQ+wwwK
         7uE4W2SbGkvMLWmVMahP7lbQUasfd0auSm+BJzx9cbPxRGZrb39Z9ICEBlByCIgZg5iP
         84luSrbVv/GA5u5EBE29vDiKfUhfwU1pKVD06uD9wHaW1cuFqeMBaY/YeviA9vmTsZk0
         Hd0QifmZwBQ5gSGZJxbFuMMP9Mpk9IHDBeBh59Zu++Nny5EW1DXpSnV+DnTFUIKdaDto
         NZsA==
X-Gm-Message-State: AOJu0Yyx0KDtn+RAdxU3Cc7hm8VWPD4Rpc5rJKZYlSRjAWifKaa+w24t
	kjWFBZvZglDtSxJryjVXrmEutTsv2oKBlSyIQ6kbbObf0/kw1wSVIEKkgSGRcXKXXsAOyfbD+xV
	a
X-Google-Smtp-Source: AGHT+IGVbpFLsjQK2s6rQgODL83UjSjhR5K5dVujq4cqlRqqXH2C9OLwgqIhDxcDE74smBpW9jTZJg==
X-Received: by 2002:a05:6359:4585:b0:178:6ea7:6fef with SMTP id no5-20020a056359458500b001786ea76fefmr1127592rwb.8.1707262865253;
        Tue, 06 Feb 2024 15:41:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcuceCZyEqR+FzZnGk6vyJme3dn/UwTocFrQhPo5/p5D9kzsEV1M2p7GIIWblcWNchaP7buGKyN4WIyCPxH6bjZ9n8sihCTwNlcqqKaycehSakY3IDg2Op80vZnxro98kxWE+MJgk0R6aZRuraayxleg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p20-20020aa78614000000b006dfdb672a93sm59438pfn.20.2024.02.06.15.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:41:04 -0800 (PST)
Message-ID: <65c2c390.a70a0220.7109a.03ea@mx.google.com>
Date: Tue, 06 Feb 2024 15:41:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.304-cip106-2-g5723c66be3b0
Subject: cip/linux-4.19.y-cip ltp-mm: 5 runs,
 1 regressions (v4.19.304-cip106-2-g5723c66be3b0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 23:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14844

cip/linux-4.19.y-cip ltp-mm: 5 runs, 1 regressions (v4.19.304-cip106-2-g572=
3c66be3b0)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106-2-g5723c66be3b0/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106-2-g5723c66be3b0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5723c66be3b09629fae4fec9711e11f0d020e81a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2bed2b4c658f41f8e1ef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c2bed3b4c658f41f8e1efa
        failing since 752 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7172CD80B7
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 11:37:17 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.89166.1696937829371935211
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 04:37:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pkRMQhlg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2777a5e22b5so4422092a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696937828; x=1697542628; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N581fUGlMqYe11SBcu01V9TZCv+WbN5KCmBuKKYTcGU=;
        b=pkRMQhlgzXcyUGslS5cs63GdYIIXz+L6LNVOcjp2r59tlIcIifWpGfvBZHaKgkG4ZN
         lV/UU64dZjowG7sxwDTkitrnYIZNPZDRokMaSw0m3vYp11D4WOa0ySYPFk16O3OfSV7b
         17NB6/orUgHXz1PR+O8jQTlFgNMXQf+w40CkuSlkHJ7dJDQmC3SJ7LawVZMA9+ukr0tP
         qX6yq6FBj5hQm1cCe0ULF5lF52YlYe7r7sdKGbFdRZnEt/PQCo5sqtIptYd036Nk0pS6
         vWHDQWXj2g5LfHgR4IDOdICY9WgPR+4qTlLGhIjyuLdOsduZUsEeg4lnRWL30dBsoOkr
         r+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696937828; x=1697542628;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N581fUGlMqYe11SBcu01V9TZCv+WbN5KCmBuKKYTcGU=;
        b=N88AyweFmGoSO4UD4uEDBBD6Sg3jfYV4HjoE9lTUKOhmbnYT/8P5w4wqwPdzSFXlCn
         LdQp7k4v/U5CLu8qKhOUBxIrvCrG7T2o3WFbAH8RJYCrmfqJhGTmMOFHgJUoWy2/jPAw
         cSGoE9AZPOdpO98/5JUCedt4To8BMLxEjKzc40jNZVddKGi9sZHMTldo636EpKSjni65
         AD/V+u3Bz+rJJaIxHDIbBX97W+KlGnv6JgNzYCp6ULSs7DvmhyVYsyAUflWfKlAahsV5
         9GvlywVFOyNQSYgduRYRowTVsDl0y1DHal6mho4Shgge/q8xl6rmWgWcmHaw8JNit7t9
         GKVA==
X-Gm-Message-State: AOJu0YxrZVJ1LMFw2LU7odnsxOgZvobkmUVqvVPd2z/UaTpKCzytQ9Qj
	f5jvC0b5xXmsgSSr7xonRPId7kzgplnOWfeM30vVNA==
X-Google-Smtp-Source: AGHT+IFA7AhVQJHmwbAYsIzOpf9xX9wL69puHD0tr2mqbuNI41Z1plbf960SAIuMTl6SN7HS6Qkrng==
X-Received: by 2002:a17:90b:4a91:b0:274:729c:e4f with SMTP id lp17-20020a17090b4a9100b00274729c0e4fmr16773130pjb.15.1696937828272;
        Tue, 10 Oct 2023 04:37:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a804a00b00263b9e75aecsm9743720pjw.41.2023.10.10.04.37.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:37:04 -0700 (PDT)
Message-ID: <65253760.170a0220.2faf1.8dda@mx.google.com>
Date: Tue, 10 Oct 2023 04:37:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-552-gc89b2c57483f0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs,
 1 regressions (v5.10.194-cip39-552-gc89b2c57483f0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 11:37:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13358

cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs, 1 regressions (v5.10.194-cip=
39-552-gc89b2c57483f0)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-552-gc89b2c57483f0/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-552-gc89b2c57483f0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c89b2c57483f0aae7f9cb377230347592eb3520f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525294047d51a1db4efcf0a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6525294047d51a1db4efcf0b
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20


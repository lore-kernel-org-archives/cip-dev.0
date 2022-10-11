Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5F6C43219
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 15:02:41 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.8557.1665500558876257356
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=WzQH7MGZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id r18so12983500pgr.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g0nYihsUxtxfiGoZZz7PMM/Cvnlj3VQsIoeiIIE+xbw=;
        b=WzQH7MGZF5rXPhIpDlNrXjD6afnIIE31MKAbjR6Sm7RUZJZWRjF4VOO/3uTHYo5Rz2
         DyS/mjoatOFGN7BLxGyutsgrxG7B78rYI/WWMycITsOTPYjjGaxOcS47F29dYDw3rLyG
         z1aAcwT8u4W3PsQs9ykJIBcieVndv1nmCd30Jusu4//apeDf2mlpoqYq2VyWW8H+NRY+
         z9gP6S6pyJCpUFRYfHe7ccTkjfGiQIyvgG6auPtRmqw5bIhf0d7xQJv6mRtI+7vf+Exu
         OS/aGqilRx0i+q3c4DdNRpVnAODI8+lv5wt+bZ545gszH0VHT5oYT/E5A80dRrbvPzmz
         IQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0nYihsUxtxfiGoZZz7PMM/Cvnlj3VQsIoeiIIE+xbw=;
        b=Py1hCq9ddXzFfb67SRi+qDC47XZPX9yAVPl/fLTe9aXNF6bVIsbIbjC62VF/KhMXdL
         peTAjq8jtLaRXHWxgwzbRvuuNs5dDlq8CDRG1zb+kc9hv3k50nP7kPqeS2+0nQoflyl9
         btm8TN85QmGbogVQu66Upyb3IB5Hq18hJAIgZnCDCijP/bAQ1kYgxRuUwlzAZLWr8UdX
         Q3RyhGU/00UKUSFguU9wILQfTgiohuUQf5InFd3niYUXdGPIBUi/XN0dl32D+PCb1WoE
         hZEgEHKDjCcOCILddy1LWMm5BJGsZFxxHRBdWjbuEcsf7bq3nrwwPeF6xITUK0kDv/Aj
         zVzw==
X-Gm-Message-State: ACrzQf1qpsKN0xDBRB2LCDq8htqt49ZH3aP+R2B/fo8LJFKcua8mt8yi
	tO+KMsGZ5rxSHiwpkqnmaOISSi0JTMAwaiVsUcM=
X-Google-Smtp-Source: 
 AMsMyM5ChQdDpztshK/LuirGDfMZxeoROtiG747rhqvZd78eiI6hjQHyGDz+paeYqohg0kuWmxp5vg==
X-Received: by 2002:a65:4c0c:0:b0:45f:f12d:f46f with SMTP id
 u12-20020a654c0c000000b0045ff12df46fmr16312530pgq.579.1665500558220;
        Tue, 11 Oct 2022 08:02:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x66-20020a623145000000b005360da6b26bsm9053862pfx.159.2022.10.11.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:02:37 -0700 (PDT)
Message-ID: <6345858d.620a0220.f6201.f9e3@mx.google.com>
Date: Tue, 11 Oct 2022 08:02:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.145-cip17-1-ge85493c8cea0
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 11 runs,
 1 regressions (v5.10.145-cip17-1-ge85493c8cea0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 15:02:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9728

cip/linux-5.10.y-cip ltp-timers: 11 runs, 1 regressions (v5.10.145-cip17-1-=
ge85493c8cea0)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17-1-ge85493c8cea0/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17-1-ge85493c8cea0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e85493c8cea0c5b53ef511efe088b0749b4d5aa0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63457fcad5b068bee6cab5ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63457fcad5b068bee6c=
ab5ed
        new failure (last pass: v5.10.145-cip17) =

 =20


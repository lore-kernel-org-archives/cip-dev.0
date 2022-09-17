Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972DCECAAD3
	for <webhook@archiver.kernel.org>; Sat, 17 Sep 2022 16:45:35 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.394.1663433132024174825
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Ra6puzpy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id iw17so24267241plb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ZLEWa4pP69sbouHJbnRGI1N0RU81AcbL5W3rDtGS35I=;
        b=Ra6puzpy5fcxGB1rn8YHq/jmRBCWyVdo6bVuEZD9ikPVsgoscpIbG+a/ea9XLlUMyo
         ORCCYwpZN4P9ZAuUBSpQIV+0h0zyOGlCQ9ONEb4aLjQ6gIWX6oF1A0/hjg0NGxrC4NYr
         jKQx+CSUBdEdVyhu7KsB86p5Y1vgTHvJxvLkFuT1dPVlvaeFiLoX/LQ+1AQHoCZio08z
         ehYbSEyDiI8B63/Av5s0ge3BtwRmYHysSmeilITyyn0ueZ5Gqs/km2LRqznf9Cte6kBZ
         OqIboSmpL/rOcjn0KrrkwHYTHp1mD/WqP2FS9rH4fkAd4yDIWIYZRE0cww8/keWugZqB
         QPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ZLEWa4pP69sbouHJbnRGI1N0RU81AcbL5W3rDtGS35I=;
        b=N15ueb9uHo45z/00uFTrTn3PvS0v7up5hUYj6kxHjS1Y6b/WhDpSIvogQW8hALxAFe
         eXy3SRmS/gAb47cOmsM0HRPJHdz/Oo+M14tMG8IF+qAhf1eH3JkTrU3y3ox5587Vsgum
         BnOlV1Z+VTNLoRyIkrBUO8QLpuWkwRa+9Z5fun597sQESV8ota4kr7XMgn36iI+VXxzV
         Y4QonsvMgH+2aNu8wOxlgq0itIoEX+aix8RNx39kjiOyVVIn3RQOZdPnvlwiikb3i7Y+
         Fzytbd2D5iaa/E847Qusb1YF6ygLmFMJjm3KoOL/J4kn9CjKW5g76H7dVFLWDS8aXsrC
         Zf8A==
X-Gm-Message-State: ACrzQf2fCy7+jidvWmgWqmvcYYvP/YGUOsKfgJ+o70hSSYveoxAbzITQ
	Ajvt+K+s1VQswEekluhR0ZYpE07M5tl8wM6/Xyg=
X-Google-Smtp-Source: 
 AMsMyM5m/peIUSlZ3GABRNWBYJx3LYzblx6HsVC8VxJlRXSv4bjtQm9zFGKXUOmxmsCmZfPcrNK5Gg==
X-Received: by 2002:a17:90b:4f4b:b0:200:862e:8b19 with SMTP id
 pj11-20020a17090b4f4b00b00200862e8b19mr10909702pjb.214.1663433131249;
        Sat, 17 Sep 2022 09:45:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e1-20020a17090301c100b0017828ae6310sm14732563plh.2.2022.09.17.09.45.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:45:30 -0700 (PDT)
Message-ID: <6325f9aa.170a0220.b60e3.b2ce@mx.google.com>
Date: Sat, 17 Sep 2022 09:45:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-229-gb433f12afe250
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 6 runs,
 4 regressions (v4.4-st20-229-gb433f12afe250)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Sep 2022 16:45:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9502

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 6 runs, 4 regressions=
 (v4.4-st20-229-gb433f12afe250)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-229-gb433f12afe250/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-229-gb433f12afe250
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b433f12afe2506afd30066f5b2b826129a20bc03 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ede19fb6707e34355655

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6325ede1=
9fb6707e34355656
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eb8fb7a9b265ab35565c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6325eb8f=
b7a9b265ab35565d
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eb886675c0a78335564f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6325eb88=
6675c0a783355650
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec87823e7de34f35568d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6325ec87=
823e7de34f35568e
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A490C4332F
	for <webhook@archiver.kernel.org>; Tue, 29 Nov 2022 10:53:27 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.146565.1669719197292752623
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Nov 2022 02:53:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=tF9+Y9bH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id j12so13013570plj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Nov 2022 02:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ndPJmYNbXlYZcLu+pyotbYjPY9XvkRO/gMigaDvijPo=;
        b=tF9+Y9bHbIiMcqtkTzyuoTF9a3/y8OXoXPGrnEQUl0NJjI4kTiTxg/vZuZVyRqsUif
         92LlY/XHk3UV+sJELg79PqSOs/Cty+zhDj3WC5u7HbQDCUyDR45jNkRtYpoJia9rWnjV
         Wecja6xn6Vlf4WepV0BS8lYo+J6Ys1hyBrmzKUT8PwWo12V0IKu0Uot3AQcgfJpNkWR9
         QZWHA+5CfQyxYGksKZI7qUR0wjBSMNjcRjfeRSf43831BrCPDzwStdZ9b/JXCEU0FLQF
         ij7MJ6MCDOlVfLsm4PmCsDR4+grEK8IOeMLKNc/HZczbXK5dzUprJdMsQtF+255X2n92
         PyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndPJmYNbXlYZcLu+pyotbYjPY9XvkRO/gMigaDvijPo=;
        b=Ryxgn7x1Zj1znVlyg3gXUgEK25P5c3hJCgQm/o7KPeZI0l92X6Ds7tfWXMfeH5aOjz
         kQ1fSSVJnkTw9DpIC6hPgxXefuwsGL+2DSewSbbUxk4FWwVE2qUl1gyLxFFji+oViC9J
         jwu6/VgamaUCYVtDz2TOBo89CIPdYnEZ2t8ck1X9r4BNbcoX8rku1zQOatyetwZu8ESu
         hkB208IrXiDYFN7tFkD+YUc78fF/x21J5QMMmiGk/+UMlupaOmB0K6dQuXkucHnE55xq
         5JMf6oqDzZUOsOJZn9zrER/PxrEm7KBv35UqsTr6MtzfKCaitRIAwakJfwpsQFS6H7AT
         BTgA==
X-Gm-Message-State: ANoB5pmi1UCmqnXvGMgPqwK5QYrVnoSlzEAyFLJr1QfRWaFK/msSIta6
	9+6Clis51LGOu15lhGeOnxD6XjItv+c6IxOD
X-Google-Smtp-Source: AA0mqf4XIOPthtS8ao1Av9A0Fzeo/bvK7SHIWcOTSYQAHUMmO5MSJfV0vynRmX5AV7Av2vsL8TTjmg==
X-Received: by 2002:a17:90b:48c8:b0:20b:25f6:3e30 with SMTP id li8-20020a17090b48c800b0020b25f63e30mr59921649pjb.227.1669719196006;
        Tue, 29 Nov 2022 02:53:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b001897d30143asm5684924plg.289.2022.11.29.02.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 02:53:15 -0800 (PST)
Message-ID: <6385e49b.170a0220.8a7ac.8cd5@mx.google.com>
Date: Tue, 29 Nov 2022 02:53:15 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline-nfs: 26 runs,
 1 regressions (v4.4.302-cip71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Nov 2022 10:53:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10130

cip/linux-4.4.y-cip baseline-nfs: 26 runs, 1 regressions (v4.4.302-cip71)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c727b8f0ca6857a9782a1ee857a57e4f563b34fe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6385ddfd16d31d56ec2abd04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-n=
fs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-n=
fs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221125.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6385ddfd16d31d56e=
c2abd05
        new failure (last pass: v4.4.302-cip70-236-g69445bc0d420) =

 =20


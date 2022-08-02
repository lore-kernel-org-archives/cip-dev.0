Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC62C3F6B0
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 21:00:49 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web09.887.1659474040465132325
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Aug 2022 14:00:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=xLWOUrJp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id o3so14555136ple.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Aug 2022 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Gmm8RTlWhEsoCKg6tw2UQfA7iKq8Vuly8V0GrY59Ahw=;
        b=xLWOUrJpDaaqvaf0OSGq5k8G0MHDZtuyEDiMmzbzGOwqi938O/YfOjio0vMGXZ6Gbf
         drheiimPRI9qUts97Y/a1a7LJzQVyU7X8Bp4ICGu1KFGOk/snaEoAw5uzPazb9T5R6sY
         XfTjmt+o93ps71rbVs/zsq5C6Og++365CoqPTf+uYkkrU41nPIFq1mCe+uVN4eiLrK/M
         zQHd1ZsE4ENyxeHC8mF7PP4uUwcoeCtasINhOAREU7BQhp10tN6CVvfchCUp9aUyF4v9
         UiebdSWTF/I+3gnU+jMI37qOE7LhjVD+dLLgvmbMZGcuceuH3nkL32UnHGZgDPhsyJHt
         TreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Gmm8RTlWhEsoCKg6tw2UQfA7iKq8Vuly8V0GrY59Ahw=;
        b=APMiBPZn5GqvVuo5VttGS7//RYFig83nyzxTCiR0DaZFuHwpz0QMYqLb/30CREvGsO
         3i9O/0nISabv5k3oVmdba+7iqkved2IyGk1n+/DO7MVMoAFPt1scLXILQzV2ndv7ilwO
         9+l/gbs6NAnhyKRm/xt6SX176+L9jdBl9oCsob8EaeOjalY1sgQ4j1aH4y3D8gIYXfQW
         SymubX39LpLYKlPbTIRfhj8rlukTnivYd8/MiMsJbTrlHeZEwWIammR/qKdGfjU5gw2K
         bpYmLNrNr7n/Hij1Cq55LAlKlnCn4vwzzmKDhjUMjW1EOC60Hq+JfGAxPCgp0TI58vLK
         1lJA==
X-Gm-Message-State: ACgBeo312Tgcs3+yp3quIF1Y7CFLemfs7kZpvcYGahOjUvkKCly8BmYp
	sTBVEhedwf7oiCpwL5Fbbt0Si+SKpKop/zIES04=
X-Google-Smtp-Source: 
 AA6agR7xqNFgK0oBZhqsY6LwRyv5FnH8hGPPp2A4fpU2C8BAWl+PfUTkRjBNG0szVc1ap1ZwdPbPfA==
X-Received: by 2002:a17:90b:1c81:b0:1f1:aa6a:82d0 with SMTP id
 oo1-20020a17090b1c8100b001f1aa6a82d0mr1384921pjb.170.1659474039480;
        Tue, 02 Aug 2022 14:00:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t17-20020a170902b21100b0016cd74e5f87sm120890plr.240.2022.08.02.14.00.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:00:39 -0700 (PDT)
Message-ID: <62e99077.170a0220.211fc.0571@mx.google.com>
Date: Tue, 02 Aug 2022 14:00:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 1 regressions (v5.10.131-cip13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 21:00:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9032

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 1 regressions (v5.10.131=
-cip13)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e217bcd84090afd29c7a9ab120fb3c8ff8844478

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e983983c97b191dedaf057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62e983983c97b191ded=
af058
        failing since 7 days (last pass: v5.10.129-cip12-36-g21d9d56f4de5a,=
 first fail: v4.4-st5-586-geb97410e0086c) =

 =20


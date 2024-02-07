Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD7AC4828F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 04:58:29 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web11.13758.1707281903155942491
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 20:58:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tpcZXqTK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.43, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2196dd318feso190365fac.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 20:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707281902; x=1707886702; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kpn2GTxZtSRGepVqMQ8CfT6UyrUnp1FRfuQcHgVQAXI=;
        b=tpcZXqTKQgB2df57Po95msrpUTEXO99r8Y476KIGXuQaiFvByIxan+MrWygLk0eMWI
         jI5MaLDKa8Gng5aXI20wFT9LLFTH+YuHRegmeMK0SVkVDE336VreUE1OaaljZYsVAmb/
         DRjGWoH2U/OFHhI+4w6AsLJ5htkpPl1PZe7yaVBXQ15dmNO1ubjStwXlZWZ2O+1V/Bfb
         Kcjx1NWnf2fcdRNtp+uQ4K5eMHm/9COt9M2C2HWL8rTAtzDiXry83HLEV1aqhwzxjrJG
         mh2UtPMg80KTdLOwX7iy5ebkdMI4d/KfhY+wv3OWLthHvwePFRGnBDETXuJYZ6Hv8KB4
         fuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707281902; x=1707886702;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kpn2GTxZtSRGepVqMQ8CfT6UyrUnp1FRfuQcHgVQAXI=;
        b=TcAlqDsg+I5pLh5dtPlCLtu+etSGJYmqocb+MlTxhXBN1Wi0eVOWAxUsQa9fmQApyT
         OHtg5F6DEZCmnQh9yNUWdX3L9zq/5IhtdF0GGGGheOomnSubQIFntOcOB4oQjRjkycD1
         Q9S9+eteJ+qY+ZzgL7hF+TYStWK0j/1KwfLSAJWPb+N3FEQmz1YDC1bbobkkQ3jrDVh4
         TpnNptPCQvGdPJNS3/MyP5olTkAP4VBc0mwNT5a1dJiVyr20Jvx2qw0kJ/2ZcR5LLqfg
         I2HGOok6N9NZntyh2E3ruabWPTE0l0aPASV5iwDF7rILqsXG0srlaXT5eOCYP5aX+OVm
         RztA==
X-Gm-Message-State: AOJu0YwKrAOeJqWRWa3/F9u3UohRU8RA9mbXqCj+iIIBXkFunWLCgrOW
	+l2JaVWuhcMHBtfGVtZU5SqdO3JdXGFQ64RliggPR1A5m9++NeNUUWberJwVrRLk7ckES2sCovI
	S
X-Google-Smtp-Source: AGHT+IEUB4riYPerq6gD4uNFWVeYTdRmW7eyJ3a8srkpi62R10Fuv7S4JhU2kyevKQRxoS0CN+uawQ==
X-Received: by 2002:a05:6870:204e:b0:218:4414:6f35 with SMTP id l14-20020a056870204e00b0021844146f35mr4858151oad.15.1707281901792;
        Tue, 06 Feb 2024 20:58:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l136-20020a633e8e000000b005dc191a1599sm412147pga.1.2024.02.06.20.58.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:58:19 -0800 (PST)
Message-ID: <65c30deb.630a0220.78e73.1249@mx.google.com>
Date: Tue, 06 Feb 2024 20:58:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-g39ff255b75f5
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 4 regressions (v4.4.302-cip72-1250-g39ff255b75f5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 04:58:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14865

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 4 regressions (v4.4.302-=
cip72-1250-g39ff255b75f5)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1250-g39ff255b75f5/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1250-g39ff255b75f5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      39ff255b75f5caee714b345c0c47b1c44b88dbe0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa6f725221e59b8e1f0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c2fa6f725221e59b8=
e1f0c
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb30fc538e240c8e1e7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c2fb30fc538e240c8=
e1e7d
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb219194736ef28e1e9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c2fb219194736ef28=
e1ea0
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fbc0b392108a438e1e7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c2fbc0b392108a438=
e1e80
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F7C4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 17:49:28 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.4297.1707328158858370086
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 09:49:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=HvQ0IKiI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e05d41828aso639942b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 09:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707328157; x=1707932957; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1bWEa9H4Mkzw4rgNTc83G4v6vQuwo2hU9Hmn6oWiDh0=;
        b=HvQ0IKiI6+114f5q7f2q7eK1jx+JyVKRQGoplkJyAdvaBtjV6qDhzupSwgOY+eFtkj
         sso3kJceJMhc/nfCWE4yaOMpjdykEJ21VQiOEBY5mw/xvwmARhzrDgPwgdb+6MR7EVE3
         jV53CCMGeorxZKRcY8dZA9hWVNvLtJUU2ppudDQTizwI99lYK8Cdmk8vZszN1R6B6yi9
         F0ez/nf1qRqz3A7XV6bpZkjWwQd4gO9Fs3apyQsrElVMKfe/RLiNFjx003QKst6a/VWy
         WPAIdk1GEkuPXdy+xg/k0+8NQGG99W4S1vfCOPUOPAulHbjR3XrY27Oc+Qr645bVCWB0
         7fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328157; x=1707932957;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bWEa9H4Mkzw4rgNTc83G4v6vQuwo2hU9Hmn6oWiDh0=;
        b=ECJaGMqUOv7aJAvWjhho4Xsvnel50TdOAZdIUkmcINz6Y8+xaQneVH+j3tEcIBmnw+
         dYGRahyKOXyvjjax83VMjDWhrxqgSEIgxGunl4xIAbbPow2rBAiZJ4cBfdH0xdd3DxgL
         Y61MHmCYZGr4v9El4KSXxwklWyK+OXpCTwW9HAz8+9WpbyvLpy1p9mKBEngB/J/5mYk1
         w+zoZwjar0JIYqrARhGnD8uWB4NC9tsy+B7Pe2Nx42XoiSRiH6HczRI6qLM7y/s0aUjm
         6OJVpEXg3BiCKYel6iHofK5zzmlqhCmlqk6IwJkKfrAWG8JN+1gwudVoHbay+8GA9hPy
         F3zw==
X-Gm-Message-State: AOJu0Yy3vjczl8/bbwa2tJyxzUxnyGnZOWN7bj4nbTYezkJFsv4u+wbB
	gVMz/yRajeriuwGJm1GLF+6JzMtv/6CiyCqp47ytzBYIPMUBN+Mu97kTbmJrbF4teOY2OWZ4vDx
	jm3I=
X-Google-Smtp-Source: AGHT+IG/kQb1lZ08FjkrJ+TS4nChdbw5fjhS/vge09lL2wDQ1ZdKLTOY3eCH+9o9mLlMC2fXbo77NQ==
X-Received: by 2002:a05:6a00:1817:b0:6e0:4d4c:f8d0 with SMTP id y23-20020a056a00181700b006e04d4cf8d0mr3694356pfa.5.1707328157314;
        Wed, 07 Feb 2024 09:49:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b006e051704d4fsm1893624pfo.5.2024.02.07.09.49.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:49:16 -0800 (PST)
Message-ID: <65c3c29c.a70a0220.cbc3.5eba@mx.google.com>
Date: Wed, 07 Feb 2024 09:49:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g57b839f015944
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs,
 3 regressions (v4.4.302-cip72-1251-g57b839f015944)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 17:49:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14891

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 3 regressions (v4.4.302-cip7=
2-1251-g57b839f015944)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1251-g57b839f015944/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1251-g57b839f015944
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      57b839f0159440df3a9c4b22dccee20e801350a7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3acfe01474869e58e1e95

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c3acfe01474869e58e1e96
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ac36bbd0d2d0168e1e93

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c3ac36bbd0d2d0168e1e94
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3af93290f3875508e1e7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c3af93290f3875508e1e7f
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =20


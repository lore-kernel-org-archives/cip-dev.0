Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DB8C43217
	for <webhook@archiver.kernel.org>; Fri, 25 Nov 2022 13:12:18 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.46762.1669381934267378209
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Nov 2022 05:12:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AZyVQCsl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id f3so3947937pgc.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Nov 2022 05:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=omP9wKPyd9sVLUEwE57dSdZ8pjTSR0qFxfTFkiNweOI=;
        b=AZyVQCsl9dnSWfdtowfeD0eTuQ4Bav0R0goM33D6oAY4EJpro0KK82Ee+Lv9aAIdLk
         T1lXD+haMQknU1rAYk/1XSJtOWHOz+o4i1eMN20+OZLDtN7J0VC9rnIP5Ph5BzdBSNC9
         HLKR66WGAJ5UJkjgniux9OnMBOi5nw0s0GjOKqiBWqL/uOiCSpBvcIevzDKP9nCXQ/v+
         cZP+3aiascZ8Qtj9U1QZsV11z46CUu+663tIOp95pVh7Xt5p3nxGOKup8FQrzHEq1FGt
         /vL3GAVtvZmozK0l2OgiO1WAbtfBPXopAq2+/vdfckyHeJPCF2VVGaQE/hRh/jTrpYhJ
         lJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omP9wKPyd9sVLUEwE57dSdZ8pjTSR0qFxfTFkiNweOI=;
        b=frv6o4/U5T4ruhlCgnk9KPEFbzSxP3yvrwSC5usgxowuFJ0zc/ZD5WaEDIiwnuenhy
         nt6d0ocmc//8okYeE6ByiZxiV83sMrMwfyjx7bGQPSEba71g9NURcmC9V2v5Z9wg1Kgv
         fsoy4iPTQ5jjUT/H0+iuiUBCjPM7I6JK4CAoKuZr3KVzNmWKhxVq3y0COxt/pVSSLruF
         ySuzQizmjrWapzEO3w4r+STy1xPv64XaOTGnAycFYzv4XogkR+yQI2D+aws2Y5RcoxWF
         FoQsm1fZTjSKt623jzkjj+75Upi66lHllxrbXZUxDc2KXXIudq9ceK0AhNg/N5JPS1od
         sBlg==
X-Gm-Message-State: ANoB5pm5hDP7Y4piHn1XOqhmzNXMmSH57ltI7lksB4wxqx9baZC1A3l4
	fNgbPlPVM3dzHGs4rWXH+XRRbueLL0ab1u3beJM=
X-Google-Smtp-Source: AA0mqf7sGpZS2G2DY6kEtUQMg806E66TvmGzxndeJU2twhIGgEr3lwW8ZjhCl4hLcstHd6pXrhDdpQ==
X-Received: by 2002:a63:887:0:b0:460:633b:5702 with SMTP id 129-20020a630887000000b00460633b5702mr34979749pgi.9.1669381933295;
        Fri, 25 Nov 2022 05:12:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b001895b2c4cf6sm3311071plk.297.2022.11.25.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:12:12 -0800 (PST)
Message-ID: <6380bf2c.170a0220.766e0.445a@mx.google.com>
Date: Fri, 25 Nov 2022 05:12:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d420
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-ipc: 7 runs,
 1 regressions (v4.4.302-cip70-236-g69445bc0d420)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Nov 2022 13:12:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10110

cip/linux-4.4.y-cip ltp-ipc: 7 runs, 1 regressions (v4.4.302-cip70-236-g694=
45bc0d420)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-236-g69445bc0d420/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-236-g69445bc0d420
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6380b9322d42f7737d2abd65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d420/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d420/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6380b9322d42f7737d2abd=
66
        new failure (last pass: v4.4.302-cip70-98-g7f7838c92740) =

 =20


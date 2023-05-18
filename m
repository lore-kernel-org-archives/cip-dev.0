Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04399C77B7A
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 23:25:55 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.7117.1684452351394624872
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 16:25:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=FWXWFTR7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-64354231003so185404b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684452350; x=1687044350;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7zunmnkyOo3TY+/gldC7/wg4LEsxINDhPYJqLbPMi7w=;
        b=FWXWFTR7BzA6EjE+qrkoCYKM5Gg4hUnCVYbQ9rL0QV5RBRBTxKiNXKGL7wUQ6FV3N7
         79rbJDIvZUzKAXScC97BvXaCMThb4MYE2cLvPlBmoADZ9ZDp+DcmB8niA2SYI+75+W5J
         OOBHo03jrnO6riLkQPfbrTJrD3tXmH6RLPmzHrpXfUvSWLph1asj/fuRAWsAqTtTPg7d
         Sve+nzLJnsuVBTiPx5/UtBrKrf0/jqCzPky0C17kxJbkeebMSwBLFJ9P4MZj9Cdt5vJS
         IH+rplPYza94TY40QejckJ2kxd91DPICREeZrRESuw7eioaVFwVqJquobCKSKOpM8yDv
         0kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684452350; x=1687044350;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zunmnkyOo3TY+/gldC7/wg4LEsxINDhPYJqLbPMi7w=;
        b=Hfw67cbtPOhS71E4LQ7DKR0NYFnMujfqHjB3Op+iBnl5wTJrWCl0x7g1erRuGLLdCL
         RItsDi2TTMmiGtNAJDzgKbI0LgEnLroltesZfZPdn4Swogs3s5OAD5x0/4hmfe6KES3x
         KQbStN9bpjtijxOgIfhfcSmTvxwhfaqco0pVexyFw1+EE8x8dC7dXBcGBrNlCtG5QBUL
         ceL24SHDbS+N4qh+GS6iSDRIrSs0DYS2InJLpJNamkydGmlf/YZDoF/jon5D1U6DH5Pz
         D//uxxY1ddUk4MoU9Yx9FI+F1z5eJWsPxHEvAlwRw36hWotdSRACLZOE6LspO0bfjelL
         7GrQ==
X-Gm-Message-State: AC+VfDwOE3h8RWD0m/CHnJUVNgL682RDoHkg73NKXPcjhdygyeQ5nGis
	bEUEZkCjMY8i6OcNixEt4cwf6Z+MtH0beoRupUuAGg==
X-Google-Smtp-Source: ACHHUZ6nTukIcPNDLcsbZn8VGH23pQaGfcUtc6tb7SCVRzh7Gs9ghMLgJ/TM+wdXqiAC1W2Vf29KaA==
X-Received: by 2002:a05:6a00:1486:b0:5a8:9858:750a with SMTP id v6-20020a056a00148600b005a89858750amr668552pfu.13.1684452350397;
        Thu, 18 May 2023 16:25:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b0063d2dae6247sm1824684pfn.77.2023.05.18.16.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:25:49 -0700 (PDT)
Message-ID: <6466b3fd.a70a0220.74969.37ef@mx.google.com>
Date: Thu, 18 May 2023 16:25:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-rt13
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-mm: 9 runs,
 2 regressions (v5.10.179-cip32-rt13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 23:25:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11529

cip/linux-5.10.y-cip-rt ltp-mm: 9 runs, 2 regressions (v5.10.179-cip32-rt13)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.179-cip32-rt13/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.179-cip32-rt13
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1f0aef82759c2eef50bcbfaab1bad1aaa64a721c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a5e120d8d066972e85f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6466a5e120d8d066972e85f6
        failing since 57 days (last pass: v5.10.162-cip24-rt10, first fail:=
 v5.10.175-cip29-rt12) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a484371e433a912e8601

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6466a484371e433a912e8602
        new failure (last pass: v5.10.175-cip29-rt12) =

 =20


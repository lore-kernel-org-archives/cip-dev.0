Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1453CC00144
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 05:30:53 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web08.1562.1659591044283599486
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:30:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=wUzNx/Xi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id f11so16996905pgj.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Su8iVfzfpRR7tkz9noThr/z4fGP+vOI1yP8ZvAUbPNo=;
        b=wUzNx/Xi4WXVdYis0kHXcnONL4MA0tba1ObjFCQ8epRGl2Bo+hZhGWGdri1/cXHgZY
         9iY8uLOn8r8v3MezE0bEnYCQOaJ3ArbxAPyqCTkmgnBfL+k1A9ujvvWI4hrBe7i6FXD8
         7eUXOF6B4oF9y06wUFISVoqYnWMleS+hFvVoryeKkU2n21Vp/JMpqap//rNx9SMZ0pIE
         uVHtyM9IVyQ8btNi0xX8+/wKAOkKGjJXZ/MzOMXguNfgipz6m+ulmMbS2jk6Cj+sakhM
         fBpnVaKM9BfTXvQimWQqJxruYKcDGCkSkljp7VPawxZebrjG6WxI3j5gK54cIYSQJPZg
         DnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Su8iVfzfpRR7tkz9noThr/z4fGP+vOI1yP8ZvAUbPNo=;
        b=saCf44av/wFqck3t50oVbqPFs43QKqK7mlyABuXFZxceO6ttZNlTZRyr7ASfjX+K2I
         XbECtG8wlhUv/6mX3qNlHVUQkMGwkAPzm3zQ7U6cHSBwTYwjFvYUR1nW4tFL53//GBIe
         hx3XDL4gEKhdjXtUYVxDulQGjbSdxGYml8CPuUQ+b8dkUV/3V8daYt6FVcLGdqWue/Tx
         fJiuGGYnkxmcg6NeZRcq3TGaQr/fn5rp1sYac7LXq0+KFFPW12t6PWlnO671jHYJCFz2
         1DTRGsPRCUemRNBOOTwpmgdTgZodlWtovJDkJ+kLcUsT8L6hGi3IGWcnNL2l/QPykfQl
         bDsA==
X-Gm-Message-State: ACgBeo04c90XI592JHFSqSx542PVzVh0gPWpUtcxvDgr9U+7CxjCqQrm
	4vH2Z6fTQJxVrg64TFhrId6+Abq0QIWeA02DJ4Q=
X-Google-Smtp-Source: 
 AA6agR5sSMjUqeGGoAKjYNSm++IdGmO/JAtmARotep0LKA2wqGQ1/siWfeKENwfMmn4vfPI3WwV7IQ==
X-Received: by 2002:a63:d014:0:b0:41a:13b3:69d9 with SMTP id
 z20-20020a63d014000000b0041a13b369d9mr302297pgf.202.1659591043341;
        Wed, 03 Aug 2022 22:30:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 l190-20020a6225c7000000b0052d98fbf8f3sm7063945pfl.56.2022.08.03.22.30.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 22:30:43 -0700 (PDT)
Message-ID: <62eb5983.620a0220.f4c67.cc69@mx.google.com>
Date: Wed, 03 Aug 2022 22:30:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 3 runs,
 2 regressions (v5.10.131-cip13-37-ge3a52725ce96e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 05:30:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9112

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 3 runs, 2 regre=
ssions (v5.10.131-cip13-37-ge3a52725ce96e)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-37-ge3a52725ce96e/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-37-ge3a52725ce96e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62eb4866d99db74f2adaf06c

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62eb4866d99db74f2adaf072
        failing since 40 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62eb4e672cd38cf52fdaf05c

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62eb4e672cd38cf52fdaf062
        failing since 40 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20


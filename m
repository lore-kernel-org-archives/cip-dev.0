Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7376FC4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 17:22:40 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.28709.1702574552601607098
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 09:22:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VKJIAsPe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d075392ff6so7030785ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702574551; x=1703179351; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L709c75Ru7ls9avwgvZaPzDYJ0lOdBo5ofvVts/3OZU=;
        b=VKJIAsPegHlvhQeS/zSTAubAAkASoRLC3yw62mYjdV0+UJEwymvDuYTweJUlHSNw8h
         W8V0mzWuRDWw5IIhbe2rruOftP0dCLNFa2dTclMqwu59+qaLGHfN+O/wWXLLSXKbsN1K
         SlolrFW/sor2Oo5zxHLYoI751eXJxcflH5w9aXGuT2U2hvsxPCbJMV8QDNv10kmKkJf8
         pg+dOMdA4IciLgCvvueyCi8Dno/Pt3YIbHBFb/Os3ZVhybr/ufZ4gdfXlDSzSZCf1Mva
         5EzJ2ciiFErJSzpaTK2pmIV8U7c+UB1S6xNWSKjIjGzwpwMpuWaJpkW00ke990Nl4dnE
         Yyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574551; x=1703179351;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L709c75Ru7ls9avwgvZaPzDYJ0lOdBo5ofvVts/3OZU=;
        b=NizFqBPgC63oPAZggBB4QqdXBEXOapxSHw6awB+UN5QoULhrsQ4NRSYI+qwjH8iEnS
         zdCKK1uueYARtLUbvBjoLR7HIRILF0J9OOcGHhDh659mqv1ychIDHYOm9qRbf95i8oiP
         exxcZ4huneMN0Aq1TckwEVTzO/Z37RKpBKoyVx03CYrXYSSLKo0w3UVav5bQXA9rkfEr
         9yGnExtdWiIikot/8HVWHEyGYo5hZWd2JghrzaTIqgSkusbuM1deoqeMI5h9IqmNZwEC
         vFthdJoqYHipH7WsZEAztBGOUAb+VdKvxm9dl3JsEikcvRIBHJ5egNLXibb2v3kgnPAf
         i8ww==
X-Gm-Message-State: AOJu0YxnSGx22Uh0BNpQFnit9YfKZ+aC0YAf/8ffxI7EEz0cUIU9LLfL
	pzFigLYN1XYRZvT1F1M2dHrmrR+XMWGFQbbVGX0=
X-Google-Smtp-Source: AGHT+IE6VJ7f16mqkqdZ5z3NMrtKkAH2q429j8zLg6o4VdGBcuGPOmToPb7LaTa8XnHahthN2p+vzw==
X-Received: by 2002:a17:903:234e:b0:1d0:9201:5340 with SMTP id c14-20020a170903234e00b001d092015340mr12565732plh.33.1702574551598;
        Thu, 14 Dec 2023 09:22:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709029a4a00b001d34796c1e9sm4108304plv.119.2023.12.14.09.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:22:31 -0800 (PST)
Message-ID: <657b39d7.170a0220.28f39.ec15@mx.google.com>
Date: Thu, 14 Dec 2023 09:22:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-cip11-1-g2d3d776d703d7
Subject: cip/linux-6.1.y-cip ltp-timers: 12 runs,
 1 regressions (v6.1.66-cip11-1-g2d3d776d703d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 17:22:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14127

cip/linux-6.1.y-cip ltp-timers: 12 runs, 1 regressions (v6.1.66-cip11-1-g2d=
3d776d703d7)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.66-cip11-1-g2d3d776d703d7/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.66-cip11-1-g2d3d776d703d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2d3d776d703d7a5abcbbebb5ff00910d7e1102ac

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/657b34dc8920217d97e1347e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.66-ci=
p11-1-g2d3d776d703d7/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.66-ci=
p11-1-g2d3d776d703d7/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/657b34dc8920217d97e=
1347f
        new failure (last pass: v6.1.64-cip10) =

 =20


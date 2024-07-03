Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7B5C31D97
	for <webhook@archiver.kernel.org>; Wed,  3 Jul 2024 22:34:39 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web11.63589.1720046074914196117
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jul 2024 15:34:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=dWGK78OU;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.42, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25e0c0df558so36162fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 03 Jul 2024 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1720046074; x=1720650874; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=137uS6DunlEFhMyQ28UwNtVIq9bP6Ol4c7adejLJigw=;
        b=dWGK78OU+gqnbT9F7Rfu232LyiYh/A070wh0ylx4LT+VxWiPxx7qbp4+CnZHHmXSZr
         0g/80249qLp0/Q0suy2Yory/poxOkLIw4lxxPEEsEW3GKRmnlUOSZte/2E4XqmvXovhS
         tWhXi9Ug+5kmqWbbTwDkbeYuvScix4HSGreG7aiMfjvtfF9B/68Zr8psELKMQiV/2aVW
         oMdVWUbzjwL6jPbAY8mxRzcdh4DFOjRtHfOxmaYuw9xryyc0EqFDQaQq3EcFgGbaTz/y
         dYShaKhxvUvUTOqA3UOCpZc9WL2kypfKRvV+f8Ns8knBrjooRlgBsCVSjhBIHLYCVmNf
         mwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720046074; x=1720650874;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=137uS6DunlEFhMyQ28UwNtVIq9bP6Ol4c7adejLJigw=;
        b=UIv8RSsVn9Zb3KWreBrrmGzTR+DIdFuK+tc8Cg/SoCw68kJE7MFkq3xJb5fN7wwbTI
         G4QcaCZU4F1ztEmDmu0HfMi/zQwdwMdJoKdtUjD+xcAoKNgZN4sIBGaB85TXrZIeH9kI
         hGcdlRBWST4Bz/SO2dHrdHxtZi5tQzAb9fYvBL5TUr6JfY9ZxiKY4ooi0+VbBsrlh9JB
         sxYc5X4goKN1cmHaOD9UtM2SupElTBeQtX3+jIWDTu4X0aSR1QjTXizqLaYjDBD4Arwy
         Hzq+WYlqf5fOn9R6Voquo0mT9mq4vSkfcvbmo2zrMJC1J5rkADHvoLxz3PrQVAtx5/yV
         3nuA==
X-Gm-Message-State: AOJu0YyV5sLXvux/k6Qy/d/p7OOHFyK/nym64aKm111Npne3DXmOQcNT
	A0hY8ZXTAy7RY0oNifqPg4lgZnTdfDIOHJPxwviOULBmNNZ+OoNMpETHztTpB+2bprDLdFtw1aD
	oxXUmX0dt2WAuRJ7yqCvHVqY2pxbPm2BwYA4at1CpU841EkTwrvI=
X-Google-Smtp-Source: AGHT+IE5jvRgYFItksjDWf48pniQZj2svTdwH+az/l3fVlG0nr2vO5Q35Xf+bMsZnK8KdBSZ+k8vndVlPLDPDI52GvQ=
X-Received: by 2002:a05:6871:24cd:b0:25e:2923:a374 with SMTP id
 586e51a60fabf-25e2923d2c2mr239614fac.30.1720046073706; Wed, 03 Jul 2024
 15:34:33 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 4 Jul 2024 07:33:57 +0900
Message-ID: <CAODzB9qJ3SvoDnhbjOPn8vPv60c1b1WiGm_BzPB4THFgZTrWkg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jul 2024 22:34:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16369

Hi!

It's this week's CVE report.

This week reported 1 new CVEs and 0 updated CVEs.

* New CVEs

CVE-2016-20022: USB: validate wMaxPacketValue entries in endpoint descriptors

Announce: https://nvd.nist.gov/vuln/detail/CVE-2016-20022

Fixed by commit aed9d65ac ("USB: validate wMaxPacketValue entries in
endpoint descriptors") in 4.8-rc3.

Fixed status
cip/4.4: [391738b9a371412a3c394975f18696d908971b69]
cip/4.4-rt: [391738b9a371412a3c394975f18696d908971b69]
cip/4.4-st: [391738b9a371412a3c394975f18696d908971b69]
mainline: [aed9d65ac3278d4febd8665bd7db59ef53e825fe]

* Updated CVEs

No updates this week.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


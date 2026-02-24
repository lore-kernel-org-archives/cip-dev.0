Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA20F4BB74
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 18:39:35 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27501.1771958373097536566
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Feb 2026 10:39:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iRC0fzN7;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: stephenecker240@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65a431e305eso10835182a12.0
        for <cip-dev@lists.cip-project.org>; Tue, 24 Feb 2026 10:39:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771958371; cv=none;
        d=google.com; s=arc-20240605;
        b=QsZdNwot1qWb04zVJeJx/dcMGs8JQTdRunIGgGBWFWyEVz0zJSTK4xxu5WvVWd+bN0
         TO8MGbSZmZx2aoElin8IfTicd6pQPDQ9CGpqH4QUWntmXm/vawaL0oC70M9gfEE84cDu
         T6apqjeDrVNhaGRdjV7vwkH4ym3BEqBq6a+rQ+3A9W1GZnYnMxqVuOahhEU6h5+UWl/o
         vfpMG8MYwnigHAbmdueTJfNehaikKNE/71bR0I3mR6QWyjPClpZ2tyV5RHDcOxBMR/zw
         fCBWB69EYOXAbI1uHmFbvHVmvUAdRMRB6b/aq5RbNEH3kOvm5tISus/WLucVOFSkoqpE
         m86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UHPZnalppa56eqPP5qI7R2SOfg7qiVM8ljCbPDUsj6Q=;
        fh=RaKH4vXZgYv/1PYcQkfLRK5D2CnBMLe+KcXQA6BQxAs=;
        b=eLMiSgkY1iPhdQWlMUqqaT5DYe9CRyybxLaydQp4chtOBQ8ejn9RWQtFf8w36FbOUd
         UYvgNfYEF6QOSewWGagpNxvY0vnJ7tefHhIIRp2UjKxHoxAtBwTlwvNxIZHUNFntQ9Iw
         VTg9xPTzMR0yrHH1dg7ixdvLbvvzUWtWM7xb2EJFV96BwY5k1bdoX/p2Ckriu1l2RsSy
         ECaJAcQg6TiMpk80goxDbHCHErd0MJLYuQZyIaWX8zQY0GpyP6A6TmKENR6nstPhdJk4
         NKGDlfNVT6bPtwZMJ7lTW6DZtGTK+aFlysgd8eZ43OuAroT92Qk69lE4lhdkkRfooFck
         GSFw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771958371; x=1772563171; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UHPZnalppa56eqPP5qI7R2SOfg7qiVM8ljCbPDUsj6Q=;
        b=iRC0fzN711ZrfLbZ2z2QcZVcQAL000IU4ReMbpIP1ypaYOf9Wt5OBUOhIZ1pOePFbB
         Hw/0WDlRxPVZAjM20C2M+1aK2whKAwsoEbLoavKfQovyZ2Tg2MkIKgojMjxXEfS4wjk1
         bmEAaaKqnvpO95dZeXWySt9zBXEXKp+zhorcwPm6HTvWcTqSLiCj9lMZr2YXR7DlhZvW
         t2DTiIWYiUoGj/2zF1MKwoUzpgXPopaXUGvBziv74J1MUfbcVo6rjjRlYhN7KdzhvmYm
         /VWbGjor5aEK/A4DZ85uPbxYzTsR38rgP4boq3l4+22NZfazkd5cP0EhTjWaOC3FQc8z
         4Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958371; x=1772563171;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHPZnalppa56eqPP5qI7R2SOfg7qiVM8ljCbPDUsj6Q=;
        b=jRCSr0V09Bxn4iuav0H/VrofcEdfXlG2sF11tXpRCsM8YJSW1rb2tWDccbqVb1bI7P
         uU+JR9d7cZF5mAWoTSnOc98xrZbp70F0pFfvqAAabSfAvemQM7XETCE6TSneoV2yKXHD
         H/RtGo3lnFAWmfWgy9YJ7pdr3MVQ+BMkgDyK+Cnzw8ODC8HLmNZ2E/8/7fpjfAfjmDBm
         rCCH/j2Ld3dTZzQybZU41jYZ5PFrd1O0wvDMEGj8KRmzVRCdROdrke0zeRkAgCXpT39t
         iUnSsKxEITaFBY/NJYaqWmlu2MJVTo/HRP9DXE89QUAVI6pSrwukTC/AYntGoZ9Mjh0A
         8Zow==
X-Gm-Message-State: AOJu0YyxAb/k7ZyLbWE6yrgFvWZRYrIAQQ70C5gmlCjI2TwoDfC3gCmY
	uTVyxNdJB/cTP4zAkktQSXRpvLLSzN49ZauCwL+rGsOuM6T80y/o4PYKNLokEEvQR3rECnqreMe
	bmYxW+EMMOOPcs9miFUrfeujrbP9D8MoJo/VZ
X-Gm-Gg: ATEYQzweeu/RQmJNoO4lXaYSFPRnIvkuTp9I1Ux67DhvM/zeSDN78rRl7lh4qcIDrZo
	KaZ9OwlOt0S3pbxAB6slmS6D6lJBluAcbiOOn5Ot+eZ0OD9k5xQiWjKg1PEbmHiwSEI6FmKgVSB
	LLUaT28GhfENJgPSNfxcKcPIOweZfkuGy9ARPDE1ZDEQcT9J3RMuSowJ89qwqgpllFNelS9W1CY
	V1ht97lciwHFS5ljTh3a6rnGoVeufmbE1Z7Y/JPjFWudqrdpl8xoEarQTnLaeRMXzstwjm0GPpA
	itJ2eA==
X-Received: by 2002:a17:906:eec7:b0:b90:771b:ceb7 with SMTP id
 a640c23a62f3a-b9081a53c72mr854825566b.27.1771958371120; Tue, 24 Feb 2026
 10:39:31 -0800 (PST)
MIME-Version: 1.0
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Tue, 24 Feb 2026 12:39:18 -0600
X-Gm-Features: AaiRm51Xx3nPEVn9W_KDr_J3N64RFhqtIgD9C83M_VJUlsf_ihjlub47BOVkSJo
Message-ID: <CAK9C7GAcSFAbw+Z8hU904aZvaG+uKCCdmomxM-8QRc679z91sg@mail.gmail.com>
Subject: i915 in 6.12 kernel
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000447a6e064b96358e"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Feb 2026 18:39:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21926

--000000000000447a6e064b96358e
Content-Type: text/plain; charset="UTF-8"

Has anyone been able to apply the patches for the i915 module in 6.12 with
RT?  It was working ok in 6.11 when it RT was still an out-of-tree patch

--000000000000447a6e064b96358e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Has anyone been able to apply the patches for the i915 mo=
dule in 6.12 with RT?=C2=A0 It was working ok in 6.11 when it RT was still =
an out-of-tree patch</div>

--000000000000447a6e064b96358e--


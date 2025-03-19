Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18346C35FF1
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 06:06:58 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web11.1603.1742364412364313790
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Mar 2025 23:06:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Io2nfoXi;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e60aef2711fso4732695276.2
        for <cip-dev@lists.cip-project.org>; Tue, 18 Mar 2025 23:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1742364411; x=1742969211; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uoewhidVXUoubpOUR7oeuWWiXVk2AQachKrLuigluKk=;
        b=Io2nfoXijwO7wIYGvcM5oGSjzht9nbRpRsoVaXLsY2gJKJpw16Qj4kMdC0ei9RCqKj
         uGcGKEyrY6LGAxeBfZWQ7b+7vJPNpVgsD5wOYttUD/kF5ISAUUZcx5hWV6zYU7psCPVe
         IuWo3qTNGIBXxQ4lNtRlfZVo5kA2NLXCgr9wZX0UlfPphB9uMJwn2i+vciXzNrzqtiXd
         xFnJui5yYSKAPCNtTICBS6rIHO6ooQy95c13QqUxDPxGSHdT6kz27xZG6O6pFvN46eyp
         XtCbDtKLwQHwjCM1fFqn61hXmofKpDSBz9hX+qdgHW67ka+L3/eUgKJbAksCd6FWhZg6
         KHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742364411; x=1742969211;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uoewhidVXUoubpOUR7oeuWWiXVk2AQachKrLuigluKk=;
        b=B5NieCW58kO5pvMDNBOGt9Zo/814GlFx13Iht3MhapkVzmtDVYqeisj7c4iOZwxeqh
         Zf8v/xa6uXNy9PvIpW2xDgUq12UIn6S1vetkVhw++lbp1rO4WkXPcNCVyC5es2DibaEy
         HLos5SAaqu0sPNm2NnTnkazc11uHh3Dk3cZu7Kdr0CRt2kmkz8zOaxhFGSDtlw0bnfH+
         TVF6ydhK0gl4Rs49KH5qrJzzuVr5piVeSkU4MoYZr+8pK5xlPPropptjND/ff42Cyfpm
         cIGiahCkUIFHLxJaItzQpbYfFJr4mJXLydQx/f8Kivxx+J4B9UXPB7fYpU0ZtjWvzWSJ
         aOCw==
X-Gm-Message-State: AOJu0YwrhM24ShzVuEYVQpheHmy7zxCQNoKvQlFtLhM7efnhpRLm/AGe
	sPC9tMBSVgWAxA/RBpkXUcbZ1uo/WgQkUC4pXSHsMI1F4kOFAuk6ljyxtERv4EDmxH8qCo2qrmS
	XKdgBKC63kT8kRtHrkAwvm3/xwhgSSrXp/13cIs/14fKUjGOjGxc=
X-Gm-Gg: ASbGncstcdOKNCiaexVm2JO53/bGzEiHf/33iHuUzS00N9P3D10XZrt5OERc9nrGLd4
	izMTUWNsy3X900HiHze3BNbfbpASi+HMrH+6kzbpvL60GYCnw1AiV/gR8RekJIg44lOs/XyO+Ln
	RHnFEgZRXzzgZHG2vfYsxLuqzrIgy73iTdMyOuMA==
X-Google-Smtp-Source: AGHT+IG/pmKO8fMTfIsBd8/wJyY3zPR0wWxoUlR/dp5bxrvC/dDfUzhAnm2Snt28Ftuq3VyUp2iRrsJ0BmP2LVU1/aQ=
X-Received: by 2002:a05:6902:2291:b0:e5b:2472:f4dc with SMTP id
 3f1490d57ef6-e667b3fa7bcmr1685185276.29.1742364411328; Tue, 18 Mar 2025
 23:06:51 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Wed, 19 Mar 2025 15:06:15 +0900
X-Gm-Features: AQ5f1JpXKLd4ofSFZ_pIXI3zfdF4C8DVk7Z-0uG6pXXPv2tqwykeg-FUVSVCHvY
Message-ID: <CAODzB9o4y-X-UY=cJx1LmNVAPHOHyChmmCd7vM6VvUo8uNJN0A@mail.gmail.com>
Subject: Added version information in cip-kernel-sec yaml file
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 06:06:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18244

Hi !

I have added two new data fields, fixed-version and
introduced-version, to the CVE information YAML files
in cip-kernel-sec. These fields correspond to the existing fixed-by
and introduced-by fields, but instead
of commit hashes, they contain the first release version that includes
the corresponding commit.

For example:

introduced-by:
  cip/5.10: [49739675048d372946c1ef136c466d5675eba9f0]
  cip/5.10-rt: [49739675048d372946c1ef136c466d5675eba9f0]
  mainline: [ec90b52c07c0403a6db60d752484ec08d605ead0]
  stable/5.10: [49739675048d372946c1ef136c466d5675eba9f0]
  stable/5.4: [da8ef748fec2d55db0ae424ab40eee0c737564aa]
  ubuntu/focal: [2d32976467084d38eb373dbed27b3bbb080f843d]
introduced-version:
  cip/5.10: [v5.10.83-cip1]
  cip/5.10-rt: [v5.10.83-cip1-rt1]
  mainline: [v5.14-rc1]
  stable/5.10: [v5.10.50]
  stable/5.4: [v5.4.132]
fixed-by:
  cip/5.10: [b0e9c11c762e4286732d80e66c08c2cb3157b06b]
  cip/5.10-rt: [b0e9c11c762e4286732d80e66c08c2cb3157b06b]
  cip/6.1: [47d245be86492974db3aeb048609542167f56518]
  cip/6.1-rt: [47d245be86492974db3aeb048609542167f56518]
  mainline: [47b43e53c0a0edf5578d5d12f5fc71c019649279]
  stable/5.10: [b0e9c11c762e4286732d80e66c08c2cb3157b06b]
  stable/5.15: [cb488706cdec0d6d13f2895bcdf0c32b283a7cc7]
  stable/5.4: [13e56229fc81051a42731046e200493c4a7c28ff]
  stable/6.1: [47d245be86492974db3aeb048609542167f56518]
  stable/6.12: [f6fb1c59776b4263634c472a5be8204c906ffc2c]
  stable/6.6: [a15ea87d4337479c9446b5d71616f4668337afed]
  ubuntu/focal: [bc9ceb8bc905ee6de2fa2625a5858e8d0769fb48]
fixed-version:
  cip/5.10: [v5.10.234-cip57]
  cip/5.10-rt: [v5.10.234-cip57-rt25]
  cip/6.1: [v6.1.127-cip36]
  cip/6.1-rt: [v6.1.127-cip36-rt19]
  mainline: [v6.13-rc7]
  stable/5.10: [v5.10.234]
  stable/5.15: [v5.15.177]
  stable/5.4: [v5.4.290]
  stable/6.1: [v6.1.125]
  stable/6.12: [v6.12.10]
  stable/6.6: [v6.6.72]

For some CVEs, multiple commits are listed under introduced-by or
fixed-by. In such cases, multiple corresponding
versions are recorded in introduced-version and fixed-version,
maintaining the same order as the commit hashes.

Example:

fixed-by:
  cip/4.19: [1477b00ff582970df110fc9e15a5e2021acb9222,
54073c46cbbd2c0c03d6f7d481540cb95cf181a1]
  cip/4.19-rt: [1477b00ff582970df110fc9e15a5e2021acb9222,
54073c46cbbd2c0c03d6f7d481540cb95cf181a1]
  cip/4.19-st: [1477b00ff582970df110fc9e15a5e2021acb9222,
54073c46cbbd2c0c03d6f7d481540cb95cf181a1]
  cip/5.10: [42f8ba8355682f6c4125b75503cac0cef4ac91d3,
d87ef4e857b790f1616809eccda6b4d0c9c3da11]
>>>> snip <<<<
fixed-version:
  cip/4.19: [v4.19.276-cip93, v4.19.292-cip102]
  cip/4.19-rt: [v4.19.277-cip94-rt29, v4.19.295-cip103-rt33]
  cip/4.19-st: [v4.19-st1, v4.19-st1]
  cip/5.10: [v5.10.173-cip28, v5.10.191-cip38]


As of March 19 at 14:00 JST, fixed-version and introduced-version have
been added to all existing CVE information
files that contain  introduced-by and/or fixed-by, excluding CVEs
marked as REJECTED.

Hope it helps triage CVEs.

Thanks,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

